Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A34643EFE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 09:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbiLFIro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 03:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbiLFIrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 03:47:40 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A66271D
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 00:47:39 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0258B68B05; Tue,  6 Dec 2022 09:47:37 +0100 (CET)
Date:   Tue, 6 Dec 2022 09:47:36 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Yongji Xie <xieyongji@bytedance.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 01/11] genirq/affinity:: Export
 irq_create_affinity_masks()
Message-ID: <20221206084736.GA9507@lst.de>
References: <20221205084127.535-1-xieyongji@bytedance.com> <20221205084127.535-2-xieyongji@bytedance.com> <20221206081847.GA8771@lst.de> <CACycT3sXHGQt_V=rgwvEv4v8+oUaAOu1T=tWrKePdybMHagzng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACycT3sXHGQt_V=rgwvEv4v8+oUaAOu1T=tWrKePdybMHagzng@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 04:40:37PM +0800, Yongji Xie wrote:
> With the vDPA framework, some drivers (vduse, vdpa-sim) can create
> software-defined virtio devices and attach them to the virtio bus.
> This kind of virtio device is not a pci device or a platform device.
> So it would be needed to export this function if we want to implement
> the automatic affinity management for the virtio device driver which
> is binded to this device.

Why are these devices even using interrupts?  The whjole vdpa thing
is a mess, I also still need to fix up the horrible abuse of the DMA
API for something that isn't even DMA, and this just seems to spread
that same mistake even further.
