Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4798E69FC08
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 20:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbjBVTYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 14:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbjBVTYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 14:24:35 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49623E0A1;
        Wed, 22 Feb 2023 11:24:17 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31MJKv1u009111;
        Wed, 22 Feb 2023 19:23:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=6X/uWgZ2IDMbDZgnGdRug7iHumTCR5NfVCdnCxhomxs=;
 b=hH+Q2NolB/lG+mb+mHtp1g/7EL68vqk86+iQNeAmBkRmI3n1FmR3OqD7queCcEsyMpTp
 NNsa32bz6pfNZiqzcXV4+VnigpHLxMjibSBiQrFsn93SwwctHajNRwFhNAFUZZSAhypZ
 NC30KD5otoux/dwfMWvcm/l5EVP2aD7lLURGuWBrjTkezo+1A+VpbtY/A8A8AfiWixCm
 7Wja4TXi1TPAtwi1aPDpHDNwG8EqgZdKNMUw3uZKgk8YHT4qSK/baCehNaNGMwMpymyy
 NQdm0QMMt1GK61xjOvurHwBRitr3f6HTiOOdoIrjbRgKJ9DQ8+Pqrwi18Q4x47IGXs6E WA== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nws4mg355-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 19:23:58 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31MIrGJn000562;
        Wed, 22 Feb 2023 19:23:57 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([9.208.130.101])
        by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3ntpa7gb1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 19:23:57 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31MJNu2e33227068
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 19:23:56 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 610E75805C;
        Wed, 22 Feb 2023 19:23:56 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5D6558051;
        Wed, 22 Feb 2023 19:23:54 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.160.56.187])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 22 Feb 2023 19:23:54 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhiramat@kernel.org, alistair@popple.id.au, joel@jms.id.au,
        jk@ozlabs.org, andrew@aj.id.au, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, eajames@linux.ibm.com
Subject: [PATCH v6 0/6] fsi: Add IBM I2C Responder virtual FSI master
Date:   Wed, 22 Feb 2023 13:23:48 -0600
Message-Id: <20230222192354.4055034-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Qau5jaHgFOrSKMbbqlF3DqLYceg6fCG_
X-Proofpoint-GUID: Qau5jaHgFOrSKMbbqlF3DqLYceg6fCG_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_08,2023-02-22_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302220164
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The I2C Responder (I2CR) is an I2C device that translates I2C commands
to CFAM or SCOM operations, effectively implementing an FSI master and
bus.

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

Eddie James (6):
  fsi: Move fsi_slave structure definition to header
  dt-bindings: fsi: Document the IBM I2C Responder virtual FSI master
  fsi: Add IBM I2C Responder virtual FSI master
  fsi: Add I2C Responder SCOM driver
  fsi: Add aliased device numbering
  fsi: Use of_match_table for bus matching if specified

 .../bindings/fsi/ibm,i2cr-fsi-master.yaml     |  41 ++++
 drivers/fsi/Kconfig                           |  17 ++
 drivers/fsi/Makefile                          |   2 +
 drivers/fsi/fsi-core.c                        |  60 +++--
 drivers/fsi/fsi-master-aspeed.c               |   2 +-
 drivers/fsi/fsi-master-ast-cf.c               |   2 +-
 drivers/fsi/fsi-master-gpio.c                 |   2 +-
 drivers/fsi/fsi-master-hub.c                  |   2 +-
 drivers/fsi/fsi-master-i2cr.c                 | 228 ++++++++++++++++++
 drivers/fsi/fsi-master-i2cr.h                 |  24 ++
 drivers/fsi/fsi-master.h                      |   3 +-
 drivers/fsi/fsi-scom.c                        |   8 +
 drivers/fsi/fsi-slave.h                       |  28 +++
 drivers/fsi/i2cr-scom.c                       | 158 ++++++++++++
 include/trace/events/fsi_master_i2cr.h        | 109 +++++++++
 15 files changed, 659 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/fsi/ibm,i2cr-fsi-master.yaml
 create mode 100644 drivers/fsi/fsi-master-i2cr.c
 create mode 100644 drivers/fsi/fsi-master-i2cr.h
 create mode 100644 drivers/fsi/fsi-slave.h
 create mode 100644 drivers/fsi/i2cr-scom.c
 create mode 100644 include/trace/events/fsi_master_i2cr.h

-- 
2.31.1

