Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CF9674046
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 18:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjASRr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 12:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjASRri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 12:47:38 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D80457CA;
        Thu, 19 Jan 2023 09:47:37 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30JGs6N8010426;
        Thu, 19 Jan 2023 17:47:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=nDBtNbxiTsR1pRQ6YNTP5Elyaltxfsu1m6pub8C7Vs8=;
 b=pLlrvzXBVvMKbQo9sqI+NKd/oVyUWm6HbZAXl5TjUIbm2mwGW9TYT+X6rwKrGJdl880+
 4Lo8q45PNAQBc4ddNOT0Hg9m2P3k504REVuWZKKteydhcmXq/OGNAphbyrRd7dsuquLL
 vDjSfXhrlllnJa7mmzntcHbzdL44G1jN/ZyhBKNhaKtQ4Du4Gan+yfbxkipmeYiFIoSH
 Hg8MZZcIQFT1yFnzafyN/juVUZJzzLwafoK46vD5rixngMSkkcgPPicWSxeBwddc20HN
 nVaLmg3ZTZiOoTlXOeGl3+iXdOcu4SqRtpLSaUqy0nt4LYa3N7na5Ug5anI/e7AlSyvf IQ== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3n79ss99g9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 17:47:20 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30JF0GkR018337;
        Thu, 19 Jan 2023 17:47:19 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([9.208.130.97])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3n3m17nj2n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 17:47:19 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30JHlITB37028542
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 17:47:18 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CECF05803F;
        Thu, 19 Jan 2023 17:47:18 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BDDA258060;
        Thu, 19 Jan 2023 17:47:17 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.160.43.39])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 19 Jan 2023 17:47:17 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, jk@ozlabs.org, joel@jms.id.au,
        alistair@popple.id.au, devicetree@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH 0/2] fsi: Add IBM I2C Responder virtual FSI master
Date:   Thu, 19 Jan 2023 11:47:12 -0600
Message-Id: <20230119174714.1486042-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -HjMonkYG-iH4vn-gB0FUF2D-7iIjpzX
X-Proofpoint-ORIG-GUID: -HjMonkYG-iH4vn-gB0FUF2D-7iIjpzX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_11,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 clxscore=1011 lowpriorityscore=0 malwarescore=0 mlxlogscore=655
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190144
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

Eddie James (2):
  dt-bindings: fsi: Document the IBM I2C Responder virtual FSI master
  fsi: Add IBM I2C Responder virtual FSI master

 .../devicetree/bindings/fsi/ibm,i2cr.yaml     |  42 ++++
 drivers/fsi/Kconfig                           |   9 +
 drivers/fsi/Makefile                          |   1 +
 drivers/fsi/fsi-master-i2cr.c                 | 225 ++++++++++++++++++
 include/trace/events/fsi_master_i2cr.h        |  96 ++++++++
 5 files changed, 373 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fsi/ibm,i2cr.yaml
 create mode 100644 drivers/fsi/fsi-master-i2cr.c
 create mode 100644 include/trace/events/fsi_master_i2cr.h

-- 
2.31.1

