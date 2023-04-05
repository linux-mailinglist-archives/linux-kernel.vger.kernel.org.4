Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3011C6D8015
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbjDEOwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233443AbjDEOwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:52:50 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26671E60;
        Wed,  5 Apr 2023 07:52:49 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 335DALID013141;
        Wed, 5 Apr 2023 14:52:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=0LY5K3/UU1Qjs5PFdmU5VBsJBkEF/LvIvCjnOMIzEVc=;
 b=cqFJBbNrZv0ARXm7XuOr/A3lNdSKF4tCe34b0H0CDvTfGa1BSQaPumeaCMLr9zP5IyKu
 j9lyzHDvUgNXNlPe5OJV41Z+ZvOIQLVytqgHWecwbZJAAqte1rar+ugN9T5HjbGTDWGN
 EI2ngbH5c1MBtZMdeD/C0UYgDF1aAgsoAnv+JadwfUD5P8T8srOaVXksSkK9HJs+KVbO
 wFYOmb9Dqggcw5DgRW7d0WdXrNtsICHASyUdA6+cBJZJqdx7OVunM2gA+T8GWQpywJe2
 7nNRqRS6oiy+B/2ZoDtc+iPTBsqE2grWKPijQMEUqVUGO4yETVuWIZ3BPYC3sFrAzKKq Jg== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ps8w7v85m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 14:52:34 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 335EAfsl031572;
        Wed, 5 Apr 2023 14:52:34 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([9.208.130.101])
        by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3ppc88cg41-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 14:52:34 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 335EqXOo15008362
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Apr 2023 14:52:33 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DFBB558052;
        Wed,  5 Apr 2023 14:52:32 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D80E58063;
        Wed,  5 Apr 2023 14:52:32 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.160.127.161])
        by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  5 Apr 2023 14:52:32 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jdelvare@suse.com,
        linux@roeck-us.net, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH 0/2] hwmon: (pmbus/core) Add lock and unlock functions
Date:   Wed,  5 Apr 2023 09:52:28 -0500
Message-Id: <20230405145230.68631-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jKtaBBRi8RygmATlEj866q1pUgQRAuqb
X-Proofpoint-ORIG-GUID: jKtaBBRi8RygmATlEj866q1pUgQRAuqb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-05_09,2023-04-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0
 adultscore=0 malwarescore=0 suspectscore=0 mlxlogscore=715
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304050132
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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

Eddie James (2):
  hwmon: (pmbus/core) Add lock and unlock functions
  hwmon: (pmbus/ibm-cffps) Use default debugfs attributes and lock
    function

 drivers/hwmon/pmbus/ibm-cffps.c  | 273 +++++++++++++------------------
 drivers/hwmon/pmbus/pmbus.h      |   2 +
 drivers/hwmon/pmbus/pmbus_core.c |  30 ++++
 3 files changed, 150 insertions(+), 155 deletions(-)

-- 
2.31.1

