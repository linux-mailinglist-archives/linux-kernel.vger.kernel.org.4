Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048886AC8D8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 17:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjCFQ5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 11:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjCFQ5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 11:57:41 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FBE5553C;
        Mon,  6 Mar 2023 08:57:12 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326FXUFJ008595;
        Mon, 6 Mar 2023 16:11:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=zF0BEHPxX0INa+tyxkG4mya8yYUlAfMExBWkAd4w0wc=;
 b=jctu7PG4GJrrlfbjzRS9122Eo6fyTkSKrzJvsAcMPZ4dz52eLGrL8ynxFE41T+7K29J6
 aOZwPpWmZKYHz+kVzTZvA9C5wvNJgk3N0S7eTomDs9GaZaTOMadGb07RDawAOpISHINm
 JYohdgKhdsogbOKvJsAFf42F/S8Bln3Di+Vnl4MjtAIdspCThwDRWGuTBQ9jzwBie8Ih
 /NnIXn2ZJpzCjMzrtx/IqIz/oW0Omp5ZXnTb+LBBWv030wJ51QpK8TrceiE7k2Bfrwro
 V5BCPVRX7uOah/gjbnYx9XI0xda7y0nRst1iQmuVPuhzl6oYw9PK/ffcAlFVlaBy9zyV vQ== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3p4wswarb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 16:11:01 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 326Fx0ki020393;
        Mon, 6 Mar 2023 16:11:00 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([9.208.129.119])
        by ppma02wdc.us.ibm.com (PPS) with ESMTPS id 3p419k633k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 16:11:00 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 326GAxeL38994232
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Mar 2023 16:10:59 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C28E58060;
        Mon,  6 Mar 2023 16:10:59 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A881858059;
        Mon,  6 Mar 2023 16:10:57 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.160.108.29])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Mar 2023 16:10:57 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhiramat@kernel.org, alistair@popple.id.au, joel@jms.id.au,
        jk@ozlabs.org, andrew@aj.id.au, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, eajames@linux.ibm.com
Subject: [PATCH v8 0/8] fsi: Add IBM I2C Responder virtual FSI master
Date:   Mon,  6 Mar 2023 10:10:48 -0600
Message-Id: <20230306161057.44017-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7MFO3IntL5dmRDdNM2P6oIUnTU1OULFp
X-Proofpoint-GUID: 7MFO3IntL5dmRDdNM2P6oIUnTU1OULFp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_08,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303060142
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

Changes since v7:
 - Add FSI master device naming patch
 - Use I2C adapter number as FSI master index with "i2cr" name
 - Export the fsi_master_i2cr_read/write functions for the SCOM driver

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

Eddie James (8):
  fsi: Move fsi_slave structure definition to header
  fsi: Make master device indexing and naming optional
  dt-bindings: fsi: Document the IBM I2C Responder virtual FSI master
  fsi: Add IBM I2C Responder virtual FSI master
  fsi: Add I2C Responder SCOM driver
  fsi: Add aliased device numbering
  fsi: Use of_match_table for bus matching if specified
  fsi: sbefifo: Don't check status during probe

 .../bindings/fsi/ibm,i2cr-fsi-master.yaml     |  41 +++
 drivers/fsi/Kconfig                           |  17 +
 drivers/fsi/Makefile                          |   2 +
 drivers/fsi/fsi-core.c                        |  73 ++--
 drivers/fsi/fsi-master-aspeed.c               |   2 +-
 drivers/fsi/fsi-master-ast-cf.c               |   2 +-
 drivers/fsi/fsi-master-gpio.c                 |   2 +-
 drivers/fsi/fsi-master-hub.c                  |   2 +-
 drivers/fsi/fsi-master-i2cr.c                 | 318 ++++++++++++++++++
 drivers/fsi/fsi-master-i2cr.h                 |  24 ++
 drivers/fsi/fsi-master.h                      |   3 +-
 drivers/fsi/fsi-sbefifo.c                     |   8 -
 drivers/fsi/fsi-scom.c                        |   8 +
 drivers/fsi/fsi-slave.h                       |  28 ++
 drivers/fsi/i2cr-scom.c                       | 154 +++++++++
 include/trace/events/fsi_master_i2cr.h        | 107 ++++++
 16 files changed, 752 insertions(+), 39 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/fsi/ibm,i2cr-fsi-master.yaml
 create mode 100644 drivers/fsi/fsi-master-i2cr.c
 create mode 100644 drivers/fsi/fsi-master-i2cr.h
 create mode 100644 drivers/fsi/fsi-slave.h
 create mode 100644 drivers/fsi/i2cr-scom.c
 create mode 100644 include/trace/events/fsi_master_i2cr.h

-- 
2.31.1

