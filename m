Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E993A6C5D64
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 04:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjCWDpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 23:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjCWDpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 23:45:11 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE562BF20;
        Wed, 22 Mar 2023 20:45:07 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id u38so7575508pfg.10;
        Wed, 22 Mar 2023 20:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679543107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I171lXLGYV7u+3rjBTP4CGRLJzbcrLM+Iqv+gS6+BCY=;
        b=UHmSP/BABiNrDs8XARQZV9iEOWMitcUws55M1qHqpkGa6OSQniJHlHhrxyNZWnwPCK
         Lf0dO7yD181b1KnNAznzZQ0y70lceC1yNpzKUOQbEUvZHwkYu7GmC/ukouxWpW7pH3IW
         79xpYXjKunNyHFBvVi7wLZYR35kiFX0Ss+XsunBTkVMw4/+BKpN/G9Z02XpcsAq6mbQ2
         MLwPJLWoBjCsnOkljUuA+WgHq5wC1d2j/VEd4nSp4DWt75Y5FiAfkL8bzOUxA/DpHJHC
         UZ0UvmHvrK4hggoEa7DCr+LdTbgw9VodsjeNdy9WW1B3JtkRxIKxvu9j/GGMgIP+aAnQ
         YdCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679543107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I171lXLGYV7u+3rjBTP4CGRLJzbcrLM+Iqv+gS6+BCY=;
        b=oY3tJF6n4JAY+SuyzP5xayNhoxSJhXK+xCIBnNbfpr7ynVYYrrRO1VMEw69j6xhN8s
         ZJsIiNeyZPEmOY2VBdE5BbfBtsm8ifgzaiHtt3n+ZNoCgVMgaYHSJ6tIOIrwCp6pzyaG
         Y+QuDFLMjNe8fqO81FnWuZAeCMmUKVDNZI83UETL0GOW5BEDLSUPpHvAsaeyzTGdagrk
         hz6h9WwxPC4EM4q8mn9Vfq8wWiNPZkkO0iTbAmPl0G2dS16w6ORJL03J1+l9GItxNXXT
         0U0NhOGWpOdHiE8wT+knxSD+V+m6oaTHqjpVrdCa/cJ3CePqOCYwSx/uUvEWUehiAtqi
         WYcQ==
X-Gm-Message-State: AO0yUKUn9vsaCT2+UMG9ds5Awg6xR7WoR5MRpupGXG8q5/BtyaOXM83U
        TL522szRASBVPFdcAEEVUKm8fhLw5nnB4nQB/cK4Hl4R8hiPhA==
X-Google-Smtp-Source: AK7set8LBM3NDTE5mvbAatbdWrnRFRcIvbUYrKwrKgfB+VNwaPkpFLw0JA+urDEGtjTVHJiTWyYPS88+034/M6z7LMY=
X-Received: by 2002:a05:6a00:9a9:b0:625:563e:7d17 with SMTP id
 u41-20020a056a0009a900b00625563e7d17mr3332605pfg.0.1679543106787; Wed, 22 Mar
 2023 20:45:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230318081303.792969-1-zyytlz.wz@163.com> <bce4f9d8-e4b9-39e6-4534-34b7dc7d43ac@oracle.com>
In-Reply-To: <bce4f9d8-e4b9-39e6-4534-34b7dc7d43ac@oracle.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Thu, 23 Mar 2023 11:44:54 +0800
Message-ID: <CAJedcCx9s9HSbJEEb_RUmW7yjSMkYaoXhuH9qrqYo1smpL=iJw@mail.gmail.com>
Subject: Re: [PATCH RESEND] scsi: qedi: Fix use after free bug in qedi_remove
 due to race condition
To:     Mike Christie <michael.christie@oracle.com>
Cc:     Zheng Wang <zyytlz.wz@163.com>, njavali@marvell.com,
        mrangankar@marvell.com, GR-QLogic-Storage-Upstream@marvell.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        1395428693sheep@gmail.com, alex000young@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Christie <michael.christie@oracle.com> =E4=BA=8E2023=E5=B9=B43=E6=9C=
=8821=E6=97=A5=E5=91=A8=E4=BA=8C 00:11=E5=86=99=E9=81=93=EF=BC=9A
>
> On 3/18/23 3:13 AM, Zheng Wang wrote:
> > In qedi_probe, it calls __qedi_probe, which bound &qedi->recovery_work
> > with qedi_recovery_handler and bound &qedi->board_disable_work
> > with qedi_board_disable_work.
> >
> > When it calls qedi_schedule_recovery_handler, it will finally
> > call schedule_delayed_work to start the work.
> >
> > When we call qedi_remove to remove the driver, there
> > may be a sequence as follows:
> >
> > Fix it by finishing the work before cleanup in qedi_remove.
> >
> > CPU0                  CPU1
> >
> >                      |qedi_recovery_handler
> > qedi_remove          |
> >   __qedi_remove      |
> > iscsi_host_free      |
> > scsi_host_put        |
> > //free shost         |
> >                      |iscsi_host_for_each_session
> >                      |//use qedi->shost
> >
> > Fixes: 4b1068f5d74b ("scsi: qedi: Add MFW error recovery process")
> > Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> > ---
> >  drivers/scsi/qedi/qedi_main.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/scsi/qedi/qedi_main.c b/drivers/scsi/qedi/qedi_mai=
n.c
> > index f2ee49756df8..25223f6f5344 100644
> > --- a/drivers/scsi/qedi/qedi_main.c
> > +++ b/drivers/scsi/qedi/qedi_main.c
> > @@ -2414,6 +2414,10 @@ static void __qedi_remove(struct pci_dev *pdev, =
int mode)
> >       int rval;
> >       u16 retry =3D 10;
> >
> > +     /*cancel work*/
>
> This comment is not needed. The name of the functions you are calling hav=
e
> "cancel" and "work" in them so we know. If you want to add a comment expl=
ain
> why the cancel calls are needed here.
>

Hi,

Sorry for my late reply and thanks for your advice. Will remove it in
the next version of patch.

>
> > +     cancel_delayed_work_sync(&qedi->recovery_work);
> > +     cancel_delayed_work_sync(&qedi->board_disable_work);
>
>
> How do you know after you have called cancel_delayed_work_sync that
> schedule_recovery_handler or schedule_hw_err_handler can't be called?
> I don't know the qed driver well, but it looks like you could have
> operations still running, so after you cancel here one of those ops
> could lead to them scheduling the work again.
>

Sorry I didn't know how to make sure there's no more schedule. But I do thi=
nk
this is important. Maybe there're someone else who can give us advice.

Best regards,
Zheng
>
> > +
> >       if (mode =3D=3D QEDI_MODE_NORMAL)
> >               iscsi_host_remove(qedi->shost, false);
> >       else if (mode =3D=3D QEDI_MODE_SHUTDOWN)
>
