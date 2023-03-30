Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3F26D0088
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 12:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjC3KCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 06:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjC3KCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:02:20 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2082.outbound.protection.outlook.com [40.107.20.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFFC7EFA;
        Thu, 30 Mar 2023 03:01:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HMwJu6uhPxVdtBQUT6hikROOW6cYPW1+W3/VHjojQNAul8NrceY0KqSGAqfnRJ1A7LSi7nUstJNjpkpt4kK2bHbwd4uMhq8NnliijwSEB02pxLMpwmH4npWhArSAScutwzDeoLIBcVBjt+g3679VUe84uSsM75Lwpz+2X1AakZSPDSe2ZMUbP/IFnm1HId654nAbb82I9/nuN3xS2O14Mr7XMi9NGn6/JIXtRWFgdxI1nN1gL4CtzTDxNrYf7mJ9PnECDYvD9BecnSgiUTDiHNwCPMW0ayfCfhkO4JVmmHq40w6HAoX50uUnbssscJucvxk7fC+EuV1LdgCVAnUeoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wuywjMJKUyAEYPEZUGd2gwIlG2kX+j2utZtXSEqEgKI=;
 b=EhTQwJXEWzOCKreM3LYsG4yBJstopjMdKkk43jZYwibycCjcc53N0WY89zoGZywqnfZiEmYbFckq+xB/csNtVySsurW/9zu7YaSdJIO8ljuoeER85Qgy+quuPpuXcIgcBYl5L9FPmRpWXHgb0ipN/2NXN4wxamK9m+YuF4VY8cO6TpkkX3iHMENUHrH5RJwqZj704h5k/V5WYLXhpfSi6FHrKtmrI2lfwdYgeLBcT6PpDXVuTNjeMgNQ7niLjDCidFNTUrp20K+grjuNhSvpUFiBwHV266lua1rZerZ/q4uigQvXd1s3TQ7AD0Jom4AzbfUGZLrqFyOEqcMH1Nlu0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wuywjMJKUyAEYPEZUGd2gwIlG2kX+j2utZtXSEqEgKI=;
 b=TE7o6hut5HxERD1stWmuBzk5cY0nM0tvdMvfbi9+AU+4WSKh98RUg6rtTij0cg7hlarh5RkR7UnTjQsQQdziHZecnZ79UqO2rC26qav9xwPoNUMKk9Vwv1vgBOqHnP7/lw3dFzmMIpLZHpAgHSZV1E9L1gt2S1+Xzz3yR2MXciM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB6891.eurprd04.prod.outlook.com (2603:10a6:10:112::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Thu, 30 Mar
 2023 10:00:55 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0%4]) with mapi id 15.20.6222.028; Thu, 30 Mar 2023
 10:00:55 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, stefan@agner.ch,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V2 2/2] dt-bindings: gpio: vf610: update gpio-ranges
Date:   Thu, 30 Mar 2023 18:05:50 +0800
Message-Id: <20230330100550.2049687-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230330100550.2049687-1-peng.fan@oss.nxp.com>
References: <20230330100550.2049687-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::31)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB8PR04MB6891:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ab89e3b-e76e-4261-34ce-08db3105a6c6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i7uLHwmeyp3mNrUIFGLUrhpsP58j+63xd40kWX+EwdtnJKYStAHRhWVq7S9jonFyJmY5wTDVDoprSrnWSJwkBkbhwCfqTaU+JcPmxSxTMFU16bOey7BLLdwQFe8V35t9BblF7ly3RaI00s1sJbC8HKrxXT+aPu9kYul+ujB/OD6PoArspBKO2cJS05welInW32n2+CpXvUiLWd4adfc8g8ivnlSdQO30XLAy8wYjWYFa+pUzMoKvXref/B9VUrahWE2VBBuYw23TijxEEj9KkbLa9KUlvKEEi6aoO2I3qhe/KvaTPRcyNk+iovtEY/+SaEr6oUPMpHDGSQbPOjcy9PRVUc4PUpXnU8Nxw95fV3dZ5AO2ceGSMbiyEbneAPA4eIrj5Kmex1pG+LIoM+tLragdaE8vTtmaC2sQMiWjz8BQqTSegQB2Jaz+L5P/dpR4jaDVXtSFrICSZYuTcIDIyHut5BTUy5Vgw02PMCk8A6T8r2/Hw35lkYmkZFkxJof7KAke0pqUhlsU1vDOB4dLlLauEJscauhQOsIiq5stawG6g01YKs14Tw0xZTEOgvU6A9q6sEGztubNkQADRhwmaCEoPw0WCkTE2MQoj9GiM7TZ3ey6Y039PVhpf1Mb2A3f
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(39860400002)(396003)(136003)(376002)(451199021)(316002)(66556008)(8676002)(66476007)(54906003)(5660300002)(38100700002)(38350700002)(41300700001)(66946007)(7416002)(4326008)(8936002)(186003)(2616005)(6506007)(6512007)(83380400001)(6486002)(478600001)(6666004)(26005)(52116002)(1076003)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8VKiEKxtI/tVt1uJfGTfOVKhqvTfrQwXO9sIHv2Dvt4uJ4oQG5BxfjO6n+4G?=
 =?us-ascii?Q?wCeg02hf6ZTa8Dn0i0QZ1x89js+OP0o12KKRivOl7zapLebl12fCVzTWD1N/?=
 =?us-ascii?Q?dFRXg+F0nDXcjN4M8UIBrYz33mrRuP/be/jKGYlD/Cfs/Cm+CIbm9vrqRsDz?=
 =?us-ascii?Q?jymriJPmCQ/XGpBvaYO+gRtSZd5VYJd2FlKf9P/LmW2gELWCnJVi1VW89jt2?=
 =?us-ascii?Q?CNxfsZpOI+cEE5dVAgf+4mCeDqe/AUewu9AGoBJGJdptIZ1qdDhR+eiRJTNB?=
 =?us-ascii?Q?mA3ipoNBL9QO53/e27riuaptqCqEDr7iNLJlYHamYT8GvZUE5ZgD/R8DtvCU?=
 =?us-ascii?Q?ehRtRp7Mhvy302Ibm1KubbBIIjkcr5qS1xP6nsTL5kGlYka1QQCm0UzjImAl?=
 =?us-ascii?Q?QbeRsN3jZBUKqBAzDDMiL3uxyJprjg92/8xYDpkwZOVgpO9zBM/MtlxFEI7A?=
 =?us-ascii?Q?oqnpj2aUvXrhlp5l/sOzxhttmIYuadPQlivt9jnInU0lTtRCVm6kyANHf5X9?=
 =?us-ascii?Q?ll6k39uwzwpsaGJ1b5vCZS+hF5g7/tCnOXSXnQybn2kWld/rbTqjoqsQpB/k?=
 =?us-ascii?Q?zEdHtJTO5y9jfpkQsnqnPAJHEsTRkb36vvWL5yboszKKC0+8cL9qKdUgWq0M?=
 =?us-ascii?Q?47dksSjC9Ao9ei1FPv0EeXZ5bLa8Wq4MQR1kG27Jnkb4mjyCOmJZEyEYXCwt?=
 =?us-ascii?Q?YyXG4VgmN/g+bXiK9ujJYzKry/1xPQ+9iz577G+M0d0ADn92b2p0zIA+o+M7?=
 =?us-ascii?Q?CDzHRNPyH7cPQAUFxY0F4NgFbcSs+9mVEQ94+PhE1zNEWfBZMJ4wCDqNVMNj?=
 =?us-ascii?Q?i9RmlgyxM2Zgg+7UGVMzHMvE6ja+W02N/Z6JT/z2mVA/BXysf660cZce6ao3?=
 =?us-ascii?Q?8VfTVC0bq1IjPWTYNLYoEuiMcPoFxY02ufHjyIO2KpxIJPj+uucMf93PescO?=
 =?us-ascii?Q?lBd6ASGv6a+s+8kGabWNSybI4jTMYDU1DndfRiU9auu2wNm0tqmIbXRajMt8?=
 =?us-ascii?Q?VqGkowvLOTb9Nnn7kdRdY6/DZPXIOHEvKuLxu3JVdkeCS7glhQ5porNZOAkM?=
 =?us-ascii?Q?98FL1iuqgBx2j/xrh96ga7kxWwf7+V1IjdRV+2qQ80gjtQUYtO8fzWz7mcIc?=
 =?us-ascii?Q?k6QS2HIjnRx4TBj1Gc9QIRtRB9bwjn1BQKpZFVDa+nGLvJYthdtUWiWF6lbu?=
 =?us-ascii?Q?jv6xNOPH1x2AmYcDz+BTGXB9iUFNNZ4NeISWLWyheUTMR/BF2UL5/2OgKZFA?=
 =?us-ascii?Q?Y9XHn2/VbJvUDPHBxNQ+8aELUht6RORvOCffvLB1M0o6yHmhdworid4jHanS?=
 =?us-ascii?Q?yThK9+/NtTyrCcd03mJ5yJ3QKoEIRntp/yaI+bBpJksVDhldlM8ttex6kvF5?=
 =?us-ascii?Q?0Xdtxj0b2Vg9ZHQEj0Xi9RI/rTXb/L2Frx6FHRIRcVnsi0Sapo10BEF+Hxs4?=
 =?us-ascii?Q?lW6Wu0TYZ7ykFD3fDZIrPlkKkvu3R4dSHt/DJrUf/iv1+pofj/06l/8oRpcj?=
 =?us-ascii?Q?Ph9d2UO5S21EIReRs59Y7MIlPgWNDe58nb3a1hAnjyzHi2zJV8cGKaOrhcrY?=
 =?us-ascii?Q?KO//bT+5/7bfPeFJAKLHtPjgbDaCkvTh8tm1bujS?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ab89e3b-e76e-4261-34ce-08db3105a6c6
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 10:00:54.9338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z0/beYp7RN5TeZRFcCSePV2NiELnn4ARuIwnWwAx4N/76uwU+x8WXYLXR5MP26I7O9hnyg4zhwq117ezhfOPcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6891
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

And bounds for gpio-ranges to address dtbs_error.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 Enlarge bounds, and still restrict as 1 for previous devices
 Add A-b

 .../devicetree/bindings/gpio/gpio-vf610.yaml      | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml b/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
index d2c39dba56ad..69eac4194459 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
+++ b/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
@@ -59,7 +59,8 @@ properties:
       - const: port
 
   gpio-ranges:
-    maxItems: 1
+    minItems: 1
+    maxItems: 32
 
 required:
   - compatible
@@ -70,6 +71,18 @@ required:
   - "#gpio-cells"
   - gpio-controller
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,vf610-gpio
+    then:
+      properties:
+        gpio-ranges:
+          maxItems: 1
+
 additionalProperties: false
 
 examples:
-- 
2.37.1

