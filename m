Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7AA66B5E2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 04:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjAPDL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 22:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbjAPDLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 22:11:55 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B824C17
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 19:11:54 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id q64so27791033pjq.4
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 19:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+uvWnxWMZEBIPVCCWshuAk5p9GxmhTM+KlXSt0OWDlo=;
        b=e9J/PhiX3rq8foVglCMKTK1MRLHL40bGSnRCohcD26yDRznHcBNM1F24x8vJ3tbdtZ
         pLRH/B+MYdUSzxuh5nLa5vi/NOm4Z+EG4zPSja/UKyhEyrtAP6TPpAQFM/Jz0bUJaWyG
         8jPAmPnnzI36C8JpFcNdXhOCWZbZXX03Ff0DsH22t7iJx+G1bNOGeX9ltcPnDYGiCRgD
         AWNnAoxbGesfPyxEmcDfgdCV0TzFIQ+lNI7UfpffLOV85fp0xzPJpfR6Y2rd7adindM9
         Bzgy5/nFaLx4pW5ORpKVN0rUGFRXO7Tp2lGqCLG8U7QVaQcjYSmuNWkHXSyYuCyuX0cL
         1ETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+uvWnxWMZEBIPVCCWshuAk5p9GxmhTM+KlXSt0OWDlo=;
        b=nG9NmigrqiORMJ3M/hJY+h3qiICfF4/JZ0c/UNEPwnmgKnBvcHnLl6wUHZx12CZBcC
         9LFhsPq6NlwKD8dMX18SYmKTCnYvyVOzUpmW9/S1uWWxvHhOpjRtawJFkBsXiWjwuMYc
         k0ANCgPKEMVs84ALOOfatuNiwMq0zrJEaH1KJmzxV8OCxFZfsZMDu0h+tvQQbwhAUKET
         Uc9HtyLl+5VSFu23OUm48R36cVVGe2G/wwK5iDqh7OuotWt0uR9cihRc40cTmZebWE+R
         BvcCkpNnR9XugPCaYoW9ZkVZgkcWJQqro3VlSpNeOgDEy9gHJMy/ThCdul3QC6kcfgTl
         WSgQ==
X-Gm-Message-State: AFqh2kr9+iF5IJn8jqnnSZcp8aJan1o2oO2gMflX7n6o7ILLojHZ6W0E
        mRcqUTCn+RjGnfA7EfxAD8o=
X-Google-Smtp-Source: AMrXdXuF2b9j/acNhKWm3eKdgl1Kz9pOPdAae3xJR8x+uVyVFiK8BPcplWdJZN/qW3mTaUcx5sjONw==
X-Received: by 2002:a17:903:24a:b0:194:480d:6afc with SMTP id j10-20020a170903024a00b00194480d6afcmr20913024plh.48.1673838714072;
        Sun, 15 Jan 2023 19:11:54 -0800 (PST)
Received: from mi-HP-ProDesk-680-G4-MT.mioffice.cn ([43.224.245.252])
        by smtp.gmail.com with ESMTPSA id m3-20020a170902db0300b0018980f14ecfsm15326458plx.115.2023.01.15.19.11.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Jan 2023 19:11:53 -0800 (PST)
From:   qixiaoyu1 <qxy65535@gmail.com>
X-Google-Original-From: qixiaoyu1 <qixiaoyu1@xiaomi.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, qixiaoyu1@xiaomi.com,
        xiongping1@xiaomi.com
Subject: [PATCH 1/2 v2] f2fs: fix wrong calculation of block age
Date:   Mon, 16 Jan 2023 11:08:49 +0800
Message-Id: <20230116030850.20260-1-qixiaoyu1@xiaomi.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230113125859.15651-1-qixiaoyu1@xiaomi.com>
References: <20230113125859.15651-1-qixiaoyu1@xiaomi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we wrongly calculate the new block age to
old * LAST_AGE_WEIGHT / 100.

Fix it to new * (100 - LAST_AGE_WEIGHT) / 100
                + old * LAST_AGE_WEIGHT / 100.

Signed-off-by: qixiaoyu1 <qixiaoyu1@xiaomi.com>
Signed-off-by: xiongping1 <xiongping1@xiaomi.com>
---
Change log v1 -> v2:
 - fix udiv

 fs/f2fs/extent_cache.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 342af24b2f8c..ad5533f178fd 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -874,11 +874,8 @@ void f2fs_update_read_extent_tree_range_compressed(struct inode *inode,
 static unsigned long long __calculate_block_age(unsigned long long new,
 						unsigned long long old)
 {
-	unsigned long long diff;
-
-	diff = (new >= old) ? new - (new - old) : new + (old - new);
-
-	return div_u64(diff * LAST_AGE_WEIGHT, 100);
+	return div_u64(new, 100) * (100 - LAST_AGE_WEIGHT)
+		+ div_u64(old, 100) * LAST_AGE_WEIGHT;
 }
 
 /* This returns a new age and allocated blocks in ei */
-- 
2.36.1

