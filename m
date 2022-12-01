Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023A463FC13
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 00:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbiLAXdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 18:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbiLAXdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 18:33:22 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2390413F
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 15:33:22 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id e185-20020a2569c2000000b006f28dd5da75so3320969ybc.19
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 15:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j5xM6059haRL2w3Ml8a9OvL6hEZxMiznHTFr64Muu3Y=;
        b=ewb56XgkB8OJ94EaI97ZNlJi8hda6Yr2t8q/bkmq3CwmXRsSaDFbJ3M2qcP3Yj2dKA
         x+WXST6VfgBddgE2zHpubheKMa0xiWrMKYNegpChRy0JHvzkCgwNg0C39luwmaKTBPct
         xzsWH5vK6uM04ozXYjeyVqAdfMDNK5298lLSIoNCLJuM6ZqXwohnfue0mu1WJ0bVx8HG
         q8KUfKfm9KdhsuVz1Sb4NfzeW/s1BqCPvIdF4pPry0GId2KBTQ0jsJopvKeiJ7Vta/tW
         7NSD0AV3P8ivtFJwq588AHC2zW4gjr5w2x6KE71cC2dzC4zTiGFheA9Gk4KQSBrqLyXb
         fuwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j5xM6059haRL2w3Ml8a9OvL6hEZxMiznHTFr64Muu3Y=;
        b=grAfoxpf13NsJz3KMKJKOuIPxawgUefoZZq/SbTKEibR+9dr92PddwoFTnzPhHTGCD
         Bt8sY83KWx22t+IYEBV1pG4CE+iOaPlean2BwoYbepUVTpjJVTp0T/iw+787LQE4mnfq
         D75GWg1ciMG7VIeGXEDkXiUSbz/u2m6Sj+9nLVVzj9kJUDNgBt7JWypY1ToUZyEeib05
         BCm56CDLAyIWEaedzbuUfwbVdqRaICRwojWTN7ESLqm4mQXvuZhsvbDAZ8t+IHdfbUuo
         3KUpEvVYaUIAiXWCYuFt2C6zN9NSj+nDWLibox8eSjvHib8wLq7vjmHGLxcNft1FzkEu
         K0uQ==
X-Gm-Message-State: ANoB5plZ6GNXYjSTpepX9n2EvU0OZbTov55JqVJynGVMJwgROKHnp7U/
        H2AKV0XOakq2TyaAnGJDGlqJpwUMoXDElDtpYg==
X-Google-Smtp-Source: AA0mqf6KQU6tuDVl1pJYFk7jClux0jWzfMz7wsgxiZKagx1M0EFtB2nfBvK7fKwyYR+G6wQ4nvVr/fFBymw+KEnPAg==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2d4:203:4f7:4c6:3f81:f009])
 (user=almasrymina job=sendgmr) by 2002:a25:c447:0:b0:6f8:784:efb9 with SMTP
 id u68-20020a25c447000000b006f80784efb9mr17934822ybf.334.1669937601439; Thu,
 01 Dec 2022 15:33:21 -0800 (PST)
Date:   Thu,  1 Dec 2022 15:33:17 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221201233317.1394958-1-almasrymina@google.com>
Subject: [PATCH v1] mm: disable top-tier fallback to reclaim on proactive reclaim
From:   Mina Almasry <almasrymina@google.com>
To:     Huang Ying <ying.huang@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, weixugc@google.com,
        shakeelb@google.com, gthelen@google.com, fvdl@google.com,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mina Almasry <almasrymina@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reclaiming directly from top tier nodes breaks the aging pipeline of
memory tiers.  If we have a RAM -> CXL -> storage hierarchy, we
should demote from RAM to CXL and from CXL to storage. If we reclaim
a page from RAM, it means we 'demote' it directly from RAM to storage,
bypassing potentially a huge amount of pages colder than it in CXL.

However disabling reclaim from top tier nodes entirely would cause ooms
in edge scenarios where lower tier memory is unreclaimable for whatever
reason, e.g. memory being mlocked() or too hot to reclaim.  In these
cases we would rather the job run with a performance regression rather
than it oom altogether.

However, we can disable reclaim from top tier nodes for proactive reclaim.
That reclaim is not real memory pressure, and we don't have any cause to
be breaking the aging pipeline.

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 mm/vmscan.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 23fc5b523764..6eb130e57920 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2088,10 +2088,31 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 	nr_reclaimed += demote_folio_list(&demote_folios, pgdat);
 	/* Folios that could not be demoted are still in @demote_folios */
 	if (!list_empty(&demote_folios)) {
-		/* Folios which weren't demoted go back on @folio_list for retry: */
+		/*
+		 * Folios which weren't demoted go back on @folio_list.
+		 */
 		list_splice_init(&demote_folios, folio_list);
-		do_demote_pass = false;
-		goto retry;
+
+		/*
+		 * goto retry to reclaim the undemoted folios in folio_list if
+		 * desired.
+		 *
+		 * Reclaiming directly from top tier nodes is not often desired
+		 * due to it breaking the LRU ordering: in general memory
+		 * should be reclaimed from lower tier nodes and demoted from
+		 * top tier nodes.
+		 *
+		 * However, disabling reclaim from top tier nodes entirely
+		 * would cause ooms in edge scenarios where lower tier memory
+		 * is unreclaimable for whatever reason, eg memory being
+		 * mlocked or too hot to reclaim. We can disable reclaim
+		 * from top tier nodes in proactive reclaim though as that is
+		 * not real memory pressure.
+		 */
+		if (!sc->proactive) {
+			do_demote_pass = false;
+			goto retry;
+		}
 	}

 	pgactivate = stat->nr_activate[0] + stat->nr_activate[1];
--
2.39.0.rc0.267.gcb52ba06e7-goog
