Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B199A633A16
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 11:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbiKVK3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 05:29:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbiKVK2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 05:28:51 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80045.outbound.protection.outlook.com [40.107.8.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828AE5E3C2;
        Tue, 22 Nov 2022 02:24:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TCVyM+LvZ9Aqxmyz6iSA3q8elC6NklGkfcZeW//vcj/AMjy+HFxBhT7ScXy21S0n3CJ5pYajEBB+fTmm0nGLVElcb4PDGchg48pKc2bBzayynPrJAdVpFPc/Pmn+R01F25ZrL2lkMprLmXqLb8LhQWPi2tsLQC8UIj0lJJo8oepi3TBkBMOX+/paV1lRhaOXljvmLQnCjt+PCGDkqYtSVO9k11woSIuR9bWmszDnxTW4bSzYDA9uU8+U+dkHu4aB6M+N2HIWp00y8CIQwA5VVkFmT7Kr8cTbHOG0x796tBuG/CKeAEcMMpx2/55IerQIFjqpOzyZvBeZILAZ+Ng3LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m9l36Vhq3JyGMCrdSPAOC0EBoTUN5Ij3qw3mtgku6e8=;
 b=AUNcTVV6+CLu9mgVUojg93qCFGjaHd2T0/iPvrwSmOg4kmV+COEw6CTfRAg+hSJcSo6pnkIVCeSif2Q57TwQSYycY5OVW2hVx/qsw+WTEUfIdOqB/NmKEw0JVy+NoZ0aIBvh5BEKbkWN6BMoory5qCUxGY4/JWwg9jh7pmlxP/xCFnxmZx8NuJmzkzopyv1H2OKRCfVgBF/wqB2ni3kaSjmBZOe88RlcTapeNLGjbkFIF8R9cIx8MUVD1kEb13KwjL2iUjVMc7h75n4FLob1f8nbgDPeQR45IgXr9ZFVHyujwO6JwnTDnYz31Locwubtuz7XZJcKjGCUnu+sw1GDLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9l36Vhq3JyGMCrdSPAOC0EBoTUN5Ij3qw3mtgku6e8=;
 b=WbO46703V3lGaRjWp36T7W8fzS7gUwDnYt4620hNgwSWGPR7e28k7zkWVg260LwzifMRc907atafAo3Bfb5N0r/Wtp0gTAl7Df99JqtH5qCE06tNZ7/tQgNh7PAxdbUDlY1WdTY3SJAtzDB6DmZO/qfMJe1CPyfbp8s3TP54LGs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com (2603:10a6:20b:43a::10)
 by DB9PR04MB9703.eurprd04.prod.outlook.com (2603:10a6:10:302::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.11; Tue, 22 Nov
 2022 10:24:23 +0000
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::7686:5382:16d5:c6de]) by AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::7686:5382:16d5:c6de%8]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 10:24:22 +0000
From:   Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        amitkumar.karwar@nxp.com, rohit.fule@nxp.com, sherry.sun@nxp.com
Cc:     neeraj.sanjaykale@nxp.com, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] tools: Add identifier for NXP UART BT devices
Date:   Tue, 22 Nov 2022 15:53:03 +0530
Message-Id: <1669112583-29804-2-git-send-email-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1669112583-29804-1-git-send-email-neeraj.sanjaykale@nxp.com>
References: <1669112583-29804-1-git-send-email-neeraj.sanjaykale@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::14) To AM9PR04MB8603.eurprd04.prod.outlook.com
 (2603:10a6:20b:43a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8603:EE_|DB9PR04MB9703:EE_
X-MS-Office365-Filtering-Correlation-Id: 5daf7c57-f9ab-4adc-95fb-08dacc73b8f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xbZtcPKjAsxWPBvKm4QkIaU9hNF+yJOjZWiWj/RhZK926yL7Uay9J/bqqjF9kfM9thcWv0HUQD1IYzhB4ruW/gyOzWOCjfHesbdOaL5ReZsHTlbK8DDTtEk4CVmQmdbkvlXFi7urRfhawrupZ6Uf6kiJmZKaSTPyCY/KzCgEKnsVzx0X5zL03lpOHn8VaollkizkOQNyO+yevEolJmrRFUpTUZtZCROqbQggmlVDUNxhutZGn6ZjcmLUl9Scrrc0SaYkDh6qqFoYFky+vwRsJelfMx775N1+DCoQj8vuCzWQMwRazebPYpsKbwDqslLTcCNiKRbpmj4h1Iy/NTB7qMl1YqFbTZvPDU15ADxdwG2PKIGuQvz7j8vCIhOsx+4rP+ulCD57su22cd8mfM4golhh4ZY+7GuT4NSv80+iQDEeLJ6AEgxxyRmzH+q8OMRbSKfWnkvJCvagtUFCp6EE7SN2ak35Yg6Cspnv2wfu1DT3A0NALKCtT6mmfl1nAiE8Ripy7Vx3J0nBm0dzahMDNZFHhJWbdLKwSj94GccaWkjIkpTfponuNa++jgths1dPo03mCT2hw/kJdbjk5hG2M/gA6oQdOfRD3fEdEVDWLd8PE1XulOwgcZ7odCdYP9hyjEncKn88AL8hVRSzgCw27Sr89HLsD1FGSevy2tw+dQVTnx5NZPeUQ6+J8RzEWQI5IAkdsYvER10YgSMS33k0PA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8603.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(366004)(396003)(136003)(346002)(451199015)(2906002)(26005)(8936002)(5660300002)(4326008)(6512007)(4744005)(6506007)(6666004)(55236004)(41300700001)(86362001)(8676002)(66946007)(66476007)(66556008)(52116002)(36756003)(316002)(6486002)(38350700002)(6636002)(478600001)(38100700002)(186003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9L406XbUcMFxLNBZi2Ac/COS67QlqXCRmGKHQJ+TtnURD63XAYpqKNEKwp/k?=
 =?us-ascii?Q?hI8+AVap9MWfR5bNUEmfmtvrfCKabO7uljBV0Z39Kk11YTIyjx4ajrHHf+Sb?=
 =?us-ascii?Q?MSQALk9TKxW/vd2OKaCEuqcI5IKcgKRLYqu+JQQ1Wmr6xj5lOUiBk2IZ+q4X?=
 =?us-ascii?Q?E1P48wvkJ5EWPQzVojycdW9cxc0stmh+QBOar46MAyiZYhDyiLOiXYkqlq3v?=
 =?us-ascii?Q?Z2kEfvMaRiDNTVAY0+0Yv/uflSRAxWbHkeRmVLfGqqoVEf8ub7vNalNw80oQ?=
 =?us-ascii?Q?pKjLWyfpzTVQUBS6zVXvEawYko7B4rM09r716RPO02p8iG0zHEkq0w2mvy64?=
 =?us-ascii?Q?HCFDWMpAg34DyW6EmGB1mwk/7GunPxsgLCNVU1dFqcdfqzeXLxN6Xt1dsVJv?=
 =?us-ascii?Q?k9sjtnCnFVqlMXSeFg6OrX6btnxmaMY8he7Nkz4nT1FasakJm7NeG7f7kk8j?=
 =?us-ascii?Q?RnwqpiAC2tIoJorkj5YTHO5pJCzWxqsQIvfNUUx8LAoMunFD+V+R07e0/5ZD?=
 =?us-ascii?Q?is+SRFJLxmfZErKv13FIIfyNvMKIyxqWjAhiRozsT8zHQJal5k9ugo8QwV3B?=
 =?us-ascii?Q?O3VzpQdCTki7Fes6ka3YdJ6LiaJ186qekrRePOuS/vAMgbUxJcuE68zNYrCN?=
 =?us-ascii?Q?ovw6qvv6QLh0/kGTrlmXJtPTwqPKVUhq/k4UgemN83mjoKZrp5KHLEq8uxRq?=
 =?us-ascii?Q?8xZ89+eVFJuFGrZrH1SQ/FHixUK3Wsuiw+ACHuj+YbznTc9rD06iSEdFl2Qj?=
 =?us-ascii?Q?k58Cu/dz4V+ZqITw4HKVohqohUqbMRIQIViH1ib5991EbWOF8cU39kHgZ7zb?=
 =?us-ascii?Q?Vwf3Upj9Loh4hr3FxelZhe/xotqopd0cCol1Wa3Wn7YIAZqLd89zkR5vcDxR?=
 =?us-ascii?Q?534l7UculHMN4l2t1/CNWS41ollYud1/1to+zk4+Ob/rOPRPePDZi/+wdgTd?=
 =?us-ascii?Q?WlJjDliXqkitreO2roTSdiTOXebc/dQ17METGa+FFOFKRSf8UTXhoB4576tE?=
 =?us-ascii?Q?0imQnPBOXWDkVyt5ORsuPzSCZ6NAb9gz3rfvdpv+irdQLap3V+s0lFVMdTjl?=
 =?us-ascii?Q?QK34j+K/+MGL+j7hkrjHLs1iA381fFFzV2IxxykwL1/on70h7WV1QV74WNtn?=
 =?us-ascii?Q?9CE0hoOIL7ucrCR2DvxNge06f1lzKel453E5dnzipNeRKANdV7jesBwNmwIX?=
 =?us-ascii?Q?qrcqVth3r10pg4QOKBYPBItTxDM4mgSjk4O11SxMrLSZs3muGleOSyqkeaB4?=
 =?us-ascii?Q?dkMb+PFGbMHNAHxfMCmwTWIu7hI7NdE1nVeWS6/3LnWjmbpGXjX6f5wT8Eac?=
 =?us-ascii?Q?PqJce6O7i3BxX4HoV8p65sTupO0AB+wPouNMcrOjFQLfcbtM2Q+UrlzNKKet?=
 =?us-ascii?Q?6wDLYBT96Ae7QnI5LhYrgEwoweMHjRbdvy0IgzIvAThckiqTr9CpT2kgZh3Q?=
 =?us-ascii?Q?FUjbweCkcCtZwUATtvxQIXPywK4+FR+Gw7ut4Av2cbtwC6+gYYJd9Xtskyw0?=
 =?us-ascii?Q?MkgPHZlFR8fhyBmudaehfhS4HIkhZIPnvQSyqvXD00O+pT0skarTKGmop/nV?=
 =?us-ascii?Q?DnKux4G0ahcCgSeoMpN8eS99ctm/PMYJ6gXOm+wTwZrozrM6Fl/eRlsyJA6s?=
 =?us-ascii?Q?VQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5daf7c57-f9ab-4adc-95fb-08dacc73b8f6
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8603.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 10:24:22.9057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: arNlaJE8YqNO9+njcru+s6pJDfBCbb27WYdBOxB0UIZ5I69noz/DncSAk3QDRE5ks8tNfl8O1t8gY0UHgH2Y4RlEO3cqcOnnyA3oo/4EMwU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9703
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add identifiers for hci_nxp to support NXP UART BT devices for btattach
---
 tools/btattach.c  | 1 +
 tools/hciattach.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/btattach.c b/tools/btattach.c
index 4ce1be7..8a30c5b 100644
--- a/tools/btattach.c
+++ b/tools/btattach.c
@@ -212,6 +212,7 @@ static const struct {
 	{ "ag6xx", HCI_UART_AG6XX },
 	{ "nokia", HCI_UART_NOKIA },
 	{ "mrvl",  HCI_UART_MRVL  },
+	{ "nxp",   HCI_UART_NXP   },
 	{ }
 };
 
diff --git a/tools/hciattach.h b/tools/hciattach.h
index 26c0d54..d62cabf 100644
--- a/tools/hciattach.h
+++ b/tools/hciattach.h
@@ -32,6 +32,7 @@
 #define HCI_UART_AG6XX	9
 #define HCI_UART_NOKIA	10
 #define HCI_UART_MRVL	11
+#define HCI_UART_NXP	12
 
 #define HCI_UART_RAW_DEVICE	0
 #define HCI_UART_RESET_ON_INIT	1
-- 
2.7.4

