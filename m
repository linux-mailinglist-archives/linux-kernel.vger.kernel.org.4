Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256B66A2FA3
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 14:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjBZNCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 08:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjBZNCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 08:02:04 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2064.outbound.protection.outlook.com [40.107.20.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82C712BDF;
        Sun, 26 Feb 2023 05:01:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Et1uOc9XmgTLj2q+TK7/lVDDLzswu6OYy5m8xi2QevqsKlIPylQngoAmhyWyyznP1IL3UCJln1hbcwSrzZSZ9ovQ8CD5sNTp+xJYYckX0FOh+1/LgaIJdrOntxPwDTkPuuX+JWQzwxSsyVxsmGOhJvqDe97R9qlwfVYDyDJN5Vo1wD8/up99rYoqOG/E4LDSfNIuKx0OCNeOKOBU/0juM/p1y+yKhLeW4gLA8Y+2xvtikUVpCtPU3ccr/J8dEvbYfCGgl7MByv6hMX5HkE0eWUCGFxBl6e5LYhBjl0hpC4omldTrM3VN0NLmWAq8zZ+5fNyRDVfIxBx2NvJP0sHERQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SMI9pE4D2ZpESde3Ls+Jv7Bxn5BVRazfqCNEvJIMi/I=;
 b=Ey1K6rf4sLXQFw7WTWEKkYCM2f4G9fDPEuU7qEBw6uboWSFZ8mooHRKQAJGn3m+MGYUlGfWP1yjveYDjkg6kU/eg8Ft+F5DJfCTg4adiJM4tQcSi3KwOg07HtimHA1/qGjSJAVT6CglKCEqwzAnctC6GZE43dBkm5PxdAsQoSDk6tVOvA8dN28Pji6j/qacxneLm2pds0Zqg5wFZI6TH12j8Ac2H280I+PWHpo1AmvBpm3dbMFNHo+JjGdjC/xT5B3Vrl4Mji5aZE6d38KSlPKWpSwFQHKOaKrpfzBDwaivNulzkxHfXt50H2cqoeHr1UmAfgDEGD+AP8uwmCm8Nmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMI9pE4D2ZpESde3Ls+Jv7Bxn5BVRazfqCNEvJIMi/I=;
 b=VCYLd29fFFS+1ZBGX2YCOLbyLMX+hbEEkokBtmhOCitvb5Yos2sYiSJIhr5QgO8gJofKJ3HNGx6IeKPufQrviRlmED1IuId1va1fs9RZHAx7l8+MBPEPnBng+mIhXrx9tniuyE72ht0lM/aGH6y7AzGOKb2bX71T8SAi1yKZ4Ek=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8968.eurprd04.prod.outlook.com (2603:10a6:10:2e3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.27; Sun, 26 Feb
 2023 13:00:56 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%3]) with mapi id 15.20.6134.025; Sun, 26 Feb 2023
 13:00:56 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, xu.yang_2@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH V3 5/7] dt-bindings: usb: ci-hdrc-usb2: add i.MX53/6SLL/UL compatible
Date:   Sun, 26 Feb 2023 21:05:37 +0800
Message-Id: <20230226130539.277336-6-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: aa195a5d-dffb-4548-f298-08db17f97f94
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WX+K4UgbMGS55HE0vSrXxctcKcse6smB5bpK40kl5fK3r/YMl5XYCYp9cv4h/y4xBHmhTm3XYqVwl6IXismD+Y0obryAbk7fYx+PGo/WqSOEhQMpIoPOnXwGDJ6jq3sIKE57I5bEwDyjeNUxIDvvy9Br0Iqosu1gwS/aNEP61a06t425DeY2yI5F5pMaX9Iv1bJ33SrdvjfhyEoCBfHWodYCV4e+zah7xqfKCTm0RkAVUOjwZEJUPBzxo0kl4hzhVWmPUWKqR2NgopyY0i1tY7SG3V0DfzCJxXmkuIphRO0nl2RjYKICNelsLqF/9ODfmg33rIHxxJM0WDUPcmnzSPhx54J+ZWgzE3DdYNkDiS1uGyvWM/JSB74H7vGBzntMp4Z7J7nrhwFE6xdblupObWbOyQfepDPI7/4/0n59Sa0AB4EYgpEN5rkCofpRUOphZx8em6mb8NQ58nwr6kvJbgQIfarHB7bTwBk52N8VJipN88vYCLTfbd5ul5zylkiGchvlUxupxmUP3xZ9D6PeRXJvF5RVWsg0lPgE4VFTmrcaZaxTH2M/Yz6ldfU6r/MfgRNdWBVgpkqV9TyLu7YQnhuOw321dpoXtxAHYPk7zfPSUN6IXF+Oiz0x0uYb/YOJvIS3pGhTD2Kp2sSx4ES5jcR6qer4s0RSpArejdcVkFvcCLxT5+1/gqxJZXTE8qi5lMF/2+86qSrjMaaDHfWHGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(451199018)(8676002)(6666004)(38350700002)(38100700002)(86362001)(8936002)(5660300002)(478600001)(7416002)(2616005)(26005)(6486002)(1076003)(6512007)(6506007)(66556008)(66476007)(4326008)(4744005)(2906002)(66946007)(316002)(52116002)(186003)(41300700001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SFVhPJCbqxybCgp2cwJFBF6t6G7M+RHDQUhqXC42gtuXNNs3Kh+kRolhQK/V?=
 =?us-ascii?Q?kJQ4Cug0K6RPq/lX0Bx2+e+ecqatR3K1nQkWvnUYjdi2n/1BOMpBsW+/2VuI?=
 =?us-ascii?Q?+vMo4P+JxwBaftAdX2km3L9kNDkfbc/JIuArVxldCY4dSXxp0A3oQ9cGl+qw?=
 =?us-ascii?Q?bL/iWhb7Ier++D1kxs3Raq3pCAOEZZKp5ujj9k7eDLyDsWXkzTc3d5MphFLH?=
 =?us-ascii?Q?cxDqVe0lUzSGqCQFUFAviok+hrhGbk7dZVY0bxxYqL60xLn46gWMxZYRtlM9?=
 =?us-ascii?Q?iijZYXBugLX7OG+YGdz93ARK7WV8qu/6385aGxkAWYpeW3i8kkxXZiBh3o5X?=
 =?us-ascii?Q?VcAxJiDieilBzwCjkHvvpgNyn9YrkpSKuI7AmStso9mlnj601RBxBrdO/SYj?=
 =?us-ascii?Q?FT9H7gaqlI3bBDpIIXrrQgS6qDjZiJJXxoht2izrBgRULqPqbB8nxdPnRumb?=
 =?us-ascii?Q?8YbGAe9qWdXX7zjexpLl4iLa+1oItJDmOzn5D7M+a3kQIw8yNoUAJEvZN3PZ?=
 =?us-ascii?Q?AVEDmUWu/SdewNIBXGIiYUXLFQRHAX+Yh+0PwFF5KgzavKURj7p3mb0nFQt4?=
 =?us-ascii?Q?ODX/1kGVbrrMtLnW+QGVmabnc0+H4/Ng01rbzlfn8f9HDxVS2hruCPsLk30w?=
 =?us-ascii?Q?4IReBJL3/5Wk/lQeS91jfjZ+UWTz63LxNwZQgmYnkQcITlaBzIshz5F8VIHQ?=
 =?us-ascii?Q?hBTsoT0uZsdFl0Pq58OXsIYwtzbzEt+X+jg7LNv00sxavlMgIyZf+izxedEK?=
 =?us-ascii?Q?TGmQdNcqILN5/yLs+3IUiwCx5rbz3Chkw1KBjGRGXgnBq7Shoh8CF22OTv/u?=
 =?us-ascii?Q?9zhBNTmmHKpw8BoPrMx8ZUowuf0V65v1O10yLLvUxVDOegQ+DIqbHZeRS1WQ?=
 =?us-ascii?Q?jCKQnrY8Rk1oSbGYTNVlfwsbiMkyU1gzfLWIPfRBB04zPYJ71ybxAUuQx4Cg?=
 =?us-ascii?Q?SCZua744jpHWGCdqAM91TuHKkxwCrf/tW+nAixTARkXXMaygfcJirzJOMLKd?=
 =?us-ascii?Q?1PWbk6lkWuy4DsgC94d6rdXyNlrXvehUcjdOuvqjJYyovovrIWkhw8pxBSvN?=
 =?us-ascii?Q?zDRJWj7ms4h34zsoNYbpAZCkNnIB2OeowSvJdgYQITyZWJv6YojAi1x3cJxD?=
 =?us-ascii?Q?byPHgz/TeP2nFZfc8dn0WXR0Yrez//7P0dzD1DcLBHgc6toTY85whgNArq6z?=
 =?us-ascii?Q?znFoGQH+63zE109Imq/wcaB20jc0zwBpAjUxrAN1H77J+9V2WSACSwWBmanv?=
 =?us-ascii?Q?5rIsqJXps5WtKW9kN67eUpDjdEN90O5F0PWuCyk6chpgcS5NCcc8/Co0XxyG?=
 =?us-ascii?Q?PIT8napgzmMJ0x7GalU6k9DKBDGWNENSkBVspaHbmVKeVyFJOhaKwQWEHnS+?=
 =?us-ascii?Q?aKHJI+KSoKB1ayvTWCgwii5eVoWFWTD2nrjrtya1yozyhVgcXZ2a/aA9a5ff?=
 =?us-ascii?Q?t42k6lOl5JexSg6y45aY9vxpkXV94kJWnyom42h4f6gaML/TXhcjZ7iwRJw4?=
 =?us-ascii?Q?PDB6TRnDo2S3vW60w+416nKxmonBHMPuZyez2DgAB1VmfUtn/HxxzWFrfoL4?=
 =?us-ascii?Q?FiJFSU/yuqbjqsbsur0OxLDRiq0hPjWqG/23Siwi?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa195a5d-dffb-4548-f298-08db17f97f94
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2023 13:00:56.1115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LwGLJAkWoEDA+ZAGKA+QoVaZs6pXh1yHCkc4pOmu72KSH8cj6RsNNOAgXrmiuzamycx1hsJCPZkAbOMv2fAb6w==
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

Add i.MX53, i.MX6SLL, i.MX6UL compatible

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
index b30ed11fa22f..8fad6e034911 100644
--- a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
+++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
@@ -27,11 +27,19 @@ properties:
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
           - const: fsl,imx8mm-usb
-- 
2.37.1

