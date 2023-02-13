Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB432694CF2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 17:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjBMQcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 11:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjBMQbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 11:31:50 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA121DBD5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 08:31:46 -0800 (PST)
Received: from localhost.localdomain (unknown [39.45.179.179])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9B3276602149;
        Mon, 13 Feb 2023 16:31:43 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676305905;
        bh=zXPbJqCldaAU06/Pl15/EuPbGqrq9pdX/EO4Oo9v1hc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GYFOIYPmxJOzBKz1ZV9fqB+BQADrG3NwplIW6YVJvdlwMcF900XODPcitVTeMK+xu
         WyzYsudjY2R0JcqaW0yu+kJjo4I2Y2Ktr4vOe8ItJX8fERsZLx/mlS3FcyoUROreqD
         04wSEDRf2I1KSq3MSFXmP+Org06bmw3vWmE5n2DN+gDw2DqPPGQqO4u2fuJeq/3Q1k
         O2JW0/FF5FGvPOdeNKqofOVsixD9WHdLZVNG1p3O0cBuR3bxaaObpw9J6V+hqzZJ5j
         34sbj4V4u2gcbXyYW9zdXNQww0NppB1iq++eIsgoAULWBJLUftJYUY/XduedhHk0Na
         bRDn8Iu/ee5ow==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     peterx@redhat.com, david@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] mm/userfaultfd: add VM_WARN_ONCE()
Date:   Mon, 13 Feb 2023 21:31:24 +0500
Message-Id: <20230213163124.2850816-2-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230213163124.2850816-1-usama.anjum@collabora.com>
References: <20230213163124.2850816-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add VM_WARN_ONCE() to uffd_wp_range() to detect range (start, len) abuse.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 mm/userfaultfd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index bccea08005a8..14ec88301511 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -716,6 +716,8 @@ void uffd_wp_range(struct mm_struct *dst_mm, struct vm_area_struct *dst_vma,
 	unsigned int mm_cp_flags;
 	struct mmu_gather tlb;
 
+	VM_WARN_ONCE(start < dst_vma->vm_start || start + len > dst_vma->vm_end,
+		     "The address range exceeds VMA boundary.\n");
 	if (enable_wp)
 		mm_cp_flags = MM_CP_UFFD_WP;
 	else
-- 
2.39.1

