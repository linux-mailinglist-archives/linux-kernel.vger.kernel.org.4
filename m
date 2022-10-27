Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F5560F488
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 12:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235203AbiJ0KKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 06:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235098AbiJ0KKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 06:10:38 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140078.outbound.protection.outlook.com [40.107.14.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50429399FE;
        Thu, 27 Oct 2022 03:10:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FjibaWeED6GEFSA4tHuzHs93j9UQstgb7sEa8J05PF37BDiPRR0I+ogNXSmyGTCM5gZd3cY6lEkME3rELcHNVlUw0NkLJThUwDdhLWnyifaV1YCAg8plDZUbIMxzOZOhkx9mdwWwozvk0O8vN3Gc1aKjTYMz6maKakWNkOSID5SJTwVTx3KXi5t7QZ7Jefle5smbkz9P2IZa5MTwzURvHCeTbbMNhfa7es49rZNfKV32xc/S2SDpUVoAQOtXiQo8X3pDgQugQp3V4rMv0reB5SAYl5VjCerYMFyr2zeRIurSg0CV1KEcBCb/SfeJHcbSbgF/0XxUoHZIODWdp/UMVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QYn+64pMjGSiH46YejHS9KftcvOgTOtIt6dShOkXmh4=;
 b=ZG/lWkDVeiwXBoRI0UXLJE/vO090EthJZZYbBOqYrOorIyK7BagfWcWLcCe5npwUgiNNrlhr1DwbuiSSHpo194vOJV2UTC84lLP/MtaSe3H9qnXeV8197yNK9o/qOg369b8WmhDt+csOb8SNu9/5gk+es26PQ3eudXNkh5v52OfmCInXEWs6T1YzC8BcORO2H98ayuVLZsv61oeZCc1bYLIoUA3Gu+Unj4fvTPtbdkfiplGC7Dllvj2AJrIe8IpDl4pb2REAzsfZIgypMrOUaOZnSr1WHadZXTyR/q79NyAWmHkWczeNCZPQA/bhw4JhtIze+haJ/mFVq6tAsMuWXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QYn+64pMjGSiH46YejHS9KftcvOgTOtIt6dShOkXmh4=;
 b=CJ2q7SApHjm4Jmcjp7YGuqg3dGhymTzKkueNPCvmnXbRXvVfhZHyWzzG4RTA5+a2ylolEP4NtZ5I6Ky6w2dWGwPmpIqi2iy8618LiAIPKmNQPCiaypn2QS9oYK4nQGdArYSk6lPRFsOPtKZwMzrdK7HWnBXKLQxzakmRC+FDHC4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM7PR04MB6871.eurprd04.prod.outlook.com (2603:10a6:20b:109::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Thu, 27 Oct
 2022 10:10:32 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1587:379:da06:2f18]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1587:379:da06:2f18%5]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 10:10:32 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/6] clk: imx93: fix and update
Date:   Thu, 27 Oct 2022 18:11:53 +0800
Message-Id: <20221027101159.942843-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::11) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM7PR04MB6871:EE_
X-MS-Office365-Filtering-Correlation-Id: 86468195-be7d-43fd-952d-08dab8037b2e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zu1EmwfycoeaAgcEtwbCv4yzN3NYxsinKXl7dj36srKGydAxZk9JJnehNEiLAD5ma3RG6M3IZutQqIzb//RygzbJ8EGXw1O1DYOafqEFS4t4LTeXPnDTFewYhO7NPuk79cABnx+EouQ+Ld478dyPqkI3S5/x1VT7FsZU7AnoTkOKgDZTGqtdkn1/47VapHwBCmE2/Q9Q1MVFqEb//IRt3wlggTMazU64X9I+wEqQR/iXsoO3U4E0g+buXKT6xHD45/sLksUr7+K/GaJaWEPbglFjLNppw7E8Jo5AcHKZ1qADHWvthE/ij28BLwZSChKpG2Z1paLADgQMiWbsq2e7gXNp3uNSuuV9JFcS0xuvnr4/w5OqjL81IAI05Jz6ACIZSQ1TW1NplBhblk71e0L2ehNSp7e7Q2pBycCTyGwaKd0a9hJUFMg5TqHExFz+5ksrLpKgATFTo46WmUhlf04/cYWRFZvLnvelY8Ik3ZHtwZd4k0IwgVdLctMZJjqZfivrrms8YNQiO064MLGFLmju4ZIbbQH+9u2y6UNj9UBGudWaDt/UxNnEkOH+v+aBzw/GVM7DlSnuo494Ur8Gyyku4BRh489Kv6V96v2DjjDdpgrBUHaUJux7txS+7FgHMosOl+VSmZ5RGCh9O50uAqxKwAAni9uyFh+89MhgWfCHgPv6EIapOeVRctWBaws8u9/X8hcgfjyUTkhCx9j1bfK6lA7Dg1qUOmLA1CDsrKKpz9ZTY+N3T8/j4uooLaISeKcTt35VaoKfH9vttcM5WHvtWPbUIUzURYZysAid2kMShf8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199015)(316002)(83380400001)(38350700002)(8936002)(41300700001)(921005)(15650500001)(7416002)(86362001)(5660300002)(4744005)(2906002)(4326008)(8676002)(66476007)(66556008)(66946007)(38100700002)(6506007)(6486002)(52116002)(478600001)(6666004)(186003)(1076003)(2616005)(6512007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pveyk4EyuK6gn7QXnzwCODFF5EnzEWVzVVAGdNa6L6JFjzCNYlkOWPdA3gEL?=
 =?us-ascii?Q?/BvUC4JZzyEs8YFeLiAsPqfH6PJkr3t686c6B/5zJACxqJEjBARJ3OEV6sDT?=
 =?us-ascii?Q?+vu3bevqwp0BCLKdQqb30dahDXnSQgGaxVQ3k8kTmTc8OM0K+wZCcg7DqDik?=
 =?us-ascii?Q?JPsMYloPNBrTIABWdQGY0f3s/hOE9dc7dxuCbLBUOU13HFYSiLam1Qll+Tdd?=
 =?us-ascii?Q?4+eT+gEGgLTuBWPtKiGFbS8/eWSYBMPhN0ItexS+210kBDEKY4HxeSuxxkr2?=
 =?us-ascii?Q?IDE0DLPWPbkBKy3Pi9yQMTqxyxUZ5buDxuDnO1THqMtAT8xKGpNso4Pcp1sV?=
 =?us-ascii?Q?6pRqzGTaiIHnb2MVKfnWPxxVT5JzB4O5Pd9/5CegiQykJCix8TPN40Fjiia2?=
 =?us-ascii?Q?Vd4HhOO2BD7TIiFXIs6a255KKXPSH7kNPuAArwuRSdNrZbPEfOfGMmQPHg35?=
 =?us-ascii?Q?08Lg6+jGOQHY5Y3NJ7LOpHpabCK2jPVv/Mqr9dOKgT6ryI+uhX32r2b4ShYz?=
 =?us-ascii?Q?SqAlvmi4nl3yXH739VzfLZ/nw1LWDPY3zu4zHDgSvU5tl9rOO+8FIFwxGgTY?=
 =?us-ascii?Q?imZnJk4qMXdu5/B9JgECanri1YDHIGBTW9Pv58n/rz80rOLDY48q+OKTyR5j?=
 =?us-ascii?Q?4WeJuGjx3kcdSLPX+pwTv+lk16gZhsLZ+GP0OxOmYHcg5sLy14CcxiJGWCbc?=
 =?us-ascii?Q?CNTuyUTmB86iXW9YCGJ5LyV49VC8znjHLgWewI4hnYg4F1hJzqyi8q/qBQaD?=
 =?us-ascii?Q?rABXGT58z3jVRh8gyc+1BA0D84fTKqys/n3vKTkhg7MHN1/R8FlBXeQIYEgg?=
 =?us-ascii?Q?DpoZxqzewiq+rN6Ja61faqfPYwCCVAk0aki1P9E2Wbtbs8J73WChz1Dfn9YG?=
 =?us-ascii?Q?CIqLvpMRIv/vTZTNLhRXT1mChRkqnRKoOuBccPA3TqjQ0I4/FY5SN40agP+a?=
 =?us-ascii?Q?NWNpyUUtK4n/BP+OT4rrCTRlTXc48dkUxryZ7nm2MHC8XXfnjPFESuivNhqt?=
 =?us-ascii?Q?s0J1adbfxc+JNYC6dQlKb7hcmDtJuZtLjVbl6g4/Zgc8qYENG2qlaQsuRQXv?=
 =?us-ascii?Q?AuvzHqFuCwzvfMlCFsY0l6mzpOlwpJBOcRP0jFY94nfwfqPgYbRFgEmgZ+oh?=
 =?us-ascii?Q?NaGkWNm/Hd6FomJEdlF0CCNp0FQYCLHsldG11OjgnCZ9PYa2MnOX4QdKXa7r?=
 =?us-ascii?Q?dtsekvUBIpFglRroWUWyLMc/nGaSlGKpG254XqkAuqX1L14J2M/K3t21T024?=
 =?us-ascii?Q?dDiyAVnr/YaIXxa5/s8mHi4V4P3fngFIxd54oPSea7s3ifOGML9hHt0oMiO3?=
 =?us-ascii?Q?aG/USHsEdY8qP9D6w4Rtu5w4jjtdxFKiK16yrusOoB1wlAe9ZpqNTkINdi4p?=
 =?us-ascii?Q?yk87F3a2P8vWjeXga3wIvdUfobC+G0IgPd/XqPYwq2SuLLLC0lpyaTjNw4/n?=
 =?us-ascii?Q?9XMqrWZ/6FDZ4B8tgKjoB/ZYeSbwdMSzEzE2VKP15bxrxc/7Y9ft/t4JMxg5?=
 =?us-ascii?Q?HSio7rlyEdEAuGEYNroB804M+2eP2cE5WyzxInm9uBGl6dKjVltD3vWHbcX1?=
 =?us-ascii?Q?I5XGb/AKZabJPlaYkwqyGlIl7xUUdlZvveGcy8EE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86468195-be7d-43fd-952d-08dab8037b2e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 10:10:32.0769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9J4lfveoikeZlLSQxwNyazHjdKrtmlAEImVngNcxzbN6mYgj1V2pJyOk65mS0H+iT0XlYSez3j10Qq2Q7KQbqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6871
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

patch 1 is reported by Dan and marked as fix

During our development, per updated reference mannual and design
information, correct enet and drop tpm 1/3, lpit 1/2.

The TPM/LPIT patch 3,4 are not marked as fixes, there is no user,
so update binding and driver both.

Patch 5 enable HSIO root always on
Patch 6 enable sysctr always on for cpuidle

Jacky Bai (2):
  clk: imx: keep hsio bus clock always on
  clk: imx93: keep sys ctr clock always on

Peng Fan (4):
  clk: imx93: unmap anatop base in error handling path
  clk: imx93: correct enet clock
  dt-bindings: clock: imx93: drop TPM1/3 LPIT1/2 entry
  clk: imx93: drop tpm1/3, lpit1/2 clk

 drivers/clk/imx/clk-imx93.c             | 33 ++++++++++++-------------
 include/dt-bindings/clock/imx93-clock.h |  4 ---
 2 files changed, 16 insertions(+), 21 deletions(-)

-- 
2.37.1

