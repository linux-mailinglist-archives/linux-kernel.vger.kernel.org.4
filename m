Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C526946D3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 14:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjBMNVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 08:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjBMNVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 08:21:01 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255CDBDFB;
        Mon, 13 Feb 2023 05:21:00 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31D4gR8p017058;
        Mon, 13 Feb 2023 07:20:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=a6KdMqV9U9YOz/15FX45aqFZVTUd19HQuUArG7NzmiU=;
 b=doGuSc7j4YPE6LAoDaliI69UgUjezremHk3GihC7AQkkCwfrlcinCWZbBewQBIkakSd1
 lDPjmpsWxzkYx1iI2TcsKTsyiUrhSvdhDmShMJR9Mctt//OSlSleraKubH15dFY6UAjW
 ZFFurMYqlWpHGSahw+h8ju8Bmlmxq6x5GTIcq1VXu79GRxiwRk+alYjWCwzFJ+Sn2P9y
 OjVQdFPeuq8LFa0MSnzbCdKqdJj8ZoCpierCGT2O3NJOgpBTMqD90relGhLbXh0nNiAs
 aoV2x9oHu90SKl8i65tAdDCMQBhvb43dvCgkrMPqAs6CGI+RlWR05Pma9+XMIQ3K1ltr wg== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3np8att8gp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 07:20:50 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Mon, 13 Feb
 2023 07:20:48 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.21 via Frontend Transport; Mon, 13 Feb 2023 07:20:48 -0600
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.127])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id DBBF5B0E;
        Mon, 13 Feb 2023 13:20:48 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <rafael@kernel.org>, <pavel@ucw.cz>, <len.brown@intel.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] PM: Add EXPORT macros for exporting PM functions
Date:   Mon, 13 Feb 2023 13:20:48 +0000
Message-ID: <20230213132048.2612961-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: BejLWHeqiJjpbC1ikArkz3pqc5hxYECt
X-Proofpoint-ORIG-GUID: BejLWHeqiJjpbC1ikArkz3pqc5hxYECt
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a set of macros for exporting functions only if CONFIG_PM
is enabled.

The naming follows the style of the standard EXPORT_SYMBOL_*()
macros that they replace.

Sometimes a module wants to export PM functions directly to other
drivers, not a complete struct dev_pm_ops. A typical example is
where a core library exports the generic (shared) implementation
and calling code wraps one or more of these in custom code.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 include/linux/pm.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index 93cd34f00822..21618f7087f8 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -379,9 +379,17 @@ const struct dev_pm_ops name = { \
 	const struct dev_pm_ops name;					\
 	__EXPORT_SYMBOL(name, sec, ns);					\
 	const struct dev_pm_ops name
+#define EXPORT_PM_FN(name)		EXPORT_SYMBOL(name)
+#define EXPORT_PM_FN_GPL(name)		EXPORT_SYMBOL_GPL(name)
+#define EXPORT_PM_FN_NS(name, ns)	EXPORT_SYMBOL_NS(name, ns)
+#define EXPORT_PM_FN_NS_GPL(name, ns)	EXPORT_SYMBOL_NS_GPL(name, ns)
 #else
 #define _EXPORT_DEV_PM_OPS(name, sec, ns)				\
 	static __maybe_unused const struct dev_pm_ops __static_##name
+#define EXPORT_PM_FN(name)
+#define EXPORT_PM_FN_GPL(name)
+#define EXPORT_PM_FN_NS(name, ns)
+#define EXPORT_PM_FN_NS_GPL(name, ns)
 #endif
 
 #define EXPORT_DEV_PM_OPS(name) _EXPORT_DEV_PM_OPS(name, "", "")
-- 
2.30.2

