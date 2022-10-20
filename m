Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C406606806
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 20:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiJTSO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 14:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiJTSOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 14:14:54 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A55D63DBCC
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 11:14:51 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 50BB420477CE;
        Thu, 20 Oct 2022 11:14:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 50BB420477CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1666289690;
        bh=ur8sScAym4ijq/4v4hHXNXCn8sXMfCruhdPnVBD9Zds=;
        h=From:To:Subject:Date:From;
        b=aGdm5Sd5dRnM54VEat6X0IA6HURGs2w6iDFe1M5AjRDo+qOYJGIkBoAjhec+7pOXf
         Su/Ht7+8b0sj4sMAL4q3aqMM6Msd6gKq6Mz0zVOnpT3LvVRocGTUciRTrT43/edgu5
         EV+LQBrQHqwS5Ru4noDwXZxPph2C39m+VXqFTBwc=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     ssengar@microsoft.com, akpm@linux-foundation.org,
        yuzhao@google.com, jack@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jostarks@microsoft.com
Subject: [PATCH] mm/gup: fix gup_pud_range() for dax
Date:   Thu, 20 Oct 2022 11:14:46 -0700
Message-Id: <1666289686-22798-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Starks <jostarks@microsoft.com>

For dax pud, pud_huge() returns true on x86. So the function works as long
as hugetlb is configured. However, dax doesn't depend on hugetlb.
Commit 414fd080d125 ("mm/gup: fix gup_pmd_range() for dax") fixed
devmap-backed huge PMDs, but missed devmap-backed huge PUDs. Fix this as
well.

Fixes: 414fd080d125 ("mm/gup: fix gup_pmd_range() for dax")
Signed-off-by: John Starks <jostarks@microsoft.com>
Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
 mm/gup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index 05068d3d2557..9e07aa54a4cd 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2687,7 +2687,7 @@ static int gup_pud_range(p4d_t *p4dp, p4d_t p4d, unsigned long addr, unsigned lo
 		next = pud_addr_end(addr, end);
 		if (unlikely(!pud_present(pud)))
 			return 0;
-		if (unlikely(pud_huge(pud))) {
+		if (unlikely(pud_huge(pud) || pud_devmap(pud))) {
 			if (!gup_huge_pud(pud, pudp, addr, next, flags,
 					  pages, nr))
 				return 0;
-- 
2.25.1

