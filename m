Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B68E5FF5EC
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 00:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiJNWGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 18:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiJNWGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 18:06:07 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BD913ECE1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 15:06:05 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29ELAMdp002456;
        Fri, 14 Oct 2022 22:05:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=hCZmNvrm+2RvitSHC59+iYpRNn2YCg0MUUQOP1GA5bY=;
 b=PRr7me7+7ozcUbSOqocD8AJ8DcT5fPYcjH5DrdDKWUn85Q5uHzsWp/ch7/bQXbbMvXGZ
 TfWaki6N5Ts4pWWdouPif0HPTL1oweiGjxTX0pWady6YCfaXpJslMY+XFmylEi56GvJl
 HI3eU3P016SsgtKcHDkJGnTwT6SH7kJV3rOiJEUVaj3fC6XWlMIrq+7J3IFN2crACRR7
 75nCCiwyK/Cge7HJ3nAQT+p+CqgTYb/Sfc2zYToYJgo/nLal4zsOnkbp/g4WVyCOy15n
 KD3hT1pAL335ldFdaAZNYm1YfndJvZaZp9wnciZwooqRMvYSlvaI17ggDiAX21lYJALn yA== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k7dhemqy1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Oct 2022 22:05:44 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29EM5CRJ011304;
        Fri, 14 Oct 2022 22:05:43 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma04dal.us.ibm.com with ESMTP id 3k30uawk94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Oct 2022 22:05:43 +0000
Received: from smtpav06.wdc07v.mail.ibm.com ([9.208.128.115])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29EM5gcs2622194
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Oct 2022 22:05:42 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 28C1058073;
        Fri, 14 Oct 2022 22:05:42 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D97558054;
        Fri, 14 Oct 2022 22:05:41 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.160.52.204])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 14 Oct 2022 22:05:40 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     joel@jms.id.au
Cc:     broonie@kernel.org, jk@ozlabs.org, alistair@popple.id.au,
        linux-kernel@vger.kernel.org, linux-fsi@lists.ozlabs.org,
        eajames@linux.ibm.com
Subject: [PATCH 0/5] fsi: Add regmap and refactor sbefifo
Date:   Fri, 14 Oct 2022 17:05:35 -0500
Message-Id: <20221014220540.55570-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Krf6LuWJA0A5jxKswohYji9OPercKeo0
X-Proofpoint-ORIG-GUID: Krf6LuWJA0A5jxKswohYji9OPercKeo0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-14_11,2022-10-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 spamscore=0 clxscore=1011 mlxlogscore=390 adultscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210140121
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SBEFIFO hardware can now be attached over a new I2C endpoint
interface called the I2C Responder (I2CR). In order to use the
existing SBEFIFO driver, add regmap drivers for both FSI busses
and the I2CR. Then, refactor the SBEFIFO and OCC drivers to clean
up and use the new regmap drivers.

Eddie James (5):
  regmap: Add FSI bus support
  regmap: Add IBM I2CR support
  drivers: fsi: Rename sbefifo and occ sources
  drivers: fsi: separate char device code for occ and sbefifo
  drivers: fsi: occ and sbefifo refactor

 drivers/base/regmap/Kconfig           |   10 +-
 drivers/base/regmap/Makefile          |    2 +
 drivers/base/regmap/regmap-fsi.c      |  231 +++++
 drivers/base/regmap/regmap-ibm-i2cr.c |  159 ++++
 drivers/fsi/Kconfig                   |   23 +-
 drivers/fsi/Makefile                  |    8 +-
 drivers/fsi/fsi-occ.c                 |  766 -----------------
 drivers/fsi/fsi-sbefifo.c             | 1144 -------------------------
 drivers/fsi/occ-cdev.c                |  157 ++++
 drivers/fsi/occ.c                     |  534 ++++++++++++
 drivers/fsi/occ.h                     |   75 ++
 drivers/fsi/sbefifo-cdev.c            |  218 +++++
 drivers/fsi/sbefifo-fsi.c             |   68 ++
 drivers/fsi/sbefifo-i2c.c             |   72 ++
 drivers/fsi/sbefifo.c                 |  797 +++++++++++++++++
 drivers/fsi/sbefifo.h                 |   50 ++
 include/linux/regmap.h                |   72 ++
 17 files changed, 2468 insertions(+), 1918 deletions(-)
 create mode 100644 drivers/base/regmap/regmap-fsi.c
 create mode 100644 drivers/base/regmap/regmap-ibm-i2cr.c
 delete mode 100644 drivers/fsi/fsi-occ.c
 delete mode 100644 drivers/fsi/fsi-sbefifo.c
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

