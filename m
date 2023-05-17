Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39C8706372
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjEQI7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbjEQI70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:59:26 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0BF30E0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:59:00 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-51b4ef5378bso439197a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684313940; x=1686905940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DxGBvrxxE77Ame9f1Z/CNikWB0RCA3Ncw948p+DNd2w=;
        b=hhZrHVT2VkGePkTiFFK4sSJd8tqamGMy8odrTM0tq7wmPGJpAVOC0d1on3Km9zXhzT
         y8D2OMuQprZsBQ1bkis77HuCjfKIWwbuujAGqKb6WVCab0myyW1TjTLmBulCtJRtb9++
         2nB5U1ur2jcEfvhed4ojCjG7XmkcUqePqFrzix4mfSpruFIr1e8Mm9LUOi4pYiwjBsVG
         Pb5fkZ6DlRSwVN5ADq+nQsZbVmfD4u/sXOD5KDkFqXds9wgkLdi9ywBUFX9W9V7yLQSP
         PcvmydPGz6L3A3m5f1hb1GPVXqXcyqapyMDTTKZwica43fM2ZzRKYIb2sGKWzoOhUc6X
         YQuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684313940; x=1686905940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DxGBvrxxE77Ame9f1Z/CNikWB0RCA3Ncw948p+DNd2w=;
        b=csPjQV3IJCqht5MXVz7YhumC12g7EHJnlXPzXlqcaghshPl+qgqoZgWQ6rUqEx7RHu
         exKZePI4UX6W/Sx5A/9x+bFoQEVYHALzgSM88Qn369aWGAJGpt3CEFWSblIkxWq4rDFg
         En8veSH7lAlV+jQ8rUM52KVf4W62Q/DD0/pyEZqpx93RlTwN4Zuj1u98m83mBAVaWyUv
         Q1FK1EYZnd6YlAMSvxuOwD/BotzCHuGyvZBqKwqS5g0wJICdn1lCEjJ5HrMLl7AzgBlk
         myodPFdjm2+dyMlTcBVeTg/+t4btQ4psmrgQ0N0iHXifPC1im9u89TW3ymBK/DG0o/UW
         3teQ==
X-Gm-Message-State: AC+VfDwMiOIcagNHPQO58wL2eShF902QlnbwjYM/v1c7H5Bl5Fqt5SbR
        VSotEgmiXnqI2Erpx1nS4adLvw==
X-Google-Smtp-Source: ACHHUZ4e152x5dK9Z0TzZC1Vveb2UGWQnunzngonUT+kThkHDvgyajgacA18i4gRmC54ibhcq0RIZA==
X-Received: by 2002:a05:6a20:244b:b0:100:a9e3:17d4 with SMTP id t11-20020a056a20244b00b00100a9e317d4mr40707827pzc.0.1684313940513;
        Wed, 17 May 2023 01:59:00 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id m18-20020a63ed52000000b0052c9d1533b6sm15056765pgk.56.2023.05.17.01.58.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 May 2023 01:59:00 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v2 05/10] maple_tree: Make the code symmetrical in mas_wr_extend_null()
Date:   Wed, 17 May 2023 16:58:04 +0800
Message-Id: <20230517085809.86522-6-zhangpeng.00@bytedance.com>
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

Just make the code symmetrical to improve readability.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 82dccc660889..f881bce1a9f6 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4262,19 +4262,21 @@ static inline void mas_wr_extend_null(struct ma_wr_state *wr_mas)
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

