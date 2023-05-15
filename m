Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876417031B6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 17:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242450AbjEOPhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 11:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242439AbjEOPhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 11:37:43 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2089.outbound.protection.outlook.com [40.107.6.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045F019BC;
        Mon, 15 May 2023 08:37:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WJ8tZbC+OQr86FIHfXsuD7HJ8nb1gSbvEwH/7f5po0id+RnYM21FZ8bY9icYANVF8EOxajyny3lyEH0gxX6lLqtXmyQ7gQidRN/eHVN/Az0fN3NAd9mv4n4qxw1l6MRlq78/ANquCgnf1vL9eM9HUBM/6BxEQWVlbDlUnPOvboFZSL3SDjR5m7ywLlB9/udwJamvqFCEh66fkc7Rs3+Yc68Qyz1qkfG58vjOCtaJF4r8G240qnh+MqR6i8lpd54+PoEWeyZT3Q4kTNaAJ6G3yfF9zti1+gyMe+i0uzG0ABzB+bYmf1kCoOg8mLMErnR9hatt4rLs+tncJVekctLR4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YyhdutEfxChnbqgo7yb5kxN7LsM+HotZlDiFdbP3YOQ=;
 b=LKZ7aA8g8lJ1qJQph3y2GgbvTaC0POOZpXPe8sBOdj9EGa8FBqGRzCGre6ckxKRVyVOyfdJCNoEMCOIeE3hDiGOrTTMJJW1ZlWNJKa0AGunBeXH2eqII2sfD4WUSoKQBcnXO1U/TmSA2omtXzicsKuxom9nYl3YeFcdfym91qL0bGZ263ONUqGVSWHT2rYSzBUo8ANiF4Bl6i3Bynl63GSTp7yqgBXw2Mb47mWonVRYgoD4xSXOr+QQuQO1aArqkcWAHWnA1lBvCcwI1dXSbtcbbkOyUViziqC6OkQvWL/Plg8pArLDYgu15BJIdySY1QEUrf/w6XqHLK4DRPMTKoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YyhdutEfxChnbqgo7yb5kxN7LsM+HotZlDiFdbP3YOQ=;
 b=Ca8G4g2xl/vCIoLdtET8w+uXic48+D59qPWGiguefh+iVh5scDeU7tCXm38aGcGoL9WQsM0FW3D5oiqi4NhsJY3XKIW/zcPsrkMbWMaR9m3Uw9mwCa5IoJPj0RGXpvfxE41/IQco9WO/oiQSRcQ+dGhmWDW5KkFWc3eU+FHIWC8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by VI1PR04MB6909.eurprd04.prod.outlook.com (2603:10a6:803:13d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 15:37:31 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884%4]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 15:37:31 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     shawnguo@kernel.org, Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Roger Quadros <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-usb@vger.kernel.org (open list:CADENCE USB3 DRD IP DRIVER),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Cc:     imx@lists.linux.dev
Subject: [PATCH v2 1/2] dt-binding: cdns,usb3: Fix cdns,on-chip-buff-size type
Date:   Mon, 15 May 2023 11:37:09 -0400
Message-Id: <20230515153710.2799008-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0030.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::43) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|VI1PR04MB6909:EE_
X-MS-Office365-Filtering-Correlation-Id: 40009bc6-bc57-43ab-5e0b-08db555a4bb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SyOu2pXIEzaciiJIBtnH+FuP3SxUjyyMTbwnF3vFZdPDMCcoStZMzqtSGKZuVhvF0f2ozE0XUy60oaz6L1ZxZPuinwNV2UTgeScpZxn6Eyhq0ees8ftoTkDJDzGFkcnbTSHy3YeV++f10NMvmCy5UBZCGCFNAB7SULa8VFblImDV9lv1bcpgME5J3touIyvrsIMIQ0V+DG9XOTSgyBIpQG1hXXm0IoS+mw3lLcoo3RmJ0EKSZelm+t/jQn+a8LeLqXHah+081uxq3kTtyU6gBIPenuROI3D/CG9JHAXZr2forYw8kLVmw/xwf2zcLFMts/AegA1fJPTfKGNEtEk1FTYn6E706wBXpj8sPvmhbDt7BAWkV6JjBNSS3w4TmWt3BbHf8mIMUcqetCgdXtshZVME7ZCUcGbIDChzE5vnFyJb8bORlzG/WbsZ+t1HG5pVlT38DBqhheePTwWLu+aVCWd29qgHa4SSzJ/fZYszRKDBItI6aW8PWfWL2SzX1XtO6ksRaZnFVgSjW0Q9h1tvKbyTdcVhGin0b/rZL39BNHZhmMncx6dfrXNrCRbcPcJiTjwa8/xs5JaAnYIRaEKIxcbQhYBteO4owCLUrQUt9lL0MHdyRR91wYKCR2l242cDo45s54SfldCyrbBwwXhJvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(396003)(376002)(39860400002)(451199021)(83380400001)(66476007)(66556008)(66946007)(2616005)(6486002)(52116002)(1076003)(26005)(6506007)(6512007)(478600001)(110136005)(6666004)(186003)(7416002)(2906002)(5660300002)(4744005)(86362001)(8936002)(8676002)(36756003)(4326008)(316002)(41300700001)(921005)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9wWcVP12nE8lvfGUp24QibKuJ3/sbh3TeN3VCeJA4b4lM15a07rH0920hle1?=
 =?us-ascii?Q?lyUy6dlvn+21kXJIui+/VkIBA9Vn9lBRTbmnNTNdmOfPlK1h4TS+xU1MwJIX?=
 =?us-ascii?Q?CTz78N30GH5EP5+F6UtZHOyoCdkY5IM/XsgTfgk/c2MALQq51uds8Fli4eTp?=
 =?us-ascii?Q?A6AAX4nJ7EKWcE0dhcxsG1zFqx0/wYnIk7htC/+/IPYMNOdbzZKCaH/eXh/G?=
 =?us-ascii?Q?oybtsSo9hZGCDFr8tCgHM4oolKTYrJhPTabB1ur+IQKF15+Rx5yTxuO0sGU7?=
 =?us-ascii?Q?IHz5XOPHlwzQtx/vpJNXZykJyoU1bo7VkPZOWklgYKlv4UzwK0FvPcCNCSXV?=
 =?us-ascii?Q?g6ltxIMqpB3/XaFk5Be1l0u4cEphDAAB7EWnumxcTacjQ3YTLfFJ4vlheN3C?=
 =?us-ascii?Q?lqpX5cSJP+PVAohUZnFWrZ8aIVlc19jrJy/Px7p48ptkC7sMtQ7xF7oAFXrh?=
 =?us-ascii?Q?XIhvgqfcd7MR1Gr4+6PSOU5D9YvpmBQK6gXXDWDkdpvoMqrRjjFd9xNmiaLD?=
 =?us-ascii?Q?MoR9SRQ7dj/gkxnLN4bVSy5pqitMCZ2ddv5BoQZSw63LCfIf7EgSoiSs11tx?=
 =?us-ascii?Q?R07eW9EmqDJsvIskt1/MdqkRHlOUUGjKwUccx/WhzwkX4HOz4mzotiXHYj6D?=
 =?us-ascii?Q?Q39TsDdOeThfP4qQgQ5ySxehfRfvWwFayvURHLcLoiRRoiHRaAjPwSueFWYR?=
 =?us-ascii?Q?XjsZVnOEqnAFg6ktFVhEdK4wqYzxDHsgK1p5WrwS98zKt7fw0zx+fztHDoTg?=
 =?us-ascii?Q?gZewMNj7S2Cg31tHFPdyOYcLZ6e/TMyfB6oktNg9Dg99tgcyJ27jwHQluFLL?=
 =?us-ascii?Q?94DvEvZNQukWQC4wkmoEZJKFbCRpgofvcZjZZvI+eUaQzHI4zwDznNvd3OG5?=
 =?us-ascii?Q?eExBM3MTMmK+VbFFXEz+1qP627kkPyhILtVmabZR6sZG5olGnbS/FIRKpqWG?=
 =?us-ascii?Q?m//mzKIu9dkcX5U8qkrtPJe0ZZtSk40H31xGwPuY6jJ4CDAPUBm8U0jlE6AT?=
 =?us-ascii?Q?DrzGuvEANALXve/zREoLPNLW1mpeSelh+/hwlXwQvPW9+SjAF8cR2jmgYEBu?=
 =?us-ascii?Q?/PU9QPtrIOKvHxjdM9ipH8Cy1O7mm6SArvu7/02D6jE16hYxghBds48TTUM6?=
 =?us-ascii?Q?QhbstVNyz65rSm0RFr9W9OQbhi+APSnfD+cAKWxoyLZ2fMjCk7JMgSRacoeJ?=
 =?us-ascii?Q?KK0hQnnTsZlMDp8q5a4LDIPZ6IK4yfoPk3RlfmdLjjsO6t47dB00wK2m5NNF?=
 =?us-ascii?Q?9P+wCAzBsRnfY8EPhoN/CXcAsXOV6ZBzUtWD9Djjn++XnM3sjhMAlroNDNtE?=
 =?us-ascii?Q?7HyWI/orY+n30M+UHfodJrcOFmaVSwvzvu0zBQGNm/RAvYgdBh4Zi5jUUeng?=
 =?us-ascii?Q?0fgZiIOwE4GwXX6fMaDw4DP0oULcWKsLMjNc6WqzYRGjU/UMwX2pgBu54Wvu?=
 =?us-ascii?Q?ZkK1iG+EOJ0KKgAs5XJNFZmCLXl3mZzZ6R8Ts5ZiB5hLlcGKy7J06io0kKiG?=
 =?us-ascii?Q?lelGu5SSzVQ3ZzvwSvqUoeVJSYtBsAS/3fwZMeot6Vj5fXIlF1GKqXzTNltu?=
 =?us-ascii?Q?2oXUWX/J5YPANuc1kSE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40009bc6-bc57-43ab-5e0b-08db555a4bb0
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 15:37:31.1132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r7d3FY/eeeL4JFcX66YXqsH1sAzGEUdaGC2llUUB5qOi6FSb/IOz4qXvCSkreJc/kKLKIrBcraawQaeAxT6nBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6909
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In cdns3-gadget.c, 'cdns,on-chip-buff-size' was read using
device_property_read_u16(). It resulted in 0 if a 32bit value was used
in dts. This commit fixes the dt binding doc to declare it as u16.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v1 to v2
- new patch

 Documentation/devicetree/bindings/usb/cdns,usb3.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/cdns,usb3.yaml b/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
index cae46c4982ad..69a93a0722f0 100644
--- a/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
+++ b/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
@@ -64,7 +64,7 @@ properties:
     description:
       size of memory intended as internal memory for endpoints
       buffers expressed in KB
-    $ref: /schemas/types.yaml#/definitions/uint32
+    $ref: /schemas/types.yaml#/definitions/uint16
 
   cdns,phyrst-a-enable:
     description: Enable resetting of PHY if Rx fail is detected
-- 
2.34.1

