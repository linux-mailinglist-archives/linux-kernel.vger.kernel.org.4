Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26D373F36A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 06:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjF0EcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 00:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjF0EcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 00:32:08 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2136.outbound.protection.outlook.com [40.107.215.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B601722;
        Mon, 26 Jun 2023 21:32:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ToElSDEa79UP4dqPih7Zon4CYoJlbsuarI8e56gOihp0Gq1blApnBwFpp4pAXEotSIjwWT4Ap1AxwpUsFA+woWJ8XtEhf35EKHfVxtAZ6tdD7lV59MOoN7oaU7jzucZaKT7sdxTGO5GgEzdjDpjJevJ79Ypryb02iT5ZNwin71JdHzpTSRt5NpjfiMnd0sSjack0ll8L34vEyveMlT6ksa8ctwVrj4PoHMbjcPVt155Wdy5oI+qoMAXQ6ecDdn80S1HPOEVzIqyEfYPWUPh/c9uyyVl+Ec6Z56l48oTi02JyL95irDMeKZEomzfJBUns/w0TSVUTovYhw/sBzHVV6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=betZCjBxzsWL0zBA0FvXhU3lDxARtS9ipzzCrPZXR9k=;
 b=lbtJtnkox1ElgWbbxTvMmV7Wc5zjYkp/cIm81C4w01uxvs3S26O9IVZ/2mdZsXzFukxks2lDq1D2p9TufxiJqlRrBpHhhFNBl+m3C2CFCTAZJmmllumLlPGj21ZiDXAL3sfybYrBNdB5dpAUNWyy3qCV8L7ksRmrn3p0tZHsz+mGyTm17Xg78SbwLswbjjC1Frd7qnJXnemsQk4Kkr/zf3U3sCLySk5A7yKYBBTRbQvfamON7Hi7gwDzTgoG/iHUpUxRhAjxIaoHrkDgmKwSPw1Nl6Dfc6M4XQqt/jL2uB61pzhXK8GOa/PhgfKEkAs8EMkBGnkN66KI5b/X0V+Vdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=betZCjBxzsWL0zBA0FvXhU3lDxARtS9ipzzCrPZXR9k=;
 b=Cg40035wG7FvcWkTaTRgMr9xR5QGLknK0v3nVdDynOKsEEH9Gl4c/Vz8a08Bd7FOvy8Uaq+/TI/CO2BHptgNOGZA3QtsFH7UoyVZSPEETqDUnDjdWYGRQm+9v1o4BdX6vJR8DhR+KAbSP3rDMU71++RLCP9ealGo4UdTRS6zPuimQicmAdo8/y7R3x3cEcizczz8RoJhKRDIi66DQMIeuLoke5sAl+Xte/Dg7qPln+W550FY5StfC6qRbMpKXqgpzj1KznXNFRZiViV5wreqBStXxnl3hwMlAWUuz1BPLbSrIULaSOB7gj7AGWYooMe3GvNxEZwu8QGrTvjOoTsv6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5936.apcprd06.prod.outlook.com (2603:1096:301:11d::13)
 by SEYPR06MB6397.apcprd06.prod.outlook.com (2603:1096:101:143::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 04:31:58 +0000
Received: from PUZPR06MB5936.apcprd06.prod.outlook.com
 ([fe80::adc0:c22:ffae:227b]) by PUZPR06MB5936.apcprd06.prod.outlook.com
 ([fe80::adc0:c22:ffae:227b%6]) with mapi id 15.20.6500.045; Tue, 27 Jun 2023
 04:31:58 +0000
From:   You Kangren <youkangren@vivo.com>
To:     Kalle Valo <kvalo@kernel.org>, Dongliang Mu <dzm91@hust.edu.cn>,
        You Kangren <youkangren@vivo.com>,
        Simon Horman <simon.horman@corigine.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-wireless@vger.kernel.org (open list:RAYLINK/WEBGEAR 802.11
        WIRELESS LAN DRIVER), linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com
Subject: [PATCH v3] wifi: ray_cs: Replace the ternary conditional operator with min()
Date:   Tue, 27 Jun 2023 12:31:48 +0800
Message-Id: <20230627043151.19576-1-youkangren@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:404:15::27) To PUZPR06MB5936.apcprd06.prod.outlook.com
 (2603:1096:301:11d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5936:EE_|SEYPR06MB6397:EE_
X-MS-Office365-Filtering-Correlation-Id: c570b84d-ba9c-472e-140d-08db76c7719a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QT2CCVUeHFOh8XVrS+aabQxxciC9PEZBvdTsyLe/5BGi3AU2i2NMgLaERKrhuwf4lGkFz90vpij9hVTR6mySq6SgBpM3ZZ60OkAGCSQ2yX8Cm9gwrwSkiAxrRPq5EYtPCtff7lmH+q3AnGdDdPwFyHEPYKrAnzKG05x4+PQRN0xwSTpY+TzS6j5HMAnMVBcnOhX1wnHolsFibzHypd/6g6556pgfsOAZOe6VpCh0npafzb6DEu44/PFIgyVP47kQAIwCBRILpFXoS7RGjkNUY/a/D8YU74meyfutOYVV7SdzWZVTrDyp9+Fr7zjH3Bv1rt8MHLErXSUaKW4PFlRKR0hqUyxdk5wCcXP21o5hOo+3lgYyd0b3VLptPNe+d7gjGKie87JBUjkDk3uDAVVAaeFsVfiV8+vpZv1cT5vxsYKnN66QNrm2bKkZtoGJPLNq9TcrtIVUrVafAuWnZAKBmjfbIWGuI9rIC8CAUYav6Q8REJKhFREI5dAKf4tku/oECHbgP6AH83Mf+FQ50GbvwAwu+oL2uDlfnwJDjj3zjoplWTdbMQ251+rZXqin+TMBfGTzoNv9cpp0RSasNpNAJhA6r24DcKA9b3SFhha3CLJCmVW8Y+s5BJsOlQRdviCJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5936.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(366004)(346002)(39860400002)(376002)(451199021)(26005)(36756003)(5660300002)(4326008)(66946007)(41300700001)(8936002)(66556008)(66476007)(86362001)(38350700002)(38100700002)(316002)(8676002)(107886003)(6486002)(2906002)(4744005)(6506007)(1076003)(6512007)(186003)(6666004)(52116002)(478600001)(83380400001)(2616005)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rLwZAnsI6x91lieS3exwsUFy3bfk3VBVaLGkArWnRNEEjhv1wAY1PDr2FKmB?=
 =?us-ascii?Q?l6POkNWsdI1OM30e40GiEG/Q241MEgtD6+0NHh9na32eI2sncSVKeWxYf3sA?=
 =?us-ascii?Q?JFvxTmTlCzlTujLpWg2xJBQ+onuACpVvRUPnKrNbIjt9gh7/IhW/MoQgLRbP?=
 =?us-ascii?Q?F4IixOAV4of9WL2YTeEifI4PlnarCR0IDfCL9B04OOHPDJ0s58Fvcm4Feawm?=
 =?us-ascii?Q?Pp9Ha5n7isLmTXTJ44eDfJHaYF77Wn1l41AvCAqwfQBMwpNyAnX2cM/G119V?=
 =?us-ascii?Q?N7n+AchPUS3oBZhvTZLG0v8Ew22AvgG/aHr6ynWO7lILjOFuMFxFKfAUBvrr?=
 =?us-ascii?Q?vqspwF2LdsRi+EeocWyjKTLrJRIG+wfI4wbYXR3LE489kXFWptA0bjsdjZ5u?=
 =?us-ascii?Q?CPRGZBw5eJ5Hwz9JqyKvU5fvyeuFXXGY1SQyDrO0/ZNENu/n56DcK8s7k0Pp?=
 =?us-ascii?Q?tyMArNn+k0eGm/mUTpnI5ssZFT7taT+E1amfpSIr1UFUICBs2NyBjqD0CE4o?=
 =?us-ascii?Q?KtPrKIH6A+dE9kkNoD1jLv+YnzHwnyojOSwYhXzNXowltEPOMU0N+hGHbdQ7?=
 =?us-ascii?Q?ksA4Q//zQlC9K2CuBGv+jxOJqCdTWQP26QLoYal3eAZflH1KI+CeVhNRRI0Y?=
 =?us-ascii?Q?oFw70VeJx2JIQt1PiLmrnX+zXTHk89OYlu6TSC9Cn8GM4hVULEauEGuw5yw2?=
 =?us-ascii?Q?RqxZWWnrlIBJDhd7my+2w6Km1sedxYg+vStCzyet3aDzxKCZv0aSCfnOo3D7?=
 =?us-ascii?Q?hueqJpO74xOi3gyhfhBokLoeqjQm4rFTUuXMK5qdLsiR+qgnBS9AmOCvjvOY?=
 =?us-ascii?Q?UZeHlHgrEbxjFOhbVb4iVL6fs8Jvlxi6QQ7CHyIbdxA9WG+vffPjt6T9tjla?=
 =?us-ascii?Q?T0hyWT4AXZM89ET1vV9szOK30iYqWX2fM/hY2SHAtTWeIjgr9CzGI5M+rUbB?=
 =?us-ascii?Q?eH0C6xXeFFCGfj+VZmQEcGSlx44KuaOSqPJkKNCgqGCBQLFj6tv9y9XtiLYl?=
 =?us-ascii?Q?C9z6DadaU9G2OzEy/H0lyfIZEvr2mnFQ05E6pdoCBU/knzS9ZUQKXds4QOKl?=
 =?us-ascii?Q?rmBKaRnR+6zDRZeiiDhZJNSdpoEBvQPw/ZTQx8Bjw1codobcrhzVl1kPVV5R?=
 =?us-ascii?Q?a40CZhhJmK2LHqSBVxsEOg7yojqG6+ed0UncclRZnEZoke+KeVv3JEKsi29v?=
 =?us-ascii?Q?5Ek8QurrsuJnTUd6dyudN9KaMBuxzhC6/s61ZjQBG0nwaEeqBp43LxIb6Mxx?=
 =?us-ascii?Q?03LwKCHhDO+JOlkVJ4YCs40Fx1BOSdhmL0b5YmjmfuCVheLGC7zRokOT1sDs?=
 =?us-ascii?Q?YwhNKzxOIreTU/9Zd8FLypz20V4xLVc6ekPlqQxWE47t7AerxLD2SriZ4k38?=
 =?us-ascii?Q?CtMHCHyBeUKqHGe4fICQ61TVaVkKTFmYh7TjAIJoJy4vFrDCGBY/US+Q8XUt?=
 =?us-ascii?Q?ZQOW0drS1hAEJyDXj8Yqvl0qSX0IX8EjadhoczdN3H77NNUhX/BDN/S1iHwc?=
 =?us-ascii?Q?+PS+q7Di2MaLIYILnBeHqyNsK6yxQqlzNP1qbGGmap4rJcanJfrDN7w6K6Db?=
 =?us-ascii?Q?QPllWOgF2PEA3+5D4TyacfYpnosZnXaaBB3/j9by?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c570b84d-ba9c-472e-140d-08db76c7719a
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5936.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 04:31:58.1950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WjUSo/xjEaDBanG1h8+OdZbYaZKuosR4Cqc6atietp3Ra4YIkAAwE+PVSIud4wTPy57olzwbgEqcFuMrM7Y9fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6397
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the ternary conditional operator with min_t() to simplify the code

Signed-off-by: You Kangren <youkangren@vivo.com>
---
 drivers/net/wireless/legacy/ray_cs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/legacy/ray_cs.c b/drivers/net/wireless/legacy/ray_cs.c
index 8ace797ce951..25edbc655738 100644
--- a/drivers/net/wireless/legacy/ray_cs.c
+++ b/drivers/net/wireless/legacy/ray_cs.c
@@ -2086,8 +2086,7 @@ static void ray_rx(struct net_device *dev, ray_dev_t *local,
 			rx_data(dev, prcs, pkt_addr, rx_len);
 
 		copy_from_rx_buff(local, (UCHAR *) &local->last_bcn, pkt_addr,
-				  rx_len < sizeof(struct beacon_rx) ?
-				  rx_len : sizeof(struct beacon_rx));
+				  min_t(size_t, rx_len, sizeof(struct beacon_rx));
 
 		local->beacon_rxed = 1;
 		/* Get the statistics so the card counters never overflow */
-- 
2.39.0

