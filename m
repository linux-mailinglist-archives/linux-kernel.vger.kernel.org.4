Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C268A652286
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 15:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiLTO1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 09:27:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233974AbiLTO0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 09:26:47 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCAF1C12A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 06:26:41 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id u4-20020a17090a518400b00223f7eba2c4so165252pjh.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 06:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WdykleZ4reuZUDGuALMZqWmYTc5/lzRFBIQz0bC+lNM=;
        b=MjWc8w+J1L/tQILl3fKHOTFPdPs4BkgGvNq9Ml0XhG6X+6LIzrSZQOi3N6Dt2yivwF
         x1VWHknuFzz/h9fQO6fsK+pGbqdDG9ykURDlJPWXGCLIWAfKmcaP6+gjc52dxFKODS1A
         VPtN5QlkkET/bPsQltPV7i/6/QA+N9vRe74+/204GPE7KL9Zry5fXf1didvfwwwKbFMk
         eJpotQlOzt/ox/8DO57kgjajFvSe9QllroD4IwNLNqdPIs3WYTP3fUrUczTvExvA4efz
         58wPCroWJz1YGYjBTPIe5C8uvianCzXItcy/sHWPhhtUlyVwjRZL+W4uEUK7SF5dsBdM
         WHtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WdykleZ4reuZUDGuALMZqWmYTc5/lzRFBIQz0bC+lNM=;
        b=33JMh0FB55p+DDxN6WH83qUpnsRaIVm6NcDifanGi0EFiS3+Cm1Wq8i3QiVEuib57S
         QzYiGljNnBd1z2N+i/qLpsOXqt5d9jgV48lhUYmvU9N1MjnaeW8X1vgm8tn8O58KRJv4
         iJmTSuWxA3OQgDGYdw/k0gb+Oc72mIvDEo8Be+17NdbBS8D7NGrtwPwxtCv2hlJn66nw
         wry7ztMH4tbel6/2zRt8mZWXjqeWXvkxBp9BBzieYJQP4lg1Z4e7INw+sotX51ZAML1o
         ZraxXE4oWU4zYbFR8dePeC/Hy2K0ITJ8yZlH+iucD53MFKsYezA5UAKSJ1On7S3xfeRh
         ctew==
X-Gm-Message-State: AFqh2koxCOguIZTTH/55q5UU6lLRMOr4XqpqeGmjItREC6lDHx+TErRK
        ntq1ELbH9lUWKTO4o74jt84=
X-Google-Smtp-Source: AMrXdXsBSW0EHE7rAoMotD3hOgcA/OPQtakxM4iNqFUFItIPYliZloQamq8otuQdfILXanPorw0cxQ==
X-Received: by 2002:a17:902:710f:b0:190:d69c:1418 with SMTP id a15-20020a170902710f00b00190d69c1418mr12103783pll.2.1671546400816;
        Tue, 20 Dec 2022 06:26:40 -0800 (PST)
Received: from vernon-pc.. ([114.231.52.81])
        by smtp.gmail.com with ESMTPSA id ik11-20020a170902ab0b00b001897bfc9800sm9383398plb.53.2022.12.20.06.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 06:26:40 -0800 (PST)
From:   Vernon Yang <vernon2gm@gmail.com>
To:     Liam.Howlett@oracle.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vernon Yang <vernon2gm@gmail.com>
Subject: [PATCH 7/8] maple_tree: refine ma_state init from mas_start()
Date:   Tue, 20 Dec 2022 22:26:05 +0800
Message-Id: <20221220142606.1698836-8-vernon2gm@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221220142606.1698836-2-vernon2gm@gmail.com>
References: <20221220142606.1698836-2-vernon2gm@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If mas->node is an MAS_START, there are three cases, and they
all assign different values to mas->node and mas->offset. So
there is no need to set them to a default value before updating.

Update them directly to make them easier to understand and for
better readability.

Signed-off-by: Vernon Yang <vernon2gm@gmail.com>
---
 lib/maple_tree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index e7dde4a1d6cb..16cdcf309e97 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -1329,7 +1329,7 @@ static void mas_node_count(struct ma_state *mas, int count)
  * mas_start() - Sets up maple state for operations.
  * @mas: The maple state.
  *
- * If mas->node == MAS_START, then set the min, max, depth, and offset to
+ * If mas->node == MAS_START, then set the min, max and depth to
  * defaults.
  *
  * Return:
@@ -1343,22 +1343,22 @@ static inline struct maple_enode *mas_start(struct ma_state *mas)
 	if (likely(mas_is_start(mas))) {
 		struct maple_enode *root;
 
-		mas->node = MAS_NONE;
 		mas->min = 0;
 		mas->max = ULONG_MAX;
 		mas->depth = 0;
-		mas->offset = 0;
 
 		root = mas_root(mas);
 		/* Tree with nodes */
 		if (likely(xa_is_node(root))) {
 			mas->depth = 1;
 			mas->node = mte_safe_root(root);
+			mas->offset = 0;
 			return NULL;
 		}
 
 		/* empty tree */
 		if (unlikely(!root)) {
+			mas->node = MAS_NONE;
 			mas->offset = MAPLE_NODE_SLOTS;
 			return NULL;
 		}
-- 
2.34.1

