Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2201668C4F3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 18:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjBFRfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 12:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjBFRe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 12:34:59 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86217193FB;
        Mon,  6 Feb 2023 09:34:57 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316Do1I4014930;
        Mon, 6 Feb 2023 17:34:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=QkknUqbMN7pIPh7Yyf9EATe+u5Np2m8BXE1VTM7Yq70=;
 b=sd96wllolymjr44giYkdm04zQ9ohDLu2xnecMlR09YIKxn6rAF0bD8aDgzawHU5taBy9
 LKA/5Emfyjm2DqSUYqYNkVe+D0WmcpGSHAmPtiwWxRMMKvRwXijTdt6aY/11PQEMFztW
 LfBcx4anOq4gsMliXk/Crm9ibE7Y1jaVTZrj+b7F0pL2qR1XgG9q3cm1tdsTt+ym5+Bi
 sDyE3uEMLtssr1zd6/BtFeNAWWtg1K/fWsq9nB6+2fW2gP2Ai3ymX5cW8+o3vFZhEVd/
 Ykbaw1QQK6SZ16gAQ4g8Prttx0ee0Blpx3xR1aL02g3sjKHWMMV6Q0GqBWvbhZoth9qK cw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhfdcbh7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Feb 2023 17:34:46 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 316GJvRl001126;
        Mon, 6 Feb 2023 17:34:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdtbcs7w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Feb 2023 17:34:28 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 316HWnYb005807;
        Mon, 6 Feb 2023 17:34:27 GMT
Received: from dhcp-10-152-13-169.usdhcp.oraclecorp.com.com (dhcp-10-152-13-169.usdhcp.oraclecorp.com [10.152.13.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3nhdtbcs7g-1;
        Mon, 06 Feb 2023 17:34:27 +0000
From:   George Kennedy <george.kennedy@oracle.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.cz,
        torvalds@linux-foundation.org
Cc:     george.kennedy@oracle.com, sfr@canb.auug.org.au,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: [PATCH] vc_screen: break from vcs_read() while loop if vcs_vc() returns NULL
Date:   Mon,  6 Feb 2023 12:34:04 -0500
Message-Id: <1675704844-17228-1-git-send-email-george.kennedy@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302060153
X-Proofpoint-GUID: 8T4aTfuA2N3oVGprDUNzl_XUvuREaB3q
X-Proofpoint-ORIG-GUID: 8T4aTfuA2N3oVGprDUNzl_XUvuREaB3q
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If vcs_vc() returns NULL in vcs_read(), break if partial read,
else if no reads have been done, go to unlock_out and return ENXIO.

Fixes: 226fae124b2d ("vc_screen: move load of struct vc_data pointer in vcs_read() to avoid UAF")
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: George Kennedy <george.kennedy@oracle.com>
---
 drivers/tty/vt/vc_screen.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index f566eb1839dc..29288401cf9e 100644
--- a/drivers/tty/vt/vc_screen.c
+++ b/drivers/tty/vt/vc_screen.c
@@ -403,10 +403,13 @@ vcs_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 		unsigned int this_round, skip = 0;
 		int size;
 
-		ret = -ENXIO;
 		vc = vcs_vc(inode, &viewed);
-		if (!vc)
+		if (!vc) {
+			if (read)
+				break;
+			ret = -ENXIO;
 			goto unlock_out;
+		}
 
 		/* Check whether we are above size each round,
 		 * as copy_to_user at the end of this loop
-- 
2.31.1

