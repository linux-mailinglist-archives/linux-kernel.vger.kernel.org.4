Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE9170B44F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 07:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbjEVFHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 01:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbjEVFH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 01:07:29 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0691F4
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:07:27 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-64d577071a6so1521509b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684732047; x=1687324047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWC57VvLqW+uV6e3VSW20kWo+uFlFhqhxKDmqi/M+s4=;
        b=EzLSK3cPy7whK/cuCX7ItKG6l3duMlUzxr2DN24N10lVm+CaqC7sQkl4JBdNua/aAQ
         zosKFg/rfFI7osQ8eZcIBIfKeDR03YZaXjE5O8+e2qadCDIp41XDnirHuK3FWoX8l3OU
         YcB4YJkxwNjDyYKJfPZHybJrX1aMBiy3UgCgsQoNlOLNB2szntp7ukZGP8Q+ZzNCsuPy
         V8JNyEch9NnjoH7EK7OtuSW0wVEcwlYQnqPEa9kzxzg0/vxd+qY1B24BapLesnKT1O6q
         iZbG3O4pP7gdt6Vx0E2R3HvXJKJDMX0BbBfYhgm7SDcOeyERTF0Kb1Cj892QnkPDOShu
         QbmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684732047; x=1687324047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yWC57VvLqW+uV6e3VSW20kWo+uFlFhqhxKDmqi/M+s4=;
        b=bNFcxqLOyjeI4enfRTfp5mFrFx2xOz2BDL0ukRFBmkN9svZ58tKM3KE4K4GoL4utIs
         /hZ2GKmlyWc0tsUMeNPW041CV2AIJ4ZnX6JAueqQjX8pzkqZ5XOpLfcwZSFwNufXNVsE
         85kg57qEOs2GMMCkSF7LMKt7i/TqCBT+FLb069yqNLQmrRSK26FKYdZPiHPkZqqJTcEW
         PW99L4OYAYoTtbJrgI+D1Blbhjjbur1k5Xd3d9vrM4qGD6l5EuVBuUirFogNu2UhVWi3
         oQ9ClJQkA3bHKJGpJFIPzX74OdgLCs1tVmwtZfFVsb6MSOrNhovuPYjsX7WPRIW5uXFt
         5fjg==
X-Gm-Message-State: AC+VfDwT4sRgsnxWZrjFEVRucm9c2Uq0Kl87OgPii8ldLUCCdW6kcx+Y
        7mjO9G4pbXdIN6b30LUJxRALvA==
X-Google-Smtp-Source: ACHHUZ78HzvmR367cMVPT2DzYVrIahGxjmoDH/aFdaP1ySwjC4sDSZwePIHcLNsfO8g2Nn/oaa1aBw==
X-Received: by 2002:a05:6a00:3924:b0:64d:5f1d:3d77 with SMTP id fh36-20020a056a00392400b0064d5f1d3d77mr4573175pfb.34.1684732047342;
        Sun, 21 May 2023 22:07:27 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id t10-20020a62ea0a000000b0063b5776b073sm3247519pfh.117.2023.05.21.22.07.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 21 May 2023 22:07:27 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v3 03/10] maple_tree: Fix the arguments to __must_hold()
Date:   Mon, 22 May 2023 13:06:49 +0800
Message-Id: <20230522050656.96215-4-zhangpeng.00@bytedance.com>
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

Fix the arguments to __must_hold() to make sparse work.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 263bd0ccc31b..3fe6a6685384 100644
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

