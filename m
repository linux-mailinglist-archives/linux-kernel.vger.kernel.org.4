Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27095ED555
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 08:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbiI1Gs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 02:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiI1GsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 02:48:02 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140078.outbound.protection.outlook.com [40.107.14.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461B42F6;
        Tue, 27 Sep 2022 23:46:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GzwKjtPxf+SG7c2z4JoOSiO1zPT7cEl2SFx2HOBOquU84D0QdbQ9xZSqpwlklE/RhCQjNApA1aHWnUWMdl1MjyE/RjD0PkmTeP/acTHcFG6lProNAgbPV0mQ+eJq76dZXAmjt9fPocQ1d2di/u/84Gk/GX1FNcKqkVMDw1J2+W2axUaqATUveO+0J45TrrS7zTlMk311IWX9K5j1N9VsFF5oVGVFAAzJJJgqaDyBuvLZWMJ154cS+GNahWQoy57VRPaaBMX3KYU5oHymS8I5tCGAUdRjrGKGmjXhl7hfNf5sjFrwtC1m25M6kiMySkUX6Q89d9dC3+FetUuav8ugAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/WX8b0WLAvS4FBD5UOa1jc2QwLNmupgAqwuuts8vak=;
 b=XNNR3eiKVR1htabhOx4dc9yNfUaaHWYLYBBy1lWp7DZD5Ab2BRI/BTyeB1iPuTRQRJFZYM6baO4DHJ4myS9Ztg/Ewlwk7DCVLGUekPMKSZH0T3xS2tGiICPsBa+qdxe90JbZ2dVjy8VlPeFsL9as4VONfMkQ0v+lrLaLA0Ue32yqOUafaa4qxfJNsg8CwazIHAeMmkrK03570P8ZIZn8xepbk/uO4KcMvcK4eOuv8K1GNnRqa9ojDBWY8BUn/PlcRBspSlxaOkC80vrqKX2cqGA58RLUmK9zBJamVulmg8/44fwZ3q9M2Jdg9I0+JtKr4dF80uNKR/zi99yVILjwIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/WX8b0WLAvS4FBD5UOa1jc2QwLNmupgAqwuuts8vak=;
 b=PgDJ/jrjG0Gmu6R7Q3fz+Ge0PcHmgAelL1S+UAj7tU6P38Vxn6jWUwFIcK2qpX4Q30elBc7tiAt2Ad/P2Wt1ZqrdPGjm6rT1INJf/BDFQ7HpBeNy7koQMAAKpUM3tglhjJ9sehjZbEmm+s0umcHIClMLAhcE69vXX+x468uz/Yg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8451.eurprd04.prod.outlook.com (2603:10a6:20b:347::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 06:46:23 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867%5]) with mapi id 15.20.5654.025; Wed, 28 Sep 2022
 06:46:23 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     andersson@kernel.org, mathieu.poirier@linaro.org,
        arnaud.pouliquen@foss.st.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V8 0/2] remoteproc: support self recovery
Date:   Wed, 28 Sep 2022 14:47:54 +0800
Message-Id: <20220928064756.4059662-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: 57e42089-bc24-4b3f-f5fc-08daa11d2817
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5SsYyIaVqLOUTB5OrMTSj9mSTCVrPG7qoKHgIa4nSsWdxvGaNEjsPTb4qF/r1w5EQM4dyKzzDFaWovWnl23e3AT8Xog+ja9TBONIPZ/DiDvhGs5RpH9BBnQv+3aLOtZ2mPXYdxPbaAN+AUrurz2DcsetVAJU8XbHp0zS7qyr0HgBwneNfBrMUSiXLnNlcHgBIi4/CPCrL2nGpYp9FAUA+WfXTF+Jg6L+KJzlwSdIZty7pku3/MEP87YclQZgPFvHNofz8mTh8twyCLpIMfrGnBERZByX09LBQZBk3qp/adRXQUej/d6rP/UfYBf0v9/1QsGAJ26ZT4cODD1inX2hExz1CEXnue3SIWBUjav/pS/9cdfijOpQXr7lsjf1fAnorJhBE9xX/IYq7yOClRxFugDSG1oMY80xyQJ5TkFaytIobo4O9EiF1pczfRBpUpPm9bdUqGE1Yfmsu0zNYklT6ssmb0p582KqnuKkfY8aJO5ltG+HW6X5yvjjqkTDhR13vhRUX2Rx+mK+m7DKILSCL36Sx9DUQSHisQ7fiOWXuWu/0GvEyxZJZvcOU/T+1575qrX+62+e1KKC97f1FHIAal+0dq+IRQeSK6hMp0WAff0IWzzI8RrPEsj746ok56ajHyc7XC/WvMrK+vtzic9LZP+impJfwIIeK0Van4BZmqNzfjMUL1TQEUBzflgDp4ooNPBjP4Qjn7OSOYse+LqJ7RWar7D18dLSChcdT7OoEW7OOK33pXKmr+uq7VsZj4lzZ4QIAZ6roqPGDQQVd/a6lP1dwKip8NYamMRxaQvSuxTfd+A/zJ6YZuK5qTBJgy4y/2i/y48l8w3XB/N2wzXjWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(451199015)(2906002)(5660300002)(4326008)(38350700002)(38100700002)(8936002)(66556008)(66476007)(41300700001)(66946007)(316002)(8676002)(6486002)(478600001)(2616005)(86362001)(966005)(6506007)(52116002)(186003)(1076003)(6512007)(26005)(6666004)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?onHdbNBhuFqXe/ywbb/vNrCuyKCBIy3yZbX3mnKRZbdJj4javUHPXSJRN4ND?=
 =?us-ascii?Q?3Ll+jjJWfCoLwAK9izMGGcFNDgzYg3EWqRpkiTm/v/Di7szShGvW75TOPL25?=
 =?us-ascii?Q?G525RfhWzOvgOY1A+iMUuOk5Hua5eB1D5Z7qYeRXDeerMDSpbV7hr5JUw8Bs?=
 =?us-ascii?Q?JxuQK9x3CHi8MDcv8R9XS5PD4I4sVF4Cew2hJC4XvYoHYyYSRSFiaXdtjjod?=
 =?us-ascii?Q?8/na1Yuhc2uHutTqQENOoq2PrE+evA9glNOboR5ZlmLTQuqhQabGxtRnkhGs?=
 =?us-ascii?Q?0+RR1+Vt2gj1ScUbQIQK3253HxbO9BRQ/2VZ2RO3jQpHXb5J4t3HVuxjIc7V?=
 =?us-ascii?Q?A91iRbyjf/pYWK2WiSMSG9t6e9hoYbhVXX82n8h03/ttYafPqQvoBqZ2CI6t?=
 =?us-ascii?Q?Gzoi9GyokOcGdDoC6xEZAK42q5g68+GjAQY3dZwJxdemECg0Ugh40yVF62Yz?=
 =?us-ascii?Q?lRbmPc7f2poN7zKpNW2cg9DmwHZKQ5jLGF3v89SdxULyFxlXoqDeGGrACa39?=
 =?us-ascii?Q?JETkGVfo36ht4J0TB2ySdF2umxg/UwATSlkS65O841eK3MBvD/qJ6C4RUuiI?=
 =?us-ascii?Q?058QyMy1tVbO3MQb4YQ/BQhea80+oHQfg1GvOVLcED9ukXglZ1LHCEuib8MR?=
 =?us-ascii?Q?xj3TqkvMu+Zp6o0yB0IJhBITA+NUN4gd70tA8yY3n6GQUNiOtuKz8Jvi4Xfk?=
 =?us-ascii?Q?hPAok/2j9CaqYu0rsxmC+rhXMkNkhp9HEkb+YOW2pV+KScV9IxRdNI1Jj34u?=
 =?us-ascii?Q?Qt5Mq5usGOE0KU+XpHbvHiYV4DeE+6aGpZ9pLOl9YlCYe+EjPOfVsdZmG7aJ?=
 =?us-ascii?Q?FCbj6bE8MAZ3fAPK2Dqv6Az16ACy71cyTwUju7bi8b4lTPh2Z/17SfkqB9VC?=
 =?us-ascii?Q?uUu6rkA3CScbTXzMf3hpDeHxZc+wBq2NN2fYjPsVAXJSlIv/mMKUVTrQg3/K?=
 =?us-ascii?Q?T9tsLy8K/nBPwLEY8fM2Rg9L2xTSYt49jVj3BGSBGF+Mrt+NW1XvbvgLDKRs?=
 =?us-ascii?Q?ic7goNfMoCefCHXxM5r2Yy2jKJU5ESW7ASpjA6zwZfSLvFSCGwzBUApIyT/P?=
 =?us-ascii?Q?hqlif/1LqZyHM0hFH7ahnXiOwSTobC+jpOiSLrtK8e1uv9Pq2il9a81Yk+ji?=
 =?us-ascii?Q?sdoE7c2caOSl4DrquucTN9dsz8ZhRz0hN1WwXFq9alUT8fKJWuhEwageGLxR?=
 =?us-ascii?Q?NQZVc9RYyOushwqpwqegrQYsZGEtK6nM6BADvUtvM6/PKfHCH6PBsyi3mULJ?=
 =?us-ascii?Q?takfqdcMGcI0fuBZAAoWp/Q6diTsrO+45nIOFKCTfgdzSAlBHBZ5oICX96O4?=
 =?us-ascii?Q?OXM9lM0cF4DnrXTToENPoLJi0/XKXpynxrNE3FhifkVJdeKhczKxUy/0IxXl?=
 =?us-ascii?Q?V72XrTtxzNg5PvDbu1oSfcV3jgN0Yb0o9vtneh/r2SH37IkTM/LsghJkgdw6?=
 =?us-ascii?Q?dXXLR7VFPiqfrcwcj25pHprI3mxoKZdl1wdpAULUebFA1jLhWsqi+p4Bv7Oo?=
 =?us-ascii?Q?6ZHsdYn3bbi19AAtekUU9f11/brKbtCJZzVvU4kw/lFwwAWrRx7FlS/s4r3+?=
 =?us-ascii?Q?bFL8oRcmvia4Mi+z9IoZcNiF3SLl1WOGazkR06Gi?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e42089-bc24-4b3f-f5fc-08daa11d2817
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 06:46:22.9686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wIUo0Nhb4QhV49Yle9QVSi44ICVAoiBcCFqblXczzAGo6u2OFmXfJTDa6q90ivJHy4W1mgpAG6CNXMJzdEmPhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8451
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V8:
 Rebased on linux-next/master tag: next-20220927

V7:
 Per comments from Arnaud Pouliquen:
   Typo fixes
   Added A-b tag

V6:
 Rename rproc_firmware_recovery to rproc_boot_recovery
 Drop the unlock/lock when do reproc_attach_recovery

V5:
 Rename RPROC_FEAT_ATTACH_RECOVERY to RPROC_FEAT_ATTACH_ON_RECOVERY
 Add kerneldoc for rproc features
 Change rproc_set_feature to return int type and add a max feature check
 Use __rproc_detach and __rproc_attach when do attach recovery
 https://patchwork.kernel.org/project/linux-remoteproc/cover/20220615032048.465486-1-peng.fan@oss.nxp.com/

V4:
  Based on Bjorn's comments on V2-2
  Move the rproc_has_feature/rproc_set_feature to remoteproc_internal.h and
 Keep rproc_features still in remoteproc.h, because we use
 RPROC_MAX_FEATURES to declare bitmap.
  Update commit log for patch 2/2, and add comments

  https://patchwork.kernel.org/project/linux-remoteproc/cover/20220323034405.976643-1-peng.fan@oss.nxp.com/

V3:
 Resend the wrong labeled patchset
 https://patchwork.kernel.org/project/linux-remoteproc/list/?series=621311

 Write a cover-letter
 To i.MX8QM/QXP, they have a M4 core self-recovery capability without
 Linux loading firmware. The self recovery is done by
 SCU(System Control Unit). Current remoteproc framework only support Linux
 help recovery remote processor(stop, loading firmware, start). This
 patchset is support remote processor self recovery(attach recovery).

 In order to avoid introducing a new variable(bool support_self_recovery),
 patch 1 introduce a new function, rproc_has_feature to make code easy to
 extend, cleaner, such as we could move "bool has_iommu" to
 rproc_has_feature(rproc, RPROC_FEAT_IOMMU).

 Patch 2 is introduce a new function rproc_attach_recovery for
 self recovery, the original logic move to rproc_firmware_recovery meaning
 needs linux to help recovery.

 V2-version 2:
 https://patchwork.kernel.org/project/linux-remoteproc/list/?series=621311
 Introduce rproc_has_feature

 V2-version 1:
 https://patchwork.kernel.org/project/linux-remoteproc/patch/20220126085120.3397450-1-peng.fan@oss.nxp.com/
 Nothing change in V2.
 Only move this patch out from
 https://patchwork.kernel.org/project/linux-remoteproc/list/?series=604364

Peng Fan (2):
  remoteproc: introduce rproc features
  remoteproc: support attach recovery after rproc crash

 drivers/remoteproc/remoteproc_core.c     | 62 ++++++++++++++++--------
 drivers/remoteproc/remoteproc_internal.h | 15 ++++++
 include/linux/remoteproc.h               | 16 ++++++
 3 files changed, 74 insertions(+), 19 deletions(-)

-- 
2.37.1

