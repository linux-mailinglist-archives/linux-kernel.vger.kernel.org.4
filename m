Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D641A74D172
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbjGJJ2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjGJJ2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:28:07 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9E993;
        Mon, 10 Jul 2023 02:28:06 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36A9MnWJ019742;
        Mon, 10 Jul 2023 09:28:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=1ETM3ZV2G0pjYnWCAaDka1qaTNjsvUPhRVhjxdUSZNc=;
 b=o4vX2vtB44JXqpa4zMFDkzZJ+QX3a33MP+AUi/Lr/qVtIB062j5Tsds4hsrE/+cFXJ0W
 Jp8lxbxVZluq4FHlDCbCoFw+2T0Ifp6Xn/1uYsJjMNpCcdBo4AejXmhh9m8qTIBS5UV8
 bRVMrg6cV8CanEdqJcoYjNU/KtFnTxqPLvPJc+Pu71dSCXXLjDgrYIxe+WX4kTc2l41t
 ZyxbYiLa7S8LJLLHavuGD1Rc79wVOWpXm/I5CL30+NTc3m/bgByCfL2Bx818AKETMM33
 C3Amx1Bvo7ua4D8QXDAHD3Ko+4Q39hceIZOX/ffn9AP/NhJgJY53DNlDI/8kMhj6zZx/ 2Q== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rrfa0r2x8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 09:28:01 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36A7mY5T014500;
        Mon, 10 Jul 2023 09:27:59 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3rpy2e1595-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 09:27:59 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36A9Rtm344564976
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jul 2023 09:27:55 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BBF442004B;
        Mon, 10 Jul 2023 09:27:55 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC63020043;
        Mon, 10 Jul 2023 09:27:53 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com.com (unknown [9.43.85.154])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 10 Jul 2023 09:27:53 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     mpe@ellerman.id.au
Cc:     linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, disgoel@linux.ibm.com,
        kjain@linux.ibm.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/10] docs: ABI: sysfs-bus-event_source-devices-hv_gpci: Document affinity_domain_via_domain sysfs interface file
Date:   Mon, 10 Jul 2023 14:57:15 +0530
Message-Id: <20230710092717.55317-9-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230710092717.55317-1-kjain@linux.ibm.com>
References: <20230710092717.55317-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: O9ESu-ZK3bpuOpBh22Da7pOjHDMQTety
X-Proofpoint-ORIG-GUID: O9ESu-ZK3bpuOpBh22Da7pOjHDMQTety
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_07,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 adultscore=0 bulkscore=0 mlxscore=0 phishscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2307100082
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add details of the new hv-gpci interface file called
"affinity_domain_via_domain" in the ABI documentation.

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 .../sysfs-bus-event_source-devices-hv_gpci    | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_gpci b/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_gpci
index 3b63d66658fe..d8e65b93d1f7 100644
--- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_gpci
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_gpci
@@ -176,3 +176,35 @@ Description:	admin read only
 			   more information.
 
 		* "-EFBIG" : System information exceeds PAGE_SIZE.
+
+What:		/sys/devices/hv_gpci/interface/affinity_domain_via_domain
+Date:		July 2023
+Contact:	Linux on PowerPC Developer List <linuxppc-dev@lists.ozlabs.org>
+Description:	admin read only
+		This sysfs file exposes the system topology information by making HCALL
+		H_GET_PERF_COUNTER_INFO. The HCALL is made with counter request value
+		AFFINITY_DOMAIN_INFORMATION_BY_DOMAIN(0xB0).
+
+		* This sysfs file will be created only for power10 and above platforms.
+
+		* User needs root privileges to read data from this sysfs file.
+
+		* This sysfs file will be created, only when the HCALL returns "H_SUCESS",
+		  "H_AUTHORITY" and "H_PARAMETER" as the return type.
+
+		  HCALL with return error type "H_AUTHORITY", can be resolved during
+		  runtime by setting "Enable Performance Information Collection" option.
+
+		* The end user reading this sysfs file must decode the content as per
+		  underlying platform/firmware.
+
+		Possible error codes while reading this sysfs file:
+
+		* "-EPERM" : Partition is not permitted to retrieve performance information,
+			    required to set "Enable Performance Information Collection" option.
+
+		* "-EIO" : Can't retrieve system information because of invalid buffer length/invalid address
+			   or because of some hardware error. Refer getPerfCountInfo documentation for
+			   more information.
+
+		* "-EFBIG" : System information exceeds PAGE_SIZE.
-- 
2.31.1

