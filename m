Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6166652282
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 15:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbiLTO04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 09:26:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233931AbiLTO0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 09:26:30 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20699323
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 06:26:30 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id gv5-20020a17090b11c500b00223f01c73c3so1026862pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 06:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICp33noRi3d9C8rE7NjY0TxUAoQ5nSMBxsmejGs1dfI=;
        b=qSfcOSDAXHDzAfM9Y5B7geRR5HEUpHSmMKAbDk3sxs2OROEkpL3sY2KXx/P1+40kU8
         +VMUNvZEBRYCyFCXRMh4LZAIfhsSYnDA/UojcTUrtDqFIBgESZfyRmSNutGyjc3XshZS
         VCeMqfpXlxIr3XQid33LGe9NW3OjH/C3ZIFb8PDQ/dB/7lWET2k5At9ES7wOWb7HIoFY
         P/yCULGUCBkbNET8C0MQgZ1wv7vKtGNpShiDJ85BqkOV2cwCnoOQ+TiB5upeHir8itjR
         VGE2GtN4zg1ekDlq608H1Ww3Vp+rf/9PCSYc3NkgBJUtrqumDywN3ALSL4dLJv3hVPYX
         tytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ICp33noRi3d9C8rE7NjY0TxUAoQ5nSMBxsmejGs1dfI=;
        b=2htsX4I/3SYB1cdbbqi7coK3fkWbSl6otCOVQwge0oO8+cWw0Y+ctWW6rn8SlCECyp
         l8VBJP8xiiv3rcP2DyLp+u690DtvBfN+lgBpJ3LperUuXXHw6GdYC1Sfp15bPV60W825
         lHpsnhp1YeZUFx5asIOADlmpkSNnAnEGNl99Fl41Rhx0U8YtoB/zFnXxzML56lOuYhRU
         Kjq+WRY9jtDBjoYTEYCsTuhegMffV45VYdfg/EGkYI/8Zwjw5UZX0uC653tWEvbe64RC
         6pCG5OE0cISn/m9+L2ytnn8FChxscvuYiTvp4x+2fcTl57iwXW6EA6M1NKelHU1zvHm5
         YW3Q==
X-Gm-Message-State: AFqh2koDd2jnsY+5h2rdhaDAx7xYWdFSd/ZTXUN38ftFyuwRZjqXx/YF
        c35zK/4Kd8ZPu95Iu888V319ChRSk6gs687xHG0=
X-Google-Smtp-Source: AMrXdXsC/+bhuxI6XrkET+fpvWyY1FAub4d3VD14eu5U88kgdX5k4+HNIelFdjL8OfO0ZJEk6DwXWQ==
X-Received: by 2002:a17:902:8207:b0:191:f83:636b with SMTP id x7-20020a170902820700b001910f83636bmr14345071pln.25.1671546389903;
        Tue, 20 Dec 2022 06:26:29 -0800 (PST)
Received: from vernon-pc.. ([114.231.52.81])
        by smtp.gmail.com with ESMTPSA id ik11-20020a170902ab0b00b001897bfc9800sm9383398plb.53.2022.12.20.06.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 06:26:29 -0800 (PST)
From:   Vernon Yang <vernon2gm@gmail.com>
To:     Liam.Howlett@oracle.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vernon Yang <vernon2gm@gmail.com>
Subject: [PATCH 4/8] maple_tree: use macro MA_ROOT_PARENT instead of number
Date:   Tue, 20 Dec 2022 22:26:02 +0800
Message-Id: <20221220142606.1698836-5-vernon2gm@gmail.com>
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

When you need to compare whether node->parent is parent of the
root node, using macro MA_ROOT_PARENT is easier to understand
and for better readability.

Signed-off-by: Vernon Yang <vernon2gm@gmail.com>
---
 lib/maple_tree.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 3d45c515ed42..b3a215dd961e 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -503,8 +503,7 @@ static inline unsigned int mte_parent_slot(const struct maple_enode *enode)
 {
 	unsigned long val = (unsigned long)mte_to_node(enode)->parent;
 
-	/* Root. */
-	if (val & 1)
+	if (val & MA_ROOT_PARENT)
 		return 0;
 
 	/*
-- 
2.34.1

