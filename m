Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32BE72EE56
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 23:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240528AbjFMVzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 17:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbjFMVy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 17:54:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9A81BDA
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 14:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686693251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nVhPI7Qoz7ZqnzsG9+Pwmnk6AKrA3Y9yvdpVEt0mHXM=;
        b=D5w6/rEXPnNuZccOm0IGyU7DxTPzzNTB1q6pvGDJ8fcJtyGF601vQuZ4DPfrFDTibFN96T
        kCjSq5AZbf6Mii5yW7x5672VwCVR+orT2u0cND+AWKWJhb2WL2yTvHlN4/8jJnkY3mn3xS
        pWB6izUF++9ZqIigsmgQOVI95Nk9Cd0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-um5Iev9jM6-lj1Mt6ltFQQ-1; Tue, 13 Jun 2023 17:54:01 -0400
X-MC-Unique: um5Iev9jM6-lj1Mt6ltFQQ-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-3fb2e6ca6eeso2354341cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 14:54:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686693240; x=1689285240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nVhPI7Qoz7ZqnzsG9+Pwmnk6AKrA3Y9yvdpVEt0mHXM=;
        b=C/IkRDqnSdoerU5bi0Fhw1AbXTZ5ueAMOiUk8D8ZNv3dhVhtuWR5g1AjAQjbmMDj5i
         jg/gR+lPQIE1+vGCGF1dQUaVy2CmAtou+OqS6w9ofZrOeuqMJJwaXEsETcfm2+AYYDrG
         Hn424eNPQp2rPL2FB/qihlC1/BFz6AONlzCf6F5F/HlPb9errCraPKgGObOGDQnl9xQb
         W1nUlD/E7dC2Yr+UDkBXLoCZ2IrDiTZFVRtScWfec66OSY6NiDVP/gfJjNt8r2r/JZIC
         6LRBkw4YhsNBGtps0IOY3c7SDZNsUG6drsgtNIpInPxn0x/wW1a83dgqA/3ZxNn+MJ0P
         YnpA==
X-Gm-Message-State: AC+VfDxc/5l/M4xt8wpe+gFi3t3jcsGYCbhjznNSNxzX4SdKL3pTt85+
        EK2NqOONaMCkwMnA79tLA8pFBHGc0KXkSbALTkkpEIILXe2TvaK6Jl73YhLM5d9eE2GFcLgbZvH
        6nUQmZ2r1RTmEjBQEs5DMMfeU6009FBPgMMsbFFno2I1flv9+O7ofaBBcaaswv6jWovDYqQYqK4
        NVFeaGbA==
X-Received: by 2002:a05:622a:288:b0:3ef:3dc3:4a3e with SMTP id z8-20020a05622a028800b003ef3dc34a3emr17942049qtw.0.1686693239911;
        Tue, 13 Jun 2023 14:53:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4MJSKcPdnj4lChUYnJRMcBfBWV2PeylliGTEYFlrviAqe21ltK55iRSzWqqMvZUCA8so0tsg==
X-Received: by 2002:a05:622a:288:b0:3ef:3dc3:4a3e with SMTP id z8-20020a05622a028800b003ef3dc34a3emr17942021qtw.0.1686693239513;
        Tue, 13 Jun 2023 14:53:59 -0700 (PDT)
Received: from x1n.redhat.com (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id fz24-20020a05622a5a9800b003f9bccc3182sm4522330qtb.32.2023.06.13.14.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 14:53:58 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, peterx@redhat.com,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Hugh Dickins <hughd@google.com>
Subject: [PATCH 4/7] mm/hugetlb: Prepare hugetlb_follow_page_mask() for FOLL_PIN
Date:   Tue, 13 Jun 2023 17:53:43 -0400
Message-Id: <20230613215346.1022773-5-peterx@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230613215346.1022773-1-peterx@redhat.com>
References: <20230613215346.1022773-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's coming, not yet, but soon.  Loose the restriction.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f037eaf9d819..31d8f18bc2e4 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6467,13 +6467,6 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 	spinlock_t *ptl;
 	pte_t *pte, entry;
 
-	/*
-	 * FOLL_PIN is not supported for follow_page(). Ordinary GUP goes via
-	 * follow_hugetlb_page().
-	 */
-	if (WARN_ON_ONCE(flags & FOLL_PIN))
-		return NULL;
-
 	hugetlb_vma_lock_read(vma);
 	pte = hugetlb_walk(vma, haddr, huge_page_size(h));
 	if (!pte)
-- 
2.40.1

