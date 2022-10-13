Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B405FD933
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 14:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiJMMaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 08:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiJMMas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 08:30:48 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2069.outbound.protection.outlook.com [40.107.104.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00905CBFC9;
        Thu, 13 Oct 2022 05:30:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IpgjzF8kx376syxToPnQv4FMYD9P4sYLyu8VGYmyv3ACR/cO1nkn4HZVxiIt+3/60SF0iTm510WG1+sf9JL9v48uccd0voPIUZpwDMbK86kWa/I6RvyHQYiQVpyXDwZybenfnDr49gBYHVN8Rqg9Iil/By8OdH8EynpGuSnbTLGGCYNm5F+E5hmE2sDs6POWfK2btrsnDLE+l71ShwDN4MIaAV/+yzjBCnZyQVSQR91Xv4jRZI2ceu3hxWvU1Kq8d31kjUKaVeImkGMJYUuKf0COrgXGleuSzbUsRNjwSESGBpAKge42FOjFUcV6Diy7zd0NySs7w7+MnR5gHwzQ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46ZAQ9qWxqtUloi0kAN+sz+KAlr9s9qn52E+sXFb+vM=;
 b=UH7DSwb7yiwV+b7+rPdlvH03oMwGgiGgkgX0yu7rQ2X5v3dWrLqp9eGxvs3yFk/BQiWRv7AsdlPURsC3BZ+AoF8y6Jbr5sGEAt5bwvTDoES0pq3hrwIe6cvWKbP1O4TLtCDyNy9tfeEm4PFZJBFJKKs+LFoAfUxPQyB29re6KCjb7f37POgLPNnOn8zLaxmuDRNgEi1PSYhfQwix4uAzgitKeSz7mTGJcHjxydTFOF0hBbCA3wmXTZyx6VdXaU5nQrluyybJwwr+4WGAb2mwEl8bNVWLDO9uTARYWmHrJmauZTBRZhBJjYg1cRMmS1mJH5Q41fDs4/1Z/99RLU6GXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46ZAQ9qWxqtUloi0kAN+sz+KAlr9s9qn52E+sXFb+vM=;
 b=A7nLU1R8H87Zzcks6HONkx9YrSxSOGGceB2O0t2dDeSJKVESON6GNf0K12paA9piJr/iabUZER0v13WNgqIdibqpaBuz8KCGD3eIdtjeRbyF1HxSehOYQ8D4f5MlW7AepS0rXBz+pTIsyxSg5M0YENKjQLu7CsQfpGUcOWryMJQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8472.eurprd04.prod.outlook.com (2603:10a6:20b:417::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Thu, 13 Oct
 2022 12:30:44 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a%4]) with mapi id 15.20.5676.028; Thu, 13 Oct 2022
 12:30:44 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     andersson@kernel.org, mathieu.poirier@linaro.org,
        arnaud.pouliquen@foss.st.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] remoteproc: core: avoid duplicated rproc-virtio.[x] device
Date:   Thu, 13 Oct 2022 20:32:14 +0800
Message-Id: <20221013123214.750320-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0118.apcprd02.prod.outlook.com
 (2603:1096:4:92::34) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8472:EE_
X-MS-Office365-Filtering-Correlation-Id: d3721fac-c4d6-4b60-7a56-08daad16bf82
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hnyrYWt2piJ6cg4R5xBBGFu4JWNRNFBB/nw53Ykm7QDIQ0KlRHMq0hadJyWg1JgKtKt9UGY05FrY6j9NMfrAbA/Os3ZQ/zPUKHz7Cv2xidFdLLdxBM3Uz/3irhjVpeUT2wOUp4iPVZTDkkkYLJekIMF1GDfkxvRDT3+9y8wQjCk9txZLvD0xSX2NkIXH9fBoyihE+vnXerTyl9eER1+XWZyglMxsB3pr0/UsvIk4ZKJ7UJUry5GQmrh0dLddNHH4obhh05LB5N1OWSqxYmKi6gFfzbx+aNsdCyMPACMpXzTh3xCA1GjfstGuzueKm37KQ+nkuh469AvOMmHk1m+dd9PRY5RhXy2Mcojf3zTKqmzzSxtBwA/UKujDy1bMgyaisYiYhT0SJjHUZhhXgrTcbGKAe22gR6IT4Gnxj9cI0B+Y/eMqCXFSaNvzj61FJTjtnhA8xd553kWViPWjLBaSHYr1YDZA8UlsTZJjrmB+jrvyHKj6UH74jJYkSoAyidntCnF38vGrxUNKpPbWLp0i/+5+4nysTV7YX+TeD6azhy4RmZJSHpZ6xny+RN7KDqkB3O/62Gztr9oYx0Yoj6VaZEgw0wDNcG0OFwj9JJNLJbGugovgREn8PrXPy9vaPc9VSKRmrnZXzbEldiobFgRe+77yUAR7sSeGNjB6RmEzYGF0R+9KZhAouyL8VprsVjmjZSYKYfmkjLke4tyF4GgYSddGfF37T715kTyCLXxkCMyLRPV5lv70+h+Yxr/HMxsP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(346002)(39860400002)(366004)(451199015)(6512007)(26005)(6506007)(38350700002)(86362001)(316002)(478600001)(6486002)(38100700002)(8936002)(186003)(2616005)(83380400001)(6666004)(8676002)(2906002)(5660300002)(66556008)(52116002)(66946007)(41300700001)(1076003)(66476007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eA2zx0xsNgsKGjK0vAYmLBSReC3Ie0wsDKhLMY6RA1Mtm0c6s2phWv8izEaP?=
 =?us-ascii?Q?Mo2thUYf2dR0tINWAkiDVFQTwbDE1xuw90Qr2nPzyqAUQBEZlNbK56p2q8SV?=
 =?us-ascii?Q?Ik22oNtO7oh28hRen2JOQpHaxQA2QBPUgHG8+qayhiWDoUL1SBXfRszUha/1?=
 =?us-ascii?Q?spGXLejt3ADRDNn4+Vw3KCEWJmjUYppNNuC4nit81Oi3BSi+C7atpVBEZ4TQ?=
 =?us-ascii?Q?Yl2Q2CbzPKC5Na23wZpsjV00+5rhwfCxIO6miuIKexM7/1Vrin0JPny//1GP?=
 =?us-ascii?Q?zHQOpAJQmUrHx5Fl+gVY6VZmZWDL/Xv6IEqpMQDsNA17b69YPYGACSzM09Za?=
 =?us-ascii?Q?OSZxHeh4VHCZJPs1ptGyAU8TIImlIjSF6iQjznquLHwHOI+Nk5bLhD/2cvyb?=
 =?us-ascii?Q?IcIRlEnYK0pzqW7CROxYGqCshC5YmSnlWGA84iaCLxm7yqtjuMhV0l6VfVTm?=
 =?us-ascii?Q?GS4PZB2ikidneSB76NvnyTPx+0Iwj5uUAlx9QqB/ZpUXbV7RQPr98ef/HJDt?=
 =?us-ascii?Q?2kHcgoWXFH+J2LDYyeZMwDvyCI2xKqdE67i3JaPOVXkvqcuZYlm+fbZedBtD?=
 =?us-ascii?Q?5rcldsUZdyKe4RGbh5q/a/k4qu0Vr3d2chR88yd2eD4OMR1ABmhhg7kUWW9A?=
 =?us-ascii?Q?R2IO1ULZ5ItuA5jE2gVY48uZEKYDi9iTYmlgcrwhOxMs2ltygtRhGhzjzpiv?=
 =?us-ascii?Q?xAATwHs7pZonbXD7J2WyEUcTXpsoyZEHNiqj/hrj30wkLzLqLNxoxKrxbiI5?=
 =?us-ascii?Q?rsTOKP0z0XMxbUYa3MmbY7okzUCRKBLH/iuocieH3OsDbUKN3kEkedQEEPbA?=
 =?us-ascii?Q?WKoryilmy2tByGB5qZ2ab6FspXd79+6N8X+BonN+NX43oaeAlR9/X7XWLZmt?=
 =?us-ascii?Q?MbNjDNIe9V7cIIpf/PiJTAxuwqqlCp4dwREaB2Jm1uEa1hoqT0VnrSttKZ72?=
 =?us-ascii?Q?CCrij6lz60su1i4E9REBmgafTabD1P2oZDk2+Zl2TUi76c0G1GzqgdHi991l?=
 =?us-ascii?Q?GZbXLZkz2rzjRQxCGV68AiXpKf1AcGvYFFsnFgxQUfQxPR3Dgg/4csHsUcd5?=
 =?us-ascii?Q?grbJZasXj7Ap8jSzEUOUYDMnDgfP2Ebo+l2jhhHEwxK1jhoitEK430xHIyKp?=
 =?us-ascii?Q?KRtiZbcuV3zvvIpsw9N9r+xSOqwU7DBzjN92OOyUwQRzSD+wW5A4xbKPnsZF?=
 =?us-ascii?Q?QaZncjYkuFG115ikq5IzwsM0DuMTZ3Z4idrQ8ko6IalEGHLOzmmZ5sWilTdG?=
 =?us-ascii?Q?G3NNl0W2GFylveI4LOkUNqsR6OzyAlc4DmkNy0w/BQxxS6zNv9z25TNLHGMM?=
 =?us-ascii?Q?Oz2MCKmsAUvst23UNEZ+IDEOFKt12rQW+W8RMwSLi0suvcvwm10imPX8sOV7?=
 =?us-ascii?Q?Q9SqMIwpP1RymMAcBHwn0ubYakdvF4tXBry1lFfAGo220/yIya8Zs16F2xDk?=
 =?us-ascii?Q?JBetdcNUozGGJjgcGjYf6wUwWAb5bQrwF3r2zG5yu8ST6G3WKqKQAnv+pRTL?=
 =?us-ascii?Q?XhOjijjel7IliY26Wp3kOnwft+WSAH8FU/Z0axpmbZ1PbuC1Z39hh7gV+05u?=
 =?us-ascii?Q?PEoVL6YmjPrfGoTVgqRrGQ6xK2yZVVG7e8vqYMa+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3721fac-c4d6-4b60-7a56-08daad16bf82
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 12:30:44.4930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WzFdJlx4f33HfmZV4Y6Dxsv3BIQ0nIJKJs8HgmrMZO5SY8qmKz2mvqW7eAjRM2jZb5edGalDGufYoY6ZtjY5AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8472
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

When there are multiple remoteproc cores(i.MX8QM has dual CM4), there
will be duplicated platform device created. When 1st CM4 rproc got
probed, rproc-virtio.0 was registered. Then 2nd CM4 rproc continue
register rproc-virtio.o will report failure.

So use PLATFORM_DEVID_AUTO here. Then the kernel log will has such:
rproc-virtio rproc-virtio.1.auto: registered virtio0 (type 7)

Fixes: 1d7b61c06dc3 ("remoteproc: virtio: Create platform device for the remoteproc_virtio")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V1:
  I think this issue will happen when more than one rproc, saying CM4 + DSP,
or CM4 + CM4.
  I thought to add a index to rproc, then use
  'rproc->index * rvdev_data.index' as the id, but seems a bit complicated
  compared with use PLATFORM_DEVID_AUTO.


 drivers/remoteproc/remoteproc_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 8768cb64f560..03a26498e879 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -509,7 +509,7 @@ static int rproc_handle_vdev(struct rproc *rproc, void *ptr,
 	rvdev_data.rsc_offset = offset;
 	rvdev_data.rsc = rsc;
 
-	pdev = platform_device_register_data(dev, "rproc-virtio", rvdev_data.index, &rvdev_data,
+	pdev = platform_device_register_data(dev, "rproc-virtio", PLATFORM_DEVID_AUTO, &rvdev_data,
 					     sizeof(rvdev_data));
 	if (IS_ERR(pdev)) {
 		dev_err(dev, "failed to create rproc-virtio device\n");
-- 
2.37.1

