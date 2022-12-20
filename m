Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52513652284
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 15:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbiLTO1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 09:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233962AbiLTO0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 09:26:46 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931041BEBF
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 06:26:37 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so16648296pjj.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 06:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=64X91MxhUjBzxu+FEguvTjtV3XYA1aG2BvuE/3RmIsU=;
        b=pwS2mq20b00ht0wE2sWSAi//5IyViRE4tk4NShJksyXTZz/akL7cBWz6/VHCOlXW8H
         5lpls1Jrlydt+SfvxiSDPAMt8uunxlGtSWYoZSb+FJp8D6WqxZNjqdMojTi4Dg39wJ1s
         +MyNdHEZqmyls/+f+7XKUzdi9QYNhyBibjLQObyULeQtIHrdIRFPwjdpK3qBp8kcqJWc
         EobCF9X3GOOPdg8Na3/ISn5vAP74qhE5ovZX85ObPYXCY1BdYnMAVsFBpZDtvRVsXpZv
         2k0X9/Sep5GWsomQj7VHPmITAPA33n06HzYrqGUiKpUNVQPsRymZW4Nt/tW2IdGzGJY3
         POfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=64X91MxhUjBzxu+FEguvTjtV3XYA1aG2BvuE/3RmIsU=;
        b=JchpKRd6d5mOyQpsecqR++AuNQUamyXhf7xp6P2tjexy1vbTGhhLPyZ2p75NkpageD
         mF/eiI4OrqJRsvljPaPT0jk1eVhhZSMWnvNPY1e/6KhpActxSFaBEScZnF7IwPHp1veE
         i0q0bqCbSIO9ieeSl36uW2MkqWjd62mzcSZBinOS0Uil5llXzHI640c/oDLroz2MozMs
         NGVvBkGj7IhDATrYvG8Hwe1UpO5o8/cs9/KbKw9zEwGBGxwYkMDx+c4PSkpRQB2F4zDp
         y5R+DKhBLAVIFk5ADS7+7R/i2YeCrFglIB8kIdrxtN4LBNrwnYzbqFZJum5vMLnIj4oj
         hGPA==
X-Gm-Message-State: ANoB5plsbC7meR6ttJg9nlsQf1QRl5T0Ob8zU3t8xLFLzi21mxRBPoXn
        uIffLBqANrzzFJxiI8Q+mYA=
X-Google-Smtp-Source: AA0mqf4k9upkMP0HrkhE5OVZzy1A8zaOGUBPPVz6j2/KB5BycYN82mg+ag6TUmJNR552xEd5Q/fchQ==
X-Received: by 2002:a17:902:76c1:b0:186:ad88:43a9 with SMTP id j1-20020a17090276c100b00186ad8843a9mr50979497plt.36.1671546396976;
        Tue, 20 Dec 2022 06:26:36 -0800 (PST)
Received: from vernon-pc.. ([114.231.52.81])
        by smtp.gmail.com with ESMTPSA id ik11-20020a170902ab0b00b001897bfc9800sm9383398plb.53.2022.12.20.06.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 06:26:36 -0800 (PST)
From:   Vernon Yang <vernon2gm@gmail.com>
To:     Liam.Howlett@oracle.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vernon Yang <vernon2gm@gmail.com>
Subject: [PATCH 6/8] maple_tree: change return type of mas_commit_b_node()
Date:   Tue, 20 Dec 2022 22:26:04 +0800
Message-Id: <20221220142606.1698836-7-vernon2gm@gmail.com>
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

The return value of mas_commit_b_node() function represents whether
the submit b_node is successful, and can only be false and true, so
the return value type is bool is more appropriate and for better
readability.

Signed-off-by: Vernon Yang <vernon2gm@gmail.com>
---
 lib/maple_tree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index b3a215dd961e..e7dde4a1d6cb 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -3578,7 +3578,7 @@ static inline bool mas_reuse_node(struct ma_wr_state *wr_mas,
  * @b_node: The maple big node
  * @end: The end of the data.
  */
-static inline int mas_commit_b_node(struct ma_wr_state *wr_mas,
+static inline bool mas_commit_b_node(struct ma_wr_state *wr_mas,
 			    struct maple_big_node *b_node, unsigned char end)
 {
 	struct maple_node *node;
@@ -3598,7 +3598,7 @@ static inline int mas_commit_b_node(struct ma_wr_state *wr_mas,
 
 	mas_node_count(wr_mas->mas, 1);
 	if (mas_is_err(wr_mas->mas))
-		return 0;
+		return false;
 
 	node = mas_pop_node(wr_mas->mas);
 	node->parent = mas_mn(wr_mas->mas)->parent;
@@ -3607,7 +3607,7 @@ static inline int mas_commit_b_node(struct ma_wr_state *wr_mas,
 	mas_replace(wr_mas->mas, false);
 reuse_node:
 	mas_update_gap(wr_mas->mas);
-	return 1;
+	return true;
 }
 
 /*
-- 
2.34.1

