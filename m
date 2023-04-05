Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBFCA6D7D63
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 15:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238210AbjDENI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 09:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238059AbjDENIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 09:08:52 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7E51FEC
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 06:08:51 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 335CjDIY007186;
        Wed, 5 Apr 2023 13:08:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=76Jov19ROPx+D3XHIaLbSZbEOCsirV8cVQ4WcgX3g2M=;
 b=ZU6pqABZEHAm6vJ8SC26Cn6ubS/hNktI2pbHRb1Ir0eFoPRO+aNmZ0Fyx1R7c58fVxKQ
 +CkSxN++bzzbpfstF6f6ESEbf5x1A8eeQjOX5QIzET+zpHZvtYxOZ+Z7gY234s6kLfgj
 mrLzso2OUue/ZtEHebvWUIcQbXu0VpXdR6RkVyXKX1C6E0R/w8OSWbUvxjIbXVIli1rc
 qXC7JmSmm2fiKqk2FuY/H1pvr0KWE6r//63jRrwgRLnQb7IOeW5eOhQ4WIiWD2KZTTst
 4JvIukRaQrUWsEDrTGR5Ijfn1kuwaIkF1oW8Pacj5OSVVSpC2tD74k/I5GAZkGWmyr/T 5Q== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ps992gmtv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 13:08:46 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3355m6PG029169;
        Wed, 5 Apr 2023 13:08:44 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3ppc87bbs6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 13:08:44 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 335D8gIQ17367566
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Apr 2023 13:08:42 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1129F20040;
        Wed,  5 Apr 2023 13:08:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1E0820043;
        Wed,  5 Apr 2023 13:08:41 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  5 Apr 2023 13:08:41 +0000 (GMT)
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Popov <alex.popov@linux.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] stackleak: allow to specify arch specific stackleak poison function
Date:   Wed,  5 Apr 2023 15:08:39 +0200
Message-Id: <20230405130841.1350565-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HjI6d3l2ktziX3kyVJo4jNphf7WSabSH
X-Proofpoint-ORIG-GUID: HjI6d3l2ktziX3kyVJo4jNphf7WSabSH
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-05_07,2023-04-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=677
 spamscore=0 priorityscore=1501 impostorscore=0 clxscore=1011 phishscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304050113
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out the code that fills the stack with the stackleak poison value in
order to allow architectures to provide a faster implementation.

Use this to provide an s390 specific implementation which can fill the
stack with the poison value much faster (factor of ~10 compared to the
current version).

Note that the s390 stackleak support is currently only available via
linux-next (as of today), and the s390 kernel tree at kernel.org[1].
Therefore, if there are no objections, I'd like to add these two patches to
the s390 tree, so they can go upstream via the next merge window together
with the s390 support.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/commit/?h=features&id=b94c0ebb1ec752016a3e41bfb66bb51ea905e533

Thanks,
Heiko

Heiko Carstens (2):
  stackleak: allow to specify arch specific stackleak poison function
  s390/stackleak: provide fast __stackleak_poison() implementation

 arch/s390/include/asm/processor.h | 35 +++++++++++++++++++++++++++++++
 kernel/stackleak.c                | 17 +++++++++++----
 2 files changed, 48 insertions(+), 4 deletions(-)

-- 
2.37.2

