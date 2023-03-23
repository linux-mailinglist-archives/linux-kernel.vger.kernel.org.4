Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247926C686F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjCWMeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbjCWMeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:34:07 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2057.outbound.protection.outlook.com [40.107.14.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B155C196BB;
        Thu, 23 Mar 2023 05:34:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/zbZ91lp9mcLw/h+O0Z7hP+sW1EdzEeX6K1q5zGbsPupGCOeyUJeJzrjmte4rgYkUerqfaFCgcOx/HH3n6kb+04+oWIwRGnbCGSB6nTPKCwhtvPTZfnMF+7NdX/m121sFB9gyPWP/ptbh23Xbudjr61y4U2PUGvlbClvOYx6OI4XqhrDka+HDgpR48kucAexs5btpR9bjdnbbkQaBGqr0S/aTWsawTfE8Msb2Sj4nYWkC4+ilsI2y9xsglUicjBDM3e6HB6Xxu8vHY+w6fUYeqSNKKkAFUgoFvaa9cvAF07cFfZfB6Iztq7OUWDcM9NA77bJNLERv27rWZlNFvouA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1rPu+BslgaSm6CfHCKtQIy6DG802vpF7dfMOB9wjPnw=;
 b=nf0FSG/NE/U32fsTn99JAevN2IiVOGrpFe4IMuwbqZlIAXpH7DhGyOB5CLqazIz3cz276WE1DhBp8fuGgTF07i1+lm2QGDrUuT/r1zM3N1uUb4skinFfHKIMXEL/CRWYm3CHjX5LfjDfa6FdeQ+uYWt0sZfoFaXhWDITC31Z78Epbs8ZT4WU6qLPuoC6rhwYC6MlUU5Pd3DfxD3B7p+Sw93po6rYEgt8A/l6NiGif4coffx61LYbqfpOMGzBibETRS1umXhZJ5eg4F+ITFvsRCAFUm11NzDxOYAnHIw2i0kPCmhsoCycFTorLfL3XDW1vh6z0tWBSdIm01hU8KWP8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1rPu+BslgaSm6CfHCKtQIy6DG802vpF7dfMOB9wjPnw=;
 b=lhpzDMY+fQt7LE0oMoownkwlAVIRcxlZ2ZyJM6bKF8dQ+t1YO/yswa5Y+Xe0BfajvgcVAZia/5wuduMF5vhu0BzMC2eImCj5I++QaRe5GPbVEx0gFRxV1/kxNtoCOxgExH+SHHv0Iggn5tVlJitridv6sdnZtb5IzbEDStUyL58=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by GVXPR04MB9926.eurprd04.prod.outlook.com (2603:10a6:150:11a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 12:34:01 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%9]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 12:34:01 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        horia.geanta@nxp.com, pankaj.gupta@nxp.com, gaurav.jain@nxp.com
Cc:     linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] dt-bindings: crypto: sec-v4.0-mon: add snvs power off support
Date:   Thu, 23 Mar 2023 20:39:07 +0800
Message-Id: <20230323123907.103719-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:195::7) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|GVXPR04MB9926:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fc6237d-9b3b-44f1-3c0c-08db2b9ae14f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LrJE7hpZnVL8jOvBgjzpW+IItfN44scs/QJcfpx+uAuTlgu1DlpgkXiJEYuZMhpqFuOEJcguFxznMWYydBE75pFiQvuWBn4Gg6LQdvWlvYmxpxdK3NBq3U/iYzw4+rsEPZkSSCxPwC34MarXauRGLhnAyDjGZYzJRVKShjIF02cB2cV71JAKuJmi/+++RSueJXt5I01WQUBr+BJf35oUYFMQR8tnOIgw3kkijbU0bsx3pr5kMvNutNgj34zBhyIyDjOOhh0rKGT2+60CS5/Z7Y+u6XaJ5KBRcLzeOhlyk9JgFVqUHjH3bwBjnal1gVkUml3jgzmrDkzuKF2xsT/HEh8j8Isgp9T2W20u1ySziXrXTQ/S7/GLzOgrJ/ykRvHj1SK8pKUJyiMmM6PVCtrBydfaFgQlY3Ypbhu8LNe+DycPVaB7nCX/S+B1MaHtjDwpey2XlNJL8wGG94dwZBexYLcUEm2PAixHZxhUei7ka1r3PJJcfLuVKt6ergpdXNO/KwlvVx7tYNU08AJA0YWOby8lRmyMeZlo9PVbR3QmqlgV/ZQZpYRM2VwDI01LxxbB9aX19GyHhxcDP83QzbojKCStu1pZ2UZkSg6CWIHQQpJK5jOgexuYMhrew6j1NzEPj6OPYQREsgKsSpteGt4NJbfEHLO0Wv4P8sJFuzziVnZvsumuQSW2CH7CisFiAKsj3WdyVHbrL695q3j0lnDzXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(451199018)(8936002)(5660300002)(316002)(86362001)(66946007)(66556008)(66476007)(4326008)(8676002)(478600001)(41300700001)(4744005)(2906002)(6486002)(52116002)(6512007)(6506007)(26005)(1076003)(38350700002)(38100700002)(186003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/X77Aay93A1RN/VlyIQiHKXau7rN+tEoyU7LZcL7stm+n6hDq8Rq9CQnnZ3C?=
 =?us-ascii?Q?DPcZ8z8faBoIuJmfYrzazvCBD2rqS8jBIh9bKFzf44Fdofd0sPiDKGHGkA2z?=
 =?us-ascii?Q?3IT7WTKPgJRbwc3jLwff42jfsYuDOpCiG8UTrU+jcXjzssBNYCeWIzcX49ZO?=
 =?us-ascii?Q?zAOAGToGmTQotEjStY+BrFWgdPIpgKxSH3bmf4CTfL/kzl+3gauIv6g88yw5?=
 =?us-ascii?Q?DvmE4S222EqnnOTVZvWVQQSFvlTthIpEebD0SU5DMUR6K+4uouLp2V5qLc/4?=
 =?us-ascii?Q?ws7DsIpMwVWlukStPvRuXbuSDPCf8gAF+Au4iJ4tmzUf9jw6ivrCXLNpsO2C?=
 =?us-ascii?Q?E9+CMrSHjG5cvYQ7BFezIwNXtHW5fxUu7u7G7kAGwjTlusCy4eADU2hPJH/G?=
 =?us-ascii?Q?qSh8toUwV47vp9GpCqPDbL4A7pJRIgLTg2UrCBEBSyKOBBD8WFKN4IFz5upb?=
 =?us-ascii?Q?g/8RuuSegQbG+6Jo6aVMLzzlTRGVbbv1PiQ0BcqYTWThtWNKy7kEJ3m+7x1V?=
 =?us-ascii?Q?l7amYhDbO0Gk9b/vHWeL00yZkVSZeUmB0l8c2pBvk0YPOkabu83NAaf1i8JT?=
 =?us-ascii?Q?eB82gGaHhmJqZOjxxju6HZ0+ro2rqUk7NOajIZN6ofYB97GEdN0LGObUjZEu?=
 =?us-ascii?Q?vS2D+QpGuTjwmFfQ7k81rjuAn7FeRHaXWYOaQydghIN4HnGzTgsWaEPs4bBo?=
 =?us-ascii?Q?/5GmJJcFAz3WZQfv9RXmXUsq8FeblyCbqjIM2dMqam/RKsz0ZH47rg+Np/3I?=
 =?us-ascii?Q?n4otXSONkEvhUnwGxMePRC8HJMSkzLs7KmuzsMLIcqbWe5Vd9IUD8bxiXfPK?=
 =?us-ascii?Q?JPok7FU+2shhU9BdW6reEkTHjuK0pV+OtOwQrnXdGcfT7f0A2WLGEOPvLQvy?=
 =?us-ascii?Q?Lqb27BlRKjTtneTiYN5MsZ/q+Y/LXv3BZrI47J4DMJGovPkLQAoyYmAW6geY?=
 =?us-ascii?Q?ITgQxqS0zKnAk5qs+PQN2tpvOJOIq8kFGdRymGhZ1QJZQ/UzMcr49sqPd9Wg?=
 =?us-ascii?Q?vcRfrxJt+nEW+yK70PUx8T5MCqFD71uIXawQQUAG4cAlCRvcYOF5UMP+AMqu?=
 =?us-ascii?Q?dqoV7aSUmSnRn74srlT/RpkZoTYNgLFNT39p9hTxHaY0/2dRaJwrRJbWNU/Z?=
 =?us-ascii?Q?9B6uKAawzourk3bQNDrUl4m5ZIw+NlAIYRt0Th7hQHaX60/iuTsuJGPvHyQx?=
 =?us-ascii?Q?2cRjJCGLwHm1/ecZ0UP18xd5P+/2ZFxIT44+lj+uju2J1QxG3xIkIpbI5qFj?=
 =?us-ascii?Q?2SIy5+NKc8sDeo+Kxf5uxTGK4B6bKlvp/FbJ1c4D9i84U/NcbgXcOkGl20EM?=
 =?us-ascii?Q?zvNaVd6w61FoQABJHdgzrbHlpWgHgTYWmEEO0QPgKaWy6v32vzcPAGiWh016?=
 =?us-ascii?Q?iSzZvtFjICRYCxdJQQ5bX0FzfthFwvhTBSOWwo6K3vDwo5i0vBrCFQDmjHPF?=
 =?us-ascii?Q?QhU3//uBok1YgT53Osh4AAvu2HgQDd6+lowitcZ5QLX9SBuaCqWU0/Eu9ydl?=
 =?us-ascii?Q?WyvjJRXQeaWhLWlZW9Ob72P3oYhXXejU2GUBRqrUJns1xew3l2MJn9/n9Hjl?=
 =?us-ascii?Q?7oCZ8YTRodl0m4ggDVyiwAU8OlmBuV+K/fPunKq0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc6237d-9b3b-44f1-3c0c-08db2b9ae14f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 12:34:01.2455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7D8QOMt4Dezj/11JVC2EAiTxS06gpru6pEWJtzr9I1N/p2c3JxD6kHU7SxvXdZYCXKgWJmugHX870Gj9fUFi4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9926
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add SNVS power off support. The SNVS_LP LPCR register could
drive signal to PMIC to turn off system power.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/crypto/fsl,sec-v4.0-mon.yaml        | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/crypto/fsl,sec-v4.0-mon.yaml b/Documentation/devicetree/bindings/crypto/fsl,sec-v4.0-mon.yaml
index 353d9140dcea..286dffa0671b 100644
--- a/Documentation/devicetree/bindings/crypto/fsl,sec-v4.0-mon.yaml
+++ b/Documentation/devicetree/bindings/crypto/fsl,sec-v4.0-mon.yaml
@@ -113,6 +113,12 @@ properties:
   snvs-lpgpr:
     $ref: /schemas/nvmem/snvs-lpgpr.yaml#
 
+  snvs-poweroff:
+    description:
+      The SNVS could drive signal to PMIC to turn off system power by setting
+      SNVS_LP LPCR register.
+    $ref: /schemas/power/reset/syscon-poweroff.yaml#
+
 required:
   - compatible
   - reg
-- 
2.37.1

