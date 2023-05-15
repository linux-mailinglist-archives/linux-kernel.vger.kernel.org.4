Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6D4702DE4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 15:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242283AbjEONTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 09:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242126AbjEONTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 09:19:00 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF5C19AE
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 06:18:34 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-64ab2a37812so19850730b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 06:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684156713; x=1686748713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eE6bxJv4UCRwtMUAfojMihpw2t2wf00Glyx+cFFRLZY=;
        b=i/UBgAcvtHHk0md0xZxj0CroBxW4tMrmR2bdSTljlwKSLUD37aMCqdoB3xk08hTz8B
         ufwwpJ4/L8cFSKLhE/WqTszR14LYvDzpcrIs/zqzfddiaq+2m2lw0NJCccNrlxMYyUvJ
         z+6U/6D/Qxi0hOTLOqKuqc5SYDLXl3MalzJyFHBS690apJ25rDfSJMcS5XNL7Ad4MgoG
         2ZruXFiyPzOqwMXcHF1dtyY9Ilkr7c+KJiyAfj3qLEGXNCE+n1yWwNIF9IM3kY5B2ipY
         kRutjohJOwPgYtotGv0CjxTX4YlT2ubdXf6t1Lx3YoAzu+mX2+WJ34qbuIwPJloqSmRd
         USGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684156713; x=1686748713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eE6bxJv4UCRwtMUAfojMihpw2t2wf00Glyx+cFFRLZY=;
        b=f/pnXCjAos5xuHFEOGX1ydddRn6H9dbJzfjsKitgOE9Sgu/86zdG8uFanMrerXk2Dp
         Juhx34Erm0c57HA7hemJSIcG+gE54CS3MCZV/NoVy/QteBfShOvoUuysJ1eGohxBG8a0
         lO1QeojkBw1FdxNeF2CfNp0cRFvopbtwEsVcjiI2ABQx6qdG5L8NIaVCK8UT7XecA+3/
         3KUpuNXJVUE1sU9MKY918NzrNEz/rI/RhIJhS71jmJAi08tGyeup95B8g8xn8l18oqIu
         0Ldi6vwbIBsONmcrGam2DTRat/gPNZ3y3Uoq1Vq+4GCeYmWTjCEygwgeIg0pd2NI/by9
         s86g==
X-Gm-Message-State: AC+VfDwm0mKftVx3yLAR2Nd1FElA6eGXoLvyQgEmcguPGo7ziXtcPDhj
        rkxEra/s+cyS9wY7Rjg0JkIR1g==
X-Google-Smtp-Source: ACHHUZ4ax8TBpv+8pqbDdmKnaFXdcM8+Si6LkP9bFQfT0YYvQy8V42QO+LcbU93Ang12fqFYOt+cCQ==
X-Received: by 2002:a17:90a:bb05:b0:250:af6d:bd7b with SMTP id u5-20020a17090abb0500b00250af6dbd7bmr22794048pjr.24.1684156713588;
        Mon, 15 May 2023 06:18:33 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id gl20-20020a17090b121400b0024749e7321bsm14190014pjb.6.2023.05.15.06.18.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 15 May 2023 06:18:33 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH 03/10] maple_tree: Remove __must_hold() which does not work
Date:   Mon, 15 May 2023 21:17:50 +0800
Message-Id: <20230515131757.60035-4-zhangpeng.00@bytedance.com>
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

The arguments to __must_hold() seem to be wrong so they should not work,
remove them.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 49dfe81dfa1b6..43a25d3042c1b 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -1752,7 +1752,6 @@ static inline void mas_adopt_children(struct ma_state *mas,
  * leave the node (true) and handle the adoption and free elsewhere.
  */
 static inline void mas_replace(struct ma_state *mas, bool advanced)
-	__must_hold(mas->tree->lock)
 {
 	struct maple_node *mn = mas_mn(mas);
 	struct maple_enode *old_enode;
@@ -1792,7 +1791,6 @@ static inline void mas_replace(struct ma_state *mas, bool advanced)
  * @child: the maple state to store the child.
  */
 static inline bool mas_new_child(struct ma_state *mas, struct ma_state *child)
-	__must_hold(mas->tree->lock)
 {
 	enum maple_type mt;
 	unsigned char offset;
@@ -6198,7 +6196,6 @@ EXPORT_SYMBOL_GPL(mas_erase);
  * Return: true on allocation, false otherwise.
  */
 bool mas_nomem(struct ma_state *mas, gfp_t gfp)
-	__must_hold(mas->tree->lock)
 {
 	if (likely(mas->node != MA_ERROR(-ENOMEM))) {
 		mas_destroy(mas);
-- 
2.20.1

