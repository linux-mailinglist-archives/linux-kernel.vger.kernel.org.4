Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5752604F84
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 20:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiJSSVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 14:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiJSSVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 14:21:04 -0400
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A5D176B93;
        Wed, 19 Oct 2022 11:21:03 -0700 (PDT)
Received: by mail-qk1-f177.google.com with SMTP id x13so11267014qkg.11;
        Wed, 19 Oct 2022 11:21:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rf1B0X+bp+VmAIqShi5GSUXRR6lyFCMHibX0juPXJDs=;
        b=EkVyObfx+8qGYcDlqx6iPybjGGDPbc2WHTDH2JKtUByhOFxwSnhKJEPmss0N6aVV5t
         789BV0X0SNLyfeUXtM4w7T9STFNm8l+tbKdF3LDDJyW5+cHcSiD+Eb30hvT47J9LplKm
         gV2UzMyElWSxs51tYvVmUA818TMQYkciV/DwPVQ/tbKiCtOnO3oS9vGmvQq2H2xS+7fN
         Pf/4ckL/gfomh30uzbCfxE/sU9Qc23EpdW44lLcBNIiawykfIwpLfJ1baPd7iUJqeKbl
         iKjvRIHjVD4clhoowa7A+WWdgR6wJ8BQoaKFrM9GQbljs/L6sVhJBTbap4uvLI/eVbxI
         6KYQ==
X-Gm-Message-State: ACrzQf0E6gpydE7ab3O7ZPeV7Aa7TUKo/OmBNDFpk59QIy76ElPjrV8I
        B405wbUHRqxyXQnDMqilxWXUjK7UTNvRqZ7QzH4=
X-Google-Smtp-Source: AMsMyM5xE5VdRAuXXW1dVy8lKG3x18M/ktegPWPCecQ6aqqTD9mlPculSMOkV+5ML3P7QHaIUs6QWukfZSCTyCPFILw=
X-Received: by 2002:a05:620a:290d:b0:6b6:1a92:d88a with SMTP id
 m13-20020a05620a290d00b006b61a92d88amr6651757qkp.58.1666203662326; Wed, 19
 Oct 2022 11:21:02 -0700 (PDT)
MIME-Version: 1.0
References: <5887691.lOV4Wx5bFT@kreacher> <166611112152.2353171.9661532286339710942.b4-ty@bootlin.com>
 <CAJZ5v0jh9g8fKAoymwv1UeUqtX7EcU3JkgMHsQWZSHngyQUFQg@mail.gmail.com> <Y1A/AZmfTI6hr3RZ@mail.local>
In-Reply-To: <Y1A/AZmfTI6hr3RZ@mail.local>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 19 Oct 2022 20:20:48 +0200
Message-ID: <CAJZ5v0hiVLroUiRv-96uyiMgj-7-GkJK5yB1O2ei8Q8gVvZPGA@mail.gmail.com>
Subject: Re: [PATCH] rtc: rtc-cmos: Fix wake alarm breakage
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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

On Wed, Oct 19, 2022 at 8:16 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> On 19/10/2022 18:13:43+0200, Rafael J. Wysocki wrote:
> > On Tue, Oct 18, 2022 at 6:39 PM Alexandre Belloni
> > <alexandre.belloni@bootlin.com> wrote:
> > >
> > > On Tue, 18 Oct 2022 18:09:31 +0200, Rafael J. Wysocki wrote:
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > Commit 4919d3eb2ec0 ("rtc: cmos: Fix event handler registration
> > > > ordering issue") overlooked the fact that cmos_do_probe() depended
> > > > on the preparations carried out by cmos_wake_setup() and the wake
> > > > alarm stopped working after the ordering of them had been changed.
> > > >
> > > > [...]
> > >
> > > Applied, thanks!
> > >
> > > [1/1] rtc: rtc-cmos: Fix wake alarm breakage
> > >       commit: 0782b66ed2fbb035dda76111df0954515e417b24
> >
> > Thank you!
> >
> > However, there is a build fix on top of this which has just been posted:
> >
> > https://lore.kernel.org/linux-acpi/2677035.mvXUDI8C0e@kreacher/
> >
> > Sorry about breaking it again.
>
> I had that in rtc-fixes:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git/commit/?h=rtc-fixes

Looks good, thanks!
