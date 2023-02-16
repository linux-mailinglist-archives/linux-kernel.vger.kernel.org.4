Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEB1698D44
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 07:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjBPGmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 01:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjBPGm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 01:42:29 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22682BBA6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 22:42:26 -0800 (PST)
Received: from localhost.localdomain (unknown [39.45.217.110])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1A30A660219C;
        Thu, 16 Feb 2023 06:42:22 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676529744;
        bh=M7QlyqeYtV2UlnIzxGzDOtk3LV88X9UD8SBF1GKpk74=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gtjiguMc1ox/cRrtHwHMVCqqQKZjlivuix+mk2HPqBPG0RDTXnrodYWaI33paHuT2
         MnwrFREwKzaKSWE4XnItQrhajqD7F0D157Z2RfM9dNiDbjJiDTQhmzsGQ3i2uV1894
         XkGgRXEOoJkI9C2vP/GYdQWub0zjuVk9yFx+t0Otn/cMUzWpmHSUQA+0cqTHuKiZw5
         SM1z4Efw1toiuoAK0+ztCcENXZKBC8sA250DbD3XN0MPZABXkwMawCyZqxyFyw1G3c
         YhXFry0lnJ8Q2INWo0qqRV+lFMPLF1AgrjUgUkIO9SZVG4KqRza2PNt4LRcDeceNDG
         O+rbk+iToXINw==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     peterx@redhat.com, david@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] mm/userfaultfd: add VM_WARN_ONCE()
Date:   Thu, 16 Feb 2023 11:41:55 +0500
Message-Id: <20230216064155.1500545-2-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230216064155.1500545-1-usama.anjum@collabora.com>
References: <20230216064155.1500545-1-usama.anjum@collabora.com>
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
index 366dc097ab11..9db77c36ef18 100644
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

