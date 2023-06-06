Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14DE723854
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 09:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235689AbjFFHCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 03:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232832AbjFFHCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 03:02:17 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2097.outbound.protection.outlook.com [40.107.215.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEA8E48;
        Tue,  6 Jun 2023 00:02:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nxozMmrZrkM/m8MmqffZqWQtrRKAUePpU8gqlR9mS7nkZFMGw9ovLAa2EMu+6LEnxSL2j06HvDwfc9LyP+XV7XCVHUbNSj2T4+lH7ADAM8PJH9CJuaRM8h/AtrsGXPy92rnWeq7gRx5lS8ESZHkmRp603mEw85rBg96S1VUuM6XM2eclPBJgW3sjl8Jw9kPebFzqno7PQs7CErdr0vMnpZa69h4npM0JhPwHGprwYTwy1b9G1NF8k0NJjjRn6gqH+XEKyOGNGnzzBdJqPqLcPEl8lMamSsXu20UoCuNxaBR0063tRyjvxGmjC/klebQAbDx+6xOJe1rouf+WVt9Jhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mAyxCOQIjRBwWK4kiwwUZuCsHpkyTF2FZI+1hw3Gk/Q=;
 b=kTFmjJSoSW5V5pcw0JgMDWMg0SaPlTXjiVIHDQi5lJyqRvMXK0V2Wpoe6FGHHXZ1VV4XpbDLZYd9m9112wPyFAarJj9OnqFL9zcOE8G8dfBWW7B8Mhq8CeFwE7EybAjUgmJdzk0CEfrDDh/0cdgmVEGeNaK5/KGxCIe+34F2EKHSINoXNCl6ztJm6PD3zx4e2NmMyvpmvQ9bjnGFx9H0a7vQS0avqzSeAGaJQL05yDTOgpQxGh97+hnsJOb0NT9SBLPPdkB0M14R+E4art7SaNDubdrTXYOM42iUKYmqb8CFKbSkwj8ANVuTpxOtX3XbOMjOGBxU5wuangUWQZxJ6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAyxCOQIjRBwWK4kiwwUZuCsHpkyTF2FZI+1hw3Gk/Q=;
 b=KBG4oQZEmzg+bgB2s/leT3YGl7SWvKL5k7I6gX6/zxEIzYoT07RwMXVeQQ6F83ViVuG7nsm8x/+mBnUniE6GkTTgk/rYQPIXeo0kwiSzZWwBfBGBODGPC98LQHwV3LBVrV8HGqfxWGVucZO493ozuWaQx1eKun2YpHKDsdDGNt3MGOQ6/q4/Ji5r4DbEV6mM9UaEYGYgg36UruumgmccGy3esfZb0NdqNHcosBmvgmZu0a8GThVnGo+2ZMmJWW6KtRYu4fh2TrvwDN5QKwOp0751GwftMUNys1u8yb34v0XfuSQdC4b1/FTyuLMSUZN8SVwiPIlwiTZN46+dsUtc6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
 by TYUPR06MB6151.apcprd06.prod.outlook.com (2603:1096:400:350::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Tue, 6 Jun
 2023 07:02:12 +0000
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e]) by TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e%5]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 07:02:12 +0000
From:   Lu Hongfei <luhongfei@vivo.com>
To:     Chester Lin <clin@suse.com>, NXP S32 Linux Team <s32@nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org (open list:PIN CONTROLLER - NXP S32),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, luhongfei@vivo.com
Subject: [PATCH] pinctrl: nxp: Fix resource leaks in for_each_child_of_node() loops
Date:   Tue,  6 Jun 2023 15:02:01 +0800
Message-Id: <20230606070201.14249-1-luhongfei@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0129.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::16) To TYZPR06MB6697.apcprd06.prod.outlook.com
 (2603:1096:400:451::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6697:EE_|TYUPR06MB6151:EE_
X-MS-Office365-Filtering-Correlation-Id: 601a781a-9099-4fd6-800a-08db665bf39b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F1C2zKZvZ9m4pp2aTfCSsaOBS+pdjB+7C5YiMZwyUlmzivhDpSy2bqbprpluVRPlWs0PTDdV8SKdhJyH7DyFlNkwk/BxS1yHDFoH+fux5tJFsGsL2Obh8+r9qGm99sJkCfdtWBXExiXe5k/4Ikz6hZk8YV1DqO/XlfdFNYpdVhCKZY2GjgFDxHtLUC1Y42tKIXkVI5SQH+w6eht0+QirQCVBcbkYW+2Z+EvXjKppqQigbbGnVNtqTS/apiBVGRuSET7g7PmIorTPGiqr8O0pYmJUI5+jUXiAQT9i9A2yLpPSRo5AecYLpp8yhHfut0RfnU6EmO2WTeyPWGvfo62N7IY4nKeM/yLgrtZ3QcrKwUXlNvN8UiL0i81UCUJhc+jtrXD5JSxYxTlllVo+ASz8C8rUhIe37y4tTHkeyFpUIWDK1v+ToKtXBEkvRxdaCHGFOyDLz5uLeoz9FmwuqMl5OMRYBVOjM67CRq1Vy9XrVv9zZ8X76r4FU/ViBLMONX6aSh6UzvaLA4KYcuyGh3FS471Pai0omcaCvlk2kP8hM5uv5p5dKfduRlkCX4Aq7HUkSbvOoTHlUeC+4J3fMNTrzlEuyZGOOW+kdg5wlotP1zn5Qm74+0xAyYzZWvNDBSgy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(366004)(346002)(396003)(451199021)(8676002)(478600001)(66556008)(110136005)(5660300002)(8936002)(86362001)(2906002)(66476007)(36756003)(316002)(4326008)(66946007)(38100700002)(38350700002)(186003)(41300700001)(2616005)(52116002)(107886003)(6486002)(6506007)(26005)(6512007)(1076003)(6666004)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uT4cn0Whw0mhQ7mBS2QRsJOHh8lDJFuMbU5NuG+sWigxG13jsfvTTrXXIm9c?=
 =?us-ascii?Q?Zsfh5bH2WKLYnTScundb+lNSoCMtDpuZVPOK8t4oJ99RRUpwaX6f4mD+q2uJ?=
 =?us-ascii?Q?iiXdzSu6veDg5IVb4FuAZeNb3ts/y2EGzdvaDm02iOklAGBqrTJ0eNg2x2zt?=
 =?us-ascii?Q?TVb/JBMM5WFltnQIE3iKAaBjlHKdpIVAGaMEcidyLv2lDIaXgJJfVEewCC/9?=
 =?us-ascii?Q?ooqgCawFSVZpVfyAKTrblNmQPPQ5YHHI5E8gNwWel+uhtYmaZQaJ4M6Lig/p?=
 =?us-ascii?Q?Wu6ueVfXYH4+rqqLyyCWNiIjh59Vwml/TsRX82oBdStYK/66GR6ow/H+cfqh?=
 =?us-ascii?Q?KTR6Zp+McScj4ylqoR1PkmKVhVxpudODRN3hwhS+UrmLVC/p4DUa7xkdklHp?=
 =?us-ascii?Q?jbUXFvMRZNEuDrFG3Mi45/36dRSjznHo9YclmDNUVbP8SsmQak8HsijnOFVu?=
 =?us-ascii?Q?r6I0o0Tvmf3AtEI7mLj9oj7215ztWAVpUrXoNnfhKaadfAVtnKQc2aVjPDHh?=
 =?us-ascii?Q?aQtCHblHKYUDu98dofiK7MEoNkTOVCb/YgutKmgMqqrmP9HNIzKVPHrS4xSv?=
 =?us-ascii?Q?dCvETMjr9rHvd8S4FIxThDkF4+J8/5vAHnQeca+/73fMzEJ9xLXedMd5H0NM?=
 =?us-ascii?Q?qx792nR3OrKYvID2yZBwnKxJ9kVf57yPlQKk0PS4CpyoVvC4SXvYxZXrAKsY?=
 =?us-ascii?Q?6NCgSBUTkJbfleFaxf656k4xZeMl5qGI7BkOx16pAgyuPHe4DCwpaPrLF3Gb?=
 =?us-ascii?Q?TIp7X8Rs4EM+s7qIClx6RcMMIvj9dcvZtt8IbS9uoKjcofOUUhrtQQLLvIuK?=
 =?us-ascii?Q?p78F/ozuv8BOEjbCxoDuSXcHcZhvX4MW8+C9HbRkb/HgRPlKebGxHvQQ5u6J?=
 =?us-ascii?Q?W//5cU2S8qkPIFe7zd2ZeghyFEwkbj1AdiGOFOHuj9HSYo/NjscKjwQldnHf?=
 =?us-ascii?Q?vQmzYSEuxutBEtv81TpPB/HdnKWrcT2WzGaXlyX6A58S+2u5vL1vzPJfKudS?=
 =?us-ascii?Q?1UPw9BO3lG1wQubMpO7WtNpoddajqwtPCYqvi67x4/qAcG38GWtchbrKdmD5?=
 =?us-ascii?Q?4iYJVoOuhUmxSxXAYIWXlB4Q2YI+xmYjCDqVLZie4e27t9wzKvtRGfwxcWPE?=
 =?us-ascii?Q?l3TFTPkYu4MsCSwiP4ACn1zp9v329AT+zPETTBCg2dV3NHiE+pbbpTb/c30U?=
 =?us-ascii?Q?y1gTrcX5+Ts5NXpFpXdyPICJffuIpNC7vPzSyTZCEvodmaaLrRKru6NdGi9/?=
 =?us-ascii?Q?ivin7m3xohWtY9z9Dtixj+sDbO98oHzcTh4W25jzaMMuAgcRTaEw9Cv/YNLJ?=
 =?us-ascii?Q?cm5xz/FsgsNqDjK0ylWmvzzY37heVNHe4FbIghKBVm3sIbzTB8kCu/XFVgA8?=
 =?us-ascii?Q?xIBp7bO/Q/hdcskIdBTojrOr6UYSZ1gzDbToVwrtT9HmCzrRqlVFfUWV75lP?=
 =?us-ascii?Q?QEEmAK8vx+sI7CqMJce8XmaV7m8VZRpU4fb9jU2UnloNFc3pbcneY0kHkLHU?=
 =?us-ascii?Q?lKHDCta9d6kU6fZzMZ+OAhE8R3f+lvNxGUOIpHjvHauGZCmW4qHcZyqMlHwt?=
 =?us-ascii?Q?lZhs7HBXxfoXm18NL2YPcgE6F61GeIzH+MWMINSo?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 601a781a-9099-4fd6-800a-08db665bf39b
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 07:02:12.0335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /w/Kt3JzaiMeD/G7rgNAgPpWmACdLmB3/cPAbwtVp/f9gEjgsUpLmXrHUauyQkeXmxtr/0Y/zO2XPH5VzU3vUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6151
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure child node references are decremented properly in the error path.

Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
---
 drivers/pinctrl/nxp/pinctrl-s32cc.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/nxp/pinctrl-s32cc.c b/drivers/pinctrl/nxp/pinctrl-s32cc.c
index 41e024160f36..3ae043b27463
--- a/drivers/pinctrl/nxp/pinctrl-s32cc.c
+++ b/drivers/pinctrl/nxp/pinctrl-s32cc.c
@@ -279,8 +279,10 @@ static int s32_dt_node_to_map(struct pinctrl_dev *pctldev,
 		ret = s32_dt_group_node_to_map(pctldev, np, map,
 					       &reserved_maps, num_maps,
 					       np_config->name);
-		if (ret < 0)
+		if (ret < 0) {
+			of_node_put(np);
 			break;
+		}
 	}
 
 	if (ret)
@@ -812,8 +814,10 @@ static int s32_pinctrl_parse_functions(struct device_node *np,
 		groups[i] = child->name;
 		grp = &info->groups[info->grp_index++];
 		ret = s32_pinctrl_parse_groups(child, grp, info);
-		if (ret)
+		if (ret) {
+			of_node_put(child);
 			return ret;
+		}
 		i++;
 	}
 
@@ -896,8 +900,10 @@ static int s32_pinctrl_probe_dt(struct platform_device *pdev,
 	i = 0;
 	for_each_child_of_node(np, child) {
 		ret = s32_pinctrl_parse_functions(child, info, i++);
-		if (ret)
+		if (ret) {
+			of_node_put(child);
 			return ret;
+		}
 	}
 
 	return 0;
-- 
2.39.0

