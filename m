Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8BFB6B3949
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 09:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjCJIxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 03:53:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjCJIvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 03:51:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A61F8F37
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 00:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678438203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6KelRWLQTWMjx8GcYyMjPPoMBBlYGGT9NTkc93ApFAc=;
        b=XqOAHipQLKW9/VHDUm/ygnzO0kd8YYeLtdzFTiSmS7WCmlcrAfN0yoGS7A4rubEcCe05cc
        NCRxq0Dqypj9EYnv1HbqCpv5pjHckWUnutRobvSfjuta261VA7vNH42VM5B9V1OSUSqwek
        gh3wgqIK6ymgLVB8hwzAPToGD5sIS90=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-CvD2rb5wPie-uCkFbUxF0w-1; Fri, 10 Mar 2023 03:50:02 -0500
X-MC-Unique: CvD2rb5wPie-uCkFbUxF0w-1
Received: by mail-wr1-f69.google.com with SMTP id bh3-20020a05600005c300b002c70d6e2014so914120wrb.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 00:50:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678438201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6KelRWLQTWMjx8GcYyMjPPoMBBlYGGT9NTkc93ApFAc=;
        b=zihE+jUloyrx4i4sl67v74oPIfFKXFZ8aTHYdZWNUApYQknLYZgCqMoIVZabpIQqyY
         zuc9C+p7dJTvN35xKjG782WPp8vpYR1khlPFCEJvtrOsBZvz2yAM3sqFst1zvgaA6UW/
         k70GxAHGMsYASyrhskOYE+bU6Y0UBj34g6idS6oeBbIKmFKyFIiE+QK1+5obJT0EgaC1
         Y/hcYrIDHxrnfyijbGCwpx1q+JpVSmVXkjMjgVSWfZVKKXcWl/PyFy7PGkI+3/DWaCyj
         KxOCmHOBAMWaoQ0lqvFOqhlbO5DUa90gMWDUirSuVMDXntKu8hi8pseHarglJOXsTbij
         QWTQ==
X-Gm-Message-State: AO0yUKW2ZpPoxpVe84rUsGDgmpAB9AOUojYs2JOzA9dZtXNs8J/bh9NH
        iBsVmtXHjUYdnglBqJKvhSTkCJsK5gEt46E7poFM8j+NhRb/Q9Ye7Hr93ogefARx0/4gRowQccb
        zvDSaudXkb8I6l4yPiks26yBV
X-Received: by 2002:a5d:4892:0:b0:2c9:640f:635b with SMTP id g18-20020a5d4892000000b002c9640f635bmr14163893wrq.56.1678438201021;
        Fri, 10 Mar 2023 00:50:01 -0800 (PST)
X-Google-Smtp-Source: AK7set9d+6elrGhQTW0gxJkTHKMPcUvYTIFaPaPg479KAOvU5rhCWCnoThdgBezbkiwy+Ifg/iNjqg==
X-Received: by 2002:a5d:4892:0:b0:2c9:640f:635b with SMTP id g18-20020a5d4892000000b002c9640f635bmr14163886wrq.56.1678438200746;
        Fri, 10 Mar 2023 00:50:00 -0800 (PST)
Received: from redhat.com ([2.52.9.88])
        by smtp.gmail.com with ESMTPSA id e36-20020a5d5964000000b002c3f81c51b6sm1560093wri.90.2023.03.10.00.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 00:50:00 -0800 (PST)
Date:   Fri, 10 Mar 2023 03:49:56 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     jasowang@redhat.com, tglx@linutronix.de, hch@lst.de,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/11] VDUSE: Improve performance
Message-ID: <20230310034934-mutt-send-email-mst@kernel.org>
References: <20230228094110.37-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230228094110.37-1-xieyongji@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 05:40:59PM +0800, Xie Yongji wrote:
> Hi all,
> 
> This series introduces some ways to improve VDUSE performance.


Pls fix warnings reported by 0-day infra, dropping this for now.


> Patch 1 ~ 6 bring current interrupt affinity spreading mechanism
> to vduse device and make it possible for the virtio-blk driver
> to build the blk-mq queues based on it. This would be useful to
> mitigate the virtqueue lock contention in virtio-blk driver. In
> our test, with those patches, we could get ~50% improvement (600k
> iops -> 900k iops) when using per-cpu virtqueue.
> 
> Patch 7 adds a sysfs interface for each vduse virtqueue to change
> the affinity for IRQ callback. It would be helpful for performance
> tuning when the affinity mask contains more than one CPU.
> 
> Patch 8 ~ 9 associate an eventfd to the vdpa callback so that
> we can signal it directly during irq injection without scheduling
> an additional workqueue thread to do that.
> 
> Patch 10, 11 add a sysfs interface to support specifying bounce
> buffer size in virtio-vdpa case. The high throughput workloads
> can benefit from it. And we can also use it to reduce the memory
> overhead for small throughput workloads.
> 
> Please review, thanks!
> 
> V2 to V3:
> - Rebased to newest kernel tree
> - Export group_cpus_evenly() instead of irq_create_affinity_masks() [MST]
> - Remove the sysfs for workqueue control [Jason]
> - Associate an eventfd to the vdpa callback [Jason]
> - Signal the eventfd directly in vhost-vdpa case [Jason]
> - Use round-robin to spread IRQs between CPUs in the affinity mask [Jason]
> - Handle the cpu hotplug case on IRQ injection [Jason]
> - Remove effective IRQ affinity and balance mechanism for IRQ allocation
> 
> V1 to V2:
> - Export irq_create_affinity_masks()
> - Add set/get_vq_affinity and set_irq_affinity callbacks in vDPA
>   framework
> - Add automatic irq callback affinity support in VDUSE driver [Jason]
> - Add more backgrounds information in commit log [Jason]
> - Only support changing effective affinity when the value is a subset
>   of the IRQ callback affinity mask
> 
> Xie Yongji (11):
>   lib/group_cpus: Export group_cpus_evenly()
>   vdpa: Add set/get_vq_affinity callbacks in vdpa_config_ops
>   vdpa: Add set_irq_affinity callback in vdpa_config_ops
>   vduse: Refactor allocation for vduse virtqueues
>   vduse: Support automatic irq callback affinity
>   vduse: Support set/get_vq_affinity callbacks
>   vduse: Add sysfs interface for irq callback affinity
>   vdpa: Add eventfd for the vdpa callback
>   vduse: Signal interrupt's eventfd directly in vhost-vdpa case
>   vduse: Delay iova domain creation
>   vduse: Support specifying bounce buffer size via sysfs
> 
>  drivers/vdpa/vdpa_user/vduse_dev.c | 490 +++++++++++++++++++++++++----
>  drivers/vhost/vdpa.c               |   2 +
>  drivers/virtio/virtio_vdpa.c       |  33 ++
>  include/linux/vdpa.h               |  25 ++
>  lib/group_cpus.c                   |   1 +
>  5 files changed, 488 insertions(+), 63 deletions(-)
> 
> -- 
> 2.20.1

