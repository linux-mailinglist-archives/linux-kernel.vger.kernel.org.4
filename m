Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295806F8527
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 17:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbjEEPAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 11:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbjEEPAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 11:00:15 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C60217DD6
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 07:59:50 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64115eef620so20215718b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 07:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1683298789; x=1685890789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bMT3CTvNOAP4fCjxDVg1BNstksZl3tnW2Myn+79x8Cw=;
        b=QwEB81Ilrk88iqDgvmlnlkgY1xH/viUbnGvJIFCcTSa1/z5yxz10LKsGBVYzgcsZuX
         Y8VncuvEQdxKiuu7XU6cI7UiCWnAo9hy/57xcgqHl8Uh9DQL6odiJWFInMmVUsIpPNOd
         6ReuzFiIJXtbdqvB2l+niWIPjPMXMNEPYa9kCThz6rmWzhRfqTEQzE5n+4wTiZ6M5Hrl
         DtpC2hpUpDLpRKS9Z+8qut8FG0ln+rashaBjgrXavbCRk2Xc6tRHV56kiXRYZXQlI4iK
         PtLyGq62Icg65t0xI0NHnRbh483/MfTaI0Jlg/KH7u9uiHE7bJU8MhB9Ag5bUHb/QDSg
         byGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683298789; x=1685890789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bMT3CTvNOAP4fCjxDVg1BNstksZl3tnW2Myn+79x8Cw=;
        b=WQM3EjeppZ1MNRB7SjN7u6h/9EgPAj5AHzMulVV3H6QJjI6MDGKNDSah9p6LFM0uB/
         BUEosfAtt4mcdXPqZ/w7YcY67XLyvurAs1AIXTiE7qsnx/k9LcxmA1QCFFVmBxcNdvuw
         QCdqDT4aAMRDwnWLPpKHcTuGvo5hfHH7K5+70QeoCPKYnDY0cgs1Ia0Fkul4qIZTOF3m
         UGHwew8lllEhhFvOwGwIjdXVoTFng2F6c/67Fkvec2/cnGmvXxkvBRcPY4fuMoEJxmPF
         Eu1+k+LNk8idGOLIzjWtbc9O+0acGT/1NdDMj//ZEoECj5TGdliw2iqT0CkmBCwPvZvA
         Fn7Q==
X-Gm-Message-State: AC+VfDw1TNESZxWOAjYcCy+8i7rlQ1S3QMiexmIbCdIjd2Zr5WIrdhwZ
        VXSqO9NfwLPpTWAHdCaWOMV6+w==
X-Google-Smtp-Source: ACHHUZ6FuVUAXC00F96fqcdHC1SI4rCfWrNHMf4zPD4ZuMK39P5kvxpDXzGvNw0oL9QZNMtop4ou7w==
X-Received: by 2002:a17:90b:350d:b0:246:9517:30b6 with SMTP id ls13-20020a17090b350d00b00246951730b6mr7007998pjb.4.1683298789614;
        Fri, 05 May 2023 07:59:49 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id jx12-20020a17090b46cc00b0024e0141353dsm5193761pjb.28.2023.05.05.07.59.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 05 May 2023 07:59:49 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Tad <support@spotco.us>,
        Michael Keyes <mgkeyes@vigovproductions.net>,
        Stable@vger.kernel.org
Subject: [PATCH v2] maple_tree: Make maple state reusable after mas_empty_area()
Date:   Fri,  5 May 2023 22:58:29 +0800
Message-Id: <20230505145829.74574-1-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make mas->min and mas->max point to a node range instead of a leaf entry
range. This allows mas to still be usable after mas_empty_area() returns.
Users would get unexpected results from other operations on the maple
state after calling the affected function.

Reported-by: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Reported-by: Tad <support@spotco.us>
Reported-by: Michael Keyes <mgkeyes@vigovproductions.net>
Link: https://lore.kernel.org/linux-mm/32f156ba80010fd97dbaf0a0cdfc84366608624d.camel@intel.com/
Link: https://lore.kernel.org/linux-mm/e6108286ac025c268964a7ead3aab9899f9bc6e9.camel@spotco.us/
Fixes: 54a611b60590 ("Maple Tree: add new data structure")
Cc: <Stable@vger.kernel.org>
Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 110a36479dced..8ebc43d4cc8c5 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5317,15 +5317,9 @@ int mas_empty_area(struct ma_state *mas, unsigned long min,
 
 	mt = mte_node_type(mas->node);
 	pivots = ma_pivots(mas_mn(mas), mt);
-	if (offset)
-		mas->min = pivots[offset - 1] + 1;
-
-	if (offset < mt_pivots[mt])
-		mas->max = pivots[offset];
-
-	if (mas->index < mas->min)
-		mas->index = mas->min;
-
+	min = mas_safe_min(mas, pivots, offset);
+	if (mas->index < min)
+		mas->index = min;
 	mas->last = mas->index + size - 1;
 	return 0;
 }
-- 
2.20.1

