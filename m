Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306D76651A0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 03:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjAKCTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 21:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbjAKCTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 21:19:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0B91A4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 18:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673403516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DN9UxpKlX7apZAt5RWDja0xzaNut2U3d9yX0t+EeEGo=;
        b=WspRGPiqzwEwrBDyFAa4VZ3+xEhnTLWUY/6TsNOhJ550YV8wC1ur2WRLX+EzQE26Cr5ZMm
        3i9oswz+veCXHDsC2UyuI1rIkdXSpPAfuTzkP6Y4UFjbibsKrY58NX0hoqVqJAZuSrkKWd
        ZkkOaNmX0xNQjTfIOQx6ZOT882D7+YI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-372-85-pQL8yM3u4HCKxSCWsYA-1; Tue, 10 Jan 2023 21:18:33 -0500
X-MC-Unique: 85-pQL8yM3u4HCKxSCWsYA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3AF452A5954F;
        Wed, 11 Jan 2023 02:18:33 +0000 (UTC)
Received: from T590 (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E4224078903;
        Wed, 11 Jan 2023 02:18:09 +0000 (UTC)
Date:   Wed, 11 Jan 2023 10:18:04 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH V4 0/6] genirq/affinity: Abstract APIs from managed irq
 affinity spread
Message-ID: <Y74cXN4SP7FNtSl3@T590>
References: <20221227022905.352674-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221227022905.352674-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas, Jens and guys,

On Tue, Dec 27, 2022 at 10:28:59AM +0800, Ming Lei wrote:
> Hello,
> 
> irq_build_affinity_masks() actually grouping CPUs evenly into each managed
> irq vector according to NUMA and CPU locality, and it is reasonable to abstract
> one generic API for grouping CPUs evenly, the idea is suggested by Thomas
> Gleixner.
> 
> group_cpus_evenly() is abstracted and put into lib/, so blk-mq can re-use
> it to build default queue mapping.
> 
> blk-mq IO perf data is observed as more stable, meantime with big
> improvement, see detailed data in the last patch.
> 
> Please consider it for v6.3!
> 
> V4:
> 	- address comments from John, not export the API, given so far no
> 	  module uses this symbol
> 	- add maintainer entry for new added lib/group_cpus.c
> 	- rebase on 6.2

Any chance to take a look at this patchset?


thanks,
Ming

