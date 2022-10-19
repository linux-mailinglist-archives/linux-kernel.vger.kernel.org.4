Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47843604CDF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 18:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiJSQOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 12:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbiJSQN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 12:13:59 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A614F1AA;
        Wed, 19 Oct 2022 09:13:56 -0700 (PDT)
Received: by mail-qk1-f179.google.com with SMTP id d13so11014828qko.5;
        Wed, 19 Oct 2022 09:13:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IHhKcEgiGkudQevH1H7LbkAoh0BJo+NcpXaDwQTf7b4=;
        b=yGjh5/P68z78GF5TttAb5JsYPXZMjjXAwOjGLMjaWQpEYl2M29OzG3/q8sC0b450WN
         Fiy7dMFMq6U8UDeXM4HmnqqrMC338xUUunZ6LX9hvtcgJJgyWEQgTeowY07BmGO0GZsQ
         5Ae2NWBKPKW74Ps7A5miXJ4Ml+Hzpey6q2H1VmBOALicr0j1Y+0ej/e8r6P8PV5AH/vt
         ECg9efBEbJJ4wKzZtHhRiwZDTCGm2yw6SxBYI/r3qNXVGhtpRVdjUJOGcUTOaVq8yAz6
         BC72nWONecuAA9ESqvU7YAAsaZibhUo+125/DRr8DIH67lg5VN2wE1h1TUGVnkwYor/T
         F/Kg==
X-Gm-Message-State: ACrzQf0H/vCuntJ6AYzYQ23aAW4mh3dgwuwxykgQjbe90EJ2zEw6I7ka
        U1J82QSLU0pRxJGahXCtyaAqKr5LY0+PTH2aZgs=
X-Google-Smtp-Source: AMsMyM5D7RZZU29da+wHtoXkLPoB/1LG3eWvwWGaAT8534K9+vHtCvMrVqTJPGn7HXBxL+tK2bPdVDCUl7T1YtTvjSY=
X-Received: by 2002:a05:620a:450c:b0:6ee:af91:60b2 with SMTP id
 t12-20020a05620a450c00b006eeaf9160b2mr6345268qkp.480.1666196035196; Wed, 19
 Oct 2022 09:13:55 -0700 (PDT)
MIME-Version: 1.0
References: <5887691.lOV4Wx5bFT@kreacher> <166611112152.2353171.9661532286339710942.b4-ty@bootlin.com>
In-Reply-To: <166611112152.2353171.9661532286339710942.b4-ty@bootlin.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 19 Oct 2022 18:13:43 +0200
Message-ID: <CAJZ5v0jh9g8fKAoymwv1UeUqtX7EcU3JkgMHsQWZSHngyQUFQg@mail.gmail.com>
Subject: Re: [PATCH] rtc: rtc-cmos: Fix wake alarm breakage
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Todd Brandt <todd.e.brandt@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 6:39 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> On Tue, 18 Oct 2022 18:09:31 +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Commit 4919d3eb2ec0 ("rtc: cmos: Fix event handler registration
> > ordering issue") overlooked the fact that cmos_do_probe() depended
> > on the preparations carried out by cmos_wake_setup() and the wake
> > alarm stopped working after the ordering of them had been changed.
> >
> > [...]
>
> Applied, thanks!
>
> [1/1] rtc: rtc-cmos: Fix wake alarm breakage
>       commit: 0782b66ed2fbb035dda76111df0954515e417b24

Thank you!

However, there is a build fix on top of this which has just been posted:

https://lore.kernel.org/linux-acpi/2677035.mvXUDI8C0e@kreacher/

Sorry about breaking it again.
