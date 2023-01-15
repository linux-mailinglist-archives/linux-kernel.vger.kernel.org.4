Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2ED866B128
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 14:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjAONNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 08:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjAONN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 08:13:28 -0500
X-Greylist: delayed 912 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 15 Jan 2023 05:13:24 PST
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C75DAF76D
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 05:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=xNAta
        AqOvpyjV3Ls/qBn+/lBLTWnqKEHSAfzJvmQetk=; b=UZJMEJddxOKNwThW4rHdL
        NQ2QSoVh6OXrfkr60+oD9oFQTCE/cflcWrcDknwekV1Jsua6ZkIv5nCqco31YlSJ
        7xmceHZHBJi4E+5tbEWDFPPHmVvLUOvGNhZ9sjs/eoJlf+9eYCmzRZ8Do+x5S9e+
        EQUdxJY+1tmMOfs0CHyNIU=
Received: from whoami-VirtualBox.. (unknown [117.61.197.36])
        by zwqz-smtp-mta-g2-3 (Coremail) with SMTP id _____wAn3uY0+MNjHwPgAQ--.20982S2;
        Sun, 15 Jan 2023 20:57:26 +0800 (CST)
From:   Jinyu Tang <tjytimi@163.com>
To:     yuzhao@google.com, yuanchu@google.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, falcon@tinylab.org,
        ttjjyystupid@163.com, Jinyu Tang <tjytimi@163.com>
Subject: [PATCH v1] mm: multi-gen LRU: reduce repeated scans in rmap
Date:   Sun, 15 Jan 2023 20:57:21 +0800
Message-Id: <20230115125721.3553-1-tjytimi@163.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAn3uY0+MNjHwPgAQ--.20982S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw4rGryfJF1UKFyxGryxGrg_yoW8Aw17p3
        yDWayrJFWDXr1akrZrZrykXFyYvFWrKF4UtF13Ar9ak3W5JrnFkrWSy3Z5XF90kry8Ja48
        Xw4UJF4DWF9xJa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziaiiDUUUUU=
X-Originating-IP: [117.61.197.36]
X-CM-SenderInfo: xwm13xlpl6il2tof0z/xtbBRRr3eGI0ethXogAAsR
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The folio is physically and virtually contiguous. If a folio have
more than one pages, lru_gen_look_around() will run several times in
the while loop in folio_referenced_one(), but most of times is
unnecessary. Because these pages always belong to the same pmd and
vma, lru_gen_look_around() will scan the same range.

So add a variable to record the former pvmw.address to reduce
repeated scans if the pages of this folio don't sride across a pmd.

In most codes in memory management now, a folio just have one page,
the while loop in folio_referenced_one() just run one time, so this
patch actually may not reduce scans. But when other memory management
codes expand contiguous pages to a folio in the future, this patch
can be more effective.

Signed-off-by: Jinyu Tang <tjytimi@163.com>
---
 mm/rmap.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 2ec925e5fa6a..b11fcfe812e8 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -809,6 +809,7 @@ static bool folio_referenced_one(struct folio *folio,
 	struct folio_referenced_arg *pra = arg;
 	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, address, 0);
 	int referenced = 0;
+	unsigned long former_address = 0;
 
 	while (page_vma_mapped_walk(&pvmw)) {
 		address = pvmw.address;
@@ -825,7 +826,13 @@ static bool folio_referenced_one(struct folio *folio,
 		if (pvmw.pte) {
 			if (lru_gen_enabled() && pte_young(*pvmw.pte) &&
 			    !(vma->vm_flags & (VM_SEQ_READ | VM_RAND_READ))) {
-				lru_gen_look_around(&pvmw);
+				unsigned long pmd_now = pvmw.address & PMD_MASK;
+				unsigned long pmd_former = former_address & PMD_MASK;
+
+				if ((!former_address) || (pmd_now != pmd_former)) {
+					lru_gen_look_around(&pvmw);
+					former_address = pvmw.address;
+				}
 				referenced++;
 			}
 
-- 
2.30.2

