Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B7E6C0065
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 10:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjCSJg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 05:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjCSJgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 05:36:52 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2115.outbound.protection.outlook.com [40.107.255.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214D010432
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 02:36:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BlHf3sqe1RYY7rXm47EEfiKadHC8DPGxHTBEXNYJUfLcZ9I93DTJvYQCnREs4tmgVATjG9Jblu9M5OMSHzefOqEj/qUGf7nECW1JCOjfQY+xXk3Qea2jPTdZCO1vfwFfszYqyp36Bla49WPZ+VO3Ow547vvtn+zK/Bg0rS/0GvhJLrrLoJQ2IRJ4CPXq1BT6PFaxjNhq5jgy1MhX6zZGY3u53wU796DoetisOj4wYqI4hrri/WqHWtzwfgNH8qr82oedByva9tMM0rsvz6AeWJ8fweueuXM1h4pK/LjCzXS4VW8e4uzmTft3HQXA4HAcut4I3ONk0zsDlul00hbm7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aIIaa5x7Apat8LoxVKaudakporoOCiCDjp8kkBVkcvU=;
 b=PQXHa9iRw6LYUGF5+BzeUKwekr4kK3Edil2J2FI6N1J+yjmD8CQjix2Vwks+SsQwfwwaAwn22pjt84sUmiYfZNdBC2RYSH2jnL8bO+lXov+uWtxxnnnXIZlLKwJiezqSp2gTXhEHSPFLBioQKYQ68uBg5rGZhKJqbFPHEuOBO59ZcVB7vyIlGorELP8YKqYpShUHjHqXhiBcTRpNXR2OmnDHwJa4QVJ0qoHeOcSWVZzC0xDl7Lh5BkgJcpQBBKL22fV4i6KQUCtYxWBtax4gHRT6c94cXblsN78kucYDtKdjgd6nnuScKJFxj/Im74Lky5uAWHbSr5BSrsaqHW89wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aIIaa5x7Apat8LoxVKaudakporoOCiCDjp8kkBVkcvU=;
 b=Egbo4RdRd/uFnwyThLDaIYSmYgMCSa+mt9HRMNAgHDkxCSUOtv8BmFx5hwk7kcWwh8ut7EooI1eh9h7wGZsVqN4KD6srkELIroTaiUQcWVpHMXMAcAEJf+2s+7eDaSUSkjUHpNPWzNYvKbFEzZlxntaK2zBZA6CdKdlK3fzW5KcPzBnFmMOU21g+XURX74dIcjRt0pnARr/eivTc350NQyW21r08yYhzr2w9wayh+2HqjE7JZv8NKa68sSVW+tyk1sVQ/kn9voWbsm7/hpJFckVWumQZAZr/gG8qUBOigWf1fJCLpbuDlo+JLJ2p1KHfCk4GVccztwcRfj1G7ypKQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4020.apcprd06.prod.outlook.com (2603:1096:820:23::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Sun, 19 Mar
 2023 09:36:44 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.037; Sun, 19 Mar 2023
 09:36:44 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     gregkh@linuxfoundation.org
Cc:     frank.li@vivo.com, linux-kernel@vger.kernel.org, rafael@kernel.org
Subject: Re: kobject: introduce kobject_del_and_put()
Date:   Sun, 19 Mar 2023 17:36:36 +0800
Message-Id: <20230319093636.7166-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <ZBbRDl4OYGZIlx7E@kroah.com>
References: <ZBbRDl4OYGZIlx7E@kroah.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:196::10) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4020:EE_
X-MS-Office365-Filtering-Correlation-Id: 9da4db56-6004-42e5-9845-08db285d73a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nVvq8ifkPzovllkfiJkI1TTufISiAG6MEeBe9xVhcBkmoMXHcE8L1xSsyKMzMwgafX/w3nhmUdOfbW9IJ9xS3l2R+ORmtZwDR2DKOaFKbkbZviGv4I1w6guu3uCc0NamplTr4aLSwly252+j7GsJwF6KvTtl1pPVYiHTitOWLjbjDZ2aGiGSNhg1a4KnEGtBIX+r+Q8KpxpeLq6m5NgZMr0iQiTPRhsSNBUk0yo8Psf/yz334lvuKvcQkxeyA3j2pMTq+mhOQF7sxFOGlkMG0DTc7Z+OMTu4eCGsJ7soKxEoCtoWYwXxhhNbxkJRBqBEs9L0V8efQ9zGEGw+oB7sD77JaSYcNZ3KkzK5bitkVmbD+yPNQ98OdWDozkKcPSP2ePmKSj2zCh9CcvEVzMnpMnsrVuZWkn3x51veUxy9nQeMU3a5eFzgeMAJPaEjQTayIQZNiD2TSR5Law6FKtLToDd5Zrvh6k3d+rl5hikXRkNflWGvQ9JfMrFWhUsaU7hB3+mH+dLtId2Ovx7RR7lPzzkfourOQ4PIT9iRbnFvv73oTmyk4tBM8W2rZAZE5VjmjYPcucEmYG9d26i6w5J17BhNo8MwWcpTeSrOCUeX7BrZrwvmCMA2gO18/r6o/4mtq5TIYP1ayrGPVd7Z8CFgx1fbqXFwb/9fj2eWVHxSwYf2e7qIigp7yklX5obIg5hBAVlyr3MufFsHAnRLXmU8UA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(136003)(39850400004)(346002)(396003)(451199018)(86362001)(36756003)(52116002)(316002)(6916009)(4326008)(8676002)(66476007)(66946007)(66556008)(478600001)(186003)(26005)(1076003)(6512007)(6506007)(2616005)(6666004)(6486002)(38100700002)(38350700002)(5660300002)(8936002)(4744005)(41300700001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/mKPeNkJiUv6uROPXGnT47Y/AkIkaTIWdSERDsLx9E43opPdaWHctPst8rHy?=
 =?us-ascii?Q?zYZIgAPkR4eoAz48x9dkD8kN0S7AFLylYNZ93ldrRRo990qd3CCILpgZh8Rg?=
 =?us-ascii?Q?yCmiVJxo6uoCP8bXScNQNYNmM6blo4kW6cP1qGUCbEIABuHRExzmV+AxGPzg?=
 =?us-ascii?Q?7OX6oDG0vamcutyyC5n1yjZRF6dr4WNdlcahnLSpE9/q9NTVAeMQX+Tt45uX?=
 =?us-ascii?Q?q2lsyJSi4YlzrHr9uEN5iNOAL4Yy+KOcnFqIHAoslTAHsyLGs6RLx+V0y+YQ?=
 =?us-ascii?Q?w1zNN4cfANRNigJZbd+6T018Jo3X6RJ0xHDCeWNv7IA++0n30ho8sEqS9KO/?=
 =?us-ascii?Q?p9ha4yAgnRSBIdy5Jq5dmN/kEznIawiIVAD8bIQkD2mrypWOAuEvsA6BBkGw?=
 =?us-ascii?Q?ZJOSBatwa7/qv+P1fzmBXFv/IBEnsU0uhoO/CAqWrRti0MdDHxqnyMZ14tm1?=
 =?us-ascii?Q?pzaYyAXNnYE/8AxGy4Uxv3n8qW/Q1Sh41YajISBl7EWg1L7SZnqYzssfoVcA?=
 =?us-ascii?Q?f45qDoLqakA8qfY5Dqr5yKDCa+x2xEmhAROvHqlMcYk1EHOzacsWPsSc04jN?=
 =?us-ascii?Q?TeltcIw3FdgJsoArbtJcgYdLJ9SCeltdFn5RWX5So29b7bY8N8HTom4+owto?=
 =?us-ascii?Q?xuJpRzxJThAPOASQEpe6P+Tl0K6d/27juqYkcT8/K7Bb0wxxQbVzZ44jCZNt?=
 =?us-ascii?Q?tDKW6dF986KAUpIzkwfJSHXpEggCqVWQAuaE4M9XL2zHf1IykouInZjUnkrt?=
 =?us-ascii?Q?KWQoOtp4MnT1Ofca78vVR39yualobwLmhD4OMqCR1euC6VtjGVKA7qw3BxGV?=
 =?us-ascii?Q?giLskrIw+lOpy8D0Dk32/exHJRsTQ5oqy7QWmNjT/P+lyubLrQ115GHd+G3n?=
 =?us-ascii?Q?PlAhHp6H6TfMe45V4hnQf+e9Ma5QyhTBYzgbovJArrDncUyrf9ogi3C4NGxl?=
 =?us-ascii?Q?gwPcjoqY8XvnETn4D3OF3BEAGEtLc8oao6Yp4xRPiTnjLlku/SxSKzzwqoo0?=
 =?us-ascii?Q?A2b1FoUblWHDT5rDFx/ItzY5hb22GDepViafeadilVBbObcKzcUw4l+Gnyev?=
 =?us-ascii?Q?6bn6Q8MaNEcJ6gaTDwWptvxf66eiRLrWSAHdGTmOjtPEjKCnjyUP7cD9A6hQ?=
 =?us-ascii?Q?pdc1HCq71ilkTGC2jtY3NDdjnKvXPYDklWTze8X/N4rnhGyGQjt/3jW2wAmx?=
 =?us-ascii?Q?9/rFE6KVLNKEaf+U5rROvMOpOvjZ9f44GhzxNpQ/o5XfkkWHuUFV1WpJRV99?=
 =?us-ascii?Q?/XMufCQBRfxrGKgIZwenSH4yihKGz8N8jh9KyDfc8wvA9sCLt+Cvfe/M8m4e?=
 =?us-ascii?Q?/31wcM46Q9P2kxeQ+55hp2M4mNStSlvmxSFOKHHCOSdxYp/eaXarP3RYsKKu?=
 =?us-ascii?Q?GAjbU/jloDjFWXFH2n+LIXIBBMMJhfA3+kl5/0QFDe0fZRpjL6jk8umzUMeU?=
 =?us-ascii?Q?VOjHEZB245XJ6tz+XpQgPJ4xpjZ3bOqGi5RpS4biqj94cYtFACu8MplyuVi+?=
 =?us-ascii?Q?0vi7XSFRL1i7MRWR2XqWlrKuTvX7856WlEfunMP0uUo8EVNInunsRxOH/xtd?=
 =?us-ascii?Q?rTctBsVDSjgdoHHDs3zkFT4mSzQE17HnsIXkoa4X?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9da4db56-6004-42e5-9845-08db285d73a6
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2023 09:36:44.2142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /9oz4bkZ99P/isWwjSzctbXPNLk0bGzqb/yL+WDNZ17LmBN8lXDpMfI2q7BA0aC3CiJuLgLGuak6Yomie+9BFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4020
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Any reason you only sent me one patch?  I guess you don't want me to
> review them?  :(

Sorry, I used the following git configuration to send emails, so it was
not sent to you.

[sendemail]
    tocmd ="`pwd`/scripts/get_maintainer.pl --nogit --nogit-fallback --norolestats --nol"
    cccmd ="`pwd`/scripts/get_maintainer.pl --nogit --nogit-fallback --norolestats --nom"

I amended the resent patch, the patch body states cc to you and Rafael.

Thx,
Yangtao
