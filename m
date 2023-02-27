Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D59E6A4B68
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 20:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjB0ToO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 14:44:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjB0ToH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 14:44:07 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A45F26872;
        Mon, 27 Feb 2023 11:43:58 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31RIhvHZ010726;
        Mon, 27 Feb 2023 19:43:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=7lIiVMqu5705185ahJSiF59PA9a9eF0SX/DQ7uXlpkU=;
 b=dwxpx5p6fdbsNgy6b+kix//Dqdl7G6HaSXMrqSrAOcHqHsgtey9HDXeYirpCkOA23dcA
 /oBfo/tSsnGeI+5mQ16922hNuu4LXqfL5WFdSDzz4dlCeI0ZhEVcl0oFvxixwpbHVo+t
 oiR7PlQ/mYE3N81Poc8xBX/7c/BNKDnbY+ZbC4ceMViFxCt+zsmtDrSTiJXs+gL6aNXo
 1iqi5aS8DlYDQw+VTaWMK6b+gvaRGDm0WUQYtBBkEScjSmAA7c7HNWe5DFaKknZGAhZQ
 fJG8XF1rBMdFQHA41OoigvzwBC94CJOF4cT6wJUbjOIRg4ELcwyqxb3kapQXC1opQ937 pQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb6ech62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Feb 2023 19:43:39 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31RJ2NrH013835;
        Mon, 27 Feb 2023 19:43:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8s5rkh8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Feb 2023 19:43:38 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31RJe4qq029242;
        Mon, 27 Feb 2023 19:43:37 GMT
Received: from dhcp-10-152-13-169.usdhcp.oraclecorp.com.com (dhcp-10-152-13-169.usdhcp.oraclecorp.com [10.152.13.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3ny8s5rkgq-1;
        Mon, 27 Feb 2023 19:43:37 +0000
From:   George Kennedy <george.kennedy@oracle.com>
To:     jirislaby@kernel.org, gregkh@linuxfoundation.org,
        torvalds@linux-foundation.org
Cc:     george.kennedy@oracle.com, sfr@canb.auug.org.au,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux@weissschuh.net,
        regressions@lists.linux.dev
Subject: [PATCH] vc_screen: modify vcs_size() handling in vcs_read()
Date:   Mon, 27 Feb 2023 14:43:21 -0500
Message-Id: <1677527001-17459-1-git-send-email-george.kennedy@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-27_17,2023-02-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302270156
X-Proofpoint-ORIG-GUID: Zj3J6vKUlH6hO3mkKCc-07unSEDtD6ew
X-Proofpoint-GUID: Zj3J6vKUlH6hO3mkKCc-07unSEDtD6ew
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Restore the vcs_size() handling in vcs_read() to what
it had been in previous version.

Suggested-by: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: George Kennedy <george.kennedy@oracle.com>
---
 drivers/tty/vt/vc_screen.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index f566eb1839dc..c0a2273bb998 100644
--- a/drivers/tty/vt/vc_screen.c
+++ b/drivers/tty/vt/vc_screen.c
@@ -414,10 +414,8 @@ vcs_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 		 */
 		size = vcs_size(vc, attr, uni_mode);
 		if (size < 0) {
-			if (read)
-				break;
 			ret = size;
-			goto unlock_out;
+			break;
 		}
 		if (pos >= size)
 			break;
-- 
2.31.1

