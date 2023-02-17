Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A7869A526
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 06:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjBQFhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 00:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjBQFhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 00:37:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EFB5BD8A
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 21:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676612173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q8y4UETkQqs5POhMp8MHo+VmSRaMVJi1lvssc8jHWBA=;
        b=BWpbnEBe7IuTMP51Y7Hg74axvTGkD5h0WY/sb1gpjZbgp6Gl+6nQijcNOuxKRT3m9I4tEA
        S6fstCzhmQ3CNTEz+9j0nH7R9E3fRjPTF+MFXuFnYIGyHe/vgo0R3tF2Syf2vEyVt6sopP
        hhA0i5Fn1kfvmKCiuu7JMO3+q59ub2A=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-260-PAKVtZNTPY--fKlWDsleGQ-1; Fri, 17 Feb 2023 00:36:11 -0500
X-MC-Unique: PAKVtZNTPY--fKlWDsleGQ-1
Received: by mail-oi1-f199.google.com with SMTP id e11-20020a056808148b00b0037fa06d71cfso932376oiw.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 21:36:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q8y4UETkQqs5POhMp8MHo+VmSRaMVJi1lvssc8jHWBA=;
        b=SHSRQcpsXF3crYdihP1Alp6+MkFmE35jlVdeby3rkkXVrD+6tRdSOL7c7ADaIq1Kh1
         XfS0tjMW5kwRcu0dsM+rK5QpSYIN+FeMK5lHl5xkMDyPByntqmeUe18A+eTrH7M+I6sl
         SJ/q/4DLKaCpv5DhF2LXzjyNS2Mf4tCk+izVKQhJAmeHYvAxHkUngDzUrHDow7pVoiVA
         1wPyufCmIwqVMomm1xOjuNESIuhTAuUjg+aXaG40Qnm944rFXzMXeBbI5MMMX2Ade01p
         UZLwIvOZjzAykXHk2R3oEfYTO6JzrWb8ejI9DH1S8OmtczHQJtkA4DNzRoutYsTOxNnr
         wjOg==
X-Gm-Message-State: AO0yUKXeNogA/bA0CHXEjvwutli1HaasiVlvgxfiqKkszaDbIxqQAVbJ
        6SqEhQcZ0ouLMt5y4TgWaw6RMEpY9fsdCZf3VY0gj2k2Pdf0xvM3kOeK/RYvSITRsQ8EUJ5vD3r
        QK6NVV7CnUzEpWOCtMA1wBwMuTdApwKeD+Acp1wjq
X-Received: by 2002:a05:6808:3186:b0:37d:5d77:e444 with SMTP id cd6-20020a056808318600b0037d5d77e444mr296392oib.35.1676612170493;
        Thu, 16 Feb 2023 21:36:10 -0800 (PST)
X-Google-Smtp-Source: AK7set+hY95HRDtXDD+GXnz1YrR2uwZRZowpsAyCm1bMt4U0npjM2XW+YfzeYKDUlmV5UD794AQCKMHVcQs7RZ9kgLs=
X-Received: by 2002:a05:6808:3186:b0:37d:5d77:e444 with SMTP id
 cd6-20020a056808318600b0037d5d77e444mr296388oib.35.1676612170318; Thu, 16 Feb
 2023 21:36:10 -0800 (PST)
MIME-Version: 1.0
References: <20230207120843.1580403-1-sunnanyong@huawei.com> <Y+7G+tiBCjKYnxcZ@nvidia.com>
In-Reply-To: <Y+7G+tiBCjKYnxcZ@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 17 Feb 2023 13:35:59 +0800
Message-ID: <CACGkMEtehykvqNUnfCi0VmHR1xpmhj4sSWdYW1-0oATY=0YhXw@mail.gmail.com>
Subject: Re: [PATCH v2] vhost/vdpa: Add MSI translation tables to iommu for
 software-managed MSI
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Nanyong Sun <sunnanyong@huawei.com>, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, mst@redhat.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, wangrong68@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 8:15 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Tue, Feb 07, 2023 at 08:08:43PM +0800, Nanyong Sun wrote:
> > From: Rong Wang <wangrong68@huawei.com>
> >
> > Once enable iommu domain for one device, the MSI
> > translation tables have to be there for software-managed MSI.
> > Otherwise, platform with software-managed MSI without an
> > irq bypass function, can not get a correct memory write event
> > from pcie, will not get irqs.
> > The solution is to obtain the MSI phy base address from
> > iommu reserved region, and set it to iommu MSI cookie,
> > then translation tables will be created while request irq.
>
> Probably not what anyone wants to hear, but I would prefer we not add
> more uses of this stuff. It looks like we have to get rid of
> iommu_get_msi_cookie() :\
>
> I'd like it if vdpa could move to iommufd not keep copying stuff from
> it..

Yes, but we probably need a patch for -stable.

>
> Also the iommu_group_has_isolated_msi() check is missing on the vdpa
> path, and it is missing the iommu ownership mechanism.

Ok.

>
> Also which in-tree VDPA driver that uses the iommu runs on ARM? Please

ifcvf and vp_vpda are two drivers that use platform IOMMU.

Thanks

> don't propose core changes for unmerged drivers. :(
>
> Jason
>

