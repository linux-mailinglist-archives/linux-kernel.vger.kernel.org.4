Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44DA95FE756
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 05:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiJNDKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 23:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiJNDJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 23:09:55 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2042.outbound.protection.outlook.com [40.107.247.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5656FEF5AC;
        Thu, 13 Oct 2022 20:09:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gzL9c+rj74JTVROek2sjQdE36Io+E7aNDM8XDuWRaioP5nZLJ5L/j6gGyRIsX5R+GbYhTrJEOQobgfCH3/qx7inKE99YXSdZrgtbBIi2UgmwCv0FFwqBvGJHs8IPTro26s8oG462McUiQUcVe7oV9BlIafx86N3snR6bK3KPaNhKoVr8yiJQ31ErKsqbwZ+p2PX5SPQQHnSnTYlCkisM/teKslOor9GD0ag5WyHI0TIzNpKVDAO2qcbMgDDdPI7tuRqlNhM5u5QZR4kbGl63bda5K+FHi/La4znAZMJc+uX0rbv7vJjAP2I+Gis6Z/gbVWnJvH0ruZi9NY5qp2kMwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+lzdfPOuuwlYsiWysVbCJILgMflGwdagQne9LOkziI=;
 b=Ucrcjd1V95ZG/R7s9X4Eme/qzfOb0BXwW4Z9gXb8vUaJkHEKed0/fw4XUaIy/s2pVr6nR6FO8ZzU6KMnGgndHfweIo7Ash7J8ppuSGg1QkqzeSaS1yITrBuw7nwA1wzcZ9ApxhaeAu+pdgQYxX8pbqng5dGW5v9As2SZMQCNmx6Nl2W72rUO+Ud9CHMc0zrWSMIkdBmfArjIkCpKGr4/8Q0VtdkZ3Aqy3e/PvcXHCiy3S+ZHhp4SRW29e7hrcOQpQhkCQLLOlmdp81ZcOGBrKC6iHluHT+XWN/Vsp5Nyr3vuK3obL1dO9G3W5WG25gyKQDa7aJhILQlwcYmFk/942w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+lzdfPOuuwlYsiWysVbCJILgMflGwdagQne9LOkziI=;
 b=ioJzh+xsLBjaIz0O7AdWf5xjI0+KKyCISL+G4JEpKYIWaoI9Riq7v+Cqv29bnv/EpwWxkdtRRKAuwnj9/mquEekSvq8mYLWr97OMnRHOpuQCpy4nkGoF4yD/mbQqfDCQCFko712BgZ5TvDVozi6sN5SiNYniaxbMca3OAoRwC9U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB6956.eurprd04.prod.outlook.com (2603:10a6:10:11b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 14 Oct
 2022 03:09:08 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a%4]) with mapi id 15.20.5676.028; Fri, 14 Oct 2022
 03:09:08 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     andersson@kernel.org, mathieu.poirier@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V7 0/7] remoteproc: imx_rproc: support i.MX8QM/QXP
Date:   Fri, 14 Oct 2022 11:10:30 +0800
Message-Id: <20221014031037.1070424-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB8PR04MB6956:EE_
X-MS-Office365-Filtering-Correlation-Id: 6755f182-5793-4551-597e-08daad917557
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zAeVkNt+h9jZYDVRKONV1vgxoA3DcdFQLIMaYBiQTZwz89sP9c75LX8QekQs4nMNErHiMMKnnvZmFAeyZRzB58zTFPlou1EyKl8kGDrgrUYqlikFfRBXjnjU7ofz8gUHP7Lv/MDBiAoycMUgc7F6qggfXAGMKSam7ayQ4dKCzA5qTUAgZQGWVbjw0pgu7Ki3e9blu2AtatkNBz94lf7XCaKvUeNO9Y6nWvLKpQl63JaYuSFs56oDgX6kp4b7uxIS3JZHtoNv3I2leHIeJEMmc3wGcpOOfsNqjvyHszH+IB54L0HrF9cRZpOhXHIY7TqCQVqs+16tawcWI0Lycwxn1tcAyXTKFwqXkbHYpe0dl3yuyytPT3Ieyr0cCr5EKpkTtaWV7Vpx1JkwiLIaWUJ+IaPXZyve2g/IQIxfE/SVSpff4rX80J1oUV4/VSCQD4hxG2swgxYqQ2LIQlO1DJqJbtxsNfKJc7RPLpqNfomc/GzXNcyNo0KB9YYqOkA0xD4BrqgxTOluULH4PADXHlAFQzqmfLhOQC1gmvhJE4ZXneg5Xp5oGJw2V3SVmDdeLzL6G8uYJcy3YEUnn43FIq4Pj9uDMw+Jx7wy6qZelc0HWnojv3vFcGg+mVWaDjj8IIjcZ/pnl7DTxxnXon9Y0GH4veyU9WIVLlE0rYhctAaWaIoZd9lT7AmDm1W2r2tUalTmnpTHaatm4dtn72ukSPD4Jnz+lu4esh3jaPuznK2E3XsVbAAWfU+LJFlaE5Pfy/L5Wx8lNfvcN9UB3ZwxABgssNnmjaSecZQxcqtyOKSDmL56cosNHubkcCY7qsnsVR0GgPVjxXhxnLjWXQSpWFgyyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199015)(2616005)(26005)(6512007)(52116002)(186003)(66946007)(316002)(2906002)(66556008)(41300700001)(66476007)(1076003)(4326008)(8936002)(86362001)(8676002)(6666004)(38100700002)(38350700002)(6506007)(45080400002)(7416002)(478600001)(5660300002)(6486002)(966005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a490T3WgQ7+dIFNEp8kjCXs9y6tUp2C3wwzDp+0ecmhmXCOr3aSeoLr9FyKM?=
 =?us-ascii?Q?sq+G0IBMBulJ+KKvUVFrnLKspLcxesXhjHAgDR359cTp1C3OxtAfp+OqKt2Y?=
 =?us-ascii?Q?PHHKt9WzedA8f4dsSq3OxB03HCWhBI+TYeZjaCvdjEcN36AEfL1Ojg1/Nr1w?=
 =?us-ascii?Q?GvXx+NjHG7orIRLrSLES3UUQPlOLVbl/CW5sL8KkKqWpq4fa9mxsA5cqSjXh?=
 =?us-ascii?Q?OJckKxpEEmKiXEYtdkiGAAGE5mKeiod1/f8pZGAzuy9xeG3DVQRspgLs7joE?=
 =?us-ascii?Q?ZyAjAn3CjBunc9RWdXe0vjqMngqxNromSo1JsuiWIugqRZQ0ckPSWqDJxt2s?=
 =?us-ascii?Q?rKWE6YQqbk3xiJZojm99mFgbi7FyGQ/TbEX0ZTuK8eP/1JInh2bRJwJ8eylF?=
 =?us-ascii?Q?gJoAx7/OK7QUKMNukrXesats4WzidG+2jaoz9redqi+xK9sOkp45lf7AdRkj?=
 =?us-ascii?Q?M7TJTC/T21hdGl+1abuuR5f29caf553XIyHzGyP9i2IsZHBOGDiVEUcNlcG5?=
 =?us-ascii?Q?HzpphivYRI+1omInQ/qk+BTK//17xTamNmfXOJ5Ywu8WKVfCj+S29nNNK/6j?=
 =?us-ascii?Q?t8tmj8hBTN/YV8JIhz3ifGJ1Kfgt5UKFrSXYQeqJdQfj//mU5A76EBkp+8bj?=
 =?us-ascii?Q?OP203PWVdTYQ2OrqM0JeHrYjFmHJ84eVynmOxV4tTwUKk0JGSOT+6jpiXNb1?=
 =?us-ascii?Q?CsIr9vsEoaPScFyvPSkA8S3b/nKOLytyC0QF0dPefAhGt0lFehkDuU/RLi3r?=
 =?us-ascii?Q?chBx+SNz0fjMGJE0sTsme1DXrjVHJPLkI1t5dnfd8iq/ft6nPFb8R92PyACQ?=
 =?us-ascii?Q?na9tFv+FBsETrAGxn+110tniF8FubYsC9oDaYMUMpEPb2dOiqxNc3ZEBRwJr?=
 =?us-ascii?Q?HWAAqdUPXGofHcda7tgCXPfxrZkY9BrhMiC2dWykhpd0Er71M9xKhVBcSfo/?=
 =?us-ascii?Q?YX5l25DyxsfI9zeYsqqRkC5rVlqZuK+Yrt1HPuK19MMeW7FnxPjxEUGfI5In?=
 =?us-ascii?Q?fFALIu3ISni5nl8vE3tdjsSA8nnrXizLGetzN9qCJPtbkjb6Q11D9JU5LG6H?=
 =?us-ascii?Q?V34GyNs3MxUmbm/lXavYHjh3EO9e8h5w5jiuaNJkzx9zT4s8MJlSeYX595mS?=
 =?us-ascii?Q?gF0MTPnHR2tWHxzglTJsVfJwrRLRs8q7Y5SJbbX4TeHOJ69rzgvzLrKFd+++?=
 =?us-ascii?Q?igYAJZnKZBiPDMSPRT7O6JKqd7Tos2KHlrtcNDnEQccI+b2dCjv4jZGhd3RG?=
 =?us-ascii?Q?KUY+df9BHlws5WFN+8UAeM1XeN1uy9SWz2s0OmmSudvbmhAB/f+bSKNoD3yC?=
 =?us-ascii?Q?gvzZ0r2ob6nT7iRTa2ccwvtn6pdMmP/TnrufZKPesRwwh4RjSjzN+imChmOv?=
 =?us-ascii?Q?ivHMvgfSlacQwS41P7iVPC6WgTTHof7RN+5fss1PnKpgyLcAh1qtl9sCmd1B?=
 =?us-ascii?Q?TKCxdTjlxMCijnMot3zYwDqQCOJjBVoO2vBUkUH9q2QKFhVzN4JMAPUsUN8G?=
 =?us-ascii?Q?eUNhD3uYC0b/0z59O0jHwYpdtmk4c8zN+U4QgvtxgFKnDb3Exu9gZA095mrP?=
 =?us-ascii?Q?tBS2ugFLuJcvwn/88Y03uuor0r3fxIO2EUgjselS?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6755f182-5793-4551-597e-08daad917557
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 03:09:07.9524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QckFMxCw4jbQSuSeG3dc+sfmcCse6jDWI1XjyQTqj1swvFva77a1U6opz1DI+r5rJ+GgK3U5xj48r7ZtvMxxIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6956
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V7:
 patch 3/7: use dev_err, and R-b from Mathieu
 patch 4/7: Add comment when "num_pd <= 1", add R-b from Mathieu
 patch 5/7: Typo has->have, add R-b from Mathieu
 patch 6/7: add detach hook to free the mbox. As wrote in the patch commit log,
          imx_rproc_xtr_mbox_init is called both in probe and attach hook to resolve
          mbox defer probe, so there is check in imx_rproc_xtr_mbox_init.
	    Moved imx_rproc_free_mbox out from parition notify to detach hook
 patch 7/7: since detach hook moved to patch 6/7, so only enable recovery feature.
             
V6:
 Two changes are made:
1.
 In V5, patch 3 has a wrong logic in imx_rproc_put_scu, see [1], however
 patch 4 fixed the wrong logic, as below:

-	if (!imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc_id))
-		return;
+	if (imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc_id))
+		return imx_rproc_detach_pd(rproc);

 In V6, patch 3 fixed the wrong logic, drop the fix in patch 4. And patch 4
 changed as below, because put scu not has return value.
                imx_rproc_detach_pd(rproc);
                return;

2. Include patch 7/7 to enable attach recovery, because the attach recovery
 feature has been supported in remoteproc core.

[1] https://lore.kernel.org/linux-remoteproc/DU0PR04MB941763C3EBF8AE9A9CD69445884C9@DU0PR04MB9417.eurprd04.prod.outlook.com/T/#m87e2864260d0a1c431b577068ba79e1d64c595f1

V5:
 The patchset could not apply on latest remoteproc for-next branch,
 so rebased. Only patch 6 has a minor conflict, other patches are not
 changed.

V4:
 https://lore.kernel.org/all/20220701104725.557314-1-peng.fan@oss.nxp.com/
 Add R-b from DT maintainer
 Fix probe failure and driver remove path in patch 3, 4
 Add comments about i.MX8QM entries filter in patch 5

V3:
 Drop the dependency in V2.
 Tested on i.MX8QM/8MM
 Use 'fsl,resource-id' and 'fsl,entry-address' Per dt maintainer
 Drop 'reg' property Per remoteproc maintainer
 Drop mcore self recovery, until we land in common framework support.
 https://patchwork.kernel.org/project/linux-remoteproc/cover/20220517064937.4033441-1-peng.fan@oss.nxp.com/

V2:
 https://patchwork.kernel.org/project/linux-remoteproc/cover/20220309102118.8131-1-peng.fan@oss.nxp.com/
 Depends on https://patchwork.kernel.org/project/linux-remoteproc/list/?series=621311
 Tested on i.MX8QXP/QM/8MP
 Addressed Mathieu's comments
 Drop V1 patch 5/9, patch 3/9 is replaced with upper dependency patchset
 Move V1 patch 4/9 out to https://patchwork.kernel.org/project/linux-remoteproc/patch/20220308065754.3355-1-peng.fan@oss.nxp.com/
 Update commit log
 Drop magic number to get entry address from device tree in patch 4/6

The V1 patchset:
https://patchwork.kernel.org/project/linux-remoteproc/patch/20220111033333.403448-4-peng.fan@oss.nxp.com/

Peng Fan (7):
  dt-bindings: remoteproc: imx_rproc: support i.MX8QXP
  dt-bindings: remoteproc: imx_rproc: support i.MX8QM
  remoteproc: imx_rproc: support attaching to i.MX8QXP M4
  remoteproc: imx_rproc: support kicking Mcore from Linux for i.MX8QXP
  remoteproc: imx_rproc: support i.MX8QM
  remoteproc: imx_rproc: request mbox channel later
  remoteproc: imx_rproc: Enable attach recovery for i.MX8QM/QXP

 .../bindings/remoteproc/fsl,imx-rproc.yaml    |  16 +
 drivers/remoteproc/imx_rproc.c                | 285 +++++++++++++++++-
 2 files changed, 295 insertions(+), 6 deletions(-)

-- 
2.37.1

