Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17BE572F434
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 07:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242910AbjFNFh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 01:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242719AbjFNFhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 01:37:25 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED861984
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 22:37:24 -0700 (PDT)
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 612033F273
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 05:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686721040;
        bh=L700u4JHszhgKkjQdfFwXH0svBOHFooI3nofINxb84U=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=J8IR/UxZxnrMUz/OAv3XXvPm/4AplucihaWNCEeMJtGEtiY7NfzqJo94cgJpEVvBF
         uffa5xuZKao1NmrVvu6ewpNcRBAsvoqqbJNEkp+jnsqK2pm80VY+uq84zvV4WNpBPR
         vP2JdnDq8BtdJi6NFHmkIWmFxaC17gwjZX5iWjpAOLeYu91bnliqDfPaE9l9U6nOlN
         i1/fJTj3Ey9MSm0WoOhwRpZOVFBocTba16yOWHmT0lvfdiwZiCpG+fp20WPu9imn6W
         yoFdr8XzZTBl/EOXL3UquEEwXKnil6F9FWVXolpmbAKhG3aryXbrKLLiwWLtQibI76
         aGJS2xJ6NVudg==
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-39a9cefa414so4700635b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 22:37:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686721039; x=1689313039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L700u4JHszhgKkjQdfFwXH0svBOHFooI3nofINxb84U=;
        b=A+BVklTHDs6q//LzrvyUfGaGFHVB7/s57+LxasmriCgmiL/G0v2xR7jvm3iebsMduV
         dQ4DTFXS+KaGQXkegmNpc/NmgPyelPlSLeqbxHGsY1F19uTViVyBEvJzDBkTCiKLquLG
         KFed5uWpIn/Fjyd6341W/D47nH+n7GxTcmwEzSTQ6g4O17fm70eBCO3ohBHpWKPlf3n+
         VCCurkrLvMVKkpbBbxzUXUZJLLSDXEUSPef1+2GDq/Mt8OUfdLNPzy1cJnBOXqoZ5mrg
         Phz3setSeBy6+o9BtMEPrRNGogFDS7jpvStVvjRlslnHUghTzzwRiXB5pd2RB02KDUZH
         UZ9w==
X-Gm-Message-State: AC+VfDyWGXvzioX1Qs45IcdPWhe8JaJfZbQSoqSpOxov8VxARhEtqMEU
        WDsIdE2cHsR4yPGRMFWC8vQ4r5CGhMHNtfcFUpMpQqdaoboqh7xXubun7HzCtqr1G5WaLYxdn3J
        YXKllEPdlJX7sgTqkf1EASOoZY4j52ZmupAWX5Fgw4pWzGeX8bNgdgGnJ+A==
X-Received: by 2002:aca:2301:0:b0:398:19e6:56a9 with SMTP id e1-20020aca2301000000b0039819e656a9mr9458906oie.2.1686721039177;
        Tue, 13 Jun 2023 22:37:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4ZCvNJFhBXY5DTwt5hF4ORUgqFO+d5WsQ0PVogShHgfbbdYyTneKVBelaRsDRX0hSU0EGW4U4/NdJvc7kGFqw=
X-Received: by 2002:aca:2301:0:b0:398:19e6:56a9 with SMTP id
 e1-20020aca2301000000b0039819e656a9mr9458892oie.2.1686721038957; Tue, 13 Jun
 2023 22:37:18 -0700 (PDT)
MIME-Version: 1.0
References: <2d1fdf6d-682c-a18d-2260-5c5ee7097f7d@gmail.com>
 <5513e29d-955a-f795-21d6-ec02a2e2e128@gmail.com> <ZIQ6bkau3j6qGef8@duo.ucw.cz>
 <07d6e2e7-a50a-8cf4-5c5d-200551bd6687@gmail.com> <02e4f87a-80e8-dc5d-0d6e-46939f2c74ac@acm.org>
 <b2cf6d96-a55a-d444-d22e-e9b3945ba43f@jmbreuer.net> <84f1c51c-86f9-04b3-0cd1-f685ebee7592@kernel.org>
In-Reply-To: <84f1c51c-86f9-04b3-0cd1-f685ebee7592@kernel.org>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 14 Jun 2023 13:37:07 +0800
Message-ID: <CAAd53p665S+dfOvWZt2UwTs=VrxE=FtpqjzUrSuLKR5tBpAa9Q@mail.gmail.com>
Subject: Re: Fwd: Waking up from resume locks up on sr device
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Joe Breuer <linux-kernel@jmbreuer.net>,
        Bart Van Assche <bvanassche@acm.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Linux Power Management <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Hardening <linux-hardening@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux SCSI <linux-scsi@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Dan Williams <dan.j.williams@intel.com>,
        Hannes Reinecke <hare@suse.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 12:49=E2=80=AFPM Damien Le Moal <dlemoal@kernel.org=
> wrote:
>
> On 6/11/23 18:05, Joe Breuer wrote:
> > I'm the reporter of this issue.
> >
> > I just tried this patch against 6.3.4, and it completely fixes my
> > suspend/resume issue.
> >
> > The optical drive stays usable after resume, even suspending/resuming
> > during playback of CDDA content works flawlessly and playback resumes
> > seamlessly after system resume.
> >
> > So, from my perspective: Good one!
>
> In place of Bart's fix, could you please try this patch ?

Issue still persists at my end, when /sys/power/pm_async is 0.
device_pm_wait_for_dev() in its current form is only usable for async case.

Kai-Heng

>
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index b80e68000dd3..a81eb4f882ab 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -4006,9 +4006,32 @@ static void ata_eh_handle_port_resume(struct
> ata_port *ap)
>         /* tell ACPI that we're resuming */
>         ata_acpi_on_resume(ap);
>
> -       /* update the flags */
>         spin_lock_irqsave(ap->lock, flags);
> +
> +       /* Update the flags */
>         ap->pflags &=3D ~(ATA_PFLAG_PM_PENDING | ATA_PFLAG_SUSPENDED);
> +
> +       /*
> +        * Resuming the port will trigger a rescan of the ATA device(s)
> +        * connected to it. Before scheduling the rescan, make sure that
> +        * the associated scsi device(s) are fully resumed as well.
> +        */
> +       ata_for_each_link(link, ap, HOST_FIRST) {
> +               ata_for_each_dev(dev, link, ENABLED) {
> +                       struct scsi_device *sdev =3D dev->sdev;
> +
> +                       if (!sdev)
> +                               continue;
> +                       if (scsi_device_get(sdev))
> +                               continue;
> +
> +                       spin_unlock_irqrestore(ap->lock, flags);
> +                       device_pm_wait_for_dev(&ap->tdev,
> +                                              &sdev->sdev_gendev);
> +                       scsi_device_put(sdev);
> +                       spin_lock_irqsave(ap->lock, flags);
> +               }
> +       }
>         spin_unlock_irqrestore(ap->lock, flags);
>  }
>  #endif /* CONFIG_PM */
>
> Thanks !
>
> --
> Damien Le Moal
> Western Digital Research
>
