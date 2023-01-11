Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA60665963
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 11:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbjAKKvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 05:51:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238964AbjAKKvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 05:51:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2AA1789D
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 02:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673434198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KicQRhRW4GIgvI9D3cmZlt5g4pih7zwKs4FM1PmEwRI=;
        b=c6qrOyDNn2Ja0CyhYadJF0kBGCDkJxMi1bMu34GwukcUcJrg5rilZLZZrpLVJhiuC0dbn9
        CpWyqZz3VyZpW5ECA8mSu8KtLxuWGYveuAfobmSPHZgfPPBb0phaqq1QyD6det+fndUzGu
        fGxcKKv56UntWm4siR5PMrSyjezx178=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-67-408C0QmUNbOwmDHQXPGZvA-1; Wed, 11 Jan 2023 05:49:57 -0500
X-MC-Unique: 408C0QmUNbOwmDHQXPGZvA-1
Received: by mail-il1-f199.google.com with SMTP id l13-20020a056e021c0d00b003034e24b866so10780351ilh.22
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 02:49:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KicQRhRW4GIgvI9D3cmZlt5g4pih7zwKs4FM1PmEwRI=;
        b=mZ/jG4jfAZ/xmJt3PGcKGY8ivBUgc6LiYOnjr0YcTLsMWG3kWffrUIYAaJLuwMqIk0
         Md2lAl+qjQHGcKKXGuTeooU+0t6to5uM3YuwNv8cHu2vBMOeKqRxA9dktzoj3WCEqxM3
         +owS/n0q8SzQ9Y+U2Twpff18zMcMpknuJAFTL2TorlJW385HvJVvIQu1uf8igCBhKi2+
         leOGqSFDK2ZNjvooPf5yZ+vaqZ78/Y1nY15wtx+56YlhZ68pvzED7WYretpNxW5nwAEv
         SmNk8e6nQUb34eo0XBIqVnctTWYMTeqdxROXM/Lm9kZeVaUWPjIgGsfmjnYcCqLHVLwE
         zDgw==
X-Gm-Message-State: AFqh2kqWMlR5ayyZX1RiLMtx1BgRCcVZAaqz5i5mf8xrVMn+QhLEeQeY
        GS1Mg2NqtJ7dkLWLt95oVSMB2CGLLZZKQUY040Dvp+pwmtRU0LMNq+8dtIwloA1zcf9ssscv3Qs
        /WYzkP6JZGje+g8N7OHAu1vGq
X-Received: by 2002:a5d:9cc4:0:b0:6e5:d1b2:d925 with SMTP id w4-20020a5d9cc4000000b006e5d1b2d925mr49142215iow.6.1673434196857;
        Wed, 11 Jan 2023 02:49:56 -0800 (PST)
X-Google-Smtp-Source: AMrXdXs3Y45SXB/Nt9M0C16VUqO/0EV+05Hlv3juN5iJV2s2eapIOTQnzGAYArJYogQH6E8bee7eFw==
X-Received: by 2002:a5d:9cc4:0:b0:6e5:d1b2:d925 with SMTP id w4-20020a5d9cc4000000b006e5d1b2d925mr49142208iow.6.1673434196657;
        Wed, 11 Jan 2023 02:49:56 -0800 (PST)
Received: from x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id v19-20020a02b093000000b0039e8c12414asm2287897jah.164.2023.01.11.02.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 02:49:55 -0800 (PST)
Date:   Wed, 11 Jan 2023 05:49:53 -0500
From:   Brian Masney <bmasney@redhat.com>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Eric Chanudet <echanude@redhat.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sa8450p-pmics: add missing
 interrupt include
Message-ID: <Y76UUZ7ZbM6csqmV@x1>
References: <20230111082331.20641-1-johan+linaro@kernel.org>
 <20230111082331.20641-2-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111082331.20641-2-johan+linaro@kernel.org>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 09:23:30AM +0100, Johan Hovold wrote:
> Add the missing interrupt-controller include which is needed by the RTC
> node.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Brian Masney <bmasney@redhat.com>

