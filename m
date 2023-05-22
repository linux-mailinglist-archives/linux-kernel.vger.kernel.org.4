Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520E470B450
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 07:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbjEVFHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 01:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbjEVFHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 01:07:35 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29EEE9
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:07:33 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64d1a0d640cso3003221b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684732053; x=1687324053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eo5rcY2cJVWJgq5aXNebmW2HhW0q7JfmSI/nM1R46gk=;
        b=ZSCKQFXLVBYNVkVOOzDNCt0Mcj4KMH0eT5hciFj/maxy7uR2Fkn3XI9lMlN5I5K2mq
         Gkw8OaXA1zC3gwyZmCX2kCRi6LHedI7vC7pGlQ/tq/vEkC3qx84ASPAf41r2VFRD1XBm
         Qq35xPIr91V1EpeXuEklHJyGwYOOSZuXcKpt7zcnKzZgmUmXG7hRA8dpYUo1ZjYK6p9J
         f/UBHZMxPM3XmWhjiUvQ3km319KaunvQEQg7Wos7iycBYkWIlOSSwDwri3+W/KsmllFu
         OfpLB1SibWVW3lTR6xYe6IJvXPIhv0Nt/Z5NcrMSHbdAEZqqBED9UAwJNrLOiZY7L84J
         F0vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684732053; x=1687324053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eo5rcY2cJVWJgq5aXNebmW2HhW0q7JfmSI/nM1R46gk=;
        b=dvjGWBmOdx7GKN0jq+dj5REHnAtalNx19fA7D26E5/id+Ie0+94eIkAPtl6KJduJCa
         U8Ez2cQ8tv9vUGno3RDq1VbsINYQ6GA+eQrrp0As3+KhZdYW/c6aRezHCJ7cbqrarqoV
         QtRkGTG2ElyP+B8OFpo+a4MmhajI6SU9A+N193802Yh4nteYHdAv+SqNrXI5pIl/F+qU
         lnqHqa27+rAuIt6P5ON0THSnWdHUN6ulWJqjALenIAVRlFFidqabDAu8Xu5vsG5j6Tuo
         /pCE+TX3pnQGcehkQmjqz39JXwO9SNeL+DMHVFV+n01n9UAZ2c2oQLyjQB3jlDcUVJml
         jVeg==
X-Gm-Message-State: AC+VfDxC7wJ5ofwL1Td/pJKa7kH02/3wWn8+ZN2XXeDw5sQUY/QnsmHW
        bFYaqHSRvKB2x79KnmSD/DaUMw==
X-Google-Smtp-Source: ACHHUZ4MzY2LZNzu/pNjw410E/5PK7X/ZtRiKyw0Xmd7JdlNmnRSaFHeU1cNLXN3WvcR/RrqWRLy2A==
X-Received: by 2002:a05:6a00:9a4:b0:64d:2e8a:4ccb with SMTP id u36-20020a056a0009a400b0064d2e8a4ccbmr13674329pfg.14.1684732053316;
        Sun, 21 May 2023 22:07:33 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id t10-20020a62ea0a000000b0063b5776b073sm3247519pfh.117.2023.05.21.22.07.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 21 May 2023 22:07:33 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v3 05/10] maple_tree: Make the code symmetrical in mas_wr_extend_null()
Date:   Mon, 22 May 2023 13:06:51 +0800
Message-Id: <20230522050656.96215-6-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230522050656.96215-1-zhangpeng.00@bytedance.com>
References: <20230522050656.96215-1-zhangpeng.00@bytedance.com>
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

Just make the code symmetrical to improve readability.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index c47af84047a4..562507979a4b 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4265,19 +4265,21 @@ static inline void mas_wr_extend_null(struct ma_wr_state *wr_mas)
 {
 	struct ma_state *mas = wr_mas->mas;
 
-	if (mas->last < wr_mas->end_piv && !wr_mas->slots[wr_mas->offset_end])
+	if (!wr_mas->slots[wr_mas->offset_end]) {
+		/* If this one is null, the next and prev are not */
 		mas->last = wr_mas->end_piv;
-
-	/* Check next slot(s) if we are overwriting the end */
-	if ((mas->last == wr_mas->end_piv) &&
-	    (wr_mas->node_end != wr_mas->offset_end) &&
-	    !wr_mas->slots[wr_mas->offset_end + 1]) {
-		wr_mas->offset_end++;
-		if (wr_mas->offset_end == wr_mas->node_end)
-			mas->last = mas->max;
-		else
-			mas->last = wr_mas->pivots[wr_mas->offset_end];
-		wr_mas->end_piv = mas->last;
+	} else {
+		/* Check next slot(s) if we are overwriting the end */
+		if ((mas->last == wr_mas->end_piv) &&
+		    (wr_mas->node_end != wr_mas->offset_end) &&
+		    !wr_mas->slots[wr_mas->offset_end + 1]) {
+			wr_mas->offset_end++;
+			if (wr_mas->offset_end == wr_mas->node_end)
+				mas->last = mas->max;
+			else
+				mas->last = wr_mas->pivots[wr_mas->offset_end];
+			wr_mas->end_piv = mas->last;
+		}
 	}
 
 	if (!wr_mas->content) {
-- 
2.20.1

