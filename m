Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDC3612D06
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 22:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiJ3VcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 17:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiJ3Vbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 17:31:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE7BBC81
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 14:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667165447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=18dXjMMHISRNlhGaFpCwLJgIneJr5paDcQBCMHn2vKI=;
        b=RPpNh4jEPEssaaPDA/aG59xRNzUMZNX1O+j+TdjkMqX5KZZp+pj+q25cxjNwdoQImZdZuU
        bl1R+dDKOrCpGLa/t3MfG5JJQkpqrwg4e+2TueDjQkyh7KGjCKJPyC87FgpN/uFz3p/GCr
        EmGqRHq3u0zyjL8oT4wcopwXxfHkMTw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-338-IcsO8kabPgyEphmiN16L2A-1; Sun, 30 Oct 2022 17:30:46 -0400
X-MC-Unique: IcsO8kabPgyEphmiN16L2A-1
Received: by mail-qk1-f200.google.com with SMTP id bp10-20020a05620a458a00b006fa29f253dcso1142465qkb.11
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 14:30:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=18dXjMMHISRNlhGaFpCwLJgIneJr5paDcQBCMHn2vKI=;
        b=EGBVSY7FfPD9nHOGgh9/tKMGMQkqc51AS14waXVwslDUJaqqhusQ+ZqUZT1jrbmv56
         Rw3h86SQ/IpbED6pgH0SVZvKvREgwvKfjVafUY20dMT64bt8CrN/sQOMYzxY1h95ywOW
         bBl096OxQg16HQyDC8b2KGzrAE2ReQ16IDxEIky7bKPnlEO1AnTUnM7+yP6zScQer8yZ
         81v8xxbkcR2X2IyPdwTjRQ4blWW/nuQ/k/0mT8SS/QcTP+jH9n/C8aRD/gGjCHI1ZXC6
         1e0zujxCd41mhqOG3JgAJxe4oPkbHs034quBpXrvJuzNwhsnqULBW17ysv60Wkp578nw
         7bpA==
X-Gm-Message-State: ACrzQf0fiJ8n5prZLhfDlhPcNsIlHVE+F6Z35fJ1bvy5+V5bWl4BLdj2
        SiYQNi3IRoawEFKXf8V7yHNCntBaC89t/2dicQcRQXp1x1Ld2WuUpn6hQwsdOtqX6faBOuL2X2y
        D9T8K/bj4dQXw/MmxeqfqytP2
X-Received: by 2002:a05:6214:262f:b0:4b6:89bc:3ba4 with SMTP id gv15-20020a056214262f00b004b689bc3ba4mr8361028qvb.44.1667165445900;
        Sun, 30 Oct 2022 14:30:45 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4WHS7WPiG6eK0xCLe5+DVpxce9WhNLEtvaEGwRBNhlLTs5Fva2fkLlQL6Z/FlVCcCkdSkbsQ==
X-Received: by 2002:a05:6214:262f:b0:4b6:89bc:3ba4 with SMTP id gv15-20020a056214262f00b004b689bc3ba4mr8361010qvb.44.1667165445716;
        Sun, 30 Oct 2022 14:30:45 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id i3-20020a05620a248300b006ee9d734479sm3533891qkn.33.2022.10.30.14.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 14:30:45 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     James Houghton <jthoughton@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>, peterx@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH RFC 09/10] mm/hugetlb: Make hugetlb_fault() RCU-safe
Date:   Sun, 30 Oct 2022 17:30:43 -0400
Message-Id: <20221030213043.335669-1-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221030212929.335473-1-peterx@redhat.com>
References: <20221030212929.335473-1-peterx@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RCU makes sure the pte_t* won't go away from under us.  Please refer to the
comment above huge_pte_offset() for more information.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 5dc87e4e6780..6d336d286394 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5822,6 +5822,8 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	int need_wait_lock = 0;
 	unsigned long haddr = address & huge_page_mask(h);
 
+	/* For huge_pte_offset() */
+	rcu_read_lock();
 	ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
 	if (ptep) {
 		/*
@@ -5830,13 +5832,15 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		 * not actually modifying content here.
 		 */
 		entry = huge_ptep_get(ptep);
+		rcu_read_unlock();
 		if (unlikely(is_hugetlb_entry_migration(entry))) {
 			migration_entry_wait_huge(vma, ptep);
 			return 0;
 		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry)))
 			return VM_FAULT_HWPOISON_LARGE |
 				VM_FAULT_SET_HINDEX(hstate_index(h));
-	}
+	} else
+		rcu_read_unlock();
 
 	/*
 	 * Serialize hugepage allocation and instantiation, so that we don't
-- 
2.37.3

