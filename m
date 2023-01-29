Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0CB268025E
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 23:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235441AbjA2Wrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 17:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjA2Wre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 17:47:34 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB36EC7E;
        Sun, 29 Jan 2023 14:47:33 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30TKt2co013055;
        Sun, 29 Jan 2023 22:47:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=pz1ywBEq/ZKmnYoUn2kuXEYh//BmHNMh4u/KXr1iiiU=;
 b=VcM/bhdueXhhdhPVmsOGjLqdkweYpmKu1wsBwPdrTqSg3CPZKNTi72tDd1XiuBvUTXXu
 dCma52p0SBYfBr2xvnRhn+vsUPd8uWQeJCDZ7brc7NdRjmrwM1Uki4T6nPtgoJnBesnw
 /hETGNGbbAwQvu8U+JqtkUrranLFz3iOCVWoJCjdt78uIj+KxrZg8hkg7xXmDT5C9TuV
 VaHbNg5/OOZkrtRzITlLDJ6RuNi/8K9EdxgIo4+4kMyVtzkgQ8WBvArZhNMDDpCmgc56
 P1s+zRXi+QRblZHTBf1EAtqKplxvGEpPHWpVDkojS5Ik9Yox3RzmZGkNu/W06mD9sXEw zQ== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nddv1804n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 29 Jan 2023 22:47:28 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30SNcJqQ028153;
        Sun, 29 Jan 2023 22:47:26 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3ncvuqs3mc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 29 Jan 2023 22:47:26 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30TMlMRl50921786
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 29 Jan 2023 22:47:22 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D54E720040;
        Sun, 29 Jan 2023 22:47:22 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B8072004D;
        Sun, 29 Jan 2023 22:47:22 +0000 (GMT)
Received: from localhost (unknown [9.171.0.52])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Sun, 29 Jan 2023 22:47:22 +0000 (GMT)
Date:   Sun, 29 Jan 2023 23:47:20 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Nick Terrell <terrelln@fb.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH 0/1] s390: fix initrd corruption in decompressor with new
 zstd version
Message-ID: <cover.thread-41c676.your-ad-here.call-01675030179-ext-9637@work.hours>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Patchwork-Bot: notify
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rFoTAHYwBymq2nbXk4_0G1HhpEVvYCgo
X-Proofpoint-GUID: rFoTAHYwBymq2nbXk4_0G1HhpEVvYCgo
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-29_11,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=594 adultscore=0
 clxscore=1011 priorityscore=1501 impostorscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301290224
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new version of zstd library integrated in the kernel since v6.2-rc1
https://lore.kernel.org/all/20221024202606.404049-1-nickrterrell@gmail.com/
contains commit
https://github.com/facebook/zstd/commit/6a7ede3dfccb
which introduces a side effect for historical usage of __decompress() function,
i.e. not specifying "out_len" parameter and expecting that no writes beyond
uncompressed kernel image are performed. More details are in follow up fix.

From architectures which claim HAVE_KERNEL_ZSTD, s390 and MIPS use
__decompress() without specifying "out_len". On s390 this leads to
initrd corruption.
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2003348

I haven't looked in details for MIPS but I've added Thomas as the
maintainer and MIPS list in Cc.

The follow up fix addresses that for s390.

Vasily Gorbik (1):
  s390/decompressor: specify __decompress() buf len to avoid overflow

 arch/s390/boot/decompressor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.38.1
