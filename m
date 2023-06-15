Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5AB573199C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343650AbjFONLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343710AbjFONLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:11:02 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471E526B6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 06:10:41 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6669be8288bso433036b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 06:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1686834641; x=1689426641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bwu5nVhZqsw5mJk5ySAZ1ZJzvb1s8FXMcsj+5u++1nw=;
        b=LrTA+ywKAk48Bks9Q4FIitMp7HeDcqRRmwSAPNDfOScb1TlK19naIDVZsu9SNJhp6G
         ciB+6/O0g2mQqQX1sYbvq7XQfe99l+pDofZVgNgI1ECqI/a60Da4LqfrqBLqBIZqOWfJ
         Qq65teJ95eepYbYMyebJySZ2X2SGYHiRzJJLO0LNbNBD5OVSG/AF2nHuunjE0XDabsfP
         Ulxt1D4JlWwsqIQMKZH+6ewgYdkFIXWrZeV/FWvTTvt7rie24HSlfngK1US75VQF9sYI
         vsHBI+uRXhuNMCQRhYA2VAwekjD63+3P+055GGksZ+oQ/yYfTrbpB76riVW5lnmnIa25
         FQ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686834641; x=1689426641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bwu5nVhZqsw5mJk5ySAZ1ZJzvb1s8FXMcsj+5u++1nw=;
        b=Frzl2UW+ADleYnP8jnqsIAtYgRL+KfCE2Apfk1/7jblaPnU06j3ZX20Kh11VTavuvS
         ql1jmWwWVbslq5lhVVw57rNQurUOfy/PFCeXq4tSZGA885pRdP8TUA6l7+qs4ePdJRSM
         RhpdzYz+AGtgEMbFF/bVweGi8hWLs1dkBf9rRZ3zyMQb0s5JyFBbIPSkz9/vpwyjkNdL
         mmGcOvuxhzAdyEy31aaDkHQ3Gff3MW3jmPLt+wxClIFQ2VcPWuSF6TTqyA/mVY7Sn+t9
         3ZNwal8BVAPsScu5pu4NV6uoaNlQ+zq0zV9l2rqBmw/OL6wPIXHkgO14o7dUCGGSGPKV
         EFCA==
X-Gm-Message-State: AC+VfDyNeLC48fVMIOpm5/09g7giKmigTAnF235s5UcjfvOSi95S657C
        yb4smb8rdXoRbbCwchscztzP9Q==
X-Google-Smtp-Source: ACHHUZ5G6bKVtrru3zNeSvvNc0GB4q9oRK4nDb5nNbnQpx/pnVkdXtJengeUj4TSq9YeSBkOwEW+kA==
X-Received: by 2002:a05:6a20:7da7:b0:10b:6e18:b690 with SMTP id v39-20020a056a207da700b0010b6e18b690mr4629377pzj.32.1686834640813;
        Thu, 15 Jun 2023 06:10:40 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id x1-20020a170902b40100b001a804b16e38sm14036019plr.150.2023.06.15.06.10.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 15 Jun 2023 06:10:40 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH 4/8] maple_tree: fix mas_validate_child_slot() to check last missed slot
Date:   Thu, 15 Jun 2023 21:08:55 +0800
Message-Id: <20230615130859.21858-5-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230615130859.21858-1-zhangpeng.00@bytedance.com>
References: <20230615130859.21858-1-zhangpeng.00@bytedance.com>
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

Don't break the loop before checking the last slot. Also here check if
non-leaf nodes are missing children.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 799afd590cf3..d91e66ea223f 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -7107,11 +7107,12 @@ static void mas_validate_child_slot(struct ma_state *mas)
 
 	for (i = 0; i < mt_slots[type]; i++) {
 		child = mas_slot(mas, slots, i);
-		if (!pivots[i] || pivots[i] == mas->max)
-			break;
 
-		if (!child)
-			break;
+		if (!child) {
+			pr_err("Non-leaf node lacks child at %p[%u]\n",
+			       mas_mn(mas), i);
+			MT_BUG_ON(mas->tree, 1);
+		}
 
 		if (mte_parent_slot(child) != i) {
 			pr_err("Slot error at %p[%u]: child %p has pslot %u\n",
@@ -7126,6 +7127,9 @@ static void mas_validate_child_slot(struct ma_state *mas)
 			       mte_to_node(mas->node));
 			MT_BUG_ON(mas->tree, 1);
 		}
+
+		if (i < mt_pivots[type] && pivots[i] == mas->max)
+			break;
 	}
 }
 
-- 
2.20.1

