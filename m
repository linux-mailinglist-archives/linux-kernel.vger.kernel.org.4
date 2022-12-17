Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB4E64F6D1
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 02:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiLQBzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 20:55:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLQBzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 20:55:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E5E442F3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 17:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671242087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=KlAUk4Rvv2uJ6My8k7MBoYVwmIEIsjetFKSoMLOi3Uk=;
        b=fiZzwKbK7SH0qWwTwKC+fPVo+GiM1+3GBW3RCQd9/oP9DwwLZ2ctbDTr2g4GATzx3y1z5T
        YHOIiIU9LulyaOP21FToPpTK0a6qUS5GDXBGxGyuv/HHKjHh3zeG4oa/brKVcew19HQe/l
        LyFziE3uk0akXSXmmARf9k704TDiOSk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-422-Y2byrGHOOMmErGkLv8UWzQ-1; Fri, 16 Dec 2022 20:54:43 -0500
X-MC-Unique: Y2byrGHOOMmErGkLv8UWzQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 63378802C1C;
        Sat, 17 Dec 2022 01:54:43 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-34.pek2.redhat.com [10.72.12.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 572DA400F5B;
        Sat, 17 Dec 2022 01:54:38 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, urezki@gmail.com, stephen.s.brennan@oracle.com,
        willy@infradead.org, akpm@linux-foundation.org, hch@infradead.org,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 0/7] mm/vmalloc.c: allow vread() to read out vm_map_ram areas
Date:   Sat, 17 Dec 2022 09:54:28 +0800
Message-Id: <20221217015435.73889-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Problem:
***
Stephen reported vread() will skip vm_map_ram areas when reading out
/proc/kcore with drgn utility. Please see below link to get more about
it:

  /proc/kcore reads 0's for vmap_block
  https://lore.kernel.org/all/87ilk6gos2.fsf@oracle.com/T/#u

Root cause:
***
The normal vmalloc API uses struct vmap_area to manage the virtual
kernel area allocated and associate a vm_struct to store more information
and passed out. However, area reserved through vm_map_ram() interface
doesn't allocate vm_struct to bind with. So the current code in vread()
will skip the vm_map_ram area through 'if (!va->vm)' conditional checking.

Solution:
***
There are two types of vm_map_ram area. One is the whole vmap_area being
reserved and mapped at one time; the other is the whole vmap_area with
VMAP_BLOCK_SIZE size being reserved at one time, while mapped into split
regions with smaller size several times via vb_alloc(). I will call the
2nd type vb region.

In patch 1 and 2, add flags into struct vmap_area to mark these two types
of vm_map_ram area, meanwhile add bitmap field used_map into struct
vmap_block to mark those vb regions being used to differentiate with dirty
and free regions in vmap_block.

With the help of above vmap_area->flags and vmap_block->used_map, we can
recognize them in vread() and handle them respectively in patch 3.

Besides,
***
In patch 5, let's ignore vmap area with VM_UNINITIALIZED set in
vm->flags, because this kind of area is created by calling
__vmalloc_node_range(), VM_UNINITIALIZED set indicating it has
vm_struct associated with, but is still during the page allocating and
mapping process.

In patch 6 and 7, change area flag from VM_ALLOC to VM_IOREMAP in two
places. This will show them as 'ioremap' in /proc/vmallocinfo, and
exclude them from /proc/kcore.

Testing
***
Only did the basic testing.

Changelog
***
v1->v2:
- Change alloc_vmap_area() to pass in va_flags so that we can pass and
  set vmap_area->flags for vm_map_ram area. With this, no extra action
  need be added to acquire vmap_area_lock when doing the vmap_area->flags
  setting. Uladzislau reviewed v1 and pointed out the issue.
- Improve vb_vread() to cover the case where reading is started from a
  dirty or free region.

RFC->v1:
- Add a new field flags in vmap_area to mark vm_map_ram area. It cold be
  risky reusing the vm union in vmap_area in RFC. I will consider
  reusing the union in vmap_area to save memory later. Now just take the
  simpler way to let's focus on resolving the main problem.
- Add patch 4~7 for optimization.

Baoquan He (7):
  mm/vmalloc.c: add used_map into vmap_block to track space of
    vmap_block
  mm/vmalloc.c: add flags to mark vm_map_ram area
  mm/vmalloc.c: allow vread() to read out vm_map_ram areas
  mm/vmalloc: explicitly identify vm_map_ram area when shown in
    /proc/vmcoreinfo
  mm/vmalloc: skip the uninitilized vmalloc areas
  powerpc: mm: add VM_IOREMAP flag to the vmalloc area
  sh: mm: set VM_IOREMAP flag to the vmalloc area

 arch/powerpc/kernel/pci_64.c |   2 +-
 arch/sh/kernel/cpu/sh4/sq.c  |   2 +-
 include/linux/vmalloc.h      |   1 +
 mm/vmalloc.c                 | 106 +++++++++++++++++++++++++++++------
 4 files changed, 92 insertions(+), 19 deletions(-)

-- 
2.34.1

