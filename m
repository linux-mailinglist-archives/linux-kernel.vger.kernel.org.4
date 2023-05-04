Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9E96F6DDA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 16:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjEDOkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 10:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjEDOki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 10:40:38 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945F42D43
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 07:40:37 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 344EdeE3030698;
        Thu, 4 May 2023 14:40:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=q364caLZf7wCcX3nZIw2/+48oTctob8xaTwLO8gkjB8=;
 b=cEdcgLt8oTuCtaMSs9Yro2ZLxTpa5EHeB1kOQdKq9ejfMlDYZ6Be/8bz+14iWFc1RHq2
 xABecqqPJdKz1tV/B4lHdeWpnZS8/RyDDWzqQ+Rx650kl9fT9abXv0Uo55aEz7zmic3Q
 bZoeJysYseeY6/1029SlKi/Sjbhjto9sNmLqb/EJsRNgYkOYHhMBOJC9fZndEfFHjOrm
 RDcY5sI2rHGhTdauI9cro3rOnEqWGRW8UJTJdsE5Y8tCwobHn3VbCTai4ZDjFtILaTqJ
 v6F00EhsTKXoS8U5cY999qOr4fuXtWJhJFkeIDpwxvHvr9Qpayn0L7I++oMB57730OAR sw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qcav0ypj2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 May 2023 14:40:35 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3444PJ4C026140;
        Thu, 4 May 2023 14:40:33 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3q8tv6twut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 May 2023 14:40:33 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 344EeTS916974438
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 May 2023 14:40:29 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C51F820049;
        Thu,  4 May 2023 14:40:29 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 31C3420040;
        Thu,  4 May 2023 14:40:29 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.60.220])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  4 May 2023 14:40:29 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 0/2] statfs: Enforce statfs[64] structure intialization
Date:   Thu,  4 May 2023 16:40:19 +0200
Message-Id: <20230504144021.808932-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: J2SVDr2qqxAInfFaO12pJ_V2oDwhBAW-
X-Proofpoint-ORIG-GUID: J2SVDr2qqxAInfFaO12pJ_V2oDwhBAW-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_10,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=521
 clxscore=1011 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305040119
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes copying of uninitialized memory to userspace by
do_statfs_native() and do_statfs64() on s390.

Patch 1 fixes the problem by making the code similar to
put_compat_statfs() and put_compat_statfs64().

Patch 2 gets rid of the padding which caused the issue; even though it
may be considered redundant, it documents that s390 de-facto has an
extra f_spare array element.

Ilya Leoshkevich (2):
  statfs: Enforce statfs[64] structure intialization
  s390/uapi: Cover statfs padding by growing f_spare

 arch/s390/include/asm/compat.h      | 2 +-
 arch/s390/include/uapi/asm/statfs.h | 4 ++--
 fs/statfs.c                         | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.40.1

