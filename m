Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F516EE0D4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 13:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233814AbjDYLGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 07:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbjDYLGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 07:06:04 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CABD328
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 04:05:41 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-63b4a64c72bso4511884b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 04:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1682420741; x=1685012741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eeRfJQ/YCl9FjXRKTZNgTU7Yw5RZfHp0FYZQ2Hd7Tj4=;
        b=Svev8byb/gTZnb0la5Wq4707w9wE4BQLB2oUjKyzCWd+gRkSVi8vfkItPYdxARqJ4q
         MbPTHUJfAQd0OtkvuRzZg/QTqPrBEBr9rwuyy0A/TIReFKimAy++ysDDQzOYAVSC58hO
         wXAfc8a4HYNGlD8F9FCsEvqUQe/eQVdcJe1K4sAYzQYoGX435meNMA1h35cA1gr5ge3D
         /auP7Lm9p3cXrA3H4B/b25cb1+45DqjELlJj996ww1QbQoCfhHQwB3ihcbibdbC3zOdm
         sVpm3ren90VMIxe337JJ7kwUre+g9lTypagafMBqfSY8eURnFRGQ2R91hUchRs38WWTT
         PbzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682420741; x=1685012741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eeRfJQ/YCl9FjXRKTZNgTU7Yw5RZfHp0FYZQ2Hd7Tj4=;
        b=NSI3Ju7p/Wf3pEZ52P9/KH8TSuFy/enVjFGFPk6UykAvXDYPCUxwioHajzGRsSqa3h
         Mi2y5Ie/yBJySUz5L6H/wodEdj/D4gtVxKIwxug9wzWqyeNjVwQwMQG2mpq8+0g8Yw5i
         Fr4fCznDs2JWo0X6oXsOtW5oIyANUnGtg3TnwcmfbdXJIr5wIetUjz07OTCmKyU49iwp
         ib0MWhyIy/awIqb87l4qXWF2W5P6nEz8BDZUMasy4+qCxyPwn+d3sDBICIN42CVZsJFc
         vgxlbCXV2qLI1zU2/Ff4D+DbpJ9ibbhyrsIxAwOt8Uq4zq8jY4A/dnspV/6kbphotawq
         5dNw==
X-Gm-Message-State: AAQBX9dAIYi6Y/GVb7B8ARmRmjflNsIkxqyKKPAVzY/T3wL9pCejNDgO
        FF0YbhvjbYGdEbub9ljrMD/pEA==
X-Google-Smtp-Source: AKy350bGAB2WnJrU0GQTFt8l6DwLDr9aIdRdmUvhZUORfrAE82ebBzlaAaNlw6D6ZqSo1FoOO6Oigg==
X-Received: by 2002:a05:6a00:1a50:b0:627:e49a:871a with SMTP id h16-20020a056a001a5000b00627e49a871amr24354476pfv.23.1682420741370;
        Tue, 25 Apr 2023 04:05:41 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id u3-20020a056a00158300b0063f3aac78b9sm4422169pfk.79.2023.04.25.04.05.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Apr 2023 04:05:41 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH 5/9] maple_tree: Remove an if statement that cannot be true
Date:   Tue, 25 Apr 2023 19:05:07 +0800
Message-Id: <20230425110511.11680-6-zhangpeng.00@bytedance.com>
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

Because the commit 06e8fd999334b ("maple_tree: fix mas_empty_area() search")
is merged, this if statement cannot be true, so delete it.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 294d4c8668323..7f4b2ce84ce61 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5084,9 +5084,6 @@ static inline bool mas_anode_descend(struct ma_state *mas, unsigned long size)
 			return true;
 		}
 	}
-
-	if (mte_is_root(mas->node))
-		found = true;
 done:
 	mas->offset = offset;
 	return found;
-- 
2.20.1

