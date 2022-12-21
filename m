Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D8D652C99
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 06:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234409AbiLUF7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 00:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234430AbiLUF7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 00:59:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23B9D96
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 21:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671602329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YqEHm3UzxG6ffY8Bp/o4RuRuWIrmYvg6Ffwy9vsFjIs=;
        b=E3/zItJeJlcXFHx/EdhEM7KW2y0DC86XLbb/1walBUGnTXQllMmMY37QF1+7xZWF2u7sCS
        qooK8sDc8jO9ntlX3ai2m7zlqhF4w6KY0OjYCVjd91w7MIBoCApg4PLq4ZJ0KsekvIp0+Y
        kn404lB6STxXyrxO2IbDEGBpOx9pqtg=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-592-m92HwsDeNLeFk5yZALaiRQ-1; Wed, 21 Dec 2022 00:58:48 -0500
X-MC-Unique: m92HwsDeNLeFk5yZALaiRQ-1
Received: by mail-ot1-f71.google.com with SMTP id m12-20020a9d6acc000000b006707706d25dso8317545otq.22
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 21:58:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YqEHm3UzxG6ffY8Bp/o4RuRuWIrmYvg6Ffwy9vsFjIs=;
        b=ykpQyWLv/sHqTHSXVMtkQ+GbkVTIRYfF+42sW0UUX2lNc+KdytOBgH2RM5QnshOlVE
         atmyV6IUmzgDcOkTao0lPX9XvcIasnsBr3f+hHU4gFYMI0Kg6cN6ZCDdQuQXfttXy8R0
         LLiIsU1gB+N7e1evDlmdhSUbO6euIBUv4MXG4Hyt+Az65aWBxKNNDyMvNcomlmw9xUZI
         NRIayqAwGwHTt5kE9KEZ1p1ocJMz85xHChrAqeMQ9Nh0/GGgN6suOqrgT0Z0VfG0U23H
         vNV6HPgpGTJg655Jnu7jsBN5CQJAm+4T6BpWahSM8EQ4IluXgA7wO3lOHVrDonDby/wH
         vFAA==
X-Gm-Message-State: AFqh2krWuCI2LjL52vesEfL1sHOcnfZQ5k6JxPtWhnkIp/q67THXdR07
        EURlvO3hEY6MkAZKVZwYb2LRs4r86yeHST2PUxVC+TKjTchyMBqOxP+2E+2Ez7EOaYZdkGc1CgY
        EIUr32KJlaBZPVjyzs16nM86zu9ASDtHYZ6GYgjdc
X-Received: by 2002:a05:6870:ac21:b0:144:910f:43ea with SMTP id kw33-20020a056870ac2100b00144910f43eamr23559oab.140.1671602328022;
        Tue, 20 Dec 2022 21:58:48 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsDR9nnF7mnDlflQ/HQ+MgFqmKyqDpmpzDNyhXa+P22bXXqLYMkGFpt1uwqUiJhWJY6UGD9PZR/L2LPB+ouxTY=
X-Received: by 2002:a05:6870:ac21:b0:144:910f:43ea with SMTP id
 kw33-20020a056870ac2100b00144910f43eamr23554oab.140.1671602327855; Tue, 20
 Dec 2022 21:58:47 -0800 (PST)
MIME-Version: 1.0
References: <20221220140205.795115-1-lulu@redhat.com> <CACGkMEuJuUrA220XgHDOruK-aHWSfJ6mTaqNVQCAcOsPEwV91A@mail.gmail.com>
In-Reply-To: <CACGkMEuJuUrA220XgHDOruK-aHWSfJ6mTaqNVQCAcOsPEwV91A@mail.gmail.com>
From:   Cindy Lu <lulu@redhat.com>
Date:   Wed, 21 Dec 2022 13:58:11 +0800
Message-ID: <CACLfguUgsWrE+ZFxJYd-h81AvMQFio0-VU9oE0kpj7t5D2pJvg@mail.gmail.com>
Subject: Re: [PATCH] vhost_vdpa: fix the compile issue in commit 881ac7d2314f
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Dec 2022 at 11:23, Jason Wang <jasowang@redhat.com> wrote:
>
> On Tue, Dec 20, 2022 at 10:02 PM Cindy Lu <lulu@redhat.com> wrote:
> >
> > The input of  vhost_vdpa_iotlb_unmap() was changed in 881ac7d2314f,
> > But some function was not changed while calling this function.
> > Add this change
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 881ac7d2314f ("vhost_vdpa: fix the crash in unmap a large memory")
>
> Is this commit merged into Linus tree?
>
> Btw, Michael, I'd expect there's a respin of the patch so maybe Cindy
> can squash the fix into the new version?
>
> Thanks
>
This is not merged in linus tree, and this compile issue was hit in mst's tree
should I send a new version squash the patch and the fix?

Thanks
Cindy
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vhost/vdpa.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > index 46ce35bea705..ec32f785dfde 100644
> > --- a/drivers/vhost/vdpa.c
> > +++ b/drivers/vhost/vdpa.c
> > @@ -66,8 +66,8 @@ static DEFINE_IDA(vhost_vdpa_ida);
> >  static dev_t vhost_vdpa_major;
> >
> >  static void vhost_vdpa_iotlb_unmap(struct vhost_vdpa *v,
> > -                                  struct vhost_iotlb *iotlb,
> > -                                  u64 start, u64 last);
> > +                                  struct vhost_iotlb *iotlb, u64 start,
> > +                                  u64 last, u32 asid);
> >
> >  static inline u32 iotlb_to_asid(struct vhost_iotlb *iotlb)
> >  {
> > @@ -139,7 +139,7 @@ static int vhost_vdpa_remove_as(struct vhost_vdpa *v, u32 asid)
> >                 return -EINVAL;
> >
> >         hlist_del(&as->hash_link);
> > -       vhost_vdpa_iotlb_unmap(v, &as->iotlb, 0ULL, 0ULL - 1);
> > +       vhost_vdpa_iotlb_unmap(v, &as->iotlb, 0ULL, 0ULL - 1, asid);
> >         kfree(as);
> >
> >         return 0;
> > --
> > 2.34.3
> >
>

