Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E0274D809
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 15:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbjGJNpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 09:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjGJNpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 09:45:21 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE37D2;
        Mon, 10 Jul 2023 06:45:17 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-c6cad6a3998so4257074276.3;
        Mon, 10 Jul 2023 06:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688996716; x=1691588716;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BgDibfR0vAy+tLjLyuDFWsMqKLHBAQDTBnmpMQZgZHM=;
        b=NEh20sQA0/Nk1JUkAoZXMpAvCOBQ3PofbPqSWNWdTAiY0a08l5a6wDUeHSzoXxGpp1
         7osD9g+aPAJWMGG4R4q1LuqrdfjORuD4rrpniZGYfbCePnIJ9AgUul7UiOmxP8bL1/cX
         QfqTzWeHyTtaFOsP2u1JfcRNSnNJvxFnW6OY7x5Izxamti7wTCQ9Cj6eIROe1Rb1OI+T
         8ARbMUqLucJxl7miJt+iTVPM8Zg1XqRf2eswqsIKMyhmCUvp+sTAsc9Xgb0CY2P0bjvR
         2pHmLYUIpcLvxZ1bQ+p0JENGcsWeRrYAu25k36PieRIb9ME+FjB0nWmmHSd0e4i6NaCH
         82Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688996716; x=1691588716;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BgDibfR0vAy+tLjLyuDFWsMqKLHBAQDTBnmpMQZgZHM=;
        b=W5hK4moHT2ZhnQN5ZmocrYy5PhlB3vtSpT9lK9HeldHO3ic6K/95w8Jgpt2Ob8ZLZz
         GxIsTqGQUZoaL6B/+tlPw5T0vtdQaniDmvDvELhiG3HOZnMdoMq/tX6VZH7/AaxMBmg3
         QIFUfmmwRLzagpQ1c2aKeM8fVNmUrapQDkU0kGohn1yfBaJ7ydDIjsf2aget/a+q1CNC
         wtTJaYBBecXLpNvPwALCjPYDAZGqLA3nI7zNm5eI7KBh7AUmPwHrSnj7cjEbFVocGZVm
         6ytttM0cuumPWHtFffWu/r1JDBXbqKL3cffeC/x+QIiKwmxlfxaPxo+Zq2f0V9Yyx+Tq
         lVjg==
X-Gm-Message-State: ABy/qLad35qxN/XpiinO/c0pNptwaDM2O9ax52W1XH4HK6kkol+FYCte
        IID8e9cbhb5/jWxWLIoOrXV/Lg8u+zM=
X-Google-Smtp-Source: APBJJlEY+dyUdKH6Z2Inbsz5UG/wmI+GW2BQqQIJgC6nYrh9+GwOQruu8eXHiIFkeCcRkH7uVV83SQ==
X-Received: by 2002:a5b:345:0:b0:c83:add0:889f with SMTP id q5-20020a5b0345000000b00c83add0889fmr2344630ybp.51.1688996716257;
        Mon, 10 Jul 2023 06:45:16 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c12-20020a5b014c000000b00c624de0d9absm2544316ybp.5.2023.07.10.06.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 06:45:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 10 Jul 2023 06:45:14 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Henning Schild <henning.schild@siemens.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Jean Delvare <jdelvare@suse.com>,
        linux-watchdog@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Tobias Schaffner <tobias.schaffner@siemens.com>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>
Subject: Re: [PATCH 1/2] watchdog: simatic-ipc-wdt: make IO region access of
 one model muxed
Message-ID: <087368d7-15d6-45e2-bd1e-5955bf81d206@roeck-us.net>
References: <20230706154831.19100-1-henning.schild@siemens.com>
 <20230706154831.19100-2-henning.schild@siemens.com>
 <876f6a08-1850-21cd-83d1-b309e7e1e912@roeck-us.net>
 <4a11393d-69bb-8e9d-3bfe-21aa7a7fb1e3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4a11393d-69bb-8e9d-3bfe-21aa7a7fb1e3@redhat.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 03:33:45PM +0200, Hans de Goede wrote:
> Hi Guenter,
> 
> On 7/6/23 18:03, Guenter Roeck wrote:
> > On 7/6/23 08:48, Henning Schild wrote:
> >> The IO region used for the watchdog also hold CMOS battery monitoring
> >> information. Make the access muxed so that a hwmon driver can use the
> >> region as well.
> >>
> >> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> > 
> > Acked-by: Guenter Roeck <linux@roeck-us.net>
> 
> Thank you. Is it ok if I pick up his patch and merge it together with 2/2
> through the pdx86 tree ?
> 

Yes. That was my assumption.

Guenter

> Regards,
> 
> Hans
> 
> 
> > 
> >> ---
> >>   drivers/watchdog/simatic-ipc-wdt.c | 9 ++++++---
> >>   1 file changed, 6 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/watchdog/simatic-ipc-wdt.c b/drivers/watchdog/simatic-ipc-wdt.c
> >> index 6599695dc672..cdc1a2e15180 100644
> >> --- a/drivers/watchdog/simatic-ipc-wdt.c
> >> +++ b/drivers/watchdog/simatic-ipc-wdt.c
> >> @@ -155,9 +155,8 @@ static int simatic_ipc_wdt_probe(struct platform_device *pdev)
> >>         switch (plat->devmode) {
> >>       case SIMATIC_IPC_DEVICE_227E:
> >> -        if (!devm_request_region(dev, gp_status_reg_227e_res.start,
> >> -                     resource_size(&gp_status_reg_227e_res),
> >> -                     KBUILD_MODNAME)) {
> >> +        res = &gp_status_reg_227e_res;
> >> +        if (!request_muxed_region(res->start, resource_size(res), res->name)) {
> >>               dev_err(dev,
> >>                   "Unable to register IO resource at %pR\n",
> >>                   &gp_status_reg_227e_res);
> >> @@ -210,6 +209,10 @@ static int simatic_ipc_wdt_probe(struct platform_device *pdev)
> >>       if (wdd_data.bootstatus)
> >>           dev_warn(dev, "last reboot caused by watchdog reset\n");
> >>   +    if (plat->devmode == SIMATIC_IPC_DEVICE_227E)
> >> +        release_region(gp_status_reg_227e_res.start,
> >> +                   resource_size(&gp_status_reg_227e_res));
> >> +
> >>       watchdog_set_nowayout(&wdd_data, nowayout);
> >>       watchdog_stop_on_reboot(&wdd_data);
> >>       return devm_watchdog_register_device(dev, &wdd_data);
> > 
> 
