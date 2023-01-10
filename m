Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE72664401
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 16:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238639AbjAJPEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 10:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238828AbjAJPDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 10:03:33 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0085C1EF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 07:03:28 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id s8so5127442plk.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 07:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6qhudAhZPV2iDT+KE0kLjqDPYcS33lIjDaCweDJV/Yw=;
        b=paSOTQBfcv/CXVsX2hlndz2PQG6+9r6Y7xHwUqxNwSJmyhdEV3NhWFNJINv5wopuCk
         bq6D18LQyZpX8zqs7Qux/I8r1v6mv4C9qKtdr4svj7ZqTrtLfycgr4Wc/LrfXp/T8EUV
         uxH2g7kZjvoAFIf/pm3/ZX8VpuiU1J/kgtMepjGfqzVwjchgMVobHlvHb/jK7FeoqiDo
         9340HGdZJSlDuQMNdiUChR7W70w864zqVmUsDFq26m3cZA6JUNVAd5abOHeK0TQzAqt/
         JQSpxoLpKyh1yc6Si5Wc9LR7C2tC0jZVEybizOTVM69oAewey4y06nNVZR5WCgkJWul7
         wjJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6qhudAhZPV2iDT+KE0kLjqDPYcS33lIjDaCweDJV/Yw=;
        b=BgHT96H0aQeI9UBLm3eAWzqIdszxf+RQPxvRC9hNT2MzTCCQK2b03a03/urmxQaSts
         uIuuapaUN33edABrQBfFkF2AYCcZ5+yYkc/vvdtaPj11ZYQ4oNaK+s8wA1v4sN1Edea7
         vpKZres/A+dTk5EgrnOhfgkDT4qyB5yR9WmkHX+DpecBwIE179qiFWAG0WHE2hEGI81N
         Qq+eQmAJZqzzSjix0qfdA+En42xB2Bzuj645rvebLQ+O594Cd5iro+Ww3SavOxl1x1xm
         pUaAnQCrftqqwMsEhsR0jNBAPItSPqd/DWU+o4zT6MJky8U9cMXCMK2P0PP0f6qVe2Ql
         OPZA==
X-Gm-Message-State: AFqh2kqCpsAZyl5DtWTCbN4Ico9f4oO3Qp7rLM/j5dOAA09VDfEH4U11
        hDuYgNsYVkU4dgNL9JTNo1U=
X-Google-Smtp-Source: AMrXdXtEVrLHAPYBitDJrA9w0WXlvAmSp/3YBee3hkA9hVra97xsgiBYnqG+5bC0eFYM03Qoe6rXdw==
X-Received: by 2002:a05:6a21:3942:b0:9d:efbe:2065 with SMTP id ac2-20020a056a21394200b0009defbe2065mr90520239pzc.27.1673363007601;
        Tue, 10 Jan 2023 07:03:27 -0800 (PST)
Received: from vernon-pc.. ([49.67.3.29])
        by smtp.gmail.com with ESMTPSA id y14-20020a63fa0e000000b004a7e39ff1e8sm7003212pgh.49.2023.01.10.07.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 07:03:26 -0800 (PST)
From:   Vernon Yang <vernon2gm@gmail.com>
To:     Liam.Howlett@Oracle.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vernon Yang <vernon2gm@gmail.com>
Subject: [PATCH] mm/mmap: fix comment of unmapped_area{_topdown}
Date:   Tue, 10 Jan 2023 23:03:20 +0800
Message-Id: <20230110150320.1676299-1-vernon2gm@gmail.com>
X-Mailer: git-send-email 2.34.1
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

The low_limit of unmapped area information is inclusive, and the
hight_limit is not, so make the comment to correct.

Fixes: 3499a13168da ("mm/mmap: use maple tree for unmapped_area{_topdown}")
Signed-off-by: Vernon Yang <vernon2gm@gmail.com>
---
 mm/mmap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index c9da9119d7f2..e06f9ae34ff8 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1554,7 +1554,7 @@ static inline int accountable_mapping(struct file *file, vm_flags_t vm_flags)
  * the correct alignment and offset, all from @info. Note: current->mm is used
  * for the search.
  *
- * @info: The unmapped area information including the range (low_limit -
+ * @info: The unmapped area information including the range [low_limit -
  * hight_limit), the alignment offset and mask.
  *
  * Return: A memory address or -ENOMEM.
@@ -1581,10 +1581,10 @@ static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
 
 /**
  * unmapped_area_topdown() - Find an area between the low_limit and the
- * high_limit with * the correct alignment and offset at the highest available
+ * high_limit with the correct alignment and offset at the highest available
  * address, all from @info. Note: current->mm is used for the search.
  *
- * @info: The unmapped area information including the range (low_limit -
+ * @info: The unmapped area information including the range [low_limit -
  * hight_limit), the alignment offset and mask.
  *
  * Return: A memory address or -ENOMEM.
-- 
2.34.1

