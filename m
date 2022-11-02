Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373D6616F25
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 21:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbiKBUwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 16:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiKBUwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 16:52:08 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185F8E0D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 13:52:07 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A2KLTQo022441;
        Wed, 2 Nov 2022 20:51:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=3Vo7kFNZKuw3z5FeVY3FfDysBAcb781H5upJaig0ErE=;
 b=ao2pkhdbdF50UBy8jNvZ9vKC4OkgjVtlRumFIzWQa6WH31li2sjP8ow47kEMPcTNcyPH
 0ZlfZ+F4g5MkIRfySZXp0jM5XrnlTk4bLmsI1SyXMSgbI+u6slAib1YZs1rmDUYTJNzL
 VqllgWWs2NWen1Ywt4myW5eXQH68LW4lUrc/QOC0iM7f1t4RPPPsjkoxBNZfqTHfDeqr
 4KMt0NmtXjoMSN32LzrIcHhR6QFNM7p6s3Aeg+GLBw1gDN2w8QJ0fLAVWySfOU2t6pow
 oXNQOCSny84+eYvKYkWd+Hu2BK7VcXhpJyFSD/oxEPOSPUzFb3ixryvufiGnWsgOE8cB zg== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kkyh18r4c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 20:51:53 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A2Kpfkk025181;
        Wed, 2 Nov 2022 20:51:52 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma01dal.us.ibm.com with ESMTP id 3kgutav8qt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 20:51:52 +0000
Received: from smtpav05.dal12v.mail.ibm.com ([9.208.128.132])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A2KpmB916253478
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Nov 2022 20:51:48 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8575358052;
        Wed,  2 Nov 2022 20:51:50 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 80C9F5805D;
        Wed,  2 Nov 2022 20:51:49 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.65.200.160])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  2 Nov 2022 20:51:49 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, jk@ozlabs.org,
        joel@jms.id.au, alistair@popple.id.au, eajames@linux.ibm.com
Subject: [PATCH v2 0/5] fsi: Add regmap and refactor sbefifo
Date:   Wed,  2 Nov 2022 15:51:43 -0500
Message-Id: <20221102205148.1334459-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nNQRhG22lDT2iYZdY7mGaMV64I4AuWeW
X-Proofpoint-ORIG-GUID: nNQRhG22lDT2iYZdY7mGaMV64I4AuWeW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_15,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=473 phishscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1011 priorityscore=1501
 adultscore=0 suspectscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211020135
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SBEFIFO hardware can now be attached over a new I2C endpoint interface
called the I2C Responder (I2CR). In order to use the existing SBEFIFO
driver, add a regmap driver for the FSI bus and an endpoint driver for the
I2CR. Then, refactor the SBEFIFO and OCC drivers to clean up and use the
new regmap driver or the I2CR interface.

Changes since v1:
 - Instead of a regmap driver for the I2CR, just have a private interface
   driver for FSI, since SBEFIFO is likely the only user.

Eddie James (5):
  regmap: Add FSI bus support
  drivers: fsi: Add I2C Responder driver
  drivers: fsi: Rename sbefifo and occ sources
  drivers: fsi: separate char device code for occ and sbefifo
  drivers: fsi: occ and sbefifo refactor

 drivers/base/regmap/Kconfig      |    6 +-
 drivers/base/regmap/Makefile     |    1 +
 drivers/base/regmap/regmap-fsi.c |  231 ++++++
 drivers/fsi/Kconfig              |   32 +-
 drivers/fsi/Makefile             |    9 +-
 drivers/fsi/fsi-occ.c            |  766 --------------------
 drivers/fsi/fsi-sbefifo.c        | 1144 ------------------------------
 drivers/fsi/i2cr.c               |  116 +++
 drivers/fsi/i2cr.h               |   19 +
 drivers/fsi/occ-cdev.c           |  157 ++++
 drivers/fsi/occ.c                |  536 ++++++++++++++
 drivers/fsi/occ.h                |   57 ++
 drivers/fsi/sbefifo-cdev.c       |  218 ++++++
 drivers/fsi/sbefifo-fsi.c        |   68 ++
 drivers/fsi/sbefifo-i2c.c        |   73 ++
 drivers/fsi/sbefifo.c            |  797 +++++++++++++++++++++
 drivers/fsi/sbefifo.h            |   50 ++
 include/linux/regmap.h           |   37 +
 18 files changed, 2398 insertions(+), 1919 deletions(-)
 create mode 100644 drivers/base/regmap/regmap-fsi.c
 delete mode 100644 drivers/fsi/fsi-occ.c
 delete mode 100644 drivers/fsi/fsi-sbefifo.c
 create mode 100644 drivers/fsi/i2cr.c
 create mode 100644 drivers/fsi/i2cr.h
 create mode 100644 drivers/fsi/occ-cdev.c
 create mode 100644 drivers/fsi/occ.c
 create mode 100644 drivers/fsi/occ.h
 create mode 100644 drivers/fsi/sbefifo-cdev.c
 create mode 100644 drivers/fsi/sbefifo-fsi.c
 create mode 100644 drivers/fsi/sbefifo-i2c.c
 create mode 100644 drivers/fsi/sbefifo.c
 create mode 100644 drivers/fsi/sbefifo.h

-- 
2.31.1

