Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447CF744835
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 11:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjGAJZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 05:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjGAJZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 05:25:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EBE1986
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 02:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688203453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Eam9D8S2vBmtyoziYyOMxULmlaRFIIksD/jzBqUMocE=;
        b=Bu6IeoxI6QPXmvSt3A1tEEfVnUi4xr9dvtNqQp0za5XfHA8ObKG5bN6nj3ohferY3xN+CW
        YINKVIF5rQBSKdiZYIYwRe6ix2rlDHXxwReNImrc28iTLbFroJNHi+59ui9FdshBi7Dhj/
        Tdg/FFYbguWet880+hw97GR8vpC/I7s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-vECiYR2hNHCS-VYJ_D4gdQ-1; Sat, 01 Jul 2023 05:24:12 -0400
X-MC-Unique: vECiYR2hNHCS-VYJ_D4gdQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-313f3c115eeso1216164f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jul 2023 02:24:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688203450; x=1690795450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eam9D8S2vBmtyoziYyOMxULmlaRFIIksD/jzBqUMocE=;
        b=H/jgYd1D6/SX4TTXiqlVQr3baqzxbJXfdpPnNFmjKUfH5BftRIBeFKgVZbZnosJitD
         9QX8PEywMNxkZg7MP4JmhJLJHrpDmGPOg5U7haPMUwpa6t1ckRW+GHkiMRVdVTu6LCZq
         RFwY7UUu+jLSru8kNc9yx7Cway/5NwupECFLxsFXgW5eax4U6HKY1Op9DMVuKadObnis
         clKzHsd7QmnC0wXGYoOyknuw8ezTfH9mkXJPjnjBJfAR7Av1uZLavPTehvXQECnjk4wm
         IYYyAimVGoGQtopHZamMvHJtP0t6VOeb7kJBcF3Qb58/dwNZS6JuHzsKtZOUJ/r/VAq+
         TfXg==
X-Gm-Message-State: ABy/qLYeRMqG60Z38+0CCNnyNJ0nLzlCAuGkYtFoPFNtWasIZyIpazon
        7d3EPPI9bDJYYiGgzJmk+hdFcCoN6ULjgiOjKpHhwOypc5YRAWfo0lXVrF6FA/xm/JLAAfuC5vL
        HZfKF8q38ViysvGXUH6j59tWkFRlMcr7wsu7Ujcgv5O08rt6wClY=
X-Received: by 2002:adf:db51:0:b0:314:98f:2495 with SMTP id f17-20020adfdb51000000b00314098f2495mr4469388wrj.12.1688203450353;
        Sat, 01 Jul 2023 02:24:10 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGIdkfDOc47sFDmHvOGwO7sKRLp+s5TlQ1vRnFa8KPeI4WqTZSk8JFSJCDQoRIXQtilqW6JCSYyLbGTn5trX7o=
X-Received: by 2002:adf:db51:0:b0:314:98f:2495 with SMTP id
 f17-20020adfdb51000000b00314098f2495mr4469373wrj.12.1688203450037; Sat, 01
 Jul 2023 02:24:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230628065919.54042-1-lulu@redhat.com> <20230628065919.54042-3-lulu@redhat.com>
 <CACGkMEuzrFP96qcFL0M=nGiQ9t57-EzOhZmB3No-8T8pMAWTxw@mail.gmail.com>
In-Reply-To: <CACGkMEuzrFP96qcFL0M=nGiQ9t57-EzOhZmB3No-8T8pMAWTxw@mail.gmail.com>
From:   Cindy Lu <lulu@redhat.com>
Date:   Sat, 1 Jul 2023 17:23:29 +0800
Message-ID: <CACLfguXHpCVuU-X9XZBOsuusELVBQsTa0L5LiJ59BSuiNx=ARg@mail.gmail.com>
Subject: Re: [RFC 2/4] vduse: Add file operation for mmap
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, maxime.coquelin@redhat.com,
        xieyongji@bytedance.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 4:08=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Wed, Jun 28, 2023 at 2:59=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > From: Your Name <you@example.com>
> >
> > Add the operation for mmap, The user space APP will
> > use this function to map the pages to userspace
>
> Please be specific in the log. E.g why and what the main goal for this mm=
ap.
>
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 49 ++++++++++++++++++++++++++++++
> >  1 file changed, 49 insertions(+)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index f845dc46b1db..1b833bf0ae37 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -1313,6 +1313,54 @@ static struct vduse_dev *vduse_dev_get_from_mino=
r(int minor)
> >         return dev;
> >  }
> >
> > +
> > +static vm_fault_t vduse_vm_fault(struct vm_fault *vmf)
> > +{
> > +       struct vduse_dev *dev =3D vmf->vma->vm_file->private_data;
> > +       struct vm_area_struct *vma =3D vmf->vma;
> > +       u16 index =3D vma->vm_pgoff;
> > +
> > +       struct vdpa_reconnect_info *info;
> > +       info =3D &dev->reconnect_info[index];
> > +
> > +       vma->vm_page_prot =3D pgprot_noncached(vma->vm_page_prot);
> > +       if (remap_pfn_range(vma, vmf->address & PAGE_MASK, PFN_DOWN(inf=
o->addr),
> > +                           PAGE_SIZE, vma->vm_page_prot))
>
> I'm not sure if this can work e.g do we want to use separate pages for
> each virtqueue (I think the answer is yes).
>
yes, this map the separate pages per vq, beads on my test this works
> > +               return VM_FAULT_SIGBUS;
> > +       return VM_FAULT_NOPAGE;
> > +}
> > +
> > +static const struct vm_operations_struct vduse_vm_ops =3D {
> > +       .fault =3D vduse_vm_fault,
> > +};
> > +
> > +static int vduse_mmap(struct file *file, struct vm_area_struct *vma)
> > +{
> > +       struct vduse_dev *dev =3D file->private_data;
> > +       struct vdpa_reconnect_info *info;
> > +       unsigned long index =3D vma->vm_pgoff;
> > +
> > +       if (vma->vm_end - vma->vm_start !=3D PAGE_SIZE)
> > +               return -EINVAL;
> > +       if ((vma->vm_flags & VM_SHARED) =3D=3D 0)
> > +               return -EINVAL;
> > +
> > +       if (index > 65535)
> > +               return -EINVAL;
> > +
> > +       info =3D &dev->reconnect_info[index];
> > +       if (info->addr & (PAGE_SIZE - 1))
> > +               return -EINVAL;
> > +       if (vma->vm_end - vma->vm_start !=3D info->size) {
> > +               return -ENOTSUPP;
> > +       }
>
> How can userspace know the correct size (info->size) here?
>
I had hard code the size in userpace , I will add the new ioctl of get
the map size
Thanks
cindy
> > +
> > +       vm_flags_set(vma, VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDU=
MP);
>
> Why do you need VM_IO, VM_PFNMAP and VM_DONTDUMP here?
>
> Thanks
>
> > +       vma->vm_ops =3D &vduse_vm_ops;
> > +
> > +       return 0;
> > +}
> > +
> >  static int vduse_dev_open(struct inode *inode, struct file *file)
> >  {
> >         int ret;
> > @@ -1345,6 +1393,7 @@ static const struct file_operations vduse_dev_fop=
s =3D {
> >         .unlocked_ioctl =3D vduse_dev_ioctl,
> >         .compat_ioctl   =3D compat_ptr_ioctl,
> >         .llseek         =3D noop_llseek,
> > +       .mmap           =3D vduse_mmap,
> >  };
> >
> >  static struct vduse_dev *vduse_dev_create(void)
> > --
> > 2.34.3
> >
>

