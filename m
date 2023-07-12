Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803F37509A0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 15:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbjGLNce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 09:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbjGLNcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 09:32:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6518BC0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 06:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689168708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WNk+/jdHxPnVKST0gawS4+1QHywyN8OFBji/tGU56o0=;
        b=ha6n/gJzfmCRCLFQb4nnfROtcDLIk4eDMFQ/lhYWAtjC+A2k5c60Rp0w5vQeEEr6Ci4miP
        czJPT/tE3QPf/3tPjK3GR2P65R+b6cb/PHnyF5AJze+DiM9fdKUk7dqzed2XFZ7cLQPJX5
        MoUEmmpfPo2ib2TkTJNG26OF5y7jWuE=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-508-N7kRTt_vM7Oce_ckz9bmmA-1; Wed, 12 Jul 2023 09:31:38 -0400
X-MC-Unique: N7kRTt_vM7Oce_ckz9bmmA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D8CE2834771;
        Wed, 12 Jul 2023 13:31:37 +0000 (UTC)
Received: from ovpn-8-25.pek2.redhat.com (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4204D492B02;
        Wed, 12 Jul 2023 13:31:29 +0000 (UTC)
Date:   Wed, 12 Jul 2023 21:31:24 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Wen Xiong <wenxiong@linux.ibm.com>,
        Keith Busch <kbusch@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, ming.lei@redhat.com
Subject: Re: [PATCH 1/8] blk-mq: add blk_mq_max_nr_hw_queues()
Message-ID: <ZK6rLJbRvcXuznho@ovpn-8-25.pek2.redhat.com>
References: <20230712125455.1986455-1-ming.lei@redhat.com>
 <20230712125455.1986455-2-ming.lei@redhat.com>
 <20230712130017.GA12417@lst.de>
 <ZK6nm2koR+TfeMcs@ovpn-8-25.pek2.redhat.com>
 <20230712131925.GA14596@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712131925.GA14596@lst.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 03:19:25PM +0200, Christoph Hellwig wrote:
> On Wed, Jul 12, 2023 at 09:16:11PM +0800, Ming Lei wrote:
> > The problem is that blk_mq_alloc_tag_set() forces to set nr_hw_queues
> > as 1 for kdump kernel, that is why blk_mq_max_nr_hw_queues() has to
> > return 1 for kdump kernel.
> 
> Well, let's fix that first and work from there.  Same argument against
> that deep magic applies there as well.

In short, driver needs to figure out nr_hw_queues first by hardware info,
then pass it to blk_mq_alloc_tag_set(), but blk_mq_alloc_tag_set() changes it,
so inconsistency is caused.

The only solution in this way is to tell driver the max supported
number from the beginning, that is what this patchset is doing.

> 
> > Thomas, can we disable managed irq for kdump kernel and switch to
> > non-managed irq? Then we can avoid driver's change. I'd suggest
> > this way if it is possible.
> 
> Why the heck would we?

IMO irq kernel doesn't make sense in kdump kernel, which is very
resource limited and has to be reliable.

PCI_IRQ_AFFINITY can be just one hint, pci_alloc_irq_vectors_affinity()
still allocates affinity in managed way, then queue mapping can work
just fine, and the only difference is that genirq handles this irqs
as non-manged wrt. migration.

This way should solve queue mapping issue, but driver still allocates
lots of queues, which take resource useless. So looks we still have to
fix drivers.


Thanks, 
Ming

