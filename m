Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2448C72CFEF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 21:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235799AbjFLT5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 15:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234031AbjFLT5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 15:57:19 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E4FE73;
        Mon, 12 Jun 2023 12:57:18 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CJqdGU024910;
        Mon, 12 Jun 2023 19:56:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=w8QDzgP0fMv5SkPQ3RMbBfTPNkUSqRxyIBjRBSpsT1Y=;
 b=Ji15yHQXdWIQNk2PhxVQhL7Ox0iLH9eOWLqw9GH67/nbreeLO2QaHFy2rS6737aTC5P5
 EZgIwwX0FY51Ri54fg1iEPC/3c54rJuxynssQo2Uu3cSXSlvRede6XajjFlXv+Zl8qWI
 CP+aRHZ5WUSiNQmr8XAsXH/EOPZpsrWxZ+JeagTaex3pIaVtwb1NYfFVMpizYNdumaJm
 COYgClAhUCBnKedtTTop9NFvYKBuT83GjC5XlaMz2TkDuUjEvIW7QHGY7fQN0oGRye1r
 cdMjKqduURZ639EY9iK3EQAO0nTdXSEFUuhQOM+e/NmwOlc7D/gxLgHenZ2FhSiWPXZ8 8Q== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r69wgr30f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 19:56:59 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35CHjMA7002823;
        Mon, 12 Jun 2023 19:56:58 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([9.208.130.99])
        by ppma03wdc.us.ibm.com (PPS) with ESMTPS id 3r4gt5cm92-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 19:56:58 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35CJuvJG22020524
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 19:56:58 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D393958055;
        Mon, 12 Jun 2023 19:56:57 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 914D458059;
        Mon, 12 Jun 2023 19:56:57 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.148.226])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 12 Jun 2023 19:56:57 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, jk@ozlabs.org, joel@jms.id.au,
        alistair@popple.id.au, andrew@aj.id.au, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 00/14] fsi: Miscellaneous fixes and I2C Responder driver
Date:   Mon, 12 Jun 2023 14:56:43 -0500
Message-Id: <20230612195657.245125-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: B-uG64PmwxPCeZ1gYsNLZXvrqbTzftzQ
X-Proofpoint-ORIG-GUID: B-uG64PmwxPCeZ1gYsNLZXvrqbTzftzQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_14,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=877 malwarescore=0 mlxscore=0 bulkscore=0 spamscore=0
 clxscore=1011 priorityscore=1501 lowpriorityscore=0 phishscore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306120169
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds a number of fixes and improvements to the FSI driver
and adds the I2C Responder driver. The I2C Responder(I2CR) is an I2C
device that translates I2C commands to CFAM or SCOM operations,
effectively implementing an FSI master and bus.

Eddie James (14):
  fsi: Move fsi_slave structure definition to header
  fsi: Add aliased device numbering
  fsi: Use of_match_table for bus matching if specified
  fsi: sbefifo: Don't check status during probe
  fsi: sbefifo: Add configurable in-command timeout
  fsi: sbefifo: Remove limits on user-specified read timeout
  fsi: aspeed: Reset master errors after CFAM reset
  fsi: core: Add trace events for scan and unregister
  fsi: core: Fix legacy minor numbering
  fsi: core: Switch to ida_alloc/free
  fsi: Improve master indexing
  dt-bindings: fsi: Document the IBM I2C Responder virtual FSI master
  fsi: Add IBM I2C Responder virtual FSI master
  fsi: Add I2C Responder SCOM driver

 .../bindings/fsi/ibm,i2cr-fsi-master.yaml     |  41 +++
 drivers/fsi/Kconfig                           |  17 +
 drivers/fsi/Makefile                          |   2 +
 drivers/fsi/fsi-core.c                        | 122 ++++---
 drivers/fsi/fsi-master-aspeed.c               |   4 +-
 drivers/fsi/fsi-master-ast-cf.c               |   2 +-
 drivers/fsi/fsi-master-gpio.c                 |   2 +-
 drivers/fsi/fsi-master-hub.c                  |   4 +-
 drivers/fsi/fsi-master-i2cr.c                 | 316 ++++++++++++++++++
 drivers/fsi/fsi-master-i2cr.h                 |  33 ++
 drivers/fsi/fsi-master.h                      |   2 +-
 drivers/fsi/fsi-sbefifo.c                     |  47 ++-
 drivers/fsi/fsi-scom.c                        |   8 +
 drivers/fsi/fsi-slave.h                       |  28 ++
 drivers/fsi/i2cr-scom.c                       | 154 +++++++++
 include/trace/events/fsi.h                    |  31 ++
 include/trace/events/fsi_master_i2cr.h        | 107 ++++++
 include/uapi/linux/fsi.h                      |  10 +
 18 files changed, 865 insertions(+), 65 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/fsi/ibm,i2cr-fsi-master.yaml
 create mode 100644 drivers/fsi/fsi-master-i2cr.c
 create mode 100644 drivers/fsi/fsi-master-i2cr.h
 create mode 100644 drivers/fsi/fsi-slave.h
 create mode 100644 drivers/fsi/i2cr-scom.c
 create mode 100644 include/trace/events/fsi_master_i2cr.h

-- 
2.31.1

