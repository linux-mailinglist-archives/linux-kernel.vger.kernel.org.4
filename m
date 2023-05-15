Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7FA702DE8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 15:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242261AbjEONTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 09:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242244AbjEONTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 09:19:06 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C3410E7
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 06:18:40 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-250175762b8so11100595a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 06:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684156719; x=1686748719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sHW4PAZciOvQN8kO9ncypAlcJrM+C64frREEyy2mYLs=;
        b=RXRsj1EZsY6H5AtAWlNnNwgRH9USWx7rFebmnNSxWVp7B1o8CDstfKLsgde6nsABW+
         pMXRGo37YS/kX6dHNMteA59tSoCGxbUBLZ6cO6Wq1ucLmJE1mXUSHZL5qT97ZRlk+fbJ
         YgjpDtflzI7axWqu49cUqsNwfPNMCiyD3qq/tywbO7P5f/mCdDy0qhzolJj52EcCpGAr
         GKc9dC3OBrqikC20SzF+ImqrLV8XP+pqYgT4oug34pP7t7GokRQqeHLdEQLgrABz7mAS
         Fw+7+talhdXjs4z04CsjkXHbdEZEdD1QbNbIUtQaIk+BveA94b6E915qmJKJ6sFUuUS/
         qcvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684156719; x=1686748719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sHW4PAZciOvQN8kO9ncypAlcJrM+C64frREEyy2mYLs=;
        b=GSIApPwJ7SZrRwH2MJsKEjqxx4PidutpiUwz+VxihY+ADgprG7ogY4D59jeb4HiEOY
         QNxYXGtp6hLnFr0FH6giqqDTXW59GPXdbAVYI3BZ+IcI88p8xaTj4iIgR73kOg710sce
         FgIqeTLPL3ioji7rV5d57hJsLfTj6lRrFl6sN6flDCPBPh2k1ryfb47gxOOoS4Zorkjt
         SGhCRTYdoSxRC/HVjQSthknSsjkUOpWP2SmHmLVC0joDMOT3FaWayKgs24EbQWs4aYcO
         9TJObbApvC71yPaIzdwIP/8jPJ2NM3s6DUoJ9zZegvwt9I15IXEyJzlct+3rLBJNYZYL
         vTQQ==
X-Gm-Message-State: AC+VfDxzR5r42foem8PSCxIUES2ikIA3VIb+uHvGk1HeMPdsRyT3QA0X
        aKIJ44wf5vbnmJYMKwA8g2KvvA==
X-Google-Smtp-Source: ACHHUZ7OPPdtpNM7SISNyCX81ZSswrdvwKVdZipovJWKD+wJP3pDOfgQHFOEVjljfMa+hOjEX6q3Ig==
X-Received: by 2002:a17:90b:3e81:b0:252:a0dc:7950 with SMTP id rj1-20020a17090b3e8100b00252a0dc7950mr13256790pjb.2.1684156719239;
        Mon, 15 May 2023 06:18:39 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id gl20-20020a17090b121400b0024749e7321bsm14190014pjb.6.2023.05.15.06.18.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 15 May 2023 06:18:39 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH 05/10] maple_tree: Make the code symmetrical in mas_wr_extend_null()
Date:   Mon, 15 May 2023 21:17:52 +0800
Message-Id: <20230515131757.60035-6-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230515131757.60035-1-zhangpeng.00@bytedance.com>
References: <20230515131757.60035-1-zhangpeng.00@bytedance.com>
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
---
 lib/maple_tree.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index fbb6efc40e576..4c649d75a4923 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4256,19 +4256,21 @@ static inline void mas_wr_extend_null(struct ma_wr_state *wr_mas)
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

