Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594E769A8ED
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 11:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjBQKN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 05:13:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjBQKNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 05:13:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197C162FD0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 02:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676628757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7Y7MkPKxQ4b4S+E2uuEcl4fSWKwkp7IBI4B2vVLi24A=;
        b=ClxYJ0hn4Jr7aQog7ltNWg76fmRK3NOEJcdlPIUCrT/eKgm/RZhIgVxlnDvJ6LPyBg8ntL
        ksIYg6CX1U9lbF5oc5QZMsjJ9PfeDRQkVpWQTY+LVaHOxx0b1S910LUrvuYiopCwUSLPRp
        W2bpWxpRBZiHp8Snb9sY+6Cz35DhpcQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-574-ZIT48nMvMvKl4M9NKzLx3w-1; Fri, 17 Feb 2023 05:12:36 -0500
X-MC-Unique: ZIT48nMvMvKl4M9NKzLx3w-1
Received: by mail-wm1-f70.google.com with SMTP id o20-20020a05600c511400b003dd07ce79c8so403431wms.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 02:12:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Y7MkPKxQ4b4S+E2uuEcl4fSWKwkp7IBI4B2vVLi24A=;
        b=TfIm2OZzSJjxjzvtmvtoLjl5B4WJFkZ/5NPAEAQMwVHyPEPC4+zeskr4SKxqUsWurD
         9E3+Zu8NDPDYzi9wK2jLkSt3C1hBU/PPFnY4AYC2mWR39K9XKGA+4Xjh0LjFMA88USQO
         q0bOTEgqk0n7g2qV6OOsWv7kt+aAQAm0RqznWhC3HRpydHUIMFVftOu+oDDWfX5p+xh9
         62keEz8cXOgFsjDd0ZmP0c9/CiadcbvXF/Tzux2uQajeZNtP0Shbbsn6JVZS5w/3HIY2
         6MmC1Xf11O4dskE6f9GcFBNBpNpPIgOig8++pwnmQuK1xz2CbXg1DyEcQGUp0SxXqNO5
         mKvg==
X-Gm-Message-State: AO0yUKU6IAAwVm7avSrRZ09HD+FeuR1ZFoVWksyaiiYAIZ86VUeRbgI0
        +lP19ik94IL2JJmtzyZo6o/kwV+ek0nlAL0ZoPIfjI05B/JxNE1XGHcob3XrTNB4Ba0qOw1onEb
        OSHEI2AJX88peRIl5oD+1IX2Z
X-Received: by 2002:adf:f40b:0:b0:2c5:5ff8:93e5 with SMTP id g11-20020adff40b000000b002c55ff893e5mr6717184wro.44.1676628755108;
        Fri, 17 Feb 2023 02:12:35 -0800 (PST)
X-Google-Smtp-Source: AK7set9h4wA736ZeMYva3jBcgfzObA1Ee5DxMQNCqSjLJtJ9uB6fqQFZuR5r1/3OYbU7YpGJ6GX0bQ==
X-Received: by 2002:adf:f40b:0:b0:2c5:5ff8:93e5 with SMTP id g11-20020adff40b000000b002c55ff893e5mr6717163wro.44.1676628754834;
        Fri, 17 Feb 2023 02:12:34 -0800 (PST)
Received: from redhat.com ([2.52.5.34])
        by smtp.gmail.com with ESMTPSA id i3-20020a05600011c300b002c4061a687bsm3720864wrx.31.2023.02.17.02.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 02:12:34 -0800 (PST)
Date:   Fri, 17 Feb 2023 05:12:29 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Nanyong Sun <sunnanyong@huawei.com>, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, jasowang@redhat.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, wangrong68@huawei.com
Subject: Re: [PATCH v2] vhost/vdpa: Add MSI translation tables to iommu for
 software-managed MSI
Message-ID: <20230217051158-mutt-send-email-mst@kernel.org>
References: <20230207120843.1580403-1-sunnanyong@huawei.com>
 <Y+7G+tiBCjKYnxcZ@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+7G+tiBCjKYnxcZ@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 08:14:50PM -0400, Jason Gunthorpe wrote:
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

Absolutely but when is that happening?

> Also the iommu_group_has_isolated_msi() check is missing on the vdpa
> path, and it is missing the iommu ownership mechanism.
> 
> Also which in-tree VDPA driver that uses the iommu runs on ARM? Please
> don't propose core changes for unmerged drivers. :(
> 
> Jason

