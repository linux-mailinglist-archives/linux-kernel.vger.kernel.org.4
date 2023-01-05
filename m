Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5637265E8BB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbjAEKSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbjAEKSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:18:41 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2064.outbound.protection.outlook.com [40.107.6.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4BD395E1;
        Thu,  5 Jan 2023 02:18:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=agRXwar6heGEhUbz0o/HccchpZsoEHT/0fGQj0diyu2WItLJPrZgNfoNOzCod+/krePAZ4OK8zipHd/yW2S2wSFo3ZcK23W0LT0fhIar4+H2IhZdcQ9XMFitK722w90RHdXZizk2G6KC1cdT0twDazTW4lVktPg9sstW4moQJkycQhQzsK3yV7vVo/HBTaxDQsMBfdh/mjlJ3ckMHEgtNryN6bDYbNKmklcgcXIDJm9dVGlJfLMjq0d+Mn8DXS736F8syk0+g4ZxdwklhwKKlTYoxEHDks1VUcF954cLiVdy6SmZ9mrm+qw66Bb03bRdLv3vliFkUx4y7KgT5VMJIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yyd48tbB9gdDpA1kteJwtgwWj3w80azCodmixY+Qca4=;
 b=cQ8OSAyGb+zJE0isQZQPucMnJRYoXSyCulhjUubqHE3dM9NCSQ04kA1mffkqIq8v0UC1ScUGhLAvJTnYJFIlX5Pjx/YSUzXlO3VbkoVyp1954YjJoevqf+butkuEG3xbg3kzM3Eai88THGim82IFbnr7d9uVbSZBbSchWvoXw6jyRvWi4gD9rK8tFWRmh6GxD+tWmNSYMeLWQNGsx+G3lrNjInKpnn0286/025UzTsNI6MhQf4wfUNfsAyxGp6GlbwXi9LxTiyGAG8m/u1MzCwZVqWUeTIbJJ3jowszMWZeUHZ3FrSGUXHmS3StpFtw8seC149cV5sEIVak8YeKSBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yyd48tbB9gdDpA1kteJwtgwWj3w80azCodmixY+Qca4=;
 b=mrJ4tCHh2JQodfhsOwCSbfUC7DIeWmt3eVlNv3fSC9mlqtZS4ozETKySG1F+diYAjdh+Kt5WxVr3GJhnqhsy8QbXxg6EbkmhcO1X2oFEtJuDfZSAajGjJv7Od/neRpOYsGi31lnmI6AT8NKVtS5QXZvUBzwAJ6j2DZXhbGU+Lec=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by DBBPR04MB7625.eurprd04.prod.outlook.com (2603:10a6:10:202::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 10:18:37 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::f75a:918f:6b4c:4a00]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::f75a:918f:6b4c:4a00%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 10:18:37 +0000
From:   "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH v1 1/4] dt-bindings: thermal: qoriq-thermal: Add compatible for i.MX93
Date:   Thu,  5 Jan 2023 18:17:45 +0800
Message-Id: <20230105101748.6714-2-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230105101748.6714-1-alice.guo@oss.nxp.com>
References: <20230105101748.6714-1-alice.guo@oss.nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0009.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::18) To AM6PR04MB6053.eurprd04.prod.outlook.com
 (2603:10a6:20b:b9::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6053:EE_|DBBPR04MB7625:EE_
X-MS-Office365-Filtering-Correlation-Id: 40b79582-026f-46c1-391d-08daef063564
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pc5KWjtzVHyvJXPVBLrLg/uBET/rvzYonMLdAMZdf7g5S6i720euQNUHFgax8vPqoYhkuacJNXTym5lqlmojfAlBYmJcNSSuRXrEGQ4Y/BWnJq1lfis6Smo6rvh8pf3OiEjFI9WITCu+Qy42OvO1f1JuX9tZedRd4nTAIpuL6yufsUZDS0BtBvuCZVo8JdQrtLKT5FTJFvVfYCBec45FLgmZiGvEPUt7TcLpUxu3odsrHBs4rdI9fErT6lNO3I7a9ay6oSA5NthQJ9gM/Yt5OIXqXRD5Me47n+VJw0YH3QpyV4IGBUuiPIe1os6O3uxkglx2Ljll92rAHNsjSBRVfQGX++eU0js/NOSbdDfTf1/EPM9oNs/64OUswd26WeeKctNM1J4SkoLc2K6EyoEqaPN4S13+pgcIjjPTYA1wV/2v/duuAhVaCLrLs583gP2yR9d/W0/mVsGoNwyLUZbZ3gQOrz2amCpPiOfeTrbs2HrUXoR12OuyiD+2nv8WJCm+ooSSpb6mmQiiHyEGaUf2B1ySA1OX1YCvdn06S25Yoszb74UPhfAawWg7EQ9XeH3Kzw8GRhhvqeOrhClJEkWmCHzevBhXYd2ryfXCB/uKk/XN/G07zORQQ3QL/+qZWKSMS9QRS6VjQ+JTohR4RpX2kdVm4PS+yRQKy4JlsT+Q6/t7QlhbSpJnJBf+8oYb56ZNUVRRMy8uY7Q/Zu+aYdLrzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(451199015)(6666004)(2616005)(6506007)(52116002)(186003)(6512007)(86362001)(26005)(316002)(8676002)(1076003)(66946007)(4326008)(66556008)(66476007)(5660300002)(7416002)(41300700001)(478600001)(8936002)(38100700002)(38350700002)(4744005)(6486002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HLsxpp88JpdlSECjmdqsejSZ0NcnqCNwyL65KeMGRFMnD6U7Vza6AsarEzer?=
 =?us-ascii?Q?dHcsCxgV24Iz1wHKS4dWheaiwH47Aco+6JOEunZHyLfxKal44v7kiFBGC58I?=
 =?us-ascii?Q?PtIV+qkJ6klU5Me2oxTCcVRkRnAfmeg3Y1hfqlo/zlKcs1xTW8r4Ig49bLgm?=
 =?us-ascii?Q?MWf6MvDDXRuL0iw/2TO50epi82kQbcLQuygJiAJR+Bga03sUxQS5YtDaMhH1?=
 =?us-ascii?Q?FvW85LKcn0jB2oJKu4muPAlqwNnoo73d/qFGLxo/zhgqywsbqS4NakgnaFQq?=
 =?us-ascii?Q?ilINnml1pHnLP+SOMw7tmr5zKCy1yU81VRD5DSkdfbRSP3EXNHit1YUhgG6o?=
 =?us-ascii?Q?A1DsVKLrcqLi5YnqkocQPM+ljzkvw1gGVpC6fMCS1qqgNNWbeC4/IH9xdqSZ?=
 =?us-ascii?Q?1BdNO9btNmUTMnHJMnZU8NfUA6K/9P054+patw83URQv2a+4UdOiWBVLflV9?=
 =?us-ascii?Q?+DSwbf1qe29fKAlXdngtLnABHeF0LYPTW0pn4uQUO1/IF5hv/28EFnSktAYT?=
 =?us-ascii?Q?ZaesjBvLFO88S7F09icMsIeWaUkbtQsWnghE+bj+p+RmCjbkcSvmDSTh/a59?=
 =?us-ascii?Q?hhF4SLq6E/Ba+yrxgKVLzyoAWgNC8ugWp7gcKBXJMWpU4nXYT4OJ+FtQgzon?=
 =?us-ascii?Q?ZYy9JyzWEG6OCKlSwSXgAqS5UERz7oh68tgIkc9Ta06V/PDVVTkxCrMAjFJp?=
 =?us-ascii?Q?FKGRLy8DsCxB7P/x+NB/5RzxPB1M3a2HxbhJswJdijSjHxyNQLzLM3sWb9xT?=
 =?us-ascii?Q?8vmkXKy+ogRKC6iLGfWpdMvKFpAK6SY89xe5gOs0JnAFTJqMAqtjIwEdg81w?=
 =?us-ascii?Q?3Yvp+g6lfP/Tb57dLBU9kSmKEC9sc+MXZw8lxZRlHMBlDRtRXZyv3tYH03qD?=
 =?us-ascii?Q?EUsEGtveV6CwtLJvqGpKFOoq5kFVRktGeNRYBd8MEC57YCIdaEon4Jx3STGQ?=
 =?us-ascii?Q?9XbIBZstIMCgKWTdGZG7VfqqiVCm4kG5pJokNUD6RCyRgG2IUqsBHbDyIkKs?=
 =?us-ascii?Q?93IIOjbNikYfYhciG1aeAtY761ZYkwcEh/+o/opJNpSwrK9qe0VzauBqxIHK?=
 =?us-ascii?Q?fe2B2k2isXcR/zV9O+lpiKGWJiyoRGnDhckJQO69OInkabMDGL1NljgPzOz3?=
 =?us-ascii?Q?F9kfWDayEV+5CTHRGg49QXbfyRv0S8I/gvOtUD2IrTR3LOAzjobxderozRw1?=
 =?us-ascii?Q?Idd1rUMy2+ZvVk2c9b+TigOkOFwi/d1YkNTGD5zxHA7e/6WYw9kd5wh1zQN1?=
 =?us-ascii?Q?feT/yguzQmCcUqCoo0dmvP0ADj24GMJHR412tuO9zLUBNkGHi3+kQ5rLL5AX?=
 =?us-ascii?Q?hIPzSS/dKnUMtu7IKBG+jZSUlDdc15QFEKIH2FbmzG9+IMQHtRCc+y2t6Lff?=
 =?us-ascii?Q?cYmv2E0sHzLBn+xpGzR0kVx38vv4VjTvZnWln/1Qdf3XUkANxYY1hFuKb5n5?=
 =?us-ascii?Q?Hhhai1UI134u3IUOFqqsIJyrtQOWRRv5tkKCPI6dR37arlNhKlHCahzghU6m?=
 =?us-ascii?Q?S1M/F3MXD4sEhSK6KNALjxWqNom55lx9cFfssd50EmtG0xCTyw1VCmJRpFJC?=
 =?us-ascii?Q?ojw5pmCH6nQBpXxfgWItBfvKANpGkgNxvGQac16F?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40b79582-026f-46c1-391d-08daef063564
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 10:18:37.4074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lIiDGzHIY5UN+eybmyLjmZWsYtARz4hF2nLSUkPPmBPgsQjMf6BRgU3H15PbgMx+3YImubyrKAdDc+mhaukNQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7625
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alice Guo <alice.guo@nxp.com>

Add DT compatible string "fsl,imx93-tmu" to qoriq-thermal.yaml.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml b/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
index f09e8723ca2b..82ac6f3db0da 100644
--- a/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
@@ -21,6 +21,7 @@ properties:
     enum:
       - fsl,qoriq-tmu
       - fsl,imx8mq-tmu
+      - fsl,imx93-tmu
 
   reg:
     maxItems: 1
-- 
2.17.1

