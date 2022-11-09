Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4ECB623378
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 20:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbiKITaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 14:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiKITaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 14:30:13 -0500
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969EFA474;
        Wed,  9 Nov 2022 11:30:12 -0800 (PST)
Received: by mail-qt1-f170.google.com with SMTP id e15so10964122qts.1;
        Wed, 09 Nov 2022 11:30:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Dad91m4JdqavDny1NSm8MrvniHzGm/e+1gZ5ERythI=;
        b=UZk+pdHTM2cRyt1R5hFJoUrnPsMxn6lGq4XjxUIqDrhxI7xOFsEMbITaa6yJV/CJNQ
         CPPfpXzioMizpuz4W4zvbyvyfWOagLxF4/5XLPw34JiGf1naE/HZzv6l8n30QawVwehR
         oTivL8fkU3He4r3Vbk5fuxZJ6BKp0ZhN5VGdBeD/Yimrx6OrLdvpROl0fidn+iuI+/VA
         A2TmvjpT5k0edYfUdEZuJ1IF09zaWZGbtN0PI1MVMp/JYJSKQld82IoIKSQ+gSsaBS9C
         BOWy6PbqnzdsUqC83XLzorSyFbt+pNqpmjYo6rLO/0xvi32vO12kliFaGnpO785lyfyh
         KVbQ==
X-Gm-Message-State: ACrzQf1bEywJGfHB/OqdB48Ze03tIbItW8UpneU9Dt62LeWeslhgVR87
        R3MGuD+1xKIW5iVuVlnMBpij0Z6/WKaJMJ7gNys=
X-Google-Smtp-Source: AMsMyM7NOjN2Zy0q7508HKVoeHqnitZBBNrkXL8QY20vxqMIbnjZV+T+DEUJ2smumypFXTCU6Ugr73SduA5MeoWuqQ4=
X-Received: by 2002:a05:622a:4c07:b0:3a5:27ec:6dd3 with SMTP id
 ey7-20020a05622a4c0700b003a527ec6dd3mr41130537qtb.411.1668022211771; Wed, 09
 Nov 2022 11:30:11 -0800 (PST)
MIME-Version: 1.0
References: <20221017130910.2307118-1-linux@roeck-us.net> <20221102185030.GA2026081@roeck-us.net>
In-Reply-To: <20221102185030.GA2026081@roeck-us.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 9 Nov 2022 20:30:00 +0100
Message-ID: <CAJZ5v0h_treX+uL_D8=b0NOyVU56W=wCQyKu3oMz7nGaWT_MUw@mail.gmail.com>
Subject: Re: [PATCH 0/9] thermal/core: Protect thermal device operations
 against removal
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

Sorry for the delay.

On Wed, Nov 2, 2022 at 7:50 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Hi,
>
> On Mon, Oct 17, 2022 at 06:09:01AM -0700, Guenter Roeck wrote:
> > Accesses to thermal zones, and with it to thermal zone device operations,
> > are still possible after the thermal zone device has been unregistered.
> > For example, thermal_zone_get_temp() can be called from temp_show()
> > in thermal_sysfs.c if the sysfs attribute was opened before the thermal
> > device was unregistered. This is problematic and may result in crashes
> > since the operations data structure and the underlying code may be gone
> > when the calls are made.
> >
> > The following series solves the problem by protecting accesses to thermal
> > device operations with the thermal device mutex, and by verifying that the
> > thermal device is still registered after the mutex has been acquired.
> >
> > This was previously sent as RFC/RFT as single patch [1]. The code was reworked
> > to match thermal subsystem changes made between v6.0 and v6.1, and it was
> > split into several patches to simplify review.
> >
>
> Any thoughts / comments / feedback on this series ?

I have reviewed the series now and haven't found any major issues in it.

I've posted some minor comments in separate replies to individual
patches.  If they are addressed, I can queue up the series for 6.2.

Cheers!


> > [1] https://lore.kernel.org/linux-pm/20221004033936.1047691-1-linux@roeck-us.net/
> >
> > ----------------------------------------------------------------
> > Guenter Roeck (9):
> >       thermal/core: Destroy thermal zone device mutex in release function
> >       thermal/core: Delete device under thermal device zone lock
> >       thermal/core: Ensure that thermal device is registered in thermal_zone_get_temp
> >       thermal/core: Move parameter validation from __thermal_zone_get_temp to thermal_zone_get_temp
> >       thermal/core: Introduce locked version of thermal_zone_device_update
> >       thermal/core: Protect hwmon accesses to thermal operations with thermal zone mutex
> >       thermal/core: Protect sysfs accesses to thermal operations with thermal zone mutex
> >       thermal/core: Remove thermal_zone_set_trips()
> >       thermal/core: Protect thermal device operations against thermal device removal
> >
> >  drivers/thermal/thermal_core.c    | 76 ++++++++++++++++++++++++--------------
> >  drivers/thermal/thermal_core.h    |  3 +-
> >  drivers/thermal/thermal_helpers.c | 65 ++++++++++++++++++++++-----------
> >  drivers/thermal/thermal_hwmon.c   | 14 +++++--
> >  drivers/thermal/thermal_sysfs.c   | 77 +++++++++++++++++++++++++++++++++------
> >  5 files changed, 169 insertions(+), 66 deletions(-)
