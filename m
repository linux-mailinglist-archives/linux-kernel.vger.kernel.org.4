Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63AFC652287
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 15:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbiLTO1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 09:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234000AbiLTO0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 09:26:51 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0FB1C116
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 06:26:44 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id a9so12408418pld.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 06:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5pCjcE2QSizxYYpcp3Q7JX0pj7AbGWE8N5U6SKdhaY=;
        b=CKh2pvjJEKmz9XfYB+s2Lm4mMBVB5Bv2Os5YbA+gIrD7IqyqI3Ob93H9gszwSnJ9Kf
         sN2nuI9TfUNHyfeEs4jgD5rfza83LS4rzw8Hne8yskYfTNDothnvWNLAMLQHBC04ByWW
         doMsWmNEVsHtiSY0wJPVtlAA2ZvQGm2v2fRkvutJroEV3zppdmSd5rC8fzp3IC1nKqDL
         oOtoxI2NH7HRIX2WY6h6EsocwG5B2iiGUPOwcLa+0QHm11jjm/mcDkbTCV5nkfMwd4hq
         3dAQg2580o2Bu0qySrLJycUJS2ObN1ZrF0X/Iy5NMT4PM/B2LovkVvjsOpyIc4i0lj5v
         WQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k5pCjcE2QSizxYYpcp3Q7JX0pj7AbGWE8N5U6SKdhaY=;
        b=BQK604XkGwHp+z5Ym1QGXFC0G/gROTuP59vIMbrqbA/RnSIowejM9B6yBciQ7L9GwO
         7RVE07GnZM+OM6oouwsVpKp7k4aHyhEinfeXvbnXsWVZrRBaUGSY1MtqVwXhcvSQ5e3F
         Zr0fjt9654PrHq4FwihJ21KMidTkwyFVVMOEJ5k+BqvCZs+yrrSB/uDSbjzUxbt//klX
         nwVwXYZg2KVWsX6SRm51H6ORZlWy/qm9KVAWXFmwKKSksnOJHBidiAFZwPpD7p19MEPZ
         a9YPWZ1vWd4mTBVqRn88+XNG60Ry4Ld7C14kWe58dxqb1/fV6hWioX4VoAxQdrTCZt6c
         ewpg==
X-Gm-Message-State: AFqh2kpBny+CqqQ86+lt/0bTrygTb4VHO3lLFz4NZssn4NlybD0go0fa
        DlRaHW012W/W/PR0EmwcTXB01MTgvT8OJBkeLxc=
X-Google-Smtp-Source: AMrXdXtlURzlzqLwBRnEXi12q7aZoY+rMiK4Tn9hVg323qyMw/gVzTSdDNY/lWtEe2PfX2SIKLofkA==
X-Received: by 2002:a17:902:bd87:b0:18c:1bc5:bd58 with SMTP id q7-20020a170902bd8700b0018c1bc5bd58mr13799535pls.9.1671546404436;
        Tue, 20 Dec 2022 06:26:44 -0800 (PST)
Received: from vernon-pc.. ([114.231.52.81])
        by smtp.gmail.com with ESMTPSA id ik11-20020a170902ab0b00b001897bfc9800sm9383398plb.53.2022.12.20.06.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 06:26:43 -0800 (PST)
From:   Vernon Yang <vernon2gm@gmail.com>
To:     Liam.Howlett@oracle.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vernon Yang <vernon2gm@gmail.com>
Subject: [PATCH 8/8] maple_tree: refine mab_calc_split function
Date:   Tue, 20 Dec 2022 22:26:06 +0800
Message-Id: <20221220142606.1698836-9-vernon2gm@gmail.com>
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

Invert the conditional judgment of the mid_split, to focus
the return statement in the last statement, which is easier
to understand and for better readability.

Signed-off-by: Vernon Yang <vernon2gm@gmail.com>
---
 lib/maple_tree.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 16cdcf309e97..d147669fb99c 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -1882,10 +1882,9 @@ static inline int mab_calc_split(struct ma_state *mas,
 
 	/* Avoid ending a node on a NULL entry */
 	split = mab_no_null_split(bn, split, slot_count);
-	if (!(*mid_split))
-		return split;
 
-	*mid_split = mab_no_null_split(bn, *mid_split, slot_count);
+	if (*mid_split)
+		*mid_split = mab_no_null_split(bn, *mid_split, slot_count);
 
 	return split;
 }
-- 
2.34.1

