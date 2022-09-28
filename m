Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48E15ED961
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 11:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbiI1Jp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 05:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbiI1Jpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 05:45:52 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E5693537;
        Wed, 28 Sep 2022 02:45:49 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id DF05967373; Wed, 28 Sep 2022 11:45:45 +0200 (CEST)
Date:   Wed, 28 Sep 2022 11:45:45 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Angus Chen <angus.chen@jaguarmicro.com>, jasowang@redhat.com,
        pbonzini@redhat.com, axboe@kernel.dk,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liming Wu <liming.wu@jaguarmicro.com>, stefanha@redhat.com,
        tglx@linutronix.de
Subject: Re: [PATCH v1] virtio_blk: should not use IRQD_AFFINITY_MANAGED in
 init_rq
Message-ID: <20220928094545.GA19646@lst.de>
References: <20220924034854.323-1-angus.chen@jaguarmicro.com> <20220927163723-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927163723-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 04:47:20PM -0400, Michael S. Tsirkin wrote:
> > The log :
> > "genirq: Flags mismatch irq 0. 00000080 (virtio418) vs. 00015a00 (timer)"
> > was print because of the irq 0 is used by timer exclusive,and when
> > vp_find_vqs called vp_find_vqs_msix and return false twice,then it will
> > call vp_find_vqs_intx for the last try.
> > Because vp_dev->pci_dev->irq is zero,so it will be request irq 0 with
> > flag IRQF_SHARED.
> 
> First this is a bug. We can fix that so it will fail more cleanly.
> 
> We should check pci_dev->pin and if 0 do not try to use INT#x
> at all.
> It will still fail, just with a nicer backtrace.

How do we end up with a pci_dev without a valid PIN?  Btw, that whole
vp_find_* code looks extremely fucked up to me.  The whole point of
pci_alloc_irq_vectors* API is that it keeps drivers from poling into
details of MSI-X v MSI vs INTX.

> - because of auto affinity, we try to reserve an interrupt on all CPUs
> - as there are 512 devices with a single vector per VQ we would
>   have no issue as they would be spread between CPUs,
>   but allocating on all CPUs fails.
> 
> 
> I don't think the issue should be fixed at blk level - it is not
> blk specifix - but yes this looks like a problem.
> Christoph, any idea?

I think this goes into the low-level interrupt vector allocator.  I think
Thomas is still the expert on it.
