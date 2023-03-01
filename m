Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA58A6A6506
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 02:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjCABwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 20:52:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjCABwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 20:52:19 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2051.outbound.protection.outlook.com [40.107.14.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4439298CD;
        Tue, 28 Feb 2023 17:52:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PDyGs7DjX/YhccK7kvjoQ7lvetOx44mPRyJfm4x7WCo0D+K7n2JxdN5A7Y5mHn+wh3K00BoMfUbSGKjcjfTiNz5zIKdoLZ7v7YCumcXtVDW8WeHIdwx///zu09SV4oQJeowHyNLYtkGPPq2qBnVuN0iMyUpSa5KWbCS36j5j7NbZgx2o2oEmA/5U56U9BoSpd8thqv4cnr7Htb8miXDPbRlnN1PuI35lGg4sfuxRxcq5ZBsVY7gGMjtoJ7F1s2vTRDfJ7FUzPGnlVQDkMqBwK4d1HVxla7VBS2/HNlFsYXuwDKWr6iwznBavwL42sm0iLySUVZIsrI/amD0QnszLzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4OhBBKZ++XggZII0kwCZ+WzDuYULs/YkD7TUUkZPDs=;
 b=kAlUtlI3s5Dc2ngtorEXeJH3YdrRnNQrjRpSEOMpnn5ChPnFeybabggmLkW3Iv/Q46m5fhrwiAjMjOK/A7N9SngXihllT7phk1qicB594oF9l1vg5GmIvhtri2FRe0tBaWKxbF07dHm6vIGJ2AkCGzLXWTxFhs6FyO+nMNi5KdziH7evep1Xvii6Um+mmQyicvjRewVwCWdN3qryo/b70cQZoSzBjlLtJTnhq8c7BgoSwTaVmdM/Acv1b0+oIjYwAbLMd5RgKuraqvmkmOSNuBXIEkQpfh3Wls3fXb9TL5aPlux9thbvpIoaH4F6j1wCUZiwKAKF/RnoqJA3jF7gpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4OhBBKZ++XggZII0kwCZ+WzDuYULs/YkD7TUUkZPDs=;
 b=SfggeiYul8iUfmaIk8B/WHr78of5Sd5Y7VegSgNK1QUZMw93hYNblE1L2sGTAqac7nYiWBXeBCdsK2i1daZsNcA3g67lrWlk0Ys/hbK5HlLNBv4UZbNMGyoImRvbXXrBHueSy1RLsGDzAvM6XqcvA7mbF95MK+UjUXYS6DDxPXE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7546.eurprd04.prod.outlook.com (2603:10a6:10:1f7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 01:52:02 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%3]) with mapi id 15.20.6134.027; Wed, 1 Mar 2023
 01:52:02 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        horia.geanta@nxp.com, pankaj.gupta@nxp.com, gaurav.jain@nxp.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, stefan@agner.ch,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/9] ARM: dts: vfxxx: drop the number after jr
Date:   Wed,  1 Mar 2023 09:56:54 +0800
Message-Id: <20230301015702.3388458-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230301015702.3388458-1-peng.fan@oss.nxp.com>
References: <20230301015702.3388458-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::16) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBBPR04MB7546:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e3de60c-e14f-468f-9b5c-08db19f78d40
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mvTQ8fhaEDRLMOw4WtCSFpKHwRRUoiPTq/mvtxUiS58ApqMKhCQXhfBqoi7T2vmc4fabrqJNjagFAyKFk4jzcX3nwfjJzPRWiYv1UXx58eua5qHblkov4wZiMYx06jqe0BWI492BqV69mgZ8xYfWcSiktO90IghllEJGrzHd0d+dTogZK2Y9Zq9R/wG2O/yloEgm80J+qcvEAsINX3XxkoJ3Bcn/7XaPpza1JOJXOOWxP9hk2iwu9UByCPOBv6KWAyjk/oG+5kN82ez5oyxZXvnNkY9UwY4j/lsaNyOmb+TcQSYm+j06d/yX+cULQMULyNlzicBBoM+jqIVRQ2RDuA172pELCJEMio28Cj5tPZD/3MnikEthwdgNSWqdrvqgyVQ+lTbbDoo7PX0IPH0au7SAIw3ZZkITc/Nph7d9Y7DOHH9Girw+F6rphpNLpuD9VdffQxTNzfDSmCr0qaY22tF5PDpWKp2Ide9GnEV8ZhCEztMj3KvTteVRlFPk6XRv1qiqZ2tOw6/zsFA1Pm9mnhI1cQoypLgND5GlCxEg7bbh6T2NX7YoNXDIUgHQhv7ahI6Cj9Nx1UnRqjCnNRQisoNPvrGpps7mTFMvy6kWdUTDeLPEH9usQBVF8bB185HWpNvUVIQJzkYZC8+4KNUb1ALiU2g9VouRE+lrHBIErcYihsu9dBChOneb3vtjZyUELlidUTzilDb3WOlCh4Wraw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(451199018)(83380400001)(316002)(6666004)(2906002)(6486002)(6506007)(478600001)(1076003)(2616005)(52116002)(26005)(186003)(6512007)(86362001)(8936002)(7416002)(41300700001)(66556008)(5660300002)(4744005)(66946007)(66476007)(8676002)(38100700002)(4326008)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x1OnefngzYoQ84H5IYDC2PTMwqb4MFzqTPLTKxAPXqRx67Cn4QAGyOr4/k5x?=
 =?us-ascii?Q?VLTyylEdnGew1Z/34xPHKKA1cLqGoK5tfHzXF+WNQvyDg/Ab9chQCmjztwlt?=
 =?us-ascii?Q?9fYzWhpPONppur7SykRhOqd7w+KEA1q650YTUvBaaDKD3M2EMfkLknMxOdQt?=
 =?us-ascii?Q?Rma+dtQ03hxNth9ttu1lzK/mBSzHb00QAloHjDj07htD5OcDrndbTQ35BFHC?=
 =?us-ascii?Q?ITn9cVEm6WloLmJ01zf8iSFh8sT3OWaeiQDSWlvMcZdNhTePLP+U3SkbNXn9?=
 =?us-ascii?Q?BQyxUDV97F8gJrmuCWXqFTG8jhqWom/HovtJOSYi/+vhAzdlQ7tAovBusEp4?=
 =?us-ascii?Q?AGZpitFGGd8iSu9xbIna9oR6+uXgosnYOIPArUsS7w7TcWUz3Pef+kkAWx1k?=
 =?us-ascii?Q?QnTmQ8CK0dc/p42iSyJT9q/Lrd6pYupTXA0g4HdBYuDF21jpBTrtu/fR6lNG?=
 =?us-ascii?Q?BdB/s//7mIwTVO3AY7VI97wgft2YvL7q6dzQoAjj38sYhaFRiFHd1QqqJ6Ne?=
 =?us-ascii?Q?8JRjkvCgung182qAa56Urz+Pyx7QW5NDGErM4gDZkuhZAF9RsZD9IuflKcOU?=
 =?us-ascii?Q?qXuD0+/aR5g/MhK9r7TC+tYr8fp4lgGXBdEh1sTitZ9afBO/PTmsdplqT1Gc?=
 =?us-ascii?Q?JltEtbbZpSxTioPkZlnmQTgiRiq+hA8Mde36YfSVvISO7zunkgjr28P5j/z6?=
 =?us-ascii?Q?4FcutG0EfmKOoVMOaTWIgwLjh79VfYbQDgFJSVA/vZXEfAuGd022z9SOZ1Wn?=
 =?us-ascii?Q?3uFezdz1yWeWnegVON86yNs1Ner7ykwM4bXMnSg5rpziuI9ZX8K+xaSawA5w?=
 =?us-ascii?Q?r5QRiaxDPan1kUsDbz5KoC71CE2qwaZFq6E1P7u51vO57FiufBD3DfpEKIzd?=
 =?us-ascii?Q?jp2uF0fRlql8HPKf80v/q1mOcxHZ/DLmfglgg3ktsvbDq7i68MXLkiWyP+xx?=
 =?us-ascii?Q?ecHMBk7F6PD0LQQ7+BpTRX6bHUtZBNQ0U94iwu3M0XmdPYJeqp7a46ZbnJdK?=
 =?us-ascii?Q?GHxeZ3OYIv2YqNiJOyL9sDkyRnMmLRHl6+n2w8KhAxczeu6cSqV9FICYHP9E?=
 =?us-ascii?Q?pKRb/+jMWDtePGHwrl3HrOeoNLRYGXIX05DMzDxFm2VicyvZofHp9Yz1rCeQ?=
 =?us-ascii?Q?qayorHabwWl4MIcYYEAUlt/UfQS+favyLheRl7MmxPuQydChtEW7/HFIQqCT?=
 =?us-ascii?Q?sPung+2PLNay/RSyf0eJxiv4s9uZOyHDKbMwI3QXWLJU1uwo6xRL2lF4WYUC?=
 =?us-ascii?Q?vzYFe+J7E8ZEMF/8cBnwjQDUM8K/hutsdGe9vzjAB2+kqb/vVZlBwFaE5OOz?=
 =?us-ascii?Q?2PiteI/9cPj9XSH57OBmI/rHUYl4y0n6uKvCzo+R2FwAg4qYTSS80moQHkow?=
 =?us-ascii?Q?/VMesYyO1pOm/e6Ep5y9bAK+gg12d2pBeUhKwObg/WJPhM2k6c1tYtdl/TMx?=
 =?us-ascii?Q?3/Imrk4dRdzt87+iey+V3/sTzMXTCrgLm50j6EYcrEidOxwzTbfsY8LiD2iM?=
 =?us-ascii?Q?IGd2Gat2tJ0CKY11cXdhEURyTreOiXZjktWm0o3qeWeisYrMu+8PH+kbCnR+?=
 =?us-ascii?Q?RtAz+pMfZsh6xPUtnF7UQlwIDWRp4l0jBIBVvSqu?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e3de60c-e14f-468f-9b5c-08db19f78d40
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 01:52:02.4088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zen3EVCrNyz2pYFmZtSl9e5qpwWBPlv+eO4E08QexCKOaOtcbFHKcogydGoqDf5P35Z4uLXNVZiuohGikZWzVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7546
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Drop the number after jr.  Use jr@xxxx, instead jr[0,1]@xxxx, and
the DT schema will reflect it.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/boot/dts/vfxxx.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
index ff4479994b60..61ab76c43a11 100644
--- a/arch/arm/boot/dts/vfxxx.dtsi
+++ b/arch/arm/boot/dts/vfxxx.dtsi
@@ -735,13 +735,13 @@ crypto: crypto@400f0000 {
 				clocks = <&clks VF610_CLK_CAAM>;
 				clock-names = "ipg";
 
-				sec_jr0: jr0@1000 {
+				sec_jr0: jr@1000 {
 					compatible = "fsl,sec-v4.0-job-ring";
 					reg = <0x1000 0x1000>;
 					interrupts = <102 IRQ_TYPE_LEVEL_HIGH>;
 				};
 
-				sec_jr1: jr1@2000 {
+				sec_jr1: jr@2000 {
 					compatible = "fsl,sec-v4.0-job-ring";
 					reg = <0x2000 0x1000>;
 					interrupts = <102 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.37.1

