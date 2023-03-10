Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17876B3B1B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 10:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjCJJoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 04:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjCJJnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 04:43:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D661CBED
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 01:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678441329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R1e5SuPHQGzU5Lth3ckLfQ0HVsiCpzxHGfk4+auJE4A=;
        b=OJsmP3/qYJFCpnA48mXpefNarI3MyafSRSFlkHXifPMvom/po1D371WZxJL7RyvzDsvs2b
        wW40F+gDABAj6ADW/xq7pgsffoSFllwor8n5Wz9/a5DhyMd3ZZqAFvw0radPxK6tx+osV1
        FzXaKX/6nfAQNCA9XuVvpRFwfDtvkZQ=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-QkVbriIUNSmWJ3qyyzhI3w-1; Fri, 10 Mar 2023 04:42:07 -0500
X-MC-Unique: QkVbriIUNSmWJ3qyyzhI3w-1
Received: by mail-oo1-f70.google.com with SMTP id y140-20020a4a4592000000b0052540059057so1472662ooa.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 01:42:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678441327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R1e5SuPHQGzU5Lth3ckLfQ0HVsiCpzxHGfk4+auJE4A=;
        b=XvOQ2XIJ8L/XVaAN6Lg8NscJckw9XALOqGQ66/Xfs4/DZEydJ82kvoViNAulnHfb4Q
         pEvc/0uMqxtl/fY8saKtZUvEc7rgA4HME5YscZNvK0n8IbxpwttOHj2qVLtk9xZCEFre
         N5i5KBD2urMOHU4D+jOlLcQEDQ1KfofXr+EF+Uj/HD0UgJLx7WElKwcMupJq6i22qKKX
         Zs3voTmW1vRDe/KcWf7ufeKWjM+JI6ylVBq3KrPRQzZwxSn/rWTNAQdfP18d95eKW4Ct
         GX6I0/RYwPKkjR8yDRq4Ycu/9RGeSVd607AtFkoQG86V9O1g5TRnqzAP8flUw63MAS8x
         HeeQ==
X-Gm-Message-State: AO0yUKUQnomkdfnafj6Slq+Ya/SFtYZsHlrRMVLHRNp1BmIHmE5YKEin
        PAgKm+Q1Pv4v7B1/VdzMLoAFFss7PnItNKJQ4C8R44G1RqNNObXrxfrMlaxYyFybOXgDtSkp75h
        WH+4lYodNPA7EfvkLixanCVjwHYD4Xk4Tw+9mjDT1ulZ1dkrMZO8=
X-Received: by 2002:a05:6870:5b31:b0:176:2b47:b31d with SMTP id ds49-20020a0568705b3100b001762b47b31dmr8659306oab.9.1678441326962;
        Fri, 10 Mar 2023 01:42:06 -0800 (PST)
X-Google-Smtp-Source: AK7set93b/mE47ddVNptTIhnLDsQN7CcKWq4mq1YTnxi436AhX1ooSYgAN2O9IkU9Bppbqf7HC5ykUiwiQY82LHipRw=
X-Received: by 2002:a05:6870:5b31:b0:176:2b47:b31d with SMTP id
 ds49-20020a0568705b3100b001762b47b31dmr8659302oab.9.1678441326737; Fri, 10
 Mar 2023 01:42:06 -0800 (PST)
MIME-Version: 1.0
References: <20230228094110.37-1-xieyongji@bytedance.com> <20230310034934-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230310034934-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 10 Mar 2023 17:41:55 +0800
Message-ID: <CACGkMEtL6a7vDKjbRdJnkiwtZMMh5vUaJ=tH7mf=omZrFy7AFQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] VDUSE: Improve performance
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Xie Yongji <xieyongji@bytedance.com>, tglx@linutronix.de,
        hch@lst.de, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 4:50=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Feb 28, 2023 at 05:40:59PM +0800, Xie Yongji wrote:
> > Hi all,
> >
> > This series introduces some ways to improve VDUSE performance.
>
>
> Pls fix warnings reported by 0-day infra, dropping this for now.

Note that I plan to review this next week.

Thanks

>
>
> > Patch 1 ~ 6 bring current interrupt affinity spreading mechanism
> > to vduse device and make it possible for the virtio-blk driver
> > to build the blk-mq queues based on it. This would be useful to
> > mitigate the virtqueue lock contention in virtio-blk driver. In
> > our test, with those patches, we could get ~50% improvement (600k
> > iops -> 900k iops) when using per-cpu virtqueue.
> >
> > Patch 7 adds a sysfs interface for each vduse virtqueue to change
> > the affinity for IRQ callback. It would be helpful for performance
> > tuning when the affinity mask contains more than one CPU.
> >
> > Patch 8 ~ 9 associate an eventfd to the vdpa callback so that
> > we can signal it directly during irq injection without scheduling
> > an additional workqueue thread to do that.
> >
> > Patch 10, 11 add a sysfs interface to support specifying bounce
> > buffer size in virtio-vdpa case. The high throughput workloads
> > can benefit from it. And we can also use it to reduce the memory
> > overhead for small throughput workloads.
> >
> > Please review, thanks!
> >
> > V2 to V3:
> > - Rebased to newest kernel tree
> > - Export group_cpus_evenly() instead of irq_create_affinity_masks() [MS=
T]
> > - Remove the sysfs for workqueue control [Jason]
> > - Associate an eventfd to the vdpa callback [Jason]
> > - Signal the eventfd directly in vhost-vdpa case [Jason]
> > - Use round-robin to spread IRQs between CPUs in the affinity mask [Jas=
on]
> > - Handle the cpu hotplug case on IRQ injection [Jason]
> > - Remove effective IRQ affinity and balance mechanism for IRQ allocatio=
n
> >
> > V1 to V2:
> > - Export irq_create_affinity_masks()
> > - Add set/get_vq_affinity and set_irq_affinity callbacks in vDPA
> >   framework
> > - Add automatic irq callback affinity support in VDUSE driver [Jason]
> > - Add more backgrounds information in commit log [Jason]
> > - Only support changing effective affinity when the value is a subset
> >   of the IRQ callback affinity mask
> >
> > Xie Yongji (11):
> >   lib/group_cpus: Export group_cpus_evenly()
> >   vdpa: Add set/get_vq_affinity callbacks in vdpa_config_ops
> >   vdpa: Add set_irq_affinity callback in vdpa_config_ops
> >   vduse: Refactor allocation for vduse virtqueues
> >   vduse: Support automatic irq callback affinity
> >   vduse: Support set/get_vq_affinity callbacks
> >   vduse: Add sysfs interface for irq callback affinity
> >   vdpa: Add eventfd for the vdpa callback
> >   vduse: Signal interrupt's eventfd directly in vhost-vdpa case
> >   vduse: Delay iova domain creation
> >   vduse: Support specifying bounce buffer size via sysfs
> >
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 490 +++++++++++++++++++++++++----
> >  drivers/vhost/vdpa.c               |   2 +
> >  drivers/virtio/virtio_vdpa.c       |  33 ++
> >  include/linux/vdpa.h               |  25 ++
> >  lib/group_cpus.c                   |   1 +
> >  5 files changed, 488 insertions(+), 63 deletions(-)
> >
> > --
> > 2.20.1
>

