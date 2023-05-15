Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED07702DE6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 15:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242326AbjEONTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 09:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242161AbjEONTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 09:19:01 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3B21FC1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 06:18:36 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1ab1b79d3a7so87373935ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 06:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684156716; x=1686748716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUBDvQ6OxE85hUN75/9d6LlRGyHmdnE5erOpWtw5OfM=;
        b=h6Vztwd3Q0rJzgXIQWj9b7a7rcwv/TKvfWHjSn7rPgPVnAwzRGI2GP2i+o8GYuMB5E
         aFz5inFtgIpGyz7XUMKZ8NAGKJ2UwZd/ZzAsQAY/TwHMA4dDvZVjhcKJH8cmgzKa5Swx
         p7DSkm4BzQ79R2MDK7TXkdd1dZguunFOryYbs46vMi+egL28fjmiOO8jIrx4iOF7vr9i
         OKY+sLoB5kvFPjKxPj9sWkbW/s0CEXb2sziSUikSXgmAk/sgii1jOrPbYFVaMPRcUgCE
         xd68Wj7Am3v6yO7HSaTtRVlczCvuTvBSSnCmKeycX0FpAHhU7HQbnQ2JhGJPm6fRGUeY
         drcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684156716; x=1686748716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aUBDvQ6OxE85hUN75/9d6LlRGyHmdnE5erOpWtw5OfM=;
        b=Edon8czEWICPxWiLwf8eso8JOaeLsbcaxSq7EHN0nh+3zqwNlciC/rTfu1KfPi5H9v
         WFtCPujSVCfO5mEf1vO6yGpqnNP4UFZOYLvW5eDlD0g/Xp9Tno/PIdk3818tB7Ieg8q0
         9tiENXLh9ij0D6lieECok3E+XjiuWALn8nMHFoGuzMIUPdyybjuduEq+eeGj5wwRI6Qc
         ss6b4PNEdCZLan9IVW7e0tM6FWj60w0N5+8EHlVRDA4/04VeS7xGjXDvrP/t7IwcbdMH
         qh880ygCdixQE1kmJkvOq0w8Cp22McMmXvB2RXuuYUE+veMreUR0PJwyFbTbHX7HVDxu
         P+mA==
X-Gm-Message-State: AC+VfDzc0U1Bi8OyLo2CLum50FeQJCqM3YDW9uo4QnTPHJrIfYA2GuMw
        XmQ/D8CAJf7PXUsWpZtge4s1/g==
X-Google-Smtp-Source: ACHHUZ6NrR5fyigxrygUBYxmthRBGrO6hqW7vNZiQJ/rNSdTeNHwNJLwR56D8E8MgAQzd/+5PFOylQ==
X-Received: by 2002:a17:902:dace:b0:1ac:6e1f:d1bd with SMTP id q14-20020a170902dace00b001ac6e1fd1bdmr37436369plx.19.1684156716446;
        Mon, 15 May 2023 06:18:36 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id gl20-20020a17090b121400b0024749e7321bsm14190014pjb.6.2023.05.15.06.18.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 15 May 2023 06:18:36 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH 04/10] maple_tree: Simplify mas_is_span_wr()
Date:   Mon, 15 May 2023 21:17:51 +0800
Message-Id: <20230515131757.60035-5-zhangpeng.00@bytedance.com>
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

Make the code for detecting spanning writes more concise.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 36 +++++++++---------------------------
 1 file changed, 9 insertions(+), 27 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 43a25d3042c1b..fbb6efc40e576 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -3728,41 +3728,23 @@ static bool mas_is_span_wr(struct ma_wr_state *wr_mas)
 {
 	unsigned long max;
 	unsigned long last = wr_mas->mas->last;
-	unsigned long piv = wr_mas->r_max;
 	enum maple_type type = wr_mas->type;
 	void *entry = wr_mas->entry;
 
-	/* Contained in this pivot */
-	if (piv > last)
+	max = unlikely(ma_is_leaf(type)) ? wr_mas->mas->max : wr_mas->r_max;
+	if (last < max) {
+		/* Contained in this pivot or this leaf node */
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

