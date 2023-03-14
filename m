Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289C56B9437
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 13:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbjCNMnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 08:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbjCNMnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 08:43:10 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365FCB479
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 05:42:26 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id cn6so2661994pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 05:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1678797741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6gfvzdPPIJNGgSXDt2FDnmzg914LTKb84rb4IiYC554=;
        b=ix7uri1ILEEPiyasmKqakK5ccU2YG24dfCqDDUm43gJDsFxSpoQlzQG6Qa5vAndQXl
         jMsc70HggeW+6NgiokrIJmXArEGC7yYYQFla6ShFJyEAu682f+SnE7+XfbcrU66ksx4k
         4kFZv0Dv44qxaNHR7T52669L7YDxYZP8MT6K0pu3uVwc9FzRsE26xZIDVpEpoMyw28YW
         MOOhI9tAbzpkS1N0dmHOI8A3Mjy9YteguHhhITQL9vclsticEYAqAYzAg9nbqA/MOwqh
         1X/UnNuLY7zn0mc1PHipCaOAx3+hJALDo3nOjHAZK3iZrjkSJ7K3Sx5kaOdlPd/iXTXb
         3Yww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678797741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6gfvzdPPIJNGgSXDt2FDnmzg914LTKb84rb4IiYC554=;
        b=NQQFZJeRa7aKRpKXdQdv/GDJv4FxS3WpfYbzr5UPXAVXsaB9YNwo8wVP7TLAL+kQx/
         JXukAicTNBAA9e4xExlwTa0/DUiUBCau6iiDONuVjUibm4hsa6B3YSMtCNwNiiWElNMk
         +Ja4ontLhKrG5Xgr3ezJ5LYyhZsUTkcVheGstXF9FLbOXPgtfGaK0hF03ZqdLQ+GL2+I
         MH1a9KKLpd0MOirUih7DIgGlUbq3dMxgnSnkc5P7BqcKGQkJANh8CQpv0jshYmeBgcwZ
         5xi+pu90DqvidgmyayEW6gDG/wSOGwv7DWksmHzwzAwjMFFbsrkxXST+gbi+8AienMhL
         s88g==
X-Gm-Message-State: AO0yUKXRvHR8v4txIfphtyx+ZYwtVPzFBtgszS9zISslQslreksWIfxQ
        JdxqJRWafmH0HTwjGRKVheB/76iRS5A/WmmEqvQ=
X-Google-Smtp-Source: AK7set866q8ia7BqTKzVyRrZrn8XKi3vOB+iHtRWLixU8F08+MZkneSL6K4NMfRCAB9Z+YCcxDUR4A==
X-Received: by 2002:a05:6a20:1bdd:b0:cd:87ef:3f21 with SMTP id cv29-20020a056a201bdd00b000cd87ef3f21mr36837359pzb.8.1678797741688;
        Tue, 14 Mar 2023 05:42:21 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id s11-20020aa7828b000000b005ded5d2d571sm1509385pfm.185.2023.03.14.05.42.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Mar 2023 05:42:21 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v2 2/3] maple_tree: Simplify mas_wr_node_walk()
Date:   Tue, 14 Mar 2023 20:42:02 +0800
Message-Id: <20230314124203.91572-3-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230314124203.91572-1-zhangpeng.00@bytedance.com>
References: <20230314124203.91572-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify code of mas_wr_node_walk() without changing functionality,
and improve readability. Remove some special judgments. Instead of
dynamically recording the min and max in the loop, get the final min
and max directly at the end.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 34 +++++-----------------------------
 1 file changed, 5 insertions(+), 29 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index b3164266cfde..4d15202a0692 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -2251,9 +2251,7 @@ static inline struct maple_enode *mte_node_or_none(struct maple_enode *enode)
 static inline void mas_wr_node_walk(struct ma_wr_state *wr_mas)
 {
 	struct ma_state *mas = wr_mas->mas;
-	unsigned char count;
-	unsigned char offset;
-	unsigned long index, min, max;
+	unsigned char count, offset;
 
 	if (unlikely(ma_is_dense(wr_mas->type))) {
 		wr_mas->r_max = wr_mas->r_min = mas->index;
@@ -2266,34 +2264,12 @@ static inline void mas_wr_node_walk(struct ma_wr_state *wr_mas)
 	count = wr_mas->node_end = ma_data_end(wr_mas->node, wr_mas->type,
 					       wr_mas->pivots, mas->max);
 	offset = mas->offset;
-	min = mas_safe_min(mas, wr_mas->pivots, offset);
-	if (unlikely(offset == count))
-		goto max;
-
-	max = wr_mas->pivots[offset];
-	index = mas->index;
-	if (unlikely(index <= max))
-		goto done;
-
-	if (unlikely(!max && offset))
-		goto max;
 
-	min = max + 1;
-	while (++offset < count) {
-		max = wr_mas->pivots[offset];
-		if (index <= max)
-			goto done;
-		else if (unlikely(!max))
-			break;
-
-		min = max + 1;
-	}
+	while (offset < count && mas->index > wr_mas->pivots[offset])
+		offset++;
 
-max:
-	max = mas->max;
-done:
-	wr_mas->r_max = max;
-	wr_mas->r_min = min;
+	wr_mas->r_max = offset < count ? wr_mas->pivots[offset] : mas->max;
+	wr_mas->r_min = mas_safe_min(mas, wr_mas->pivots, offset);
 	wr_mas->offset_end = mas->offset = offset;
 }
 
-- 
2.20.1

