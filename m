Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F525605BF8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 12:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbiJTKPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 06:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbiJTKPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 06:15:47 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2061e.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1a::61e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4BC197F95;
        Thu, 20 Oct 2022 03:15:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NPvL/HaRXmrZhGkRybhi9/rR4YmdVvCNO4rgwphtbziDYLlF4Rm2+PVyJ6Qi+DZFcueZwJMgKzTPgYsiyfu/8EPOp5GlCNgAFPVTwiZxMkWwpPsFKdC0fmsIGzxILsrKYBaTwmTWl8JhfrjP4z+cf0sGVlxRAlwI/dyg7as9fN+YZmXBZc70C0SUlUA77yM5LwG6hhCVWfiqhKDwShepcfzNjqDgkuO+pehFAD2QN39gcbpSR0KTUpmgkdST1YaVT4iR2qAQYfVETUU7gUIpIzKkAIzdqTpN6aJNm0Pht0w1ZcFAp0IIDNucjxgmjBoRgMTkOJf5DV7o8l1MZNzWqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RsItDQ2SqU5bfB8W0oZrH6w03WMqJFS4WITgqJxL8P0=;
 b=Rv+7by9AevqFC8aawps61tiG5tU7HawHZTTRjB8gjuzBPDxX/+eY/sJgFbvWCYfXpXsliu+2ciPpLAyWkyqezf3zo3ha+joajtI4c0BJgGUQcELVkvXyuJAzaFK2/0mJ0G+ooN9f8bJc7hN6iWvaXd55GkwHi7ojZoY6OQMDujvp7ZWG/In0hISsDe5o+WOechbyKMWl7Bsy2Iyg+3+eDYQ5c7N3kjHc83GMWzYajUd0mdc5EAR2WO3wv5nAiESZXatM8wBpDdJ8i9EzGwNLJXYx2xJVAi4djwBTcj1gu21gntUl/7N4KDKqC3RqoZCQE2ol4ER4QMTBoPXfdPGIJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RsItDQ2SqU5bfB8W0oZrH6w03WMqJFS4WITgqJxL8P0=;
 b=KbcONVVeMa5eduYEe8FeG+KaW+lSCwSrAyAprmvIoi3E/r+cWqSZgePjOM9rwUN8taBearHd/BdOH86LdRMPxFUeCN3r5Xrlbhsi/E+ffXlBGKvrg20HA/DpdjvIgWWSkVuQh6AHRvaGFDdVX5rhVFUGv+P9WChIJIlA/beJOAg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8127.eurprd04.prod.outlook.com (2603:10a6:102:1c5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Thu, 20 Oct
 2022 10:15:39 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed%6]) with mapi id 15.20.5723.032; Thu, 20 Oct 2022
 10:15:39 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/7] arm64: dts: imx93: nodes fix/update 
Date:   Thu, 20 Oct 2022 18:16:55 +0800
Message-Id: <20221020101702.1867188-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0039.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::16) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8127:EE_
X-MS-Office365-Filtering-Correlation-Id: 62208cee-665d-48af-bb6b-08dab284099d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZukDpM3cZ0VusjjuG928K4OhCkClJH/28T/B2dfOg+9hF89NLp4S7xtlZLnoiPX7jNfRa0cH0EJEAg6s9vvq1b4HBytixypqtlPPyiaJH2gAW3Pj1vqA9MWgzpjD1+qwuFRrFpj/KIfOE4Wtqe0cCGkWiQ1gCZkgPyh2S4ByyXnI5/dNDfVYcJvpT8RibCRlTo3+j5KwTcN+aqgEbEC05PRgSMhgdtduu2+UXDmyR4lRw5VpgnMwpmj9dE4vrRw7/KQeT9mAecKMqs1t+omyzz+QQWhfgoJAi67fFnhLO/E8s7UE9/u5XCOHRzSGdQVrii387N+bzWRdri3uuoh5IYNNRYJsqlz9mJ7QU1/z1+NnS7XhbA8WB4kucvEppxCISmlqtTM9kon7JiBTpq0oT63uE/PkMvygvkE6WC3oGy0LVgDuAI1F9i9XPjMYkyd2gmNCkWF/cRn89vT+IcXtWbKfdjryvRR+/PDcRTitwtAvbpljGHbOt/3ldjQCVy389n8RAUfofZeaVXbS3/gobRfCVfQUe+1Tf3oIW7c/Gn5vPB1FpHtXuW8E9XTwlZA8HjoQWNU8U31PtLz+vUVcdTWcp9CQTamzfdVdkSVLD5MuwBxX5i+lZDNzoi3Ezd+w5inD+cthNwsdjSIBp51lK1ScA5bgUoinscdsLE49CEkBqMbQokncCzcbWPOfzx1zsESyMPOJRp+UJc7kG3vv6jsMNqzyq5V+v3SrycIWuZWXx9u+67DlHPX5IxvgmImFn20gsr2+rnwykWZBZGrWLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199015)(38350700002)(186003)(2906002)(1076003)(38100700002)(2616005)(6486002)(478600001)(15650500001)(8676002)(66476007)(86362001)(66556008)(4326008)(66946007)(4744005)(8936002)(6512007)(52116002)(4743002)(26005)(83380400001)(6506007)(41300700001)(6666004)(316002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FiZ1hHDuLBclsdWvAd7w5bFZHcgQygLB2noDB3Z5Tgr1RkGow8ehja0QBEic?=
 =?us-ascii?Q?2NG7t8o8t7yJwNBQkOXp8opJ+2ubMzu9zT4Cq4X/5iyhzVeqlPcKIj7u7i9J?=
 =?us-ascii?Q?F9mCZIPFXFnPAivAZU1qK1q+jnwCS49w4vsHrYG4B5bv4NhtIuS8htS7FrVz?=
 =?us-ascii?Q?uEvX8wkCZbJNy0xNURn5CfjsZGDq8arfddRz2siTwUPxNgzf9nn4BoRLZkoo?=
 =?us-ascii?Q?1ihZJ/nxfRJ7FzeSlarmgx/+nw+md4hen/MAOoi3zB2VnQB+5ZSTSYFYY30J?=
 =?us-ascii?Q?js5wbZ6XKKuesCOO5G1WbzniKAlEOlFM3v/VDE/VKmweDKiet6VKk30dC5D3?=
 =?us-ascii?Q?I0+lG9fhMh1RET86vegueO+viM5dTksomOGFbK4s0tUMN7LZ4bzFLLYBLFoU?=
 =?us-ascii?Q?8LHMNx72JsRjsZv8bh0vqH/vWkg9AWx3ChJfkr1a5288ZaqBdpBPhLN3o1/k?=
 =?us-ascii?Q?5He4q/ny2x73gBVvMIoSURH2uSSvGScULMDpdhMUy40Y2OMLlC1iERnt2NBG?=
 =?us-ascii?Q?X6UgXD7g3iZ+Gkc3/MSzDH6pl0HWFYMyV9ARhdD1ejNz6EYVroiZKhjBA8Ns?=
 =?us-ascii?Q?AJqdnK9MgwOLt/USDsQ+sRalYfLnvJk76xAuC5a5BgBn1nC1pIHA6Lbijpie?=
 =?us-ascii?Q?H1MH1Nn2mJjIklJ5n0/3z7r2KqZzWfx7Km/MuI5/cSp5/FhOAIUCSAS4v4Gp?=
 =?us-ascii?Q?X6eF/KkYBr9OSSZIKBp/pX0hIvz1yxAafd5h5FawwX/6R7oLW/l0XWfLDsDK?=
 =?us-ascii?Q?Jf0BzYyPiO4dicGyAjJfsN7l0X3guBsbY5fSjfJPddHH9MgNTJF+wfMv5l4W?=
 =?us-ascii?Q?Ra09I4f3Y96X459Rlhydkr57tue3VWczpcC/BP+3UfxbUkaTF5R8W8GRrKEL?=
 =?us-ascii?Q?pdO3p1l0BC0r8dR0KVyV7Oy/NOIBdGtT+E/gMjTu5mBFBmDK7YOb/GFo23Uu?=
 =?us-ascii?Q?/lcFtdhgTosPzzcOAHprIPFcp57R+GabI05todP9Pn32qbjz2ns/3oQxuFoL?=
 =?us-ascii?Q?k4RVZefsxGPFlQnK4s7lUj4PaE3AUIq/LZ7tWU2ryIqYGSDz+Eup1BMtLXYU?=
 =?us-ascii?Q?Y4gNQdpXnZoEAZyF1AkpV3PsYDtwWRkYCFUkQVO8Ebz5ICR1CogbWr0zucVa?=
 =?us-ascii?Q?h9yVxYVtpQdL0so3polOn5A7JYa2eSYeP/xYEu9XdSdT/Qa4sOLprnW/xqIn?=
 =?us-ascii?Q?R8oXWw98z74efuSROoZg4AVrbVE5tV5OGe2/DDbAQddl4uxh/sAr2s9gRSrj?=
 =?us-ascii?Q?0bhzQL4SlbWfVYfb9wbA3VZWKNaEzCr9UtzjcQZZ6Ud8ho8UuL/FpxqxdiwX?=
 =?us-ascii?Q?nKaWplp7tyYa3DFpPh0VycktXkIrXGEcil9Po4cf0z4CmA3R1eblcs4qpfWG?=
 =?us-ascii?Q?auvEZ9sPyGcwnPyK3oyMNm1tASd/IeZywuoICYbkQoKNE0ENet/x1AeN/Aca?=
 =?us-ascii?Q?qES5VndePJjF0NbvqqCfrbaMKWjMEf9qzXv202KY4KgMpWWTV0dgLGkKjBMu?=
 =?us-ascii?Q?ZRYBsr/QUCQm6HhUgt0hhGlF/hmACrGqSeXXy6VYO9zP3dugzuiVaZWOhwOw?=
 =?us-ascii?Q?YZbSpnXuuKcSfuItn5bp9Mi+/MhojutVLs2e5pZ9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62208cee-665d-48af-bb6b-08dab284099d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 10:15:39.6230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0mxq5F3MHVWmli4I/8i4HhvN7kEpBFpPYJm+E63cFxmmfE94aGdqeYeKO6EGefALrV02nGfy0p+BsItH7V7nVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8127
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,
        T_SPF_PERMERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

First two patch are fix, other patches are update

Correct s4mu interrupt name and gpio-ranges
Add nxp,no-divider property for sysctr
Add MU clock for Message Unit
Add LPSPI/TPM nodes
Add gpio alises

Haibo Chen (1):
  arm64: dts: imx93: add gpio alises

Peng Fan (6):
  arm64: dts: imx93: correct s4mu interrupt names
  arm64: dts: imx93: correct gpio-ranges
  arm64: dts: imx93: add nxp,no-divider for sysctr
  arm64: dts: imx93: add MU clock for mailbox
  arm64: dts: imx93: add extra lpspi node
  arm64: dts: imx93: add tpm nodes

 arch/arm64/boot/dts/freescale/imx93.dtsi | 122 ++++++++++++++++++++++-
 1 file changed, 117 insertions(+), 5 deletions(-)

-- 
2.37.1

