Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9DF66FEB18
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 07:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237044AbjEKFWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 01:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjEKFWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 01:22:02 -0400
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77BF4213;
        Wed, 10 May 2023 22:22:00 -0700 (PDT)
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34B1GhEE028406;
        Wed, 10 May 2023 22:21:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=proofpoint20171006;
 bh=HVq5hN4d9TzY9cVrkDSJEB6424m4tTTrHWqEtA/4wbs=;
 b=oLtTlHor7/M62YYfUXLIVbt/xOH7ghD/C0gGHRidXDq3U07J7+tCepP0AyZn/cWT2TIM
 NvqCrQmB0/cXGn7325THZ8bcmp9r5eGrXpKCCrDOk6g0098AB3LX0evjJglyn4A8gpZJ
 LZHVYhb48nfb2j7vZDLUAcHYaHrZrJbl75pXyavU9hmsbvE6wRl0KWQNHzQaqIj4VCtu
 vwRnlW4fP6AMgJ2kHr9eijiUxfl9u7WIcVPb7ojMqFCnpJiLwyEmKjBJCUYeQNjc/TtP
 G3ApKG9ph+B1dQjulUq+3PZ5/21pgQ9Z2J6mpJP9h17SpiNsqv2sPhj0DzkPL5aFa8WM lA== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3qf7jvdbvr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 22:21:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3ANPU80WHIW9De9jevZA0pSxI7ITnAKETSV5cGewiiXvHzM6i4kwH5HUVIp1rfcFpUHy/tj6bbus5JXmXUFIiE95rEunM+oFir3sWDRwB4XdYUvZ4z5ms/bdjCgmaGZnkorPx+U7ymL3t44LRNClFPeotkWad6ThBov28fGG6/iUPmWckZQNvyUAlezNDMEBYrLbeYD1oeL0F1RuWk+2GB5weDY9SswVeHhNOS+F2BjpOibZ8R9rxx/PZnf6Gxcc/OikwwnFn//FFMvZjy4Om9MbOuEHwuc0CHFiUyMjMRVMd2ZuUimvCDmBRheu8VGaivL1/OGbUEQo6Kzp6d8nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HVq5hN4d9TzY9cVrkDSJEB6424m4tTTrHWqEtA/4wbs=;
 b=GXK2HNN5I1F83/E3vA4K6v7dfAEn1Du/zaeCIYJjm45EBG3S5dnzEXb2PkOgBQ/yPOTkKteEk3xIrec3HwfYilPhhcQls96C2fHE0ZAzabDSd9WcywYP46FwXro3wT1JAMzWVCjsS4I/b/1Y7SwOotSeXxLu4NHxXYv2CeD0+34F0/9IlGnJS+Z5kRezb8zVEV36ei9pEv0c0vqkRY+KZuwvPyNYKTAknbpeUTW2syh+Jd7aCa4tJdG8GP+vBlAgVg4hPMBCJytuhsVNTLYCRQjdD5g1BaedJn+If8I1nVwoU7TVrA4PAjZ+yy8TufNKJ0j3RMIvVK+iOCkk82/Umw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVq5hN4d9TzY9cVrkDSJEB6424m4tTTrHWqEtA/4wbs=;
 b=OR+CfhMsxZhwzECQE2t9IDh56xZ+v2QNQ4VU0DOpJBX5dG2tIKAjeWahTqBxrNBHiwEQWP0+AS8Gfwxs9OZD+31Dkm8k413+mLb6jXGKFYXtUFQR/Iz76pXcca3cG927bNQEfYByu55pXaEYJzRry46Mb7avxrwy3TKkc1Qmr0nMNNsEf8zNPbVDLgncOQ7JESgo/6J54+6esSRASQyzGtRMKzf0Xo9Hdjpxrw8ahym2unfTPsyirrm51woijocXrGAknDuPDN/+7ed8sh4gOh0gOzvxhXmAXuJjKgvnTM2+a+MJSBsag6fRIhS0RTyuV4yWWJFUYcH8Oh/yILYjOQ==
Received: from CH0PR02MB8041.namprd02.prod.outlook.com (2603:10b6:610:106::10)
 by LV3PR02MB10006.namprd02.prod.outlook.com (2603:10b6:408:1a1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Thu, 11 May
 2023 05:21:30 +0000
Received: from CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::e48:dd5d:b7e4:4d54]) by CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::e48:dd5d:b7e4:4d54%2]) with mapi id 15.20.6387.019; Thu, 11 May 2023
 05:21:29 +0000
From:   Eiichi Tsukata <eiichi.tsukata@nutanix.com>
To:     paul@paul-moore.com, eparis@redhat.com,
        linux-kernel@vger.kernel.org, audit@vger.kernel.org
Cc:     Eiichi Tsukata <eiichi.tsukata@nutanix.com>
Subject: [PATCH v2 0/5] audit: refactors and fixes for potential deadlocks
Date:   Thu, 11 May 2023 05:21:11 +0000
Message-Id: <20230511052116.19452-1-eiichi.tsukata@nutanix.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0074.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::19) To CH0PR02MB8041.namprd02.prod.outlook.com
 (2603:10b6:610:106::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR02MB8041:EE_|LV3PR02MB10006:EE_
X-MS-Office365-Filtering-Correlation-Id: 05f6373d-4a9d-42d2-0bc2-08db51df9347
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /tr246l0LEGeULVfN4XIc3zZ/gOaHgzvn8CNHoOqMEV0E3mPh9rGnl16BVtBVPfrp9CWH+NN+kAFxew7/kplInzw19k1Y1UmJ65qYvzrvnySQozalDrSO59J4a846vg39ijGXFHbTl09c/FIlB3mN8NlZk77nCMD5sTDWoZ5njfALmXpB5UVqPj9QdN8WEuODtyferENamzqg7dwCPpC3jR6WId4vaTP/H8pKa3KDG1UCcPdUf7JgG+T2etaZzSw2dfuM/eP2HhhjnsbBZfJHDKjVxcCBHUv7Kv25vufIGyeMS3eEe5c8e2yl9B0vtrg1q0QkYkA/ku3kA/WNGyHXYUA3te/Cv0tarhlzmRX2JiyAsmqlVcoaBTFllW3YaZUIUCN1AF051eJqBGPdvT1Gu5LBVseLtF3DXynh0Ss3rOU9SCpVUpSfUMuVCRmRD/owxRriCy8minWYIM6VKs/sZbc2D580qUCHCfj635lV6Cqou2j322gdq33vhhAHDbVYPWTDB9LrU/7+KjI7DzX8rtbofAdh+X0jmR/MPR93yUSrP1mOHaKfSB5PN2sKTuVfGGsb16nYKBs3Ark/yVF3QYpLSnMrcICaw6ylMHPYpezdkvW9/MVK0I7Y4fcWjDZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB8041.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199021)(478600001)(36756003)(86362001)(2906002)(4744005)(44832011)(5660300002)(2616005)(38100700002)(4326008)(38350700002)(186003)(316002)(6666004)(6486002)(66946007)(66476007)(66556008)(8676002)(83380400001)(107886003)(1076003)(8936002)(26005)(41300700001)(6512007)(6506007)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W3VsNDQy/QeEf3AY0Vka+C6Asend1OZbAPzSxNO2MWOeeMDhXFZb1JgHG0fK?=
 =?us-ascii?Q?OLdiO3saaqJhG6j5hFz4wQZ2WlF7RvMefZc2v1G0t3c33imyDjsIf10yAnPz?=
 =?us-ascii?Q?0440sx85B/bHTO3ZPSJaEk7/tF1ZMefaXvyCRyqYcHAKBwgxCgrRtXqajhYB?=
 =?us-ascii?Q?NacjkoJ+mE7/ALQfhpBCTBLwEY8QBfOBaSumT7sHN+nnPL2QClcbSPZPncIM?=
 =?us-ascii?Q?pdNhZ0vzGYMZS94nap7uK+2cV0HogyKraq9CaCZ7ECUEtg78rDLKiAKJlUoB?=
 =?us-ascii?Q?ccSdLNai+pFBHG5b3syNBd6CFL8sTyrTJn+qdb7XbzzVnP2CWPdeNTqU3L/c?=
 =?us-ascii?Q?MkORhbYM9Q7mPvbJqjerjnRhuYBxVJkmmCUvOl2NmlKrDUNDTscPWbyJ9sgY?=
 =?us-ascii?Q?HBZhQpooPIrYVUS+hsIaJNvbu0mYDxC35VC4BShyuCTmWOKcl4ZGJ4e4W1ZK?=
 =?us-ascii?Q?rCq8GlEI60/s/soqeeMRwaGmGGgZ3w+VN2P9ityqvQeAJaTIO59PPyM3ElV/?=
 =?us-ascii?Q?qjqcy6xQdq32VKD6lC/LSNQpOEB9XO9amazXRjhpSD172fX4ph+BZM4eamON?=
 =?us-ascii?Q?XtIVnM1mrHzb3UQndThT5y4UPreSAytdA7whhbPQbpnpisP+t4JPbrGz8hfo?=
 =?us-ascii?Q?28xWsBa4EKEDUh0wamJ3lZZ6r3/Idu9nnqMzEqhvWyzMdE0TTtagWNtFfdAf?=
 =?us-ascii?Q?fB6ukRi0weSXBBXsfqgjd6RZ+8IcJDVOoiI6TQtITsHGN0ySqeLZsYlLJkoH?=
 =?us-ascii?Q?R3M98PNE3konsaZXUadF5E9udJzpu7AtuG1Gb2dCdRAV0n8l+KZECJp2ewDU?=
 =?us-ascii?Q?rNK8DrS2hLVg3LvEDcibzzZRV0TIg+1ZxnlQ5ZSfdZ5SeZuKGI1o4g7YudeM?=
 =?us-ascii?Q?evewclsyL8FN8od5KzJcIg5Wbu7PMka0fhyyY1XGb4vk1kbfVhV44Bgya021?=
 =?us-ascii?Q?1yk/yTvmQcdGXvGMn7LYWv3kXR7uqhUUzugzJ3nwmxktrxVPpYR/DbnTqSU8?=
 =?us-ascii?Q?u6plTSONNk7gEPy9qLYXEb8wpP1XXnjiHyKXZIO1cJdtqrt8idKpSIMh/47O?=
 =?us-ascii?Q?4sJMYHEoYU0Fz4ry7C+V/mWcFemQ7TH+pyajOfEyjhy/TGpz1zRc/mzVBC9/?=
 =?us-ascii?Q?nWlalFJY2CWhaURLpNCknSFXyFw7St0QaS3zi2YA1nfTlt1IR+O6PvCWIxE/?=
 =?us-ascii?Q?wkrtp2YOpBU/qF8mXZyW53TYmMGrZUFqvf4nhICQmCCNs9xjymaq/MFKgSFn?=
 =?us-ascii?Q?vnQ34KI3HRuIWy4dCRQ/5bzfGHyY6VnbRchALalspv8xnLHUT/GOKFSdWnAX?=
 =?us-ascii?Q?1vUB7vv/rrsNCR2NY1LQifTLZD/cQF2cIoP3cbfJVR/TzJF6QiVm4hOZpzC/?=
 =?us-ascii?Q?xwR/IttAwkE1C+0sg2JINr1AZa2jQz3xQLCbNasBZH4Tf+rkIL2mBz204zBa?=
 =?us-ascii?Q?TNCMRKaO1I0WOuh3NNpizx80htBbxC5M4Loj+Yw3+LZecYEaHT2ETShyuVmQ?=
 =?us-ascii?Q?+uyRAPH/+u0wzOlQh+nmiheyPuFtNZvoJx5d0cmwa4APsu9WDyX0eYwew09E?=
 =?us-ascii?Q?OchV+xjAPrhBgY3sY6sN5zgWV5wR4n3VnOJYj0IVm1IYliYY3KevTCROSBZu?=
 =?us-ascii?Q?qg=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f6373d-4a9d-42d2-0bc2-08db51df9347
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB8041.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 05:21:29.5440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cry6IstuDLQlfIFoNqHyMYWDTKtV+sfn7ILRId3zwd1u/InzkbxAtQKlnK8GsHwmSMYupat7pizciwAydNi0OiL0XioJs1GmVth/8nX2hN0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10006
X-Proofpoint-GUID: yfYWgw0knsazVdvVszAUWvyw72HWo6oN
X-Proofpoint-ORIG-GUID: yfYWgw0knsazVdvVszAUWvyw72HWo6oN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset consists of the following refactors and fixes for
potential deadlocks.

  Patch1-3: Refactorings and a small fix preferable for following deadlock fixes
  Patch4: Fix for deadlock caused by wait/wake_up race in @audit_queue full
  Patch5: Fix for deadlock caused by missing wake_up

v1->v2:
  - wait_for_kauditd(): returns 0 if @audit_queue is not full
  - Add another fix for deadlock caused by missing wake_up

Eiichi Tsukata (5):
  audit: refactor queue full checks
  audit: account backlog waiting time in audit_receive()
  audit: convert DECLARE_WAITQUEUE to DEFINE_WAIT
  audit: check if audit_queue is full after prepare_to_wait_exclusive()
  audit: do not use exclusive wait in audit_receive()

 kernel/audit.c | 78 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 50 insertions(+), 28 deletions(-)

-- 
2.40.0

