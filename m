Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D7762BC7E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbiKPLuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237640AbiKPLtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:49:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043DAB1C1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668598536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=76g6nnVy/er8XFtFjE8C/ZicZTPcSvobVbZwHsj2pVY=;
        b=TobUHZzstEwoDlnOAaaF1fKEBpDsY8DbmFz4EdzmqpLejii3r/8t480brRosujxdH6zRvh
        d/zSvuwkYT/Ih/rsAP0LsieLKsKOCmevv/PwW8Ocxqla0MAEHYM+GcO6gwgAuPo72h7vYO
        AGoXPixiuM3yJ02VBj769yKHNZNoR8Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-102-OAQOQCrIPZOWLHiUvlxydw-1; Wed, 16 Nov 2022 06:35:33 -0500
X-MC-Unique: OAQOQCrIPZOWLHiUvlxydw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 06EFF185A78B;
        Wed, 16 Nov 2022 11:35:33 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B6AF2166B29;
        Wed, 16 Nov 2022 11:35:28 +0000 (UTC)
Date:   Wed, 16 Nov 2022 19:35:23 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Angus Chen <angus.chen@jaguarmicro.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jason Wang <jasowang@redhat.com>
Subject: Re: IRQ affinity problem from virtio_blk
Message-ID: <Y3TK+0m6kJjiyrao@T590>
References: <TY2PR06MB3424CB11DB57CA1FAA16F10D85049@TY2PR06MB3424.apcprd06.prod.outlook.com>
 <87v8nfrhbw.ffs@tglx>
 <20221115174152-mutt-send-email-mst@kernel.org>
 <87sfijrf9o.ffs@tglx>
 <87o7t7rec7.ffs@tglx>
 <20221115183339-mutt-send-email-mst@kernel.org>
 <87leobqiwj.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87leobqiwj.ffs@tglx>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 11:43:24AM +0100, Thomas Gleixner wrote:
> On Tue, Nov 15 2022 at 18:36, Michael S. Tsirkin wrote:
> > On Wed, Nov 16, 2022 at 12:24:24AM +0100, Thomas Gleixner wrote:
> >> I just checked on a random VM. The PCI device as advertised to the guest
> >> does not expose that many vectors. One has 2 and the other 4.
> >> 
> >> But as the interrupts are requested 'managed' the core ends up setting
> >> the vectors aside. That's a fundamental property of managed interrupts.
> >> 
> >> Assume you have less queues than CPUs, which is the case with 2 vectors
> >> and tons of CPUs, i.e. one ends up for config and the other for the
> >> actual queue. So the affinity spreading code will end up having the full
> >> cpumask for the queue vector, which is marked managed. And managed means
> >> that it's guaranteed e.g. in the CPU hotplug case that the interrupt can
> >> be migrated to a still online CPU.
> >> 
> >> So we end up setting 79 vectors aside (one per CPU) in the case that the
> >> virtio device only provides two vectors.
> >> 
> >> But that's not the end of the world as you really would need ~200 such
> >> devices to exhaust the vector space...
> >
> > Let's say we have 20 queues - then just 10 devices will exhaust the
> > vector space right?
> 
> No.
> 
> If you have 20 queues then the queues are spread out over the
> CPUs. Assume 80 CPUs:
> 
> Then each queue is associated to 80/20 = 4 CPUs and the resulting
> affinity mask of each queue contains exactly 4 CPUs:
> 
> q0:      0 -  3
> q1:      4 -  7
> ...
> q19:    76 - 79
> 
> So this puts exactly 80 vectors aside, one per CPU.
> 
> As long as at least one CPU of a queue mask is online the queue is
> enabled. If the last CPU of a queue mask goes offline then the queue is
> shutdown which means the interrupt associated to the queue is shut down
> too. That's all handled by the block MQ and the interrupt core. If a CPU
> of a queue mask comes back online then the guaranteed vector is
> allocated again.
> 
> So it does not matter how many queues per device you have it will
> reserve exactly ONE interrupt per CPU.
> 
> Ergo you need 200 devices to exhaust the vector space.

Hi Thomas,

I am wondering why one interrupt needs to be reserved for each CPU, in
theory one queue needs one irq, I understand, so would you mind
explaining the story a bit?


Thanks,
Ming

