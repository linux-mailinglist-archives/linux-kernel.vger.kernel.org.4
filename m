Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A633D6A2FA9
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 14:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjBZNCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 08:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjBZNCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 08:02:41 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2064.outbound.protection.outlook.com [40.107.20.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F06A12F00;
        Sun, 26 Feb 2023 05:02:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LdD4S7TOxI0Icr4CjMYnUJJ/b6O4dR8I0rVM61Sc8b1V6TyU1CeEe4UHNWIDA8ZD4PHPLH+jmi7u+WfDzIcg6qgkvWVe4ajBqbhZ0d4fWFQRgdD6vrlY0tUvOrz7pLo06ShzAVuvth5oPIb3/ogki42Vqmu1tfIkSUucn5RjG53+tnbuI2sD+MghncpGTXE4N+s7f87Xl/8J4ANcPFdNaqIqMDo3IBkKXSvwmaU1V9IwoVv5bP5JP2xtXQPT6ettKon0GlbZyPItbrnnb6RQcAngYH7bJhwg6h3+WN14SpAUR9s7uURIQtqSUN1D4l1dtmlqekl6vgkdWlCfk3pAKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jLEzeQ8e3fW0rNttF2JWi1LXmFssh825G0k7LQqK+f0=;
 b=BcEiWa6PRnCYBNnMk4Pgd1sEJrOLFTe0PdzfaRMn+iXdDffJ91thbmujUuRbwjbMLCjmVZk+ABnyFjri9v2i1KA2aEaU13Ccepy0OSvwcBLJf7Borae36gpJHG3swhoIpjhv7LLGNAkxyeGFoOPg8a2PZK3Zl2IdOcsjxMXhEJq6F/ZDQU1kAF3Zo51MgyEXPLoO49BLfXYX3DsOe5OkGiOp43ju136nQvAbF5B4boUqBnzzyERTrHf0Z2z672i2iulMCWoTf3cbKnhS36ERloqOyrktb4r/nDov0L6481Gs4B8EmA8AR/XlIC2OemoQxkDLxS/2HADf8KCmqMY7bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLEzeQ8e3fW0rNttF2JWi1LXmFssh825G0k7LQqK+f0=;
 b=B8GOkvaQiGFJVsMByF0mAcZdRWRSNTCAidC28Q0hsUScWzMzlRdFqeRJv5wZT/6vv9EWGQHxkSJ9DSkNcS87NiqGuGv0mf6C9hqqNVMTPWqR0zSlBFQHmExhEugB0NCf2UZFRBOsFEG43ToC4WgAfr6KMWrfPXujbQlOn/8Xrsw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8968.eurprd04.prod.outlook.com (2603:10a6:10:2e3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.27; Sun, 26 Feb
 2023 13:01:00 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%3]) with mapi id 15.20.6134.025; Sun, 26 Feb 2023
 13:01:00 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, xu.yang_2@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 6/7] dt-bindings: usb: ci-hdrc-usb2: add i.MX8DXL/MN support
Date:   Sun, 26 Feb 2023 21:05:38 +0800
Message-Id: <20230226130539.277336-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230226130539.277336-1-peng.fan@oss.nxp.com>
References: <20230226130539.277336-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::16) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU2PR04MB8968:EE_
X-MS-Office365-Filtering-Correlation-Id: be22d415-02e5-480f-9f46-08db17f98259
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eHkDNvAM8cQ5em4G+g3OSdCUqeZ2+6ZsEFCBYwm7BcE9AC2VnAM07mxh0bOnTJmc2dfYUYIQIb5gfqV49qCRBF6ii7uTpkC49UUq9kzmWSwhQvhq3akYzO7d26zPOF3VaqpOQ8JpaIkjH0TjBXhpyepE8NpFIbU16XP8XDcVL57AS0F1AbqfqqLkXhxCpRS9YRBt4gkycubQKadYTuCUCVUi4FkBvhRwt0CnesIlhWmmiw0k3TGSsN90JBxQwOob8Tqt5mffh1eeJxHsaryhlgksJ2aHsSFiBoU8Il+ZEWNNqfO09GsIcAWSJi1bVAcuk01xN9Di/Eeoj/D4ItAo76pLWtyfVIuSY2jtOjgy4lBper8HWF03OtSa2w2RBRwpO0jH4E1yj4h4+SAHaL4MUiaHsXw/T3GxpNnP+boaMt9wFSEZNA3+575WtdYj377e9iFz8vqTaBONl8pFhoQu4RoUTGUc7se5ygiiPJbifZReVce+UDvHzaDwr01vQWZUhqRtDr9kZ7bAtrlj+cNxJVurYX9URLDGvu2Cd4ruw8jvGZQe13nm9ogkyHeRApw9VlQdbdu7wA4/dYdLNqFPmZN/mhS34EpQBIY9692ZrH8hOV5zwRHkq1qAbJQmLc5LPuLHosGTzE0U6Rsym7BAa1Viy7hvJDzP/P3RmVNedCx1qMPQplbglRpzvcfWBdAn7PA3rEDVPDGGc5m5HRRzUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(451199018)(83380400001)(8676002)(6666004)(38350700002)(38100700002)(86362001)(8936002)(5660300002)(478600001)(7416002)(2616005)(26005)(6486002)(1076003)(6512007)(6506007)(66556008)(66476007)(4326008)(2906002)(66946007)(316002)(52116002)(186003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hkjWUrgXErNv8q2ucUYfYaf0wfvqlBPb3SWuYbrJXIYOOknjA4aLKf1/JrOc?=
 =?us-ascii?Q?IleKHyoQ0ilvuhhHjpw7deqhFMKtCd5Xne/c1RsMvxTXqlVSSoKWCI2AaFo5?=
 =?us-ascii?Q?qka8BYH2nM7rJX5kNBKdjSDNqdxDDCP+XScin2t3+VV1zISTwhlJsEACNsFi?=
 =?us-ascii?Q?YMrdqdIG+yN/P69zUlbeeqz88EDC0o/GJykQfRRM8zpGmaZwFYcc1/+a7UIy?=
 =?us-ascii?Q?kP0qaKv87WAMiSix6VmGRt3wA/0cijo/Qsatshi1IeLIoH6KQj/fSDWXhx6I?=
 =?us-ascii?Q?eZ/hJRdHs7q//td00ZyJa+4LR18Fmme9ejy1tylJLQOfug8UBmlyMOlCuX3N?=
 =?us-ascii?Q?z9KAg420MaPFKiwYYkGQQ8IfY2omoqk+uRypxKArCNAGIRel96WTd3F50uvh?=
 =?us-ascii?Q?zlb2Cj75SX1VetxZ3oZzGwo0uQJBkK/kZ2v1Sc12XLKOyYsVFlRZ0HFu60Gi?=
 =?us-ascii?Q?bbhsZOTfYxpuKD28GmxA2G8B9FXVk4oaoe6YkibIa43cHyTJqWoeIRcaofPi?=
 =?us-ascii?Q?0sldxEQf5eB86lA90mAOpgwy/bW+1heozdWSsCGmsiF09R/auL99VCZhw2wt?=
 =?us-ascii?Q?3hOkY3rdMv+WQKM2bCCaMc0YiBxGWvyrGvAVA+EdMawXU+25Nr7/a1Y6ZjAF?=
 =?us-ascii?Q?axTgAOMqReJQRoYTiJkIoRzl9+5/yCro/Us5z/9FeLpSL2kNIIlPiEmRvcz9?=
 =?us-ascii?Q?wMt3nba5lI+i8r34pui6gtbqxtKSDFDELYtM6ZGZmZUEHKt0iEI7DGNQZPEO?=
 =?us-ascii?Q?Fw1OKd0LWXQM02QrZooc56FKLCAzvAq+SeRNkbeEcRlrKVzX2Zn6SbmqhML5?=
 =?us-ascii?Q?Pc3cFlpa1diADe+y1s5vi42ExkTZDCK3WDCLYIti7MQH4YXzCKDn4jyJgjtG?=
 =?us-ascii?Q?C39yQWdeFCC9NIHhXubYfsiMm7NdBVFDbpWsnV/DuxYU+7kAxPKNKfHEUpXv?=
 =?us-ascii?Q?Oj0arnrkB425+Fy1HkN4c8by1hhG6KhXhP2RsQlJPNKWq25blTgMH2ak3aKG?=
 =?us-ascii?Q?8RQWNJQ+6KO8zRpGjtRYiFAfugUepKMqUA2FgbTl6EeCHCc3O0kWn73Tg9Tm?=
 =?us-ascii?Q?2s2CfesEYJAMV5iSKkYEgVcUsVXxTqXh8chpeU+KiLmr6dScYGiKPDKHq3DH?=
 =?us-ascii?Q?x2mmyR/uKUuWgiSGHEWoEqjxpRcK6khhbFZP8MMKjdpWahmAJz91gwgNoQHG?=
 =?us-ascii?Q?lUTSYHM67D5l3OVBxGRYXg9oOmXe2vFMPesju5GP6pMRbbBg6Bwm5lNDzz1s?=
 =?us-ascii?Q?mi1w8KPoVx9zf6LHA0L4o8ZETlb+ZFW50k/J9Qw3z5BIN9NT8Ad7du8lDPD0?=
 =?us-ascii?Q?J3wBX8RoJXGzjOvS++MR0vILjluUibNQEf+Wm/WkPVmQKFm+Ty9s90KaREmB?=
 =?us-ascii?Q?C2X5Ch5qHdG4BoDSXPspGYonKIY0gmPFSJWdytQyxadEIJH/tPmSxOW6o6TP?=
 =?us-ascii?Q?weWzv1Wf6cDfZdVeKO6ziXbdgBAsZQAus8dbakCHoJZslx6J9GSWwjbeQNqo?=
 =?us-ascii?Q?jZtyNrbAboL4rFT2A/uXe+oVrkPMH6XaUowTJik/mxqrnqAkU766BgDG2YAz?=
 =?us-ascii?Q?47OMeCHRE+opNYFkHzXukXSHYhVlpndCdGiSKRy/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be22d415-02e5-480f-9f46-08db17f98259
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2023 13:01:00.7544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WbnIRcHfDdEa0Q34GGKRaGfVrQRFYuoZE7NADSByrgyRXM+b+tTUcPZb6kkAsGnr+rPsWcH6mRLlbM7F0zfRGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8968
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX8MN compatible strings, which are compatible with i.MX7D.
Add i.MX8DXL compatible string, which is compatible with i.MX7ULP.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/usb/ci-hdrc-usb2.yaml         | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
index 8fad6e034911..203649d0d02c 100644
--- a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
+++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
@@ -37,13 +37,18 @@ properties:
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
           - const: fsl,imx27-usb
-      - items:
-          - const: fsl,imx8mm-usb
-          - const: fsl,imx7d-usb
       - items:
           - const: fsl,imx7ulp-usb
           - const: fsl,imx6ul-usb
-- 
2.37.1

