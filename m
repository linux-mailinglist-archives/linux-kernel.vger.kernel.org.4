Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD106AC1EE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 14:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjCFNzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 08:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjCFNzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 08:55:36 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843A929426
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 05:55:35 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326D59jg018320;
        Mon, 6 Mar 2023 13:55:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=gRD8JJYANQoaDeDDLwQmfnykMhkvwfwnnj9U9gA27mA=;
 b=m6V+7NL6ucr8BkYk9y+2W8uMUK50NAyeDGOY6X9ZF0aBaUmJDmWFE2MwDhQA6R4PFGCA
 ogtqy8M1Ib7Ou8a5wg945i8rVgiVzzhLysZb7QUs/ll93cAPb0u0fAONqwcKcsUmzx7R
 i/57EqO8Sr5/PgohMQ9UyEZY9EM7qYDPsby50LOH7sZEZKzr5KAh9P0q+E/4WQDXSas2
 TbnJlyH9fXEWhjXTSt3ahyOaIhSVzt0XiPxzL6xfr1+nqlX8ALfmdTWgFQAnzb/rD8i2
 rtrgcNS6d5f46AHO9IxBuRQ0GzfR5wAQE5+mJ2nsEBBAYzu5/X1yjLbQ8WG1vyY8DjXu Hw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p4vp20636-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 13:55:28 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 326D9B4R024378;
        Mon, 6 Mar 2023 13:55:28 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p4vp2062g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 13:55:28 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3266D2uk008169;
        Mon, 6 Mar 2023 13:55:26 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3p419ka7dv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 13:55:25 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 326DtLHF19792456
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Mar 2023 13:55:21 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 28ABE2006A;
        Mon,  6 Mar 2023 13:55:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4B7920067;
        Mon,  6 Mar 2023 13:55:20 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.101.4.33])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Mar 2023 13:55:20 +0000 (GMT)
From:   Laurent Dufour <ldufour@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Sachin Sant <sachinp@linux.ibm.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH] powerpc/mm: fix mmap_lock bad unlock
Date:   Mon,  6 Mar 2023 14:55:20 +0100
Message-Id: <20230306135520.4222-1-ldufour@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -mfselKxpsUFz8XBPm9kLaG4aVfl3jwU
X-Proofpoint-GUID: OchV6nD80rsjtI295AnTPoQEGnRuyelA
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_05,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 clxscore=1015 suspectscore=0
 mlxlogscore=999 mlxscore=0 priorityscore=1501 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303060120
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When page fault is tried holding the per VMA lock, bad_access_pkey() and
bad_access() should not be called because it is assuming the mmap_lock is
held.
In the case a bad access is detected, fall back to the default path,
grabbing the mmap_lock to handle the fault and report the error.

Fixes: 169db3bb4609 ("powerc/mm: try VMA lock-based page fault handling first")
Reported-by: Sachin Sant <sachinp@linux.ibm.com>
Link: https://lore.kernel.org/linux-mm/842502FB-F99C-417C-9648-A37D0ECDC9CE@linux.ibm.com
Cc: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
---
 arch/powerpc/mm/fault.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index c7ae86b04b8a..e191b3ebd8d6 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -479,17 +479,13 @@ static int ___do_page_fault(struct pt_regs *regs, unsigned long address,
 
 	if (unlikely(access_pkey_error(is_write, is_exec,
 				       (error_code & DSISR_KEYFAULT), vma))) {
-		int rc = bad_access_pkey(regs, address, vma);
-
 		vma_end_read(vma);
-		return rc;
+		goto lock_mmap;
 	}
 
 	if (unlikely(access_error(is_write, is_exec, vma))) {
-		int rc = bad_access(regs, address);
-
 		vma_end_read(vma);
-		return rc;
+		goto lock_mmap;
 	}
 
 	fault = handle_mm_fault(vma, address, flags | FAULT_FLAG_VMA_LOCK, regs);
-- 
2.39.2

