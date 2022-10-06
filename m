Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB375F7135
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 00:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiJFWhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 18:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiJFWhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 18:37:21 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044D592593;
        Thu,  6 Oct 2022 15:37:21 -0700 (PDT)
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 296MYusK001006;
        Thu, 6 Oct 2022 22:37:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=Duxug50hyqlUo3vJQebtcrpCMNmKwa8QfgSYdJzoNuM=;
 b=UhZyX7MU0w0HqSuDw3L+7n1VfgicJUNVpqT5yfol8RiGbu2SHXmcDOsDE+GDPG17WbB5
 +4a0STX/LZgmBfZLHSGwLsNu9Ly3k4rn26owIePqTqDLTzLeKy280HQ3SqOeeAISp0BU
 v8+83FTDfuARSYr5Wl+e4Y0B/N+BvfwoLvcgKFMwcksgclqIfIWYK93WzR4SW8okQmb/
 djJyx4EOfjQzkWH/zotD2XEMRn0A0wLnO5IHlQvYpZZwn0rhOH5Z+NXYQrzqAVnlHf5N
 oGNwTh9xPV3BMm42dCGu7cWyAvPUhLMX1s0Exp4tH4oUi3YQIfQrrhspV0V6FtI/6R/X nw== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3k27xag0ke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Oct 2022 22:37:15 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 65B3313949;
        Thu,  6 Oct 2022 22:32:15 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 162C6803AB6;
        Thu,  6 Oct 2022 22:32:15 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [RFC PATCH 1/7] rcu: correct CONFIG_EXT_RCU_CPU_STALL_TIMEOUT descriptions
Date:   Thu,  6 Oct 2022 17:31:45 -0500
Message-Id: <20221006223151.22159-2-elliott@hpe.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221006223151.22159-1-elliott@hpe.com>
References: <20221006223151.22159-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 3tntthtH4ugWrwTBrPT1WkqFVy2HJArY
X-Proofpoint-GUID: 3tntthtH4ugWrwTBrPT1WkqFVy2HJArY
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-06_05,2022-10-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 bulkscore=0 adultscore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210060133
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the descriptions of CONFIG_EXT_RCU_CPU_STALL_TIMEOUT
match the code:

- there is no longer a default of 20 ms for Android since
commit 1045a06724f3 ("remove CONFIG_ANDROID"),

- the code includes a maximum of 21 seconds, evident when
specifying 0 which means to use the CONFIG_RCU_STALL_TIMEOUT
value (whose default is 60 seconds).

Example .config:
  CONFIG_RCU_CPU_STALL_TIMEOUT=60
  CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0

leads to:
  /sys/module/rcupdate/parameters/rcu_cpu_stall_timeout:60
  /sys/module/rcupdate/parameters/rcu_exp_cpu_stall_timeout:21000

Fixes: 1045a06724f3 ("remove CONFIG_ANDROID")
Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 Documentation/RCU/stallwarn.rst | 9 +++++----
 kernel/rcu/Kconfig.debug        | 2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/RCU/stallwarn.rst b/Documentation/RCU/stallwarn.rst
index e38c587067fc..d86a8b47504f 100644
--- a/Documentation/RCU/stallwarn.rst
+++ b/Documentation/RCU/stallwarn.rst
@@ -168,10 +168,11 @@ CONFIG_RCU_EXP_CPU_STALL_TIMEOUT
 	Same as the CONFIG_RCU_CPU_STALL_TIMEOUT parameter but only for
 	the expedited grace period. This parameter defines the period
 	of time that RCU will wait from the beginning of an expedited
-	grace period until it issues an RCU CPU stall warning. This time
-	period is normally 20 milliseconds on Android devices.	A zero
-	value causes the CONFIG_RCU_CPU_STALL_TIMEOUT value to be used,
-	after conversion to milliseconds.
+	grace period until it issues an RCU CPU stall warning.
+
+	A zero value causes the CONFIG_RCU_CPU_STALL_TIMEOUT value to be
+        used, after conversion to milliseconds, limited to a maximum of
+        21 seconds.
 
 	This configuration parameter may be changed at runtime via the
 	/sys/module/rcupdate/parameters/rcu_exp_cpu_stall_timeout, however
diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
index 1b0c41d490f0..4477eeb8a54f 100644
--- a/kernel/rcu/Kconfig.debug
+++ b/kernel/rcu/Kconfig.debug
@@ -93,7 +93,7 @@ config RCU_EXP_CPU_STALL_TIMEOUT
 	  If the RCU grace period persists, additional CPU stall warnings
 	  are printed at more widely spaced intervals.  A value of zero
 	  says to use the RCU_CPU_STALL_TIMEOUT value converted from
-	  seconds to milliseconds.
+	  seconds to milliseconds, limited to a maximum of 21 seconds.
 
 config RCU_TRACE
 	bool "Enable tracing for RCU"
-- 
2.37.3

