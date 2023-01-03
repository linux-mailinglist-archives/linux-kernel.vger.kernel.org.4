Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2425C65BB24
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 08:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236799AbjACHUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 02:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbjACHUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 02:20:39 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6C4B1E8;
        Mon,  2 Jan 2023 23:20:38 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3036CGGr032696;
        Tue, 3 Jan 2023 07:20:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=BIIiIarhrMjfZ53epwzctaykif7mltHYkilT75A5OPY=;
 b=KizFdBnlOLpd9/LevRENWKUnt6tz9UI+RVlkfAKECJXG0+AJq8JVCUyMH3uBpfNSIv1N
 aHPgTEyQFLw48Hjwhdou0fBoykM09eCapOFk74wYAudadsh2Rd5CsTDCQ4iHvbqGixar
 OaaGDSc7EaFZvf8cJzJ81EpqtIXO74uM/Fxa1JC5/MgJncksz6wdSZfikkUsB+6IKO0L
 JmFRJ+krjc79KggR4xga/2HFqiQnTqL5Z9UiJo6Wx2LQpjuFi4rD7lApX861HEWqTK9F
 asg3grv4H4SZxcV4NEOWZL9T+D0qFhAN0hHmqtJPeLawp0auAtPwKSVUFoT88jXqCtR+ iQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mvevns0su-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Jan 2023 07:20:08 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30378iA1040828;
        Tue, 3 Jan 2023 07:20:07 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mvevns0s7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Jan 2023 07:20:07 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 302BoFlL008404;
        Tue, 3 Jan 2023 07:20:05 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3mtcbfjh0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Jan 2023 07:20:05 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3037K2sw46137732
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Jan 2023 07:20:02 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B27BA20040;
        Tue,  3 Jan 2023 07:20:02 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A1F5A2004E;
        Tue,  3 Jan 2023 07:20:02 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue,  3 Jan 2023 07:20:02 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
        id 3B9AEE095C; Tue,  3 Jan 2023 08:20:02 +0100 (CET)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Willy Tarreau <w@1wt.eu>, "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v3 5/5] rcutorture: build initrd for rcutorture with nolibc
Date:   Tue,  3 Jan 2023 08:19:57 +0100
Message-Id: <20230103071957.222360-6-svens@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230103071957.222360-1-svens@linux.ibm.com>
References: <20230103071957.222360-1-svens@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dVNGR_Aw9M95AwyOFs1Lc5kuM-qS7uPg
X-Proofpoint-GUID: ZB1-E_5NVP3HV5W2wiWC1YX4QVzIqMq_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-02_14,2022-12-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 suspectscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 spamscore=0 phishscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301030062
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reduces the size of init from ~600KB to ~1KB.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
---
 tools/testing/selftests/rcutorture/bin/mkinitrd.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/mkinitrd.sh b/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
index 70d62fd0d31d..71f0dfbb2a6d 100755
--- a/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
+++ b/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
@@ -64,7 +64,7 @@ ___EOF___
 # build using nolibc on supported archs (smaller executable) and fall
 # back to regular glibc on other ones.
 if echo -e "#if __x86_64__||__i386__||__i486__||__i586__||__i686__" \
-           "||__ARM_EABI__||__aarch64__\nyes\n#endif" \
+           "||__ARM_EABI__||__aarch64__||__s390x__\nyes\n#endif" \
    | ${CROSS_COMPILE}gcc -E -nostdlib -xc - \
    | grep -q '^yes'; then
 	# architecture supported by nolibc
-- 
2.34.1

