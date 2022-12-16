Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40BBA64EE32
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 16:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbiLPPwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 10:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbiLPPwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 10:52:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869A836C51
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 07:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671205878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t1N733mGfOZDIeBgBOLPf9hKyMpT23Vbs9QUhNwynbg=;
        b=g/odTUMQC38MTBi31Z1wOiOv28WTPLSd/+R/A0KhwjBYdDpqEG6q9+tgjSoCMrty6n74cc
        md1z4mCV6F4xhYZszrSZFwPF0PK4Qa9A7rOZDQ5opyC3iHyisOrLBedo0LI4WWhKWiF1s+
        QaGc2V6aqqqWS8RALrfjqXMxw9k+a6E=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-362-Qx61AxhiPuy9CElpUmT-eg-1; Fri, 16 Dec 2022 10:51:12 -0500
X-MC-Unique: Qx61AxhiPuy9CElpUmT-eg-1
Received: by mail-qv1-f72.google.com with SMTP id m4-20020ad44484000000b004c78122b496so1679694qvt.7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 07:51:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t1N733mGfOZDIeBgBOLPf9hKyMpT23Vbs9QUhNwynbg=;
        b=xJ9vOcURGPLlJUgfX3wi2AaiMm5ND8Y12ktadUxCJm5hbLQoQE9hU3m3FH043RwtVj
         noNxFCZVwI7NBEgQ4TEMUiZzPXn/2/bw3r+H+eTFDocgvVlSYAIx1WU2+8FckM5XQ8mL
         7s1XfOMYuGS+7xFThT9sF+hzm6Z9eSP8JQhSnqMePC/zIcap13j7XfAvsCBmbvsLqfXU
         OlyR86SMaWxNJVSBNlV+f32DYONT+xkeKjw/IWEUS7XIY0cNh5hTb80br9TjRgS7lFgV
         RGHs4K/3eATIDf2haumCqxbPE8L7/Kr7kmAHqZH7MVvUEuVg5EgTSdQmQvaVbzFdrtAx
         RnTA==
X-Gm-Message-State: ANoB5plBT6dCKIBwnKV/GN+CyZDSDpUSJYDbNN+8+Qig8ScbqND6jEkK
        jnwtpd4j5S7y3M+UARDRRaOvhf1MESgcKtsOruh2TEB4SN8x3o9jQZIUtzTsRzlh/1gySFbZoPl
        Oz50vLxaK1nOmx0H3rTR6sfaO932US75gwIjoZgB6rq/jdOlZn4yEO8/lIt/bpQLD4SkLWRSwtg
        ==
X-Received: by 2002:a0c:dd01:0:b0:4c6:fb9f:a327 with SMTP id u1-20020a0cdd01000000b004c6fb9fa327mr41198464qvk.29.1671205870676;
        Fri, 16 Dec 2022 07:51:10 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4FDmXNL5rmIhjVY1GIvpSpY4Qco5LlZXCExcuuFvXBDlMq/YlZ/u02dz6yRyxhRquFj5j+Cw==
X-Received: by 2002:a0c:dd01:0:b0:4c6:fb9f:a327 with SMTP id u1-20020a0cdd01000000b004c6fb9fa327mr41198425qvk.29.1671205870379;
        Fri, 16 Dec 2022 07:51:10 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-45-70-31-26-132.dsl.bell.ca. [70.31.26.132])
        by smtp.gmail.com with ESMTPSA id s81-20020a37a954000000b006eeb3165554sm1682297qke.19.2022.12.16.07.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 07:51:09 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        James Houghton <jthoughton@google.com>, peterx@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>
Subject: [PATCH v4 2/9] mm/hugetlb: Don't wait for migration entry during follow page
Date:   Fri, 16 Dec 2022 10:50:53 -0500
Message-Id: <20221216155100.2043537-3-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221216155100.2043537-1-peterx@redhat.com>
References: <20221216155100.2043537-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That's what the code does with !hugetlb pages, so we should logically do
the same for hugetlb, so migration entry will also be treated as no page.

This is probably also the last piece in follow_page code that may sleep,
the last one should be removed in cf994dd8af27 ("mm/gup: remove
FOLL_MIGRATION", 2022-11-16).

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 0dfe441f9f4d..8ccd55f9fbd3 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6380,7 +6380,6 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 	if (WARN_ON_ONCE(flags & FOLL_PIN))
 		return NULL;
 
-retry:
 	pte = huge_pte_offset(mm, haddr, huge_page_size(h));
 	if (!pte)
 		return NULL;
@@ -6403,16 +6402,6 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 			page = NULL;
 			goto out;
 		}
-	} else {
-		if (is_hugetlb_entry_migration(entry)) {
-			spin_unlock(ptl);
-			__migration_entry_wait_huge(pte, ptl);
-			goto retry;
-		}
-		/*
-		 * hwpoisoned entry is treated as no_page_table in
-		 * follow_page_mask().
-		 */
 	}
 out:
 	spin_unlock(ptl);
-- 
2.37.3

