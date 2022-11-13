Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8D36271B8
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 19:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235522AbiKMSnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 13:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbiKMSnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 13:43:14 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1A51007A;
        Sun, 13 Nov 2022 10:43:13 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id b185so9135346pfb.9;
        Sun, 13 Nov 2022 10:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k8vSHHNv2Bg5J5FULTMMY+fgGAbq3LKBKnD5MYk+EOY=;
        b=VnNFK5a1E1GQzM3wupjVRW3SI0Vc1BTnsUeIwaAR14C/kqQAR3NrlJSG5zLnpkTC/5
         jknO24J2wojaDbcZuFLjOLO3OgvjRg1F/O3pGpU81MghmzgW8NDDiZs1p62Vr0vRPD0d
         O6FoYSN1HlGPKjnlWHhWmfuHQAqydDh2mfYmGX3gUv+hiSFhkXIeQIovjRG9Pe9iP0M3
         qe3qp0dZ6gB7saf0qEuAL9MOA/8Na6SWYO+It84mzHkdMWPLC16Lz/ASC7YaJ6M1elZY
         OeaW0DW/F2lygR71xCRD8U5mfDJVTwALozG0sstN4IqUCDGgetK/KfWl7F0zOMFMxMB4
         RnkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k8vSHHNv2Bg5J5FULTMMY+fgGAbq3LKBKnD5MYk+EOY=;
        b=0JmbDZV1jHjbx1KnvtiAigslpCvjZEUWliGAgchEJagc4vHiO7RrjZBL3o9UgZ+tg9
         WokmlvH4RWE8cOW4Ke6d/CoBhbPOngVuJcSdpC8/v3Oc5xBCHgLesYbDAXx+5mpmjPUh
         ffIWI/mLt838i2wqDIney4ocExvQB61Sl63smAoPdLmA7br0jGc+7BCaYPRsJfdRaZnP
         qKetIdLcJNDQNH7NzQ4Yeg2AN5tkPoArJhne4sZL6qcm1TbQph8N03C66NGrocTM+EH8
         uyu72Uj2PkMpcFTIKSzr/A4hcB4wZD1DjES499Li/Za0WBQn1K5OQkTjYACq10ZhylTX
         H7Zg==
X-Gm-Message-State: ANoB5pmjwNX1jF2PJdhguPkSlnQ6tNXUppk+PQuXjZWqeOuLyErtRT2M
        d97bLxzZn9zHAfak4NbMY075O1vTNd26eEWjum8=
X-Google-Smtp-Source: AA0mqf5rHz+vA5PQaqvoliDSV5HsO18XlEPUxjK8RFVBc/k8VeAYWvIh8ol3exz4WKy3J92eKzHMUPkUG3GNbfvqs9A=
X-Received: by 2002:aa7:96a2:0:b0:56b:f62c:4dc0 with SMTP id
 g2-20020aa796a2000000b0056bf62c4dc0mr10810717pfk.79.1668364992445; Sun, 13
 Nov 2022 10:43:12 -0800 (PST)
MIME-Version: 1.0
References: <yq15zo86nvk.fsf@oracle.com> <20190819163546.915-1-khorenko@virtuozzo.com>
 <CADvTj4rVS-wJy1B=dgEO1AOADNYgL3XkZ01Aq=RTfPGEZC+VMA@mail.gmail.com>
 <ffdb2223-eed3-75b4-a003-4e4c96b49947@grossegger.com> <yq135kacnny.fsf@ca-mkp.ca.oracle.com>
 <CADvTj4qfPhEKy2V0crGs+Hc_fq=P5OKWFohG9QbTHK3i+GWc=Q@mail.gmail.com>
 <106f384f-d9e2-905d-5ac5-fe4ffd962122@virtuozzo.com> <CADvTj4rd+Z8S8vwnsmn2a7BXDPBwx1iqWRmE+SbtWep=Lnr20g@mail.gmail.com>
 <BYAPR11MB36066925274C38555F20FB17FA339@BYAPR11MB3606.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB36066925274C38555F20FB17FA339@BYAPR11MB3606.namprd11.prod.outlook.com>
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Sun, 13 Nov 2022 14:42:59 -0400
Message-ID: <CADvTj4qH5xuK9ecEPi3Pm9t962E=nnH0oTBqWv4UPmibeASqdQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/1] aacraid: Host adapter Adaptec 6405 constantly
 resets under high io load
To:     Sagar.Biradar@microchip.com
Cc:     martin.petersen@oracle.com, khorenko@virtuozzo.com,
        christian@grossegger.com, aacraid@microsemi.com,
        Don.Brace@microchip.com, Tom.White@microchip.com,
        linux-scsi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 1:17 PM <Sagar.Biradar@microchip.com> wrote:
>
> Hi James and Konstantin,
>
> *Limiting the audience to avoid spamming*
>
> Sorry for delayed response as I was on vacation.
> This one got missed somehow as someone else was looking into this and is =
no longer with the company.
>
> I will look into this, meanwhile I wanted to check if you (or someone els=
e you know) had a chance to test this thoroughly with the latest kernel?
> I will get back to you with some more questions or the confirmation in a =
day or two max.

Did this ever get looked at?

As this exact patch was merged into the vendor aacraid a while ago I'm not =
sure
why it wouldn't be good to merge to mainline as well.

Vendor aacraid release with this patch merged:
https://download.adaptec.com/raid/aac/linux/aacraid-linux-src-1.2.1-60001.t=
gz

>
>
> Thanks for your patience.
> Sagar
>
>
> -----Original Message-----
> From: James Hilliard <james.hilliard1@gmail.com>
> Sent: Thursday, October 27, 2022 1:40 AM
> To: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: Konstantin Khorenko <khorenko@virtuozzo.com>; Christian Gro=C3=9Fegge=
r <christian@grossegger.com>; linux-scsi@vger.kernel.org; Adaptec OEM Raid =
Solutions <aacraid@microsemi.com>; Sagar Biradar - C34249 <Sagar.Biradar@mi=
crochip.com>; Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; Don=
 Brace - C33706 <Don.Brace@microchip.com>
> Subject: Re: [PATCH v3 0/1] aacraid: Host adapter Adaptec 6405 constantly=
 resets under high io load
>
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>
> On Wed, Oct 19, 2022 at 2:03 PM Konstantin Khorenko <khorenko@virtuozzo.c=
om> wrote:
> >
> > On 10.10.2022 14:31, James Hilliard wrote:
> > > On Tue, Feb 22, 2022 at 10:41 PM Martin K. Petersen
> > > <martin.petersen@oracle.com> wrote:
> > >>
> > >>
> > >> Christian,
> > >>
> > >>> The faulty patch (Commit: 395e5df79a9588abf) from 2017 should be
> > >>> repaired with Konstantin Khorenko (1):
> > >>>
> > >>>    scsi: aacraid: resurrect correct arc ctrl checks for Series-6
> > >>
> > >> It would be great to get this patch resubmitted by Konstantin and
> > >> acked by Microchip.
>
> Can we merge this as is since microchip does not appear to be maintaining=
 this driver any more or responding?
>
> > >
> > > Does the patch need to be rebased?
> >
> > James, i have just checked - the old patch (v3) applies cleanly onto la=
test master branch.
> >
> > > Based on this it looks like someone at microchip may have already rev=
iewed:
> > > v3 changes:
> > >   * introduced another wrapper to check for devices except for Series=
 6
> > >     controllers upon request from Sagar Biradar (Microchip)
> >
> > Well, back in the year 2019 i've created a bug in RedHat bugzilla
> > https://bugzilla.redhat.com/show_bug.cgi?id=3D1724077
> > (the bug is private, this is default for Redhat bugs)
> >
> > In this bug Sagar Biradar (with the email @microchip.com) suggested me
> > to rework the patch - i've done that and sent the v3.
> >
> > And nothing happened after that, but in a ~year (2020-06-19) the bug
> > was closed with the resolution NOTABUG and a comment that S6 users will=
 find the patch useful.
> >
> > i suppose S6 is so old that RedHat just does not have customers using
> > it and Microchip company itself is also not that interested in handling=
 so old hardware issues.
> >
> > Sorry, i was unable to get a final ack from Microchip, i've written
> > direct emails to the addresses which is found in the internet, tried
> > to connect via linkedin, no luck.
> >
> > --
> > Konstantin Khorenko
