Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB44B65B00A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 11:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235846AbjABKwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 05:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbjABKwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 05:52:07 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E137260EE;
        Mon,  2 Jan 2023 02:52:05 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3028wM5E021196;
        Mon, 2 Jan 2023 10:51:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=3s0sKuYQYSrxGa9epdS6MVxcS8fJENNzbKxhMU2MFhk=;
 b=U7C+x5CFg69duxkXvi6yXSsP9vA8KzMDbbzvigHY5glWVOKQ895p7uGlrGsnyBeMAVMo
 fFgWtgMPcr6STMKjn8nfzHzOqHJSBkURidO1ulYWoY9fqsYsdNQM1TOWQmL7B4kHkgAI
 xuCSbWxQnYaiUwpPiJME03DDB2vzqto29gVR/EYkXbkNtYDKGYHIdALEnokHVIFibcTA
 B5zU2/LDPhE0TPF3zB0DJXWabRK23D2uCWdsQIUdzISWN8cfTnTjG/CRA5XVLLfjfg8p
 sdbDwKYZIClfnmcd6p5B5TYAHLtAytvoaWY+nkL6VLBxtEU25EUTKVS/yZfjYlwDTslH Tw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mtxhhewcm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Jan 2023 10:51:36 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 302ApZRJ008694;
        Mon, 2 Jan 2023 10:51:35 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mtxhhewc1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Jan 2023 10:51:35 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 301Klw1W017430;
        Mon, 2 Jan 2023 10:51:33 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3mtcq6spay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Jan 2023 10:51:33 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 302ApUJ148562562
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Jan 2023 10:51:30 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CBCDC20049;
        Mon,  2 Jan 2023 10:51:30 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC35B20040;
        Mon,  2 Jan 2023 10:51:30 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon,  2 Jan 2023 10:51:30 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
        id 8E382E0959; Mon,  2 Jan 2023 11:51:30 +0100 (CET)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Willy Tarreau <w@1wt.eu>, "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v2 4/5] rcutorture: add support for s390
Date:   Mon,  2 Jan 2023 11:51:11 +0100
Message-Id: <20230102105112.1661651-5-svens@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230102105112.1661651-1-svens@linux.ibm.com>
References: <20230102105112.1661651-1-svens@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HzOfUN5fhcP2wwM7GxomgBUxearBffqr
X-Proofpoint-GUID: DgcUssCjql7x5Wpk9pzy_pRbLpGSo-1T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-02_05,2022-12-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 mlxscore=0 clxscore=1015 malwarescore=0
 adultscore=0 mlxlogscore=797 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301020096
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

