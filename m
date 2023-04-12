Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83056DF9D5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 17:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjDLPYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 11:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjDLPYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 11:24:00 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9956EA1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 08:23:41 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id bl15so10098560qtb.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 08:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1681313020; x=1683905020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/E244aiAIcJteNUm2g4L6wCEgk4wHVyuDmdP/JQSqeM=;
        b=Kp9E8Fd/WTrYSSeoo9KBh1EftdY3j+iuaOJTMcIvpFxA2yPnI3cDartcEmE7A9/Agf
         oyYsrrwGfKn5NzQCtxcbog/wucmjejZx6KPj7Tp4LY6v1WQS3n6wcTTIhUN0L9VJ/D+D
         Cd7QmiowIfGjwME5ia6RCy8QLRzk1AECUKluPcK3RMq1VYncfv7Vdtjv3pfWa1oztjFW
         7HeYoQMVerCbNDjyHsAXA1Nt6j9hXO3D7L1LCDJ4uEN+jv3Z7mh/D6ER92Yvw+laY7g4
         oBalJAWScdUdRo9t6zfsse9mDN3hW2hDb5gGxpELlfPMHzcRFAGusr8MNHAe667T2w/c
         jKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681313020; x=1683905020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/E244aiAIcJteNUm2g4L6wCEgk4wHVyuDmdP/JQSqeM=;
        b=bficxyi7OWT+nmYyDVmySeSRvstivm3Fy11S05rVmeO6INAz1ep+A/7GW8d9fPIE/u
         IyZ0cS6y5b2aJkS5jxGLrw0vWJSPd7aeLpIdpl57VD8EpP6wQV5nQkJlHZnuAzWf8tFq
         ajScP6l+qSph+nEMRpIswBGDyts1/1E8/ZGY66dpb2UqUk2ZfSfK38DiOXK0cHo3j3pL
         DyUj3vV673xgFZXfXEM7vf83bJfYn+3qc+sINye4KFdkZssgyZZmrWi8cZybpeElHS2U
         n6VJ6mYhgOuhttsjMfQKMjz/AXd5QXjxYdIFa8RGStK5+5QmLelv77We7iyF42UIAASI
         3H8A==
X-Gm-Message-State: AAQBX9eCHAyHI2v417TG6FiiJyPQjz9Sgy0FqHTTdnbmVPH5Eqpo610r
        a50vcr4v0oTL2MnM5X643h+dVQ==
X-Google-Smtp-Source: AKy350YdHHKPja00olWR+pbPgiAi8UG3+5u351p3NI4uYhU7UksPv84K8e5Odt3i/EYydukTbCGCEQ==
X-Received: by 2002:ac8:5a46:0:b0:3e4:ed0d:6a87 with SMTP id o6-20020ac85a46000000b003e4ed0d6a87mr4107807qta.32.1681313019992;
        Wed, 12 Apr 2023 08:23:39 -0700 (PDT)
Received: from soleen.c.googlers.com.com (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id he35-20020a05622a602300b003d9650a7a9csm3154296qtb.46.2023.04.12.08.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 08:23:39 -0700 (PDT)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, muchun.song@linux.dev,
        rientjes@google.com, souravpanda@google.com
Subject: [PATCH] mm: hugetlb_vmemmap: provide stronger vmemmap allocaction gurantees
Date:   Wed, 12 Apr 2023 15:23:37 +0000
Message-Id: <20230412152337.1203254-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HugeTLB pages have a struct page optimizations where struct pages for tail
pages are freed. However, when HugeTLB pages are destroyed, the memory for
struct pages (vmemmap) need to be allocated again.

Currently, __GFP_NORETRY flag is used to allocate the memory for vmemmap,
but given that this flag makes very little effort to actually reclaim
memory the returning of huge pages back to the system can be problem. Lets
use __GFP_RETRY_MAYFAIL instead. This flag is also performs graceful
reclaim without causing ooms, but at least it may perform a few retries,
and will fail only when there is genuinely little amount of unused memory
in the system.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Suggested-by: David Rientjes <rientjes@google.com>
---
 mm/hugetlb_vmemmap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index a559037cce00..c4226d2af7cc 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -475,9 +475,12 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
 	 * the range is mapped to the page which @vmemmap_reuse is mapped to.
 	 * When a HugeTLB page is freed to the buddy allocator, previously
 	 * discarded vmemmap pages must be allocated and remapping.
+	 *
+	 * Use __GFP_RETRY_MAYFAIL to fail only when there is genuinely little
+	 * unused memory in the system.
 	 */
 	ret = vmemmap_remap_alloc(vmemmap_start, vmemmap_end, vmemmap_reuse,
-				  GFP_KERNEL | __GFP_NORETRY | __GFP_THISNODE);
+				  GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_THISNODE);
 	if (!ret) {
 		ClearHPageVmemmapOptimized(head);
 		static_branch_dec(&hugetlb_optimize_vmemmap_key);
-- 
2.40.0.577.gac1e443424-goog

