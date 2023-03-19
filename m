Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7936C0012
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 09:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjCSIl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 04:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjCSIlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 04:41:53 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2098.outbound.protection.outlook.com [40.107.117.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7253E1042C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 01:41:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DU2H/x/pK1tDKAxdarh5x9R1u2kWGXHPMwwaDmtG19Cet6vbduExN1Y+W+1oQDC6oKpZDLouwctVkb98FF5jFA2QpEAJeUG4XaBhaKfP7qoNKhs7MCqxiU5RxRBmWheHVdsw8HZO1AlRzYHhzG00Av/a5MJDcayhf42jE8yVWZKSfTL1m1C/uWd53DhYBJtvsPdcjhNNkH3CJ5Nm1jDVXmr3HVlVsYFNTCfA7pl7wwwdHqa13sqwNt50JGxZElu0HCw8BqHQlwgihzFPCLLGgGZBhpqzBgxbOAGrmCTS38rtCExBeuYDARa/zek3xbNYngtSraT8fv745aQSBTaAZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6BZayVBRrs48yzFLcLJlf01NdTuhulQfafIL7TCrlZg=;
 b=hyMI/xlg4ZupwwWff1vUdO7cMxYhj0HJQ1v0Nr0WK5xPmN2eRp/gO2q+Y/M63Li82gDNYKAXM4Chpo7R0GEoZHnUlzugk5IZdxMaZ8KKFBrOcIzfjksa//qXki4QWU7mNnJ/W30wVsXVxFTlcffj29OZ8SgaMjpNds45nTJVnlOHTRVZsdZkhL8oX+ps3LAccInaeMhHceh2UVUXuqFG+R/hHcal8eklOCL/bY+jdhCvekb+5UPCKwC2WEGQ60HZ50ynZusOlWkEiJ4WwD+rQKtQ+q1jL3eTVcGrMkxC8Zp7tGAPCDTRwPsGTQTJrGZxbr6YI7FI/F8KKPLFTZ7Eog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6BZayVBRrs48yzFLcLJlf01NdTuhulQfafIL7TCrlZg=;
 b=J6fCEEhREDEm6yx4auOrL5Oi2pxqYzHPeqIonFpKyYdRcn+fMrX0tTBWDcqZcGSQKF1J2u4v5PhvRJ9EAuxRiAcfjYauljTBgIMOf5ELDOJLLay18wEVvvPBKkTDC6Q8wucJTdgZy2vfRYxCIVs5c3ySiadKp0iNOsAzIMTbkDvHsugUvvWCvD7ucyHooybN4//hg7P2sXZv5xB74HdgykpYaGop710o1yvu0Kof0OP39JRpA9rHEGGcNBZqe470g2P08pDAYDxWMARvUTqhwcrgzzhJDaijdcxNcfXZelDkIhwOeOWilDGScsnbCCdDiki10E25SQR665GtHtNx5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5350.apcprd06.prod.outlook.com (2603:1096:101:6a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Sun, 19 Mar
 2023 08:41:46 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.037; Sun, 19 Mar 2023
 08:41:45 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/10] kobject: introduce kobject_del_and_put()
Date:   Sun, 19 Mar 2023 16:41:24 +0800
Message-Id: <20230319084134.11804-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:195::20) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB5350:EE_
X-MS-Office365-Filtering-Correlation-Id: 4784f520-a2fb-4f90-2748-08db2855c5b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yT681Q1ECEdddz2imbxelwRiCzmu4liK0+RzRVzRt4Yjzx+CWL+C+4fRBtGGryYDGL7y7Xlcak0o9xNHd5yE+PGqy2MfIrffdKNiZXbKuUyKpR4r18ejJHl1NrzPaoUOpdW37xF0mMlfWKLFwziONV+PBeQEQW7UVX2YxGISmqP58yhdWsQnt6u92W006EglGUlmbgKlqKYpVgLecJRS0Av66n0tQEMWCEyGlKqjUqOW1iPAWhuXQiDgQQmj149X4BdrQvVVosnaOCVg38/NZkip2ce+buG1ElIbcJTlHj2Ssl1oboH3notb+FThb00CWhpEsVB+0DdvmDcLh/vzyzFR1BrO7WUHXst/g0VPhvDakgXM0zahJR9npqVbrR9d3aG5hwfgYjtxfTGZSVem6w+Im2Bq6Ckd0arnMS4oM/v5ZT5Zza5GgA6ygds5lL7Yy2qnPdngrKxDhXPCE8BaUUvC6fdtZ0YoKVJE2MBskJrp/bOXeRJEwraD2YkcLxeHNwt7wcUteIaGgfksIj7BOsqmduJ7hbdRnc/zSU57/2bro65qkvLXXwAV7NfQzhgEuOzFbUt1RoAklWnK75qKYH6HPRaSjaAVCy0aXomaejESRMcNOGSSZ43dw1V7eC2uiAONN+VpxFHUpXZYL1P254ZPk8a29QfYKjq1L+bbCfDsqBNqZqxd8jTKw4hZSMjKQiKqyGRf4PffhQrnkfB6jQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(451199018)(86362001)(36756003)(52116002)(83380400001)(316002)(8676002)(4326008)(66476007)(66946007)(66556008)(110136005)(478600001)(186003)(26005)(1076003)(6512007)(6506007)(2616005)(6486002)(6666004)(38100700002)(38350700002)(8936002)(5660300002)(41300700001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?foQBbTFJkWNU48/cfYpBch9nq5V0wsvrLbBos0a5hIAwKmqFeSCRYJrAS36k?=
 =?us-ascii?Q?O1BDR4MolRoZ+I1o5MV0sRyTFqmgGYabM90MhSzFeyWckabqciLAzIjxYi4s?=
 =?us-ascii?Q?yS92sX433Qj6wbi3ewp7RVNAreywkQcqRJec3/XssVIH4RiIs0yfc3lA8X+Y?=
 =?us-ascii?Q?lfGNCoCBdrvqMyhzA4VIiZl6I+tHG4lZdvRT8Izc3Xy0S/4YmLiHsjewmWWC?=
 =?us-ascii?Q?6HEWXrjvHLVB3OWooWMCrz3BnyeA2c5HnaguNa1jeGc8dA/9KOhsf/IFEpE2?=
 =?us-ascii?Q?0dmVaMzgpCwhuvTg7TrYXaAfmvp0uQcKv1BqAs2z+nK4HeME2cWOlQCCIEB7?=
 =?us-ascii?Q?K8M5mgXFovU+BBESiNIwhYPQrbPu+ZfYqFdKXTiKFCK9yFHuV2XVTm7hIYI5?=
 =?us-ascii?Q?rNwI9Kwxpc2FsO2smp1GVD5NgtL6Jq+Hkn3zdoz04WXE+71dNLBwXamaQkHB?=
 =?us-ascii?Q?QJV+WKdWuTiEVMgxk2cNk9iSd494V7SMHXXMTNqiW4aoD8kPZ03H4DfQW6Md?=
 =?us-ascii?Q?gkzs7oR59Hhar1sozMehxy804Wo9k+cD/Gm0G9HQ3aIS+5phwuzUS2ZTKGf9?=
 =?us-ascii?Q?aT9q7AMIQCBT69/oeePHxI5LNJVoO5sK7JxG51vNSwCdBGrUEXcZBcT9BBox?=
 =?us-ascii?Q?wl9VsNYMJsqV1h+4zE8aTcQjWzj76j+3AerRztsGzUo+VnJuifB1ebKtAwLU?=
 =?us-ascii?Q?O+cJ/QQPeyamj13rM9KYvElPMIY+++i1decJl+NZLKTfPj5e02AODCGvjdL5?=
 =?us-ascii?Q?P1nMyyBBpy18J/zNWlPHejNPPyg1Yt3Pzvk4sawiGU0pEqzmJJYcZVbZFmp2?=
 =?us-ascii?Q?E5N/0sGQkIaXFo1dNjI0Y+0AmueZmp+jroCAjBrAkdQZvrzeGIyLBayobozH?=
 =?us-ascii?Q?DZhFT0De5BKcrvAFWFHd/VE4dl7L4ptS478ayJjGK6khEp7AxEKTaoFVept9?=
 =?us-ascii?Q?L/51LDvy1F4bwKFBCb26UHyJsstGZJboGVTC7mNL+HGgVnCJ+T7Z28rvCTRj?=
 =?us-ascii?Q?rTh99Ap2VFkAm3y7httXerR7+6tgT9G37zGhFRCPztYODNnkzONH4hq43hCh?=
 =?us-ascii?Q?4i8RkomU3lQ+W8F3Xa9s/CcMqbwA98boXxXbRbb6aRIajXkg4jGN2zXQ7GEN?=
 =?us-ascii?Q?0gzf2FbXkSGNSlm5MX+lAPaDDD6lj7rNpOv8/dZ3GCCeS3ZNXwJxdKOchGzo?=
 =?us-ascii?Q?y9lLyVLw7NyWcAftP6YF64vbdzI6DSfAh5WW1bNcIBKY//OjL3268qvqEbNi?=
 =?us-ascii?Q?Y3jJKmeBioO1W9q57BalnC57F/wbUHX4Ums2eRgMZsbceYrYwBW/uXWKnzqC?=
 =?us-ascii?Q?xb5lcooRkbdbSC29m/pmLuC//II6NW83CTJl/CKvOymOCmLmG6wReLHJY7Ca?=
 =?us-ascii?Q?Q/kAhkRfm3ygI1trE8cQZ9tcrh2Z1Vg1R5576klOkHftPG6sb8Q7T7a1SSlz?=
 =?us-ascii?Q?oWhSUyjwLt+VfI+hzZzeV9OfowPRU+13p6ulhXNv0092xa+kEG1lAjgPI4o+?=
 =?us-ascii?Q?KQy4zNXWdW/+Hm7U2NlshQG6kjpO+dDX5FgNmLtxd3YEGBUPcpBwFARlQ5eR?=
 =?us-ascii?Q?vPUnLuRQyHzB31xQu4WzIh23u1bd4Nx7tycCQHs0?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4784f520-a2fb-4f90-2748-08db2855c5b2
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2023 08:41:45.8425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rsd9711XFmkUTxfOXx7JsI2q8O0CdP2zqVv3uF0cGo62YwgBuLCS30wLCbKAnbG4wQlPbMrAlFrB2/H/Oal3Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5350
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are plenty of using kobject_del() and kobject_put() together
in the kernel tree. This patch wraps these two calls in a single helper.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
v2:
-add kobject_del_and_put() users
 include/linux/kobject.h |  1 +
 lib/kobject.c           | 17 +++++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index bdab370a24f4..782d4bd119f8 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -111,6 +111,7 @@ extern struct kobject *kobject_get(struct kobject *kobj);
 extern struct kobject * __must_check kobject_get_unless_zero(
 						struct kobject *kobj);
 extern void kobject_put(struct kobject *kobj);
+extern void kobject_del_and_put(struct kobject *kobj);
 
 extern const void *kobject_namespace(const struct kobject *kobj);
 extern void kobject_get_ownership(const struct kobject *kobj,
diff --git a/lib/kobject.c b/lib/kobject.c
index 6e2f0bee3560..8c0293e37214 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -731,6 +731,20 @@ void kobject_put(struct kobject *kobj)
 }
 EXPORT_SYMBOL(kobject_put);
 
+/**
+ * kobject_del_and_put() - Delete kobject.
+ * @kobj: object.
+ *
+ * Unlink kobject from hierarchy and decrement the refcount.
+ * If refcount is 0, call kobject_cleanup().
+ */
+void kobject_del_and_put(struct kobject *kobj)
+{
+	kobject_del(kobj);
+	kobject_put(kobj);
+}
+EXPORT_SYMBOL_GPL(kobject_del_and_put);
+
 static void dynamic_kobj_release(struct kobject *kobj)
 {
 	pr_debug("kobject: (%p): %s\n", kobj, __func__);
@@ -874,8 +888,7 @@ void kset_unregister(struct kset *k)
 {
 	if (!k)
 		return;
-	kobject_del(&k->kobj);
-	kobject_put(&k->kobj);
+	kobject_del_and_put(&k->kobj);
 }
 EXPORT_SYMBOL(kset_unregister);
 
-- 
2.35.1

