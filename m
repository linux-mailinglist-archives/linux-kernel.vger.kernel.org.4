Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A225F6865BC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 13:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbjBAMKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 07:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbjBAMKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 07:10:00 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2131.outbound.protection.outlook.com [40.107.104.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED8944BDD;
        Wed,  1 Feb 2023 04:09:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQid3n4bsGCohPQoiSMHpvUO+KHIzO4hWiRl5CQzNgdN9ikQ2lmQZueyarbBNJpJE4HdJjf+LtlwSdeEe6ApqO1Gq2FTOTxfMFxGEIzcr63gRn3E5kb/fsJr2YcT9wGQXD/hxAiK1EfOyk3t+UJUuMJIPB7+Whiu/GUcQKm2lyeu2vL3mGz00gxB9WMfbMDofBA53jbRlhZKUQRtluuiUk6Ji0hxjy+bETeU4CE0w4BzJ1qGVJDx4eUr/+Zv9ZujZ0zGCoANkA4TwOQMR2vu3t3MO2qsG0jNdEshIF3QdJPQxWkk6eAFhoQVQRPpeibDfbfzsdVpspa2UgfXimKA8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7a2Jf65klGv6Fg6Hkaesf+ZITHdAy5qqiLA+j6y3dGQ=;
 b=ZkhlDkM0Z1U3tZbIsKqwxxTP3Q5dlT2Tae+2hW9RSzh8t76BBtyWCItG5l0OqP4scaptBVZiqAVPXOOAnDbkx6xZyHQmlXaq8GUFMM43SOvsWpfj/axECw+B7gUFfqdTD2RUP++qyQ6akWtmTFLE+hH4FMM0Q9sZe7ZkzIoCc9XbK8VQxEJn+AozybOE4fgjPyyBlUE1dQfxZoTvRPTFB1h6EkILHCkFqKyQ11sg3t9xUsU8u7hiXj9/U+bSmG8Kp5uEh8XQejwrxKE78ddYF1erFK/g4joZZGn7lUv0It6FkZbl2KbnKdB37toX5HfpdpDwtqkSF+bPXZ+0ldm6Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7a2Jf65klGv6Fg6Hkaesf+ZITHdAy5qqiLA+j6y3dGQ=;
 b=GkF2he/VR44PuHXkIFgi8Ctw9yb3UtwjD0PFBADviQqXeAY25O3N0NFHa9nI5/AndzFEHb6BKi4RScATamrKEOKxNqlFG5Nqkhvp/+VsnkS5txqDafTE3KAwY1Y5VIioYJHcsZMWKhK7z/BFIbni/cLh4M+YSmNQf0AwvTdC83qaivE8mMl3CfwIof2PuHCddolmQ4jzGsUTNVmNAiXCO2Tx8LHRwVYvFiehNGxXFojv4w0gxoT7MMislH/n+z6WStD3uhVA721T/wdeWel7bcIOgoV1FFHSGBCHgOBMZ3ZUYbZvCsdP/DoM9qovM/HO5HR5nE/mICxxlgflb3IxBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from PA4PR03MB7488.eurprd03.prod.outlook.com (2603:10a6:102:bc::11)
 by GV2PR03MB8749.eurprd03.prod.outlook.com (2603:10a6:150:ac::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Wed, 1 Feb
 2023 12:09:47 +0000
Received: from PA4PR03MB7488.eurprd03.prod.outlook.com
 ([fe80::be04:b005:c96f:feeb]) by PA4PR03MB7488.eurprd03.prod.outlook.com
 ([fe80::be04:b005:c96f:feeb%7]) with mapi id 15.20.6043.030; Wed, 1 Feb 2023
 12:09:47 +0000
From:   Markus Burri <markus.burri@mt.com>
To:     linux-kernel@vger.kernel.org
Cc:     Manuel Traut <manuel.traut@mt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Markus Burri <markus.burri@mt.com>
Subject: [PATCH v1] colibri.dtsi: Refactor ASoC driver name
Date:   Wed,  1 Feb 2023 13:09:00 +0100
Message-Id: <20230201120900.840725-1-markus.burri@mt.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVAP278CA0009.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:20::19) To PA4PR03MB7488.eurprd03.prod.outlook.com
 (2603:10a6:102:bc::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR03MB7488:EE_|GV2PR03MB8749:EE_
X-MS-Office365-Filtering-Correlation-Id: 0790f098-4eff-45e9-4e35-08db044d360a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Hsri10/UG0BxXUT2RJk6uUYeo/1CxO4upgpolkLfpim8/t4VUXgmcirgHue2aal23cXuY2e0Jobzm+GgP+O8yGE/yX32nax4PK+obpCbaVjcm0KycBUpw7MGhNp6L4tje7HNIRqohFAY0crisM4RZR9HqHjPJPVo9eYtlr10doMrMDdBnH9Smvbn0ynFUz11OXKpoNEUiZenyY4tylE4kZw09QyF6z3snNtXVEuQn5H+QUJ34tindNrB1g/R+K50VYDT5U9TBf+h+qUX24y8ouzvON0cDLfYXN0ODdad2eeC2WC2dtT6Y2Xh1RN8cUreyJaAs+GhZsJ7ebR4FOi6q7IqzozIgmbVLmVQ1nsNxkZnr2pzF1jTHjqO2eTMDn+5kvIaxzzW3GtFVVXzUNDw2fzT4qrSRpqGt+BmlDsYflJFTVdf1YJtB4wTuiyDpFgWLzZvDkkr3B0IRi4Z7vtyCNwFCSpHVApAEqQq8LGM6WlFXdYII0uaTYOt/XETZey72mcCXCovepExnSlVJJCq4LneAtQl8XkZdrbI3Dye2HIslpF7iDOTQiTJOZcmpj9PO0EGm+2L3yZ5FUtgUdWN5vAHrk/uhARILhgMXjK+eggIcYIgWScShbXzpo3jk9CwA4eLmSiQA7b+gMmDXEeOPv68ej6vxBlvrMFKGrT+cf6k9gnARbp3FVfWs2WNGWXUw3lLghPZ0EMVLzDeSz/zw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7488.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(39860400002)(366004)(346002)(396003)(376002)(451199018)(83380400001)(44832011)(4744005)(7416002)(2616005)(86362001)(38100700002)(38350700002)(52116002)(6512007)(36756003)(1076003)(26005)(6506007)(2906002)(478600001)(186003)(8676002)(6916009)(8936002)(66476007)(41300700001)(4326008)(66556008)(6486002)(54906003)(6666004)(5660300002)(316002)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UKmyRkNQ113pO3F2nYtpkegSlKEUCh7yHOfVTYtMA7weBlwHEak8gqIpPJF6?=
 =?us-ascii?Q?cyFhdTAdkBVoG9ZX7m/YjtzfD/OvlZ3s/xKMnnH1kzYcjoEjU4otN5a1VuUs?=
 =?us-ascii?Q?k7Q46YslAAqmTTYc3JTqtm0jffBLPQZq5YYO4vKlpQZbD1GPE8tcaUdzHOLl?=
 =?us-ascii?Q?QtnPEOq1XMTg6SsPRyMHq29tOvhSlSo47KpAj8jOKCucoLvFatJw2A2fuQDg?=
 =?us-ascii?Q?Z4r7pUV9jr4GgIb4jkIbxpWdFJmG3UnJ9YUXXwopikaiGxJ07696QBgXULBY?=
 =?us-ascii?Q?cWzJVGSY2pO/ztxNvvnWHBmj2SF1oGVDZuwopzfB+sBBwbgU1TxC6M2md4KC?=
 =?us-ascii?Q?WEQgLvwfxInEZdfazJ6J2C1i4q2ktiHCYKvN226tYMjbcFtYVBp7E5iHemWc?=
 =?us-ascii?Q?FzMXyBUNfX7ipi6qyEHxUTWZrE4QGDVhIqP2YcqXwpsFdBAFMFHpmxgO5SKl?=
 =?us-ascii?Q?b2Yh8+GqF+2vrKbpFnl4yKZVjHUgPXDz+msJYKGqe4SvoOvzx7l88rlCgVsn?=
 =?us-ascii?Q?BGuX/APU4APLpAKuCFZF7VcOo8yoHMi1HYhozvQBMRmXDD/F6l6KD3quRNf8?=
 =?us-ascii?Q?OSy34HpS6RqOpt2856FuyWsbboUYN367T898U0RtegoPD+HCwu2Iu4PZwDyC?=
 =?us-ascii?Q?LpRnH2Vz1/mmnGyCaQ3yskB0bE9WYcnXB6jTN/1xGfOSJfl6nJ403d0YBGZC?=
 =?us-ascii?Q?gjdHaj8h4D8iSczxfhpE8xZu8MVsc06QT5sfUhi7bSgCYfmxgCMenrCksTkb?=
 =?us-ascii?Q?8Sq99E3GcW+6liB1TB8W7ByFV0eDpcgbUj+lzNciIfPcXRoeKA5CNFQ71cMm?=
 =?us-ascii?Q?YyPj/cT6QxE9ea+UxnFeYHj4uYrqaLG4HKzcMtbXitkIEMH3aSb0/yYrZzT2?=
 =?us-ascii?Q?GL+CcBVGhOcvo+YDkG4ROPEfat/Hh/PfSB+Tvyf+syjgXaF39e4dQaIzQ8hb?=
 =?us-ascii?Q?eNIJeeSrLRcoM7LiY4zoy18x7lnSg2/v99iy58FNjeKgW3hnxPIyt72/3KEe?=
 =?us-ascii?Q?XNqheNRRSZqYd+MJC9VbDKCUraeFaF+tQEeAlxjM2aw68hEu0a5hkG8Y4I6B?=
 =?us-ascii?Q?KgnvbgPfVMam0ekzdu8OvO0Gu08XTdmdG3F1iZyidMAPyrbCXWPOHKt4nUS6?=
 =?us-ascii?Q?WZOQMdp0mk3XzbrT8EfV3F6R6JimgZ7+CvAHw0lgvlH3jKR51dV0Pul/DmV5?=
 =?us-ascii?Q?b81wffW7aIQJNJCqR9Hk7hKvceapbry2is9p5/AuUGQvTP8z6XBZo8E/+mq/?=
 =?us-ascii?Q?gieRof8mbgF7hxSlY3N7C13HN3b1hdE+7q78YcVBKSsg5lzztlHvtPHwUPXr?=
 =?us-ascii?Q?JS/kvg2K6S/M2i/XqSm0SzxIZxeCl8YE+7U9swWdqmoL7IcDjcQC1Jj4OGkV?=
 =?us-ascii?Q?sBibTN5Lu4+fPikcyXbbDTqsXeM/53DduiXbrBOFAYlyH9/R2bGLauV8dIGn?=
 =?us-ascii?Q?NxVfXg7VPtq6/1oxgLdsBlR4DrJ0QqQWveOrUbigL+2L3pHq1VzwFRN0DEiu?=
 =?us-ascii?Q?w5V3G038WTacTjnq2ItPm/gsm+NSTYu7FU3vLTGQe064FxexUJ1rgE2xfdJ1?=
 =?us-ascii?Q?BlDENKZMkuYriwM8AK5r5fPHQ26a07hkcpxBcEnG?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0790f098-4eff-45e9-4e35-08db044d360a
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7488.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 12:09:46.9631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 74xX6CW1Ws0ZmFwZ48ssZsVmhNrFhSEoGl17GCjew0WikKZOf+JiTQ5EtOM1WN+v4raKfk/d0t1INcNijyiIfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR03MB8749
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manuel Traut <manuel.traut@mt.com>

ASoC driver names have a 15 character size limit:
[   21.917463] imx-sgtl5000 sound: ASoC: driver name too long 'imx6dl-colibri-sgtl5000' -> 'imx6dl-colibri-'

Use a name that fits.

Signed-off-by: Manuel Traut <manuel.traut@mt.com>
Signed-off-by: Markus Burri <markus.burri@mt.com>
---
 arch/arm/boot/dts/imx6qdl-colibri.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
index d8f985f297e4..f50030cf208a 100644
--- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
@@ -129,7 +129,7 @@ sound {
 			"LINE_IN", "Line In Jack",
 			"MIC_IN", "Mic Jack",
 			"Mic Jack", "Mic Bias";
-		model = "imx6dl-colibri-sgtl5000";
+		model = "imx-sgtl5000";
 		mux-int-port = <1>;
 		mux-ext-port = <5>;
 		ssi-controller = <&ssi1>;
-- 
2.25.1

