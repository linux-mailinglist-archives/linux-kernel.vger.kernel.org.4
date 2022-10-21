Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1375606EB0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 06:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiJUEOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 00:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJUEOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 00:14:06 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2081.outbound.protection.outlook.com [40.107.247.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121CD1BB978;
        Thu, 20 Oct 2022 21:14:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jRAdLP40hwyPUjLryoP5iDc9KamMZpO+1vQ1Yg4wgL58m1KvQrCldwkr5vLAEWWkv7HmXp7Aa79B/vLcGQyCA4dvZh2PnURwIFArMh7XEh03En9d9MRqk08nbx2kjMH1xhwtpIck4Yw+/J5Uvu7UJ8+js+30g/Ubi/Y1iq2MAt8E8MjYpCbcvBBQENXd13z1hkvxf2BIhKrCD7M5vZFMwA5oWrLk1EwLgb79u/S9wh4zOcFVX6S1x9orcbMmCm5gMljxOVphtQ9OBYZyE9yFLSLGhT4uP0uIqMDd1YtFZxIwmDDG8KrOtXQTQeMoeqTaGoO2H0RmLEQ+T+BUDmTN3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vfdho66Q0lFk/ABiQkeWMAkkZfa4+zxvFmQk/RxGnY4=;
 b=OXBBhpV6uv8uuvrRaV6rrlJORy58T6CBKkaXYtSy3IhES18bcWdWD06y6m17u7fdmVncLk3ift+TxMI/iUMJR+JnYOigaegOyxgAoPN6IOI+Kz7+/voOS/CPlCe6VL3l/IPYc3k1Ox4WgsUEpd7h3SxOs+AyueqRj7kT99PAlbGFDBXcMJnk6diRZGaHr9DAKNG37xLZe9RgsjZ3d+jrojzFNPXzBJdSv1Ewb7WYTD6Dc0M22ioNmRaNGwxSPri1W2V1CLrH/sGyaOx71uWQoVL7xvLcYdGvt/lZepZxDZn8Af38NGfol5jlLeh/jeAvMuZtGj+07X2cdLfGPrvXOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vfdho66Q0lFk/ABiQkeWMAkkZfa4+zxvFmQk/RxGnY4=;
 b=WvskTy5UpPOtVyFDTcaUJ6ShGi63BJP1/LyuuLQcSAyhR0K6URHjDmLNLtn15IWcv1XhSIdHw2YvQR9GwD7EbtE6mffs1Exz+UaTBz/cFu7RYsyTYC7pA3309iCytighdsUjqio4f/KEmoNmTkee32aIB5Xa/ztMMd/2S0A/0CE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VE1PR04MB7294.eurprd04.prod.outlook.com (2603:10a6:800:1a3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 21 Oct
 2022 04:14:00 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed%6]) with mapi id 15.20.5723.032; Fri, 21 Oct 2022
 04:14:00 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@kernel.org, mathieu.poirier@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V8 0/7] remoteproc: imx_rproc: support i.MX8QM/QXP
Date:   Fri, 21 Oct 2022 12:15:19 +0800
Message-Id: <20221021041526.3696483-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0018.apcprd06.prod.outlook.com
 (2603:1096:4:186::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|VE1PR04MB7294:EE_
X-MS-Office365-Filtering-Correlation-Id: a83e5292-f351-459b-4200-08dab31aae73
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c9txovyxGm9MUBnN1YtD1hDLm6Lvnuj+nH9hXTxhROj9tFX0zmY1HYZJ8uVB2DkN05HvJG45N+fyhZhOuq81il2GZp1GKL92AzCK3EvtrezfjKrh7sM9oAb8sg+cdumBmxtjlFRXRQA61W2qwKwprH6naPpoFsZGZMDBCPpudIr84Zja5LF6hi1KjuIRTGjS6PcuXHoYCrrNnDNG3+DK0FYd3jhJGgSzfDrhFSQ6/Gkg2/62wnxibJX6HUn35V0YbI0UmtuDtXL82h/j9ORFGSEm6w79kjUifEfbuygglDfi5UE2LRjMVxzheWaEPqD4UDfc4o10B3lL6knVVuXHv91idgE4W2D1+PSRcQInQnGBstDg4YaySpqqu2D1GUmW5RqC8idFM2/qXfbA/nxX5GsCrUC2jaQGpKL6vr38aYYnCuIVzteFZUtPfnZyurZUagNQD8or3hzY2hD1N/BoR4+qHCKAIDdZf970VuhsT5NRIppW92dm+li7qNFSbKrpc80eB143Gj8+vM45kR/4qCYgnBd6zbsPU2WCfNSzlk70tXqGjJk36pm/9PgvhphstDg7Cld2CBHjbmdGWbYq+WQm2UdYh6PYLCz14mdnk2IkX13PFppEfh5AScGkRt8XmGbSAelEMt/ABLjVbo2JpopiI+GEpdsf6HulSufMUt0/AmjV2TlZvDb/6L9dHu5cmE5rgntQmE0RyTS8HVnGdoydMDOwIu1f58/ZxzbSq1J3wsdNEUl3mJPm35BVlCu8i4zlcx+9V5skS00abs1WNf3PELLz7wHQkotYI3yRkUmdqULWAjz8aHWk0TJSkqK/FXoDnIKMR/SpeP1wQKeG4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(396003)(366004)(39860400002)(376002)(451199015)(38350700002)(186003)(2616005)(38100700002)(6486002)(2906002)(1076003)(478600001)(45080400002)(66476007)(66556008)(8676002)(66946007)(86362001)(966005)(6666004)(8936002)(316002)(4326008)(6512007)(6506007)(26005)(41300700001)(52116002)(7416002)(83380400001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XhlauEQ6e3cPI22bUVjLSjTP1//dxrvQdiYGRvcikMwOGhd8pSjEcYgH4uiw?=
 =?us-ascii?Q?hwZkmN8u2o2WtY9RgZ3jaaIAIcgGFAPKU8hAQ/OXGUuaIzBzPn6CroK6jfpU?=
 =?us-ascii?Q?GGStP0wZ8efA5q1k2NgJkTILWY2yWzJLckNBUcqqydvyaw4RMNeaJ8kmPrqY?=
 =?us-ascii?Q?ESZmaZhYR7434K5Hix6Of37FVgC84hP8pUZPwvAsIAMOR0E5nC1aq8NcEInH?=
 =?us-ascii?Q?yOWbvup2fYKP4exSXhb3kbO+7gQTnHQlLPfdV2n/LSWxGQBYQt4ye64FtzOO?=
 =?us-ascii?Q?g2RN6ib0u+L83mQlQtvj+WEHbI44gOyvemWlN4FQMxz0RJtrCYvkhfbm9kC5?=
 =?us-ascii?Q?2f/pw4BHLAW3yN4veoe+T/+BfNWoWaYs17+kwJ6bHFcKXDNgMXpmHhEfU9Cw?=
 =?us-ascii?Q?1cjRlX5sYw/93oTStyRMOCnAPXuYFYoYGPziiJBqNCpJvTG9J3n2q5Xugm2V?=
 =?us-ascii?Q?WNQ5cfmL1as+t1nz+1C9Wi7+wfmRyyIsitGmT0p0It5HBDKkGPaGFrl5ratg?=
 =?us-ascii?Q?OeWf0LK4JWQuRU1o/3UN4v7U++ZJXkEfmNZu0DntcRhkogijH1nA4LV4hFLI?=
 =?us-ascii?Q?b2hxghJnREY/eyYMvqivb0HNfQzyNqOUtWt2c6vO3Eih1tFINLN0LQQA1+Oo?=
 =?us-ascii?Q?6SsjMd7dBi4qwYfaofyldPwQ08PqxrBN7PFcRH4SGamcK9+bZ5OM9dUmXpA1?=
 =?us-ascii?Q?PE9oCwvlEbQ6NdS+Qas2yqSN0eBwyghVKMsiPjrq/kTsza8ejQ9aVy5Ru/lv?=
 =?us-ascii?Q?1Kk3UTC8sKxj/I0xIimj5ttingy2IksybaTs6ACU4eckp6xRUg9D0W+S5VXB?=
 =?us-ascii?Q?Jy0FgbAQqUQSb6pfI85gTmt7lkaoDacS12sdoysESeyzc41oRWBoBB0FSRBU?=
 =?us-ascii?Q?CbXJVyN/BoAsMnTBZTTyRGMgEMMkzFxo1rrMbqqyRbxx6TtP5/vOO4uH5kXC?=
 =?us-ascii?Q?7AW70H5GXSLDewC+V7gs3h5/diGH4q3ekqAWUFelFatCvsVd9mCn4HzAt2tT?=
 =?us-ascii?Q?Gbwk6cqKGU4xhC3zV7dYdtbuJsv+2yW5vWVljMCUAv84TKawKGWkef9AHLON?=
 =?us-ascii?Q?1UQ4N1ajzTyZJntr5YU7iC/shEvlPa4rOzX0zkws7BubK46tqpmMaDK2q2GY?=
 =?us-ascii?Q?Yy2QS008OeldDnBhy/xJbS1O5mDW0GXKAwGHbip9Y3OkdBGy85i7JDWy4BKO?=
 =?us-ascii?Q?u7JsCSu9UR3w7IkoTXfisTWjLKZw5rm+26PU2WPYfq4sCLXHi1mjElDrwMnU?=
 =?us-ascii?Q?muuHiNEdab4oc6By3y5/TiQevemvXvbPyMjzNkzDet/kumHEepcIEN0eui2R?=
 =?us-ascii?Q?vUEyHdYEv+8UQYfUbcKrMnI3sA2uuk/gYSXUDFI18jKwKSyyyd9s1uT21YrE?=
 =?us-ascii?Q?T8mnvhTqgbKd+Yq0qy+ujykGIWhyabsxCMbIZeEE0x3chchBNZEoZbDWeNM0?=
 =?us-ascii?Q?f1ttAKZZSrp4gq1X8rjufI0AcLAuABdweuwE7Iq6aZoAYOCVMcBReddWxWmH?=
 =?us-ascii?Q?c35jXQX/3kfTEit/hW3OcMsblmz/Mm3K4aykNqyho3fynfPidSKFV2R+Vjdk?=
 =?us-ascii?Q?chJcuvdMykjFytgjnTmJxnfhaDU83pe/arIP2Cay?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a83e5292-f351-459b-4200-08dab31aae73
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 04:14:00.7875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DlcPgvHVSaNmp+VIAUVEQJefvIxkNKYYjKCvRtcRL5p1TrL95iKmjyf4eYYUMDCfYLV7XR1gK0Xur37cXvIoiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7294
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
 patch 2/7: Per Krzysztof, keep alphabetical order for compatible string
 Patch 6/7: Add comments to explain the tx_ch/rx_ch check in imx_rproc_xtr_mbox_init,
            to address comment: https://lore.kernel.org/all/20221017173335.GA121862@p14s/

V7:
 patch 3/7: use dev_err, and R-b from Mathieu
 patch 4/7: Add comment when "num_pd <= 1", add R-b from Mathieu
 patch 5/7: Typo has->have, add R-b from Mathieu
 patch 6/7: add detach hook to free the mbox. As wrote in the patch commit log,
          imx_rproc_xtr_mbox_init is called both in probe and attach hook to resolve
          mbox defer probe, so there is check in imx_rproc_xtr_mbox_init.
	    Moved imx_rproc_free_mbox out from parition notify to detach hook
 patch 7/7: since detach hook moved to patch 6/7, so only enable recovery feature.

 https://lore.kernel.org/all/20221014031037.1070424-1-peng.fan@oss.nxp.com/

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
 drivers/remoteproc/imx_rproc.c                | 294 +++++++++++++++++-
 2 files changed, 304 insertions(+), 6 deletions(-)

-- 
2.37.1

