Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E143C74E562
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 05:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjGKDgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 23:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjGKDgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 23:36:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28895F9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 20:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689046561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RAKJNLVa7Dz/gEOC8l+W1ubVM3SUfpJDz/d6N9kvm8w=;
        b=dtOCQgyeZfew8yc4ck0qqex2UgAsZmgASGXB3bhX84Cd0IIDwm/t5uuOCxbIVShvICpGyZ
        devCD+AhzwrS/VrQ0+r6sU8mnD55RPcM9WN3J3b+nUn46S0OamygbwrcwrY8NNNtK8XoQu
        n7ooLAi+3uE+lOKbE3bzJYfjf+liPqk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-498-rnGtRtxZNxW8idSVCPY9jA-1; Mon, 10 Jul 2023 23:35:56 -0400
X-MC-Unique: rnGtRtxZNxW8idSVCPY9jA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 765518028B2;
        Tue, 11 Jul 2023 03:35:55 +0000 (UTC)
Received: from localhost (ovpn-12-93.pek2.redhat.com [10.72.12.93])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2547DC52D9C;
        Tue, 11 Jul 2023 03:35:53 +0000 (UTC)
Date:   Tue, 11 Jul 2023 11:35:50 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Wen Xiong <wenxiong@linux.ibm.com>,
        Keith Busch <kbusch@kernel.org>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/2] nvme-pci: use blk_mq_max_nr_hw_queues() to calculate
 io queues
Message-ID: <ZKzOFkokjTVwd4Ry@MiWiFi-R3L-srv>
References: <20230708020259.1343736-1-ming.lei@redhat.com>
 <20230708020259.1343736-3-ming.lei@redhat.com>
 <20230710064109.GB24519@lst.de>
 <ZKvL58L58rY3GWnt@ovpn-8-31.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKvL58L58rY3GWnt@ovpn-8-31.pek2.redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/23 at 05:14pm, Ming Lei wrote:
> On Mon, Jul 10, 2023 at 08:41:09AM +0200, Christoph Hellwig wrote:
> > On Sat, Jul 08, 2023 at 10:02:59AM +0800, Ming Lei wrote:
> > > Take blk-mq's knowledge into account for calculating io queues.
> > > 
> > > Fix wrong queue mapping in case of kdump kernel.
> > > 
> > > On arm and ppc64, 'maxcpus=1' is passed to kdump command line, see
> > > `Documentation/admin-guide/kdump/kdump.rst`, so num_possible_cpus()
> > > still returns all CPUs.
> > 
> > That's simply broken.  Please fix the arch code to make sure
> > it does not return a bogus num_possible_cpus value for these
> 
> That is documented in Documentation/admin-guide/kdump/kdump.rst.
> 
> On arm and ppc64, 'maxcpus=1' is passed for kdump kernel, and "maxcpu=1"
> simply keep one of CPU cores as online, and others as offline.

I don't know maxcpus on arm and ppc64 well. But maxcpus=1 or nr_cpus=1
are suggested parameter. Because usually nr_cpus=1 is enough to make
kdump kernel work well to capture vmcore. However, user is allowed to
specify nr_cpus=n (n>1) if they think multiple cpus are needed in kdump
kernel. Your hard coding of cpu number in kdump kernel may be not so
reasonable.

Please cc kexec mailing list when posting so that people can view the
whole thread of discussion.

Thanks
Baoquan

> 
> So Cc our arch(arm & ppc64) & kdump guys wrt. passing 'maxcpus=1' for
> kdump kernel.
> 
> > setups, otherwise you'll have to paper over it in all kind of
> > drivers.
> 
> The issue is only triggered for drivers which use managed irq &
> multiple hw queues.
> 
> 
> Thanks,
> Ming
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

