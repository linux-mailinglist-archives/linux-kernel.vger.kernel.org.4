Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509E374E58F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 05:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjGKDzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 23:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjGKDzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 23:55:24 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8856BE42
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 20:55:02 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-5634808e16eso3725675eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 20:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689047702; x=1691639702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vnneOZGmz+RJtivDvKZ74LFhvf3KlKhvaFlPPXT7kZI=;
        b=Z4IrWlz1AVjCsHQerCU8etu0x4fMRgmj78dqWxOaEVokcj5JlvJ48wbsN1nYAt8aCx
         GyIG4fljUcmd36IPAIMorw1pVL0WKa1lCiJxTeiR8S2f1WdwstlfNNXOLV/lPYXe6w1h
         DVjrFkjamSlpBL0rycqTgq+TECck80TZzdXkKOcfQH4QVOG0MGoHytPkEiIPLoB+jvOb
         bIEAdvF5OtUo3o2laMkrVhKHijhKrDznzeOUJ0gGzpAgJ1tYhDAcKvPIU5b6T4kPx4Gg
         OKUPDT72H3ElLV4oau0mU8I3UjQjAbd0NEcN69RmvH/J8FLOzK114dRUY492oyqnmudr
         BFgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689047702; x=1691639702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vnneOZGmz+RJtivDvKZ74LFhvf3KlKhvaFlPPXT7kZI=;
        b=hn5dIHyIlfLSOrZfzIEetLoCnTBlRnsdj8456s9GlWYGDEQu2se17A6Do7u+jo5IDF
         wwj4LFGqm6QxapxAl3YgSAI8AJECj8TiLynqCr0cxplO2iiaWOTURpXsvsk30YbGxQbz
         nm0BkkEK6v1667QPWh8TsvPXZegzUAXI99goOVDK8ZSwbutDjsUHlipw0Mwcfr3i6Jwz
         tly6wcoru++QnmAleaiy8IXvEkMIVhQherNdBil2EgXoYyINHC5zxSGP53WSJsZnVMPf
         79W3ca74xxBVzDhPWHCDyCMPQEDPe3zso0Sw2fJDKr2UtMwIQV7cnM6vHqm5fUMxH4bH
         1kfw==
X-Gm-Message-State: ABy/qLZ4Kn1G6kPTusx/e7OEqlnc9out6J48FKjay7JjpjxEWGhiYZ7r
        xEH0fc7QmOfo7Vjj9OaknhLj5g==
X-Google-Smtp-Source: APBJJlEIEZOJHFzFjqHdn5Rtin4l+6JxK3vqqJKAQWR7goZOnHNKOij7NoyuIfZwPg9ro0YTA3YksA==
X-Received: by 2002:a05:6358:5e02:b0:134:c8ee:e451 with SMTP id q2-20020a0563585e0200b00134c8eee451mr10966324rwn.13.1689047701778;
        Mon, 10 Jul 2023 20:55:01 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id b15-20020a170903228f00b001b872c17535sm688329plh.13.2023.07.10.20.54.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 10 Jul 2023 20:55:01 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        stable@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2 1/8] maple_tree: set the node limit when creating a new root node
Date:   Tue, 11 Jul 2023 11:54:37 +0800
Message-Id: <20230711035444.526-2-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230711035444.526-1-zhangpeng.00@bytedance.com>
References: <20230711035444.526-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the node limit of the root node so that the last pivot of all nodes
is the node limit (if the node is not full).

This patch also fixes a bug in mas_rev_awalk().  Effectively, always
setting a maximum makes mas_logical_pivot() behave as mas_safe_pivot().
Without this fix, it is possible that very small tasks would fail to
find the correct gap.  Although this has not been observed with real
tasks, it has been reported to happen in m68k nommu running the maple
tree tests.

Link: https://lore.kernel.org/linux-mm/CAMuHMdV4T53fOw7VPoBgPR7fP6RYqf=CBhD_y_vOg53zZX_DnA@mail.gmail.com/
Fixes: 54a611b60590 ("Maple Tree: add new data structure")
Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: <stable@vger.kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
---
 lib/maple_tree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index d3072858c280..f55e59bd9122 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -3692,7 +3692,8 @@ static inline int mas_root_expand(struct ma_state *mas, void *entry)
 	mas->offset = slot;
 	pivots[slot] = mas->last;
 	if (mas->last != ULONG_MAX)
-		slot++;
+		pivots[++slot] = ULONG_MAX;
+
 	mas->depth = 1;
 	mas_set_height(mas);
 	ma_set_meta(node, maple_leaf_64, 0, slot);
-- 
2.20.1

