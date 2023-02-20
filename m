Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED00A69C434
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 03:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjBTCiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 21:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjBTCiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 21:38:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF6CDBF0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 18:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676860651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z4mF9eRLWUighxaWu/WlNqJCc0pM0J+zyyIk2SE2gxU=;
        b=fPygkbLALlk+6ukzBEvSJLsPhuqYnNPH0N7bl7BG0m0F3E6y+Pfob4gWdaTJz9lCvJobxG
        fLG5thQGVgd5lqzmTEaK+4VJqNjDNVV5AqTmIVNbM6TxWm8X8UXf6x9VIgJMcbcNqKkxoW
        PWh5hg2L2e56X4rdY32ZSAVN2Bs/ppo=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-605-t_GJ7HGgOAKaooSDws2FhA-1; Sun, 19 Feb 2023 21:37:30 -0500
X-MC-Unique: t_GJ7HGgOAKaooSDws2FhA-1
Received: by mail-oi1-f197.google.com with SMTP id a2-20020a056808128200b0037dc3a143bbso159008oiw.9
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 18:37:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z4mF9eRLWUighxaWu/WlNqJCc0pM0J+zyyIk2SE2gxU=;
        b=T6WkgELNKknBkhvIeKxW6BfAYTNUEMURj7NbcYxC6Tg9doL8z4Y5UqXAJ4Eic6PPes
         tUwDr83bRmUxDrUvAQGRmQRTyN4dwm4BFs1dI+nDIDLAoR2rzP/a3WWVwEcoMHKRuli2
         IkGqrNVLGQRtLyz3WTLjJiH7tGj2ECh34+4zS95qBZjBYs0511awexVZ/uM3ARYNQqps
         Qiiqnahxyimea1Py4nuEPcOAaaUFPiTUxdhbEnKEAydh40VLMLJcCB3rmXGmgWH8K+iZ
         E+6roxonM2IBByKXE7+pzo2dHlWUKE+CiLT0AOvPPsZGQ7jQ6WVIMpar4TZje0BQ3bo4
         FiNQ==
X-Gm-Message-State: AO0yUKX0eoOei4a0LP1qVTmAASs6Q50w3NYjPRth76jcjkdhvOnmAa+A
        kObXd+sT87LezGavfqtkx/DTbl3tUVNWHI05vsOoAw2rCqQtBwQUdNUhlLG9Nvo7pH5amjsIINj
        1OlJxiRsx4C8Japvhlm6WlJVnSMPPdrg32K98i6JF
X-Received: by 2002:a05:6870:e309:b0:16a:cfba:d187 with SMTP id z9-20020a056870e30900b0016acfbad187mr57936oad.2.1676860649419;
        Sun, 19 Feb 2023 18:37:29 -0800 (PST)
X-Google-Smtp-Source: AK7set8SJitLQ9LUE3u1syC+o7Uv38TErayt/RAfp5Ui0lrmlYgjeBjytjXtpn+4L/G0i6tLLMj766NjBhCbz614fY0=
X-Received: by 2002:a05:6870:e309:b0:16a:cfba:d187 with SMTP id
 z9-20020a056870e30900b0016acfbad187mr57932oad.2.1676860649055; Sun, 19 Feb
 2023 18:37:29 -0800 (PST)
MIME-Version: 1.0
References: <20230207120843.1580403-1-sunnanyong@huawei.com>
 <Y+7G+tiBCjKYnxcZ@nvidia.com> <20230217051158-mutt-send-email-mst@kernel.org> <Y+92c9us3HVjO2Zq@nvidia.com>
In-Reply-To: <Y+92c9us3HVjO2Zq@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 20 Feb 2023 10:37:18 +0800
Message-ID: <CACGkMEsVBhxtpUFs7TrQzAecO8kK_NR+b1EvD2H7MjJ+2aEKJw@mail.gmail.com>
Subject: Re: [PATCH v2] vhost/vdpa: Add MSI translation tables to iommu for
 software-managed MSI
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Nanyong Sun <sunnanyong@huawei.com>, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        wangrong68@huawei.com, Cindy Lu <lulu@redhat.com>
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

On Fri, Feb 17, 2023 at 8:43 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Fri, Feb 17, 2023 at 05:12:29AM -0500, Michael S. Tsirkin wrote:
> > On Thu, Feb 16, 2023 at 08:14:50PM -0400, Jason Gunthorpe wrote:
> > > On Tue, Feb 07, 2023 at 08:08:43PM +0800, Nanyong Sun wrote:
> > > > From: Rong Wang <wangrong68@huawei.com>
> > > >
> > > > Once enable iommu domain for one device, the MSI
> > > > translation tables have to be there for software-managed MSI.
> > > > Otherwise, platform with software-managed MSI without an
> > > > irq bypass function, can not get a correct memory write event
> > > > from pcie, will not get irqs.
> > > > The solution is to obtain the MSI phy base address from
> > > > iommu reserved region, and set it to iommu MSI cookie,
> > > > then translation tables will be created while request irq.
> > >
> > > Probably not what anyone wants to hear, but I would prefer we not add
> > > more uses of this stuff. It looks like we have to get rid of
> > > iommu_get_msi_cookie() :\
> > >
> > > I'd like it if vdpa could move to iommufd not keep copying stuff from
> > > it..
> >
> > Absolutely but when is that happening?
>
> Don't know, I think it has to come from the VDPA maintainers, Nicolin
> made some drafts but wasn't able to get it beyond that.

Cindy (cced) will carry on the work.

Thanks

>
> Please have people who need more iommu platform enablement to pick it
> up instead of merging hacks like this..
>
> We are very close to having nested translation on ARM so anyone who is
> serious about VDPA on ARM is going to need iommufd anyhow.
>
> Jason
>

