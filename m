Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD9970EF8A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 09:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239991AbjEXHga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 03:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239981AbjEXHgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 03:36:24 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2079.outbound.protection.outlook.com [40.107.105.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E57D18B;
        Wed, 24 May 2023 00:36:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nBWJeXdTNnj7Xj9BU1+139ZHkSZHpLhpWwAZW4FdKIgmgk80hPs/LNoIMuOBUHM2EmPmabpZULebWIUwzcnvWiluBt6udNuRO6ygaYpSwWuDTAyEo/IXcZjcnHJ1fuBl2oTm2zEOUqEdwe+AILmGk/3Av5DYsbZAFvkPwD1bkIbe/d4sEEysokhBTOW40BO8jhioYA7k4jOyaGpVIf6SQVIC5k5rLpf6GTuIUkng0KpKx2zgi75Vnpq2oMVDcnjgvVyHJ9tpQJDkG3Qe+/19K1Hnungp1Ozuo78rxaqmfBHN4CG3nCvv2/T3rPl2oTjCAdd1vDzM4JopGkwN7fTmbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ICMWYqxW5Z7/xfQsP1bXewCDneNCVCy++tTraZ73VvU=;
 b=Ad48MfnxTQbZTwFYPmisSpFD8fXpMxMCuHk+XdYtMwjcxbsU6UQcyVVK7TPghshPcmeNgr469REW2qdrayNZi2KLcPIZRsbq3dzzDkz4TT6thO36gkNXQAZWuH8LA+aNIrU3+C/kXAQpBLB017e75zFkjwz5k027/AloiISS9qUBK1E/iP80m1as39Hvhl+DGdLFCJjW6Nzm6rZAaMNin8vaJBHOIITTgnqV7btKAKmFQV1TbAd0zpxUTDixazXTcJLCaQrICGfWaW7w1qjSDLYArflwUI/GpyTfSqmQBv0boDb8MEMvR/8zfziV90W3J6KsdZ/IdrSuKDQwMLvLzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICMWYqxW5Z7/xfQsP1bXewCDneNCVCy++tTraZ73VvU=;
 b=ZabL9nb28LcHPbVl0NA8uZ+Hmz1l1BsFYLLasr+YeobkYmXN08m5BYeps0UA5V2vmH176Bjx1Ss6Fz0mdD6vnCzSrr5s3/vATv/Eo45VWoR7PA9w7ARb1OZT5nzvCyvsLmtbI8zz7Q5lQjBHGcJ+oc/EAY3SUDUYslenjtHwOPY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8304.eurprd04.prod.outlook.com (2603:10a6:102:1bc::10)
 by PAXPR04MB9375.eurprd04.prod.outlook.com (2603:10a6:102:2b3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Wed, 24 May
 2023 07:36:18 +0000
Received: from PAXPR04MB8304.eurprd04.prod.outlook.com
 ([fe80::513b:76ce:48c9:f9f2]) by PAXPR04MB8304.eurprd04.prod.outlook.com
 ([fe80::513b:76ce:48c9:f9f2%6]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 07:36:18 +0000
From:   Zhipeng Wang <zhipeng.wang_1@nxp.com>
To:     rafael@kernel.org, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] cpufreq: dt-platdev: Support building cpufreq platdev driver as module
Date:   Wed, 24 May 2023 15:34:17 +0000
Message-Id: <20230524153417.2738448-2-zhipeng.wang_1@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230524153417.2738448-1-zhipeng.wang_1@nxp.com>
References: <20230524153417.2738448-1-zhipeng.wang_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0001.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::13) To PAXPR04MB8304.eurprd04.prod.outlook.com
 (2603:10a6:102:1bc::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8304:EE_|PAXPR04MB9375:EE_
X-MS-Office365-Filtering-Correlation-Id: 20728707-c5d7-4a54-f6b9-08db5c299002
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pL36Sx6NAix8KW3bgHn5E73qRTzIpaD1pidaHnTAf0RhS2SZZkUeR0d2zJ4FyGhSuH+himCWeR5euDQmHlGOoiLBbmnW/GQLOcdV7FmCVMexClnFy/47FfTppzd0FOX1fF2/WSDYjy2pc/GxXksS9LURUo95v8sPkr55UbZnLLftzHB9lL0U6WjWBzWmThpaGdEY/ZTyNeI5tttK8gKpcbRDD4TljCkLvG/vqi++M4j/eXbJZEkyV5Iia2HqtqfeXsTD+y8enhAb7fV4w6WH+RzuK5pa0QGuhsK4KVpauF+L7Z+fYVxAkR7zzdzhh+PK/3CVRgJwc6h9gj2gi7ducyKjDcDqCUSJIcunYYGMLuOIo/jH6Qm7hyWCU5XYnxlmb8Y1BlUD1vrv56p0hdbTSpzAYk8TkI8usIFoFmO1A0GNMXsSvNZb9+Iz6BG3knkCuV7+TdK613aRuLV+GmrQiaGQpFjrLNNXqfCUdlxmok9Q9CGPoEx2dxKh5QdfMKxtulDM8WpArRo4LTmRwtOX/OkGuNmkEMMCCSM7pYXwHUcygC/kU40KUlqVfRqRcCzc40LxNwCm2do3jmUqk416hKB19GAP2F12se5bPJQqPrIu7AV/owRVVoy/WsByrCqZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8304.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(451199021)(26005)(6512007)(1076003)(6506007)(83380400001)(2616005)(186003)(2906002)(4744005)(36756003)(4326008)(316002)(66476007)(66556008)(66946007)(41300700001)(52116002)(38100700002)(6486002)(38350700002)(478600001)(8676002)(86362001)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IYn0huOhF1i/KRxeOd1WqE3XUm/o10HPPcddhP1lh8kimImqVwhfRoJu1IP9?=
 =?us-ascii?Q?hh2Cc1DCHvD92OqjIKpFYPSB6ejMlJLWfj0ujaQJFp8c917tN7C2sFEZ5++e?=
 =?us-ascii?Q?bbRcAVKCZMMWXFi3KBt4h/0sF1bczq6m8mvIXE7Ejv4xaeLdiJ98EVoHkz6P?=
 =?us-ascii?Q?7W21rh5VtaaZJC6uZblJj/XMW2oSVij/Lfw+nKjnYKifJwNFnByy5HeM2hc/?=
 =?us-ascii?Q?Lyg5a+jCoscOraEE5j/jOBo5D8eku8gI/GuvpTK70O6nkWQiWuYiHXpjlLde?=
 =?us-ascii?Q?q6K/7mIENnHANlKe89Le+CvIz/d4NWvJTQc2tkTmznjA5NLD/bSNvainbEur?=
 =?us-ascii?Q?xq64cvKhsIzbtwWySQ56TpAI42Kazp8vJPrGxWihKetbwoDpR4OaUcqbfewb?=
 =?us-ascii?Q?/HLM9nduy9IjlQOC9ExCk4idSBI1+tC6TB6Ft5uuOdw0OfrZNLI0Cg6hx6k+?=
 =?us-ascii?Q?VVS8s67OhbXjBwUitUCSn8YeG6zfhi51lE663kpkhyRs63AR+sfQlvMXoTyf?=
 =?us-ascii?Q?uCnGzmyi0Au5qi93LroYwn3TF/whIMuSS8u381D1A7ZmKKTmYMYt+C8tXphk?=
 =?us-ascii?Q?6UHlRMYmgK02dShWI980wuZfQaD/Lr8ysf9zK/8XQk4c0pgmpbaeFHUO358a?=
 =?us-ascii?Q?Q2Ca3Os8Wku1S40XEwbBuXpCIL9Vg+3HD0caXh39Ucmrs/Lq3bjpZmrC4X4s?=
 =?us-ascii?Q?ch4AU/R9F7GtCCy1OJLd2bRv/HTj+jITVqUMUuZGsAS//yOJU1JufcQIIGd6?=
 =?us-ascii?Q?EWL7EncMtS2h1fr6tzAW0IGTJvQmvfBoCsEdBub7CkV/cWlhKqGtYixNwtNH?=
 =?us-ascii?Q?T75WJAnIVb6D2sB90c1g6UKxh7zntzYo4R5kUVw4TZESig+/18fG+sjsWBxs?=
 =?us-ascii?Q?TKekBShJOUD3xTg+Plty1SYLshrnonkTJE6h13xyVzHM1Z2uA1Jd+4r8LDSZ?=
 =?us-ascii?Q?sM8nNZI7/PKcIm8+F87FZyR0JUbTmXkTZMeC3nSlF/UtCKfFwDFnYeLCxGBk?=
 =?us-ascii?Q?2h8M0tsFxh5pF6ta3kMb1x1WTgaQTf4KbJcKDLsWKkGMsETmru4mkZ7dHHJx?=
 =?us-ascii?Q?MOeDthke4UuKPo71IInQJLBZP789Xz606HFtoemNOczgVXM1zy3Lu+COfTJp?=
 =?us-ascii?Q?O9Gf7dav0RCvCBe1Ro7OAiSAJC7Sg0msoFWlBUXXPGgBdZfLUHq7J5Hg8zOY?=
 =?us-ascii?Q?9OPUeKQQJDg1P9E702cyElXBQjaXPJQ9ReZwIFx95r6/aqDpiL/biRKxSN4K?=
 =?us-ascii?Q?aWe0D78Swj/gjC24AJZ/Xx8VWa8789IeUTr0MC3EVl9S1wtBcf1FG+K2eBQG?=
 =?us-ascii?Q?9Bhz8EbRFFyK05sTahI6K6optzHuc/0K7AmckbgiDt+foXYftpXWUGUhG+K1?=
 =?us-ascii?Q?6l2t65Wl0qXymzlZxhJkZEGwJV7CS46ZbPIYRrZBXOJm4Mwx/6npWarvb6QR?=
 =?us-ascii?Q?cgQLPdQk1gH6EnL3/wfa4MPZ9MIaJllq9yRKL7lzWwo7HtGJxDC3mKOosBee?=
 =?us-ascii?Q?CaqrhEu9bPqhoP/PYC6fCpXPFZ/lM74QcVHDUfOX0cW56IHozneHWU+HNk49?=
 =?us-ascii?Q?/pqFJyDmfkunealzPIdHQYP37vFN+t0oyq9S/QND5SoPxYa1vYsaWpIbfbeq?=
 =?us-ascii?Q?+w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20728707-c5d7-4a54-f6b9-08db5c299002
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8304.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 07:36:18.5661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EkkgwOWPIs6hrn30CK/60l7E9aIEWsh8hpK2oWbmMOC5w60DQqb8wNpmkYh126H3/1Y5qIaAGWD88qMefh31Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9375
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the cpufreq platdev driver as tristate so that it can be built
as loadable module.

Signed-off-by: Zhipeng Wang <zhipeng.wang_1@nxp.com>
---
 drivers/cpufreq/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index 2c839bd2b051..dda3a78bfd5c 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -218,7 +218,7 @@ config CPUFREQ_DT
 	  If in doubt, say N.
 
 config CPUFREQ_DT_PLATDEV
-	bool
+	tristate "Generic DT based cpufreq platdev driver"
 	help
 	  This adds a generic DT based cpufreq platdev driver for frequency
 	  management.  This creates a 'cpufreq-dt' platform device, on the
-- 
2.25.1

