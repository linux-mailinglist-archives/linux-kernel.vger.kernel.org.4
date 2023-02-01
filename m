Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC7A686E94
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 20:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjBATCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 14:02:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBATCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 14:02:44 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA51761AD;
        Wed,  1 Feb 2023 11:02:43 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id e10-20020a17090a630a00b0022bedd66e6dso3222358pjj.1;
        Wed, 01 Feb 2023 11:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i8tCEq9NZttwhpKwtdIc/HgNl+0QVb0jDo+OaOqmvig=;
        b=TdRV+oufea/VpsTU5XWyNQGzjAX6lamnJPFAv+UT0tWvSKaT9COwxbyOcMa/++N5t6
         h1YyNH+F+DQh/HRTuH0QUKauMq3dRBqo+3C9lPy2NHjUjQszr7s2eE45zfoXbGfh378a
         a+stJdjZgdnld/REwq4WwXdUUyzJVH/Ic1ajs2bqCq7FJf6PgYeGXz6QHorL6xqYQ1UD
         rSxjrfy700M8SVOCxQDJwmguXl7AvIFhCmBeP1E6GLsD0zXrrduy8UwrTJtOz848f7/n
         DQKtLbPv5BA1OSaZ2Wj5c1uzoPuIxTJFekz46AVlN0VKzTNx5emtJVp0N7zTv6gyDUZP
         dOZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i8tCEq9NZttwhpKwtdIc/HgNl+0QVb0jDo+OaOqmvig=;
        b=jZ7v1HbI+281eriFs6pFyEi52a9GEWlLj7V1Kj1C+o4Oo0FliaoKlze6LklWmMM9+5
         rcXqsH6O/BZiMujLpT/yQS8SNL58g8sx4+wH5HGkfnTkM8SqVh96sKNJ42dgGNNgiO2I
         VdnoFZTxHZdOJNrMqt4orTPTjbMsLq0Ooadrqr4fGQYwO7ChrP4Xj+ZEethUodFYn4GX
         qTjqkl/9zB9ItIZo9mVMe0kEk9qK4Ga/7JdqkipJY/X7qiJ8ZtG9tTJYKhYLWwgTe+dY
         U+R9ggitLm1P6tz8tDxnP9d2v2YH/dM4YB+4Ttyx5O+0QU9klz5UHXdYXUU25InQ8IvD
         101w==
X-Gm-Message-State: AO0yUKUF4xBJlp+frCD4J7Qkgh6onzZspSdQoJ5+aa3G6UWcQeMkHqln
        4A4wINQlmnj0XGEqYbQ7XIY=
X-Google-Smtp-Source: AK7set9KH81jmmLtMVCouivLHuamz+iPPQBfIZm3d6pMId/DQxUZ68PfweuCRhkSdtOwGWVEeXrCqw==
X-Received: by 2002:a17:902:ecc9:b0:196:2d33:e09e with SMTP id a9-20020a170902ecc900b001962d33e09emr3461481plh.27.1675278163165;
        Wed, 01 Feb 2023 11:02:43 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:ce3a:44de:62b3:7a4b])
        by smtp.gmail.com with ESMTPSA id l16-20020a170903245000b0019896d29197sm4088925pls.46.2023.02.01.11.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 11:02:42 -0800 (PST)
Date:   Wed, 1 Feb 2023 11:02:39 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: rtc: moxart: use proper names for gpio
 properties
Message-ID: <Y9q3T17r5G2PD9Gk@google.com>
References: <20230201054815.4112632-1-dmitry.torokhov@gmail.com>
 <20230201054815.4112632-2-dmitry.torokhov@gmail.com>
 <31e979dd-f4e9-081e-1bf2-e44dffc4e70f@linaro.org>
 <Y9qQHj70SN/3fZCc@google.com>
 <20230201175504.GA4075318-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201175504.GA4075318-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 11:55:04AM -0600, Rob Herring wrote:
> On Wed, Feb 01, 2023 at 08:15:26AM -0800, Dmitry Torokhov wrote:
> > On Wed, Feb 01, 2023 at 08:38:48AM +0100, Krzysztof Kozlowski wrote:
> > > On 01/02/2023 06:48, Dmitry Torokhov wrote:
> > > > MOXA ART RTC driver has been switched to gpiod API and is now using
> > > > properly named properties for its gpios (with gpiolib implementing a
> > > > quirk to recognize legacy names). Change binding document to use
> > > > proper names as well.
> > > > 
> > > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > > ---
> > > >  .../devicetree/bindings/rtc/moxa,moxart-rtc.txt      | 12 ++++++------
> > > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/rtc/moxa,moxart-rtc.txt b/Documentation/devicetree/bindings/rtc/moxa,moxart-rtc.txt
> > > > index c9d3ac1477fe..1374df7bf9d6 100644
> > > > --- a/Documentation/devicetree/bindings/rtc/moxa,moxart-rtc.txt
> > > > +++ b/Documentation/devicetree/bindings/rtc/moxa,moxart-rtc.txt
> > > > @@ -3,15 +3,15 @@ MOXA ART real-time clock
> > > >  Required properties:
> > > >  
> > > >  - compatible : Should be "moxa,moxart-rtc"
> > > > -- gpio-rtc-sclk : RTC sclk gpio, with zero flags
> > > > -- gpio-rtc-data : RTC data gpio, with zero flags
> > > > -- gpio-rtc-reset : RTC reset gpio, with zero flags
> > > > +- rtc-sclk-gpios : RTC sclk gpio, with zero flags
> > > > +- rtc-data-gpios : RTC data gpio, with zero flags
> > > > +- rtc-reset-gpios : RTC reset gpio, with zero flags
> > > 
> > > Your driver breaks the ABI, doesn't it? If not, how are the old
> > > properties parsed?
> > 
> > It does not. As I mentioned in the driver code patch, commit
> > eaf1a29665cd ("gpiolib: of: add a quirk for legacy names in MOXA ART
> > RTC") makes sure gpiolib falls back to trying old variants if it can't
> > locate properly formatted names.
> 
> A dtb with the new names and a kernel without the gpiod conversion would 
> be broken. Up to the platform whether they care really.

Seriously? And I guess devices with DTS do not work with kernels v2.0 so
we should never have introduced it...

I understand wanting backward compatibility, but asking for both
backward and forward is a bit too much IMO.

Thanks.

-- 
Dmitry
