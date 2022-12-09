Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15CB96483AE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 15:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiLIOVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 09:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiLIOUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 09:20:35 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2894712090
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 06:20:29 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B9Dn4N4023341;
        Fri, 9 Dec 2022 14:19:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=3s0sKuYQYSrxGa9epdS6MVxcS8fJENNzbKxhMU2MFhk=;
 b=Q9HOSLtFbNDYquy2ZvKgtZ/KGRAo2DL6e+28Gf/QCEHEk1SvfVf1ozKNf+OunLWcgr+P
 sxCxAaKvO1QKV99n4NoV1SWkCKV9SnG34n3vxHa9ufxgwwXAlQy7jDRjVWY9lTSb5Tgh
 ocz8r8q0dWVDRg/IBjFZSyRKnv++cFMbCO6qafiAiLlaCZYch/6yXXheGHuG4UzOEUpY
 t8BucLMl0vQK8PXYTmD07B2QQGtnk1AQsFc6noVCnCEH2VLMTJIz27gmeidljJn6LJKx
 OQ2ufxThWuckozsorQvayiIvHyL1BOmWtIOb7MBW7cuZ5f54pRn6mTPgnlP23Y+sMcJH Ag== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mbxfdktd1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Dec 2022 14:19:58 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2B9EAXCS009266;
        Fri, 9 Dec 2022 14:19:58 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mbxfdktcq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Dec 2022 14:19:58 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2B99Ii9Q022504;
        Fri, 9 Dec 2022 14:19:56 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3m9kur4eq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Dec 2022 14:19:56 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2B9EJrbU44302816
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Dec 2022 14:19:53 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7DB7F20049;
        Fri,  9 Dec 2022 14:19:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6CDAA2004B;
        Fri,  9 Dec 2022 14:19:53 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri,  9 Dec 2022 14:19:53 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
        id 288E9E06EB; Fri,  9 Dec 2022 15:19:53 +0100 (CET)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Willy Tarreau <w@1wt.eu>, "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] rcutorture: add support for s390
Date:   Fri,  9 Dec 2022 15:19:38 +0100
Message-Id: <20221209141939.3634586-5-svens@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221209141939.3634586-1-svens@linux.ibm.com>
References: <20221209141939.3634586-1-svens@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PtbRnuS8AgHSLKLf5mbL2hH7IpliXBVV
X-Proofpoint-ORIG-GUID: d7YUM2uHTWIJsyuWehRxjNhNj4r9-zIj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-09_07,2022-12-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 suspectscore=0
 mlxlogscore=798 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212090108
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the required values to identify_qemu() and
identify_bootimage().

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
---
 tools/testing/selftests/rcutorture/bin/functions.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/bin/functions.sh b/tools/testing/selftests/rcutorture/bin/functions.sh
index 66d0414d8e4b..b52d5069563c 100644
--- a/tools/testing/selftests/rcutorture/bin/functions.sh
+++ b/tools/testing/selftests/rcutorture/bin/functions.sh
@@ -159,6 +159,9 @@ identify_boot_image () {
 		qemu-system-aarch64)
 			echo arch/arm64/boot/Image
 			;;
+		qemu-system-s390x)
+			echo arch/s390/boot/bzImage
+			;;
 		*)
 			echo vmlinux
 			;;
@@ -184,6 +187,9 @@ identify_qemu () {
 	elif echo $u | grep -q aarch64
 	then
 		echo qemu-system-aarch64
+	elif echo $u | grep -q 'IBM S/390'
+	then
+		echo qemu-system-s390x
 	elif uname -a | grep -q ppc64
 	then
 		echo qemu-system-ppc64
-- 
2.34.1

