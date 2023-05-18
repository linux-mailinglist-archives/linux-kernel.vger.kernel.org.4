Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D2E70862B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 18:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjERQoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 12:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjERQoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 12:44:00 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2072.outbound.protection.outlook.com [40.107.14.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CA8D1;
        Thu, 18 May 2023 09:43:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNA6L/2mzxkyX38dBo6EL8tjT/ypWF9yBFmci6fWRaVToNpaJlf6MXx8rGtGGDayauLgm2hdgUD/gMuIkgRCvftRH3/62yHobSDC7lz544YjnQLCVSXcLzw0BBFsyKTq9ZOXsacbVZLiPo8acaxOzbG0CT/W9FykNGowiSlsK3+sH/4vviV5+/nDzl9F3zshNX6LLba21Y/NiU1X8p8wNlwHVpyRAV/6vgrOA9jZXmn4vALjdGZu5uhb6ouRnwcjwQiTzbk5R7/CH7mBRfnkHG8RfT6JVJz+8f6qLJVX6lvcy7Ys5tqevgadTm2hKSIIxvLLRRQb4Ls8/fYL+k2e5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZIxX08vpdsKEBAXFVGTrWksGfTYQ7AeDlak7crJpec4=;
 b=oez63QtdpIqLIL26Tyaho+uddZ/eEAZsUf9IgdyhXbq95rgJXgN2aAmmQpQBkkGLwkU4CsYmIW/JV1Ue2FF5z9IhVFFfHCwx0akN3Z42x9FjCGQ3QLD3nYPhP6wsfM5A/y4A3TS+MuNEeIGv9/9YcNGFl7DwUVWW/Nwn+IKgBPFR3Rsyb4MW8OXDxkeYIpkTiIhGNd5CO3m6zs71G7dUfGteVFZiwhpf3eHZGWgErJLIT9mQI/Vs+3nHM8mHMaKZ6pXOnKXM4hPEgHhNZgLuyrJBiWW/y7iOGBXKFcfdiBj8fxL1Ag8gVdQPYujaeFPqWCb6nqZZVlpGJdskPcWnbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZIxX08vpdsKEBAXFVGTrWksGfTYQ7AeDlak7crJpec4=;
 b=L23K4d23ND5j7MtLA5G6FVCxVIjnkcAP6AinpxdmY8F2Sptsvv8rQR4FLyHOJ2W25r1bTiysv3/m8jnfWSSqsUBMcaFebcUj+BoXbGvWcgrUYVB1yh+DgnxPcsxzKxxjk8BNwzQlGcmucJHSOksTvVE0h+X8te8epRREFwD2yyE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com (2603:10a6:20b:43a::10)
 by AM9PR04MB8454.eurprd04.prod.outlook.com (2603:10a6:20b:412::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 16:43:52 +0000
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::9dc3:f8ac:24c4:9f49]) by AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::9dc3:f8ac:24c4:9f49%6]) with mapi id 15.20.6411.019; Thu, 18 May 2023
 16:43:52 +0000
From:   Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        ilpo.jarvinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        amitkumar.karwar@nxp.com, rohit.fule@nxp.com, sherry.sun@nxp.com,
        neeraj.sanjaykale@nxp.com
Subject: [PATCH v3] Bluetooth: btnxpuart: Fix compiler warnings
Date:   Thu, 18 May 2023 22:13:47 +0530
Message-Id: <20230518164347.2531983-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::8)
 To AM9PR04MB8603.eurprd04.prod.outlook.com (2603:10a6:20b:43a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8603:EE_|AM9PR04MB8454:EE_
X-MS-Office365-Filtering-Correlation-Id: 127bc9f3-3416-445b-29f4-08db57bf0fb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Z70/u4oVzO5I4hAF+IkLn0sLBTiuwLy03/QCqpDz56FSg5Js7NHkDkit821ueLc1rTTXaMNJ0LDHLy9wLCbROyQVu0Xoeo/kumeHsUGcfsSLsn9xeCTaMpCu9i4jV4qoIOghSFYqnq+Yvcbd20Cim3JAQZABBwVnv/cacjVKW/NfNMj1CI3/XZmVYgJFaw4+mJxDubdz8sT0XXExQTViwvLEZid9pydclOd0UtwG8DXj6LyQAURl/ubW3vT1ZqSzjDc8ChZZ5jvvUeva7TXSFFm67ZF8oE1sxFw8Ht2ApI/x/UB7arIoeYRYgheTjn8BEjpEo5kZUIBKxEKKtyk6lJLHMDQQCrHtHAIKPMXk/Qe++HiJAkQ/LGx1UqNUvR68MfsXyjREqKEwpiksev5ojms5EfZOXS+1Wb0O2bBWAB+YW7OrusjpP/TS4ijgMRdtKgqb5sl3u5oITEKlawKzCDZSwtk88z0UbwNEJww5V7yQYfnficN5CJddL2vl3o+WwMnZdXyhlpO/x1gbGErkVvgv1hF1n+yH5+QOWqm5NOFX8GoGHtsFImxmLzEITcOXMtC6DyqL7MRdSAt2uuYjx6N62SHnIReo0ePEpkWX0g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8603.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(396003)(136003)(39860400002)(451199021)(6666004)(66556008)(316002)(66476007)(52116002)(4326008)(478600001)(966005)(6486002)(36756003)(86362001)(83380400001)(1076003)(6512007)(186003)(26005)(66946007)(6506007)(2616005)(8676002)(8936002)(5660300002)(2906002)(41300700001)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zrJTzx2P1JhetJg3vgzM1vUvizvASjkQkHXP+LNfH0WSTj0K2jOpCtu+ZLr3?=
 =?us-ascii?Q?Dza/4Pu4Mi+0T9JNoFlhpoRecY/Cn3h0TpeQrEayOCZQxp8LXpBvSNf7nCYu?=
 =?us-ascii?Q?xQZijyUJGTa/RTc1EkVuLjvRX4W5hPmNdZ+Zd5Kq9K1iOc5sVX8z7dd/0N/V?=
 =?us-ascii?Q?DUTpVC3tXOcnI88OhEuPQVP9yBAIyZVYNcQ6m7G1d+XK0c7Mk4mmtSSc6kmx?=
 =?us-ascii?Q?Nd4x/65Z79fhoWhw4J8E9y+xGjzMrJSg1908qvIKbCjM0FJ0xCx38lNzK+xB?=
 =?us-ascii?Q?A2GLS7CpRdDvgLGsYjC5ggg7LL4mBjQK/Ko3y18KHtQgKCKTPBOHXMTZw4u8?=
 =?us-ascii?Q?bJjU2Poyi+K8BOmNv9n39A/NmmMetwo1H5K49uaqSoGKmF/JwE4wvpgfemT1?=
 =?us-ascii?Q?3a5dYSGCylOg7T4i5mnMk8snilnBoTHl+uiWMeiqclwqU/xpPN7NL8Z2bIUO?=
 =?us-ascii?Q?ZVs/bZGBe/UnNa7/IGFmtvepGEl0AvYAb1KFT2LjaPu5ChoHRxRnqrxBTVeH?=
 =?us-ascii?Q?0BpE4SF48oNlEYs6EX21mxjUbqlA9badWRhmR2/xigfLXiUvyl6PMnV/D5HG?=
 =?us-ascii?Q?5YKH30P8IDq/fkKko0GUywD+4ccGdAvduxkZRyIymFApgV56cRHu54KnKcsL?=
 =?us-ascii?Q?DUD7C8yIRLh14MC5HiQZ4U97K5JvO+5KrMji/mk4E1Mp0Zl7ZPHKl71zJhte?=
 =?us-ascii?Q?KLfGkgC4vCOTsSzTRDPJym3eqMJ54+emmmejXmnnz2REV5Yj0/dcadhzHLuI?=
 =?us-ascii?Q?+twdrBZ+9rBYDJZiuyrflMKCtdiJFtr4Xn6zOO84orlF6wtQTLdFCCnuMPaU?=
 =?us-ascii?Q?C4zbvrBayyQl298PHck9s/DdDWlnCZQc4MaWnu01G7mJG60+YkD0eded+OtS?=
 =?us-ascii?Q?7TDqyygiCeeGjCrE+jzCT3WN2nGsV6FpDXXYTwmiyxY3uFYcoGO4b4uNLNMp?=
 =?us-ascii?Q?iM94eBf2CP6/LCJeZ7A9yT/y+pVD9jpvRclAc6eBZ46ZGfK3Le02q+BgcQyh?=
 =?us-ascii?Q?M6KnCMe0P5seitOz262AsPK3WTiWNQFwUUgIu/18x6QBN2cZS+w2IWuYjyDz?=
 =?us-ascii?Q?63XOTwtG0+gBDK03Mjii0xeed2zmPVFVnrm0sM2QgTdZUOstzF7ujHVT2fI/?=
 =?us-ascii?Q?3hkCUQU8emeXStj8LefSGHGWb/r13W7wYM+lmBrlEBSJz3n1sdWkhNpgt7Hl?=
 =?us-ascii?Q?L+2kxCOn9d69Vi7KkuQrS05SOj+ohDc9fzUbWMitXT5970v2OhIs91hJ9sz1?=
 =?us-ascii?Q?h1efcioHwdlaxBx4/1WazxgEsEqQhG+E6c8RcKv6rSYS8BfvNno7/DkYfnI+?=
 =?us-ascii?Q?XTT8lsruSpOZoJZgF7xuIT4yQukquZ5mH5C/vWey42U/tNqd8VrvuCnWivY4?=
 =?us-ascii?Q?3CcPdQbPTnvVETCWh/jLq96kCkv89fAvA4Um02Dax4RRdCJTUartDbxU5nqv?=
 =?us-ascii?Q?PDkcGh1/SfL/3M9OkkH74Hem9OIXNMnvsU6mcWv9JEPk6smIfIyFlXIXWevZ?=
 =?us-ascii?Q?ReMbiwxJvOdm/duDhJfmTRPMSLRzeW9K1asGugSqOzHI8h0XPS9NwwS29LgF?=
 =?us-ascii?Q?DyYs73QMwk4zKOqi0gHYoZfp7rRKxKVasL5hHLIL2aKgzCaMQnaQqPs/Y+Sm?=
 =?us-ascii?Q?Fw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 127bc9f3-3416-445b-29f4-08db57bf0fb8
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8603.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 16:43:52.0773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3OiA8IVRVXhP76SYQ/9r9U8W3dII7f0NsnH5wA9V5gVzV9Xwts8hI3AaL9B6n6s71IPI5YUQN3Y2KD7Q48+GigA2r7U+T8Wt6Y0Lh/1/lxo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8454
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a compiler warning reported by kernel test robot.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202305161345.eClvTYQ9-lkp@intel.com/
---
v3: Use __maybe_unused instead of CONFIG_OF. (Luiz Augusto von Dentz)
---
 drivers/bluetooth/btnxpuart.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 3a34d7c1475b..52ef44688d38 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1319,17 +1319,17 @@ static void nxp_serdev_remove(struct serdev_device *serdev)
 	hci_free_dev(hdev);
 }
 
-static struct btnxpuart_data w8987_data = {
+static struct btnxpuart_data w8987_data __maybe_unused = {
 	.helper_fw_name = NULL,
 	.fw_name = FIRMWARE_W8987,
 };
 
-static struct btnxpuart_data w8997_data = {
+static struct btnxpuart_data w8997_data __maybe_unused = {
 	.helper_fw_name = FIRMWARE_HELPER,
 	.fw_name = FIRMWARE_W8997,
 };
 
-static const struct of_device_id nxpuart_of_match_table[] = {
+static const struct of_device_id nxpuart_of_match_table[] __maybe_unused = {
 	{ .compatible = "nxp,88w8987-bt", .data = &w8987_data },
 	{ .compatible = "nxp,88w8997-bt", .data = &w8997_data },
 	{ }
-- 
2.34.1

