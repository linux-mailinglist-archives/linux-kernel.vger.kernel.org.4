Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94BCB706371
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjEQI7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjEQI7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:59:25 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DB730DE
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:58:58 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5304913530fso446405a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684313937; x=1686905937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PgePm/CbmI9b6FDUeL4Fm0Rwlug6tP8O/eeOWJHUuog=;
        b=CweT36VdUJkzd7EgyQjEpA/g6MONV8fPH2+11DoRZ4gl9z4pn4gx0f5yRC38Oo0kxK
         /hOZIMttxfmQcLJcRE12mcyOso3iB19zL2YRd6wnP2BIrfQ9RGYC/EvLPmu6VhcdRlST
         sb8J/NRQg37aubTJbQd4RYW/oGlOyZowBikpiRraOyZTAleG3Aei4bfYFIuWCbcYacJi
         n3z9EzW4KLf5MngHWtxR8texHVwmwCRUn05aw/7+E6mi4DaBv41SUTLcNOJDhAdcS5Ff
         rxYgtd5EXyH9Q96Fede6UlmrE+iWdPMfwBb+zROOYYpAeztuNSrfs/mZl23iOCt9k+oc
         YO0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684313937; x=1686905937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PgePm/CbmI9b6FDUeL4Fm0Rwlug6tP8O/eeOWJHUuog=;
        b=aupssNgSnE5HI5440PGZ+pVTBtjHaw9KFNlkURjYAv4WooeoCVxvTkmYb30AST6ouQ
         YT37GMhfZrgXSAqOZp5VvEKHgfaQP/nMGQILGLbyvdNrlMPuOkvVQuTHmPtijWKBxMDp
         jSXgbgyfocIjU/dX6PTW6KheGqyeV7UDhV9cGGGJj8B67ySCJSHiqj45Rok3Kx9bDJs4
         ihGgkpgif49G/Y067GybgwxcWxk2zfUuElHyMOwf5vDs6POez7o/J14sk4ljgMrWJBrt
         l6mk5GaPtTe9VUqyP6QVNnKVMc/lvXKy+fgdmGRUJwrBvzwLcxBlGa71a5Di2q84lveI
         +/WA==
X-Gm-Message-State: AC+VfDyzXgMTBiz0NPRpaJsI62PqRTnRLhZCzuhCtmu1//OLCNWjLbBm
        xpSgV3LdRdQQtl2IdsEgIBsLTw==
X-Google-Smtp-Source: ACHHUZ5Pdv2NaLOo7WcmzSQapiahkZn70TlS2n8UFh7QzMN8tnXEt5QRKZ2elo832+y79/XLpr8c8Q==
X-Received: by 2002:a05:6a20:a10d:b0:101:4d10:e40a with SMTP id q13-20020a056a20a10d00b001014d10e40amr37103525pzk.12.1684313937698;
        Wed, 17 May 2023 01:58:57 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id m18-20020a63ed52000000b0052c9d1533b6sm15056765pgk.56.2023.05.17.01.58.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 May 2023 01:58:57 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v2 04/10] maple_tree: Simplify mas_is_span_wr()
Date:   Wed, 17 May 2023 16:58:03 +0800
Message-Id: <20230517085809.86522-5-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230517085809.86522-1-zhangpeng.00@bytedance.com>
References: <20230517085809.86522-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the code for detecting spanning writes more concise.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 42 ++++++++++++++----------------------------
 1 file changed, 14 insertions(+), 28 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index bec9906b0c8c..82dccc660889 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -3728,43 +3728,29 @@ static inline void mas_store_root(struct ma_state *mas, void *entry)
  */
 static bool mas_is_span_wr(struct ma_wr_state *wr_mas)
 {
-	unsigned long max;
+	unsigned long max = wr_mas->r_max;
 	unsigned long last = wr_mas->mas->last;
-	unsigned long piv = wr_mas->r_max;
 	enum maple_type type = wr_mas->type;
 	void *entry = wr_mas->entry;
 
-	/* Contained in this pivot */
-	if (piv > last)
+	/* Contained in this pivot, fast path */
+	if (last < max)
 		return false;
-
-	max = wr_mas->mas->max;
-	if (unlikely(ma_is_leaf(type))) {
-		/* Fits in the node, but may span slots. */
-		if (last < max)
-			return false;
-
-		/* Writes to the end of the node but not null. */
-		if ((last == max) && entry)
-			return false;
-
+	if (ma_is_leaf(type))
+		max = wr_mas->mas->max;
+	if (last < max) {
+		/* Contained in this pivot or this leaf node */
+		return false;
+	} else if (last == max) {
 		/*
-		 * Writing ULONG_MAX is not a spanning write regardless of the
-		 * value being written as long as the range fits in the node.
+		 * The last entry of leaf node cannot be NULL unless it is the
+		 * rightmost node (writing ULONG_MAX), otherwise it spans slots.
+		 * If this is not leaf node, detect spanning store wr walk.
 		 */
-		if ((last == ULONG_MAX) && (last == max))
-			return false;
-	} else if (piv == last) {
-		if (entry)
-			return false;
-
-		/* Detect spanning store wr walk */
-		if (last == ULONG_MAX)
+		if (entry || last == ULONG_MAX)
 			return false;
 	}
-
-	trace_ma_write(__func__, wr_mas->mas, piv, entry);
-
+	trace_ma_write(__func__, wr_mas->mas, wr_mas->r_max, entry);
 	return true;
 }
 
-- 
2.20.1

