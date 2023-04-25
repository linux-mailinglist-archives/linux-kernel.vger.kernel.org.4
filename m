Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E243D6EE74F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 20:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235020AbjDYSE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 14:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234902AbjDYSEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 14:04:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F38A17A19
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 11:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682445833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mLRDaEM8IkNU4aroONTY8q5AePgj7Z5Af/7/yOM3ivs=;
        b=cH9PwdYc83+ua+L5mN7s8BqwXgUb6huzV9PGfgbWv0XOSrTCdKUGZhvHHoEX7gdElGM5Nz
        9c5WrpLLhA5tQc2ul2v6N8tXzU+JjUpDzgJiKyR7EzFc7J+74ELQUnXrLMRuObdHmPD0RP
        BtHGDopabjb2Uw2O+jYwFu/R3PUcqOg=
Received: from mail-qt1-f200.google.com (209.85.160.200 [209.85.160.200]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-62-JKlprlMoMv-Y3ZwwlrywJw-1; Tue,
 25 Apr 2023 14:03:40 -0400
X-MC-Unique: JKlprlMoMv-Y3ZwwlrywJw-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-3ef5bad5aedso64682031cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 11:03:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682445820; x=1685037820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mLRDaEM8IkNU4aroONTY8q5AePgj7Z5Af/7/yOM3ivs=;
        b=MNNmzdFkzUyrpWmf1SFs2mbnj5s02XWI0AK/5liPZIuc4Ehb6JBFlHzFBAOnV7R6Wp
         Ucsr9/Y5QQX0rkvPKAHZZfFZ2tRjafLZ9lusnRRuVGugLajZpGoHyXZohEY/nTZ/HoZ1
         D1Omr8mKe/jAI6w/nKlM4i4l0spskNIRX5xZcUt4G3cBavCbNIWvRu6TxKzhHCKRrMN9
         UMkUZZKQOk4JLoiAyajME494ZySTbYkFQQYFeQhGFg9ocD+mZuxvrOHjHLjvR6qkZefb
         +si5Z8HsMAPRlYoV+nZTPNn08mRTYdxeVyxpJRp4VXNICfts+rcN7Z3FNXjDbMZ29oXh
         k8hg==
X-Gm-Message-State: AAQBX9dv6X69xF3PV2Aqb2R1TEYa23CwQKvT25YpZR3VCj2Lkbe5ysus
        CMmeZLM3J7GrQiDtXiCV98JCNhTScx62g9YlqYIbAwk9tygS4juvlPpkhbJR4LGF5PZTpTNWr+7
        YTtYRCxSRRwgGJ6LSKW/PDWCV
X-Received: by 2002:ac8:5c01:0:b0:3e1:59e8:745a with SMTP id i1-20020ac85c01000000b003e159e8745amr28268786qti.3.1682445820205;
        Tue, 25 Apr 2023 11:03:40 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZR+URkOBjqHmQb78faZMLxITsne2FMxrzysNlFS71f08K8wvOrg5C2bC9hBB1dS3N1M/UwJg==
X-Received: by 2002:ac8:5c01:0:b0:3e1:59e8:745a with SMTP id i1-20020ac85c01000000b003e159e8745amr28268745qti.3.1682445819878;
        Tue, 25 Apr 2023 11:03:39 -0700 (PDT)
Received: from fedora (modemcable181.5-202-24.mc.videotron.ca. [24.202.5.181])
        by smtp.gmail.com with ESMTPSA id ge8-20020a05622a5c8800b003e3914c6839sm1868947qtb.43.2023.04.25.11.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 11:03:39 -0700 (PDT)
Date:   Tue, 25 Apr 2023 14:03:36 -0400
From:   Adrien Thierry <athierry@redhat.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Shazad Hussain <quic_shazhuss@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v1 0/6] arm64: qcom: sa8775p: add support for USB
Message-ID: <ZEgV+H3yZLp48Dlc@fedora>
References: <20230421133922.8520-1-quic_shazhuss@quicinc.com>
 <ZEcEGJiikEC2wIVE@fedora>
 <CAA8EJpr27=2jAXbamN6J7yF+7G=L5Af8+XReB5UnFuihcEwMQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpr27=2jAXbamN6J7yF+7G=L5Af8+XReB5UnFuihcEwMQA@mail.gmail.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

> Semi-random suggestion, but could you please try using
> clk_regmap_phy_mux/clk_regmap_phy_mux_ops for USB pipe clk src?

Which specific clock are you refering to? I'm not very familiar with
those, in the device tree I'm seeing "pipe" clocks for usb_0 and usb_1
phys, but not for usb_2, which is the one that's causing issues.

Best,

Adrien

