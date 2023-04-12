Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5B96DFB07
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjDLQQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjDLQQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:16:16 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE34986BE;
        Wed, 12 Apr 2023 09:15:46 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33CFiWI7004531;
        Wed, 12 Apr 2023 16:15:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=sOK6hJbrKxjZKrwj6KUDnTZAEUPt4aEnsyZ7H7rfSJQ=;
 b=s7D+Z91hsE6AwIXXQHDk40T+9pXo5HJuKkT6ylJ4t1nl7SrUUsB+AoBg15eB7Y4c3YWc
 bvt7ysIlGvbbe61A6LYO0VV+giDnc7gOQSEAcWes5cjn5YUaGSSyTQ42/3hivlurXcBU
 1vAH1OeOG7/vB1kG5JkFPxIDXz6eePe1hht8gpvxU2V8ATDOXMcKm4nh5xH7r5d1PSLH
 uooALwy8gABsOsPdLnK+HDfKFd022YOwV85Yb1K8WgmF0INOOSgxNabmahQ0/uC810OX
 vUO/EMWi6l/JW49SQoPbJHgzY2oAebvwhmwLdMIqhyKQUKcEyulW2tQvSN7aXGRERDQj 3w== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pwxpncmnu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 16:15:32 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33CDSYYo022734;
        Wed, 12 Apr 2023 16:15:31 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([9.208.130.97])
        by ppma02wdc.us.ibm.com (PPS) with ESMTPS id 3pu0f9y3f0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 16:15:31 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33CGFUrN43451000
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 16:15:31 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 84C9058059;
        Wed, 12 Apr 2023 16:15:30 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8BCF25805B;
        Wed, 12 Apr 2023 16:15:29 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.160.16.129])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 12 Apr 2023 16:15:29 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jdelvare@suse.com,
        linux@roeck-us.net, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v2 0/2] hwmon: (pmbus/core) Add lock and unlock functions
Date:   Wed, 12 Apr 2023 11:15:24 -0500
Message-Id: <20230412161526.252294-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _ShlAKnQHlv9-QdEjJeyXr4pd9KG-F28
X-Proofpoint-GUID: _ShlAKnQHlv9-QdEjJeyXr4pd9KG-F28
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_07,2023-04-12_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 impostorscore=0 clxscore=1015 suspectscore=0 mlxlogscore=667
 priorityscore=1501 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304120139
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Debugfs operations may set the page number, which must be done
atomically with the subsequent i2c operation. Lock the update_lock
in the debugfs functions and provide a function for pmbus drivers
to lock and unlock the update_lock.
Use the new lock/unlock functions in the ibm-cffps driver and make
some additional improvements.

Changes since v1:
 - No whitespace change in cffps patch.

Eddie James (2):
  hwmon: (pmbus/core) Add lock and unlock functions
  hwmon: (pmbus/ibm-cffps) Use default debugfs attributes and lock
    function

 drivers/hwmon/pmbus/ibm-cffps.c  | 272 ++++++++++++++-----------------
 drivers/hwmon/pmbus/pmbus.h      |   2 +
 drivers/hwmon/pmbus/pmbus_core.c |  30 ++++
 3 files changed, 150 insertions(+), 154 deletions(-)

-- 
2.31.1

