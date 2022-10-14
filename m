Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5175FEC20
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 11:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiJNJvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 05:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiJNJu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 05:50:56 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2070.outbound.protection.outlook.com [40.107.22.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AD31C2E8C;
        Fri, 14 Oct 2022 02:50:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y38AQUQTxYV5SJ8Fq0oZOUqax6M0lvF5On/Hxushw5VvT+SXHR8xyftJqrffsVed0Czd2Bn/C61jGb+wXo2aT7NZPro8C5i3rmFYiJa4NAlmmfIQJhWbH9X5JT8OIAJebXVpd3hJA7YiLPsj2Aj19o3910kAHybJLi4ank/QBxd/oojQbNr6axo4Z2C1m0By0pTt5s9NwaRUEVANqpTAFfS63XEUsv//30T+J0ESZJG/pVdmwODgT5chRINJ+f7+XJele+kzczKKK3/4RqFFht9ag1ZHfai3X3tcuBC67CWX6nu735ZjuXZum7adeymOQMvtS9EIOZwFnKSE8bLd2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7pCho7cMmWJPwzUqqUfHJPMVZmuBYxq0jDxdhGuwKEM=;
 b=jcTTnpy1ox5+Y5DzBbHH+Rqnk+flisRSAe7GUvOD6CvxSkya8+r/6us5ENBbbwfI1PaKMDGwVBbFG4XrRpH8A9AihMiTt7xtAsDBc+O0JlZYDkgEy52QX3+wEMB8HlILzUMc1/+YGmf2O7TGrQMaxkktoRUp3u3VIx5zQ6dQsOUHJlpQjwVAfPBNjS70MTJydzYquu9i7DxH/T5ldR9JB4ZeQPwZmSu23jPzUdzycv7qMECq6/useTg7FmJfXiF3NibofLzIy86Hi0E/MOOUSJPh29QAATEeYg0POJPXyZHEXYjBgDpAUzw5HQiXR6ZCYqd4/jNdXmTPHKvQDgrO9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pCho7cMmWJPwzUqqUfHJPMVZmuBYxq0jDxdhGuwKEM=;
 b=csbhSFw/O7T2a8CxlU4JMuXvuoUkeFPpdBcs/rK4yjH+Wb5zxaDpKv8VKCFgl7NviNzw4faClLiu3msR6zi/eS1xbBvr+NLY2yhx8wj3rQy2FbipfERRhd3pDx0YFhiAnRUV/DOq9Mv3WLU9t3a170W5xOltGZMK0v7K71m1IYc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB7666.eurprd04.prod.outlook.com (2603:10a6:20b:287::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 14 Oct
 2022 09:50:41 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a%4]) with mapi id 15.20.5676.028; Fri, 14 Oct 2022
 09:50:41 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, xu.yang_2@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 5/6] dt-bindings: usb: ci-hdrc-usb2: add i.MX53/6SLL/UL compatible
Date:   Fri, 14 Oct 2022 17:51:47 +0800
Message-Id: <20221014095148.2063669-6-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4178a12c-7159-42b6-9dd2-08daadc98e2c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1ZUzd3o7h2PJQKeyiE1KOdcPErR8axRc1raUWmuR/UnWf1K5jkgGo1gZAZ0RC75ZkpSGk0eNVjeqWtOhDsl+kjay3oSOx3EPOd4lFQWnAJce2QrYEAxezR3pcyLKjeFpvgNQjOw23QyAqhYgHAqLkdmYJvdIZWq2PQ7hn6HRQ6Y4NvyoOXu9e5ix8zJ5SN0SSMIl3iTPHBgF2WY6mKLfy1C2IUs8U65/pGChfCN2BtbX3apvC0MvnROF8MMdcT/TwpNdX6ZbT2NVzm5cqUyTQ/VYHFybSeih0y8kHCkORds1dCgfzAj9iqRUeG9ib39A4xDVD3aGhOl8dHL7jSwcgUt1+K9TXwRF0tE8Mddi00mpPKELHLMI6tDwdutDr3lq8CBNT4UKkagcYBwu1EjjbUb/0gI5ZE+/ttXpwyItvl8RGZcOUbs8gUyrbHkEaQHm8De9lDgZkGQIJcaWlmVoy2JHKeeo8hoJv9EV79Nxasi57UUG6DiSEr5myZqFabsjmuOS4PG8yKdQGUwIqQRN8ec0AJVKIbdYMmoX3wAxeQppFLWk80/eeBCJg1hOteSLP9I7JIE3bHmEm/oCx171iESieEWA8jfuBJzLsnN5vhSlbbXTRV5JqwXXW4s7DRWcvcW0s/EAqokZlzZ9lJv2fRcbyEuEB+yUNJqM0+W/5S6SzPKACEDzGkG2lcC7DltADNjly5ABvSHvxG8geZlanArUAISJEEVSUpfAKAaVPtpjfhnd7DWHmtCeiXIWY0CS36DxBVT6ar0jC8UDkbWGTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(451199015)(66946007)(478600001)(6486002)(86362001)(38100700002)(8676002)(41300700001)(66476007)(6506007)(7416002)(4744005)(52116002)(26005)(4326008)(66556008)(316002)(38350700002)(186003)(1076003)(6512007)(2616005)(5660300002)(2906002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E//BzYgxjMqoZtPkMgQUC7oQBOiCgCkdFjv6fQ7NNjNojoGoHqhZgU267B5p?=
 =?us-ascii?Q?4EjsMDmyZElxjsJnEqtgrbe3R14zYWUVbtgUxM1R3xdH8VZePMSYg8UwzlbH?=
 =?us-ascii?Q?M0XKiSq1VQCcoZnb8YmvJg5FpegjB5KTm3uS5OqFI5BsjhGZW7Wseq9ZNXRh?=
 =?us-ascii?Q?txCoSdilUK5IoCdN9zMWGV6WCaDuUFUlvL2z38k+ivTKmMpvI/1FWQPXKRCw?=
 =?us-ascii?Q?ZZHFkwxh6CIu4QczTnQxquQP58TqN+EHQ1F8TUIlua36wvAV0YMluK7uBtOB?=
 =?us-ascii?Q?LsKNPMzcPeA1Y7HG1xuhiJC6anDtsM07m7bjVlTk5P69jNihhHBJoontQnMG?=
 =?us-ascii?Q?xYmHl/Vi1x4HqIXCuIaJrBJ1BMfyRlrZdumbNB82iAcIMnTTbaJEoiujW/Tk?=
 =?us-ascii?Q?waWieB7Ymmfh6oCZ799ZZl/Nq0tcGBnWH5ZZxmC0mMDV0xe272NtnJpS0QDF?=
 =?us-ascii?Q?J9OF2syN4g8D9j5xfnWFf7jxtn2VmFiqP5inTqX9T9lOgb7fjyTwk0Or4HZO?=
 =?us-ascii?Q?aEYBOnCFR0Z3D1onbmEDAfk/M4Au+LPIuqkt09d2V8qNL9KXor/ht3l5jbCq?=
 =?us-ascii?Q?o/B5kMeZ/HbB+iXOGmCtewH5M0NXj91k8/JshiTi7mD3G8KXJ7RN7u7jyrgA?=
 =?us-ascii?Q?05FINJBRN0ncnLA8oPX1aMRDqaPjZNw3HosNOM0MfihE3bAquvXBriu/nF+q?=
 =?us-ascii?Q?wSnZcjmi6J3O9AmdR4nE1vlWwm9cfHd5tgQ8JTchS0bFxxsJPc8u0jPQyCjQ?=
 =?us-ascii?Q?0bb4C+eqeS2TsCtl1xj/wPR7sVMSibWUpfv1As0bPXzhSQ65uRLhS3DPK62/?=
 =?us-ascii?Q?9S4qkY9EQ1/PVr4FXautN04FkRUyrzLhjCx5uJQXY9ViJfHvd7FQxbHIlJ77?=
 =?us-ascii?Q?ElDtenNsqqnb4gtQCJS8Ub43ipyRHBNC9dqGoMoZ0qEkKMDWIqHwStp5pv/j?=
 =?us-ascii?Q?0G4ZMGO+UckMkV7n4Z7aMyWpFVs0YtySg6cRkQ5zMvWQ6y85VhG/lRMBNX1a?=
 =?us-ascii?Q?WAwTqTVolKpOvWVGhMrquKvBjI4MJs3Z1UOTgau+zriCLdWU3wB5LEPiKusM?=
 =?us-ascii?Q?1VCzEJG0N714sKfQhc+SYlTiB+Zs+OVyPsoez1jPb+lccURYhpYLEwU256Hu?=
 =?us-ascii?Q?D+u9L3X8Mjs0kSrBCdz/j+7/UIvZ5g6OCsspXmqHm7Ctea4GXeP7AjBfABxP?=
 =?us-ascii?Q?6gNfDu1dB9HkAWbqT0uqCYVWMTiW7yLFAvD+bi29LjzF4DZyi0N0jHEFqf5/?=
 =?us-ascii?Q?kz2YZH78heN5/9cDS+TDoS+gDEGukith9GfgZCUnv9A969SfsJy1jIrSleyV?=
 =?us-ascii?Q?3hXuBqEGKDKm11e5JeiaB+JUfkIZHlzxA3KxO/MPueMxrT6SM91y3MuDHXqZ?=
 =?us-ascii?Q?VCAXBghM9iJ4kxn/dujUbZmkXZ/Mxa5bspMflQUd3tDw7KVNCWGwprCrZUce?=
 =?us-ascii?Q?Y1W8uv0Hy3XTECW/v7QYP8AGTQDFNOHCLD6NCTGHTaB03G3PhdmBF/g4Vthj?=
 =?us-ascii?Q?FSxkUorPKYwiWvUqvNwwj5EF4tnHVy4Wxb6m/DEwbORIlrasZ6fI8RcR9Dck?=
 =?us-ascii?Q?iI0ilimtlQ8NJPqaBfPA7mCUdEa0XYjjuwkiLNBP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4178a12c-7159-42b6-9dd2-08daadc98e2c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 09:50:41.5728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IpBLTK/gmzECM3dGzWr1fqDauEHbOlsZdfSTz4fj0I5DWuQUANoroH/0A0bbvxtDeIilFiZ4tFS5iEOoNGCx1w==
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

Add i.MX53, i.MX6SLL, i.MX6UL compatible

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
index ed03649f17a6..29ea427861c4 100644
--- a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
+++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
@@ -25,11 +25,19 @@ properties:
               - fsl,imx23-usb
               - fsl,imx25-usb
               - fsl,imx28-usb
+              - fsl,imx50-usb
+              - fsl,imx51-usb
+              - fsl,imx53-usb
               - fsl,imx6q-usb
               - fsl,imx6sl-usb
               - fsl,imx6sx-usb
               - fsl,imx6ul-usb
               - fsl,imx7d-usb
+              - fsl,vf610-usb
+          - const: fsl,imx27-usb
+      - items:
+          - const: fsl,imx6sll-usb
+          - const: fsl,imx6ul-usb
           - const: fsl,imx27-usb
       - items:
           - const: fsl,imx7ulp-usb
-- 
2.37.1

