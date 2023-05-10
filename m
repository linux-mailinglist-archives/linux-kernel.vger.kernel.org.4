Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF676FDCB4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 13:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236913AbjEJL0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 07:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236890AbjEJL0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 07:26:11 -0400
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01on2063.outbound.protection.outlook.com [40.107.222.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3F71FC2;
        Wed, 10 May 2023 04:25:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PSO4QD/DOnvZuwsVgN8QqrVhLO3NgtHhCpAYW4UHvhsVfiCiDgkmh7PWjg+po7W3w+W1qK3CTERk+zWMpGdzTKc4Wh14iR2uUUptLLfxXuCIdsLBkZDAS4YjHakm0iIe3NXmMqVnH9y4cQvdWh47MYUN+nGRrtB1rRKaQ8+IQLp8EBPvPENnAER5pKBRHb2RfN48tKta66GktiF7ppjKiKaoZ01SkkFdze2liBsfF/+i4ZkUirLVlIlIVMMSstfmohYqTO9sXEYyjJ4wA8jxOCcu75IjhJ2SuQWCr8n5taQQP3jmXYmTp/CI1w1IMIXdM/B+b3NnCBsQijWwyJzK4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2qDYFjErdaOZswKTfpDbo8VVghZdtr7lqGHuiAhsEE=;
 b=fpktPq++YMjswd8hn/EO8NLmAJu81nWN41gSMRalkkgriQ4F191BK6+VCMu0Zvrm5xc242xAwG8kZclRSRT14lOEormlSu2+cIHqh01oH7QNEAhePLn6FJ1lJUwmssD8CxDH3EnHq59pfQ3Te9FzxzWPCd+yrfLbWOJbs0u5ZnTLFkSlQ4e63EN93qYC8yXYNOiJFJrPqeL6xfeCqzashlyHnVbH3wXvLTAMRaGKsuhec9DjdylBM3Cgr5fVzHyh42tnQb+vZ005nbpA/HmzJxwlyxoWqxCoTJNCZC5X1u2vuSjmQZ5OoW0gHbLEbpwlqhcTBpROhH2iDZrmw86fGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b01:b::15)
 by PN0PR01MB9138.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:165::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Wed, 10 May
 2023 11:24:47 +0000
Received: from BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::a54e:e611:b89d:7470]) by BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::a54e:e611:b89d:7470%3]) with mapi id 15.20.6363.033; Wed, 10 May 2023
 11:24:47 +0000
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
        Stefan Wahren <stefan.wahren@i2se.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Markus Niebel <Markus.Niebel@tq-group.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jagan Teki <jagan@edgeble.ai>,
        Chris Morgan <macromorgan@hotmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 3/3] dt-bindings: vendor-prefixes: Add Emtop
Date:   Wed, 10 May 2023 16:53:41 +0530
Message-Id: <20230510112347.3766247-4-himanshu.bhavani@siliconsignals.io>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230510112347.3766247-1-himanshu.bhavani@siliconsignals.io>
References: <20230510112347.3766247-1-himanshu.bhavani@siliconsignals.io>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: PN3PR01CA0092.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::10) To BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b01:b::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BM1PR01MB4899:EE_|PN0PR01MB9138:EE_
X-MS-Office365-Filtering-Correlation-Id: 1815bea6-8ecd-4f28-fd5d-08db51492947
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k2S527wWliYVdLSCxzdkShbj5+8o1W/FevxCF9ZKpfWT+7Icwxa8S4lux5B2UWlV27W2wEKiEeh3M96/Va/pT6wa8QMpinyZ+bsyZu37LwG/In+XD3TSiAKq7LJQUarjWlDERivxlKC0o9siWxc084FnsKmIz0oEvfb7Ky+u72mdIxxBUmc4uXQBvxpaQwsHOXJgCYir81qSl7ZuOpJgtj5ZAyOskeSGsCF3PFKlaP8mtVixTBuMizJMNFg4KedutPbwz7e72FlQoUUv5M/UU2lxbksET1XBZguXwkyyqzVDj/7GTGayMY1Sa0FKwuGejVRj5gzWwMY92xmxvT2S3ENZCxYHGAxuDgzDent4bLVvlaCB7PvGwa/3hy3ZQfB/viiwWcKS+sydr1KBucxIDz0J4S5FRJp74AU2Q0lh03k3VJGK3R1+aDpmP3S7X61ZQp5ntgwcJ87MGCtz685zcT7fCGcI3dDO3/xcl9kyVeeg0RuRu+GZByJ9Ug2mArrB8hy0AZ8I3Pvvcwtq2GIUKF7sF2zIFzOrfZA3LGHAOSZxJHTCpwMsytSreLcx2FNj5fTEirJB36xriHuxXNqiSehdw9naCsBDyRfxxgcnMpVtxLQc6vXoKcMuhO4GyDwi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(376002)(396003)(39840400004)(136003)(451199021)(41300700001)(38100700002)(52116002)(6486002)(38350700002)(44832011)(5660300002)(7416002)(8936002)(8676002)(478600001)(54906003)(316002)(6666004)(6916009)(36756003)(4326008)(66476007)(66556008)(66946007)(2616005)(86362001)(186003)(2906002)(4744005)(6512007)(6506007)(26005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iYLqLR6md+KPiFzdKFtAf+WaBvr12VP4do0DsIYKcQVcv5TmV1SWy532HSGT?=
 =?us-ascii?Q?TTs/AePoKnumgypHM72d8YMqWgpREqUs4JUMXEMrD+LShg0jepmxgBRO3H5X?=
 =?us-ascii?Q?EwXLkzzF33ZvFA3pgkOgBkwys7uZnCqMd8VlLomzod4AOs1aTkGuSw2/G1Wx?=
 =?us-ascii?Q?EHbmZJjrGDJZshflDSjYRHU4CMzaKOt9K5GD+FZbF3umD7itG4qZIKddIObl?=
 =?us-ascii?Q?rL4Ipy/ljUOr1oLounR3pUDczMRqn49HSpZrm997vkaiDFwjuTPgpGCoZj6j?=
 =?us-ascii?Q?Lmmqhiplne2eaosiYf5ViCQpBAfvfMqLklODNcOM3GiqTiic3iw0kL1B6jtP?=
 =?us-ascii?Q?D8+phC2bTBo7Fyn0iaWDoLbil/xdK87/fEj/C1bdZW1g1fko8AqOkBIT21v2?=
 =?us-ascii?Q?GFCcP6LD6nIoITDKLC3fhPQeuDIj9zexf6Uk9E1GY5qVgKctenw34xnd9hE4?=
 =?us-ascii?Q?65eFphfwD1wnX+A1vqyY5eoZSce+iB8WsMRTupZY1lWQW1k17Oa0R1IOFi0q?=
 =?us-ascii?Q?acmA7qrgkTXTkHMfEd327prR311iC+46nEgL2zcB/vcidcUqO9/XUrrExUSf?=
 =?us-ascii?Q?2wMIkTorOGFjmk7745onq9v6CfQ5SbVctypP8bwxdF6n+Xoqj1USnR9hmnAj?=
 =?us-ascii?Q?/Zfi5RiyXnJF/DXYoW50A7XM0xt0SxFeApRJZujBKZdkEbIgl3JXRIuU+NKp?=
 =?us-ascii?Q?rwp8UuEGPYP8H9zDCAh0B4I1Tmp/RjD+NC+NrYnkTYIvqRWuqD113oHT9kwm?=
 =?us-ascii?Q?6w+Zqyxtt2OS2/ogjFI6p3RFsrbjLjP+uP6655+lGe17NsSW12lGpQ1Jyu3Z?=
 =?us-ascii?Q?31BjcVzFFuLgzWDakjDJwamO4Y6MPbNEGtxUaS16hLuBytCDmbVjJrsRrROt?=
 =?us-ascii?Q?qmlsL8Wf4LcWPBfrudpi79jSQrnOhZfs6IkJKzHv0B4oC7z162z9pp4hokMJ?=
 =?us-ascii?Q?4jf47lbCLyyGFgcEA89tD5XvExdDg7nUiuEXOOoq68WSBLcQ+jaP/h3sVmU2?=
 =?us-ascii?Q?bd8DgMPe/K9CgnTG+E0E85OOk9edjsHegQtabKe7jpFELEzPpIGDbaJKC4Q6?=
 =?us-ascii?Q?RoZLquFZx7EY34WvwMruHJ8N3QHWlMFlZFxBKg0EsmKTnX7rq2qRhNDcuGZz?=
 =?us-ascii?Q?vTE0yMjjx+BtkF9hY0MEA0BDXdF5o8eocmA3sFV5Vf7/QitsSxCIEspIrLQp?=
 =?us-ascii?Q?EpfxqJozLRF7qx5qVtBVg7jyfjikulsWEz0Ja19vdtmZ6pi3oFf3V+AQ/IKK?=
 =?us-ascii?Q?fS9sCeYymIMOXrprkEpvU76+IvpGDWEbk6VLDG5DCZjXJFbH1xbdfymJ3woP?=
 =?us-ascii?Q?t7gl1WiDR5ke1pYjkgImVzNDOfwHpY/ekEaA8R+QEfH0755KWxPr9NKC4LgK?=
 =?us-ascii?Q?QRarLsk9TPslgFnyt97xPiF3/cIsTsWb+kmCkvaWCjVBV/e0lJXPG0NPMQPg?=
 =?us-ascii?Q?2iruNlEu0yK0A0E4spElmJcmWDsXnaVeqH97b8LC2aHizGQl8b0y20Pd45wp?=
 =?us-ascii?Q?D/TXWivl//b1sGWv35bPf/uEhw7OVURNHVYMh6ysKH/WKgXvXcEQ4JKj6N5l?=
 =?us-ascii?Q?T1GoHR57XyVweoYI7FW78MKjyMBSfvGZJjrFM7r5ym/JxZjQPmacTkxM2FyI?=
 =?us-ascii?Q?/NkgYwKMfiIHPRjHrWhDrkw=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 1815bea6-8ecd-4f28-fd5d-08db51492947
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 11:24:47.1372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PknxdaWZEih4AEM4N4rhShZzEQvz/pmX5FnNw0RuG0tMYkG8HT187XiLo+g+GOd8EAo/xSUWaUSEMfc6Im2y4Rg6eR6zW2Q1W22zegFEgte84w25a/ncxamVExV749GN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB9138
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry for Emtop to vendor-prefixes.yaml

Signed-off-by: Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index ed64e06ecca4..e6e3c99f6ac1 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -412,6 +412,8 @@ patternProperties:
     description: EM Microelectronic
   "^empire-electronix,.*":
     description: Empire Electronix
+  "^emtop,.*":
+    description: Emtop
   "^emtrion,.*":
     description: emtrion GmbH
   "^enclustra,.*":
-- 
2.25.1

