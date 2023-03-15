Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255906BAAA9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 09:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbjCOIVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 04:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjCOIVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 04:21:49 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2083.outbound.protection.outlook.com [40.107.105.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1975B763FA;
        Wed, 15 Mar 2023 01:21:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eUz/bNfm6/RrtnxtoSOuvxP1hE01WL4C7lYyEzpZv35iHM4KAiJj9lm4BEQAj7XnE3sSL4rzddVbCa4KfXY2tGtqgwh6rkOXFSUdNHuKxr/x1K5I66LSt/BjdpHbe/LRdkNMq4VTVrvgx83duqCoSPgU3kK9N8og9h/xnLrPz07SlWbjftFZhPOsnEFPNNts1+bs+AbLt5gEJvPcWdGkXzbYp9eoDV84ldKPBtosMvbOM2jGD74YuzukpcPx18aHZ/s14Zt2ziwAAD/omCiX7zLC3JGPfSgguCKPpTIz4oCyy+r7wTH2AwA/g07EzbrS8jEB7/DxrzMdhkbg6K1aMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NfEgxZJzoxDNRDkf7iH0VkOgONaMgSAihvJo04V2424=;
 b=cI4wBSa8BbwP36FPImPom9ZXBN9EFHtX1Cq/SNYaZYtVNX164ra1zxYbLlJ9YNLrYsVEQ/jrpWdMG+v3967gUiqlTEBgU5VT4I1gStHzTgf2NX5qmOO1MXJdEtk5jYGbbEySkpvxIW+M1lviHFy0UVmNsQw5g+7baqmxRctF14Y7rm8FN4D/fv89tpSgv6csi9Eio6i4XeuPiOivY017oo2GuAwLrz3c5rvzqYJubtbZnyuHGL3BDBmqu8m3ySgKtiyPnXXJKp205ssgCnm28invHMFcIj78hpzICo5OzIfcyHu1nnMRT+BelNaSdISKKw8jqW1n1Eh1OOElD8Bu/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfEgxZJzoxDNRDkf7iH0VkOgONaMgSAihvJo04V2424=;
 b=lNWb6FeIY8P3PT2MMINOkkQGLyxKm5qUoX21ktrcoaRxs9xI+X5stnecLzajtTUF8BHzFKH8JjJGs26gEXgM8NDr6hViu8rW9gWdBmBLAhQUGH3xfR16Fxq0uuUniwmw2PAzykTBjJ5I9nS2DkA7vsq2kHJXTBgP4/5Jn7lqeN0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by AS8PR08MB8779.eurprd08.prod.outlook.com (2603:10a6:20b:5be::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Wed, 15 Mar
 2023 08:21:09 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c445:c8e:be5d:d40e]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c445:c8e:be5d:d40e%7]) with mapi id 15.20.6178.026; Wed, 15 Mar 2023
 08:21:09 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
To:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Javier Carrasco <javier.carrasco@wolfvision.net>
Subject: [PATCH 0/2] rtc: pcf8523: standardize code
Date:   Wed, 15 Mar 2023 09:20:19 +0100
Message-Id: <20230315082021.2104452-1-javier.carrasco@wolfvision.net>
X-Mailer: git-send-email 2.37.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0132.eurprd07.prod.outlook.com
 (2603:10a6:802:16::19) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|AS8PR08MB8779:EE_
X-MS-Office365-Filtering-Correlation-Id: 4effa56e-c42a-42e9-d9f6-08db252e3b42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HITVAZCLnXlCtGNutRTOxWpj9ntb6gLFsU29ZYNKV3qf+qLG9+WE2NKcIqFmvEJgovxfuIGw+HcA+jv6E7jz/qPqkZZZkBiAZlBfD1aJPnetAQLKDWkQFVZOqt9whJm60ELjmN66+hw7HC1YGAioyasRplv4yNu4wCmPAC8WEnb7Rz/NBF+T7/tyuSHSc/o9l3faZqkQoKBXB/AUjmnHeh/cYtfQ3kaWApNPN8Ikn0c7lZ67J9dkd+UCjKc4HPyqGxgdP66NyzfqOR/S61d4oZgr7f9fjI+PiOWJOMTJPPQHwROeg0fb+d5278y2fOHfRflg/sxk3BFjwpCjgf8bvz8R3tTzIXU7iZ06LCQLtq7dj7mChdsL7jBEe+qjRiMr/GDdVZ4xYHRvWe6BHT6tyrXEqS/AQ5vPTmnxjrcvbP3qQCWNzz190DgABCpnX8yKRTcx2sh+lslEg3XVqr6UQAz3GIEh5QT81UrcmnjCcAt4Coh5mLwLJkQvfhJ+ZhevepssbZYbWw+7+w4DVwtEhmNpv1o3dwp14/V7yPJCcHR21sAsoPqv2rMKk7NKLDe7GnmpIEw5+d46XVs5We09NaENsF/Ytr4C6DveYkRlbrm5b+4TIyH6kR2tKaqYFTr8OPWCmKrj9wOaBZ7k45dOKaN2gSmbW2q7EHiNRinN+emNeDW6ZMMsyRMzzaJw4Izoee0XdXyZ9SesY/Vb95CX/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(136003)(396003)(39850400004)(376002)(451199018)(38100700002)(4326008)(38350700002)(316002)(54906003)(86362001)(8936002)(41300700001)(8676002)(66946007)(66556008)(66476007)(83380400001)(36756003)(44832011)(2616005)(478600001)(5660300002)(4744005)(2906002)(6666004)(107886003)(52116002)(6486002)(6506007)(186003)(6512007)(26005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V8lL07srdYIZfnXQ9bLXwWomduD5EYXwBBd8wzH+jD3yWUbTHuaBWV9YFtGX?=
 =?us-ascii?Q?JxV8d2lcvh+ipd8BZNCJjLYw90AwudULDHYlA3jhD7GJxHfmbw9MHog626qB?=
 =?us-ascii?Q?GfjFxJHsrZMsrwhqpIxEik99YGLjPo1F2W2to7ej+zug+KlZPUtRAwErWYjQ?=
 =?us-ascii?Q?JTNs0sfDmUUf3/TKn2sdtISw62uTTrnAd8d3Fd1R0AfviDQiSRhvIaFx2guV?=
 =?us-ascii?Q?mGYNnQDMGN/8mkPioRqFtzrwMsOhr+Iav3Fl6puGlqyd/0ug6clcrdMKujfj?=
 =?us-ascii?Q?ui935SGMSJ1GJV2pVmhtSrqhOeQnfsg/XHtVP8oDEsAQUZ3307FpzYsimpJD?=
 =?us-ascii?Q?cMmXExZeRRNW558EWNgyOJkOQ/VUhiinURY6Dgh+Yk/e768dSzo8IXEF03BB?=
 =?us-ascii?Q?KHAM0B9fPIJPgb5zMg77c4eYNf0y6/6Xr8O4SwdsGmlrkIAOx4XJA1qnRhpk?=
 =?us-ascii?Q?kVO+XV9Z0KBOZW4Br8TJKXVcKd8Du9txpvgWaD3G6eaysn5IR6HoDAaBeutm?=
 =?us-ascii?Q?TVcp108Nje6EZSi/uTf95sd4MGaOU6NHGENpaZAisWoGVsFgXNj9Jn10pcEX?=
 =?us-ascii?Q?D8YxX1Rr19FTvk07QfIsZZuacdVC+NQbmo5/q/To4cB4I9V/9xuNhg+aI7LK?=
 =?us-ascii?Q?z2FCeBcRQc+jYbAXwIaoDLBIq/6XO4SW91A43Ob8b//Sg5m3st75wK30DRSq?=
 =?us-ascii?Q?d19RdSUnuSFBMREyyoliQgCrw/RpUgdiCaA1YwfsQrHIC1bCSZiIPO1aQ2B1?=
 =?us-ascii?Q?nfnqc95JkVNvS/Rpl7Weko+apeOsWDcDlshrnjv6h/1v7U+QAppVO8hu/rgh?=
 =?us-ascii?Q?E7PSNe3egYNk1ZFR8doV34rZQvmhqAnJi2I/q/Ru3IGc+x6ILouCcloi+IjE?=
 =?us-ascii?Q?yA/fhzcn2+GmSH6cLtcM6Kqefqe2iFpRKLq7oAgwi5XyhtAPd6FtcTYw0jBJ?=
 =?us-ascii?Q?LpMGtQLelrvJOL15McYtscpMMuOBB4xHXCtGIf6cU0VJjj+Pq4GgcAn7N2+K?=
 =?us-ascii?Q?BerraMElv8+X6lbOWrkMAakv1Wk2ZVt36lGr3+To7FofmosubkI30O/PoeOz?=
 =?us-ascii?Q?g+6+VAAG2cQazyhACgveDX1K8uFsGFv1ZfBk5zjGvas+9V1xrweon2CxagOB?=
 =?us-ascii?Q?9JobMMRfn38x23fAiC9KfWtQ3b8Sg9YDdwnuCmPPTMHw9cVxjjRmT/ZdKP80?=
 =?us-ascii?Q?Z3/xP0xJzXm6APQAYG/fkGJBJDYCY2Jc8hUENkgSOT2OY78bsQ4CEsaYxt1n?=
 =?us-ascii?Q?uZWv3VWofupvaEHCJ/V2RVQ5BouHnsGDJP0eTHOOVKuztqI2W5I1L6+U1htV?=
 =?us-ascii?Q?/+QH9LrbmkIBiZzf9u5WSsPL2oidjEu9LG7zQSARo0O0Xw9o2Z1op6gmhnK6?=
 =?us-ascii?Q?ATP8ih5AYpBmkqdTbJ6ZmSsvm2R/ZC5lKNupKoW5S+bVXpYMi4Dl7XgADCnR?=
 =?us-ascii?Q?5vZ9ktmKJHAO0HM+G3vFipAqkcbCBoDB8dWVErlFRO3cxAa4wXEDvK/LcK6p?=
 =?us-ascii?Q?IoRckE8ege4t3r11O9ljA/CpFoBiRLTgYVJzElM16fa6vh9nzn47Xo8UfsVA?=
 =?us-ascii?Q?TmecHlaiBwBYr8Mdg4beuLiXf2udduNXZsOtb7gaeD56doFkRVzUXRosxHse?=
 =?us-ascii?Q?0jUSaWa3dZ8Y9KWv410vCt8=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 4effa56e-c42a-42e9-d9f6-08db252e3b42
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 08:21:09.7579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /HZ0eSbiUopn+byBIHRnqBYcz+0Hnmt15MH4lxm7ngeJ7SyUG93MuLgfbv3y0E1v3deTR5gIe1cAwS7sVixlLrzB4xEDH9lfH4bsMQ9mpzc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8779
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A series of patches have introduced coding-style issues that make
checkpatch generate a number of easy-to-fix errors and warnings.
Furthermore, some cleanups and refactoring operations left an
unnecessary OR operation behind. These patches claim tosolve 
these minor issues.

Javier Carrasco (2):
  rtc: pcf8523: fix coding-style issues
  rtc: pcf8523: remove unnecessary OR operation

 drivers/rtc/rtc-pcf8523.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

-- 
2.37.2

