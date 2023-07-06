Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0816174972B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 10:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbjGFIOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 04:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGFION (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 04:14:13 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330D31982
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 01:14:11 -0700 (PDT)
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 64BAE3F205
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 08:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1688631248;
        bh=7HSYp1icG+guqeU+FJYsU4fa4qwz2KYF1jp5j0Ry53A=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=ugAHKkGVza55YQSIromYzK/jDa6tYo96wMw/8i7/TPzXk6jqZ0Iu6xBoocheYWOqg
         7873ac0pz4H3uTv08F1RK7COcD9FFRKYB5Y34NRCeNB4dC0m9lqII/Nl/lwY/bf7kR
         YP8/ZbuLJPsYcMH9vORx7ejNp5ImTMMTiN7TiZp6tsW28QAGudYwi2++XALEuzvc0z
         b2fIACBAQhMESk3F6RpCTBPcA+l9fTnUGzRm2t8LfZ16gUzJ5gx5T9aDjgzbp7BqsF
         6vl/V86zgkOt9FW5eaAbsoZr2b329AsGhPGemzrbZFQiF4kwx3tqcOFkaGLwsnCLQb
         dXWhx60eMfiGw==
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-666e3dad70aso826759b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 01:14:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688631247; x=1691223247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7HSYp1icG+guqeU+FJYsU4fa4qwz2KYF1jp5j0Ry53A=;
        b=jTKHJ3Qjw9aK1m3do41gxavup5ddrRrRNcmPJ2ThXhjVtqnhnmrYq9uw7vH2ZijIUG
         rW8LfCbOHs17nan4JZwLnIjY9tLK9G27/5A/8Eoq7zNaLkhBfeanE9eHhSh5usyT29yJ
         UUptZz+ipIUkrwzLV4Yo6fJvdB0zik8WcLvbyKsukUFYJHKdovwAULwQDq349iwp4nFP
         wuoSEHIMoxV7j0Uwskld/1GvfSQ8EaRw7CPbkEXmf7T1qM4HqBMNbTqlo2F36hexvta6
         tnZ7yvdmiEDM25MmFeEJW1ZJZxmesRPkx+RSkFeKeFlioo8wGhytJq+GqpClC6yrlNxG
         fMVQ==
X-Gm-Message-State: ABy/qLbpML1AJiCZESSvVeJFNXRZ5r/aegzm4n5dJf2kN0dA8E0xRBYv
        BjdOOPhlZOdRn9KAAPOLV7Dgpuv/E6WprdkMwVAQX4bNngh+7j7kYDj8XLdDec1ZHUtH9hFjtMo
        VvnND/yCLAWnc//9KflFLREgnVR7Blwq68Kq/BTyBm84CdmxaI0k5OfnRNw==
X-Received: by 2002:a05:6a20:7484:b0:11f:33da:56ec with SMTP id p4-20020a056a20748400b0011f33da56ecmr1160248pzd.27.1688631247020;
        Thu, 06 Jul 2023 01:14:07 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF95ylLuO9tMs5+hripSwj2rqR9msxTCudrpIm4KNPOB7It6fu0srnyBvU7aXSE34l+pb0V6g1vX6qIhO02+bY=
X-Received: by 2002:a05:6a20:7484:b0:11f:33da:56ec with SMTP id
 p4-20020a056a20748400b0011f33da56ecmr1160236pzd.27.1688631246691; Thu, 06 Jul
 2023 01:14:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230704074506.2304939-1-kai.heng.feng@canonical.com> <CAJZ5v0jwO1NJ_x2t3RV-kYDmVY9UtyexznCSZMAmQ-gK4dWCmA@mail.gmail.com>
In-Reply-To: <CAJZ5v0jwO1NJ_x2t3RV-kYDmVY9UtyexznCSZMAmQ-gK4dWCmA@mail.gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 6 Jul 2023 16:13:55 +0800
Message-ID: <CAAd53p4vUkmvgAa8JgxzSNS1F0EVWYQxTBPOoRS+bQscDEc_nA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: video: Invoke _PS0 at boot for ACPI video
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 5, 2023 at 12:59=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Tue, Jul 4, 2023 at 9:46=E2=80=AFAM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
> >
> > Screen brightness can only be changed once on some HP laptops.
> >
> > Vendor identified the root cause as Linux doesn't invoke _PS0 at boot
> > for all ACPI devices:
>
> This part of the changelog is confusing, because the evaluation of
> _PS0 is not a separate operation.  _PS0 gets evaluated when devices
> undergo transitions from low-power states to D0.

But not at boot.

>
> >     Scope (\_SB.PC00.GFX0)
> >     {
> >         Scope (DD1F)
> >         {
> >             Method (_PS0, 0, Serialized)  // _PS0: Power State 0
> >             {
> >                 If (CondRefOf (\_SB.PC00.LPCB.EC0.SSBC))
> >                 {
> >                     \_SB.PC00.LPCB.EC0.SSBC ()
> >                 }
> >             }
> >             ...
> >         }
> >         ...
> >     }
> >
> > _PS0 doesn't get invoked for all ACPI devices because of commit
> > 7cd8407d53ef ("ACPI / PM: Do not execute _PS0 for devices without _PSC
> > during initialization").
>
> And yes, Linux doesn't put all of the ACPI devices into D0 during
> initialization, but the above commit has a little to do with that.

Devices without _PSC now doesn't have _PS0 evaluated at boot time. I
don't quite understand why it's not related to this commit?

>
> > For now explicitly call _PS0 for ACPI video to workaround the issue.
>
> This is not what the patch is doing.

To be specific, it's for the child device nodes under ACPI GFX.

Kai-Heng

>
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >  drivers/acpi/acpi_video.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> > index 62f4364e4460..793259bd18c8 100644
> > --- a/drivers/acpi/acpi_video.c
> > +++ b/drivers/acpi/acpi_video.c
> > @@ -2027,6 +2027,8 @@ static int acpi_video_bus_add(struct acpi_device =
*device)
> >         if (error)
> >                 goto err_put_video;
> >
> > +       acpi_device_fix_up_power_extended(device);
> > +
>
> I would like to know what Hans thinks about this.
>
> >         pr_info("%s [%s] (multi-head: %s  rom: %s  post: %s)\n",
> >                ACPI_VIDEO_DEVICE_NAME, acpi_device_bid(device),
> >                video->flags.multihead ? "yes" : "no",
> > --
