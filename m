Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7DE46FBB17
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 00:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbjEHWb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 18:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjEHWb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 18:31:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9445BB4
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 15:31:56 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 348JOqYU002193;
        Mon, 8 May 2023 22:31:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=XrK/JXU+hKQB6UYMoHY7BZ0MAhaISZxQ8B5BJOL3qro=;
 b=ZqeLt0eR/Ob78wA1D9IsHB67IRe2CyVPaI18DIVSTO/aKx4ts4HIL/AyXewlMBrZ+Ecd
 WX0uJKr4F/WZWw75kk0djbWtqiCTbjyYQJqKzU5wVnqqnxBqoegprrStTjBfUzLFOBt7
 FIbUjQUMTD9HsEuslsJopkzN6+SHItVF1WyvyzKDHL4A5rl7Y3xyYMU8pSNxpZ1rJCXg
 BQP3dNlwTE5c9zvBAvk/p36Syng45Mtmo+xsQv8q5CN7//J/MIBBl0hI0mVP4Mp6ImpP
 VZQ9Pa8v8TwyIeLhRWxUHZpLri4w7a1qyq5ib+/9LGXY0gy5o4sZpPuh52X5FtUPxrhl Gw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf7770ah4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 May 2023 22:31:45 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 348LZueZ015246;
        Mon, 8 May 2023 22:31:44 GMT
Received: from localhost.localdomain (dhcp-10-191-130-46.vpn.oracle.com [10.191.130.46])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3qf77f5pca-2;
        Mon, 08 May 2023 22:31:44 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     peterz@infradead.org, paulmck@kernel.org, jgross@suse.com,
        vschneid@redhat.com, yury.norov@gmail.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 1/2] smp: Reduce logging due to dump_stack of CSD waiters.
Date:   Tue,  9 May 2023 08:31:23 +1000
Message-Id: <20230508223124.1438167-2-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230508223124.1438167-1-imran.f.khan@oracle.com>
References: <20230508223124.1438167-1-imran.f.khan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-08_16,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305080149
X-Proofpoint-GUID: _fkGR7T4gLbh6PYqry66MmP2USW6qBbc
X-Proofpoint-ORIG-GUID: _fkGR7T4gLbh6PYqry66MmP2USW6qBbc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a waiter is waiting for CSD lock, its call stack will not change
between first and subsequent hang detection for the same CSD lock.
So dump_stack for the waiter only for first time detection.

This avoids excessive logging on large scale systems(with hundreds
of CPUs) where repetitive dump_stack from hundreds of CPUs can flood
the console.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/smp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index ab3e5dad6cfe9..b7ccba677a0a0 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -248,7 +248,8 @@ static bool csd_lock_wait_toolong(struct __call_single_data *csd, u64 ts0, u64 *
 			arch_send_call_function_single_ipi(cpu);
 		}
 	}
-	dump_stack();
+	if (firsttime)
+		dump_stack();
 	*ts1 = ts2;
 
 	return false;
-- 
2.34.1

