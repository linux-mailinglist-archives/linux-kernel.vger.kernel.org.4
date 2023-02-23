Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D62D6A0337
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 08:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbjBWHND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 02:13:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjBWHNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 02:13:01 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6889E17CD9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 23:13:00 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id e5so12783077plg.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 23:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A6QTGm81phs1BDTIrGmL3AE+q+u9INzAv0b8ooL163Q=;
        b=qw6kU8IOs9YLnPcnx7k3brP0v/xsrbYbyyTADSWojaS3kGHoqpazneINsSl1LpCiF4
         z8kAT7JDnA7fI2KCP1/J0AhohtooNBj144mMfJIN0LogYQ7FN/e5P0ls0Gly6PuYCuAW
         cateNSima5wp7fKbcBQex/Lkk+KA6WjbzQVI1DeoRlN54tI7p8BSqmi1xXAMAzCnz9+/
         kk6g2RSEfyJVHutk26XlLurkGhUiBGgm7d6PVJ1EZQr0cJAsxzrjSqSsyyiWUG3uDCg5
         TuzwG8I0EmDlGc590Zg9IWhjwRK15xzOpOMIZTOE1kC2eBLscO4/VHdoc494DXQZbpD5
         KUiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A6QTGm81phs1BDTIrGmL3AE+q+u9INzAv0b8ooL163Q=;
        b=v9G04wy2pnzFQ/EUUhnzHmhd+YPT90upSNkdpwrxCfy7j5rKtuXUF8qTOxUI3EBgaY
         D/cj/ReNzroAtiQUXnXlt/wjPD61Hv586ikz2dFY8cfhd1XPRXYEup0G8wBTGykEH6Iy
         9ir0q2uxhHDs3xUZ0rGvII4dFu1iB4BVEH/YTotqvrno0RmXoRcyfCUGrXWLEuhI0/9t
         RhzJhC4th5z77FhMxKV2zDi+8hVa9fjl8bstrAgbPk5VlO4aTkUcR9JOc264I2wFF7xh
         Sat5bQJeE8XQmU9pclLlEDmcO7YBDgZmQQNNZKYL3I/klLB1lMcRpUJllU3JZ3nZ8dbh
         4EIQ==
X-Gm-Message-State: AO0yUKXuhSfEqU1zd+Nx5JUkjQAmanU/sMk7Lj9aC+tOnMbJJr2cyizw
        VsKQePgsFzAy9bdnOdScPsgICw==
X-Google-Smtp-Source: AK7set+Tp6YAU+VuewoLRDk/J3IiEoVCKpv3GmkSgsu7IaZt4N4jGYkQc3wV37sh3+9U7WFried9GQ==
X-Received: by 2002:a17:90b:4a85:b0:230:3af9:174 with SMTP id lp5-20020a17090b4a8500b002303af90174mr13622969pjb.5.1677136379844;
        Wed, 22 Feb 2023 23:12:59 -0800 (PST)
Received: from PXLDJ45XCM.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c24d00b0019ab6beea1esm2501639plg.87.2023.02.22.23.12.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 22 Feb 2023 23:12:59 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        muchun.song@linux.dev
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm: hugetlb_vmemmap: simplify hugetlb_vmemmap_init() a bit
Date:   Thu, 23 Feb 2023 14:59:47 +0800
Message-Id: <20230223065947.64134-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The check of IS_ENABLED(CONFIG_PROC_SYSCTL) is unnecessary since
register_sysctl_init() will be empty in this case. So, there is
no warnings after removing the check.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb_vmemmap.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 45e93a545dd7..274b91d408c3 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -590,17 +590,15 @@ static struct ctl_table hugetlb_vmemmap_sysctls[] = {
 
 static int __init hugetlb_vmemmap_init(void)
 {
+	const struct hstate *h;
+
 	/* HUGETLB_VMEMMAP_RESERVE_SIZE should cover all used struct pages */
 	BUILD_BUG_ON(__NR_USED_SUBPAGE * sizeof(struct page) > HUGETLB_VMEMMAP_RESERVE_SIZE);
 
-	if (IS_ENABLED(CONFIG_PROC_SYSCTL)) {
-		const struct hstate *h;
-
-		for_each_hstate(h) {
-			if (hugetlb_vmemmap_optimizable(h)) {
-				register_sysctl_init("vm", hugetlb_vmemmap_sysctls);
-				break;
-			}
+	for_each_hstate(h) {
+		if (hugetlb_vmemmap_optimizable(h)) {
+			register_sysctl_init("vm", hugetlb_vmemmap_sysctls);
+			break;
 		}
 	}
 	return 0;
-- 
2.11.0

