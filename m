Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8D57481B9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 12:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjGEKGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 06:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbjGEKGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 06:06:33 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F551721;
        Wed,  5 Jul 2023 03:06:31 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3094910b150so7348921f8f.0;
        Wed, 05 Jul 2023 03:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688551590; x=1691143590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3JC4cty1h4LTg6PGf3ujnUkUmH9YwB9xkDx2TdcaDU=;
        b=oFDxPINMeMo768O4RoGp0X3SXwj+nclnUke7CK99XwYmR7cWNt8Iuv/JtFeYo9d2XY
         HUUFP6Snx1bvQq6nzREYQjOCgD2DZ4r3fJ9UJRx4OGYaCZpAN/cOQV3zDiZ5OLiPWPIH
         hReFljsfhcR9KvhrYDBivqJTWK91lCA70jwkUDSPtTXNBQfLeHpfgClUe0OKcbmaYyGO
         WXHH6Iwxik1nLJPCXHJbzUUebM/2B8vttbspeGhCORmBXTZb0uCavztZvMychMT+vNLm
         sUA4Zu++AGjw4cWsnetGe/8RhnCTgAu98dSxvA4zG0fk9lYIKUz1UX8g5GC/kd/gvWHw
         xprw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688551590; x=1691143590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V3JC4cty1h4LTg6PGf3ujnUkUmH9YwB9xkDx2TdcaDU=;
        b=b+RXvKDXuIhNRFGEPkpu+NPe8H6y5UZwr8UCEqyle03/UN0JdUX12WBejshgfR2JNv
         X7XolTg2IFnW4ZqI3yvQqlnflb9lItEfj9C4AlbjGurqEYnUbZOnvD3rh5if2CFDi+4w
         fEhT0LafTO/cCHxTHW5fphC2nHeYXzxmEz5bytfK9azxLdmKZPI21ZnkjXH+Guuyn+em
         pV1XDsxpTxVWLCkmcjJRL+Z2hE4x/opP1SEeQ44MK52RcpowjOZ5+lrJ+c/UYoBV5fgk
         bHJcl8wXA/a0jU/G8buLtBCY9Anb3ls56BO2ZSV72KgzWydLQQ65+RAG3eeMbePy5y1Z
         pZmA==
X-Gm-Message-State: ABy/qLbqaMoK78wgRAqwgmN0VHOo5YHdrHXNYVJMBP+XweF1mOnS+sxt
        fr7OTu3kApKpVZ7ZRZ26RPb4zrm4xnYvu2C0MXI=
X-Google-Smtp-Source: APBJJlGMYxG3hjfqW2AhZsyzM1MkdUFDHgqsho7h5KIzH48v4tR8+/SOB+Z58ws2MxVTeRGU0eksFxPZ1QksX0pro/4=
X-Received: by 2002:adf:fac8:0:b0:313:dfb8:b4d0 with SMTP id
 a8-20020adffac8000000b00313dfb8b4d0mr13036538wrs.66.1688551590048; Wed, 05
 Jul 2023 03:06:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230628153010.57705-1-dg573847474@gmail.com> <eb9476ed-8dc3-a7b6-7478-b7fba3d8e33b@hisilicon.com>
In-Reply-To: <eb9476ed-8dc3-a7b6-7478-b7fba3d8e33b@hisilicon.com>
From:   Chengfeng Ye <dg573847474@gmail.com>
Date:   Wed, 5 Jul 2023 18:06:18 +0800
Message-ID: <CAAo+4rXdvk5NKCi84-7M=vBRSq21iV=6KQn2Te8EdEsr8GOTOw@mail.gmail.com>
Subject: Re: [PATCH] scsi: hisi_sas: Fix potential deadlock on &hisi_hba->lock
To:     "chenxiang (M)" <chenxiang66@hisilicon.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the notice!

Yes, removing the lock acquisition inside hisi_sas_port_notify_formed()
can avoid the deadlock problem by the way.

Best Regards,
Chengfeng

chenxiang (M) <chenxiang66@hisilicon.com> =E4=BA=8E2023=E5=B9=B47=E6=9C=884=
=E6=97=A5=E5=91=A8=E4=BA=8C 13:55=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
>
> =E5=9C=A8 2023/6/28 =E6=98=9F=E6=9C=9F=E4=B8=89 23:30, Chengfeng Ye =E5=
=86=99=E9=81=93:
> > As &hisi_hba->lock is acquired by hard irq int_abnormal_v1_hw(),
> > other acquisition of the same lock under process context should
> > disable irq, otherwise deadlock could happen if the
> > irq preempt the execution while the lock is held in process context
> > on the same CPU.
> >
> > [Interrupt]: int_abnormal_v1_hw()
> >      -->/root/linux/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c:1447
> >      -->/root/linux/drivers/scsi/hisi_sas/hisi_sas_main.c:2050
> >      -->/root/linux/drivers/scsi/hisi_sas/hisi_sas_main.c:1079
> >      -->spin_lock_irqsave(&hisi_hba->lock, flags);
> >
> > [Process Context]: hisi_sas_clear_nexus_ha()
> >      -->/root/linux/drivers/scsi/hisi_sas/hisi_sas_main.c:1932
> >      -->/root/linux/drivers/scsi/hisi_sas/hisi_sas_main.c:1135
> >      -->/root/linux/drivers/scsi/hisi_sas/hisi_sas_main.c:1116
> >      -->/root/linux/drivers/scsi/hisi_sas/hisi_sas_main.c:1105
> >      -->/root/linux/drivers/scsi/hisi_sas/hisi_sas_main.c:166
> >      -->spin_lock(&hisi_hba->lock);
> >
> > [Process Context]: hisi_sas_dev_found()
> >      -->/root/linux/drivers/scsi/hisi_sas/hisi_sas_main.c:665
> >      -->spin_lock(&hisi_hba->lock);
> >
> > [Process Context]: hisi_sas_queue_command()
> >      -->/root/linux/drivers/scsi/hisi_sas/hisi_sas_main.c:188
> >      -->spin_lock(&hisi_hba->lock);
> >
> > This flaw was found by an experimental static analysis tool I am
> > developing for irq-related deadlock, which reported the above
> > warning when analyzing the linux kernel 6.4-rc7 release.
> >
> > The tentative patch fix the potential deadlock by spin_lock_irqsave().
>
> Thank you for reporting it.
> But we consider about removing  hisi_hba->lock in function
> hisi_sas_port_notify_formed()
> which is called by int_abnormal_v1_hw(), as we think it is not necessary
> to add hisi_hba->lock in this function.
> So please ignore it and still thank you for pointing out the issue.
>
> Thanks,
> Shawn
>
> >
> > Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
> > ---
> >   drivers/scsi/hisi_sas/hisi_sas_main.c | 17 ++++++++++-------
> >   1 file changed, 10 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_=
sas/hisi_sas_main.c
> > index 412431c901a7..47c5062a732e 100644
> > --- a/drivers/scsi/hisi_sas/hisi_sas_main.c
> > +++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
> > @@ -161,11 +161,12 @@ static void hisi_sas_slot_index_clear(struct hisi=
_hba *hisi_hba, int slot_idx)
> >
> >   static void hisi_sas_slot_index_free(struct hisi_hba *hisi_hba, int s=
lot_idx)
> >   {
> > +     unsigned long flags;
> >       if (hisi_hba->hw->slot_index_alloc ||
> >           slot_idx < HISI_SAS_RESERVED_IPTT) {
> > -             spin_lock(&hisi_hba->lock);
> > +             spin_lock_irqsave(&hisi_hba->lock, flags);
> >               hisi_sas_slot_index_clear(hisi_hba, slot_idx);
> > -             spin_unlock(&hisi_hba->lock);
> > +             spin_unlock_irqrestore(&hisi_hba->lock, flags);
> >       }
> >   }
> >
> > @@ -181,11 +182,12 @@ static int hisi_sas_slot_index_alloc(struct hisi_=
hba *hisi_hba,
> >   {
> >       int index;
> >       void *bitmap =3D hisi_hba->slot_index_tags;
> > +     unsigned long flags;
> >
> >       if (rq)
> >               return rq->tag + HISI_SAS_RESERVED_IPTT;
> >
> > -     spin_lock(&hisi_hba->lock);
> > +     spin_lock_irqsave(&hisi_hba->lock, flags);
> >       index =3D find_next_zero_bit(bitmap, HISI_SAS_RESERVED_IPTT,
> >                                  hisi_hba->last_slot_index + 1);
> >       if (index >=3D HISI_SAS_RESERVED_IPTT) {
> > @@ -193,13 +195,13 @@ static int hisi_sas_slot_index_alloc(struct hisi_=
hba *hisi_hba,
> >                               HISI_SAS_RESERVED_IPTT,
> >                               0);
> >               if (index >=3D HISI_SAS_RESERVED_IPTT) {
> > -                     spin_unlock(&hisi_hba->lock);
> > +                     spin_unlock_irqrestore(&hisi_hba->lock, flags);
> >                       return -SAS_QUEUE_FULL;
> >               }
> >       }
> >       hisi_sas_slot_index_set(hisi_hba, index);
> >       hisi_hba->last_slot_index =3D index;
> > -     spin_unlock(&hisi_hba->lock);
> > +     spin_unlock_irqrestore(&hisi_hba->lock, flags);
> >
> >       return index;
> >   }
> > @@ -658,11 +660,12 @@ static struct hisi_sas_device *hisi_sas_alloc_dev=
(struct domain_device *device)
> >   {
> >       struct hisi_hba *hisi_hba =3D dev_to_hisi_hba(device);
> >       struct hisi_sas_device *sas_dev =3D NULL;
> > +     unsigned long flags;
> >       int last =3D hisi_hba->last_dev_id;
> >       int first =3D (hisi_hba->last_dev_id + 1) % HISI_SAS_MAX_DEVICES;
> >       int i;
> >
> > -     spin_lock(&hisi_hba->lock);
> > +     spin_lock_irqsave(&hisi_hba->lock, flags);
> >       for (i =3D first; i !=3D last; i %=3D HISI_SAS_MAX_DEVICES) {
> >               if (hisi_hba->devices[i].dev_type =3D=3D SAS_PHY_UNUSED) =
{
> >                       int queue =3D i % hisi_hba->queue_count;
> > @@ -682,7 +685,7 @@ static struct hisi_sas_device *hisi_sas_alloc_dev(s=
truct domain_device *device)
> >               i++;
> >       }
> >       hisi_hba->last_dev_id =3D i;
> > -     spin_unlock(&hisi_hba->lock);
> > +     spin_unlock_irqrestore(&hisi_hba->lock, flags);
> >
> >       return sas_dev;
> >   }
>
