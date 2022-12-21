Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87E2652CA2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 07:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234476AbiLUGCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 01:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234470AbiLUGBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 01:01:43 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5578DE0EB
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 22:01:35 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d15so14548021pls.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 22:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4q1h/FltzRsnfoKTgYieWO+QDivMRlb3nPVnegVijrw=;
        b=qvyWkaPc2mWqmYZUiQwgi83zwsWommy6qCXbdOCAx0BGVDaGwsdStY6ZgNTuztkSdB
         vFsOmmu639lPnIjC6Oi2Yg9Jn8fgvKfiRoil4qTF8eE2fKY9YXsRg43LJOhdrNPBnHEm
         WqLaoM5oaCYUc9G5eQFjeSspwAKBI1KKJIfTEtJOv27q3gzAsp1gG0BpDT7pwDw5Ybhm
         z+U0DE9r7LxV04F3b1rdiP8/dzN/LRG8iCPOEJH52wZ53wL+gPuONp8sWeRBeQPfF7Op
         iMFXrVaXCSnnFovKG8zpRQ83A0CIfLh6j8FnoFFHCfyAsZolZY9r/HE4tMaGlpmZZUcm
         6z/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4q1h/FltzRsnfoKTgYieWO+QDivMRlb3nPVnegVijrw=;
        b=7p6bnWc11S7WhknwGnx6onjE1IsBpvyEXhQ1FJKKVUlgQJF2ZP7JyEZTIRK8/bN5u7
         c5poZ6MrYtL6zTBcIZ1JqNw7mwcnlRxbFj2hZSMT+VRfkG+mOjCRVbnC2gK3SVRM3JJQ
         OuLtyZXc/oM91t///PqCV3LkoVQFH3eTxPh58Qi6Lg4kOqJCTPHvW3IZA7oaVErd5zdw
         E9dvjYKqc7VjPEDk+kbXZULEJBhj1Mwh/R1e/hyv1RH8OgfugvaOY5htagn2fB/jed5c
         umSX1LFsOsI7EpH1aIVfa/i436WfCenFVk2nJmCh2YXvO61WXrWrofwOhxMbDFpbGqFv
         pezw==
X-Gm-Message-State: AFqh2kqjK2LY64hilu8tdTgD14b8qszm1yo0uz5lvSVRTi6QA9Tpn8dj
        v+ePmS89IpNpsGJ0Y5drguM=
X-Google-Smtp-Source: AMrXdXtMWHYZDWMbr3SCf2WxP+u1fWAuFluUCB86aTREdxhvQzXKoWcNNFKrvZ5xojMwDA7x/jxPHg==
X-Received: by 2002:a05:6a20:d807:b0:a8:79bc:dfae with SMTP id iv7-20020a056a20d80700b000a879bcdfaemr1303595pzb.20.1671602494878;
        Tue, 20 Dec 2022 22:01:34 -0800 (PST)
Received: from vernon-pc.. ([114.231.52.81])
        by smtp.gmail.com with ESMTPSA id w7-20020a626207000000b00562677968aesm9598886pfb.72.2022.12.20.22.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 22:01:34 -0800 (PST)
From:   Vernon Yang <vernon2gm@gmail.com>
To:     Liam.Howlett@oracle.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org, Vernon Yang <vernon2gm@gmail.com>
Subject: [PATCH v2 4/7] maple_tree: use macro MA_ROOT_PARENT instead of number
Date:   Wed, 21 Dec 2022 14:00:55 +0800
Message-Id: <20221221060058.609003-5-vernon2gm@gmail.com>
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

When you need to compare whether node->parent is parent of the
root node, using macro MA_ROOT_PARENT is easier to understand
and for better readability.

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
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

