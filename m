Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC8F73FB0B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 13:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjF0LX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 07:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbjF0LXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 07:23:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A1126AB
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 04:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687864951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=AXpX6+bIX3VG+BFlIbD8IyCdNffvSiQAQaFthXvYXYA=;
        b=f5yW+z4BA9GZ4IMpu1WFTtfqvZRPySQPSst5tXvmaQd60QIiXmb9+JEw290gToA1XjnLGJ
        vOcSEftQHhmv0RNvFJDsrJv5nKUHHwlBBBfbSQm091akxJiPPOWDFqcPC8Skz/b3IhLQ1V
        DHeHfFCABYxOlNNgfzMuMXKDfPwBEus=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-458-KoLIc-NHPDWNdw4_zSVBwg-1; Tue, 27 Jun 2023 07:22:28 -0400
X-MC-Unique: KoLIc-NHPDWNdw4_zSVBwg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 638D11C07588;
        Tue, 27 Jun 2023 11:22:27 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.192.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 69FFF200A3AD;
        Tue, 27 Jun 2023 11:22:21 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, virtualization@lists.linux-foundation.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH v1 0/5] mm/memory_hotplug: make offline_and_remove_memory() timeout instead of failing on fatal signals
Date:   Tue, 27 Jun 2023 13:22:15 +0200
Message-Id: <20230627112220.229240-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As raised by John Hubbard [1], offline_and_remove_memory() failing on
fatal signals can be sub-optimal for out-of-tree drivers: dying user space
might be the last one holding a device node open.

As that device node gets closed, the driver might unplug the device
and trigger offline_and_remove_memory() to unplug previously
hotplugged device memory. This, however, will fail reliably when fatal
signals are pending on the dying process, turning the device unusable until
the machine gets rebooted.

That can be optizied easily by ignoring fatal signals. In fact, checking
for fatal signals in the case of offline_and_remove_memory() doesn't
make too much sense; the check makes sense when offlining is triggered
directly via sysfs.  However, we actually do want a way to not end up
stuck in offline_and_remove_memory() forever.

What offline_and_remove_memory() users actually want is fail after some
given timeout and not care about fatal signals.

So let's implement that, optimizing virtio-mem along the way.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

[1] https://lkml.kernel.org/r/20230620011719.155379-1-jhubbard@nvidia.com

David Hildenbrand (5):
  mm/memory_hotplug: check for fatal signals only in offline_pages()
  virtio-mem: convert most offline_and_remove_memory() errors to -EBUSY
  mm/memory_hotplug: make offline_and_remove_memory() timeout instead of
    failing on fatal signals
  virtio-mem: set the timeout for offline_and_remove_memory() to 10
    seconds
  virtio-mem: check if the config changed before (fake) offlining memory

 drivers/virtio/virtio_mem.c    | 22 +++++++++++++--
 include/linux/memory_hotplug.h |  2 +-
 mm/memory_hotplug.c            | 50 ++++++++++++++++++++++++++++++++--
 3 files changed, 68 insertions(+), 6 deletions(-)


base-commit: 6995e2de6891c724bfeb2db33d7b87775f913ad1
-- 
2.40.1

