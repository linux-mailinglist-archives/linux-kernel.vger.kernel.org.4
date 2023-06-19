Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF1C734F05
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 11:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjFSJD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 05:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjFSJDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 05:03:53 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3E0102
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 02:03:46 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1a9d57f8f9fso2991306fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 02:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687165425; x=1689757425;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=28IVmM1JzFRFgQO0nqLoiWUsyVNzNBQTjvB7G3706MQ=;
        b=iUn4sapbbds8Rb6vf8wubqKSjLd/Qz4f7JQYbwVktKqpd2Ax073i9jf3dDsgAk92XW
         FyFMZdZENYXsDm07BSq/plBYjr99oE4NgA7/3q3I5qMt+SpygCS+THJJejZhrI/mpKi1
         UCnTSG5zvG2TeeeQmhm4E1YNW4dQgCXaHeO0UiGA98fX+mQVhbBkm21QkLJNi5JbMBwK
         Ov/gh+oF/F9/kk/HBiFlt/EVeUHFs5hd24DV3nNinGfX9eePZc+NvkFNNW5N1cFuvwyr
         1nzixlPdfbZitS4vZTzZGmnHetET21/jYHInbRd+nVyZzG7g9CsUwodIarcze47njj1X
         8NgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687165425; x=1689757425;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=28IVmM1JzFRFgQO0nqLoiWUsyVNzNBQTjvB7G3706MQ=;
        b=XziFpwonuOfj2yIdq3zK6pupE9xdusP872CCRG+YWScSdXMCQunCEBIc1bxwefZwqX
         ssqKx4Exl6AgM8kaMFM5KOs3jOUL+L86Cj0apGg+WHi9oNwJO9JZb/sGDJiILcLUGi3F
         HfHDJhtLXvCcwE2+pTsM2pe4aHSTsto3CkR3YMW8qfVT9LfTQZ2ZFYghctn4i6Ng2K3P
         oy1CesNzFFI4Ag5KKr7Cau22ih8oyAcSPDnIdk6oKcL7f93Z+Cvm9EZDQRK+HUzFd4KI
         y76zCKl4TEVPvgMI4UxmNoShePlB6uSeVeGDRgbjA8I1MzUvwCgqgEVpocv9VKBbm1uY
         /Qqw==
X-Gm-Message-State: AC+VfDzWGdtI9Z2UT+6q2BywoQ8Yyj9Cqzi0PSMHTCjKS00gj5a8nMk2
        ub4+ZewS0SYuQUTkWI3L7xc=
X-Google-Smtp-Source: ACHHUZ5T0nMdjBo42aur07XmJwDxKuz93O2lZ5Ag1UaCvIxeShWFPQ/tqXoRXLMGAZw77B0Fx3Q/ow==
X-Received: by 2002:a05:6870:b145:b0:199:a686:a93f with SMTP id a5-20020a056870b14500b00199a686a93fmr7775409oal.4.1687165425285;
        Mon, 19 Jun 2023 02:03:45 -0700 (PDT)
Received: from localhost ([2402:d0c0:2:a2a::1])
        by smtp.gmail.com with ESMTPSA id t2-20020a655542000000b005143448896csm16805442pgr.58.2023.06.19.02.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 02:03:44 -0700 (PDT)
From:   Alan Huang <mmpgouride@gmail.com>
To:     paulmck@kernel.org
Cc:     edumazet@google.com, linux-kernel@vger.kernel.org,
        Alan Huang <mmpgouride@gmail.com>
Subject: [PATCH] list: Remove unnecessary WRITE_ONCE()
Date:   Mon, 19 Jun 2023 09:03:36 +0000
Message-Id: <20230619090336.145738-1-mmpgouride@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c54a2744497d("list: Add hlist_unhashed_lockless()") added
various WRITE_ONCE() to pair with the READ_ONCE() in
hlist_unhashed_lockless(), but there is no need to protect
->next with WRITE_ONCE(). Therefore, this commit removes those
unnecessary WRITE_ONCE().

Signed-off-by: Alan Huang <mmpgouride@gmail.com>
---
 include/linux/list.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/list.h b/include/linux/list.h
index f10344dbad..ac366958ea 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -940,7 +940,7 @@ static inline void hlist_del_init(struct hlist_node *n)
 static inline void hlist_add_head(struct hlist_node *n, struct hlist_head *h)
 {
 	struct hlist_node *first = h->first;
-	WRITE_ONCE(n->next, first);
+	n->next = first;
 	if (first)
 		WRITE_ONCE(first->pprev, &n->next);
 	WRITE_ONCE(h->first, n);
@@ -956,7 +956,7 @@ static inline void hlist_add_before(struct hlist_node *n,
 				    struct hlist_node *next)
 {
 	WRITE_ONCE(n->pprev, next->pprev);
-	WRITE_ONCE(n->next, next);
+	n->next = next;
 	WRITE_ONCE(next->pprev, &n->next);
 	WRITE_ONCE(*(n->pprev), n);
 }
@@ -969,8 +969,8 @@ static inline void hlist_add_before(struct hlist_node *n,
 static inline void hlist_add_behind(struct hlist_node *n,
 				    struct hlist_node *prev)
 {
-	WRITE_ONCE(n->next, prev->next);
-	WRITE_ONCE(prev->next, n);
+	n->next = prev->next;
+	prev->next = n;
 	WRITE_ONCE(n->pprev, &prev->next);
 
 	if (n->next)
-- 
2.34.1

