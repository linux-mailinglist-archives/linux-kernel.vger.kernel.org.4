Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD1F722D84
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 19:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbjFERV7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 5 Jun 2023 13:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjFERV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 13:21:57 -0400
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B5D8F;
        Mon,  5 Jun 2023 10:21:56 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-974539fd9f0so91572066b.0;
        Mon, 05 Jun 2023 10:21:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685985714; x=1688577714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wbfuCX3KeuduJF8G+hJppxoK/oLfHykbG+OR5oxUZ7w=;
        b=CThqsbtnRxYVXAwHJ2NDtAqfLp+z+mXHZXhF9zY6mv5eZOblKa7nsNb7eoUkXqF96/
         2OLZY2gv+Bdir2dBDyvhHpKpUIecYjjxx7EWQXq0ttzgEs7UlWVEWFjm2ggXST3XaOac
         St5Ffp7PMZLBpiAxY5gF2y51XaeJupgNyu9JtkAP+ot2B/n2GLzG2rRK0TKBDGS+R29R
         FH+6oETEJ3k5a/uVXNn05awHq2r6OoMVebAEZ7TYKpGifcvJII3QHsF5VqcdkHB45+aw
         emLFdDzWnGRvh2atUab5vNMSTvLycazYsHYGupMX9HhH6GtKQsw2EF6KarnRwPLfDEuI
         Al1w==
X-Gm-Message-State: AC+VfDycJPR5WWXu+2lillQ4LOroEVhvEhh+fNDD2kNWy7vtQBN0j0HB
        kB3N9nNrhqAhv+HzjSverjH1dxXzUHw/Lfh5sIs=
X-Google-Smtp-Source: ACHHUZ6IIMkr8cREMNLySIQBDWbdoz2BkL3etn1uvisfJ75KGhwsywwPE4Aos4yMV3rZlBCrLwiCHWJj0UvbrI5YP/8=
X-Received: by 2002:a17:906:5199:b0:975:bb7:5dc3 with SMTP id
 y25-20020a170906519900b009750bb75dc3mr7278685ejk.7.1685985714469; Mon, 05 Jun
 2023 10:21:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230601221151.670-1-mario.limonciello@amd.com>
 <CAJsYDVKoB1AEL47Ud+8jbxMrbZedM0i9p44-PLQTFR9PKLfy6A@mail.gmail.com> <9d420293-f5af-7563-e7ec-1e42bd69bb8e@amd.com>
In-Reply-To: <9d420293-f5af-7563-e7ec-1e42bd69bb8e@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 5 Jun 2023 19:21:43 +0200
Message-ID: <CAJZ5v0ia97k3_1SC6tAbgpQqq-EYCkMk1mUvn1=ex=twXVmgpg@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI: resource: Remove "Zen" specific match and quirks
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     Chuanhong Guo <gch981213@gmail.com>, linux-acpi@vger.kernel.org,
        rafael@kernel.org, linux-kernel@vger.kernel.org,
        ofenfisch@googlemail.com, wse@tuxedocomputers.com,
        adam.niederer@gmail.com, adrian@freund.io, jirislaby@kernel.org,
        Renjith.Pananchikkal@amd.com, anson.tsao@amd.com,
        Richard.Gong@amd.com, evilsnoo@proton.me, ruinairas1992@gmail.com,
        nmschulte@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 5, 2023 at 4:46 PM Limonciello, Mario
<mario.limonciello@amd.com> wrote:
>
>
> On 6/3/2023 5:19 AM, Chuanhong Guo wrote:
> > Hi!
> >
> > On Fri, Jun 2, 2023 at 6:12 AM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> >> commit 9946e39fe8d0 ("ACPI: resource: skip IRQ override on
> >> AMD Zen platforms") attempted to overhaul the override logic so it
> >> didn't apply on X86 AMD Zen systems.  This was intentional so that
> >> systems would prefer DSDT values instead of default MADT value for
> >> IRQ 1 on Ryzen 6000 systems which typically uses ActiveLow for IRQ1.
> >>
> >> This turned out to be a bad assumption because several vendors
> >> add Interrupt Source Override but don't fix the DSDT. A pile of
> >> quirks was collecting that proved this wasn't sustaintable.
> >>
> >> Furthermore some vendors have used ActiveHigh for IRQ1.
> >> To solve this problem revert the following commits:
> >> * commit 17bb7046e7ce ("ACPI: resource: Do IRQ override on all TongFang
> >> GMxRGxx")
> >> * commit f3cb9b740869 ("ACPI: resource: do IRQ override on Lenovo 14ALC7")
> >> * commit bfcdf58380b1 ("ACPI: resource: do IRQ override on LENOVO IdeaPad")
> >> * commit 7592b79ba4a9 ("ACPI: resource: do IRQ override on XMG Core 15")
> >> * commit 9946e39fe8d0 ("ACPI: resource: skip IRQ override on AMD Zen
> >> platforms")
> >>
> >> Cc: ofenfisch@googlemail.com
> >> Cc: wse@tuxedocomputers.com
> >> Cc: adam.niederer@gmail.com
> >> Cc: adrian@freund.io
> >> Cc: jirislaby@kernel.org
> >> Cc: Renjith.Pananchikkal@amd.com
> >> Cc: anson.tsao@amd.com
> >> Cc: Richard.Gong@amd.com
> >> Cc: Chuanhong Guo <gch981213@gmail.com>
> >> Reported-by: evilsnoo@proton.me
> >> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217394
> >> Reported-by: ruinairas1992@gmail.com
> >> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217406
> >> Reported-by: nmschulte@gmail.com
> >> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217336
> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >> ---
> >> v2->v3:
> >>   * Adjust to drop heuristics entirely
> >>   * Drop tested tags
> >>   * Add more links and people to Cc
> >>   * Drop Fixes tag as this got a lot more risky
> >> v1->v2:
> >>   * Rebase on 71a485624c4c ("ACPI: resource: Add IRQ override quirk for LG UltraPC 17U70P")
> >>   * Pick up tag
> >>
> >> Rafael,
> >> Please hold off on picking this up until the majority of those on CC
> >> have tested it on hardware they have and reported results.
> >>
> >> Everyone else,
> >> Please test. If you have problems with this applied, please share
> >> an acpidump and dmesg either on a bug or to me privately.
> > I was expecting this patch to break my keyboard again but
> > that didn't happen. I'm on the latest UEFI from Lenovo.
> > By dumping ACPI APIC I found that there's this:
> >
> > [0C4h 0196   1]                Subtable Type : 02 [Interrupt Source Override]
> > [0C5h 0197   1]                       Length : 0A
> > [0C6h 0198   1]                          Bus : 00
> > [0C7h 0199   1]                       Source : 01
> > [0C8h 0200   4]                    Interrupt : 00000001
> > [0CCh 0204   2]        Flags (decoded below) : 0007
> >                                      Polarity : 3
> >                                  Trigger Mode : 1
> >
> > I don't have a dump of the ACPI table from older UEFIs anymore.
> >
> > Tested on Lenovo Thinkbook 14G4+ ARA with the latest
> > UEFI (J6CN45WW).
> >
> > Tested-by: Chuanhong Guo <gch981213@gmail.com>
> Thanks!  Yours is the one I was most worried about.

I've applied the patch as 6.5 material, thanks!
