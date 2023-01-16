Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7398C66BB35
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 11:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjAPKHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 05:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjAPKGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 05:06:44 -0500
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE37C4C22
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 02:05:56 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 99B421863D00;
        Mon, 16 Jan 2023 13:05:52 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 4dgrfdgRyiYb; Mon, 16 Jan 2023 13:05:52 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 3B51D1863CA9;
        Mon, 16 Jan 2023 13:05:52 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2xqAhuCC3QDV; Mon, 16 Jan 2023 13:05:52 +0300 (MSK)
Received: from ekaterina-MACHD-WXX9.astralinux.ru (unknown [10.177.20.29])
        by mail.astralinux.ru (Postfix) with ESMTPSA id 998E11863CA7;
        Mon, 16 Jan 2023 13:05:51 +0300 (MSK)
From:   Esina Ekaterina <eesina@astralinux.ru>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Esina Ekaterina <eesina@astralinux.ru>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: [PATCH mm] mm: hugetlb: Add checks for NULL for vma returned from find_vma. find_vma may return NULL, that's why its return value  is usually checked for NULL.
Date:   Mon, 16 Jan 2023 13:05:20 +0300
Message-Id: <20230116100520.71277-1-eesina@astralinux.ru>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Found by Astra Linux on behalf of Linux Verification Center
(linuxtesting.org) with SVACE.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Esina Ekaterina <eesina@astralinux.ru>
---
 mm/hugetlb.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 3499b3803384..2162bfcf8f46 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5394,9 +5394,6 @@ void adjust_range_if_pmd_sharing_possible(struct vm=
_area_struct *vma,
 pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr, pud_t *p=
ud)
 {
 	struct vm_area_struct *vma =3D find_vma(mm, addr);
-	struct address_space *mapping =3D vma->vm_file->f_mapping;
-	pgoff_t idx =3D ((addr - vma->vm_start) >> PAGE_SHIFT) +
-			vma->vm_pgoff;
 	struct vm_area_struct *svma;
 	unsigned long saddr;
 	pte_t *spte =3D NULL;
@@ -5406,18 +5403,25 @@ pte_t *huge_pmd_share(struct mm_struct *mm, unsig=
ned long addr, pud_t *pud)
 	if (!vma_shareable(vma, addr))
 		return (pte_t *)pmd_alloc(mm, pud, addr);
=20
-	i_mmap_assert_locked(mapping);
-	vma_interval_tree_foreach(svma, &mapping->i_mmap, idx, idx) {
-		if (svma =3D=3D vma)
-			continue;
+	if (vma && vma->vm_file && vm->vm_file->f_mapping
+		&& vma->vm_start && vma->vm->vm_pgoff) {
+		struct address_space *mapping =3D vma->vm_file->f_mapping;
+		pgoff_t idx =3D ((addr - vma->vm_start) >> PAGE_SHIFT) +
+			vma->vm_pgoff;
=20
-		saddr =3D page_table_shareable(svma, vma, addr, idx);
-		if (saddr) {
-			spte =3D huge_pte_offset(svma->vm_mm, saddr,
-					       vma_mmu_pagesize(svma));
-			if (spte) {
-				get_page(virt_to_page(spte));
-				break;
+		i_mmap_assert_locked(mapping);
+		vma_interval_tree_foreach(svma, &mapping->i_mmap, idx, idx) {
+			if (svma =3D=3D vma)
+				continue;
+
+			saddr =3D page_table_shareable(svma, vma, addr, idx);
+			if (saddr) {
+				spte =3D huge_pte_offset(svma->vm_mm, saddr,
+							vma_mmu_pagesize(svma));
+				if (spte) {
+					get_page(virt_to_page(spte));
+					break;
+				}
 			}
 		}
 	}
--=20
2.39.0

