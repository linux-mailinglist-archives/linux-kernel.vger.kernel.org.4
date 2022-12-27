Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303756566D2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 03:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbiL0CaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 21:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbiL0CaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 21:30:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA83B5A
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 18:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672108165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jbAtScacCJJF14FDmrZt0VPAoTte0b/A2HYccNWz1a8=;
        b=accmjlKjlDvmiwMUfHAzrLfj1xMn78/31aLelFe+X8wpRqmUY4HyJrhd7ZcfEM3ICcfJBx
        rkp7xrDGAZko/0FEqfMKjBN2MO63lX8VKlpu2cwgjMVuTN/ayXK5/QclFX1lzqUy/AAU0u
        ekuWnG4O14m1h26VfZs3sQEFe6OYREc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-88-dknrK1sCM8SaCT8kSUC8zQ-1; Mon, 26 Dec 2022 21:29:14 -0500
X-MC-Unique: dknrK1sCM8SaCT8kSUC8zQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C5669101A55E;
        Tue, 27 Dec 2022 02:29:13 +0000 (UTC)
Received: from localhost (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C43B52026D4B;
        Tue, 27 Dec 2022 02:29:12 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        John Garry <john.garry@huawei.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 0/6] genirq/affinity: Abstract APIs from managed irq affinity spread
Date:   Tue, 27 Dec 2022 10:28:59 +0800
Message-Id: <20221227022905.352674-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

irq_build_affinity_masks() actually grouping CPUs evenly into each managed
irq vector according to NUMA and CPU locality, and it is reasonable to abstract
one generic API for grouping CPUs evenly, the idea is suggested by Thomas
Gleixner.

group_cpus_evenly() is abstracted and put into lib/, so blk-mq can re-use
it to build default queue mapping.

blk-mq IO perf data is observed as more stable, meantime with big
improvement, see detailed data in the last patch.

Please consider it for v6.3!

V4:
	- address comments from John, not export the API, given so far no
	  module uses this symbol
	- add maintainer entry for new added lib/group_cpus.c
	- rebase on 6.2

V3:
	- fix build failure in case of !CONFIG_SMP, only 6/7 is changed

V2:
	- fix build failure in case of !CONFIG_SMP
	- fix commit log typo
	- fix memory leak in last patch
	- add reviewed-by

Since RFC:
	- remove RFC
	- rebase on -next tree


Ming Lei (6):
  genirq/affinity: Remove the 'firstvec' parameter from
    irq_build_affinity_masks
  genirq/affinity: Pass affinity managed mask array to
    irq_build_affinity_masks
  genirq/affinity: Don't pass irq_affinity_desc array to
    irq_build_affinity_masks
  genirq/affinity: Rename irq_build_affinity_masks as group_cpus_evenly
  genirq/affinity: Move group_cpus_evenly() into lib/
  blk-mq: Build default queue map via group_cpus_evenly()

 MAINTAINERS                |   2 +
 block/blk-mq-cpumap.c      |  63 ++----
 include/linux/group_cpus.h |  14 ++
 kernel/irq/affinity.c      | 405 +----------------------------------
 lib/Makefile               |   2 +
 lib/group_cpus.c           | 427 +++++++++++++++++++++++++++++++++++++
 6 files changed, 467 insertions(+), 446 deletions(-)
 create mode 100644 include/linux/group_cpus.h
 create mode 100644 lib/group_cpus.c

-- 
2.31.1

