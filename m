Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2531865B2EA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 14:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbjABNwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 08:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjABNwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 08:52:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D30E27C
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 05:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672667506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yafyz4ioVVvoQAhwV2aIRVvfD9yfwhAh4dPTo7SXFJY=;
        b=SbGAmqTDs85+QPY3fBBL8d/iNFN4cm2IWZKLg9uuJg/weKA3lzN6OvBzxT9mZhlhlec8Cu
        wQnCr8s4zvY+cyu9VSA2SlIhPQf9/jOk26S4CQD22xJPFaKYejt8sa8P21BlYe9MjtmrN6
        xao+EqKb6r1TfWyT6OVMTAzsVNhFAMo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-271-5vB_hWsAOcm81gDbS3WFhg-1; Mon, 02 Jan 2023 08:51:45 -0500
X-MC-Unique: 5vB_hWsAOcm81gDbS3WFhg-1
Received: by mail-wm1-f70.google.com with SMTP id f20-20020a7bc8d4000000b003d1cda5bd6fso6356738wml.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 05:51:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yafyz4ioVVvoQAhwV2aIRVvfD9yfwhAh4dPTo7SXFJY=;
        b=Y0G6kTxp0DpQsWB+eV9qffr2euFtJ/PF3ThS/DQ65na7jg48rgWuEb56+tvCcoBgfw
         CxdLuVFXkSNadd1dndSR8rSXhzXoolLpsBLt/nzz0Tu04mFaMDrSl4VLcGTYw19+6jC0
         QNWsEGEGKSHpPgmgu6JqrllB7HwqC1fKupxgI1G40P/tnA91c1ysca+ZLxS2X/svuywy
         Ml/6oPsuWTsrgjZV2hCVATdtw0tun+EwNRKr6OYVihw3GCx4AhtBFon0cqc2YiR3ffre
         tFPOVIcpzWPmAasw65iuvtNBYwPtHAMkNcAHA5BrDwpufadxoez69uWnn6SeoFqaRKdB
         XkGA==
X-Gm-Message-State: AFqh2ko1zojzoET5Hj1TxSkHmnuvcgtZAdKfpvRJJU8J/tRP+X9c3Pqt
        V8fc+VTLbRqe2Sg8xApqhKBbi0KP6kjIAWklL5UDJOGftg2jVVIoGC+hLbVt5lGv0ZFy3qobdGI
        4/pw9Yz/tYVye8LSzn0iqwU90
X-Received: by 2002:a05:600c:3d0e:b0:3d2:3ca2:2d4f with SMTP id bh14-20020a05600c3d0e00b003d23ca22d4fmr31097440wmb.36.1672667503873;
        Mon, 02 Jan 2023 05:51:43 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvbJtUehka09TTHzpZ3/tNKAm+H+SNwIOl23IORGJcibzel5onetyN+N+qYZrSa/x/EZ634SA==
X-Received: by 2002:a05:600c:3d0e:b0:3d2:3ca2:2d4f with SMTP id bh14-20020a05600c3d0e00b003d23ca22d4fmr31097417wmb.36.1672667503668;
        Mon, 02 Jan 2023 05:51:43 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f18-20020a05600c4e9200b003d35c845cbbsm48786206wmq.21.2023.01.02.05.51.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 05:51:43 -0800 (PST)
Message-ID: <eead4707-e73f-f648-edc6-8415bbb25b8b@redhat.com>
Date:   Mon, 2 Jan 2023 14:51:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 2/4] drm: panel: Add Himax HX8394 panel controller
 driver
Content-Language: en-US
To:     =?UTF-8?Q?Ond=c5=99ej_Jirman?= <megi@xff.cz>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Kamil_Trzci=c5=84ski?= <ayufan@ayufan.eu>,
        Martijn Braam <martijn@brixit.nl>,
        Sam Ravnborg <sam@ravnborg.org>,
        Robert Mader <robert.mader@posteo.de>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        Peter Robinson <pbrobinson@gmail.com>,
        Onuralp Sezer <thunderbirdtr@fedoraproject.org>,
        dri-devel@lists.freedesktop.org,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Neal Gompa <ngompa13@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>
References: <20221230113155.3430142-1-javierm@redhat.com>
 <20221230113155.3430142-3-javierm@redhat.com>
 <20221230154043.7v3zmzqdrnouqzd2@core>
 <7120dfd4-305f-69ac-fee8-123196ed06a9@redhat.com>
 <20230102105915.gbfhletcm4dunrlf@core>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20230102105915.gbfhletcm4dunrlf@core>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ondřej,

On 1/2/23 11:59, Ondřej Jirman wrote:

[...]

>> Yes, because as you said were debug printks. Feel free to propose adding the
>> debug printks if you consider useful for normal usage and not just for devel
>> purposes.
> 
> I already did, and used them do debug and fix the issues. This submission just
> doesn't include the fixes.
>

I missed the fixes, I think that cherry-picked and squashed from your tree
before you added commit f19ce7bb7d72 ("arm64: dts: rk3399-pinephone-pro:
Use unused GPLL for VOPs DCLK") at least.
 
>>> hooks. Have you tested the driver thoroughly with various DRM apps,
>>> with DPM/suspend/resume, etc.?
>>>
>>
>> I did not. I wasn't expecting suspend and resume to work on the PPP given its
>> support is quite minimal currently.
> 
> System suspend/resume works and is used by distributions. Display blanking is
> also used by normal distros, even if you don't use system suspend/resume.
>

I know but my point was that the PPP mainline support isn't ready to be used
as a daily driver in practice. So I didn't consider susped/resume or display
blank as a requirement to upstream an initial support for the panel driver.

[...]

>>> Also, have you checked the clocks are actually configured correctly by the
>>> rk3399 cru driver? I have a lot of trouble with that, too. clk driver sometimes
>>> selects the fractional clock, but does not give it the necessary >20x difference
>>> between input/output clock rates. You'll only notice if you measure clock rates
>>> directly, by looking at actual refresh rate, by using some testing DRM app.
>>> Clock subsystem sometimes shuffles things around if you switch VOPs and use big
>>> VOP for mipi-dsi display, instead of the default small VOP.
>>>
>>
>> I have not. Just verified that the display was working on my PPP and could start
>> a mutter wayland session. We could fix the clock configuration as follow-up IMO.
> 
> The display output will be broken after you fix the assigned-clocks in DT to
> expected values (use GPLL parent, to make the HW generate the exact pixel clock
> defined in the display mode). So this needs to be dealt with now, not later.
> 
> 
> The driver issues are all known at this time and have fixes available, unlike
> a year ago:
> 

My goal was to have some initial support in mainline even if there could be some
issues. IMO it is better to use upstream as a baseline and attempt to support the
PPP incrementally.

But since you are aware of the issues and know what are the available fixes, I'll
let you continue with the effort and take care of the patches. Hopefully there may
be things that will be helpful, such as the binding schema patch and the collected
tags. I can also take care of pushing the DRM bits to the drm-misc-next tree once
you feel that those are ready to get merged.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

