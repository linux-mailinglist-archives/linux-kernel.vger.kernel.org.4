Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02B668D72C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 13:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbjBGMtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 07:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbjBGMs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 07:48:57 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E201CF4A;
        Tue,  7 Feb 2023 04:48:53 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 317BwvTm011461;
        Tue, 7 Feb 2023 12:48:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=TGkF2tOO4frLvPts9ZwsXb2QPUj+1HoDuf+5oC5qBMs=;
 b=zogrOpzSNhuymsZ2J7Hj7yr0POlZj7LuKS6sJWnOzssC/32PJYxNlFa9rR9z2Pz4qE23
 AxMYoviUZwTIz+Xy4+NC2o2yKrfbM3AXpBldGvHVv4/LDwtUHpD4TV0e4n9+PIIgvf85
 FgPXrSFCmjura9s/mOKrKl/joqxmiEMvEPo/Tj6YShKDtsLaKYslw4HgcU5sLfUTk2GG
 2TkbOhPSoednafKu62/Wz7yqnsJUd7Aa4kUIn0PQn/74vItSsNq4EjieWgopXGcUt93p
 x5yHEgTCaIRlPHHh/W09Usg2xY8tgKUcq4xhNx7/sjeTmgVTrU5o5UgjJAikciqyICFi QQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhdsdne4w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Feb 2023 12:48:42 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 317CipCR040797;
        Tue, 7 Feb 2023 12:48:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdtbu8uh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Feb 2023 12:48:41 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 317Cd0lN029118;
        Tue, 7 Feb 2023 12:48:41 GMT
Received: from dhcp-10-152-13-169.usdhcp.oraclecorp.com.com (dhcp-10-152-13-169.usdhcp.oraclecorp.com [10.152.13.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3nhdtbu8uc-1;
        Tue, 07 Feb 2023 12:48:41 +0000
From:   George Kennedy <george.kennedy@oracle.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.cz,
        torvalds@linux-foundation.org
Cc:     george.kennedy@oracle.com, sfr@canb.auug.org.au,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: [PATCH v2] vc_screen: break from vcs_read() while loop if vcs_vc() returns NULL
Date:   Tue,  7 Feb 2023 07:48:18 -0500
Message-Id: <1675774098-17722-1-git-send-email-george.kennedy@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-07_05,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302070114
X-Proofpoint-ORIG-GUID: 4r_C2QQumyNCCkEnwvirGRvLf103Pp_g
X-Proofpoint-GUID: 4r_C2QQumyNCCkEnwvirGRvLf103Pp_g
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If vcs_vc() returns NULL in vcs_read(), break from while loop if partial
read, else if no reads have been done, go to unlock_out and return -ENXIO.
In addition, change the goto unlock_out after vcs_size() to a break
to conform to the break handling after vcs_vc().

Fixes: ac751efa6a0d ("console: rename acquire/release_console_sem() to console_lock/unlock()")
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: George Kennedy <george.kennedy@oracle.com>
---
 drivers/tty/vt/vc_screen.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index f566eb1839dc..c599b452969f 100644
--- a/drivers/tty/vt/vc_screen.c
+++ b/drivers/tty/vt/vc_screen.c
@@ -406,19 +406,17 @@ vcs_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 		ret = -ENXIO;
 		vc = vcs_vc(inode, &viewed);
 		if (!vc)
-			goto unlock_out;
+			break;
 
 		/* Check whether we are above size each round,
 		 * as copy_to_user at the end of this loop
 		 * could sleep.
 		 */
-		size = vcs_size(vc, attr, uni_mode);
-		if (size < 0) {
-			if (read)
-				break;
-			ret = size;
-			goto unlock_out;
-		}
+		ret = vcs_size(vc, attr, uni_mode);
+		if (ret < 0)
+			break;
+		size = ret;
+		ret = 0;
 		if (pos >= size)
 			break;
 		if (count > size - pos)
-- 
2.31.1

