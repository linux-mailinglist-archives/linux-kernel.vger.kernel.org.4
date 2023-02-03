Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A073688C43
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 02:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbjBCBHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 20:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbjBCBHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 20:07:40 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2070.outbound.protection.outlook.com [40.107.104.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3018E54573;
        Thu,  2 Feb 2023 17:07:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HDhf0o3JdQbl3NeQeyPth4ikZ49OmP4fNkLd3hx3ObrEpJVi5H0KsrCtmvG91E5uVFZIuL36QeZiB3tvTD4xc818wkSVbXres8CfZm08XmD7bBUGdjSV8Lo5JuOjJZhfALdByeleJqILEcjcOHF4iloLCHgZFM+mZvathkXqWz1/zQZhFlO2z94lR30qcxAKczLCmTeSM6d6vlWufIbZrn7Ilxn0ED+NoI6EyDZdIW+/in5/jD6xPQJw6NOgWpJYCjHBwlVqT02MNgxOGyx576nkjrsytEse7R1l+0hVtc7vSKZoMsif5LmCUthqhgvNaKejFFUGLlf+tkGVHsaAOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jO/EQ3TjXXNpfg62Op+MSAD3qmhBB8fDpayFmkbz/wY=;
 b=fWsP7U6VYoRAm2savAYOVASQqRwdWopQ217VA66VkhkU7E09AjFJCG8lRBwmrC8+30uXeG0woevNHMLhxoK0D6JuBZZw4csZKnMmxQ4JkaRPJbVxZOSztvdwhjHUVmQtA+pO68+y0rmdfin7nQnxe9HlPAOlwKabpT9EoAJkZ3+sREv4b36OiIFWKCicqJEbglC7a6GJClC7UWGlyAnNdfKU2G4+G9bSClL2NFUrteKRG67XU7mgKeuVviVN9ON6HQIe9Cm0BIHSPw2fzNY8NndXe/zFbikare8+fW5aBufQ1uBrYdQZ4I7JTExakndBadkE5ye/9jylKvqrpkUUVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jO/EQ3TjXXNpfg62Op+MSAD3qmhBB8fDpayFmkbz/wY=;
 b=TdJPAESg0G9ICAP1skjjU4vQLl0vt3hzTF1pQrFEsAygMvq6r5WahL55owFXdncbdIpt6p7XrDLAhnXT3NF9yYmZ8CtYkr147HjAKCoREztRZgU6mDn4DBdJ5kLtm5255rNQodmwr7J/8uZe3fU3wq+6UZqEgXK0gqwwEo/7R+M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM7PR04MB7141.eurprd04.prod.outlook.com (2603:10a6:20b:11d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Fri, 3 Feb
 2023 01:07:35 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e203:47be:36e4:c0c3]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e203:47be:36e4:c0c3%9]) with mapi id 15.20.6043.025; Fri, 3 Feb 2023
 01:07:35 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, balbi@kernel.org
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jun.li@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] dt-bindings: usb: snps,dwc3: support i.MX8MQ
Date:   Fri,  3 Feb 2023 09:08:47 +0800
Message-Id: <20230203010847.1453383-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0100.apcprd02.prod.outlook.com
 (2603:1096:4:92::16) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM7PR04MB7141:EE_
X-MS-Office365-Filtering-Correlation-Id: 09a593d1-900f-43a5-4b63-08db058308d2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rtUKa1u/2igKWOT1oCmWILqmJ7bxtlQSWAPrqa+Fjxe9QAWdi3cLq2XTdI2PWP9oPyd9Bk6+308yyy4lj4jrO+TJg5JIe4eBLio6qdYeu24urx7fxDacpF8szyHcNWa9V2V28keZbQymGcy5EU/RvTa5cEG06B+Y9v29RqN0K0U4v2TCt1RM9hu1/aiSWMtSyLrg8DMo1WTBY7DiT6GndQVI3wOskcIGX0DiFtuwNlTIalp7S/TxqoPV9VYgosb02JwLlgdVklrqgyL12aavj6L0idcoB/T0cXMs2Lw9Xub9Pevyx2wIsygiQ7ryV012sYer0P+UVhNQY4pbO/BwAdVfF+UP7umahCScTqlYVEz5/VLP7eQj1gm5AT608vDiqzmuZl8HVST/gGyy7S3/sg2XZm7nOpJCDgETYRCpCYQI84wGqwjzpKXn85YGmSdVuJJymgJiCcm1pdPQNWhZ2CovdjQpO4fG8mKMKsPVmzfN1ER7CJZk/1nj/TQWBSs5lEwBLC4i1R4c8tAz1x0Td6Ac7I6M44XEAdFj4rD2uIk1vdJ7mlAH/WdF3dl95V11jTDNLsEEW1jiTytEEEVe2FI33ZctlLBq9TGjN6FjCKGgkb0AJCzTAXRts3Eb9tYaqlScq99fshLa9P02zzOgP9Ci5hB+q72Hmb5DaN2/h42mLaZTFb3rsTiB+eS4JSLJJFhP1dNzlYh2FXKIvIBLCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(451199018)(38350700002)(38100700002)(66946007)(2906002)(52116002)(6486002)(4744005)(8676002)(41300700001)(4326008)(316002)(8936002)(5660300002)(86362001)(26005)(1076003)(6512007)(6666004)(478600001)(66476007)(186003)(6506007)(66556008)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CnVXDy5gd+WOel9fAz/m8KNjF2jRiJm7RoETcKutsLH+Qehk4M/bGCAfF0XG?=
 =?us-ascii?Q?Ao9+v21eIzvC3TqxdSm2ipdN1ldAXDpaMANMkRD1bEjAnycHB7u0//80c1FO?=
 =?us-ascii?Q?MU0xZXp/GvMziR4uhK1Qci5DfyrhdmKxT8AmrX4jnn1FMrGhl5V982vaHCCs?=
 =?us-ascii?Q?2JMuSbvVtaJtepLvzlxNthaj8g3R5fN8SrZ8m2PaPO8vnO6xaORGBzbdRZmP?=
 =?us-ascii?Q?SJgQfnks+7VQIW4TH+hq9vKw2a3eU9OvZu2x0NTk6PLH0VwxCV8yTup4W5DR?=
 =?us-ascii?Q?Q3AEGEXfcSI9T5IWDaPyMHz8/yr4myNcq2RHFNRCiml5aCk/9LXtmCEoTUkd?=
 =?us-ascii?Q?+slpdmJv5wIYGc4sIAa0DFA/E1UGh+5bRRm5FJ+FbL+/ay+W4C0ueXu+jGE2?=
 =?us-ascii?Q?p77ntdi9JTsr+N0sNRJ5YoQQxccPCVSs/fTYPJ6bbL5sN0eE7LgXjl9aIEV1?=
 =?us-ascii?Q?N+ZlafwRJxwUCHOxqMZzQpcn+NUE7Xe6fd7THSf8wPeoDuS3CuxCIH6aT63B?=
 =?us-ascii?Q?6kxD3hcPqvxeKX+XQY4LMjhrn2jT20IrROq01EOGvKdGJp+qKPrbC+iMNuYb?=
 =?us-ascii?Q?x+UridrWkVdC9MoCmWrGuk2GSLJq4KVaqM/wexg+YhGZ7ufjBE/S6/Ur0tyS?=
 =?us-ascii?Q?ShnpTA+60ItIOMor8hwqAx3EL+Zfk9wWzaNAO+zhBih1wCn/jyVXfQNnG68z?=
 =?us-ascii?Q?cowAsmphL2oxUuNUjOfq/Q+y9D3aUoBy3YzruahSIXpPjyPa6WCQv0Z8MYup?=
 =?us-ascii?Q?eWzge5UqdSEwmEkT2QzrkzXN7ViZORbLLAQAWlJyK4Ce1Vpdkh1dtLlyb5ka?=
 =?us-ascii?Q?4gfaeI+Oa1HTUMmtE4ylIym257RP1V/XMhDoRt3C9qCsO4xQ/R8ODqgvMrJ+?=
 =?us-ascii?Q?gtgdx5IcYR7SRnceW2MTzupteTpSGgU7TmTXvbbr7a48T5Ln7hfB7eIeQ6qy?=
 =?us-ascii?Q?9NDmMpBOBNF+P6fynJ8Krpp0ibGmdmUTx98WNdIFJ3CE2BOJM7Dcy55x2fgO?=
 =?us-ascii?Q?6EZOGusTAvFtTevF8CCqwQYMlFIw6op3nnt4XvbRcN6w6kHxiZnDVfmUVysl?=
 =?us-ascii?Q?cnpHHJT4+JcOcLNYJvlqTHWA0HCtkHGI/j62kDD0fO87n6AxrIouuti4HEft?=
 =?us-ascii?Q?mZ/jESu9Gr6vc723WjUW50ZH8tX0fJlHs0tW/O0KS/Y7RkIHDHZglUPZWt6g?=
 =?us-ascii?Q?f+tNmFHf6aNbkiqIBbfjEKp7xxPX4E5+PqQSBcaIxkbMfRMxmXiQ4z9Eh2hK?=
 =?us-ascii?Q?SSTFtAQfHLrRF+4EQSJmxsFIazq8Tip/gwfX0txbBStyP9lB8w1UxUoUMxhv?=
 =?us-ascii?Q?QfJN1aBDJpBU/O+OYCq537OY6EHKQrYn5hlSlKcay0klUtJ/sFcOjqiABlVM?=
 =?us-ascii?Q?NfYcRFydxptlhBqu9wr8jYKD/bImM/ESVy/5LSHHJPEJvNmcHTBYTq+mFO6S?=
 =?us-ascii?Q?vAo4a7SmGo/J/VHw9V6odymi7bgr+wxSORrKHPNv6qHE6ilaGORLLog/H6zB?=
 =?us-ascii?Q?20fYOyVFlWoFSD4/S4sHzkMVpn6j8ZleTHU3xug013M9bzjyXkcjl898MWnm?=
 =?us-ascii?Q?Yfe8eTFGpBlRhbvn3G3Ek2q0YpV4sjgmtzjFmStY?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a593d1-900f-43a5-4b63-08db058308d2
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 01:07:35.6177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nW9ZWkqpJlElWK2GlKOFGQTNg4bWM9buRQCHs2EKSJGjH0GxNqaB0VHt6w6txCxDD1xZCLPoCVLuC9nAV6gR4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7141
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8MQ use Synopsys DesignWare USB3 Controller IP, so add the
compatible. And also add optional power-domains property.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/usb/snps,dwc3.yaml        | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index 6d78048c4613..a9a677411477 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -30,11 +30,13 @@ allOf:
 
 properties:
   compatible:
-    contains:
-      oneOf:
-        - const: snps,dwc3
-        - const: synopsys,dwc3
-          deprecated: true
+    oneOf:
+      - items:
+          - const: fsl,imx8mq-dwc3
+          - const: snps,dwc3
+      - const: snps,dwc3
+      - const: synopsys,dwc3
+        deprecated: true
 
   reg:
     maxItems: 1
@@ -91,6 +93,9 @@ properties:
         - usb2-phy
         - usb3-phy
 
+  power-domains:
+    maxItems: 1
+
   resets:
     minItems: 1
 
-- 
2.37.1

