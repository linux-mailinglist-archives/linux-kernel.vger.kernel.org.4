Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B831639FAB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 03:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiK1Cqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 21:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiK1CqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 21:46:13 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C32011A06;
        Sun, 27 Nov 2022 18:46:07 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AS1jSRl027845;
        Mon, 28 Nov 2022 02:45:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=hRKbgPIfXpWItDUNGQ18eZmARY23HnteA925JlfSjJ0=;
 b=KahTis9+9sN+F30kSW0NGZXFdnHlYkvM8vm/qgREIi9+2S8A7swzZbRKrnqgBYJ5Lj6H
 ec5sv2SVuqH4vLnO5vL5X86W/Mz7d3EVH8q4YNytgHlHOKLh8viHXemvaWaCj0eWc6qr
 EtSSxmwvpOE1+Ynb8ko7vdy75sxx40/oHxNz+xcl/MFtx9NR+/6BpW3KpQ0XpqOpRPXa
 wPhY/QkH8vjHjsajNkvZLZ/d72v9GTELzfqQLJ3ddvoguphFAUcEpnBR4YVYZKtS99Lx
 Kkt9MO7aleXVOBTbZpXv9pxV1zxP43Su4gKP36XJDE4BWKC8N2UPTV3zQ5NVCZwi21hi Wg== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m3vn6ups3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Nov 2022 02:45:49 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AS2aqAo002451;
        Mon, 28 Nov 2022 02:45:47 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06fra.de.ibm.com with ESMTP id 3m3a2hsbdc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Nov 2022 02:45:47 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AS2ji4F1114862
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Nov 2022 02:45:44 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B2B2411C050;
        Mon, 28 Nov 2022 02:45:44 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D17A11C04A;
        Mon, 28 Nov 2022 02:45:44 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 28 Nov 2022 02:45:44 +0000 (GMT)
Received: from li-0d7fa1cc-2c9d-11b2-a85c-aed20764436d.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 4F28A60312;
        Mon, 28 Nov 2022 13:45:39 +1100 (AEDT)
From:   Benjamin Gray <bgray@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     ajd@linux.ibm.com, ruscur@russell.cc, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, cmr@bluescreens.de,
        Benjamin Gray <bgray@linux.ibm.com>
Subject: [RFC PATCH 05/13] prctl: Define PowerPC DEXCR interface
Date:   Mon, 28 Nov 2022 13:44:50 +1100
Message-Id: <20221128024458.46121-6-bgray@linux.ibm.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221128024458.46121-1-bgray@linux.ibm.com>
References: <20221128024458.46121-1-bgray@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -pC6GJ7LCjS02iw7JgnEbMfDt3VekRIJ
X-Proofpoint-ORIG-GUID: -pC6GJ7LCjS02iw7JgnEbMfDt3VekRIJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-28_02,2022-11-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 mlxlogscore=743 phishscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211280018
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds the definitions and generic handler for prctl control of the
PowerPC Dynamic Execution Control Register (DEXCR).

Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>
---
 include/uapi/linux/prctl.h | 14 ++++++++++++++
 kernel/sys.c               | 16 ++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index a5e06dcbba13..b4720e8de6f3 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -281,6 +281,20 @@ struct prctl_mm_map {
 # define PR_SME_VL_LEN_MASK		0xffff
 # define PR_SME_VL_INHERIT		(1 << 17) /* inherit across exec */
 
+/* PowerPC Dynamic Execution Control Register (DEXCR) controls */
+#define PR_PPC_GET_DEXCR		65
+#define PR_PPC_SET_DEXCR		66
+/* DEXCR aspect to act on */
+# define PR_PPC_DEXCR_SBHE		0 /* Speculative branch hint enable */
+# define PR_PPC_DEXCR_IBRTPD		1 /* Indirect branch recurrent target prediction disable */
+# define PR_PPC_DEXCR_SRAPD		2 /* Subroutine return address prediction disable */
+# define PR_PPC_DEXCR_NPHIE		3 /* Non-privileged hash instruction enable */
+/* Action to apply / return */
+# define PR_PPC_DEXCR_PRCTL		(1 << 0)
+# define PR_PPC_DEXCR_SET_ASPECT	(1 << 1)
+# define PR_PPC_DEXCR_FORCE_SET_ASPECT	(1 << 2)
+# define PR_PPC_DEXCR_CLEAR_ASPECT	(1 << 3)
+
 #define PR_SET_VMA		0x53564d41
 # define PR_SET_VMA_ANON_NAME		0
 
diff --git a/kernel/sys.c b/kernel/sys.c
index 5fd54bf0e886..55b8f7369059 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -139,6 +139,12 @@
 #ifndef GET_TAGGED_ADDR_CTRL
 # define GET_TAGGED_ADDR_CTRL()		(-EINVAL)
 #endif
+#ifndef PPC_GET_DEXCR_ASPECT
+# define PPC_GET_DEXCR_ASPECT(a, b)	(-EINVAL)
+#endif
+#ifndef PPC_SET_DEXCR_ASPECT
+# define PPC_SET_DEXCR_ASPECT(a, b, c)	(-EINVAL)
+#endif
 
 /*
  * this is where the system-wide overflow UID and GID are defined, for
@@ -2623,6 +2629,16 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 		error = sched_core_share_pid(arg2, arg3, arg4, arg5);
 		break;
 #endif
+	case PR_PPC_GET_DEXCR:
+		if (arg3 || arg4 || arg5)
+			return -EINVAL;
+		error = PPC_GET_DEXCR_ASPECT(me, arg2);
+		break;
+	case PR_PPC_SET_DEXCR:
+		if (arg4 || arg5)
+			return -EINVAL;
+		error = PPC_SET_DEXCR_ASPECT(me, arg2, arg3);
+		break;
 	case PR_SET_VMA:
 		error = prctl_set_vma(arg2, arg3, arg4, arg5);
 		break;
-- 
2.38.1

