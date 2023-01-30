Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48865680FD1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 14:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236658AbjA3N5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 08:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236709AbjA3N5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 08:57:06 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2098.outbound.protection.outlook.com [40.107.6.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A033A582;
        Mon, 30 Jan 2023 05:57:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPreM8fznXb1k8rhc/cufHNUOxn08N84Axc9kug9wM3dVupeeUFbnNoenn947qqGa+LMNjiwtgkJqRbTYu8HLOMjbqtJWsbdvAj4Fg9k+Ffe52I2YPPsBpW067iR829FL2PzM/m1I7hJ1AxdQmJejCpfD5bI99PmofuS2Nl5rCmIowIaEnkjmeDCFIiP7zn6WuFE/zaeZbzBWUMPuLG6SlHm0m+uKZcphHaDUsZ2HXxt80GZjaCLYQro1vf3Cnp03DQWAviE7sHwjtbxFgHsKNfKJrrHsXx4rGvTGgZQeF11qd1eQl7rLu/MO3QpyrFiC68ryDwSGa/tWUbuF0y0Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1hhraKXnek1ogHM4jFo1LBDXhvWiJvsbERh69OUHiag=;
 b=GorfywxCKWp9JkNkJlBvV60529hrQYpd7VxUsgVwA1BLIWsuQsIeyxJp02++XJr5WOmQbe/Tmvh4ve11PmPahu22feC93Ulc9jtToL+knWgQMa4SWZm23qoHgmQP7hexzrWfRtkaTKFsE/ovaHU0hpuISbO5WM3wB/ASjRfey0O3FnCUK7Zz28YmrIj7b36Apk/c79doPzICvSTnExfrlgX3NiBbJ9bNOYO+WLA97z98YQDX+f21xSQjGgPIUdpHhA5IIb3Q640rkg8Dq3Ol7rVqYjpVZQ6yjCFiuvDPcYQrtkjrIi3rOKcfrRLV4kTcEycHWgwSgZRozd6087EvZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hhraKXnek1ogHM4jFo1LBDXhvWiJvsbERh69OUHiag=;
 b=GPt5WQiR/luv6+TAoJOCgIaUOggurECpoCgSPQY4eeHk31JmOR5VHz/G/CUSYfW98xAoEh1XAtUvosew1huOvcEM+qX8SCHsozfnMbRKUJ9CQOIjTfxL587ExI4Duspt+nXavv2vMJeS7VqWAlIehqeY9lPq+IrFCWGF+8mFI7xsu/gmg1bvYpTZdK8z7HO0yMHICsonzuAGeFvvOuLRVq20k63aF6R8ugTRNWQG85c8rOpWJ2iwsNSUO0Zd9DxI5GjfOHN4XOALA6epJMJEAryYKHYX2pWaQxuUg6N5M02UQwnzr6da0AnPl88eUpf+TBlG2ohE1vKWzQbyoibCkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com (2603:10a6:20b:345::20)
 by PAWPR03MB9081.eurprd03.prod.outlook.com (2603:10a6:102:33d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.33; Mon, 30 Jan
 2023 13:57:00 +0000
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::b42f:82f8:24cb:a225]) by AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::b42f:82f8:24cb:a225%9]) with mapi id 15.20.6043.036; Mon, 30 Jan 2023
 13:57:00 +0000
From:   Manuel Traut <manuel.traut@mt.com>
To:     linux-kernel@vger.kernel.org
Cc:     Manuel Traut <manuel.traut@mt.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v9 0/4] input: pwm-beeper: add feature to set volume level
Date:   Mon, 30 Jan 2023 14:56:46 +0100
Message-Id: <20230130135650.1407156-1-manuel.traut@mt.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0160.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::9) To AS8PR03MB7621.eurprd03.prod.outlook.com
 (2603:10a6:20b:345::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB7621:EE_|PAWPR03MB9081:EE_
X-MS-Office365-Filtering-Correlation-Id: c005f00f-dff5-48d3-33cf-08db02c9dbda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e5hR2mcVjS5AHpYccx0eRCZZ5/XhCYq27JCdlERZyu/prAbRoqI7TmeafFo8gWiJz2kBZs0EZ+j1hbN0D64SC7227L1tjleCxmiqNZr/NvMTtxV2QCKjnpLpBIVn+fFeQE9BX89ZKsJMQMFJxODRwxHxiN6PxxI7AoIntPZJ9H0bKihSNd9SlWeekpIh3IaQhicb2z07honre6NkqmPMLfoK3AuAIQ4Z1PbeJUvOEFG7QjTFaWOfX9fljBUbjM9MyFegbCAumfpQy83nwjuT29/V119wkX23OEsWYyVOedU0QYuEFHfTksKF+sAGXKx/xo/a+WcuOIXtqSzyVX4guVojp1/fA7XhUIRMKuGGXvi653nq/x+s29nGkv0/sUtYCojCimggEDrQfBfHmCACUyr5MbPrVY0W1dbuMHl4f2B+vuBy/tKzuH30jdRnzK4lFbxSLpRTDolhvEpaE7aMWnusTvrgcfGnHjk/2GWm1jIcNBycBUkhEOBCEVWlzv3wJSCPSeET34/PrDswB91MMe2zBSGncSENRlqmYEHeHqFU0U8g48x/JwUDsWD4L2bPEiiSEhtxeLv9oTVkW/ESjeQVntr8ZFRKjwkeEsyXgGAWzpmex98Ey82vXWlFlwUblA12Sx7iF6rhGflw03dnVQZdndGTybBsjPBjgopRArJai7QEYfLlXaiqC+WHZNe4OyVoeQZajAxwWpfB4brf2XIy9fKx267Dh+pwX1gG+C0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB7621.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(396003)(366004)(376002)(39860400002)(451199018)(5660300002)(36756003)(86362001)(44832011)(38100700002)(38350700002)(2906002)(2616005)(966005)(52116002)(6486002)(6512007)(186003)(478600001)(1076003)(26005)(6506007)(83380400001)(54906003)(4326008)(66556008)(66476007)(8676002)(66946007)(6666004)(6916009)(316002)(41300700001)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lD8nOfOAZ2pSPix43Djd04wg1NprX8Z7JL6T+ZOACE8LGYCy3P/1MlArnS2N?=
 =?us-ascii?Q?jHw8MReOPceMClkH2goRn0BJRQ4MfwWz+TBKK0KKKSoStCqzlyEqWE+Mefuo?=
 =?us-ascii?Q?mi8BAssg/dtBI0Pg1srqvQja+m5bNFQJ/yTA0dLmdzlfjwo0BsRy4k8sgB5Y?=
 =?us-ascii?Q?CpoMz7vUte53lj9EYx/DMU+Oeetvtp+MR7KJElw6w3fKlLvbFWUMf12c/gkn?=
 =?us-ascii?Q?NXfy7h2JE1et2XXO5nH8oUPJJe2wGigYYHiRv9InQHTq0nmlGsX0feuFcTA7?=
 =?us-ascii?Q?zJnVwZh6C+YHWVa7i40OPxV7cJWwZw6UV9V8zQm5cmz+N1/+yuIuYMFd7Gud?=
 =?us-ascii?Q?hsTCGo6MJDgnAHDUDGkKjzkudjWbju0v5FIAFvAhin6yb+rtkD3byZIPZ4iK?=
 =?us-ascii?Q?TIxQbhLCrS8ebp5EXmmJhk0ZH0RVLh+OmhNopjCvDcLKj7GXk4x8aCRBJOl/?=
 =?us-ascii?Q?DsrymJt83zZkH7JJVfQMcaz1xkJXabAYUeA+9kpo1qwdN2Lm4YMYGNTIiiA4?=
 =?us-ascii?Q?awKJq7jIxBbUA8zmqEaJNXgQzAyHQ1+5P6IU6/5NARhoIJdG6g/8WKjlRZNB?=
 =?us-ascii?Q?XDDL+gjtZ01fnnx+sQODhuDguKLH6+/JYp4Z9PgAdjHfbh+rFdqPtMQ0frKQ?=
 =?us-ascii?Q?wec9i4B+u5rcB/goU1Mf3wBtMd5Rb3f/qGAOv5NSjv5qf8xxfYheLoTIAbo7?=
 =?us-ascii?Q?knpzzyqX/IjzAPQnsW2llGdDkLa8HQknKo091ZB8hd0AM4wT3jzpcXqjg7GI?=
 =?us-ascii?Q?JLgsW4XJxQkXNb2guSK3AvsTyh3mD/M2QuaFbOD5JD/IZWrL/jjNKfHtngL3?=
 =?us-ascii?Q?TdKv2/rm6OC53RjE7cUvBbDWhTK3WNUgMWZDhwB2Yg4HAmuK11AdELF8NcYL?=
 =?us-ascii?Q?RoLhQS5Grw4UTRF2JAj9SsPsc4YuUciirn7qnbWRdaxyDz4HF1ThGL9TzpIg?=
 =?us-ascii?Q?3VUnAfcSuVB3KqlXgf8N0SVM0/sMyQZBgskRa4Gqe77xycltoablbEX/9PTP?=
 =?us-ascii?Q?YxInQLtD49GUHnR5lj5jKsPPLYJPVScy32SaM3xjsnSJr2VE9giSA7g9uH32?=
 =?us-ascii?Q?ovuvL2x6UI39HkUWxZEPLwhkub+Y6pB2zDzyHQwY5RzWdAFLb1tY3Uqge8d7?=
 =?us-ascii?Q?p2cFaGO+NgEupXgT6t7XrC9GQvwtgABPrtCXpXMsbqX0vb8SteiQL9DUgt4n?=
 =?us-ascii?Q?o/lI4ieKzz4cDm6JimRGcIwiot8ukWP3bxy+JSpKkTb7UeBKy9v82fn/o50d?=
 =?us-ascii?Q?U72ROfF4/gYxHo+e8zB+ckPj2WU8oHbrbMbsL3jXWYMK0Haul3d0PflL8Jnj?=
 =?us-ascii?Q?2zaPtK36riT67b3REq5UPB2sfs/dwEbEN9tLuclNklOOmNtOexrEZFedGZRL?=
 =?us-ascii?Q?yb/WVNlTUvq6Y0h9s/CPxL/fTqu/96n6Yhzgdl1eKEQSBLMIn0pDr49exoxV?=
 =?us-ascii?Q?bLMxQRfQN6569ZN+YWT+a3lrxLb1Br2Zmlk5Ej0PEuriVCCm3tHCeM7621rt?=
 =?us-ascii?Q?73TOqQOj8kvFmvqhKfEoCgqES3fnOuZgShbae4f5CtM18ox6y/17cqiMYrBb?=
 =?us-ascii?Q?thtM5zcqVUwXTFH6hOLUC5H8Tc1ETLq5Xm529/nL?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c005f00f-dff5-48d3-33cf-08db02c9dbda
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB7621.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 13:57:00.4499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fUc5Dy+qTZbeuQlivNMD9ILl8nwhv+plBKQC3a/v12Qtfq+0HUsxag/4cxipnr65wd8avIfQNlF7etYDspS/vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR03MB9081
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This implements volume control for the pwm-beeper via sysfs.

The first patch changes the devicetree documentation from txt to yaml.

The original author of the volume support patches is Frieder Schrempf.
I picked them from this [0] LKML thread from 2017. Since it looks like
his email address changed in the meantime I changed it in the Author
and Signed-off-by, as well as in the copyright statements.
I did some minor changes on the patches that they apply and work with
the current kernel.

checkpatch still reports warnings regarding the changes:
  * from txt to yaml of the devicetree documentation:
      WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
      WARNING: DT binding docs and includes should be a separate patch.
  * and the introduction of Documentation/ABI/testing/sysfs-devices-pwm-beeper:
      WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
  I am not sure how to fix these warnings. So any suggestion would be helpful.

Changes since v8 [1]:
 * yaml devicetree doc:
    * reordered patches to introduce dt-bindings before usage
    * drop quotes from $id and $schema references
    * amp-supply: simplify description
    * examples: remove unneeded amp device node
    * use -bp suffix for volume-levels and default-volume
    * specify default-volume as value instead of pointer into volume-array

  * fixup to work with new dt-binding specification
  * squash patches as suggested by Frieder

Changes since v7 [2]:
 * yaml devicetree doc:
    * Use shorter subject
    * Fix indent
    * Use units
    * 'make dt_binding_check' succeeds
    * 'make dtbs_check' does not report new errors

 * Reworded commit messages avoiding 'this patch' phrase
 * Fix wrong indent in [PATCH 5/5 v7] input: pwm-beeper: handle module unloading properly
 * Use current date in Documentation/ABI/testing/sysfs-devices-pwm-beeper

 * Hopefully fixed my setup that
   * mails are CC'ed correctly
   * patches are sent as replies to the cover letter

Changes since v6 [3]:
 * Convert devicetree binding documentation from txt to yaml
 * Use DEVICE_ATTR_[RO|RW] properly
 * Change Frieders Mail address
 * Added Signed-off and Tested-by statements
 * Fix module unloading


Frieder Schrempf (2):
  input: pwm-beeper: add feature to set volume via sysfs
  input: pwm-beeper: set volume levels by devicetree

Manuel Traut (2):
  dt-bindings: input: pwm-beeper: Convert txt bindings to yaml
  dt-bindings: input: pwm-beeper: add volume

 .../ABI/testing/sysfs-devices-pwm-beeper      |  17 +++
 .../devicetree/bindings/input/pwm-beeper.txt  |  24 ----
 .../devicetree/bindings/input/pwm-beeper.yaml |  56 ++++++++
 drivers/input/misc/pwm-beeper.c               | 135 +++++++++++++++++-
 4 files changed, 206 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-pwm-beeper
 delete mode 100644 Documentation/devicetree/bindings/input/pwm-beeper.txt
 create mode 100644 Documentation/devicetree/bindings/input/pwm-beeper.yaml

[0] https://lore.kernel.org/all/cover.1487323753.git.frieder.schrempf@exceet.de/
[1] https://lore.kernel.org/lkml/20230126091825.220646-1-manuel.traut@mt.com/
[2] https://lore.kernel.org/all/Y9AIq3cSNzI9T%2FdU@mt.com/
[3] https://lkml.org/lkml/2023/1/24/379


-- 
2.39.0

