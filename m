Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41C463B216
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 20:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbiK1TTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 14:19:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233219AbiK1TTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 14:19:42 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6A1271E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 11:19:40 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ASIwsSm008634;
        Mon, 28 Nov 2022 19:19:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=+gLY5OoxmlxRDbqoAsbBva+B7i53FlqQOurNICHD+r0=;
 b=NO3ht+97UMhb+g8DmzZAIo7zH75Lk3F9806xRd+qBte0klzOjVCpvXZ15GKuVVtGo31D
 aD1gmyYQu7/JK/7oZ++0PnCJLONG/gL+dtRznyopsXNGScCwRi7T9Dq/Pj3hNkVK71IF
 7baXRiCT65V2n1aIKuml3M0eGpa+VnmX2Wq1C84Vi5ExxVPTfYGLKotzjPfusdke92j1
 /bveAMElM2FgLDYuFaBrI+Ocu/TJLV5jWSQRilnkpqUrPJH1Cld1KLV6hNIwI7fiDWat
 Zh2wNgcpvc96XvLVHoL/Y8x7MzU3g9a8fhxrjXlBb7fXzXflrDWJwzVysQmhiDzG6tiB SQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m39k2mkd0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Nov 2022 19:19:37 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ASIb0wn028047;
        Mon, 28 Nov 2022 19:19:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m4a2fdaqr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Nov 2022 19:19:35 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2ASJJZ13005867;
        Mon, 28 Nov 2022 19:19:35 GMT
Received: from dhcp-10-152-13-169.usdhcp.oraclecorp.com.com (dhcp-10-152-13-169.usdhcp.oraclecorp.com [10.152.13.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3m4a2fdaq5-1;
        Mon, 28 Nov 2022 19:19:35 +0000
From:   George Kennedy <george.kennedy@oracle.com>
To:     bryantan@vmware.com, vdasa@vmware.com, pv-drivers@vmware.com,
        arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     george.kennedy@oracle.com, linux-kernel@vger.kernel.org
Subject: [PATCH] VMCI: check context->notify_page after call to get_user_pages_fast() to avoid GPF
Date:   Mon, 28 Nov 2022 15:18:25 -0500
Message-Id: <1669666705-24012-1-git-send-email-george.kennedy@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-28_17,2022-11-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=807 spamscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211280140
X-Proofpoint-GUID: mskZEriotQiaUj82hfFPKwlPkHgl7L8B
X-Proofpoint-ORIG-GUID: mskZEriotQiaUj82hfFPKwlPkHgl7L8B
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The call to get_user_pages_fast() in vmci_host_setup_notify() can return
NULL context->notify_page causing a GPF. To avoid GPF check if
context->notify_page == NULL and return error if so.

general protection fault, probably for non-canonical address
    0xe0009d1000000060: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: maybe wild-memory-access in range [0x0005088000000300-
    0x0005088000000307]
CPU: 2 PID: 26180 Comm: repro_34802241 Not tainted 6.1.0-rc4 #1
Hardware name: Red Hat KVM, BIOS 1.15.0-2.module+el8.6.0 04/01/2014
RIP: 0010:vmci_ctx_check_signal_notify+0x91/0xe0
Call Trace:
 <TASK>
 vmci_host_unlocked_ioctl+0x362/0x1f40
 __x64_sys_ioctl+0x1a1/0x230
 do_syscall_64+0x3a/0x90
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Fixes: a1d88436d53a ("VMCI: Fix two UVA mapping bugs")
Reported-by: syzkaller <syzkaller@googlegroups.com>
Signed-off-by: George Kennedy <george.kennedy@oracle.com>
---
 drivers/misc/vmw_vmci/vmci_host.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/vmw_vmci/vmci_host.c b/drivers/misc/vmw_vmci/vmci_host.c
index da1e2a773823..857b9851402a 100644
--- a/drivers/misc/vmw_vmci/vmci_host.c
+++ b/drivers/misc/vmw_vmci/vmci_host.c
@@ -242,6 +242,8 @@ static int vmci_host_setup_notify(struct vmci_ctx *context,
 		context->notify_page = NULL;
 		return VMCI_ERROR_GENERIC;
 	}
+	if (context->notify_page == NULL)
+		return VMCI_ERROR_UNAVAILABLE;
 
 	/*
 	 * Map the locked page and set up notify pointer.
-- 
2.31.1

