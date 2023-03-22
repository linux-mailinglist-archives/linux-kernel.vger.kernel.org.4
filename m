Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431606C42DB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 07:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjCVGRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 02:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCVGRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 02:17:41 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2084.outbound.protection.outlook.com [40.107.21.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7582859823;
        Tue, 21 Mar 2023 23:17:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLBG3Ol5YojTprjKJY1M3FMz7axlLmuNQKjVeF88fUvn8YsefAYWuzkOINZl8+toZMzC5xctOgAC2qYes1P3t1M0HbmqKcwasx8R6iBMXmlybLDjfBJlI7cYpBWfCfv5k7FZ/m/ia0JG+qusXrUaKa33MQG+rpyRTIRLZ7jw0eOfIdxPttoYDcixVf62q/jE7Zatswo3EAW2zZURcIhEcJItPJxqPWBxTM3sLWLouF1xrsEf0oDk77mmrDVZVoKUh2/CSwstT5GKIfN7nbv6NbaLrmKrZo+GLAb8MhxZvkPVFljT7QAZz551+O5nBPzVOCQYdFdo+rxJGDmXNh7bdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3UeKKmRo5ymedSruODd4tSYgsD+Wr0rCFkvDOLjmzc=;
 b=B+KS1eUnr5BtxIhwbeYyajwdj6HHc2kF4aMLzDolQqXtc3N3gpD9wDQLHPPN0Ev6p53wP8UGpaG4rwguZZFaQuc8/17mXJakL4rQ5aHOr5Cow4alAFmqUaA34bfn6fBiE/7rP50zVX0C379LnSExibfZ0oNKb1G/EFrkRLoC7WHej5uDdunjyXy42Bj0oQNn5Rp0BxUfPk5zKydK/jEV7mSUaq3w02djUb1Tg4nP3zsTvHowVjEN0aANpwBWr8Ix2YYR+TCuc5QJPEz2RBzoYRFhiChzlvOze8hq8A1+pHhzKTWPsW1MBA6RFtFBRMsUKt3FP1U9sfEGv76kJXFExQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3UeKKmRo5ymedSruODd4tSYgsD+Wr0rCFkvDOLjmzc=;
 b=du/5Pots94y5XL5Or1c8R+epizJTlpCYgMbVxd24VnEDPJidM3oR8XY/W1YfjdP7rY13wCKxjSPbAFGEfDhPJVzjcidHb+U1qhFizKOzpa7qjeXLQIgMih/zuA2Kq9kuV7so/1K8oXUWxdfGANXmCM1gD7aqb3qvGqFw8yesB18=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com (2603:10a6:10:314::7)
 by DB8PR04MB7020.eurprd04.prod.outlook.com (2603:10a6:10:126::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 06:17:34 +0000
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::a518:512c:4af1:276e]) by DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::a518:512c:4af1:276e%6]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 06:17:34 +0000
From:   meenakshi.aggarwal@nxp.com
To:     horia.geanta@nxp.com, V.sethi@nxp.com, pankaj.gupta@nxp.com,
        gaurav.jain@nxp.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Subject: [PATCH v2 0/2] No access to CAAM page 0 registers
Date:   Wed, 22 Mar 2023 07:17:14 +0100
Message-Id: <20230322061716.3195841-1-meenakshi.aggarwal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230302062055.1564514-3-meenakshi.aggarwal@nxp.com>
References: <20230302062055.1564514-3-meenakshi.aggarwal@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6PR04CA0042.eurprd04.prod.outlook.com
 (2603:10a6:20b:f0::19) To DU0PR04MB9563.eurprd04.prod.outlook.com
 (2603:10a6:10:314::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9563:EE_|DB8PR04MB7020:EE_
X-MS-Office365-Filtering-Correlation-Id: 5972ee0a-65c1-4b53-d1c7-08db2a9d1ee4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F5KbAm3RQTVZ4hhtqi/XzW9/kjl9Tck2GlTMIwKjkGzaw7RUciJvqOfCrmXngq0LNJAe6rmIr6SUhDOHc+MlMS86aLLiDvxvIj2GnKNOJHmLha2UKdGiOUYPRaINWwgJyNPgs1P0GjINkoGBqpTwYDx2Ui9snA5N79cUF9izFpHLzjjQKpCLp907C/ltTGoV107mV1t8pQONu+hZfZ3yYTHTxt8T/c7jDmvDRdwGlDHNCNnvbQE//IAKMMEtYhdVzUq+dfToyJk3nngQ374M+97R1SBiGXkArSH41s1L7jHZjNOQ/cWFJAm1ENSEC0Di6CVa0u+6jE5myENkNUTzO1hsXpWC/xpiuWwIMZzUhuYtF6NVudLN9GcxxRg/qt6ofjJQcocreoacdjI+LTB5KWQzQqxQoYr7BhaR8oeqdKinGbf7n/9NkphJRTNiQ5gru7yEETKb9cGqg56HorXcZBxLPVcjEgVCoNp1O1RbfN1+36+T6MLgZmmxUYhly2igYGMWk6kXWfs2ALnKEy8O1ozNdjXmybAyikZH1ipcuOAkVti5cUbO1TOATI6OOjzkVNwHVpTSSatSZdTDpZYRNzPD+xLvFkO5mK1AEl/qtkwHZpvjU31WpUbeEfkoMgnFUfi8tSTgqgcf/kz2PtUQ8wYOOf8k24NCxSHr8h4d1WjpwBu2I1c+4Y5KeE+7/zzr7Fabpl2ime72Tjsrnddapg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9563.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(366004)(39860400002)(396003)(346002)(451199018)(6512007)(2616005)(83380400001)(478600001)(6486002)(26005)(186003)(6506007)(9686003)(1076003)(8936002)(6666004)(316002)(66556008)(52116002)(66476007)(86362001)(38350700002)(38100700002)(2906002)(4744005)(5660300002)(4326008)(66946007)(8676002)(36756003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zym46uTnudT32nUAsCvwOi84pauZHWYMoGQ+P3IvRj+pT5C5kwvWSKXO7OpR?=
 =?us-ascii?Q?DDcxf0nV+j/UkIBjyS5/wzS5VIRLE14bcMuHaMgPQuHzS8cIMHIfMDOSrB90?=
 =?us-ascii?Q?J2EoOIByXWaEHAcjK3tchbLO2Znkcn/MjfZQLBZ13x3Ao3ytYKInhPuhkLFb?=
 =?us-ascii?Q?6GV4cwf5XM1HocBYrs+zYlvW0Pv/CnNvfLoEbArPGtdzYaTML9+xxlRNPJHg?=
 =?us-ascii?Q?m1CAi8f44jzBjH635w5DU6rSKcAsQhs/tLLlVyhyAQ+Z+0v/NKvLwOMqP5og?=
 =?us-ascii?Q?K1fjsYmu/esnCdDev5QCyhXo0aZ4G9ME25AXPBMMpf9enxKxFh/XdD3JMAro?=
 =?us-ascii?Q?Cdm7cuolDQAvq3PmtAlFoA1fOh0Lax6thuWKLuFXsK7dpaoM60ixcAxPvuUb?=
 =?us-ascii?Q?ySFE8Y+4/jHPiTUbXlqSrJaZThiiNDwIWeFxwSRTBMhLB2uZrkcSnbma6L8l?=
 =?us-ascii?Q?Sw1r/5ZIRT4FaESnSLKBlRNmerqokWjRVJ708SUq5LlAxOV/9q4xOv1Ncl1q?=
 =?us-ascii?Q?8xUvJnAl9B4qIpppJs9dXOQ8TcpHvKjSWrl2ZWLYcWGWkXxp8b0UJ2oCscEG?=
 =?us-ascii?Q?UhAPaYYiWT/F+2G8MJp6LtkGTF1oEbHS+4hp8IzzK1Hjd/J+KWkZrmOR/g+u?=
 =?us-ascii?Q?BUO3LYmbGrVQVuvoQjpPIdepEHQeDckQHn5TgRq0OHTmqreSMA098OLP9nlD?=
 =?us-ascii?Q?T94K+KwrsXt/g7M8uGFPAIDLxTkZ48Epdnj8RsAS1oQpi8pG76EHN7+kjTm3?=
 =?us-ascii?Q?RqVnHF51xHkRlNJRbJhgKc4lC/Wf5cWS30QlVN/vJH0jc0AT+cljgtLlaB7d?=
 =?us-ascii?Q?MEOxGkYYX0Hf2hd5uzzL6BweAMD0A4MQRj0pQg3xpv1w3Gj6ALHar7+clkAM?=
 =?us-ascii?Q?PvjJWq7n2fB0RZZu0fb6b9hbVDyJayNifn8G0U0pkxnTTmyEwnoNRGrTnT0l?=
 =?us-ascii?Q?bemxfSpkNBifj2xBH9ka/gzOne+yqJkF78ikrU49VejYnRpUa42T80hmpBix?=
 =?us-ascii?Q?SDRA6XTmLopnwq+qWc4e1sZl2o8PD+9oLhzZ8yxaU1asvrCjM2Lz26yv26MA?=
 =?us-ascii?Q?pomLrGAae3+WPE7mlacJqQCanJnbIkbCh7wTY9VmQg+hvA+dBQ59W/i0lxHi?=
 =?us-ascii?Q?Pi2Yu39e1G0lMu/frKdCQ8nLNBJ7UzKA/2Kzq4Y8hXWIpK2GbJWOtvS7eifS?=
 =?us-ascii?Q?YHv+v5anH4ZZEmG1PTdz+A8Utx6hfLISbrf9h8zCS32fokLcxaKwk5UEd02Q?=
 =?us-ascii?Q?hf7xGQBhrmCoEDDAh5HGxcgUGQ0kI6WTaPv6c+/EZltQLH9U1LxWyHQrd7/k?=
 =?us-ascii?Q?IUb2oRG6KP4I8+zBvREFR8x9BeeaaZ6r8CtNyfuOrdpEKn8jCZQPJB1f8AoF?=
 =?us-ascii?Q?WI6RhfYhSVZ15O+26rrjtgYqdEQbXuwJG8fI+b+JrLgmIuRHFDtIAEi8p70g?=
 =?us-ascii?Q?Id0bs9yKs5R7qhqUI9OGf1AHEJyF9ZxQDwfVVnYnDrfBB7fIfDHxc7+EeiAM?=
 =?us-ascii?Q?djC7yHNCKGzhjJbGo0zvroVANhYO/KWFnWE2/MoJCToGd+asB2omVxaWNT/W?=
 =?us-ascii?Q?r96U3HBHUc+4lVMqir+KQg3h//8ZHO79cyZvxFpk1teAoSbbxj0YiqMrC5qt?=
 =?us-ascii?Q?Dg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5972ee0a-65c1-4b53-d1c7-08db2a9d1ee4
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9563.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 06:17:33.9124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2FabnZf5MFytQeo8+Y1fo7aQjzZJDML24Tt9EE4IZNjvz1qaIfS3eBSnW3v0D+n2CNIkVu0uu4K+yDCdept4/O0HJ12iEGZBY7jTobcZYxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7020
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>

This series includes patches to reduce access to page 0 registers of
CAAM from non-secure world.

In non-secure world, access to page 0 registers of CAAM is
forbidden, so we are using alias registers available in Job Ring's
register address space.

Allow CAAM's page 0 access to OPTEE, as OPTEE runs in secure world.

changes in v2:
	- Fixed compile time warnings coming with compilation flag W=1

Horia GeantA (2):
  crypto: caam - reduce page 0 regs access to minimum
  crypto: caam - OP-TEE firmware support

 drivers/crypto/caam/caamalg.c  |  21 +++----
 drivers/crypto/caam/caamhash.c |  10 ++--
 drivers/crypto/caam/caampkc.c  |   6 +-
 drivers/crypto/caam/caamrng.c  |   6 +-
 drivers/crypto/caam/ctrl.c     | 105 +++++++++++++++++++++++----------
 drivers/crypto/caam/debugfs.c  |  12 ++--
 drivers/crypto/caam/debugfs.h  |   7 ++-
 drivers/crypto/caam/intern.h   |   1 +
 8 files changed, 109 insertions(+), 59 deletions(-)

-- 
2.25.1

