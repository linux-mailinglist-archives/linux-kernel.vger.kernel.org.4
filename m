Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93ADA670E54
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 01:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjARADx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 19:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjARADQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 19:03:16 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AD3BD14B
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 15:16:40 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id b10so2483702pjo.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 15:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gTiyHD7Ef/752rEDI0F/LBvIYY0+LQDTJtaLZSqbVXc=;
        b=kOHVN4iCCmfxv/zeMoeqp1NIDCtKrp3hBek5mMJSon6a/fiUKWljfakQaTg8gv/rm0
         FcO/VFOYSl46GbdZAOp3L81OQ4NMnkVuIngOcoBNCdGaqrkn+TT90/HU5K6Gb04DIXum
         Pug1+4LyQZeU8NUjAmeV6W7wHa/IaFckbaRGSRS1nRrfsTqTFlfbqkfiRdW12W5fb58v
         qJkso7ivSEnXfhkEJnroxGe/+H9/8mY0Niyj9Qv5ADD5cCEqkbgjg3fzZ4bCmCJP4FRu
         wtDP3Hy4Y9yo/qv/9lu6EzoAdy98bMM/ElSSd8PhoeKIc8t0VVQSilNV6W9GsG0LUmqs
         P12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gTiyHD7Ef/752rEDI0F/LBvIYY0+LQDTJtaLZSqbVXc=;
        b=7KBNU+FRkUwycTtp4wjc9e/FeT06d6U/lbk9XfQS+EBWiPceeOS4myHfxokUtWpLIY
         J9f0aXyRU6cyaqP13xU6HPYlvRfdXhGsff31vPtzJKSFjk5JAjL5uZpcAxsYZGOzA0NJ
         BCphjtLEWmCJfIhoK7pDGDT6MlrQP/6pjM0DF6SlFSHw3N2fO+Tim13l4sOngilvn5fX
         1X15AtLCkbmHbn7Shh/dr9pMgRy/w1DZ/SM+FDIJ8ASgNUOPVj+w0aXVc3s0pWlDa4CN
         ixd378k5xdeicBQuv6yZy/vbXdB4V++AU/vLWz3m3CQNZf34/YaCKAZTwGu7jNxL9X8D
         0QFw==
X-Gm-Message-State: AFqh2kpFxHt+SiI7rzk5mJAJaF4XpZnBTMWZKi+Khjhu5RsKfIJvGyzi
        7lbk3723WFRWvauORwowOj0=
X-Google-Smtp-Source: AMrXdXuoGPnt0eAYkj7iSPPjbAuqd8tFEbpGverST+idm85MqQnUhGUuQkjo3Rol7XmplIK3mdIY8w==
X-Received: by 2002:a05:6a20:939f:b0:b8:99e3:4835 with SMTP id x31-20020a056a20939f00b000b899e34835mr5398685pzh.17.1673997399645;
        Tue, 17 Jan 2023 15:16:39 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:27ce:97b5:ee13:dbfe])
        by smtp.gmail.com with ESMTPSA id c24-20020aa79538000000b0057447bb0ddcsm5180965pfp.49.2023.01.17.15.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 15:16:39 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>, SeongJae Park <sj@kernel.org>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH 2/3] mm: return boolean for deactivate_page
Date:   Tue, 17 Jan 2023 15:16:31 -0800
Message-Id: <20230117231632.2734737-2-minchan@kernel.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20230117231632.2734737-1-minchan@kernel.org>
References: <20230117231632.2734737-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Returns true if the page was successfully deactivated. The return value will
be used for statistics in next patch.

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 include/linux/swap.h | 2 +-
 mm/swap.c            | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 0ada46b595cd..803e5fa4cd86 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -409,7 +409,7 @@ extern void lru_add_drain(void);
 extern void lru_add_drain_cpu(int cpu);
 extern void lru_add_drain_cpu_zone(struct zone *zone);
 extern void lru_add_drain_all(void);
-extern void deactivate_page(struct page *page);
+extern bool deactivate_page(struct page *page);
 extern void mark_page_lazyfree(struct page *page);
 extern void swap_setup(void);
 
diff --git a/mm/swap.c b/mm/swap.c
index 955930f41d20..52532859c05b 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -725,9 +725,9 @@ void deactivate_file_folio(struct folio *folio)
  *
  * deactivate_page() moves @page to the inactive list if @page was on the active
  * list and was not an unevictable page.  This is done to accelerate the reclaim
- * of @page.
+ * of @page. If page was deactivated successfully, returns true.
  */
-void deactivate_page(struct page *page)
+bool deactivate_page(struct page *page)
 {
 	struct folio *folio = page_folio(page);
 
@@ -740,7 +740,9 @@ void deactivate_page(struct page *page)
 		fbatch = this_cpu_ptr(&cpu_fbatches.lru_deactivate);
 		folio_batch_add_and_move(fbatch, folio, lru_deactivate_fn);
 		local_unlock(&cpu_fbatches.lock);
+		return true;
 	}
+	return false;
 }
 
 /**
-- 
2.39.0.314.g84b9a713c41-goog

