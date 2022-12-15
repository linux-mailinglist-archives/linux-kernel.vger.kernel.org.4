Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7229764DF91
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 18:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiLORUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 12:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiLORUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 12:20:41 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2138.outbound.protection.outlook.com [40.107.117.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EA0C39
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 09:20:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wg8kXmlehprpkOFfW77jYavpTRikCZSNhjk2RKJxLBBBAoylRtezO+hohcRSMFHz6C2SOs6Yj68tSntB2Yw3gLn41Z/L2ksQ40iAyWEa6yc6Af3X80YrUsVe3vxcaxQ7ynYcaVasVNkAJR2pJ9mklDtV7MVYUhkNfnsyHtfZqOSIflIU3K8nbPCbz0b7c2Rk9rMZniEuVeMNdOuASK6eWkh8c36gqcZaLhK4UBVAPEyg/wy8qARuh1E0ILtQPJ/fZHS3TMtP8uDu4EoERh2kXlO6Ty8Obr4d5lqgpbGK9Nbaikh8+hnpShKHq0E30zChrsxZ4QwFC/65v0PTFuG5yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5fMGhzqbHoph5HyTpmTChWQXjN8JRq7iE2hoYRLdbyI=;
 b=lcKl5Sc1sFUaXvIiOBXb/bpp+Kf9QGJhkHtHmBQsOHN7tyeXrb962Nou2vo3xTfFzGslqPovc74tusD9W3M0CJq3rvb692Z4nwNdVqC1D/RekYSJnXW6MoX7G2kheBcbnoF2ctL8OlcvaGMCFZ+Wa42bNwXtpEGrrivCm7i8j9Ek3fK0xK/yUOK9oR/4VHq/ib6lQuc0KnNwSt8lzAlJh29iMe8r93sNljX/zaMdAG9CQQvo7QcVQZ9Xc1bWJg1nUNEGW1DoomSlFKiVMF4BXlmntaUdJ8mIWeq/TCgYwd/CNvCbd6C8VyWRdWoaLyvZuRqqJQoR12rNqD82nWwSVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5fMGhzqbHoph5HyTpmTChWQXjN8JRq7iE2hoYRLdbyI=;
 b=ER1aowdxrvpdfJ66zkEQOzxsC+Nz0nnKDHD4O8tRa3Lrx/WOj4W8jCwLy/iOCPcjaXinVG73k6CWY1GdxeQooBBOK5okvDUrGyXpxCtaL3OKo6tp99kSDkBMRpf7LiKrmWxgSHVJmUMsTCwJsqHgsRjh4KC/YyPE/egJvYc42Cj39CGNWBXzGUnUW/z7/BMszglAJQviHcOwyY6gyqw86M47YZho++G0ODCGPV+8j2n2c/U2gZ++xHc/xbh0BtHBnS58pOEOoIJ5AphetjBArPDSsjsiZEzbPpZ8dEMB0JMwIEjtvRsibc7VYQc6dk3VKZBuT4pA1Noy68Sbs+eRLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5720.apcprd06.prod.outlook.com (2603:1096:101:b8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Thu, 15 Dec
 2022 17:20:35 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::ef03:cbfb:f8ef:d88b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::ef03:cbfb:f8ef:d88b%9]) with mapi id 15.20.5924.011; Thu, 15 Dec 2022
 17:20:35 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH] MAINTAINERS: Add f2fs's patchwork and add Yangtao as a reviewer of f2fs
Date:   Fri, 16 Dec 2022 01:20:20 +0800
Message-Id: <20221215172020.8115-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:196::14) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB5720:EE_
X-MS-Office365-Filtering-Correlation-Id: e7188173-10c5-4d98-d9f4-08dadec0ad82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: soGAme2tqoRRltfWd1/a3NCMvhlrlFPE15CrE3DHctZTOQNhfH453gCyv2vozRdJysOpNPkU266tW4gxiH0dGckMy6jhjFc3rH+lzmfqXcRa04/zyhXYtLa4M/5DQ1Pb9kKjT4tAmWz2JBtVQ6q0JKhNuVADKzEJbPBcS4tjQANzSbndjQehnyjxb48kot2JUXAX6VWDfp5Bc43ZBStYp6t0XXKhbgEouY53xQkcB1zWjc5L9fSt6TEtQ655MUOCbPUdnRvpwbuMx4QN8tsDEPu9D7Ej7ZqVmzWVFX0BM/d9N8yAMitWNPcT+8TVHxrp+TVRceucf2dUI7LGJb9TIu9cjIZGrAIf5DKtwCNobf8RpMyj7hN5nBw4sI7NWgBoSPfBML+JjGQl/sY/69qRHQdqwYT/PKPtwUqU16PirxYvgGlOWVXInShjAIBsqrmuV0sJxYO/6f4mV3JRvE22g4EpLdp2yPGdkEe1cZWfk+6Cjyxo1uEcL4LdoJ4oLSuGb0lrlAS9qmb+vlyBFcWiG5QF8ootwdA4WK6LM6sbHDMc46tV/5L/nvAw1x9fT9D3sqmuSj61lJj5N29pFBI5nNdAPUROc1A+oXjOZrxXqvQUzb2o+xKbPnaXCyL5ZFPHYUMIZ+7x6rKPLC2xSCBOc2zfNYCHhCw7SkVTpknR28nrmWoowiTGs+1VcOCSgjHy7yBJxwp+gQdIOS2TPxWDYqnDwmNE7U7Y/3he4Ni87z4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(451199015)(86362001)(41300700001)(966005)(26005)(6512007)(66946007)(66556008)(8676002)(186003)(66476007)(1076003)(4326008)(2616005)(6486002)(478600001)(52116002)(6506007)(316002)(107886003)(6666004)(38100700002)(38350700002)(8936002)(83380400001)(5660300002)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BxnDXTFg2l5UKt07p9rctlL6xGMbKIMU3FVWoanaFQW46WH0GQWTRAtWKu/+?=
 =?us-ascii?Q?/V6wSbdYpzmv46SjQGkmSKiBoKu/vAmqlHmqHUbatTdRpkXlT/XfSidU3rXM?=
 =?us-ascii?Q?4oqkgbyfnMr/it2C3sjbMJO7jQNSa8/gNGIh3mJsu0ZB3CiDEPSsbmzFwBd7?=
 =?us-ascii?Q?M0AZ/RqwQBG1IS9AqM3ZsvYUbygcyDprm6tDIOF7DMIQHayu5bljstqXKL5b?=
 =?us-ascii?Q?0WCv87wAS89U6lM9dBz37zadPk/hTXWl/ge7rvcxMGn892sM0TCP2CPykfbI?=
 =?us-ascii?Q?AgWeTNBOhV4/oaIZo0VavpVTq8P3opZ5Wd5tW/pdkT1utkChyQgPy5mMxaAl?=
 =?us-ascii?Q?ULlwagiVVjmP601Fdl8ufuhvDfd+twv2nRLqsVS3wzeYh5KlRtOY/pbB06eC?=
 =?us-ascii?Q?vhYJRHiayKKhNhjFzrMRloLL7uMDkcicrJQOcF6ICZvoQG3weM657nSo0e9s?=
 =?us-ascii?Q?V0SvpETCu2OIe0U3WQIJ76OairrzvK1eF8FAp0IcAuvk0xAFumTjfNk7h3wa?=
 =?us-ascii?Q?t8QnttRGjOfh7pw6FzrpmyK90ElUWRsi5j68gkxrB4w1wSwPewL+cAF+4ony?=
 =?us-ascii?Q?x1olbLIpw6XpXhe4T1bjlPozl12z1wYo8XZpgh0te6IfE+Xv64sIzbBMRU/q?=
 =?us-ascii?Q?7P9tQRtXI6zc/Ep5MSGqvRka7bMEO9jaCQ35/TAi2eDwg8r3eXCBCbsNcNca?=
 =?us-ascii?Q?9OEVR/Gnn+1nClULaaTMLWSaHiSicrrgyKCfD1mrCt0rWJmyAdBWglZTWHdG?=
 =?us-ascii?Q?5alvOAEuNf/ibpwnU2R3aK2EP10F19zaTu30mWLqBAcDB6KR0gj1jB5GHCVO?=
 =?us-ascii?Q?lK4oZEY7T+o/fMftkhuLeaPbWygILxoAMfxWButL/iggiBoRdGm5lkjbkoha?=
 =?us-ascii?Q?jymJXe+H4DnsYSiobLwNxmTtbN5CZmPMbyeNUsg1LrwcoDolLcj6XR4RU016?=
 =?us-ascii?Q?6sRw72u+MP7VaWWddwRqhERGyxMsNHy5VuuxQbm836ZatiWj0l+JJvUQ9yS2?=
 =?us-ascii?Q?yPrsbQnMKLJr1SBW7YaqVWP8zi5sJLNt5RN1zakhrc+3+Rq3lkZIHwB0xXW4?=
 =?us-ascii?Q?515uSVrBm4rqqdbacYisubDC/WnNaKuSakeXUO05/xqBckW4gCsfKrqzIwTs?=
 =?us-ascii?Q?mQxIompZjnm0PIsWiP8J9V67T6Fn6UGwMrrPKWTn9Qed5jeZtiRPYzAJzFLS?=
 =?us-ascii?Q?pGXRR75hfwrOiom9uNtvyFHMGFH9fukhnGSszl2nnIwJkk7pPnFFaqB2K7P2?=
 =?us-ascii?Q?LGMGRYzvQzk7pNWUrOQWCHsID8Mp4lZAhm62avc7zAWU8NisGIEYipaWrZTa?=
 =?us-ascii?Q?yfW88UvNDRYdVSIMcajuNQusrxugBp2P8/UF90mjYZnjYjuEyxcD6Lrw9aSR?=
 =?us-ascii?Q?wZsL1z9liQa/6kRVpHZ+oDD2Fyl7wHEgYFt1kAyK6cnlcfEyzuShSYikJpq+?=
 =?us-ascii?Q?QWVscZUHJHJMIj6ob80V4O/KeDiReUXUgIlqCjNe6L5HJhPYsHeq7aHAGOFw?=
 =?us-ascii?Q?Nsfk/D/hAszk8xrLAWUj2IgsFmd2NXetC9ohlSG5lk2/enaCoT4kLPv+wzyd?=
 =?us-ascii?Q?W3FDfj6zYXwPFD/x6wKQZDvAYXxiW3zU5xds2hiw?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7188173-10c5-4d98-d9f4-08dadec0ad82
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 17:20:35.4498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Bq3pQ+yDxiOWNKfV7gO/dKaYYXtJOOLUAJF2NuqyIZOum6C1crwrmr9HGY+kvZBRDVK/XDn8Xeb8zR4ydLujA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5720
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From now on, f2fs also has its own patchwork link, thanks to Jaegeuk
for starting this tool. Let's update it to f2fs entry.

I've been focusing on android storage (especially f2fs) for the past
two years. And I volunteered to be a f2fs reviewer, add my email address
in maintainship entry of f2fs.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a608f19da3a9..655a8b68b332 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7886,9 +7886,11 @@ F:	drivers/iommu/exynos-iommu.c
 F2FS FILE SYSTEM
 M:	Jaegeuk Kim <jaegeuk@kernel.org>
 M:	Chao Yu <chao@kernel.org>
+R:	Yangtao Li <frank.li@vivo.com>
 L:	linux-f2fs-devel@lists.sourceforge.net
 S:	Maintained
 W:	https://f2fs.wiki.kernel.org/
+Q:	https://patchwork.kernel.org/project/f2fs/list/
 B:	https://bugzilla.kernel.org/enter_bug.cgi?product=File%20System&component=f2fs
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git
 F:	Documentation/ABI/testing/sysfs-fs-f2fs
-- 
2.25.1

