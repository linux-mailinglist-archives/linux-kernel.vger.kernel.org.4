Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78CA269B082
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 17:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjBQQSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 11:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjBQQS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 11:18:26 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018211BD3;
        Fri, 17 Feb 2023 08:18:23 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31HETHOc014539;
        Fri, 17 Feb 2023 16:18:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=MPQIfozxi3agzhuInh5Dfy0UCTxQiOBuqBY+xGl4A8o=;
 b=Nvzzkk38Bks/YPT3VoN+8OPsAOnh9f5uuS8LbcXw35qm8fCbDdyaQ1DuG+7Nf1jC2zj/
 dGmRNFOnr0nLY9VbmBvG2eDiJ2JBFwxKJGZpsu+toEtyYff7w1neTKUHEYncv2J1P+X3
 Nmp+ifkYBDur2Z+uf5szKNk9GM865Q1jebGaftGIO6OWnPT/8pVBFdblKY8LbVRBG5uB
 eqPh3GZwp0bmThJdowQcNuoqDjQkGEgdIbq/FSrMet2w1Voz9adPjkuDAd5SOuLedulc
 HzjFx+00r/Z4VoGehFrT9uoNxlVbnVRTrRUi8K7Lb8v8BHHr0i8N6TEyDeaAaBXfaPZe Ig== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nt15x0q90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 16:18:13 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31HFtj4Y009842;
        Fri, 17 Feb 2023 16:18:12 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([9.208.129.118])
        by ppma03wdc.us.ibm.com (PPS) with ESMTPS id 3np2n7rj8u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 16:18:12 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31HGIBik6488722
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 16:18:11 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3EDD25805C;
        Fri, 17 Feb 2023 16:18:11 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A89ED58059;
        Fri, 17 Feb 2023 16:18:10 +0000 (GMT)
Received: from ltcden12-lp3.aus.stglabs.ibm.com (unknown [9.40.195.53])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 17 Feb 2023 16:18:10 +0000 (GMT)
From:   Danny Tsen <dtsen@linux.ibm.com>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, leitao@debian.org,
        nayna@linux.ibm.com, appro@cryptogams.org,
        linux-kernel@vger.kernel.org, ltcgcw@linux.vnet.ibm.com,
        dtsen@us.ibm.com, Danny Tsen <dtsen@linux.ibm.com>
Subject: [PATCH v3 0/6] crypto: Accelerated AES/GCM stitched implementation
Date:   Fri, 17 Feb 2023 11:17:59 -0500
Message-Id: <20230217161805.236319-1-dtsen@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: d0932ihIO08aC2VYFCuhOZeHvueMzBsr
X-Proofpoint-GUID: d0932ihIO08aC2VYFCuhOZeHvueMzBsr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_10,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 mlxlogscore=539 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302170143
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
passed the selftest.  The patch is also tested with
CONFIG_CRYPTO_MANAGER_EXTRA_TESTS enabled.

Danny Tsen (6):
  Update Kconfig and Makefile.
  Glue code for AES/GCM stitched implementation.
  An accelerated AES/GCM stitched implementation.
  Supporting functions for AES.
  Supporting functions for ghash.
  A perl script to process PowerPC assembler source.

 arch/powerpc/crypto/Kconfig            |   11 +
 arch/powerpc/crypto/Makefile           |   13 +
 arch/powerpc/crypto/aesp8-ppc.pl       | 3846 ++++++++++++++++++++++++
 arch/powerpc/crypto/ghashp8-ppc.pl     |  370 +++
 arch/powerpc/crypto/p10-aes-gcm-glue.c |  345 +++
 arch/powerpc/crypto/p10_aes_gcm.S      | 1521 ++++++++++
 arch/powerpc/crypto/ppc-xlate.pl       |  229 ++
 7 files changed, 6335 insertions(+)
 create mode 100644 arch/powerpc/crypto/aesp8-ppc.pl
 create mode 100644 arch/powerpc/crypto/ghashp8-ppc.pl
 create mode 100644 arch/powerpc/crypto/p10-aes-gcm-glue.c
 create mode 100644 arch/powerpc/crypto/p10_aes_gcm.S
 create mode 100644 arch/powerpc/crypto/ppc-xlate.pl

-- 
2.31.1

