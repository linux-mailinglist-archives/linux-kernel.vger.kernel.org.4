Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B006C0058
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 10:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjCSJ1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 05:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjCSJ1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 05:27:34 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2123.outbound.protection.outlook.com [40.107.117.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B4E19F37
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 02:27:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DW5WaaAXFBfqRsLtWMFuA8TZxZLbeckBGdlf1q2vTEiC+WyQMJ0SMEi/UhrYGEqZnHWh0WJuLd75Uhe4tz76IxQryYEzd8xZfb6cS/h8ZmHuLRsjzcMdfobzWc6+A/zgOegyH5f6kNPIdWEkUXHtiseREYZgyWgUs/Qi+YccwqwxLs2e8sqOVEwbs4sRTycmG1A951dzYB2MN2sEOX6oUWpa/Q9e97613z8smK/DIuxzS64m2ybsKl4+0UIn83Z9iLqNbXvBN00SrQky+RbpSRxIaT7LRUIvj0/VTSPHMfWB2sCt81QkOmI8dq9/PAmzGE6Id0fJNbkg6zH/ouVHlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/Ly6n6zozyf6Q7d27WyhzYVqOabq1IPEThi+wvRY2o=;
 b=lghzOV8zRDfRQxtR76jse2BgaDPtBqdQYxySm8BK9x4dRXBFDkIy8mzLLWaGlPuWtUwF+CleKHnFTjJ00o9ORIMrW8JLegUyVG0x7fxF2a2eTorKGHfp0urkZFIm5PXlDIITNluAFPPj3lLK9pFZGUQhmX5CmQqlMWN+hWJxbFwlduR+yxDvlqfeTVuegyqGi2CBUKXARubYiSRMS6sM7gOLOVdUujezNabDyt95gG1NCEAjIbHL4qSddNLPpVssxT+pPUljA54kCm9pbZMW00j4L9fw2l+DIh0uOvw9qMYDofj/FuU8hh6KwB/WFAbaf1gKYI4mAiGo9ptz8JEAEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/Ly6n6zozyf6Q7d27WyhzYVqOabq1IPEThi+wvRY2o=;
 b=gzwR/TQMQd58w1aRTywAJ0krwb5HsY3G9q0oGEk/lktczWED6eoLybJrVImGhmlmdXgAGbpbR5BeN2Zp0D5mLy5wQQpPrSgSSH4M0Wh8+5ZXbU6agbIR0RqO8XlhiUmmlD2nLidc8QrKchGeLW9Vcp4eONHOPI+OGe10F+X/M4ra4CPNUEy0sgytwNsGoonZDjlucFw8YHxDiPgQHugqVWEoB5NU3PGeX8tMRCsNXn4xnK7AsyVzn0kZCcvurumnZMLHynjrob1ZV3TD1hpmzvuDGu1LbmXBJ0qksMFLIu+62V6kPw/ExjPP62xtpu4cgBPEIpsKlM627PBjbu1Irw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4012.apcprd06.prod.outlook.com (2603:1096:4:f9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Sun, 19 Mar
 2023 09:27:05 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.037; Sun, 19 Mar 2023
 09:27:05 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2, RESEND 01/10] kobject: introduce kobject_del_and_put()
Date:   Sun, 19 Mar 2023 17:26:32 +0800
Message-Id: <20230319092641.41917-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0137.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::17) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4012:EE_
X-MS-Office365-Filtering-Correlation-Id: b7655930-280f-42ba-8f6f-08db285c1ac2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T4A+JE7DBnIk8qGoYUz06DM2s7V0aIct6iWwL6ox3Tt0JhBMfBuSmQJ875/Eec3Wg2TmlR7jnGlKy86tAsmTu8zC30xI70OXRrNj/58rVwquYzRUl0kE2EJSaFLlFuzakVnjNjxWYX9ZPV4X8L+LLrp2rgat8ZkQZ484KcGMCVapn3xxGyiUdsvQZW3q80BIq9ccD04fuc5f+LSsz5kCSeJ5bEUWcJ7QVXcxgUHzq66un4HpJyk3UQ1i+cN6Te08clxQfX6qFZ+agrCdowPYZoR3EiA4b7KZssm//9ILGcfBFcZNXDG7+VOPpNPId5qzq+3/fOlLqjN/ZzV8O4oIz4n8iASaplPFh+a68ZfkPjzIlxaEfO/f20Q6kmg5FsYYjZz0Md8BR+gXi+Mk0DZ1VCLXKi2v1BEHOLjNg67+2p+c8y4rrZ0ONhx3L+miPyU43LJ9htN0pYr03ZpsN9I+9NlhCCRECtNErKVNLVvWhtsfqHDc3sIm41cpOKNUx2p69Amz60db5xEByh0Lgw9zlPdlG8slk0qDxXXfsOtE3tl/EuuIPkvRGeX0kYkeNtGCrGb6PVlGkvw/M9D7/cksBGQ8v2yWGYlgYZ0j/vXo++X8jCQrChEblqKgbl/QhkpCaaHJAp97+7+haO6GPxxnpT7k/Nm7lABmF7pr0dG0t2k00k7up4lv7Ksat0/Q9T2iqXR0V+J2Eskd7BvFK0wPQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(136003)(366004)(396003)(39850400004)(451199018)(52116002)(2616005)(478600001)(6486002)(83380400001)(6666004)(316002)(8676002)(66476007)(66556008)(66946007)(186003)(26005)(6506007)(6512007)(110136005)(1076003)(4326008)(5660300002)(41300700001)(8936002)(38350700002)(38100700002)(2906002)(36756003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o4m0N1LlGV7da3PMiuSqsRY6JDc4BuG/MtkZzw1vnKHZdjveDFyP1QeByJm8?=
 =?us-ascii?Q?XcFSP1b7CXpGHK/M11zkZaMndNAYSCbnOfC5E7QXhKy80mogvcK21Xdn40NC?=
 =?us-ascii?Q?PJGwCdA+vHMr+tA/cXtsVL7hz2Em2jo0rWfH67QKMRzBS3nVwJewUbJz4mm+?=
 =?us-ascii?Q?86g8L45HlMBWQ69atd24z/UDKSK69KW/YYidjtSaNAILlWB2SLPVqLduz1Vd?=
 =?us-ascii?Q?RmBmTzT6ukBngQSlxxhzJUYR7Y92AsX/Z5GiKq46EMAXmqBHSNBwp7y7J2GV?=
 =?us-ascii?Q?NyEyI+JysXwWj7sc4L8U/BCIhJ2Go/2HHhhRv2n267qKp9eYcykune5kwuLf?=
 =?us-ascii?Q?+YGw7R3Qg/HVCrekA6QuZ+T/XeKJnxvqfRoJer53HI1IJzOByANhKdS7H3tS?=
 =?us-ascii?Q?7UzQ0Dd5kyQmkiytno6ELR+NFcX1BjmE3QeU53m+ZdqigdTRvXom1gxfYn4l?=
 =?us-ascii?Q?5OJMd9byRmpPz3o8lEZsQqr2sTtDzHvwWvE4BGasCXFc56/H0CwFfkOIR4/v?=
 =?us-ascii?Q?pv4yNefejgdkivAPDT1NnDdmTSP2CIiEQD8Ry9v0lfBD2jTbViugLLqe0Fes?=
 =?us-ascii?Q?xWzrcrlWM11zOQRFxOy6NWxs98mh8j8o+CrqQqQzj6NLaV2sSeswRiD0W6QC?=
 =?us-ascii?Q?LC3q+AMwuZ9A82mCOC3lhrdX6WkiaZSykgP/2N+9xPjGSwR8ZgP+DMdS88gI?=
 =?us-ascii?Q?gRhvz1XTo9prSfhzF4ZY6nHLofzd6nNYzCESrz8ibRh6N+ZQWDVcOVPcEWyM?=
 =?us-ascii?Q?Lhm2tqa1/wHqYLOE80F7q9ToxnBkwPV+5CV9S3N7i6You/bI9V2+12QRKATi?=
 =?us-ascii?Q?sz+boE34F+XnvNucSxj75Sw5E0HxdT73yjWnB8hT/088wQPImNSYP7pbqeIn?=
 =?us-ascii?Q?9z2TJwpA/+RSq9/03MWUF/2FPBopIDRi9jCQx5RC7WQ1fbCPGk26fNZPlajN?=
 =?us-ascii?Q?0cOvUz2fwja2X6WEGW/U+HbtPir8xEkOFC9QZia0FNwYxpyvISKhJyp7cakz?=
 =?us-ascii?Q?Zye6CanaGJN2rPvXb7g5giW/kw28eOxWd/Ofk83qi31CNkSTPqF6bSnPDcgI?=
 =?us-ascii?Q?R/62uUas+QyKHnY1n2ZRQq6VWhL/62q7By1IQ+hNdU4yfSWJytYnrjdyBeWd?=
 =?us-ascii?Q?iOpY12hG52AF59Fh68fQTQ4BciMpDNnkhmam+EynJlMfGuPec8aNY68oqSng?=
 =?us-ascii?Q?q2yEXuzkg5rGdhMqSXDBJtR5t7ecF1+oiqHVvSkbAjeNW9LQZACzqMb9ThqO?=
 =?us-ascii?Q?NQ/hytwL4TjrBacA1VOrj/0HUMlRKOK/8wG3z9iny12iyH1lAdOnvx8emaVI?=
 =?us-ascii?Q?DTpww7/BBzX3XYZlvWTodQ4R02MF1w/5JgvrODjGjPneP650u9d7tumooUtd?=
 =?us-ascii?Q?1ywv+Kgm3wZWz70vjT+Rz+/U0uwiy7G+GtrEZEujW7EdDG3mer64+N19vQgh?=
 =?us-ascii?Q?d+jQW3Buf9e4tQuMMWXfZoGYfFJ3lzI7mfUiRzzBhaYcYMEoNhysp1hMRk27?=
 =?us-ascii?Q?StZJkMT8ofw4YM+qlwtmMZwKEzH5oCt98kNr0dCCS4jYqGseAljj8yT3JzQ+?=
 =?us-ascii?Q?mgyusFTefhaLv2mmKRAEsfCl7OQ/kBOf/bJsRnAq?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7655930-280f-42ba-8f6f-08db285c1ac2
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2023 09:27:05.5367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JjnrRdtaUQvX3jPVse/tT2/yjMKQHR0eOfAbuNNhdiIQVanJyhpGnirTgdSZi2id6nj9Hv9cn5ov78ciShW5wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4012
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
resend patchset to gregkh and Rafael
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

