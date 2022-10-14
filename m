Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2534F5FEC23
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 11:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiJNJvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 05:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiJNJvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 05:51:09 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2070.outbound.protection.outlook.com [40.107.22.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27191C881B;
        Fri, 14 Oct 2022 02:50:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gGi5DD89Bq2cmBtvb7orWdKb8/m3Igzwgo8AWv5EiXQb+BRQ+bsm2oFC3HktwqsuKUg23O9P50cjM6M41U/gNJOcFBxJt9alC2I9kVxFX7SeEdGZ0n0Ak4jeOlzk+eduEXX8SYKU0rnc1gN6yorF8AeiY0rWrx9JgmvwUj5+vj/SvZBPgXhYCkYV1YRbny7mdvJ6loUvGqvCa4uwCzKa63DqpqOs8oTIcit1dPHsFjA6SZzKPyFdrOGahowDWrvk5e4AAgtNJISlxb+bpwV+MRxrP0IOAbFfww0asrzJ/h3Gi1m+AtkzpCAfoVRMf+DlVGWIF3HBALnKqi+fZA4HYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=atoyHDFA6enF7vuSU02+2A+yXu2qKYFap7gKdYlo5II=;
 b=Bwt+rbTrhlnqEQCh6g86mFfFileJOsW0DCMpPDqu2jWvXqy/0YkfMfg3e524etWdmKi1mq0iZHflADMUQxhqv/YqnMHQ9LcE2oKBfbZVoDdvKAsXXkvl8boT3z0vVWHzp7Sdwz7r5KPrhj1PcBrmiXzSy72iB+YOSCE3md6bJIwHODQluVOytMqu+HNKQRBzC4MMvOAyJgjHr+aiAKfPi/k3PAN/toLPjbpeZ+UGn95VXKGppUPrXlxSmDL8Ur5VVn/hkljQD2Zh6a8yMTKpQ3PKYN/1OxbdRs4AuwttWazZ6SIfx0sYbIzOCa9ZV0LnBlo+L8VeLwUL2rnaH2Ul1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=atoyHDFA6enF7vuSU02+2A+yXu2qKYFap7gKdYlo5II=;
 b=ZvxzSQ0KFh3MuaLE5j3CZ0ggMfu/PPOjTnaZ/9Z8z8F44qjEprvsvzIh6iR/nRDka4jQsk2cYCwpk3fLb4Oy9cZe2DeqSITrdQ7Am66eDtjM/tY9I4tcUvzHPsm2VFezhbd8Yo70H+zir7n0wWEFQGrevM/TPeddPd/nuYf9p2A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB7666.eurprd04.prod.outlook.com (2603:10a6:20b:287::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 14 Oct
 2022 09:50:46 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a%4]) with mapi id 15.20.5676.028; Fri, 14 Oct 2022
 09:50:46 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, xu.yang_2@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 6/6] dt-bindings: usb: ci-hdrc-usb2: add i.MX8DXL/M[M,N] support
Date:   Fri, 14 Oct 2022 17:51:48 +0800
Message-Id: <20221014095148.2063669-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221014095148.2063669-1-peng.fan@oss.nxp.com>
References: <20221014095148.2063669-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0127.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::31) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB7666:EE_
X-MS-Office365-Filtering-Correlation-Id: 3544643c-9152-40cd-043e-08daadc990fd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ne2MGUbXZz4jyVbiLOfitDDy21iFT5vDyUP7w1QO99FabITsx7RrxAydDIYOjN3StqN5dcUBb8832e+JcscEUq57y4YolYHrVOEGpzrwqYpCt0d7oGa2dIYAzaMUERvHj05FWyRtsFesjUUidd0jbGVYH6iwCDEr6XdZW8fItG5RNDXZ1Ixui2eHkBuaD4Qridth7NHJtkg0QESUho5MZ4S1g/7okwkOklrdN3dFf+hSu9cteOZ0I3n3H7n9/AwMxzqgrhsWv9oDqeJ9xl5I3Li76hmEbpKUWgKYMGUunexfLc1WUCUZ0k6ym7gYxzpQ46c66Bo8dgf1NOTLGR8h+J3wpJRf5xn47F65+r/+ISK0+ckaXwRf43M+8/BFAsVyjwL2JcDyr9aiPnCttrWRtp1bF1Qs1ybjVHqCmbq2rEgWsy0PVLYP2PKCs26qaypzxWB4+UugheH2sdRtpq/j0jXN0x/JmLx8tVBxFR0dYPdXuNM8CooKZhyoR+Wlf38WlrDDLzV0W7JYmO2b9hoR3PJspvLpheDUU1Q6oX2ImuM4tFToDJRflJubyTMfxjklZuBTQTa7Nlc80ZNiPnYvv2h6yE96fcp75vzndg1wRZUfUaN4mfM+sjbkIb6G53XtrhQExxikrV01OI1rFyjlSnmRn7o4cqtj8Uy2eTi0ERHwja0QlHKdwZjAPXB7kBwk7nQj23dVZyoeCSf5KVyRapteOg/k4O/TwkuW4mC285RSMuGStnUS4e8ragSH0hKItnQ8EHQNvCA45p5QA9tdVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(451199015)(66946007)(478600001)(6486002)(86362001)(38100700002)(8676002)(41300700001)(66476007)(6506007)(7416002)(4744005)(52116002)(26005)(4326008)(66556008)(316002)(38350700002)(186003)(1076003)(6512007)(2616005)(5660300002)(2906002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dndfAlVLInEtrzbAu9gG6i3igXgpSpawLdkdckBuSWwV2QHKUF+3rA8WkEFB?=
 =?us-ascii?Q?SI4sn7lsBQEN0dZUK2NSs92PoUt0LR9fjMPlmOZM+4UumOsnL0eXRH3bQEvs?=
 =?us-ascii?Q?B5aEXD4XdZdRA+dGl3KE3AN24LQM/bm6kqDrO4Q4ZSMZ9nhl/DCOQF+OHqyq?=
 =?us-ascii?Q?701NY4BImXNbSTZg6oTCFHbMpQn0yzrKj5X9+Zv+kde/Id/MmZVs828edcrd?=
 =?us-ascii?Q?Hph3m1N/2/mxDCiBtuGHMXBZmtH7yOEKk2ZDuNOs8hLRunKl7gjjJybn4RoF?=
 =?us-ascii?Q?Irfafn7v0KAM+E0WZBwFvfeAP8pzBYA4pLaUApDOLzvoT8zlljTtZS5af6aT?=
 =?us-ascii?Q?icC0DHEa8Jk9PkEZZ3zkW0/NcR2hKQuGxiraeSs0r4GJ0XGS/bF3MSqDpqVc?=
 =?us-ascii?Q?Uw8BueQ9/nzO62fuEL4qKzlhcOL2SAdOLxf3uHuIIIM47pz7tpyOKhsVW4R2?=
 =?us-ascii?Q?dLyPgjl0TpI1RyiKFrRMOgDgY02MnqJ5sNSwKT7ne1Xm6pKGu33LYfLAlhDL?=
 =?us-ascii?Q?Bq/p6Xmyn53KJubHMlNmPj17AVyoSYe3nh4RNzEpaMaXD0KppSjdHyrFba7w?=
 =?us-ascii?Q?Z2zhuzVlcjqRZvhF8N3EbS/wOk7/SA/sesdt5GO0d5RdyPhJFcOwBtT4Peh5?=
 =?us-ascii?Q?/GdkQW3nmuqaiyHqZZMoTsAtncRMlD65io0GjpgbPHeXNGnt/9/GyHe004ay?=
 =?us-ascii?Q?zWTfLTAJqlfmF+YKQCl/KY1OdsOIyatejstaMeVpq8FEW3YK2jb4m0GtF5FA?=
 =?us-ascii?Q?KTQIWSf+BclCi7pZH09trrPeAxsb7DIBA+hFc53KJ+RufUc9bx5Edwz2tbs0?=
 =?us-ascii?Q?7JIeYPTcFQFGP8OW81+QVA0KpnQ8rQVFpL0t2p8lWfd8J3CsGVfsaCUfPUr/?=
 =?us-ascii?Q?DLnyKRCQm8lM8Go1Ywh+xIrICXwBwGHKfMvKpsUgl6cd2Me30MekODewOFSi?=
 =?us-ascii?Q?3zUv0FU78Ozq0vCCQPC/5Uq8+m1IpSHfuAF7lz/6EeN83I5mDD9DnBoICW2z?=
 =?us-ascii?Q?ipchIYHby+psSlN/X5eLsGB1aGWuk8L3OI72IRE3uEIHFDZ0oMrQbEdEvWq/?=
 =?us-ascii?Q?UBD+ou0LpKH20CS+itrxplobE4lUC8Fdvsk8siY48ytdcee7iINVh8Y+XjDu?=
 =?us-ascii?Q?N1775mTEWIcKCmDrWJFp15dMdsIYnyxWcIJjaEcH04mJrR4RsAZgICPFuVJA?=
 =?us-ascii?Q?lQ/37iu3q7paEsZzpM7v/PB4Mfo+sYgdvU9GYquhP39Pr0kFFAZkr2mrJnuQ?=
 =?us-ascii?Q?Yb+SPYCzLh1g1o8sWoCp5OiMccYrjmHvT5ygYHk7WAJ3xXICvJ9wUkjdup8C?=
 =?us-ascii?Q?+1BCyEx2a+Z4PcWZNt22KcyVFY/aOVDa+ErdbFCn3oJ3Q9pqKr0c9XCzyblE?=
 =?us-ascii?Q?pcRktlUJU3+eE5Kef7tLz9Z+vslfaJhwdNjwvMjEA5DCZPSvTw9Bi/StTg9Q?=
 =?us-ascii?Q?ZJ9uPn6Ul9+CSnB2vhes9+1Aqd77AEJpk6+SfcnPu1jC5OcVcp5B1j2WP8jK?=
 =?us-ascii?Q?FZAHODKlp783Z6RLlQX50YHnFcvDgypo6bXGcyJP5dcNSMfcx6vAzeKeCpf6?=
 =?us-ascii?Q?kq8XIk/G5xM1a6LkeEvjfmqiwDau6tp3aWRRJR5+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3544643c-9152-40cd-043e-08daadc990fd
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 09:50:46.2159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q1T/DNO9KFepFw4T4ySq0fE+L8nye17hLNPXz3+hReMJhz+yH3Dr8bQ1R5BiTOsHEDbUpe5XidMDnE7i18rgVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7666
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX8MM/N compatible strings, which are compatible with i.MX7D.
Add i.MX8DXL compatible string, which is compatible with i.MX7ULP.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
index 29ea427861c4..34cdb1be3b32 100644
--- a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
+++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
@@ -35,6 +35,14 @@ properties:
               - fsl,imx7d-usb
               - fsl,vf610-usb
           - const: fsl,imx27-usb
+      - items:
+          - const: fsl,imx8dxl-usb
+          - const: fsl,imx7ulp-usb
+      - items:
+          - enum:
+              - fsl,imx8mm-usb
+              - fsl,imx8mn-usb
+          - const: fsl,imx7d-usb
       - items:
           - const: fsl,imx6sll-usb
           - const: fsl,imx6ul-usb
-- 
2.37.1

