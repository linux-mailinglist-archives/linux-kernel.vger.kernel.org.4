Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C54A652CA5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 07:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234556AbiLUGC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 01:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234478AbiLUGCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 01:02:02 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3741A20F7D
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 22:01:44 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id 21so9994759pfw.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 22:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ytBbvPTXR4FdqciS4jsfQvnjl2UrmH262qeoBNVrzHw=;
        b=jw0wbWgKyc3Q6Zq1TuhcRXITmEOfWs7TN0eWvllMPmMcHMAdVZWUm80Eh2mWdWnt7k
         hXWD+JrNkOB7hvw4ppRyxg2PVr0MhhrPZqgApkq2npstymirN6PCv2462HJ6G9D1STUX
         IqRMa/uqSTUy55DX8LFZnwAEvexbPqVRLeIjWBaJx1R3LS3f1IzRqCi019epBfNGsGBL
         8TO6gv50pUT2bNAWYVMUDKBS3gslh86ihDiAylvYMCQcGV5SPvp9kupz0rQyLZ9vyjgs
         s5zMrlgBEyQHpeM/ggwOmZEed8IRBpvkydAMrfPH3Gs4smtBcmEx/TchhlNSmgITQid/
         4hyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ytBbvPTXR4FdqciS4jsfQvnjl2UrmH262qeoBNVrzHw=;
        b=S/hyo0zJ8f3U4mQQrLpEULz6ObbJQOf4p70OwOrBu80mRhUSwrKHaOb7GebONPCgyR
         w53nnrECe/fxBO/vjOe83dySYTXG6l3s/HVqMraX1RCx24a/uBikrTv4WMYCO8mg8qDF
         a0dQkBmifeoraPyW1LHvenR5Bp6YVc88vFOfcZZhorz88lKCwM5VB+b6nuy8kwi2KKLk
         ddvosBxAYMJZgU8l0/wngMv8gg7rtfKQBA4fQt/uJn8xfYk1NvjYXkP9ybUX49R617TH
         b0a9fkg6vbBJY4DyTzZVL9Ix2wPuDfpQWX2ifOJvCTd4YBQuG5JWNqC2vVTVlIe32ByM
         cqdw==
X-Gm-Message-State: AFqh2koqOCZaGidzQQ1qxyTv2Qfl7QliwCof2Yk3CzCPp8Fz8HX5e/gS
        i/axwx8YAu3DrnWuisF1skA=
X-Google-Smtp-Source: AMrXdXsxGwqIM5xvXEW99PyYos0qHzvLtaE2c5N1DiiTeZRQgwkFsv40m2wKs3WF1Y5ZUax9VoVMjg==
X-Received: by 2002:a62:6143:0:b0:577:3546:d7be with SMTP id v64-20020a626143000000b005773546d7bemr1140045pfb.30.1671602503240;
        Tue, 20 Dec 2022 22:01:43 -0800 (PST)
Received: from vernon-pc.. ([114.231.52.81])
        by smtp.gmail.com with ESMTPSA id w7-20020a626207000000b00562677968aesm9598886pfb.72.2022.12.20.22.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 22:01:42 -0800 (PST)
From:   Vernon Yang <vernon2gm@gmail.com>
To:     Liam.Howlett@oracle.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org, Vernon Yang <vernon2gm@gmail.com>
Subject: [PATCH v2 7/7] maple_tree: refine mab_calc_split function
Date:   Wed, 21 Dec 2022 14:00:58 +0800
Message-Id: <20221221060058.609003-8-vernon2gm@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221221060058.609003-1-vernon2gm@gmail.com>
References: <20221221060058.609003-1-vernon2gm@gmail.com>
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

Invert the conditional judgment of the mid_split, to focus
the return statement in the last statement, which is easier
to understand and for better readability.

Signed-off-by: Vernon Yang <vernon2gm@gmail.com>
---
 lib/maple_tree.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 5911211c8557..5e1a9d39b330 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -1882,10 +1882,9 @@ static inline int mab_calc_split(struct ma_state *mas,
 
 	/* Avoid ending a node on a NULL entry */
 	split = mab_no_null_split(bn, split, slot_count);
-	if (!(*mid_split))
-		return split;
 
-	*mid_split = mab_no_null_split(bn, *mid_split, slot_count);
+	if (unlikely(*mid_split))
+		*mid_split = mab_no_null_split(bn, *mid_split, slot_count);
 
 	return split;
 }
-- 
2.34.1

