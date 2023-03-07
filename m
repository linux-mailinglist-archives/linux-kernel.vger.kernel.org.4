Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D1F6AD636
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 05:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjCGEZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 23:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjCGEZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 23:25:12 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7734236FCD
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 20:25:10 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id x34so12075272pjj.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 20:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678163110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3KTnrnv3dHcE3f0vIugluw/FAEArmhiZErhNRUYdOI=;
        b=JCWbMWcIe94/eoDecPbu1BSXlFXilW6amLFsklUPmQfAy/SwqTxb1QanUFqSIl2TAR
         EU0u5XyNa+1Hz0GdSMbJ0GVogKlTZFEpE57kMF8EwDLy8Zj/npvjsFvQ/x0PNvFojBwQ
         GwGFFSbBPJhVf/N0JGfDPrqxPKF5Nc/UmzhpSTaUXtD38mNfjZCS0GrNTvW9ir45VRT7
         9Ekdlhmq8TJT26P2w/ttNMjzQ36qQrVH5tnc8uwVhIlJlYwlxm8PNJ3FAUpQ3qpd2/yG
         Tgn19JQ/4g9wJbu1FlRumOn/U190Eb2sDneZq2y3moRHGAUunK+c9CnJDkZKtxhHJ4pt
         6kNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678163110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s3KTnrnv3dHcE3f0vIugluw/FAEArmhiZErhNRUYdOI=;
        b=3X2JfcirdnsMHyVg2QRBpg+YnWLQAJEGOcSN6jEo0IEwgOQL9B0msIwYEhv4XM2617
         xqVXPDud5XrE+Pq/gHcyJRLj+btDrvd0u0+mfNukDOLwGkYZxV4bgCFGToJSWN/9h8Cq
         YXBTu7+5pLza6L1l+5PZ5mu9Y98EzmmwhcNOPjlytyuVZfVY/xRx9dQmS1PE/O1kxvX8
         Jjri5JoHI+SDr7yMXa2AmafP56XAnot3IYgief1mq25TGB3LwHXPMNHGLsGWO75mWBUi
         oumk/MqhLDt57JShBFUqMsuJ3agT2yFajwHLmSI5ZfObgefnHQc81t90a2mxcUtXhCSr
         9e8A==
X-Gm-Message-State: AO0yUKVDD8E5XbZ3MPYkNS8g4YWHHsS5IBesuWk4hGLRzc3QHRrxSkVZ
        D1iXIzRmRJsz9ajD7UhiJCWtqd6zdmDXdl+o73g=
X-Google-Smtp-Source: AK7set/16SayqVO0T/l1KqHu4xJ95/iM0Gu0PLByPiWI+Ia6I+98f3uYrMX2bHVwAw8aLBcT0g1wTIC1OH0pVtPqSCc=
X-Received: by 2002:a17:902:ef92:b0:19a:8259:c754 with SMTP id
 iz18-20020a170902ef9200b0019a8259c754mr5099471plb.0.1678163109892; Mon, 06
 Mar 2023 20:25:09 -0800 (PST)
MIME-Version: 1.0
References: <20221029074654.203153-1-zyytlz.wz@163.com> <5882bd80983ac04a32676f07622cba7d0e245e55.camel@redhat.com>
In-Reply-To: <5882bd80983ac04a32676f07622cba7d0e245e55.camel@redhat.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Tue, 7 Mar 2023 12:24:58 +0800
Message-ID: <CAJedcCxmnnrVsq6TtyNPp1v7yv6hszbWnRub8V=ZNFA7OaFa=g@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/mmu: fix use-after-free bug in nvkm_vmm_pfn_map
To:     Lyude Paul <lyude@redhat.com>
Cc:     Zheng Wang <zyytlz.wz@163.com>, nouveau@lists.freedesktop.org,
        bskeggs@redhat.com, kherbst@redhat.com, airlied@gmail.com,
        alex000young@gmail.com, security@kernel.org, daniel@ffwll.ch,
        Julia.Lawall@inria.fr, linux-kernel@vger.kernel.org
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

Hi,

This bug has been proved to be a false positive. So there is no need
to make the patch.

Thanks,
Zheng

Lyude Paul <lyude@redhat.com> =E4=BA=8E2023=E5=B9=B43=E6=9C=887=E6=97=A5=E5=
=91=A8=E4=BA=8C 08:11=E5=86=99=E9=81=93=EF=BC=9A
>
> Actually - could you resend this with dri-devel@lists.freedesktop.org add=
ed to
> the cc list just to make patchwork happy?
>
> On Sat, 2022-10-29 at 15:46 +0800, Zheng Wang wrote:
> > If it failed in kzalloc, vma will be freed in nvkm_vmm_node_merge.
> > The later use of vma will casue use after free.
> >
> > Reported-by: Zheng Wang <hackerzheng666@gmail.com>
> > Reported-by: Zhuorao Yang <alex000young@gmail.com>
> >
> > Fix it by returning to upper caller as soon as error occurs.
> >
> > Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> > ---
> >  drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c b/drivers/gp=
u/drm/nouveau/nvkm/subdev/mmu/vmm.c
> > index ae793f400ba1..04befd28f80b 100644
> > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
> > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
> > @@ -1272,8 +1272,7 @@ nvkm_vmm_pfn_map(struct nvkm_vmm *vmm, u8 shift, =
u64 addr, u64 size, u64 *pfn)
> >                                                      page -
> >                                                      vmm->func->page, m=
ap);
> >                       if (WARN_ON(!tmp)) {
> > -                             ret =3D -ENOMEM;
> > -                             goto next;
> > +                             return -ENOMEM;
> >                       }
> >
> >                       if ((tmp->mapped =3D map))
>
> --
> Cheers,
>  Lyude Paul (she/her)
>  Software Engineer at Red Hat
>
