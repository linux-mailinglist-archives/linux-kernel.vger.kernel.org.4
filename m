Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852E86A196E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjBXKEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjBXKDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:03:47 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824B320049;
        Fri, 24 Feb 2023 02:03:17 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31O8eTcR023105;
        Fri, 24 Feb 2023 10:02:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=DhvZLnwQKj3eToT9c7irY6sdql1OfzSaxAnRI4LOokI=;
 b=CWZXiv4WqW8EQdBSZZueeS60UiiOyYYXJNHcMCzUXLHdi8tjc/GIYWtbQC0Rn2watF3/
 zRYmg+VSG1XTnn2Xya0u0RWbd5PRPm1HtVfT1OF/sIYjqjuizuPOFw6cMf9SleE6/rzg
 tsqiUvy9DooOyZMd1QvJ41vxlJ9PO5bURIpq/88djybcpXl1k39jTkQqc0ddcg0j8G7z
 DD0dovF9l/+nSiipstypNO10qcoY10p38xVkFOFYyohKIIVR/k25O9Bfg1f6/irUR6I6
 M+BnSX+DIN34Ei4JU+j1CxIL2qkJBe3qhVFL3dvYXj9wIUNgom5qLSBlIKT0A9Hc6fnS Xg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nxme4929q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Feb 2023 10:02:44 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31NNsZZv007421;
        Fri, 24 Feb 2023 10:02:43 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3ntpa6fspr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Feb 2023 10:02:42 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31OA2coW55050720
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 10:02:39 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 65B932004B;
        Fri, 24 Feb 2023 10:02:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 27DF72006E;
        Fri, 24 Feb 2023 10:02:38 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 24 Feb 2023 10:02:38 +0000 (GMT)
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] s390: don't use 128-bit cmpxchg for READ_ONCE() purposes
Date:   Fri, 24 Feb 2023 11:02:35 +0100
Message-Id: <20230224100237.3247871-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TM1q27yobqnBkrFXdDgFXW7Fj78ztAvK
X-Proofpoint-GUID: TM1q27yobqnBkrFXdDgFXW7Fj78ztAvK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-24_04,2023-02-23_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1015
 adultscore=0 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=747
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302240079
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce and use an s390 specific READ_ONCE_ALIGNED_128() macro in order
to get rid of the odd 128-bit cmpxchg READ_ONCE() usage in cpum_sf, which
was introduced with commit 82d3edb50a11 ("s390/cpum_sf: add READ_ONCE()
semantics to compare and swap loops").

Heiko Carstens (2):
  s390/rwonce: add READ_ONCE_ALIGNED_128() macro
  s390/cpum_sf: use READ_ONCE_ALIGNED_128() instead of 128-bit cmpxchg

 arch/s390/include/asm/rwonce.h  | 31 +++++++++++++++++++++++++++++++
 arch/s390/kernel/perf_cpum_sf.c |  9 +++------
 2 files changed, 34 insertions(+), 6 deletions(-)
 create mode 100644 arch/s390/include/asm/rwonce.h

-- 
2.37.2

