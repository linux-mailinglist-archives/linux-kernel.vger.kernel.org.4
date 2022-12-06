Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE7B644A13
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 18:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235752AbiLFROp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 12:14:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235687AbiLFRO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 12:14:26 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6139132B8C
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 09:14:20 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id m18so6273218eji.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 09:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10IT05+HKhb7xyirRRNdh88kI/5idGFXpcCcjOl6q8w=;
        b=uhHfurOuRNSHba5bcgYmHYTUiA0/YQOE6uTGKT8Nlcmry8Tts8/UpjfQ4dm10Rm3yF
         uwkMG3xtgqkmQ2FFsCCiTFe2q2QL5Ml99J3lDmyTYSbiu/vlsJJTOzc/rc6Ry1jRSKvY
         iqu4J98q8ZTNmGg26MTPVifMLjCyjIlyOmcx4ifNd5Tr368zq5meHCenw/bXIzm6w1FA
         fCnOb5UmPsn1+RqvMqwZKgSO2IcO8MmnYWogG426iZHQQb4cILJz/fSHqpNipzX9kxdN
         XCSKZBMRd1s3w6KC1U9lxsD54O3g3JBbdyxhjnR4Y8JhslpAg4hiNFX9CYv8+rpKR3at
         wjKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=10IT05+HKhb7xyirRRNdh88kI/5idGFXpcCcjOl6q8w=;
        b=T8I1WRudxIBsmblYfns9T4XbosX/zh5p8G9kBZ2VGBPgB0xx6Wvb5vsyrZFsyOHVls
         bmPjai+dgKW9DMD53ql9PD0WWsqMKclZ1GsOX+rF209xYZoiBff0ZTy5/poGpJrsUCU3
         mNaGF/tlP30p4RxmcfkIirPMF7mnYoDYvKy5lUhaXqxNyc8Ft0DDeqadXH9IemKOu3xk
         rHlwXJ8LVhGV+MfW5uU+AsTzjG5+xK4d8WkL1mA8GqjEJFkMiNCK77zGziZ1QnPRTkdN
         qOvAIDsIhJzKX+dPFDu5XlyPt2kSf3ec+wv4d70eGyfEEc14EEFfmCCgPTVUAi3Q5HNC
         OH+Q==
X-Gm-Message-State: ANoB5pm3ja+D+IjTHZMv/UzANKZudQqa8q+oSlyZpepil0ReJDuOIclR
        aF+Q2kgIHDtnyGNTMWzzoyv4XA==
X-Google-Smtp-Source: AA0mqf7kQJJ4LPTmjKqwgzg8jBUYoouC//Y9xZrafAmdsNdsR1Uk81RoFo7FkZKbUBxLLtJ04Q/PaA==
X-Received: by 2002:a17:906:32ce:b0:78d:9022:f146 with SMTP id k14-20020a17090632ce00b0078d9022f146mr56850399ejk.656.1670346859021;
        Tue, 06 Dec 2022 09:14:19 -0800 (PST)
Received: from localhost ([2a02:8070:6387:ab20:15aa:3c87:c206:d15e])
        by smtp.gmail.com with ESMTPSA id r11-20020a056402034b00b0045bd14e241csm1187950edw.76.2022.12.06.09.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 09:14:18 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] mm: rmap: remove lock_page_memcg()
Date:   Tue,  6 Dec 2022 18:13:40 +0100
Message-Id: <20221206171340.139790-3-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221206171340.139790-1-hannes@cmpxchg.org>
References: <20221206171340.139790-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous patch made sure charge moving only touches pages for
which page_mapped() is stable. lock_page_memcg() is no longer needed.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/rmap.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index b616870a09be..32e48b1c5847 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1222,9 +1222,6 @@ void page_add_anon_rmap(struct page *page,
 	bool compound = flags & RMAP_COMPOUND;
 	bool first = true;
 
-	if (unlikely(PageKsm(page)))
-		lock_page_memcg(page);
-
 	/* Is page being mapped by PTE? Is this its first map to be added? */
 	if (likely(!compound)) {
 		first = atomic_inc_and_test(&page->_mapcount);
@@ -1262,15 +1259,14 @@ void page_add_anon_rmap(struct page *page,
 	if (nr)
 		__mod_lruvec_page_state(page, NR_ANON_MAPPED, nr);
 
-	if (unlikely(PageKsm(page)))
-		unlock_page_memcg(page);
-
-	/* address might be in next vma when migration races vma_adjust */
-	else if (first)
-		__page_set_anon_rmap(page, vma, address,
-				     !!(flags & RMAP_EXCLUSIVE));
-	else
-		__page_check_anon_rmap(page, vma, address);
+	if (likely(!PageKsm(page))) {
+		/* address might be in next vma when migration races vma_adjust */
+		if (first)
+			__page_set_anon_rmap(page, vma, address,
+					     !!(flags & RMAP_EXCLUSIVE));
+		else
+			__page_check_anon_rmap(page, vma, address);
+	}
 
 	mlock_vma_page(page, vma, compound);
 }
@@ -1329,7 +1325,6 @@ void page_add_file_rmap(struct page *page,
 	bool first;
 
 	VM_BUG_ON_PAGE(compound && !PageTransHuge(page), page);
-	lock_page_memcg(page);
 
 	/* Is page being mapped by PTE? Is this its first map to be added? */
 	if (likely(!compound)) {
@@ -1365,7 +1360,6 @@ void page_add_file_rmap(struct page *page,
 			NR_SHMEM_PMDMAPPED : NR_FILE_PMDMAPPED, nr_pmdmapped);
 	if (nr)
 		__mod_lruvec_page_state(page, NR_FILE_MAPPED, nr);
-	unlock_page_memcg(page);
 
 	mlock_vma_page(page, vma, compound);
 }
@@ -1394,8 +1388,6 @@ void page_remove_rmap(struct page *page,
 		return;
 	}
 
-	lock_page_memcg(page);
-
 	/* Is page being unmapped by PTE? Is this its last map to be removed? */
 	if (likely(!compound)) {
 		last = atomic_add_negative(-1, &page->_mapcount);
@@ -1451,8 +1443,6 @@ void page_remove_rmap(struct page *page,
 	 * and remember that it's only reliable while mapped.
 	 */
 
-	unlock_page_memcg(page);
-
 	munlock_vma_page(page, vma, compound);
 }
 
-- 
2.38.1

