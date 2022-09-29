Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950AB5EEDAA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 08:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbiI2GPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 02:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234865AbiI2GPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 02:15:41 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on20630.outbound.protection.outlook.com [IPv6:2a01:111:f400:7d00::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F148128A32;
        Wed, 28 Sep 2022 23:15:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkwep9O+X+XBoMnqlGFzOwdpzKJNyodHTfsp1P7m1tKVsKIYyngkx+T2DnHnLdJl835FbtrsmnNjBPVrG6Jt9Jgjkt6fuA8srURgwcKZv9RNxxrJhD1oKk9v7u8XB0oQx9C/LrUKlCEfdKXO7BuvEIupnpxIjsg/hv5pQCXUyy4pXtKI0K/1ESHzrYh0Jwh+bw1ZB2zGBmxmn7y8RSug/8O6p6c0CltHSFUeKq/GOUbRAZlMfRn4NQTVbX4PQ1OOt+zFk5f84nLCBiFBeSVdiQQALHGuQ2iFq9//iMEKIBgTcFThnhRgckPcMCWZz0tyk8mKz5kgxejAzNXcEAQ/cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kTLA88+iD3Kdkh4LQRbgWEHNaUmvEWJ7rBk28tAZng8=;
 b=RPoXnBmLUfSY8vO9FQAk/yw14W7Ng+pACjCgAYwzXOj4ebENA85ZBOcwxSkn6YdMEflHhz4TCJfYDYtAKsqm5j7gkFyzWT7duiq/+feQ5yDfjUZHg6OO6tQnTJsPcbsMU27ctthbkJqpOkIQdOwBgamNQ8Ws0rh/HfzTRnUJRoEmA5nyFmS+n4fRFdBY8FVlV4O7M8KnuLdCcH1SsYvBRCrZrjC5gjBtVcETV1p9GNeZtfsr+vhwXxgAq3gKJK4pHsQPUTDQZ8nR5vDzf0NyxcynNVzfkeiyg5mdeJb3KuZjpiN34h2mxJZC26x88y00H8gKK/pnaTLSl0ZX4HPcUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kTLA88+iD3Kdkh4LQRbgWEHNaUmvEWJ7rBk28tAZng8=;
 b=fApFTDjM1Auso7XCP+q6yio6SML0hFiotLU+0Vnz7bAj55P0d2QazYZO6fEsZrJlW9YiJTLfQMuOUYGpt9k/Mq3SiH2UWJgD5LX0pSjNeV64wsCq4gc3gdfYf1cNw8xB0CBpuSfWYI6CW760bLft89zy0eS3KvHc5e0fbY8lmsc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8648.eurprd04.prod.outlook.com (2603:10a6:10:2df::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Thu, 29 Sep
 2022 06:15:33 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867%7]) with mapi id 15.20.5676.019; Thu, 29 Sep 2022
 06:15:33 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     andersson@kernel.org, mathieu.poirier@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V6 0/7] remoteproc: imx_rproc: support i.MX8QM/QXP
Date:   Thu, 29 Sep 2022 14:16:57 +0800
Message-Id: <20220929061704.1571746-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::7) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU2PR04MB8648:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ff913fb-8618-4b83-839b-08daa1e20432
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +N7EVwmxifxARMnXAjYtu7mGznxDZ0uO21bCiQTkFRAbSSbvhfROb+mrnlHz0s6MgeQejyhWnOvnRcKcPfPk5m66ZYlvEfSAdigqms84gYcOBuwzPullfqVN2aFSUpMM/hVSpgu4m8+96qGNspOCVo13qWmJQJf9g2MSWrCQW7kIULdIpcJjczAlh6meXOaAQVREnrfxP4WXWo1hhZBvgNVOY0m2AhMwDmOZjp9wxJN0j2PjD4CM2u35S7kE+vwA8Q84IwmaV3+q122UN37+67bX0RkI1HavjJ34tzbDsX1/g2jn0GGAqG8NYT0z2VjvG6J95c4YnUyc1kve0X7XSbweUVdiJqjOZPf9H0FINYpccX9gRqjFOq46wg9m5TUPVLisNmTreF+UkreWOJKyQA/TdgdyOdwlGlo7/vxf3Y2tHM/vpHpPG0otPOk0nrqn7kpWWhgki/HhGEIVuD15D4rd0lUrZ2+xSQWfmPayWOnv6BJvRbw5cpcGk/pIYDZhCOIEH5Tveg0gJK2ZGT7SJHvhQ3gyAwAZiwop78Cix9Gb8EckMsYZZSE1eIXvTBKBeDoi8as/E69TGIYPoASd6eyyrHza0Wmx1McySeYe33VgHia5/fn+pR64PxcP1V7WZzghIo0QsZwSpcrAmze/zOML1j5vlPk2PYtn5sF7nFfyUhlzL+F2a7bW5gbEJbTAt7R73tE6oPITArvvx++wPMhzsrp/8ADN6hdxB4tIzj1HmrrAGk0banJgzzUtn3lgCWR2oKjbKDSZ7YtulwMOMwublNotU15HcwoA+R3SIEa/4FODjuR0d0CzVB9TKvmNphjvANYqFYu2fOvAqClP8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199015)(45080400002)(4326008)(316002)(86362001)(38350700002)(38100700002)(8676002)(66556008)(66476007)(66946007)(1076003)(478600001)(6486002)(41300700001)(2906002)(5660300002)(83380400001)(7416002)(6666004)(8936002)(186003)(2616005)(966005)(52116002)(6506007)(6512007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qSqyyvNpNLQnJqpqKqoEa2Wb9iMfkAFCK4qQnxTUriYfumu+avGU1IScDBfQ?=
 =?us-ascii?Q?fv2B1gYSKA8zpc0KFDZzO9ybZhVlE0h7nhO1V/sTk7m4nz6IU+VVjBNmuTel?=
 =?us-ascii?Q?HHFMUO2KQ2vaNAJ/UfpYnVpldAI0EsludR1GoRRV8WK+1Ufaecv/MJ2wSVej?=
 =?us-ascii?Q?T59lzm0h5uj9dcbt5Z/NYBRxukq3Mj7iEErUthEWouIEPCDwVP2DePuZHnBe?=
 =?us-ascii?Q?XB/tRGgmD3/gw/b/5LWpKwcM2CNouYpFM7LjXvbPPUapMYo1iyn+7OOCe5aG?=
 =?us-ascii?Q?gbi+sGg8kQlKUdUVukE5xPt3VHa6IFrAupaZMdBcQFSam5z/awmlY+Wm4Si2?=
 =?us-ascii?Q?zTB5UBb0i3IIZ0i3tV3EWCz0FwPgFbaWsnvcXWB5wkAsDBi0EH8I+siVF5Hn?=
 =?us-ascii?Q?yzdOzLZDlx6WQudz93GVVdpU6O9qdzZ5cr6FICTGAmmwEsvNjQjfhbxzIjYA?=
 =?us-ascii?Q?INMcm1plSUDU75eZkezvCkg1wyyEjjQfUoTaSiVczvuW/F11PMNEq2mDfPmV?=
 =?us-ascii?Q?bYmt/Bx7dEgPZinmLYQQ2WtzdC9YBSFbYMjG0nG/xNEBn4Z0CdbYlJeFsGz1?=
 =?us-ascii?Q?AlaCiNaoMDB1q8GY4qpl9tvBv1fxNHRTAsnkqB+gVJvf2NzPCbkyE7KOBzvT?=
 =?us-ascii?Q?RmeExVw81voAaX10a/DJ2t/hjPWsb+8QXFBqk3lHtY1Cs1LyxtxPNQdAyk3j?=
 =?us-ascii?Q?mz7KYe3C0ThzImHXU204Pwnqqhhr2d91ulWnDf487xyDOt2PLiiTwgFMdH7+?=
 =?us-ascii?Q?F5t2fex8U+Z1nrwjyfep9Ow+8Bl6cE6cuZLXyrO83DXs51QnT2D8dWBVexRC?=
 =?us-ascii?Q?qIHvFmU4jqY0t2WjmHizKdeHuHmbbnE06j3rteqzL11cl7PplZq7ZxTIvfoO?=
 =?us-ascii?Q?QgygcUOY+P4tywU1iv1S7QLgiwh2VkxWyH5ltrrY8zcLzKD8zF00a79Tc46c?=
 =?us-ascii?Q?NrbgrjG+kMaVYQ+id5zfZHdns/W6PiBQlIbycqSlmsotr3AbyRXQTZjByVQ6?=
 =?us-ascii?Q?2aHg8R0dWFVCpQ9gEQtTG4i5zxhOskHF1YYc0HQFTmN1tI4ROmbZs+N/42qS?=
 =?us-ascii?Q?nMc4JjMNYiwO4v/vPAHLCUqn42EOyQfSR3XLDCU8uRr237TutJNXurEgIfIU?=
 =?us-ascii?Q?XUuEvcoE5Fup/tfpRihR7PgRfQDvUg+2y3/WKasFkKHEAPEoCrXiVf0dJ1/C?=
 =?us-ascii?Q?F0Crk4jI9AsIBXs1IbkUWoJFHLpd5EsFJttNCAV8esbDkEQRQbVpb08LKhR7?=
 =?us-ascii?Q?wx+K81jAr06KHodbsMIIe10lIoWSEvqvIxafymgm/vGcbzVzk+qQBotKQKds?=
 =?us-ascii?Q?RILtFTU5YEq8iXxs+U7uLdo8Djkiv3zZQZcnR6wZJGW1wVH0IqYnhuHXxVck?=
 =?us-ascii?Q?MCAVmCm7OjkRWr4nPy5VE06vv010T6t7C+TxuxStKArtvbnS0WPnLF1/VleX?=
 =?us-ascii?Q?1/yz1+f7oJlSvRWcFn7rg+TsSbauaLUArqHLfv3ZH8NDFdWbLin/nPB1zs1j?=
 =?us-ascii?Q?AMM37dWdFykftJ63rkrUn8Nzv4hEVJ3hpkQwYkPSEaW5dTtbHnYOkkB7EdPq?=
 =?us-ascii?Q?zHk0EsDfKTy17MsBHfJ0NzPJp0rKsqdLmiWE7ThZ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ff913fb-8618-4b83-839b-08daa1e20432
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 06:15:33.6133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FxFqSSOH9VDXUF9VM/1BfGxuSOyq3ZwamobH6sBzXxfcchdbMxCGjSf7tie980xRBKbhiNa3Yuj5bNMA1ay9JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8648
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,
        T_SPF_PERMERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

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
 drivers/remoteproc/imx_rproc.c                | 277 +++++++++++++++++-
 2 files changed, 287 insertions(+), 6 deletions(-)

-- 
2.37.1

