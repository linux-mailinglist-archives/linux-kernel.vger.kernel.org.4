Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561CA68A610
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 23:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbjBCWWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 17:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjBCWWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 17:22:38 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A82E2D6D;
        Fri,  3 Feb 2023 14:22:37 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id j1so537065pjd.0;
        Fri, 03 Feb 2023 14:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QBbJD/4vFduSZffKUZSYe3pTJViIry24OYhRieFlxp0=;
        b=Zoc3Y/XK8r/GgfenTCFOjuEO65km7MXVTeIaYy7yLPfsCWZEXwvySB/VG/kBMFlUlZ
         K2hOYczq2ywOBA32GTsXJLaLeyjlVnALjD0ykYrjkyXt6sh4gjxUJMl1Bb3qypAsApoF
         yAoyqtdbn3LbnOzT0YzQy2erAjHWXmTgxHOmL9jLRm4XolA9OUykdLGqDJfa4L/VTIir
         WtuuNeMSmqqRvprUCCTXeoxpqN5phLd/hZsa8oMP34xC6PtHkT8SIf4VicT/N9ZEJluG
         TfmSb2IAuHgmlThfcx9djGEyuBLZp6eQ3RBQE8IJCPboeUtaVLmCAP7aPRfkPTUacosQ
         mbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBbJD/4vFduSZffKUZSYe3pTJViIry24OYhRieFlxp0=;
        b=4aY3vuzhpx+UF0NlB/pN4d4y76VdrTQcuhyqWuUkyauby7khFzDVZK4XrshmvuZdVp
         +NuodXbON/yeBCvVgBXwx1CCYbb9oV5B3ThjADvtjsstU+s4uzWVpp0mAE4uYp4IdmwN
         XAUbyVvKEvk0mZQKvKO2embf0Imx+rhbgw3PFgKYA+WwLu+/jq+pXwwEpQaTmKebiQSo
         fIDmn5JXXwvLNBqrQqhZaArsy+VrCRKhjZjFWH8uEFcCWBdpZToAZ2+AzPaUKsQ3hjzM
         eul8L7pf+/SKvb7+E5DX8R+7Mo9tHfzPsOSnqKwBt+fgGLItJg5NUJUEl255XszF9yAp
         oNlw==
X-Gm-Message-State: AO0yUKUOITP4dZixrHzfmXiFtIyIChdrPokDjPifA/lIRI9jbztRbv7H
        0INc/fHoycWs5uDu6aevydE=
X-Google-Smtp-Source: AK7set9hpK37OYHtDPMVQiPbQlIE/jv6D/rNDkWvFxZP81KZ4b75o3xKmcGCfI7ovs9R4GVj695MgQ==
X-Received: by 2002:a05:6a20:3ca2:b0:bd:14f4:7add with SMTP id b34-20020a056a203ca200b000bd14f47addmr15408642pzj.46.1675462956649;
        Fri, 03 Feb 2023 14:22:36 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:6e90:bb76:2b36:4df2])
        by smtp.gmail.com with ESMTPSA id t23-20020a639557000000b004ecd14297f2sm1975898pgn.10.2023.02.03.14.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 14:22:35 -0800 (PST)
Date:   Fri, 3 Feb 2023 14:22:32 -0800
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
Message-ID: <Y92JKFwF5vS1byx2@google.com>
References: <20230201054815.4112632-1-dmitry.torokhov@gmail.com>
 <20230201054815.4112632-2-dmitry.torokhov@gmail.com>
 <31e979dd-f4e9-081e-1bf2-e44dffc4e70f@linaro.org>
 <Y9qQHj70SN/3fZCc@google.com>
 <20230201175504.GA4075318-robh@kernel.org>
 <Y9q3T17r5G2PD9Gk@google.com>
 <20230202232734.GA2889187-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202232734.GA2889187-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 05:27:34PM -0600, Rob Herring wrote:
> On Wed, Feb 01, 2023 at 11:02:39AM -0800, Dmitry Torokhov wrote:
> > On Wed, Feb 01, 2023 at 11:55:04AM -0600, Rob Herring wrote:
> > > On Wed, Feb 01, 2023 at 08:15:26AM -0800, Dmitry Torokhov wrote:
> > > > On Wed, Feb 01, 2023 at 08:38:48AM +0100, Krzysztof Kozlowski wrote:
> > > > > On 01/02/2023 06:48, Dmitry Torokhov wrote:
> > > > > > MOXA ART RTC driver has been switched to gpiod API and is now using
> > > > > > properly named properties for its gpios (with gpiolib implementing a
> > > > > > quirk to recognize legacy names). Change binding document to use
> > > > > > proper names as well.
> > > > > > 
> > > > > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > > > > ---
> > > > > >  .../devicetree/bindings/rtc/moxa,moxart-rtc.txt      | 12 ++++++------
> > > > > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > > > > > 
> > > > > > diff --git a/Documentation/devicetree/bindings/rtc/moxa,moxart-rtc.txt b/Documentation/devicetree/bindings/rtc/moxa,moxart-rtc.txt
> > > > > > index c9d3ac1477fe..1374df7bf9d6 100644
> > > > > > --- a/Documentation/devicetree/bindings/rtc/moxa,moxart-rtc.txt
> > > > > > +++ b/Documentation/devicetree/bindings/rtc/moxa,moxart-rtc.txt
> > > > > > @@ -3,15 +3,15 @@ MOXA ART real-time clock
> > > > > >  Required properties:
> > > > > >  
> > > > > >  - compatible : Should be "moxa,moxart-rtc"
> > > > > > -- gpio-rtc-sclk : RTC sclk gpio, with zero flags
> > > > > > -- gpio-rtc-data : RTC data gpio, with zero flags
> > > > > > -- gpio-rtc-reset : RTC reset gpio, with zero flags
> > > > > > +- rtc-sclk-gpios : RTC sclk gpio, with zero flags
> > > > > > +- rtc-data-gpios : RTC data gpio, with zero flags
> > > > > > +- rtc-reset-gpios : RTC reset gpio, with zero flags
> > > > > 
> > > > > Your driver breaks the ABI, doesn't it? If not, how are the old
> > > > > properties parsed?
> > > > 
> > > > It does not. As I mentioned in the driver code patch, commit
> > > > eaf1a29665cd ("gpiolib: of: add a quirk for legacy names in MOXA ART
> > > > RTC") makes sure gpiolib falls back to trying old variants if it can't
> > > > locate properly formatted names.
> > > 
> > > A dtb with the new names and a kernel without the gpiod conversion would 
> > > be broken. Up to the platform whether they care really.
> > 
> > Seriously? And I guess devices with DTS do not work with kernels v2.0 so
> > we should never have introduced it...
> 
> They would be fine because they would ignore the dtb. ;)
> 
> > I understand wanting backward compatibility, but asking for both
> > backward and forward is a bit too much IMO.
> 
> Like I said, up to the platform to decide. I'm just defining what's an 
> ABI break or not.
> 
> If the dtb ships with firmware, do you want new firmware with a newer 
> dtb to break your OS? We can sometimes mitigate that with stable kernel 
> updates. There are obvious cases that don't work such as adding 
> providers such as clocks (instead of dummy fixed clocks) or pinctrl, 
> where old kernels will never have the driver (but doesn't know that).

When vendors ship firmware they target particular set of software that
runs on it, so they would not mindlessly jump to the very latest version
of binding. Doing that would be similar to a vendor that originally
shipped a system with Windows 7 out of sudden changing its firmware to
use latest and greatest mechanisms defined in ACPI 6.5 and removing
older ones.

Thanks.

-- 
Dmitry
