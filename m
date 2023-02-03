Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C14689111
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 08:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbjBCHkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 02:40:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232461AbjBCHke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 02:40:34 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DC993AF8;
        Thu,  2 Feb 2023 23:40:24 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3136umpC031865;
        Fri, 3 Feb 2023 07:40:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=W6h8V1zpwEkskGTzcjkxhlNXpeHXV5iR8z5FgwPs6tU=;
 b=p8u3qR6o0hyPg7WaUWGP1BoCAUevGI7BJddoH3FIBjOdRSOhT6zcnBJNljmLFbjGDGfm
 Ty5EqIIlqkNFiussAYx9xv/UzUh+UPZKV2F1kpNGe9TU6xQGEO7xGaCUM2dCSKmaox7i
 LRntASX9V+540ftns7f5Xbyo9KEbiUSKWFWOwp2uQjOCYmNh0FQS83ycqlbPFY05dXHN
 6LpbIZVBtfc8yfaFUPqXw0cGmkb8i5l1Uym/Rtby/R2NcNNNCN/5q6neMOaeVZFXiMAE
 My4sGeR2Ea6ABjhIZAdbbIdolxaKZNt1O7Jvcw5IT6qbKsoZUGH4snsPdUcncXrHcrbV oQ== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ngwetgxrx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Feb 2023 07:40:11 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3136T6e2031351;
        Fri, 3 Feb 2023 07:40:09 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3ncvv6d2sm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Feb 2023 07:40:09 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3137e7j019464480
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Feb 2023 07:40:07 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 21A1C21436;
        Fri,  3 Feb 2023 07:40:07 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1434D21429;
        Fri,  3 Feb 2023 07:40:04 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  3 Feb 2023 07:40:04 +0000 (GMT)
From:   Alexander Egorenkov <egorenar@linux.ibm.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        hca@linux.ibm.com
Subject: [PATCH 0/5] diag288 watchdog fixes and improvements
Date:   Fri,  3 Feb 2023 08:39:53 +0100
Message-Id: <20230203073958.1585738-1-egorenar@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wfd7VBVoRvCwMQlJrM23Jr73FfP6x7FC
X-Proofpoint-ORIG-GUID: wfd7VBVoRvCwMQlJrM23Jr73FfP6x7FC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-03_04,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=836 phishscore=0 clxscore=1011
 impostorscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302030069
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minor code refactoring to improve readability of the driver,
reduce code duplication and remove dead code.

Alexander Egorenkov (5):
  watchdog: diag288_wdt: get rid of register asm
  watchdog: diag288_wdt: remove power management
  watchdog: diag288_wdt: unify command buffer handling for diag288 zvm
  watchdog: diag288_wdt: de-duplicate diag_stat_inc() calls
  watchdog: diag288_wdt: unify lpar and zvm diag288 helpers

 drivers/watchdog/diag288_wdt.c | 162 ++++++++-------------------------
 1 file changed, 37 insertions(+), 125 deletions(-)

-- 
2.37.2

