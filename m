Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE0564A2F9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 15:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbiLLOPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 09:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiLLOPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 09:15:43 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2137.outbound.protection.outlook.com [40.107.117.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36B1DF65
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 06:15:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c7LlXaGvxSUSXNV9wYj3lUTVFD5Vfmdi9hYkssn/RmAKjTa4Wtw9ufrVmGF3HHBJnkv+jdVf3c0Qw4dYkZZiFCIJEF1buergQmxgbKYjsNsySW0AAdo66EXtEVYOWgBu1T4jmF6x+JnhTTittCtcvfVcoi7A2J34g02g7We9Hl6kPeK3hlI35/oEKyB5UfgjN6oP39LAoNlxW6TdqUmHsKqwQ2exaA9r6rb1ECo16M2Y48ORNDUOvRdCIH+ivUecER4i4voqu2W0aP6IzPcuHt5hTG9HIDqy1GDQo+czV/bm72es5KOp3pSpih3RpZdx+P2OA20iZjFpHIB6lRCSgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sB+n4jZTMB/fx/gxcGDwJ9Yci4UN7SIlRIrbXVXWq+0=;
 b=gLcllg+8qHQT5IqbmjfV38ANHipMScbF/MDCuV+XgQLP2oJakS4gaqrx2SyciOFwntsPaPloWAeQ/gi11Nhg1V1Y0/ZuAEFe3xAZsY8JO6D5Ezih50YptKNdaLj6S/fd62Ynqk0YemXmuIXRAWDs2v3TwTZ+F3tQu7eALdHmfeKFACAAl76u/4pb7eh/DLWqyHMMYbDb4ka7lNl+pkirLMwvJEeS8e/uML35nGiV/hnS+d7OAn5BDZkqVfY1urbJGfdJVyDtyp52k6SESV1svGptHojkVcJIqsQnozfqkBR55gd2691J3jDram9eyMQjzjA30uWuL9ZaYGxLp4/iOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sB+n4jZTMB/fx/gxcGDwJ9Yci4UN7SIlRIrbXVXWq+0=;
 b=JQa7JPwPKn2CuNVuL7uPVZuoDLtr4gbCRMxDAWNJZVcK0SN9HQt+/qdBOb10ExTMa94sp9xkSSLbVzv0SiZC+/+i5JGTwkr3dGLA3nsJ6NmoxzbvZCUMr+Ug0vl9Ts0cwe/bzxoX7+RH82FN005+Y+Pn63KGiGyhsVgbOgzZZ0dY9fopHMaL7y+gYTR3/RrW63Dum4u0FXaTXP8u7jqYuq7mqaAKIsQexHooeft+EJXiivjpJQgb6LOO56Vv9B95BkrlRUyIsfoav7lq31EzHXEfie1o+IP8FLO4rYuHFodOyGI3zVTjz1aYUS6hoSbgBC7qRBEuUkf39QRl/NwVig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB5395.apcprd06.prod.outlook.com (2603:1096:400:201::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 14:14:38 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::ef03:cbfb:f8ef:d88b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::ef03:cbfb:f8ef:d88b%9]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 14:14:37 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] f2fs: don't call f2fs_issue_discard_timeout() when discard_cmd_cnt is 0 in f2fs_put_super()
Date:   Mon, 12 Dec 2022 22:14:29 +0800
Message-Id: <20221212141429.6329-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <974f5013-b6af-a39e-0b0f-2ce86253eaeb@kernel.org>
References: <974f5013-b6af-a39e-0b0f-2ce86253eaeb@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0183.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::16) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB5395:EE_
X-MS-Office365-Filtering-Correlation-Id: dbc78305-0a22-48ed-3bf2-08dadc4b33d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AFxyeuOTaW5TQz2PH8LsL52Yc6Q38rRhWgKCy4d5cGHIVZtcobitLbtjXXyypkGtUOCCh8cxaMI2hQPVmcJWFtqhOLzBeo+1YZ2apoZowF1QScx1NI/RxMlmmBsbLW8m+1jfbd4O72SYeINX1FCdObKBL39QHSyGprVn9gdSNGsVDyGyoHflxc8nb6VKcxonRaFMzAG8hjqf5LBJcUu9fWQAcvWUX44qYTYAqKACo7AUDzFlJw4QJiiBoGoXeg2YyMVwUojQttWYH2MHQ/rDLKR0p6wL2NcSaU7/mMHIowSA/azBqzEJMcUHeoSTzV/yYkQ1m0USxpL0IncGzxf4vI4ja++78n9i99TsGYnMMpsZIWz+bkRQUSFAHtxhWFealb15Np7Yxm/I94nGtp3Oap94Vib8xrt6KnHb0Oylorh9SzPTO7wddSMOmGJO35g7Kt01VLcQCTy50GLqRdlXwbGTBDx7I/NrGJ/GB1qzV/gxPTrEMZb8lInwVDXk7wBqZZktWad/wS2tbkQkeEmUZZir+QWr9hP1IzxjmUsB/2l6K0RUFx1kb4ws9TS2J57sgFSidSsMMx+3A5TvldQcxEg7ls5Ps+WmxHD/ALfYAU45qSVyGvcq0qs8AodgaY1TIIQARFi6Vx0ZLGSnEnxu3qFK4+R5YTh1xQ9k793GYMYSjKPFFh1O51Z1GDAzs3XP+oT9hvi/DLu8acQmy8ErmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(451199015)(86362001)(36756003)(478600001)(6486002)(6512007)(52116002)(4744005)(5660300002)(4326008)(66476007)(8676002)(66556008)(66946007)(2906002)(41300700001)(316002)(8936002)(6666004)(38100700002)(26005)(2616005)(38350700002)(1076003)(6506007)(186003)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JJJcS4GoRewQWhT02KVjefPCOzFANLrKafmqU29+nK0vUJvim66Rdx2elC2M?=
 =?us-ascii?Q?qba0vyMkB+1Q46cpKD5yAC9UlyyEBa6ctjMwnTsCDOae7SSGxa6BSTR3/G9Z?=
 =?us-ascii?Q?DL5UrMOUEJqf8BcSg2TG4DiMUgghH3no8MU8Ju3k/QpjNUmR8jYs5Knu5SMD?=
 =?us-ascii?Q?xDRa/R5mzDo5AWL93qIFZTEIgWBRYqEnuXbU0f8mrBDZzr7wqpSZhhUsjz2/?=
 =?us-ascii?Q?4xVxHmPg0GFq1hxMd2P/0MgnFMMZkQlu+to7XjGGdbT/szULKG4J38zHEDFc?=
 =?us-ascii?Q?TT5z723WT42ZQEBxvG6i7uGCA4xNb4FbXLqjqLvQdsQAGxcggZZFCNFVNIAW?=
 =?us-ascii?Q?Jfx5g/kJaQzXhzgcoNr3h9xGICqpsICsOFpNsp57dtJVP+DZsqe2WMJpV6Iz?=
 =?us-ascii?Q?klFilUs0AjmnYStkXp/mVYSAnsoEWaQyZQTCqtQthFRuEfiWwTEGZGHneKoi?=
 =?us-ascii?Q?2w2fYBs9WIWgHOvlM57myyFw+IcstkNGxm6IYRLaYt2Yy/IdR89rmcbBquUC?=
 =?us-ascii?Q?OukjQgONltuwj69qSYMDWho8wkB8wblQ9Mjb81ObmYFxjYEV0rMRBZN85HAz?=
 =?us-ascii?Q?ZAlyKZroD/djaDcnyK1w/QpkE9ilqTFlhcZxzMsQ9+H9traagU18HO7oRsav?=
 =?us-ascii?Q?q3ASHgePbBDVbp3iYQR+SczzZ/+NF6QvtsfKTeu6Q+tvL4eyycwaF5haDdxw?=
 =?us-ascii?Q?OMv20YVHAMilxRj/lCjMn0xqe6ba6Enyg1szH+wnyPecv30z4+ARAyRqzOAf?=
 =?us-ascii?Q?jJFA6RN5QIpqbieIEpU6MVSG7gtTeoZc0QmHoeLR+eRPrYDAEonm8b4X3uEP?=
 =?us-ascii?Q?VFRnKehmqON+aXBdIuboOdKJIhd/mftS7SaRNZJiSZ6xI3eUzjSiI/F3+FS3?=
 =?us-ascii?Q?D/Z9DHmI/VBDlh5YmfAOYi0v0/Mg6T9ecvHzdylsp8NrlyGf0hw0K04PvvNw?=
 =?us-ascii?Q?c4XXcHbj5UmZXa7wYoKZTWX7CJ38WW+kNGvi93jSKTwd7kbjRqpureR+LPWG?=
 =?us-ascii?Q?rnFH8tGFnFr7Shadbv/7UNZ08DJbzJMEsvtdJRRowphVbWyyTTes8owPQPe5?=
 =?us-ascii?Q?rd5GbUAzS1QhZPsvphjHHgkiixq0/xY51npf3aoplnNnxgyT0n2cPfmjHGnL?=
 =?us-ascii?Q?Btoj1DaLuvlfwufO2MZ6CeLPvMSDdAv4GryZfnUxdnWCT4+7Q4eLOPtVtRzj?=
 =?us-ascii?Q?0CYu8xMjjBsbcYYVTJ9iE8B1TnZCdKJQslh5v2a9oI3eN5AocV+i4jUhsstd?=
 =?us-ascii?Q?TOGx0bUfgoryzwW211W7j/quLHfCbif+f6dnNLSPE60o7GEm1gQ0nm73CPm9?=
 =?us-ascii?Q?AJ6gIbRMWfa7zGfklmH72sHNSV51iCfVb9QSh6UPobAa3AzdjbeOFTFWKRbZ?=
 =?us-ascii?Q?zetyBnW7D8EB/nW67lsAAcRIWxNyiTilK57DJ/eAUSdblW7M//B4ZdJFVjGv?=
 =?us-ascii?Q?/NmoFN08dYVs3MLR83K717Adxy59dVFCkw41Lx796Uah55l6L4nN8ixmFhKr?=
 =?us-ascii?Q?KCw2hjvFpgdv8XXxT5/tmV0ObsGpYYUKSEeyDfdI9NY3FAPWTPM/HiUcI7se?=
 =?us-ascii?Q?kaqhhDdOaJTqiyBzQR6zHK6xaeDHJvMG78unNggR?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbc78305-0a22-48ed-3bf2-08dadc4b33d3
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 14:14:37.8516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bPuqopuSpHNdfeNz2N3kc3ZkLpPV/3bkl8abJCN8So1J0KMVgVW/xTkdubo9p78VlgoiNVe68L/8KvLYOztcBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5395
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

> The difference here is, if we use f2fs_realtime_discard_enable() in
> f2fs_put_super(), we will only write checkpoint w/ CP_TRIMMED flag
> when discard option is enable and device supports discard.

> But actually, if discard option is disabled, we still needs to give
> put_super() a chance to write checkpoint w/ CP_TRIMMED flag.

Why do we still have to set the CP_TRIMMED flag when the discard opt is not set.
Did I miss something?

Thx,
Yangtao
