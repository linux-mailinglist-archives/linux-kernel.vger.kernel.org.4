Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E509702DEB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 15:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242132AbjEONT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 09:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242098AbjEONTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 09:19:23 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF9419A6
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 06:18:42 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5208be24dcbso9137603a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 06:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684156722; x=1686748722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lo1IIZfKjDP5LNi0dc+D12owX90CR8s5tkIi0vNkd7U=;
        b=iRq9sScOWZTCRfloTGbziN9cAC64a11zOsNkjp+5c1soI+3pRGWoucKuYa0+afBrM9
         KP8InFDQgvCjKmHotLh2wYIyXRzWHtTPq+Eu/2q4uz7EHQaV09LS/cg0LBz50XCOSenv
         5TIATnqEPFgNUuV8mtQuISYyzUH0xhNubca3DObs4XwCQmcEhgMKj6lZoQBSaPM42/p3
         ZPnakXFKNosi63bdx6zJYoyHGjOpg2rxmoG3YBjH17UsScQn6r/yNgXEZSpXMSaiPPvO
         sVodHaxkosK0wFyiC0Hn2X0gh8Q5Iww84zRZZ4k5Aa2XQix6BKn1naSGI7OW3PhFCTqn
         VtCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684156722; x=1686748722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lo1IIZfKjDP5LNi0dc+D12owX90CR8s5tkIi0vNkd7U=;
        b=YQpevQl3CrWyhZqUs/Cqo5sOMj1fDC0nuGdLKCJNbOOfX7DcND+7YtaVFXspvEdZ+B
         ILDHR7lRBwp3E65yUh05HZA8WbF607jvWhGvEpETth2AtxV78SOHavPOXC62d7CQDBI2
         0RoEF37ZGb0cB67SxOlQwf3g2NGiuUS7+29Wn1LY+68kSpiDjEKWEPHXOgbASAAFTnrr
         F8xdPrLWsXoZyc/aQ7ttot8k8zn+PCGVd1MmRTxXkEv0WzqvDnnoAScNvZbb2IgnVkT7
         3LyNaYxXv+wtk5rGTI2BP14BAMeDB1xP7CrFcz4p7nSRMCiayWG1oarK9UwYx0mNAw+Q
         8j/w==
X-Gm-Message-State: AC+VfDzINvCkH4VGeSYxYsJ2WbppwWeGG9rrJsG6igl8rEtP3/lqwGe4
        N969vAr75tFAW0fCSwV5iuEUrg==
X-Google-Smtp-Source: ACHHUZ6sqdEAVKXCZZzGT9Z6sL0SWer+AhnOXHqqOFRcuvjaqR338puxAj51isP5NagP+6F7tjxgTA==
X-Received: by 2002:a17:90b:46cd:b0:250:6119:6c1f with SMTP id jx13-20020a17090b46cd00b0025061196c1fmr27787639pjb.19.1684156721988;
        Mon, 15 May 2023 06:18:41 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id gl20-20020a17090b121400b0024749e7321bsm14190014pjb.6.2023.05.15.06.18.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 15 May 2023 06:18:41 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH 06/10] maple_tree: Wrap the replace operation with an inline function.
Date:   Mon, 15 May 2023 21:17:53 +0800
Message-Id: <20230515131757.60035-7-zhangpeng.00@bytedance.com>
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

To make mas_wr_modify() cleaner, wrap the replace operation with an
inline function.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 4c649d75a4923..ce695adc670ec 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4288,6 +4288,19 @@ static inline void mas_wr_extend_null(struct ma_wr_state *wr_mas)
 	}
 }
 
+static inline bool mas_wr_replace(struct ma_wr_state *wr_mas)
+{
+	struct ma_state *mas = wr_mas->mas;
+
+	if (wr_mas->r_min == mas->index && wr_mas->r_max == mas->last) {
+		rcu_assign_pointer(wr_mas->slots[mas->offset], wr_mas->entry);
+		if (!!wr_mas->entry ^ !!wr_mas->content)
+			mas_update_gap(mas);
+		return true;
+	}
+	return false;
+}
+
 static inline bool mas_wr_append(struct ma_wr_state *wr_mas)
 {
 	unsigned char end = wr_mas->node_end;
@@ -4347,13 +4360,9 @@ static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
 	unsigned char node_size;
 	struct ma_state *mas = wr_mas->mas;
 
-	/* Direct replacement */
-	if (wr_mas->r_min == mas->index && wr_mas->r_max == mas->last) {
-		rcu_assign_pointer(wr_mas->slots[mas->offset], wr_mas->entry);
-		if (!!wr_mas->entry ^ !!wr_mas->content)
-			mas_update_gap(mas);
+	/* Attempt to direct replace */
+	if (mas_wr_replace(wr_mas))
 		return;
-	}
 
 	/* Attempt to append */
 	node_slots = mt_slots[wr_mas->type];
-- 
2.20.1

