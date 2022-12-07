Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142D56453CA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 07:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiLGGAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 01:00:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiLGGAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 01:00:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1655B5A8
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 21:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670392623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lU+AyjZqCt5Zscy5OezHUmjY2MSPGosbS0p0NXtwsxU=;
        b=S+hOenTHz8qpo4pykcYyI7D48Iwyt2Tpm5inecRIrM7XOJQNP8a16GeqYIi4ZufllFJFkT
        6/yMniZlduImbSjxZ1dIq2Ps2txcOSJwtfsCTrFZMqilxRHwDLbjgCjt9QAesRkdlmQfk0
        ZggEQpJe9OuFzROzE2gITRD1lkGShhg=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-522-RdD07QuPONGCl-34DJD9JA-1; Wed, 07 Dec 2022 00:56:54 -0500
X-MC-Unique: RdD07QuPONGCl-34DJD9JA-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1444cf9e0d8so5732559fac.20
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 21:56:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lU+AyjZqCt5Zscy5OezHUmjY2MSPGosbS0p0NXtwsxU=;
        b=44RuZ9OoTQlEx6+PvfcxfbA7FkZWznfb/Lism7cJyUBZ+RNZzL1u/M1vTCWqthKHJT
         02M5VkTCyfC7vuiwX/tka+22H+/2gNssp3rh7WW1EdjAX0cdDENnjwHBENSzHr4MXdj4
         XOtaF5SxM+nTz6iGaEithKIYN/gwW0Rw/Ku02e81N56mLFi3NxK89Cw6W5HY1lBe97kd
         LCSg0zZiLIpTPqCcj/4FUiDrHaM6Ukux1ZKw8Vgo9HHW3nyloGJId5WtxmZy9dtBFY5h
         GNr49O9yTshi7kHJbCgkewE1YkGXLPu7MItRXhs4wUjJxFffZYgWkiL1XOBXVkT5rbJg
         5NYg==
X-Gm-Message-State: ANoB5pmGPPZg+EUNGitlE1uJTDn6V7PFlQsotVFftSsAIFAPre0tR90g
        1uyLM7AQtpOM86fUPOTWG6TBB0v8YnA1H5WOE8ThXqLWFuw0zcGgEZnDao016JaVImCPU976z/E
        usGhZdZdr7dqUdJbqqdZTSb85o+ZzhTMBjLruUm3U
X-Received: by 2002:a05:6870:b9b:b0:144:b22a:38d3 with SMTP id lg27-20020a0568700b9b00b00144b22a38d3mr5150123oab.280.1670392613465;
        Tue, 06 Dec 2022 21:56:53 -0800 (PST)
X-Google-Smtp-Source: AA0mqf77QPIsbA8jEogUQu/a5zSH+M+Eph6ulRoBolrhbx2gABP5M6e6zVN5P1JJfcS1nZURmB/WGzpOSOSC55QC1yk=
X-Received: by 2002:a05:6870:b9b:b0:144:b22a:38d3 with SMTP id
 lg27-20020a0568700b9b00b00144b22a38d3mr5150114oab.280.1670392613277; Tue, 06
 Dec 2022 21:56:53 -0800 (PST)
MIME-Version: 1.0
References: <20221205084127.535-1-xieyongji@bytedance.com> <20221205084127.535-2-xieyongji@bytedance.com>
 <20221206081847.GA8771@lst.de> <CACycT3sXHGQt_V=rgwvEv4v8+oUaAOu1T=tWrKePdybMHagzng@mail.gmail.com>
 <20221206084736.GA9507@lst.de> <CACycT3uk4FCswFj8VqqPDgdEM73iqMnYSL8j6DYxCiy1FNSvHQ@mail.gmail.com>
In-Reply-To: <CACycT3uk4FCswFj8VqqPDgdEM73iqMnYSL8j6DYxCiy1FNSvHQ@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 7 Dec 2022 13:56:42 +0800
Message-ID: <CACGkMEtXiEk72coPnzKmFyTYun_9H+Gm-Hmj68R4x4sb4rp+aw@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] genirq/affinity:: Export irq_create_affinity_masks()
To:     Yongji Xie <xieyongji@bytedance.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

On Tue, Dec 6, 2022 at 5:28 PM Yongji Xie <xieyongji@bytedance.com> wrote:
>
> On Tue, Dec 6, 2022 at 4:47 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Tue, Dec 06, 2022 at 04:40:37PM +0800, Yongji Xie wrote:
> > > With the vDPA framework, some drivers (vduse, vdpa-sim) can create
> > > software-defined virtio devices and attach them to the virtio bus.
> > > This kind of virtio device is not a pci device or a platform device.
> > > So it would be needed to export this function if we want to implement
> > > the automatic affinity management for the virtio device driver which
> > > is binded to this device.
> >
> > Why are these devices even using interrupts?
>
> They don't use interrupt. But they use a bound workqueue to run the
> interrupt callback. So the driver needs an algorithm to choose which
> cpu to run the interrupt callback. Then we found the existing
> interrupt affinity spreading mechanism is very suitable for this
> scenario, so we try to export this function to reuse it.
>
> > The whjole vdpa thing
> > is a mess, I also still need to fix up the horrible abuse of the DMA
> > API for something that isn't even DMA, and this just seems to spread
> > that same mistake even further.

I think it's mostly an issue of some vDPA parents, not the vDPA
itself. I had patches to get rid of the DMA API for vDPA simulators.
Will post.

>
> We just want to reuse this algorithm. And it is completely independent
> of the IRQ subsystem. I guess it would not mess things up.

I think so, it's about which CPU do we want to run the callback and
the callback is not necessarily triggered by an IRQ.

Thanks

>
> Thanks,
> Yongji
>

