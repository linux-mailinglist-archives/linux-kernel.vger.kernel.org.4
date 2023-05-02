Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A273C6F49EA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 20:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjEBSt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 14:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjEBSty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 14:49:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438CA10C6
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 11:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683053348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DZ0W+FU8PsLfAAZv9zbz/cngBwAlCp+YIRm01kljAiE=;
        b=WEQWVkoCRuowfnvASph77+4Thuq+xphdcVA6CEuicnmj5DXqDhKhYMsMR/SbLgN9C3Zv9Z
        ADYuPfWKjJ5w+Kd/daYE5+s+RRQMXhknqlqEV7IVroLu5tU9guAdLWX/EE8mBWleZ6CZGJ
        z2JW7aE+a9iIIEcyVfy7E2QT/mVd0UE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-vJC9gA-qMBqzA7GO8Y4j5g-1; Tue, 02 May 2023 14:49:07 -0400
X-MC-Unique: vJC9gA-qMBqzA7GO8Y4j5g-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-61b591eb0cfso13534936d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 11:49:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683053346; x=1685645346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZ0W+FU8PsLfAAZv9zbz/cngBwAlCp+YIRm01kljAiE=;
        b=CpmlYPWWcKyQumzbnpFqO3ojiF/8C/w0gSI5qq0zV4dV12X6iONlTwWRcQ37TPfbzM
         byyq/4Qf37rn5KEVnuY5I52fp5016GxVZbTvcyM5C6IfK6PmIeSyu5w+PjKcJPeR8yUX
         KJEldKoMoTW9O8rCsW8mT+yP1RRi3y6lsY+akJjhCwZaXQNNHlGYknZqYK0p5YJSHSnk
         OH/wgk/MhS1lcs2Ym8v2Iz4eU0izKuWpzIgkKmihb9bprhHcB6wHlIjLmafPLCmqjdLg
         jPJo1Bm7Ejp9/3ZGxl5idmjviIkwj+JZ4KgNOaqTJkmH4so/D0+/fMAFlfxiuHU25N61
         gaiQ==
X-Gm-Message-State: AC+VfDxlzmSnRQLI7pxtS7pRxWEauB3ZAWmsHQB4GLrucZ29ooRd5Dgp
        8l3CTFs5KN0AoFrABFCQMJtqDjpE8SlWyuqNA6xJ1lL8lAfDcIUmm2GyyhHNYwtII7unec318qP
        D0de8yeDsJiJhbHZoGfmX/Kmr
X-Received: by 2002:ad4:596b:0:b0:616:5c8b:59d with SMTP id eq11-20020ad4596b000000b006165c8b059dmr6197888qvb.20.1683053346398;
        Tue, 02 May 2023 11:49:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Wy2JnTAhWuNet9cEToNtvnh6Rgxw5wsbBieiyINBFnufP8DZTowekkRqdmisuq2+jBHV9JA==
X-Received: by 2002:ad4:596b:0:b0:616:5c8b:59d with SMTP id eq11-20020ad4596b000000b006165c8b059dmr6197852qvb.20.1683053346170;
        Tue, 02 May 2023 11:49:06 -0700 (PDT)
Received: from fedora (modemcable181.5-202-24.mc.videotron.ca. [24.202.5.181])
        by smtp.gmail.com with ESMTPSA id y10-20020ad445aa000000b006057140e017sm9063235qvu.89.2023.05.02.11.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 11:49:05 -0700 (PDT)
Date:   Tue, 2 May 2023 14:49:03 -0400
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
Message-ID: <ZFFbH7bH0pCDdoN1@fedora>
References: <20230421133922.8520-1-quic_shazhuss@quicinc.com>
 <ZEcEGJiikEC2wIVE@fedora>
 <CAA8EJpr27=2jAXbamN6J7yF+7G=L5Af8+XReB5UnFuihcEwMQA@mail.gmail.com>
 <ZEgV+H3yZLp48Dlc@fedora>
 <3dc6e993-bcca-4e0d-5aca-686fcc8b5b73@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3dc6e993-bcca-4e0d-5aca-686fcc8b5b73@linaro.org>
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

On Sat, Apr 29, 2023 at 12:41:39AM +0300, Dmitry Baryshkov wrote:
> On 25/04/2023 21:03, Adrien Thierry wrote:
> > Hi Dmitry,
> > 
> > > Semi-random suggestion, but could you please try using
> > > clk_regmap_phy_mux/clk_regmap_phy_mux_ops for USB pipe clk src?
> > 
> > Which specific clock are you refering to? I'm not very familiar with
> > those, in the device tree I'm seeing "pipe" clocks for usb_0 and usb_1
> > phys, but not for usb_2, which is the one that's causing issues.
> > 
> 
> Ah, I see. Could you please try adding the 'qcom,select-utmi-as-pipe-clk'
> property to the usb_2 host node and running the test again?
>

Thanks for the suggestion. I tested this but unfortunately the issue is
still happening.

Best,

Adrien

