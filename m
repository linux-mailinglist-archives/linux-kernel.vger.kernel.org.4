Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385FE6A2FAF
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 14:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjBZNDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 08:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjBZNDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 08:03:47 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2080.outbound.protection.outlook.com [40.107.20.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37419EFB8;
        Sun, 26 Feb 2023 05:03:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JUoDQ7YaCIIkXTvgolla6/8XO8ThYHuzvBJPW5V0xCzXvIpi8Z1bMHPKea0xY3kazOsrdgJMuIBue3uk9KGD4wXQkUhngR2NVloLDNRHQDypGQbl9xIDy7xgbet8611+SLq+u+8mP/gf3g6oYtKoF6vsmE01Y0rmTFXVtBJL2w5iu5aFpmpqPMzlMmwWRYN2icUKigRzGuKw9wsZsjrNbDRIw6I0KowMllKjZF0Y/8YlCtpq5T/uw9p/ipn3UBcu1Eb8IWn4Sqsukhpdsy7BjHLObwN7KW8DDeu6+SEt8tI4zhfkR7qUmaJ9XnCiJYWbNiQdrj+7WVqKUbl1d56tFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMhx5gaFq/eVZn6hEAQvAmcyOS5BTOrsYtlZmKioKn0=;
 b=DFaHoXI1O7yvYCIjim/3YP0Feg8vSydXFAi0wsDG4kzqeNHMTszG3jTaQSIBQxeaxE/KV1iLkUQXuow/B8+gSfwbe7hijR9+JVPJcGt+fObtvFFuaRt5BQY3FmWJNOyrlnVPOPZvOYmbbaxFFg5iy67p8glxwbxYEzCiJElXUi7GZL2qmAwZLPggCJVqkWadsPOS0AMaofR7JVmQxM7ByViYIO3i8eXrLRN7h+rBJEJixxSD7BOHlfb+RPhYceytnP43Jctc3nwen20O4A1v7KiseqRjId5j7sVf98BWO0m2dFSa7k8i0PZn9Kp8vuPUqj938vRhS2y+/fIgiVHTlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMhx5gaFq/eVZn6hEAQvAmcyOS5BTOrsYtlZmKioKn0=;
 b=jkY7Iojd5uZqfGk7tqS6PmbBJpMTHZxtAwjxX5FBMHYrYJNhF+ZIXiH3IdyIroc1vcutY1TgWK7X/FhxVmKASvTf096orC5n7rFpcWlm+elnsrawkwlflTFWewzbViyxlWis2UD1fi5nl4q/2aDMLRq4aG28iWOjrVSETUHUj1o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8968.eurprd04.prod.outlook.com (2603:10a6:10:2e3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.27; Sun, 26 Feb
 2023 13:01:05 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%3]) with mapi id 15.20.6134.025; Sun, 26 Feb 2023
 13:01:05 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, xu.yang_2@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 7/7] dt-bindings: usb: usb-nop-xceiv: add power-domains property
Date:   Sun, 26 Feb 2023 21:05:39 +0800
Message-Id: <20230226130539.277336-8-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 56430bb9-ca8e-42b6-e011-08db17f98518
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gnemK1scHyFp0MGaDDStJX4AOFjYTHw0KoCGjHFErUiOuKrIYaeYwQAhxBA1xiNQCDSY2KUXF7vKYdIpNdW0AKfdnxn5ayU3vt/r9J4VJ5EuQFU0Yds88+wC+uxR6s3w6nspvakeYgcQ+fLaeIVkXQeZmDH09fKGSuWNmick6ce84S9L4bOVTTQH46AFhKLlrOVwcCwR/AdfQ9Srlz7JKqQ4x3LrZkLEzNv9Uh/PeJJwOLeCixP3zr35HYKcZ0Uv/5ydtN9DoV3udNzPs3azVbSrwbmnGQTNcJo58i8EkAHeCf8qCjCCqCzRNbZ5LBtvsMOVNZ68yZ7yJjKYTen17D8DGE3rBGATJ8av/glo1ydruqFKYeqcuprbnJOW6ur+A/NqQH/SrwnPBxrfmGrUJRoUyCBIWfVXIzbAbAmC84/mtyfAu/moC4jxyS4zjywVPflck2tOmnYF7kSJRtXBpYfe+k8VmlesBB0d6ibUAK13FxjjCaWIIiJVZWq9culjWzSmmNO1acFcK+Az6PEGk0t5E4nYY2CksSEDRRRL5pAFhISgZoPT3H2vvVw+1IMatJP2VIoo/pOuk2octxD65C7kTF7Z/K8igqLkDqs8UYdvYIaO0LQ2eG9BKr72Ugv+WNAsUkf3DqyEd4NwO+4VSOG6KNm3SwXYJEIiMP/S5YcB6UWD2B89TLoNoTDwFjdeNeK3EBpCat8XappwUMj2yQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(451199018)(8676002)(6666004)(38350700002)(38100700002)(86362001)(8936002)(5660300002)(478600001)(7416002)(2616005)(26005)(6486002)(1076003)(6512007)(6506007)(66556008)(66476007)(4326008)(4744005)(2906002)(66946007)(316002)(52116002)(186003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?csb+L7bCCjKOz9VwUNIxy/JtuiM1x90wGzqe0U0wQKp7zdSyLc7kXRvzk6FJ?=
 =?us-ascii?Q?/pq+hSMj4RB0LAcTvdppN7CwBPtzJynCzD2t3th8LWu7+ASSgC1jtQW55Toh?=
 =?us-ascii?Q?GLq8po3IbrqcjcMYpoSFI7l4i+tFDa8dV+RUeyVfSgPineOKQlEH+vsuGsCl?=
 =?us-ascii?Q?A/sgrMky5I2TT3+XmN3TiraWGffVIW+FaO0WtD5aS4DOEA+Uq9vL+GflYQLa?=
 =?us-ascii?Q?A4Odjw352Ru8J8Lg5E1R6bs0UyTbFM1QDtajWvCMFvIwJ9h4G8xniZS5bLOg?=
 =?us-ascii?Q?oAQxt3nZjp/wHGl8EWURj2k4L6IrXMT9HLjk7+NZ4SoN5ouoahbZxPF0HiA9?=
 =?us-ascii?Q?gTNcvUUDDo4cw/LPq1UnMx+5YY5/+cb7Yzl6cogeHKtOLK5dHYJ4pQ6zGGMM?=
 =?us-ascii?Q?gcLlcnnKiNcXPYIsK6ydZO4Orxca+vfsHo/CQS7+6Cjr4Q2fSPhR8pMPSSUX?=
 =?us-ascii?Q?7rhAVvXehl078UBRnxJ34feDxkkf2acB7YmGaJi6gxgZ58iDq8LDElASu+mk?=
 =?us-ascii?Q?dKhdmDHmNTJO7lYLtipGJ2h2H5S1NQLLuxIjVPYejeCKVF3MPkDmQvyAfMw1?=
 =?us-ascii?Q?o+jW66eC/LSUVKIFWLFeNcprVTiDFnNcXc1jLKKF5LHuMWS0GQhA9lm8oVZn?=
 =?us-ascii?Q?Bj3/qTVxMQDdRoaWFaJVp2ieEGx6AeIS8Efpaqqq5VX5kCxcSU9XESZ3Ub+9?=
 =?us-ascii?Q?47GqRYl6cNhBgEi6Uqq49G6s5GERh2P0I5UhcFVyIlFSplf2PB/JHMxjPtQU?=
 =?us-ascii?Q?BWV6/0wNRzm5FrZultbwd/Nrx/uvX/uIiTQZFCPjyViTijK4QoHNsx+6uNjB?=
 =?us-ascii?Q?G3Wkcg7ueeMTB8KYhrj6pmp5WoNbBVmQnH3U2g8R1Md+SIiBlx312EIaAYkL?=
 =?us-ascii?Q?pX/w0PxUSRZUX2rAae6q7gy1ByFEWL5zdK92TPAlI2Qua6Qm4tMbgH3yldzP?=
 =?us-ascii?Q?R9ebCvy+4wzeefnuh7LVuArPy+Aa8yx/2+Hw2NSA9s9hZekvGLMyHhUyCfgJ?=
 =?us-ascii?Q?R9IE2pvzP9M3rdbZe8l40RpGVpB+wKsCiYvrbjSHFeT12F7efPWGFlMJkdWs?=
 =?us-ascii?Q?2vfYtcGn0SvywblMAWZFkSfMpaJQtzuiXoYeSQ2Riu+AGRBtomc7ggVwyDW7?=
 =?us-ascii?Q?udbFKU+Xab/+mndUoEtTRshCuoFGxjb7S+okUpTkt8i1qCQ+1AuOPOL1wuRU?=
 =?us-ascii?Q?M4JOrd60NIG0FfajyC/qWjvtoUBotI2XEE23tcFbMgp/E0Gm9YovvI2lGeGO?=
 =?us-ascii?Q?gOqNSL/JvP/DplKNAcR3zToCC8LI6T0gjMfWez2nOpRG+BJSaS/bD7SQMQQD?=
 =?us-ascii?Q?rtW6ISQbPmvqLj1/nux/EbIah7I5qibJ454QWv3SNdjonGOl3zEp6uD2BttZ?=
 =?us-ascii?Q?5l+2tcHOGfgyXEi4Tx4orU25hJbh50SFSNpF+UUzpjunuLwIQazQSGwmqs05?=
 =?us-ascii?Q?3BPxdGnJ0dIGCcLOyYPXcQkRkKGhsquz3GURI3oH3Vsf4R3fbnjgJ8Ns+K/h?=
 =?us-ascii?Q?QbvpcPmjUko7L65F388BV5ntzCKyZMqnJoE5yHM6LW/sCKa6mY+EpnOjs/+Y?=
 =?us-ascii?Q?DOI9IPLXZ7Q7xYgh4QDqpvE2shhJLcFgqXxtXWPt?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56430bb9-ca8e-42b6-e011-08db17f98518
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2023 13:01:05.3789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2QE75hTLE+Dd/oGr2V67WBoq/6rpfdF0UFn+19BtCPkGINGZxby/OqTzp/8qoyYL+vRUENrK7PcaC0dV2yXJrg==
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

Add power-domains optional property

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/usb/usb-nop-xceiv.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/usb-nop-xceiv.yaml b/Documentation/devicetree/bindings/usb/usb-nop-xceiv.yaml
index 921b986adc47..6734f4d3aa78 100644
--- a/Documentation/devicetree/bindings/usb/usb-nop-xceiv.yaml
+++ b/Documentation/devicetree/bindings/usb/usb-nop-xceiv.yaml
@@ -27,6 +27,9 @@ properties:
   vcc-supply:
     description: phandle to the regulator that provides power to the PHY.
 
+  power-domains:
+    maxItems: 1
+
   reset-gpios:
     maxItems: 1
 
-- 
2.37.1

