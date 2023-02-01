Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9865686B5C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 17:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbjBAQPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 11:15:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbjBAQPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 11:15:37 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADB640FD;
        Wed,  1 Feb 2023 08:15:36 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id b5so11680679plz.5;
        Wed, 01 Feb 2023 08:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AhR4u+vxDGzq69f5+cc5asnvpVqZaiftxbUIgQ+O7y8=;
        b=mJ0tX01t685V6CibzNWcXwo0AQi3b3VVSjlkoqCiMcof4SAKo3KJxnY2U7IPVAwRz7
         xLCLI0jywgcmlCBoUuWcWgg3Qxl6H0GbFczg5RfB5g+GrrhXLakccmqr+HU7ZXGDAQUp
         u4Yc4ZqV/ULPrMJGGohn8maidjUvROAcln43aipv34gZtGNDem15nkpo/nStsvOkkf1y
         Xl3jiW5fX6Cseo9wqrnLim6bTutBhNCuFZXmTqyo+ecASCdg61oGtStUcr+m/PoChBpP
         ruvVfHjF3mpJ/HVsgbc2+C3irRJAdLCm2sQa0k1aaEwPnmEKnipGRRIQWcG1iNu3ERr6
         A9/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AhR4u+vxDGzq69f5+cc5asnvpVqZaiftxbUIgQ+O7y8=;
        b=jVsZh6xLDjkwqFxvqjPwZueYVukYrNpegEq9VerbM4LCkaeszYwkh42DVbcUEo5FdO
         zop1oFWQ5F0lCve/hEPE5ZT0/74pr5U9wiSfvRapUwlwxNN+yl1cVzGIUaUD1hdyFugN
         bOe6EO2FEwLE7H8hZwnGBb6j/G+laHrrNtUQmmoNnARmTluQu/Nmjn3vfnSIDuaFx19s
         apSdksFVJFRBA3HXHOxM3OwXWp5qVk8eoNXAGvfam+lXFxkM+STGjFLZzbCpNgq+KDbJ
         xlfAQ2Wgb8Hn6bpJS86iFIMX725H+Fzvqxe90GzeYqre55QOcxVslN3g8oOAWYrpY+7h
         0/4g==
X-Gm-Message-State: AO0yUKXBlVjCSsMs213RJik+WCCA0PoIMc/hEc/ewxotloGpOduQMRi5
        0fN8SY5D8TOue8PK8RE+gEI=
X-Google-Smtp-Source: AK7set/cXFOzG/U5yeAhHQQhMy5PiRNYtGMDesEiGCMSOznrqODzwLM9sAEhg0yMZ24Xux0oizSdiA==
X-Received: by 2002:a05:6a20:a689:b0:be:e0c3:5012 with SMTP id ba9-20020a056a20a68900b000bee0c35012mr6615060pzb.1.1675268130748;
        Wed, 01 Feb 2023 08:15:30 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:ce3a:44de:62b3:7a4b])
        by smtp.gmail.com with ESMTPSA id q21-20020a637515000000b004b1fef0bf16sm10752763pgc.73.2023.02.01.08.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 08:15:29 -0800 (PST)
Date:   Wed, 1 Feb 2023 08:15:26 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: rtc: moxart: use proper names for gpio
 properties
Message-ID: <Y9qQHj70SN/3fZCc@google.com>
References: <20230201054815.4112632-1-dmitry.torokhov@gmail.com>
 <20230201054815.4112632-2-dmitry.torokhov@gmail.com>
 <31e979dd-f4e9-081e-1bf2-e44dffc4e70f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31e979dd-f4e9-081e-1bf2-e44dffc4e70f@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 08:38:48AM +0100, Krzysztof Kozlowski wrote:
> On 01/02/2023 06:48, Dmitry Torokhov wrote:
> > MOXA ART RTC driver has been switched to gpiod API and is now using
> > properly named properties for its gpios (with gpiolib implementing a
> > quirk to recognize legacy names). Change binding document to use
> > proper names as well.
> > 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >  .../devicetree/bindings/rtc/moxa,moxart-rtc.txt      | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/rtc/moxa,moxart-rtc.txt b/Documentation/devicetree/bindings/rtc/moxa,moxart-rtc.txt
> > index c9d3ac1477fe..1374df7bf9d6 100644
> > --- a/Documentation/devicetree/bindings/rtc/moxa,moxart-rtc.txt
> > +++ b/Documentation/devicetree/bindings/rtc/moxa,moxart-rtc.txt
> > @@ -3,15 +3,15 @@ MOXA ART real-time clock
> >  Required properties:
> >  
> >  - compatible : Should be "moxa,moxart-rtc"
> > -- gpio-rtc-sclk : RTC sclk gpio, with zero flags
> > -- gpio-rtc-data : RTC data gpio, with zero flags
> > -- gpio-rtc-reset : RTC reset gpio, with zero flags
> > +- rtc-sclk-gpios : RTC sclk gpio, with zero flags
> > +- rtc-data-gpios : RTC data gpio, with zero flags
> > +- rtc-reset-gpios : RTC reset gpio, with zero flags
> 
> Your driver breaks the ABI, doesn't it? If not, how are the old
> properties parsed?

It does not. As I mentioned in the driver code patch, commit
eaf1a29665cd ("gpiolib: of: add a quirk for legacy names in MOXA ART
RTC") makes sure gpiolib falls back to trying old variants if it can't
locate properly formatted names.

Thanks.

-- 
Dmitry
