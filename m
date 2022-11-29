Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C9E63BF6D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 12:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbiK2LyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 06:54:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbiK2LyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 06:54:02 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3203454B3B;
        Tue, 29 Nov 2022 03:54:02 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AT9kFa4006636;
        Tue, 29 Nov 2022 11:52:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : mime-version : content-type; s=pp1;
 bh=jI8jJEOJ6YN347QD8GxvxY855mlZXtRWwg9j7N6zesM=;
 b=th3qjFSSl1mpo+QQtYQTJrPlGZNUfNJK2avdIsdnprJaa6yIN5jyNWcsZn4EJ6yh1GTr
 G+2XIdRGAqNSrqGBaNunSoIv5Wnrq3T1AIWh5rNTCMgnzf2iijaSRV47i8CyuMcaHqWq
 90nOesfwYybG7Vlarcf6g8/I+IGn3IdK9PkP0xChUbKxwidL0p/VORRPxxas7gv6cZtB
 GUN7G0H6NiHNUJhA8Jh4f3Q5yh1/5yeip6idIIK8EFMs/iZ/o+flcinMTrzy8fzJbjah
 zG0l7mAJ1gO1TtaVy6OgK3zYUPHXb3XauFKXsj8qOWikqWahwqUGVSThbG+hzJKBDdBy vw== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m5djwpegf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Nov 2022 11:52:45 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2ATBpE7q023615;
        Tue, 29 Nov 2022 11:52:44 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma04wdc.us.ibm.com with ESMTP id 3m3ae9m8v2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Nov 2022 11:52:44 +0000
Received: from smtpav06.wdc07v.mail.ibm.com ([9.208.128.115])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2ATBqg5k20251160
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 11:52:43 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C92EC58056;
        Tue, 29 Nov 2022 11:52:42 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4809C5805A;
        Tue, 29 Nov 2022 11:52:40 +0000 (GMT)
Received: from Dannys-MacBook-Pro.local (unknown [9.211.123.96])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 29 Nov 2022 11:52:40 +0000 (GMT)
Date:   Tue, 29 Nov 2022 19:52:30 +0800
From:   Danny Tsen <dtsen@linux.ibm.com>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, leitao@debian.org,
        nayna@linux.ibm.com, appro@cryptogams.org,
        linux-kernel@vger.kernel.org, ltcgcw@linux.vnet.ibm.com,
        dtsen@linux.ibm.com
Subject: [PATCH 0/6] crypto: Accelerated AES/GCM stitched implementation
Message-ID: <Y4Xyflca/hkvR0eR@Dannys-MacBook-Pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3RLrEUFhQJBWWfqdSGvj3-GKjF0xkr7A
X-Proofpoint-GUID: 3RLrEUFhQJBWWfqdSGvj3-GKjF0xkr7A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_07,2022-11-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=595 spamscore=0
 clxscore=1011 lowpriorityscore=0 phishscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211290069
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series enable an accelerated AES/GCM stitched implementation for
Power10+ CPU(ppc64le).  This module supports AEAD algorithm.  The stitched
implementation provides 3.5X+ better performance than the baseline.

This patch has been tested with the kernel crypto module tcrypt.ko and has
passed the selftest.

Danny Tsen (7):
  powerpc/crypto: Define new module in Kconfig.
  powerpc/crypto: Create new module driver.
  powerpc/crypto: Functions to set round keys and encrypt data.
  powerpc/crypto: Functions for creating hash table and generate hash.
  powerpc/crypto: Glue code to create AEAD algorithm module.
  powerpc/crypto: Added new stitched AES/GCM implementation.
  powerpc/crypto: Perl script to process PowerPC asember source.


 arch/powerpc/crypto/Kconfig  | 11 +++++++++++
 arch/powerpc/crypto/Makefile | 10 ++++++++++
 arch/powerpc/crypto/p10-aes-gcm-glue.c | 341 +++++++++++++++++++++++++
 arch/powerpc/crypto/p10_aes_gcm.S | 1519 +++++++++++++++++++++++++++++
 arch/powerpc/crypto/aesp8-ppc.pl | 3846 ++++++++++++++++++++++++++++++
 arch/powerpc/crypto/ghashp8-ppc.pl | 370 +++++++++++++++++++++++++++++
 arch/powerpc/crypto/ppc-xlate.pl | 229 +++++++++++++++++++++++++++++++
 7 file changed, 6026 insertions(+)
 create mode 100644 arch/powerpc/crypto/p10-aes-gcm-glue.c
 create mode 100644 arch/powerpc/crypto/p10_aes_gcm.S
 create mode 100644 arch/powerpc/crypto/aesp8-ppc.pl
 create mode 100644 arch/powerpc/crypto/ghashp8-ppc.pl
 create mode 100644 arch/powerpc/crypto/ppc-xlate.pl
-- 
2.31.1



