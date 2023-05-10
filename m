Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B126FDCA6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 13:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236883AbjEJLYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 07:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236891AbjEJLYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 07:24:30 -0400
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01on2064.outbound.protection.outlook.com [40.107.222.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CAB5FC1;
        Wed, 10 May 2023 04:24:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l5Ez/RXE+te5IdKUQ7PvUdz7Lg2QQeIakYgZ/Ma6aYSLTswelBnJ6zq5vQL3WhFuyBymQUiSr5czwhIO6/Mzk4VTBNuKnBGHSIA/TdDzzsSyhUsrj/TOHUiOhNe1pBOIgB5r+XzmalIxqLKycOWQm6XWOhJc2APfmHUB4S0oddazj4ag2rA4v4Ps0vSqNgOxJE7W5vhbvGrRRxs5DA6gyArX8rij7xKi1cVabqWcGQiTDIMY6fRQLUUze14+3NrbkmcW3Sb4m/ccaE5OIT0syj7+HmXT4TPwsE2sSDw7mk3uwDWUwSHbTT19xGge9rrDCVM5UStDgSprNgkQM99sxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5FADIMWd5Zluodio+a6NDpeDE90a62OZr7wdnKz+G3c=;
 b=RA/LIqnI5j6OuYjKFp6meVk3UYYK2JnXWC0U2f6iB7YpmBLVj5cIStA9WaGNQZg798Xr31NmVYllR6zeAFTmw9VuHaiIeNjdxttQylCY7UFnOe0u39Magm69mB8wKRWSAUWP9maKk1u4s3HMqNj1xC4TmN8LAnvz1GnHuBBz+0yJF/TcsBXznJm2OCpsRAvcCZopKRWKtHt+7xPEfMGdhdHOmosSKofbSjFp4G0aqc2dydICd34c9gOrV6/5mKMARzhAm9N3EHAscM4NK9DyFmQo1K62Gn5j1YseDKdibnlt2vmel+O0VZZYNlDCRQFg+SH1WQXizTbWzkGd8eksNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b01:b::15)
 by PN0PR01MB9138.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:165::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Wed, 10 May
 2023 11:24:20 +0000
Received: from BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::a54e:e611:b89d:7470]) by BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::a54e:e611:b89d:7470%3]) with mapi id 15.20.6363.033; Wed, 10 May 2023
 11:24:20 +0000
From:   Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
To:     krzysztof.kozlowski@linaro.org
Cc:     Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Jesse Taube <mr.bossman075@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Jagan Teki <jagan@edgeble.ai>,
        Chris Morgan <macromorgan@hotmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 0/3] arm64: dts: Add initial support for Emtop SOM IMX8MM
Date:   Wed, 10 May 2023 16:53:38 +0530
Message-Id: <20230510112347.3766247-1-himanshu.bhavani@siliconsignals.io>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: PN3PR01CA0092.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::10) To BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b01:b::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BM1PR01MB4899:EE_|PN0PR01MB9138:EE_
X-MS-Office365-Filtering-Correlation-Id: e6f620d6-2a82-4a1e-90f5-08db5149194a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3NImwOvnyh25aG1DBur9i7SxhUlE9akCqD5YYs/Lx0bmTR84ni7d1YixOfZ72mFtGmlHV+nfTh5+CWRIbFGXq1Xg5iiry0hID6iyZ7OCOi/gjgGyhJ69AfHXwi0XPFKDwDalo9kJ1yM3MNBCvi1kvGrPH80pavagySJ3tU3i5BoLd8p+xGL/LO9Y9GRxxLYCVApuhk527bpKme9BVCZIbfB8uW2w0Zm5deAiqdX/9Ke2wESaucwWGYnbtLqXfX1vBtqut5or+XtpYXr7TbbmtlRTrkNC2dXXRuZ7fv9T3tkgvL5Hvjt+IDTAntKfGUVUxZ+fw2b3vAYBkRraCFTD+PC5kxpxfWqlfe0gscNMgjgVeNs5L3MOUQOhGoSZTGwZCAwj4V5YP1IiG5NvjheGbstOJqv7GFDuQYFHecgUPs5zIX6v1nJ0RDE8Njsf1Jnj4Q4xlWdKA7vNkoVilpsA2rrznE2Mf9l4WzrDUBi684CoBGtArIfuPdgFE+nZvVnZi+WbdRTzx9GfL0m1494eJm2RfiurNYzEv4yyekaTxavDCyy0QR3JmwO9vY6Fwm37Svt2+sSecBYyjpdClN7qvfw7kdlEX7UROX9NKGuLzPm6kVeIcT52+qTaDTZsIupYhoSieZ0vIA3bGw8M3oJWoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(39830400003)(366004)(346002)(376002)(396003)(136003)(451199021)(41300700001)(38100700002)(52116002)(6486002)(38350700002)(44832011)(5660300002)(7416002)(8936002)(8676002)(478600001)(54906003)(316002)(6666004)(6916009)(36756003)(4326008)(66476007)(66556008)(66946007)(2616005)(86362001)(186003)(2906002)(83380400001)(4744005)(6512007)(6506007)(26005)(1076003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4laBIFg1JDvfgUzIXMfVcJVtbHIJ7ehcu5okQWsygydXEt/ElGt7E8ODDyuY?=
 =?us-ascii?Q?N5UfVGM+I/RxnU5WNEo3Fwqoh0Dk5IMPzqfn3atO6TdqQvX9hwTv7Tjl5UmG?=
 =?us-ascii?Q?EAumfBdWJUHEBw0yFyDhfFEtFtWrrAnjdzD5yHPhtIAQRoShP2ZhD4OpePg2?=
 =?us-ascii?Q?KtxN4ZjByHU/f0I8N8oParIIwbS3TgJ+CgOETPG5nwYIqMUZou1RA31MlZTQ?=
 =?us-ascii?Q?A1ieDvlxH+RGKFAyu0cP2tIRxADP6ZmuAi/gC/XYPTnvBrn6Jmg8FC6V5sEW?=
 =?us-ascii?Q?PTmuSrja5NEnR/5y5BX3hvAWsm8FTLrM7oRRGitTz3w8q+Ez6qR8Qss/2jAw?=
 =?us-ascii?Q?ZDImc/cD/DhD+ze4rYJURVIZAONjHqng8uFqMvItpLpZqejB4RNn58x0PrB8?=
 =?us-ascii?Q?Y1D3JG69CuTv5vQbgs/EbpKrWpc5BCo7ePSRT9gZ8bCsjBUiBhQfxHAIs5fS?=
 =?us-ascii?Q?j4PbAAGEBFEwctpLdkcRtPVfIBxRcU9PBm7w/A2YQhGRpLFlBqjG+ofZX5uw?=
 =?us-ascii?Q?wFbKbenPvhrhfO7A1zIdQfUOQAOWujgIdLiteyuA8DlxnlWwIjXyRW3EMM7r?=
 =?us-ascii?Q?GqG5sGJiuSsPPOQN+A9fNitkihqe3gRl0nf8EkmVTXaDH3DOOk0Y2nx0IQe3?=
 =?us-ascii?Q?m9IqvJeWakWpooNLoSDBBhjdb41LSzFsTHKl+lrSmkC65TWtcPIKOE4Ug/pq?=
 =?us-ascii?Q?LBDKyqy9+Zbekk98m44LSg3JPzoF2ufc6sx0Uk8wHi8KRMTOOj9slD9naPAf?=
 =?us-ascii?Q?HP9oPxFTLDBAM+LkYT9bTJdzWJSBoZbw7reL93z1mHs4iyz2sUsENRPWwUbG?=
 =?us-ascii?Q?zQNRg2lafJysu1t2hRFuCueABb4ZFDaCOwQmF+2FpFuy0P84FePkazYseru5?=
 =?us-ascii?Q?DebOAL2KG7iS+To1lGcjIDJp+God4K7izdyEi7/PhUOTpS33mB8LGjhY6EQc?=
 =?us-ascii?Q?SwooxO2s8TF4piNw/QrV5asRWClsYx3U0SdF2CKUxsXow+DwcczhaFDaodL7?=
 =?us-ascii?Q?FGJzsnK3CqyYZozYjT6cBmp4NpMblwtVD60sKZYcxOxfghMkdbmOwdYAW2/s?=
 =?us-ascii?Q?rY1uPblwPiTZZcJ5HA2i/Z7oHkIm3wY4EU/LjTgeowBZtMZ7d5NBhjkHG0sX?=
 =?us-ascii?Q?viGswzA0CdHK251dh5yk5whxzKwq4DBR7SPYfStD99l0VcNomHva9OAVWPFT?=
 =?us-ascii?Q?//IPC6Uy2TfqZ4Ra0fRAwlkincQ3znOZ4sfPY6AhC3rkqXJlZdweEzrYnrYk?=
 =?us-ascii?Q?uNKrXKvCZbBg4fDigIkXRFMiyE6f8fqYQlA7J2KkJ6kdQhFm56DLUzRdJQjz?=
 =?us-ascii?Q?+n0RdX20GM8s4Z2Ak6u0tKsaKa7o56EIdUEgnCJ/FpyN9f5CMGRe19C4r3hD?=
 =?us-ascii?Q?YWTqhrBr+6DLf9ctjgzqCMcLBm/HjRnMN5mf0c7fgunAhm0JXWf7CwLdiyzn?=
 =?us-ascii?Q?4cxR4uiuPS4LpO2SttDvg5vImF5lo0CAmQChsXWGBDKfCeHjo3KgYwwAoHSb?=
 =?us-ascii?Q?aecfIhbCL6S6j2YXjclPhd3ZBCG7vayJOUR/kMJXfaqs1Bf34D/ALSkHZSwm?=
 =?us-ascii?Q?5F/m+vyJB2pFUZybTi5NNy/EttyrKvdzT7tgX5J+/vKsXYX5pIYVtElQAtpw?=
 =?us-ascii?Q?d3tPP76df7oXCseUAhgogTQ=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: e6f620d6-2a82-4a1e-90f5-08db5149194a
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 11:24:20.2954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UewhiV4eSJGoJiANiHLYfbwRw4h5rjPtCFv+WmH8yC1Yjt/D8S/sH7jB0WNTr+IMTo4LbZ6Fl9vxgpqQ66bV39ZvMEBNtYHCPvUas1N9xB9mwcjUpzoS8IuHcV4u9hUP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB9138
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the initial device tree support for Emtop SOM based om IMX8MM.

Change in v2:
- in patch 1/3:
        - Update dtb add order in Makefile
        - Update proper prefix/name in dts
        - Removed stray blank line
        - Add pinctrl-names

- in patch 2/3:
        - Update bindings

Changes in v3:
- in patch 1/3:
	- Removed dead code
	- Fixed style and indentations

- in patch 3/3:
	- Update vendor prefix

Changes in v4:
- in patch 2/3
	- Update SoM Name

- in patch 3/3:
	- Add Acked-by

Himanshu Bhavani (3):
  arm64: dts: Add device tree for the Emtop SOM IMX8MM
  dt-bindings: arm: fsl: Enumerate Emtop SOM
  dt-bindings: vendor-prefixes: Add Emtop

 .../devicetree/bindings/arm/fsl.yaml          |   1 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../arm64/boot/dts/freescale/imx8mm-emtop.dts | 261 ++++++++++++++++++
 4 files changed, 265 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-emtop.dts

-- 
2.25.1

