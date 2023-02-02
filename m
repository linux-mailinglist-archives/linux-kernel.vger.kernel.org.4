Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16987688772
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 20:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbjBBTTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 14:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbjBBTTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 14:19:48 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695AA6BBFF;
        Thu,  2 Feb 2023 11:19:48 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 312IgHGh005107;
        Thu, 2 Feb 2023 19:19:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=90rb28D4eH5/VYus99ZiB0G9V1016cNatkVgJowu94o=;
 b=d/85v8E9/7RcqVon+IyjSV278nBpZa/V4V88EvF3jQYvGzC/Dr5uFnhbsoKoQxNxvdze
 V0hZGBOMnGjk+zxGwbdEq7Xg+dpSKWdKWlH2+Bqp91whSpsPiPUNo11/HA+ZngQ1FT3a
 /f3Y6xobY5DabWLHUT6kOk9UnBTWKuBqAvppaaAYoJyQTcEjdPj2X7j9Nb10rDQNg7e2
 M70nkZREs8WJxODOqkDMhbuIDVMigtixrpjavAySfkNdQoa3M6ZbDG0OFq2YyuwBNvZL
 xhP1R8/ojqRt++QrCaUmpP8eO6EEtFpRXmGTZWdXcURYEDvwj7wDrVn0HoZwPZe07idE JQ== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ngjp60ykc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 19:19:31 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 312Icw3X028521;
        Thu, 2 Feb 2023 19:19:30 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([9.208.129.119])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3ncvuyw399-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 19:19:30 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 312JJSOD38732180
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Feb 2023 19:19:29 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9392E5805A;
        Thu,  2 Feb 2023 19:19:28 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D80F58056;
        Thu,  2 Feb 2023 19:19:27 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.65.214.66])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  2 Feb 2023 19:19:26 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-trace-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        rostedt@goodmis.org, eajames@linux.ibm.com, alistair@popple.id.au,
        joel@jms.id.au, jk@ozlabs.org, andrew@aj.id.au, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH v4 0/2] fsi: Add IBM I2C Responder virtual FSI master
Date:   Thu,  2 Feb 2023 13:19:24 -0600
Message-Id: <20230202191926.133340-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TPKBdyL1LEJuXxcnqGIux5U6f2yx6U9c
X-Proofpoint-GUID: TPKBdyL1LEJuXxcnqGIux5U6f2yx6U9c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_13,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 spamscore=0 impostorscore=0 mlxscore=0 mlxlogscore=824 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302020171
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

Eddie James (2):
  dt-bindings: fsi: Document the IBM I2C Responder virtual FSI master
  fsi: Add IBM I2C Responder virtual FSI master

 .../bindings/fsi/ibm,i2cr-fsi-master.yaml     |  41 ++++
 drivers/fsi/Kconfig                           |   9 +
 drivers/fsi/Makefile                          |   1 +
 drivers/fsi/fsi-master-i2cr.c                 | 218 ++++++++++++++++++
 include/trace/events/fsi_master_i2cr.h        | 109 +++++++++
 5 files changed, 378 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fsi/ibm,i2cr-fsi-master.yaml
 create mode 100644 drivers/fsi/fsi-master-i2cr.c
 create mode 100644 include/trace/events/fsi_master_i2cr.h

-- 
2.31.1

