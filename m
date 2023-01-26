Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3391267D7BE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 22:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbjAZVbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 16:31:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbjAZVbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 16:31:47 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D79F15C80;
        Thu, 26 Jan 2023 13:31:46 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30QK6vwI021614;
        Thu, 26 Jan 2023 21:31:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=Mf6rFMBtnM6tqGSKPkciaWZvU1nkFUZo0Ro+i8HWrR0=;
 b=p1Ef7GodCPSzA0Pro3Lj0+usNn9Sj4geY7uP5STTokpBt32xN2L9E1w0RFhCy8vg8qHz
 6qkV0L8oyK1eKcCGy7fXiyU48uyvxTLj4hWuQ5HtgynpLN4EcPKNi6HOpohMRrDo6U7w
 grFVi/y9iELUMFarLyBzL9PIWt1hkdFodnp3t+y3WY2iWk3S4fIXcMJB9WTUej3YUlEp
 rZxQJ1qu7kICPrEqYvTDzYpiFnjE+jpGK+fq4H65Zy9WfI7mBgRTx4an6V5pT1qcSPHO
 3uotn9w8JycwZHOwRMQGma6xQ7NoFogSTgxLpcs7q31Ov2yG2bJXKQYpyum6Ro/coZyM VA== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nbu2jtscj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 21:31:26 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30QL9CrB006970;
        Thu, 26 Jan 2023 21:31:26 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([9.208.130.99])
        by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3n87p7q5s7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 21:31:26 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30QLVPeE30474708
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jan 2023 21:31:25 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 058DA58059;
        Thu, 26 Jan 2023 21:31:25 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F50758043;
        Thu, 26 Jan 2023 21:31:23 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.160.3.213])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 26 Jan 2023 21:31:23 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-trace-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        rostedt@goodmis.org, eajames@linux.ibm.com, alistair@popple.id.au,
        joel@jms.id.au, jk@ozlabs.org, andrew@aj.id.au, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH v3 0/2] fsi: Add IBM I2C Responder virtual FSI master
Date:   Thu, 26 Jan 2023 15:31:21 -0600
Message-Id: <20230126213123.884125-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AeT6XwDjMdGazYn_x2iOWLxvSNDApdOZ
X-Proofpoint-ORIG-GUID: AeT6XwDjMdGazYn_x2iOWLxvSNDApdOZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-26_09,2023-01-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 suspectscore=0 clxscore=1015 mlxscore=0 impostorscore=0 mlxlogscore=988
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301260198
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

Changes since v2:
 - Fix the bindings again, sorry for the spam

Changes since v1:
 - Fix the binding document
 - Change the binding name
 - Clean up the size argument checking
 - Reduce __force by using packed struct for the command

Eddie James (2):
  dt-bindings: fsi: Document the IBM I2C Responder virtual FSI master
  fsi: Add IBM I2C Responder virtual FSI master

 .../bindings/fsi/ibm,i2cr-fsi-master.yaml     |  41 ++++
 drivers/fsi/Kconfig                           |   9 +
 drivers/fsi/Makefile                          |   1 +
 drivers/fsi/fsi-master-i2cr.c                 | 225 ++++++++++++++++++
 include/trace/events/fsi_master_i2cr.h        |  96 ++++++++
 5 files changed, 372 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fsi/ibm,i2cr-fsi-master.yaml
 create mode 100644 drivers/fsi/fsi-master-i2cr.c
 create mode 100644 include/trace/events/fsi_master_i2cr.h

-- 
2.31.1

