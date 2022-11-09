Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986826222A7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 04:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiKIDgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 22:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiKIDgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 22:36:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D6C10EF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 19:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667964945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=iF0b5s+98G4TrJkekhHZ+dOQgcRNsa+t4EO2IaaGQDs=;
        b=eR125MQmuJgx7Cyp7Wadha+T2RJ6LdUhev3C/Vj5uWsTolWQL65AcZB9XCcZ8T/nGOH6gM
        OSBWJsJvu8sVRqH5KKZ9bDBGyXX6BRq3fFNLbgXyRGbgj1XmoBZMekwU+2CX+ddJGv1eT/
        bX1GkPqDcMjVzPYCODde2JZzBNJ2jKk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-343-Sgm9KCncMEipjdTeGIl6GQ-1; Tue, 08 Nov 2022 22:35:42 -0500
X-MC-Unique: Sgm9KCncMEipjdTeGIl6GQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 14B98101A528;
        Wed,  9 Nov 2022 03:35:42 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-86.pek2.redhat.com [10.72.12.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5C33B10197;
        Wed,  9 Nov 2022 03:35:37 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        stephen.s.brennan@oracle.com, urezki@gmail.com, hch@infradead.org,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH RFC 0/3] mm/vmalloc.c: allow vread() to read out vm_map_ram areas
Date:   Wed,  9 Nov 2022 11:35:31 +0800
Message-Id: <20221109033535.269229-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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
will skip the vm_map_ram area by 'if (!va->vm)' conditional checking.

Solution:
***
There are two types of vm_map_ram area. One is the whole vmap_area being
reserved and mapped at one time; the other is the whole vmap_area with
VMAP_BLOCK_SIZE size being reserved at one time, while mapped into split
regions with smaller size several times.

In patch 1 and 2, add flags into struct vmap_area to mark these two types
of vm_map_ram area, meanwhile add bitmap field used_map into struct
vmap_block to mark those regions being used to differentiate with dirty
and free regions.

With the help of above vmap_area->flags and vmap_block->used_map, we can
recognize them in vread() and handle them respectively.

Test:
***
I don't know what system has vm_map_ram() area. So just pass compiling
test and execute "makedumpfile --mem-usage /proc/kcore" to guarantee it
won't impact the old kcore reading.

	[root@ibm-x3950x6-01 ~]# free -h
	               total        used        free      shared  buff/cache   available
	Mem:           3.9Ti       3.6Gi       3.9Ti       7.0Mi       497Mi       3.9Ti
	Swap:          8.0Gi          0B       8.0Gi
	[root@ibm-x3950x6-01 ~]# makedumpfile --mem-usage /proc/kcore
	The kernel version is not supported.
	The makedumpfile operation may be incomplete.
	
	TYPE		PAGES			EXCLUDABLE	DESCRIPTION
	----------------------------------------------------------------------
	ZERO		327309          	yes		Pages filled with zero
	NON_PRI_CACHE	81750           	yes		Cache pages without private flag
	PRI_CACHE	83981           	yes		Cache pages with private flag
	USER		12735           	yes		User process pages
	FREE		1055688908      	yes		Free pages
	KERN_DATA	17464385        	no		Dumpable kernel data 
	
	page size:		4096            
	Total pages on system:	1073659068      
	Total size on system:	4397707542528    Byte


Baoquan He (3):
  mm/vmalloc.c: add used_map into vmap_block to track space of
    vmap_block
  mm/vmalloc.c: add flags to mark vm_map_ram area
  mm/vmalloc.c: allow vread() to read out vm_map_ram areas

 include/linux/vmalloc.h |  1 +
 mm/vmalloc.c            | 81 +++++++++++++++++++++++++++++++++++++----
 2 files changed, 75 insertions(+), 7 deletions(-)

-- 
2.34.1

