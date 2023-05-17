Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1CEE706370
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjEQI7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjEQI7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:59:21 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BED946BD
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:58:55 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-643b60855c8so468878b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684313935; x=1686905935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JHlXin2w6vavc2+J7pEpRe/GvVWd1HUUirBvk9ov2Fw=;
        b=H+MW+AUW5biA2FNoD0LhWFVRD42pY2bqjWAmvKM0Yoa4zTu8srZy/Gj8H/aG3FvJL/
         PA7sqqD+P2gUrAnlcsVHplTZl7wgbKAwHdTslukWmxEbgOXjPNvl10Imxfu9KOfb40wV
         kDTXMdOHxMgcLMLVn0uEGcjpaDT7ki5Q4pHfq/86IbfqVFgUdd0aXxibTk7EQxs3FXfw
         Ft/AS4NL32YXcLAJ1KSYOVm/6/qDeLSjmWKXoqRugkYoN74YskuK9j1WX96iwuHAN6EV
         tX08aUTLefRpOaQIL+Ad8e1kQkrnhOc0fhXJVRy2BGulNjX5fRt6fSezcJyZUWd9vLcM
         LL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684313935; x=1686905935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JHlXin2w6vavc2+J7pEpRe/GvVWd1HUUirBvk9ov2Fw=;
        b=WyhM/h+E+zrxQnRtr47+V3T0JGPUiIt0/5a+cQJCn3K2UaXN+At7/ANPGQhhPW9Y5x
         qSy9lZPyAQJqDnt9Xx8v2zpYZKWQml/u0nWXlnnz4kNfQUULa124QJPeMSQ6m8WvzNQf
         WgdYiP9xjTUHT40gLtRoSrTUZ0LfouOuZxVsogedQXvOX0XlZwBnPU44YQCcHQeBRolU
         Faap8dnAeu94GiD8VFFRGmG6J01EBCHiHbK2JbTMzfEb40IhlmXGkTp5LsxE/2zLXRtL
         aEu4gL8J6OlWnHI4UwOjIrdj0Qm+G9xmfZF0KgnacwLxQmOc1ukzY8vGCY8qBnJyRFIc
         9qFg==
X-Gm-Message-State: AC+VfDwb7ydtL9U5l1NIcxlBplow/T1rAa+6lnHmdu8YxChLaVgbCQ3T
        HTh6tab06wcuFqh3JFa7a58RTQ==
X-Google-Smtp-Source: ACHHUZ6NOi/1YycNdfdoBvrCAF+/spFRL1mJivf4kbwtDda7IS7ETsJwYzP9XTa6xQROkzqYEveytw==
X-Received: by 2002:a05:6a00:1a4e:b0:646:2edb:a23 with SMTP id h14-20020a056a001a4e00b006462edb0a23mr135673pfv.1.1684313935021;
        Wed, 17 May 2023 01:58:55 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id m18-20020a63ed52000000b0052c9d1533b6sm15056765pgk.56.2023.05.17.01.58.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 May 2023 01:58:54 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v2 03/10] maple_tree: Fix the arguments to __must_hold()
Date:   Wed, 17 May 2023 16:58:02 +0800
Message-Id: <20230517085809.86522-4-zhangpeng.00@bytedance.com>
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

Fix the arguments to __must_hold() to make sparse work.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index c8176f360dc2..bec9906b0c8c 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -1752,7 +1752,7 @@ static inline void mas_adopt_children(struct ma_state *mas,
  * leave the node (true) and handle the adoption and free elsewhere.
  */
 static inline void mas_replace(struct ma_state *mas, bool advanced)
-	__must_hold(mas->tree->lock)
+	__must_hold(mas->tree->ma_lock)
 {
 	struct maple_node *mn = mas_mn(mas);
 	struct maple_enode *old_enode;
@@ -1792,7 +1792,7 @@ static inline void mas_replace(struct ma_state *mas, bool advanced)
  * @child: the maple state to store the child.
  */
 static inline bool mas_new_child(struct ma_state *mas, struct ma_state *child)
-	__must_hold(mas->tree->lock)
+	__must_hold(mas->tree->ma_lock)
 {
 	enum maple_type mt;
 	unsigned char offset;
@@ -6204,7 +6204,7 @@ EXPORT_SYMBOL_GPL(mas_erase);
  * Return: true on allocation, false otherwise.
  */
 bool mas_nomem(struct ma_state *mas, gfp_t gfp)
-	__must_hold(mas->tree->lock)
+	__must_hold(mas->tree->ma_lock)
 {
 	if (likely(mas->node != MA_ERROR(-ENOMEM))) {
 		mas_destroy(mas);
-- 
2.20.1

