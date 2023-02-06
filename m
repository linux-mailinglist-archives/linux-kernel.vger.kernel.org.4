Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF00A68B784
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 09:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjBFIlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 03:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjBFIlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 03:41:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3EC1715D
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 00:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675672829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=eDVaZJdMGL4kVKzSO0PRgS/vEsAWvBE6o/r2igpI1bc=;
        b=huCslSgQmIXUDfrbcfkb3rN7qFzdILt/IT1Yy6quouzsw21eyJkVFiDsRBfzQ1KXW42rkk
        DdAUPV9tyE8SWWyus276qG8QhGrHbfngmM/4uliUtwpb/40OmiMrYtJwf9Bx+Y8IYM482x
        alMWSOScVeCxCtTl6wSfdEtsKAIu9Xk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-659-6hb2469dMb-FDzgH3OfGLw-1; Mon, 06 Feb 2023 03:40:28 -0500
X-MC-Unique: 6hb2469dMb-FDzgH3OfGLw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B8B342A59567;
        Mon,  6 Feb 2023 08:40:27 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-71.pek2.redhat.com [10.72.12.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9D5E02166B2A;
        Mon,  6 Feb 2023 08:40:23 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        stephen.s.brennan@oracle.com, urezki@gmail.com, lstoakes@gmail.com,
        error27@gmail.com, Baoquan He <bhe@redhat.com>
Subject: [PATCH v5 0/7] mm/vmalloc.c: allow vread() to read out vm_map_ram areas
Date:   Mon,  6 Feb 2023 16:40:13 +0800
Message-Id: <20230206084020.174506-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
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

Problem:
***
Stephen reported vread() will skip vm_map_ram areas when reading out
/proc/kcore with drgn utility. Please see below link to get more
details. 

  /proc/kcore reads 0's for vmap_block
  https://lore.kernel.org/all/87ilk6gos2.fsf@oracle.com/T/#u

Root cause:
***
The normal vmalloc API uses struct vmap_area to manage the virtual
kernel area allocated, and associate a vm_struct to store more
information and pass out. However, area reserved through vm_map_ram()
interface doesn't allocate vm_struct to associate with. So the current
code in vread() will skip the vm_map_ram area through 'if (!va->vm)'
conditional checking.

Solution:
***
To mark the area reserved through vm_map_ram() interface, add field 'flags'
into struct vmap_area. Bit 0 indicates this is vm_map_ram area created
through vm_map_ram() interface, bit 1 marks out the type of vm_map_ram area
which makes use of vmap_block to manage split regions via vb_alloc/free().

And also add bitmap field 'used_map' into struct vmap_block to mark those
further subdivided regions being used to differentiate with dirty and free
regions in vmap_block.

With the help of above vmap_area->flags and vmap_block->used_map, we can
recognize and handle vm_map_ram areas successfully. All these are done
in patch 1~3.

Meanwhile, do some improvement on areas related to vm_map_ram areas in
patch 4, 5. And also change area flag from VM_ALLOC to VM_IOREMAP in
patch 6, 7 because this will show them as 'ioremap' in /proc/vmallocinfo,
and exclude them from /proc/kcore.

Testing
***
- I did basic testing on kvm guest, and run below commands to
  access kcore file to do statistics:

	makedumpfile --mem-usage /proc/kcore

- Stephen helped to test v4 and confirm the problem he spotted and
  reported has been resolved with the v4 patchset.

Changelog
***
v4->v5:
- Add a 'unlock' label and goto jumping in while loop of
  vmap_ram_vread() function, this improve the codes execution. This is
  done in patch 3.
- Add Stephen's Reported-by and Tested-by tags in patch 3.

v3->v4:
- Fix typo in pach 2 catched by Lorenzo.
- Add WARN_ON(flags == VMAP_BLOCK) in vread() to address Dan's concern
  that VMAP_BLOCK could be set alone in vmap->flags.
- Add checking on the returned value from xa_load() in vmap_ram_vread(),
  Uladzislau commented on the risk of this place.
- Fix a bug in s_show() which is changed in patch 5. The old change will
  cause 'va->vm is NULL but the VMAP_RAM flag is not set' case wrongly
  handled. Please see below link for details.
  - https://lore.kernel.org/all/Y8aAmuUY9OxrYlLm@kili/T/#u
- Add Uladzislau and Lorenzo's Reviewed-by.

v2->v3:
- Benefited from find_unlink_vmap_area() introduced by Uladzislau, do
  not need to worry about the va->vm and va->flags reset during freeing.
- Change to identify vm_map_area with VMAP_RAM in vmap->flags in
  vread(). 
- Rename the old vb_vread() to vmap_ram_vread().
- Handle two kinds of vm_map_area area reading in vmap_ram_vread()
  respectively. 
- Fix bug of the while loop code block in vmap_block reading, found by
  Lorenzo.
- Improve conditional check related to vm_map_ram area, suggested by
  Lorenzo.

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
 mm/vmalloc.c                 | 127 ++++++++++++++++++++++++++++++-----
 4 files changed, 112 insertions(+), 20 deletions(-)

-- 
2.34.1

