Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD159634866
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 21:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbiKVUjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 15:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234777AbiKVUjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 15:39:13 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AF868C75
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 12:39:11 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-393c38f7bcfso128045147b3.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 12:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FPSzCF4B4ZUUfFv+NywISnCJ1Cav2tvMYf25Hqqvvgg=;
        b=Ylw0t/TQAkkJ5ZZ1Pjx3hAcFXh/aS80QxJujdVf6jQSIZZqenDDpuUnVzgNX6ILpOT
         D+OjVdmtDW5/tAPK26Gb1zGy/ZoTCNYUJRF0pyT+nwSM+/hfu38zrqKsPnMqXGmEd+xx
         cuUwYrnWdEWlYYI+NWRholXeyBpeozHwyScvQAjTUOFxdVVobSIfg3zrrhjVGUP9l7Px
         HcnmajR3YLpKxiUY3qDInKNDQjuM2qZP0Bd8vfd5A7IwOfoP5RK2bZZ11acFXKOU83kT
         GwdUHROVxNzf/nQ9nlj5eX8S+GZeK8I5hMFTQ/pyIzMVhZn83FC27sX4jgh9Me5r10Ge
         mRkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FPSzCF4B4ZUUfFv+NywISnCJ1Cav2tvMYf25Hqqvvgg=;
        b=hSg9oDOuTDIY7qYkqZIMmukoYNlf5GISiD+Eo0Ml7qK6I4frZ+gk3dB5UWFRXqFhS2
         wLVT8pl+UZEaHlELig428vlV/h7/+I57VR5FMA5ZI8Gl0r4X2paNT/Thj9NCDWjTYfkz
         MFnRfxPMW5Ljzo3VsSZTd3M9qBd+rCXW1kvn0ZmveulmR+DrkoFyQkvt/MUrZbxULF/k
         V9TRny6uySrE9/yIDcppPpTTvxlgrLl92nwbbyDod163xOVrK75bPJih4nK6Su1T+8/d
         z2rcKfXmkwnz99TFpM8sr2CLX5FNPKI7pEA47Rkf9V/hSai3OW6+AnFXEqMxxUgBTQBH
         FUmA==
X-Gm-Message-State: ANoB5pnMtnBKeBnTDw5t83zbimYs/3L+zf6iW5RHqONxqtylzbIExPoA
        TaamPS/HDvUtmBxelO2ajh91Z2O0epb1nIy52Q==
X-Google-Smtp-Source: AA0mqf5zIOUTB1IFL2y2aEl4Z42kcyhA+7NcLlkiYs3Zc4zWJSHdxsp+4pi/s7LSj0PB2eVCfSvbDfxnKCWTXWMg1w==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2d4:203:b7d0:497d:abe4:3e6f])
 (user=almasrymina job=sendgmr) by 2002:a25:cccc:0:b0:6de:afe7:1c27 with SMTP
 id l195-20020a25cccc000000b006deafe71c27mr2ybf.642.1669149550378; Tue, 22 Nov
 2022 12:39:10 -0800 (PST)
Date:   Tue, 22 Nov 2022 12:38:47 -0800
In-Reply-To: <20221122203850.2765015-1-almasrymina@google.com>
Mime-Version: 1.0
References: <20221122203850.2765015-1-almasrymina@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221122203850.2765015-3-almasrymina@google.com>
Subject: [RFC PATCH v1 3/4] mm: Fix demotion-only scanning anon pages
From:   Mina Almasry <almasrymina@google.com>
To:     Huang Ying <ying.huang@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, weixugc@google.com,
        shakeelb@google.com, gthelen@google.com, fvdl@google.com,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mina Almasry <almasrymina@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is likely a missed change from commit a2a36488a61c ("mm/vmscan: Consider
anonymous pages without swap"). Current logic is if !may_swap _or_
!can_reclaim_anon_pages() then we don't scan anon memory.

This should be an 'and'. We would like to scan anon memory if we may swap
or if we can_reclaim_anon_pages().

Fixes: commit a2a36488a61c ("mm/vmscan: Consider anonymous pages without swap")

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 8c1f5416d789..d7e509b3f07f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2931,7 +2931,7 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 	enum lru_list lru;

 	/* If we have no swap space, do not bother scanning anon folios. */
-	if (!sc->may_swap || !can_reclaim_anon_pages(memcg, pgdat->node_id, sc)) {
+	if (!sc->may_swap && !can_reclaim_anon_pages(memcg, pgdat->node_id, sc)) {
 		scan_balance = SCAN_FILE;
 		goto out;
 	}
--
2.38.1.584.g0f3c55d4c2-goog
