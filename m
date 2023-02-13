Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2795E694D45
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 17:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjBMQuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 11:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjBMQuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 11:50:21 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A082C10DD;
        Mon, 13 Feb 2023 08:50:20 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31D5v5hL009266;
        Mon, 13 Feb 2023 10:50:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=F8TUMXGOhWtM0xhDNu8yzbORHyhxZkTgVpYiH25GvO8=;
 b=K/0j7v7Pgo4OnPfgAPRgefKbh7vLwBtbnsrrhuqzexvGkfLBDtliqn6jko9g3+K0iS7p
 YmNHUsSqG+fY8iKLXZbJuZEfKZKHPtvkMpiTSK+DUQqw9ppeqxl7bXwnfpCyIgOCfSN+
 ccumCn2W/9DHn3QsOlG8UJv93WfFgw+dLmN382exbfHfFNIKA3TP8ieGIOTj3p8lGLx9
 GTUK359t/2DadHM+g1+BOd9XgIfmveB5uUMDcAw+HcxpQDvG7K85iMHdlUbQQvts+eJc
 ybz6fZ+45Z+IDnnOwzmZn6IgiKZd628LjgSgHmD0r9D2CMqZiFQHp9O10W2JyRsk8Tv/ pA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3np9a72fk8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 10:50:07 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Mon, 13 Feb
 2023 10:50:05 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.21 via Frontend
 Transport; Mon, 13 Feb 2023 10:50:05 -0600
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.127])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 723EA11AA;
        Mon, 13 Feb 2023 16:50:05 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <rafael@kernel.org>, <pavel@ucw.cz>, <len.brown@intel.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v2] PM: Add EXPORT macros for exporting PM functions
Date:   Mon, 13 Feb 2023 16:50:05 +0000
Message-ID: <20230213165005.2943219-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: N1uBgpY4xXvU798yocea3UNUbfImLfqN
X-Proofpoint-ORIG-GUID: N1uBgpY4xXvU798yocea3UNUbfImLfqN
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a pair of macros for exporting functions only if CONFIG_PM
is enabled.

The naming follows the style of the standard EXPORT_SYMBOL_*()
macros that they replace.

Sometimes a module wants to export PM functions directly to other
drivers, not a complete struct dev_pm_ops. A typical example is
where a core library exports the generic (shared) implementation
and calling code wraps one or more of these in custom code.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 include/linux/pm.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index 93cd34f00822..035d9649eba4 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -379,9 +379,13 @@ const struct dev_pm_ops name = { \
 	const struct dev_pm_ops name;					\
 	__EXPORT_SYMBOL(name, sec, ns);					\
 	const struct dev_pm_ops name
+#define EXPORT_PM_FN_GPL(name)		EXPORT_SYMBOL_GPL(name)
+#define EXPORT_PM_FN_NS_GPL(name, ns)	EXPORT_SYMBOL_NS_GPL(name, ns)
 #else
 #define _EXPORT_DEV_PM_OPS(name, sec, ns)				\
 	static __maybe_unused const struct dev_pm_ops __static_##name
+#define EXPORT_PM_FN_GPL(name)
+#define EXPORT_PM_FN_NS_GPL(name, ns)
 #endif
 
 #define EXPORT_DEV_PM_OPS(name) _EXPORT_DEV_PM_OPS(name, "", "")
-- 
2.30.2

