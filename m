Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0053E5B7ECA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 04:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiINCAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 22:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiINCAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 22:00:05 -0400
Received: from mailgw.kylinos.cn (unknown [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8B0201A2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 18:59:59 -0700 (PDT)
X-UUID: 4d4ef284744541329d009dfceea0b86b-20220914
X-CPASD-INFO: f7874b5afde54a14a5064046803bb73e@r4dyV2GUY5GShKeBg6R8boFmYGZkXFS
        FempTkpBnX4WVhH5xTV5uYFV9fWtVYV9dYVR6eGxQYmBgZFJ4i3-XblBgXoZgUZB3tXlyV2SQZQ==
X-CLOUD-ID: f7874b5afde54a14a5064046803bb73e
X-CPASD-SUMMARY: SIP:-1,APTIP:-2.0,KEY:0.0,FROMBLOCK:1,OB:0.0,URL:-5,TVAL:198.
        0,ESV:0.0,ECOM:-5.0,ML:0.0,FD:0.0,CUTS:167.0,IP:-2.0,MAL:-5.0,PHF:-5.0,PHC:-5
        .0,SPF:4.0,EDMS:-5,IPLABEL:-2.0,FROMTO:0,AD:0,FFOB:0.0,CFOB:0.0,SPC:0,SIG:-5,
        AUF:0,DUF:4672,ACD:79,DCD:79,SL:0,EISP:0,AG:0,CFC:0.825,CFSR:0.038,UAT:0,RAF:
        0,IMG:-5.0,DFA:0,DTA:0,IBL:-2.0,ADI:-5,SBL:0,REDM:0,REIP:0,ESB:0,ATTNUM:0,EAF
        :0,CID:-5.0,VERSION:2.3.17
X-CPASD-ID: 4d4ef284744541329d009dfceea0b86b-20220914
X-CPASD-BLOCK: 1000
X-CPASD-STAGE: 1
X-UUID: 4d4ef284744541329d009dfceea0b86b-20220914
X-User: sunke@kylinos.cn
Received: from sk-yoga-14sarh-2021.lan [(118.250.49.117)] by mailgw
        (envelope-from <sunke@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 2027479164; Wed, 14 Sep 2022 10:00:28 +0800
From:   Ke Sun <sunke@kylinos.cn>
To:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Ke Sun <sunke@kylinos.cn>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH] mm/filemap: Make folio_put_wait_locked static
Date:   Wed, 14 Sep 2022 09:58:36 +0800
Message-Id: <20220914015836.3193197-1-sunke@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,RDNS_DYNAMIC,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's only used in mm/filemap.c, since commit <ffa65753c431>
("mm/migrate.c: rework migration_entry_wait() to not take a pageref").

Make it static.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: Ke Sun <sunke@kylinos.cn>
---
 include/linux/pagemap.h | 1 -
 mm/filemap.c            | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 0178b2040ea3..82880993dd1a 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1042,7 +1042,6 @@ static inline int wait_on_page_locked_killable(struct page *page)
 	return folio_wait_locked_killable(page_folio(page));
 }
 
-int folio_put_wait_locked(struct folio *folio, int state);
 void wait_on_page_writeback(struct page *page);
 void folio_wait_writeback(struct folio *folio);
 int folio_wait_writeback_killable(struct folio *folio);
diff --git a/mm/filemap.c b/mm/filemap.c
index 15800334147b..ade9b7bfe7fc 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1467,7 +1467,7 @@ EXPORT_SYMBOL(folio_wait_bit_killable);
  *
  * Return: 0 if the folio was unlocked or -EINTR if interrupted by a signal.
  */
-int folio_put_wait_locked(struct folio *folio, int state)
+static int folio_put_wait_locked(struct folio *folio, int state)
 {
 	return folio_wait_bit_common(folio, PG_locked, state, DROP);
 }
-- 
2.25.1

