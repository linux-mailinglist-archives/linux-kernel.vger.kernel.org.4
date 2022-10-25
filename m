Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82AC460CCCE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 15:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbiJYNAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 09:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbiJYM7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 08:59:31 -0400
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94AE3ECE9;
        Tue, 25 Oct 2022 05:55:23 -0700 (PDT)
Received: by mail-qk1-f181.google.com with SMTP id z17so5272328qkj.8;
        Tue, 25 Oct 2022 05:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yIHQeRu6+k+uEjVxAuibPyEPD1wGoj/FafhrdNtjTmA=;
        b=g2UYhyizFNx4N+YG77NmhcBgXiYCAeOucEMc9cO98d6xMuVvoRxJtDOMjMOSaaAWK+
         AN/7QRSGMWv+Y8dqswlOfa9mhOM8qCFXJyw6GtGl7A9ZfdYxsl6uCp2rRtJbLgcl42mo
         UyAp2N1tOH6qNXpycgfpE4bMvxPASpIrW8eXSHTPvJCj3O/HIaYqk9BnCYut5aSWoxL7
         9jos/pAhgdRHhZwxbkh8Luku7SI6REgAiGPDZKiPsHzRutRki1AQE+kfGwH/PY9Qr4Hc
         Uf7/1cmxll1juncLEz1UqHu6N6+RShveNmb6X2V824KTR1szHmNT+/pYVzUVNHreLILO
         dbTA==
X-Gm-Message-State: ACrzQf3vIS9kPmVtZiRIuQRg+x4wpujW7csZaZG61RwMeF3OAETpE0NT
        YnmhhURi7RbZYHHFNrHb67vVhKdHfmUm+MVNsPWbvdyt
X-Google-Smtp-Source: AMsMyM4iYSyBRCGcK7eDHaL2ViaugaEPr0CLBkHXpCP+PPhafrPxnLbbBXqcFORjaIneVsGhlXBdbx8tkBjuEIy+Heg=
X-Received: by 2002:a05:620a:4626:b0:6ee:b43:d2bc with SMTP id
 br38-20020a05620a462600b006ee0b43d2bcmr25553040qkb.764.1666702522945; Tue, 25
 Oct 2022 05:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <20221013035017.5098-1-mario.limonciello@amd.com> <63718e7b-bc37-af47-011d-9fd0207a6d2c@amd.com>
In-Reply-To: <63718e7b-bc37-af47-011d-9fd0207a6d2c@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 25 Oct 2022 14:55:11 +0200
Message-ID: <CAJZ5v0i-vQSAMrKCbh+e0OGW8-ctzaxSzhx9uWAO5vtrYg6L1w@mail.gmail.com>
Subject: Re: [PATCH] PM: hibernate: Allow hybrid sleep to work with s2idle
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        kolAflash <kolAflash@kolahilft.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 2:12 AM Limonciello, Mario
<mario.limonciello@amd.com> wrote:
>
> On 10/12/2022 22:50, Mario Limonciello wrote:
> > Hybrid sleep is currently hardcoded to only operate with S3 even
> > on systems that might not support it.
> >
> > Instead of assuming this mode is what the user wants to use, for
> > hybrid sleep follow the setting of `mem_sleep_current` which
> > will respect mem_sleep_default kernel command line and policy
> > decisions made by the presence of the FADT low power idle bit.
> >
> > Reported-and-tested-by: kolAflash <kolAflash@kolahilft.de>
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=216574
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > ---
> >   kernel/power/hibernate.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
>
> Hi Rafael,
>
> This got sent near the merge window a few weeks ago.  It's a trivial fix
> so I just want to make sure it didn't get misplaced.

It wasn't lost.

I've just applied it for -rc3 (and added a Fixes: tag that was missing to it).

Thanks!

> >
> > diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> > index 89c71fce225dd..537dd3beafc16 100644
> > --- a/kernel/power/hibernate.c
> > +++ b/kernel/power/hibernate.c
> > @@ -641,7 +641,7 @@ static void power_down(void)
> >       int error;
> >
> >       if (hibernation_mode == HIBERNATION_SUSPEND) {
> > -             error = suspend_devices_and_enter(PM_SUSPEND_MEM);
> > +             error = suspend_devices_and_enter(mem_sleep_current);
> >               if (error) {
> >                       hibernation_mode = hibernation_ops ?
> >                                               HIBERNATION_PLATFORM :
>
