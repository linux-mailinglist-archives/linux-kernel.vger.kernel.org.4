Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696AC6A9CAD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 18:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjCCREr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 12:04:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbjCCREl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 12:04:41 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833184201;
        Fri,  3 Mar 2023 09:04:40 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 323FfsaL007125;
        Fri, 3 Mar 2023 17:04:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=wq3AH8u5wlweiaiE2n7B66++FFOVcFqeWMITnz01CiY=;
 b=ozodOT6TRcQgJySAcrbk9EdVJtTEQzbzB/j18GYogVFzRZxF3O0Uox23ayZpLMXiLi8a
 VXZFh8aKGk17GElAsZpG7sPzPjny9eFsfTrFiE+Pbgbs2gF5ySkgKXD6obknc2xX6q75
 Ep+ZrwevZ1mk/LCb+bMbYot34GBSlOMY3VIrV1uBFIlMrDtGhLR1QS34KFV1P2XOr6K3
 7OWgt02JYghmEDvyKIGpMjDxEjZtXQD+FHsdOMhATQ4hojazNSGkPuZiBxTG3ewVh+CC
 rTJ9wDTUsYt9IxpkgPfoWqLQeSOv78M1Bbm6RUDuMyeWf332fk2vK0XKaFqC2ZznQotG Yg== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p3krrjbq2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Mar 2023 17:04:21 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 323Ejvi3005616;
        Fri, 3 Mar 2023 17:04:20 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([9.208.130.102])
        by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3nybexvx5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Mar 2023 17:04:20 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 323H4JV145285706
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Mar 2023 17:04:19 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3961558059;
        Fri,  3 Mar 2023 17:04:19 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5CCC95805F;
        Fri,  3 Mar 2023 17:04:17 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.77.137.234])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  3 Mar 2023 17:04:17 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhiramat@kernel.org, alistair@popple.id.au, joel@jms.id.au,
        jk@ozlabs.org, andrew@aj.id.au, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, eajames@linux.ibm.com
Subject: [PATCH v7 0/7] fsi: Add IBM I2C Responder virtual FSI master
Date:   Fri,  3 Mar 2023 11:04:09 -0600
Message-Id: <20230303170416.1347530-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dDjIWwr1Uj2h7H-djzz7F2cpxPEgCJGE
X-Proofpoint-GUID: dDjIWwr1Uj2h7H-djzz7F2cpxPEgCJGE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_03,2023-03-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 adultscore=0 spamscore=0 clxscore=1015
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2303030148
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The I2C Responder (I2CR) is an I2C device that translates I2C commands
to CFAM or SCOM operations, effectively implementing an FSI master and
bus.

Changes since v6:
 - Drop conversions to BE except in the FSI core interface
 - Emulate the CFAM config table since it doesn't exist off the I2CR
 - Drop status check during probe
 - Add release function for device
 - Update SCOM driver with newer interfaces and drop BE conversion
 - New sbefifo change to not check state during probe

Changes since v5:
 - Make I2CR scom driver depend on I2CR FSI master

Changes since v4:
 - Add I2CR scom driver and associated patches
 - Use compatible strings for FSI drivers if specified
 - Include aliased device numbering patch
 - Restructure the trace events to eliminate holes

Changes since v3:
 - Rework the endian-ness in i2cr_write
 - Rework the tracing to include the i2c bus and device address

Changes since v2:
 - Fix the bindings again, sorry for the spam

Changes since v1:
 - Fix the binding document
 - Change the binding name
 - Clean up the size argument checking
 - Reduce __force by using packed struct for the command

Eddie James (7):
  fsi: Move fsi_slave structure definition to header
  dt-bindings: fsi: Document the IBM I2C Responder virtual FSI master
  fsi: Add IBM I2C Responder virtual FSI master
  fsi: Add I2C Responder SCOM driver
  fsi: Add aliased device numbering
  fsi: Use of_match_table for bus matching if specified
  fsi: sbefifo: Don't check status during probe

 .../bindings/fsi/ibm,i2cr-fsi-master.yaml     |  41 +++
 drivers/fsi/Kconfig                           |  17 +
 drivers/fsi/Makefile                          |   2 +
 drivers/fsi/fsi-core.c                        |  60 ++--
 drivers/fsi/fsi-master-aspeed.c               |   2 +-
 drivers/fsi/fsi-master-ast-cf.c               |   2 +-
 drivers/fsi/fsi-master-gpio.c                 |   2 +-
 drivers/fsi/fsi-master-hub.c                  |   2 +-
 drivers/fsi/fsi-master-i2cr.c                 | 312 ++++++++++++++++++
 drivers/fsi/fsi-master-i2cr.h                 |  24 ++
 drivers/fsi/fsi-master.h                      |   3 +-
 drivers/fsi/fsi-sbefifo.c                     |   8 -
 drivers/fsi/fsi-scom.c                        |   8 +
 drivers/fsi/fsi-slave.h                       |  28 ++
 drivers/fsi/i2cr-scom.c                       | 154 +++++++++
 include/trace/events/fsi_master_i2cr.h        | 107 ++++++
 16 files changed, 737 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/fsi/ibm,i2cr-fsi-master.yaml
 create mode 100644 drivers/fsi/fsi-master-i2cr.c
 create mode 100644 drivers/fsi/fsi-master-i2cr.h
 create mode 100644 drivers/fsi/fsi-slave.h
 create mode 100644 drivers/fsi/i2cr-scom.c
 create mode 100644 include/trace/events/fsi_master_i2cr.h

-- 
2.31.1

