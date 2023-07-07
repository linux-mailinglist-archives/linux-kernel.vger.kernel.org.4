Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8D374AEE8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 12:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbjGGKqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 06:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjGGKqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 06:46:09 -0400
X-Greylist: delayed 721 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 07 Jul 2023 03:46:07 PDT
Received: from bjm7-spam01.kuaishou.com (smtpcn03.kuaishou.com [103.107.217.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB871737
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 03:46:06 -0700 (PDT)
Received: from bjm7-spam01.kuaishou.com (localhost [127.0.0.2] (may be forged))
        by bjm7-spam01.kuaishou.com with ESMTP id 367AY63d051707
        for <linux-kernel@vger.kernel.org>; Fri, 7 Jul 2023 18:34:06 +0800 (GMT-8)
        (envelope-from yangyifei03@kuaishou.com)
Received: from bjm7-pm-mail12.kuaishou.com ([172.28.1.94])
        by bjm7-spam01.kuaishou.com with ESMTPS id 367AWXfQ050673
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 7 Jul 2023 18:32:33 +0800 (GMT-8)
        (envelope-from yangyifei03@kuaishou.com)
DKIM-Signature: v=1; a=rsa-sha256; d=kuaishou.com; s=dkim; c=relaxed/relaxed;
        t=1688725813; h=from:subject:to:date:message-id;
        bh=elR/CUA67bIsrY8k02zjWmaLHSSZNGva7b2+ov2x4wY=;
        b=UuyMOdWC5iW9fEjfe1Vpy31A1lQ9H9REeiFSO7aFfHoRbJuwscXaaVRbdqwtD48iD9SMuxrWawJ
        l+NvtFDcR4vYQ3S38eqLAht9pDl+IQW+uBXabsLyKGW1UWoECjsOQZfLuvQWb0ue77/iN4Pkrkm86
        AUnOpFcmRH+s8a9nYTc=
Received: from public-zl-rs11.idczw.hb1.kwaidc.com (172.28.1.32) by
 bjm7-pm-mail12.kuaishou.com (172.28.1.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Fri, 7 Jul 2023 18:30:13 +0800
From:   Efly Young <yangyifei03@kuaishou.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] mm:vmscan: fix inaccurate reclaim during proactive reclaim
Date:   Fri, 7 Jul 2023 18:32:26 +0800
Message-ID: <20230707103226.38496-1-yangyifei03@kuaishou.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.28.1.32]
X-ClientProxiedBy: bjxm-pm-mail09.kuaishou.com (172.28.128.9) To
 bjm7-pm-mail12.kuaishou.com (172.28.1.94)
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: bjm7-spam01.kuaishou.com 367AY63d051707
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With commit f53af4285d77 ("mm: vmscan: fix extreme overreclaim
and swap floods"), proactive reclaim still seems inaccurate.

Our problematic scene also are almost anon pages. Request 1G
by writing memory.reclaim will reclaim 1.7G or other values
more than 1G by swapping.

This try to fix the inaccurate reclaim problem.

Signed-off-by: Efly Young <yangyifei03@kuaishou.com>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 9c1c5e8b..2aea8d9 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -6208,7 +6208,7 @@ static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 	unsigned long nr_to_scan;
 	enum lru_list lru;
 	unsigned long nr_reclaimed = 0;
-	unsigned long nr_to_reclaim = sc->nr_to_reclaim;
+	unsigned long nr_to_reclaim = (sc->nr_to_reclaim - sc->nr_reclaimed);
 	bool proportional_reclaim;
 	struct blk_plug plug;
 
-- 
1.8.3.1

