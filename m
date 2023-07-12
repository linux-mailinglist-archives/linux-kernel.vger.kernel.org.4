Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5AD875096F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 15:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjGLNRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 09:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233232AbjGLNRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 09:17:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528A81999
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 06:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689167786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YdW3jXa75uZifOOTp5ZtJFJJaNTXIh3AfAYdiE+BpGY=;
        b=Cmp0XKQWfdBj4LO4I+4SASPp+SXG+fO5FcLxEOfHjUjDCbyWo7qlDxGgECo5SltOAfVtV0
        IcSs6bBl1QE/VBP2S2RIXBf/liHJGW7AojELmO81Q1+m884c86BYUxVkmiqhfyUiJPf9r5
        EZfwT8Ic9kmx241eOYaE3N0ZLUvh+Xk=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-288-6xGLn3mlMKuJeIXdR53l4w-1; Wed, 12 Jul 2023 09:16:25 -0400
X-MC-Unique: 6xGLn3mlMKuJeIXdR53l4w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6E9C23C0C491;
        Wed, 12 Jul 2023 13:16:24 +0000 (UTC)
Received: from ovpn-8-25.pek2.redhat.com (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F33FC4087C73;
        Wed, 12 Jul 2023 12:38:00 +0000 (UTC)
Date:   Wed, 12 Jul 2023 21:16:11 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Wen Xiong <wenxiong@linux.ibm.com>,
        Keith Busch <kbusch@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] blk-mq: add blk_mq_max_nr_hw_queues()
Message-ID: <ZK6nm2koR+TfeMcs@ovpn-8-25.pek2.redhat.com>
References: <20230712125455.1986455-1-ming.lei@redhat.com>
 <20230712125455.1986455-2-ming.lei@redhat.com>
 <20230712130017.GA12417@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712130017.GA12417@lst.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 03:00:17PM +0200, Christoph Hellwig wrote:
> On Wed, Jul 12, 2023 at 08:54:48PM +0800, Ming Lei wrote:
> > +/* Max nr_hw_queues for each hw queue type */
> > +unsigned int blk_mq_max_nr_hw_queues(void)
> > +{
> > +	if (is_kdump_kernel())
> > +		return 1;
> > +	return nr_cpu_ids;
> 
> Again, these is_kdump_kernel hacks don't make any sense.   The amount
> of maximum available CPU needs to come through a proper API, and we
> need to use it, not add hacks like this.
> 
> The only thing that makes sense here is to find the last CPU
> in cpu_possible_mask, and for kdump kernels to ensure that number
> is 1 or whatever low value they want.

It doesn't matter how many cpus are available, given at least one
cpu is online.

The problem is that blk_mq_alloc_tag_set() forces to set nr_hw_queues
as 1 for kdump kernel, that is why blk_mq_max_nr_hw_queues() has to
return 1 for kdump kernel.

We have to tell driver that blk-mq only supports 1 queue for kdump
kernel.

Or:

Thomas, can we disable managed irq for kdump kernel and switch to
non-managed irq? Then we can avoid driver's change. I'd suggest
this way if it is possible.

Thanks,
Ming

