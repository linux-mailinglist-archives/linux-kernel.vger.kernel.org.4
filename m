Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1EB36483AD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 15:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiLIOVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 09:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiLIOUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 09:20:34 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773FF6274
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 06:20:28 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B9DdSLD003705;
        Fri, 9 Dec 2022 14:20:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=BIIiIarhrMjfZ53epwzctaykif7mltHYkilT75A5OPY=;
 b=Li/HoyK/JLvLLAhtavsDzOtlrr2MZqLRAiM2ORUMNZc2egwH0dk9rhSvv+i94vWDTCXW
 4zzpvBAl3C2UNZHQNn/xtLJmjR/9Px4NfJzdJXdb11ytwWG3JobenutWUsHXCJ4ZnWhM
 yPnnF3NuaCJynvqgzeKamGf/ZyCXgjQhVJ8fV/XXj7btLImLZ+WUX/f+xAtC+kE4wzC4
 k9u8dBTFZRNR7StVX4cb6/nG+iwrYlqZgsxBxnbC0Yse8HhqxtMDrfI2HvfN+D6jiEUv
 sBB7RyFnsY5L470caJ6hmBbF37Gzap4C81QdnhIvevPRLHLFkDwwAwtUgskkcGIR/OJC CA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mbxakkw48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Dec 2022 14:19:59 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2B9EBeFq029267;
        Fri, 9 Dec 2022 14:19:58 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mbxakkw3k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Dec 2022 14:19:58 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2B99Ii9R022504;
        Fri, 9 Dec 2022 14:19:56 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3m9kur4eq8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Dec 2022 14:19:56 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2B9EJrKU45482412
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Dec 2022 14:19:53 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0A192004B;
        Fri,  9 Dec 2022 14:19:53 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9FA622004E;
        Fri,  9 Dec 2022 14:19:53 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri,  9 Dec 2022 14:19:53 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
        id 2B29EE0732; Fri,  9 Dec 2022 15:19:53 +0100 (CET)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Willy Tarreau <w@1wt.eu>, "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] rcutorture: build initrd for rcutorture with nolibc
Date:   Fri,  9 Dec 2022 15:19:39 +0100
Message-Id: <20221209141939.3634586-6-svens@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221209141939.3634586-1-svens@linux.ibm.com>
References: <20221209141939.3634586-1-svens@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Dx3uCqbfEn9HPhla7508HsCkyytWbnGE
X-Proofpoint-ORIG-GUID: npxYvDsgI4Y4SwcBGnM_2_uEo9Jsq2oL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-09_07,2022-12-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 mlxlogscore=999 impostorscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212090108
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

