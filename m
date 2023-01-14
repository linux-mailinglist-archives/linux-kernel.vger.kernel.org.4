Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D56566A76A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 01:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbjANAQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 19:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbjANAQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 19:16:31 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2095026E6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 16:16:28 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id w3so25028574ply.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 16:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/KjcC4vdn0F8bwHPm7aH8/jU0gejjB6PredV8xmX1m8=;
        b=arrSrn4L+VBsJd77YJD8ctZh/KRnLsYulABJcTjOdPsLbpnHB3YR44IYBDCjYNq1tG
         3kqEV2HjQiFgS5hPnM8e8aawAgoxrBDhUsejPDYvPmE8paMVjPiOAbxZGVsipLE0ORKF
         umVciZnOpsYKRccyQtgnMCi3LYllnDGScc8QmsyFH71obCJGtIhWvmdObv73mUrf05Hv
         orHDT5xtJjnIXsb+3dGi+z5yDIIfVmP3t9zt7pW2CeaCwx9zRdG1ZKMGEYC2CaPxyzlY
         VClZOxqKTSbQdPwuVkHoXgR6QpWzTXUxyAUCATUb7wnkrZaPmHSz3BhyfLtutzOd8SDJ
         sH3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/KjcC4vdn0F8bwHPm7aH8/jU0gejjB6PredV8xmX1m8=;
        b=YFdUGAypNFkiIJ+gSmikxFR9CLUfE61+Slq4W3yTdD0ZIDzJyE+OrMt1Wn7/gNsTMc
         bLTDMuWgckrXxWB2Q+w9PNGDHQdMcPVjZbhayfGX2hDW4HltfnF+8Rdd/RMMmrSGOJ9k
         6NEZ/evMao3zcRsHCwG5UyvQHbhfcnaD+iBy0nQG6cOpJsMLIz02O8jgLFDLdN/IpAeF
         uQLQS4CA3ImlDDMIsEFv+26op3wXM3+QY+N9Rok4mEJX6sZ8RoJRLl4I48bYTDHu6g+U
         oj7wEaSWEiRwspYXkcF1HNFQDYwNL1KwzNzdu7C1Dkt0kVu0NspDraxkiGUv2egKjwcq
         SZIw==
X-Gm-Message-State: AFqh2kpSSKu7lJEoBsBX47ED1TgaIGXnuq2PztA1daHKyi6D2Gaf01Yh
        IP06QEFCExAh2TiGTvjfr/s=
X-Google-Smtp-Source: AMrXdXu1WR7K6RyKti4hXxLv2+gB+N7RA/seu5IQRIR3O9VXK1EAKlIv6NrvJOxpNkqjKc4NH4o0PQ==
X-Received: by 2002:a05:6a21:3944:b0:a3:754c:2769 with SMTP id ac4-20020a056a21394400b000a3754c2769mr96572284pzc.40.1673655387606;
        Fri, 13 Jan 2023 16:16:27 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::2e58])
        by smtp.googlemail.com with ESMTPSA id nl5-20020a17090b384500b0020b21019086sm4064541pjb.3.2023.01.13.16.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 16:16:27 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 1/2] mm/khugepaged: Introduce release_pte_folio() to replace release_pte_page()
Date:   Fri, 13 Jan 2023 16:15:55 -0800
Message-Id: <20230114001556.43795-1-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

release_pte_page() is converted to be a wrapper for release_pte_folio()
to help facilitate the khugepaged conversion to folios.

This replaces 3 calls to compound_head() with 1, and saves 85 bytes of
kernel text.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/khugepaged.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index e1c7c1f357ef..4888e8688401 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -492,13 +492,18 @@ void __khugepaged_exit(struct mm_struct *mm)
 	}
 }
 
+static void release_pte_folio(struct folio *folio)
+{
+	node_stat_mod_folio(folio,
+			NR_ISOLATED_ANON + folio_is_file_lru(folio),
+			-folio_nr_pages(folio));
+	folio_unlock(folio);
+	folio_putback_lru(folio);
+}
+
 static void release_pte_page(struct page *page)
 {
-	mod_node_page_state(page_pgdat(page),
-			NR_ISOLATED_ANON + page_is_file_lru(page),
-			-compound_nr(page));
-	unlock_page(page);
-	putback_lru_page(page);
+	release_pte_folio(page_folio(page));
 }
 
 static void release_pte_pages(pte_t *pte, pte_t *_pte,
-- 
2.38.1

