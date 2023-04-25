Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8034C6EE0CE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 13:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbjDYLFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 07:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233888AbjDYLFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 07:05:49 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383D012C97
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 04:05:45 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-63b60366047so4504872b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 04:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1682420744; x=1685012744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uhpet9rFKKSbNY/rO+kxNiiukorlrEmSdc9GCeX7BVQ=;
        b=kRDCATpMOFuEPi6tXPsOXLZpTjhUGeNU5eTbsWS/STvZypZztv1c2WheEeS2ZqnMTC
         kpd1b3dOaUmTKyXaj+z9CyulDGeZtQwWDI4jrkMX22GZUDqIUkdI7glYxD+jmHZth1/E
         i0VsY7k71T7rtEZsPr0RtaW/qwJYwCCfnFrPYFo8E6rV4sJwqA/Wvf75YGIZtKQjP8gN
         tXmWXV7YanL+BeCwrwhNMS0CbG66ajylBFYygIuyhlINtNPvpz2OfsBg7buDGPs6x44o
         m5vs7IxRJ7cIHDTdtX9SfH9SC0bt7BMfYOLlFrjKRITZjTGinAox/LUHikSJzJkWe5Qz
         ySKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682420744; x=1685012744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uhpet9rFKKSbNY/rO+kxNiiukorlrEmSdc9GCeX7BVQ=;
        b=LlaxBhN1XuUQqbz9ANQ8G3BC4I6v5N0u+fB6KyPa+lOdUvXnbskdZywi1ive1q+0Bm
         06rwv/2Ke3sYuy/mSQe/H7HOY4cKNlrSG9116fIKRB+mBA89e/plIGJgRkJkrabwCPNL
         DuSs73NxOooGuAT/+VaTuE5YAG5QSY3hvZ8X61riWECkqTbyACoB5nQICzK+6Fy0UdTn
         08LBUYWViFc/4QYAS/4o+o1NCt0NzDiKJ4gp01Ndxsjtrrjp/zkd481MdIg+eJvaM3LL
         iJL1OsAAGQr1ImTtbX3Wpv7I+cOhQv75NysmDn2nHjzA6bCDNKq/P39lcMJxp/KlgAv2
         yddA==
X-Gm-Message-State: AAQBX9e5RIRrqVOY5RrzRCgDli37YNdsx+IcVN6u0L1qZ8cFyBfWi7Cp
        DM2tGoNo/JXKlRvECEovZJHHcwi4aEZs/sX4a9o=
X-Google-Smtp-Source: AKy350bb8ivezPwkMZceREpecMXYm1R01Tbms6afrN+M43oKICEeAjPUTaLy3P5Yg3AEbvNizSRdwA==
X-Received: by 2002:a05:6a21:998d:b0:f1:ff77:4a32 with SMTP id ve13-20020a056a21998d00b000f1ff774a32mr23584687pzb.9.1682420744512;
        Tue, 25 Apr 2023 04:05:44 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id u3-20020a056a00158300b0063f3aac78b9sm4422169pfk.79.2023.04.25.04.05.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Apr 2023 04:05:44 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH 6/9] maple_tree: Remove a confusing check
Date:   Tue, 25 Apr 2023 19:05:08 +0800
Message-Id: <20230425110511.11680-7-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230425110511.11680-1-zhangpeng.00@bytedance.com>
References: <20230425110511.11680-1-zhangpeng.00@bytedance.com>
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

After this loop, we are at the last slot of a node. Our purpose is to
find an entry that is not NULL, but the pivot is checked here, delete
it, and change to mas_logical_pivot() to get the pivot. Finally, only
check whether the entry is NULL.

Why is this confusing? If the pivot is equal to 0, but if the entry is
not NULL at this time, it will return NULL because of the pivot, but it
should not do this, the entry is valid.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 7f4b2ce84ce61..83441ef2e1f57 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4742,17 +4742,13 @@ static inline void *mas_next_nentry(struct ma_state *mas,
 		return NULL;
 	}
 
-	pivot = mas_safe_pivot(mas, pivots, mas->offset, type);
+	pivot = mas_logical_pivot(mas, pivots, mas->offset, type);
 	entry = mas_slot(mas, slots, mas->offset);
 	if (ma_dead_node(node))
 		return NULL;
 
-	if (!pivot)
-		return NULL;
-
 	if (!entry)
 		return NULL;
-
 found:
 	mas->last = pivot;
 	return entry;
-- 
2.20.1

