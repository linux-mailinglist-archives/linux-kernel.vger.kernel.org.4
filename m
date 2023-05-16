Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0025705003
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 15:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbjEPN4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 09:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbjEPN4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 09:56:11 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BDA12C;
        Tue, 16 May 2023 06:56:09 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GDjPWO000629;
        Tue, 16 May 2023 13:55:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=C2KIS1bKMuu3Vj7hq4K06H6pBbRg+jfCnREru5i6gT8=;
 b=ck6IqIX6LeG0RuX7fGZVu3oJvfy08CrZ3WWfMx+hZeb0XNooP9JZ8OPzIkOAXo/5yiY3
 ldWauI/0zfCIIKFGAcIAMDw/ibSBX2RHSCcuO9VyROOMFcXwlVOHtlNg6OkT/ki/8SHV
 1KYImnygSig1n+KhUT5nbWsA0a/oETctPpxk29wh9bo1ML652SWGK2ymr7K64sbTYiqD
 xZqoHj0LD9PcaAS3f7g32x1Tlb1E+jZgCjaQGobF5fXnO7N2wqKzK66wj5Tqss46EGlT
 Xr8SaWteAlFJs/NLHFm7WDdZIyM8HVRtrhqJ1qj80K0JS+i8+UYYXYw42D/bc0hkCCNf pw== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qmb048cuc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 13:55:50 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34G4PN8E032129;
        Tue, 16 May 2023 13:38:21 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3qj264scr8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 13:38:21 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34GDcJFw28770942
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 May 2023 13:38:19 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F9762004D;
        Tue, 16 May 2023 13:38:19 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F11A820043;
        Tue, 16 May 2023 13:38:18 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 16 May 2023 13:38:18 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
        id AAC4DE05FF; Tue, 16 May 2023 15:38:18 +0200 (CEST)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     linux-s390@vger.kernel.org, hca@linux.ibm.com,
        linux-kernel@vger.kernel.org
Subject: [RFC 0/2] allow to inline generic entry
Date:   Tue, 16 May 2023 15:38:08 +0200
Message-Id: <20230516133810.171487-1-svens@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lRdntWzxCMQUurOHBDJZcr9vI6EDZLjN
X-Proofpoint-GUID: lRdntWzxCMQUurOHBDJZcr9vI6EDZLjN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_06,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 adultscore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305160114
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i looked into the syscall performance on s390 with the latest
kernel. For that reason i wrote a small syscall test program,
which just calls getpid() in a loop:

#include <stdio.h>
#include <time.h>
#include <bsd/sys/time.h>
#include <unistd.h>
static const double nsec_per_sec = 1000000000;

int main(int argc, char **argv)
{
	struct timespec start, end, res;
	double diff;
	int i;
	(void)argc;
	(void)argv;

	clock_gettime(CLOCK_REALTIME, &start);
	for (i = 0; i < 150000000; i++) {
		volatile int a = getpid();
		(void)a;
	}

	clock_gettime(CLOCK_REALTIME, &end);
	timespecsub(&end, &start, &res);
	diff = ((double)res.tv_sec * nsec_per_sec + (double)res.tv_nsec) / nsec_per_sec;
	printf("%f\n", diff);
	return 0;
}

Analyzing performance data i see some overhead in the generic entry C
functions, which are not inlined because they are defined in
kernel/entry/common.c. Moving them to include/linux/entry-common.h
gives me the following runtime for the loop above:

with entry common code inlined: 12.8s
not inlined: 13.8s

While i prefer to have C functions in C files instead of header files,
7% performance gain is quite a lot, so i wonder what people think about
moving them to header files. I made this a small patchset for reference,
if there is interest in merging that i'll clean it up and submit it.

Any thoughts?

Sven Schnelle (2):
  entry: move the exit path to header files
  entry: move the enter path to header files

 include/linux/entry-common.h | 305 ++++++++++++++++++++++++++++++++++-
 kernel/entry/common.c        | 281 --------------------------------
 2 files changed, 297 insertions(+), 289 deletions(-)

-- 
2.39.2

