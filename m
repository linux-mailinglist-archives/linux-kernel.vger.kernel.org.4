Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A7E640F37
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 21:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234744AbiLBUeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 15:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiLBUeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 15:34:16 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC106EF0F0;
        Fri,  2 Dec 2022 12:34:15 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id c7so1433051pls.4;
        Fri, 02 Dec 2022 12:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=14xUzCkDZTIX4ZvU2fMuPgJCXPTawps2raw0aQTAfl0=;
        b=pBEOhi2yxhV+E7GqedD9eNHZmCTArEPPbWq4xksBXggTqWKRrE0aiiUNneRCxa0I0M
         TJvoP14DtrabIoGKwaPWxLVspTj7n7l12BIpwMyFhKHKt1CAmP7CMfHDqXDQI/AMuzFz
         2g0c5bOpBtP7M0Oxm3/o218UsMS37zz+r5QycjR4PNcYwPqYD9rSId+Hs//Dt0S5e1kP
         OXPLIpsKgnlVRVSR3xMzIyilKOPG1yEkyyO5iSj7PhYfc3mcsP4chz8jJySuCgM5NtyJ
         FO28y3aiRj8cMY7Cbyza654NXjLKIVIeyj2Bl2SmS6mbOI7n7Jd93X2N0nMcatwYldbi
         SZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14xUzCkDZTIX4ZvU2fMuPgJCXPTawps2raw0aQTAfl0=;
        b=pmRbHU5chQot9RIky9ZJQDBJKZLWrR/0yjxTMLmuR+y5qDjLSY9nbho5cpzSrwEHR6
         eIWoTEcmp6mueWJlvfQ8irKi39W2Exam+g31jfWlvZ9O28ba3rJPEflFxU3+4t0sLfD/
         lCBRNw+6rv0dgDaD7TnfDXvdVN5+MvV8bMZVCjsqu9DtnP13Eduv4gYGqR7k4kMG9koQ
         OdTq/idjBPJzUl5deuWjLmrkE29x/yXyirdD0PJidVc0+WwZ2M1J/7HqyLVnm4Of5YNr
         OZdg4fnI+r9UHhEnQNFUQ1l1u0zoqvllIG1BWWmioXzmTFZvfjiHIZs2luzzfoj31RXP
         alQQ==
X-Gm-Message-State: ANoB5pkgQN1Ede/rOWAGTFqjPgXp5ApR+/17BEjeYc0pYa5Cc0c0X3mt
        CZuKlEJkTQYaRpC+mXUbwEg=
X-Google-Smtp-Source: AA0mqf4IHG/sg2OVW8OJWOgenUejFzNKEzflUA06eBquAm7jugZvIQAntzHW2HYsMqvNKWYh00959A==
X-Received: by 2002:a17:903:41ca:b0:189:78d9:fe2e with SMTP id u10-20020a17090341ca00b0018978d9fe2emr33049857ple.96.1670013254897;
        Fri, 02 Dec 2022 12:34:14 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:cc23:eebe:90c0:1fbf])
        by smtp.gmail.com with ESMTPSA id e16-20020a17090301d000b00186727e5f5csm5954861plh.248.2022.12.02.12.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 12:34:13 -0800 (PST)
Date:   Fri, 2 Dec 2022 12:34:10 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org
Subject: Re: [PATCH] Input: edt-ft5x06 - always do msleep(300) during
 initialization
Message-ID: <Y4phQpK1Kwn5RC3u@google.com>
References: <20221202105800.653982-1-linux@rasmusvillemoes.dk>
 <Y4pCtm4J3HWhYl8/@nixie71>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4pCtm4J3HWhYl8/@nixie71>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

On Fri, Dec 02, 2022 at 12:23:50PM -0600, Jeff LaBundy wrote:
> + Mark
> 
> Hi Rasmus,
> 
> On Fri, Dec 02, 2022 at 11:57:59AM +0100, Rasmus Villemoes wrote:
> > We have a board with an FT5446, which is close enough to a
> > FT5506 (i.e. it also supports up to 10 touch points and has similar
> > register layout) for this driver to work. However, on our board the
> > iovcc and vcc regulators are indeed controllable (so not always-on),
> > but there is no reset or wakeup gpio hooked up.
> > 
> > Without a large enough delay between the regulator_enable() calls and
> > edt_ft5x06_ts_identify(), the first edt_ft5x06_ts_readwrite() call
> > fails with -ENXIO and thus the device fails to probe. So
> > unconditionally do an mdelay(300) instead of only when a reset-gpio is
> > present.
> > 
> > Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> 
> This is just my $.02, but it does not seem we are on the correct path
> here. 300 ms sounds more like bulk capacitor charge time rather than
> anything to do with this specific IC; is that a reasonable assumption?
> 
> Normally, we want to do the following:
> 
> 1. Enable regulator
> 2. Wait for voltage rail to stabilize (RC time constant)
> 3. Wait for any applicable POR delay (IC datasheet)
> 4. Deassert reset
> 5. Wait for any applicable reset delay (IC datasheet)
> 6. Start communication
> 
> Here we are dealing with step (2), which is board dependent. Some may
> require more time (larger bulk capacitance), same may require less or
> none at all (e.g. voltage rail enabled by default and stable by the
> time the kernel starts).
> 
> I think the right solution is to introduce a variant of regulator_enable()
> which does not return until a delay passes, where that delay is specified
> in the regulator's child node. Unless something like this exists?

regulator_enable() (via regulator_do_enable() already does this:


	/* Allow the regulator to ramp; it would be useful to extend
	 * this for bulk operations so that the regulators can ramp
	 * together.
	 */
	trace_regulator_enable_delay(rdev_get_name(rdev));
	...

but I wonder if here we are still dealing with some form of 5 even in
the absence of reset gpio being actually wired up (how is the chip's
reset pin actually wired in this system)?

It would be good if we had something like regulator_get_enabled_time()
to know actual time when regulator was enabled (and for always on or
stub regulators we might use the boot time as "on" time), so that we do
not wait unnecessarily in case the regulator was turned on long time ago
or was never turned off...

Thanks.

-- 
Dmitry
