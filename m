Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1094D74E7A0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 09:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjGKHBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 03:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjGKHBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 03:01:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365B418D
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 00:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689058849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v7BjYj/I+4PNhxODpnsSg7iMK5tRoeIrCo2+55CRjhI=;
        b=QfM+MhGzmGz0nCCS/aUvnmx8bx1rSwjhYwUJFPev1pl6HkML0jr0T6nfm54s9lmNhj0hLj
        FPLo9PIKFm1or9zeAlQAlpNZcRyWKoejNOA53lnF6bedhXIK2QpDe/MlXNaqN8fnX5YvMN
        a8TGTUChomkb+0OqJlbzKL7vbQbdmRw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-26-PfcYMSaXMaKpVE0zvE3fRA-1; Tue, 11 Jul 2023 03:00:45 -0400
X-MC-Unique: PfcYMSaXMaKpVE0zvE3fRA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F6FA856506;
        Tue, 11 Jul 2023 07:00:44 +0000 (UTC)
Received: from localhost (ovpn-12-93.pek2.redhat.com [10.72.12.93])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B333A492B01;
        Tue, 11 Jul 2023 07:00:05 +0000 (UTC)
Date:   Tue, 11 Jul 2023 14:59:35 +0800
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
Message-ID: <ZKz912KyFQ7q9qwL@MiWiFi-R3L-srv>
References: <20230708020259.1343736-1-ming.lei@redhat.com>
 <20230708020259.1343736-3-ming.lei@redhat.com>
 <20230710064109.GB24519@lst.de>
 <ZKvL58L58rY3GWnt@ovpn-8-31.pek2.redhat.com>
 <ZKzOFkokjTVwd4Ry@MiWiFi-R3L-srv>
 <ZKzSHDPR7Jfoz/G8@ovpn-8-26.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKzSHDPR7Jfoz/G8@ovpn-8-26.pek2.redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/23 at 11:53am, Ming Lei wrote:
> Hi Baoquan,
> 
> On Tue, Jul 11, 2023 at 11:35:50AM +0800, Baoquan He wrote:
> > On 07/10/23 at 05:14pm, Ming Lei wrote:
> > > On Mon, Jul 10, 2023 at 08:41:09AM +0200, Christoph Hellwig wrote:
> > > > On Sat, Jul 08, 2023 at 10:02:59AM +0800, Ming Lei wrote:
> > > > > Take blk-mq's knowledge into account for calculating io queues.
> > > > > 
> > > > > Fix wrong queue mapping in case of kdump kernel.
> > > > > 
> > > > > On arm and ppc64, 'maxcpus=1' is passed to kdump command line, see
> > > > > `Documentation/admin-guide/kdump/kdump.rst`, so num_possible_cpus()
> > > > > still returns all CPUs.
> > > > 
> > > > That's simply broken.  Please fix the arch code to make sure
> > > > it does not return a bogus num_possible_cpus value for these
> > > 
> > > That is documented in Documentation/admin-guide/kdump/kdump.rst.
> > > 
> > > On arm and ppc64, 'maxcpus=1' is passed for kdump kernel, and "maxcpu=1"
> > > simply keep one of CPU cores as online, and others as offline.
> > 
> > I don't know maxcpus on arm and ppc64 well. But maxcpus=1 or nr_cpus=1
> > are suggested parameter. Because usually nr_cpus=1 is enough to make
> > kdump kernel work well to capture vmcore. However, user is allowed to
> > specify nr_cpus=n (n>1) if they think multiple cpus are needed in kdump
> > kernel. Your hard coding of cpu number in kdump kernel may be not so
> > reasonable.
> 
> As I mentioned, for arm/ppc64, passing 'maxcpus=1' actually follows
> Documentation/admin-guide/kdump/kdump.rst.
> 
> 'nr_cpus=N' just works fine, so not related with this topic.
> 
> After 'maxcpus=1' is passed, kernel only brings up one of cpu cores as
> online during booting, and others still can be put into online by
> userspace. Now this way causes IO timeout on some storage device which
> uses managed irq and supports multiple io queues.
> 
> Here the focus is if passing 'maxcpus=1' is valid for kdump
> kernel, that is we want to hear from our arch/kdump guys.

Yes, 'maxcpus=1' is valid and suggested on ppc64 for kdump kernel
if needed, because there's no 'nr_cpus=' support on ppc64 yet.

> 
> If yes, something needs to be fixed, such as, what this patchset is
> doing.
> 
> > 
> > Please cc kexec mailing list when posting so that people can view the
> > whole thread of discussion.
> 
> Already Cc kexe & arm/powerpc & irq list.
> 
> 
> Thanks,
> Ming
> 

