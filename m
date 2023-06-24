Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B7373CB7B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 16:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjFXOzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 10:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbjFXOzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 10:55:45 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C002E7D;
        Sat, 24 Jun 2023 07:55:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aoVLnOxxWRIN69f7nKkS3l1/kzBrin0qtMmnHvURK0BBiuULXh49ix5m1Hr9dQCrqcd4w8Qm1psjakKtVWMcXBhHD4txpHkzbYHHysWtOHVmlDxSNFm8kAhg++w/fJGKz4iTF7rNS9JNlz3B307V2RfZcz93Pb1zYv1vvTdWUbwOsM4/H3cUN6IuaKL4NXGKoM8RJxs1s1YG3CPvcZr+0jhNU4RkyD9+uV7zdNhEgSD6Z3YlyHsA9r1VZxLG2fT6K7IzrLQ0zRIAmjxzYHveCwqPkNEnO8FOnoocDgu32s0FHR2be/vo/KXJJgaw4+yNf8+J9XuGEvU7rDTZ7GK65A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gbmVkoGzWRDCDzyhIXnKxTclnpx0hTMqKywvet4Wpg=;
 b=FR9U87s/QWq1quU/4CLgu0YQ0MnauOtimhXIGp0VNUXE4R7BnDm/O2wurj4YuOfXhLIEOZpLjC2NlO7wNZwoyLRirmhOPLTb2TWLICnqIAhq9c2ulL1G4OlA/4r04sWDcgePtCGu/Z+W4rQz4IkSEUZ5vneMhb1lYX0aJL2cLGDNyBYyzb8EZO6smZ3clmEzksCReUTNWJObma2F0SPsYQMla3/tN1pLBp4OitHbf9OKU04NrEP6Ig7qTS4LB2j/0OfLtMTpdaVAgCBtCtwUUaI8ZhSYborUCUf9eVZTldwQ1mnbl78t0UALhFeM9BXfneFH9qhNQ5HdASlFvYcO1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gbmVkoGzWRDCDzyhIXnKxTclnpx0hTMqKywvet4Wpg=;
 b=H3vHo42E8h4NFJwO4YAWJDiznYrVDZh8pJ+Az1Ub5b880Rf3dicvPKkY5x/Bu7WWL3Ss0eJnFHikYIow+PBmzhWfW2dTMj+k9Re3DHEdfWDVL1OzarAmhCXGhdLXY/dKHZqcOwkzPmBKEBmUqF9AAMDDcNwZW7hbbBKRMXGeZ+Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by BY3PR13MB4993.namprd13.prod.outlook.com (2603:10b6:a03:36d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Sat, 24 Jun
 2023 14:55:37 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Sat, 24 Jun 2023
 14:55:37 +0000
Date:   Sat, 24 Jun 2023 16:55:30 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Jeroen Hofstee <jhofstee@victronenergy.com>,
        =?utf-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>,
        Tony Lindgren <tony@atomide.com>, netdev@vger.kernel.org,
        Mugunthan V N <mugunthanvnm@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "open list:TI ETHERNET SWITCH DRIVER (CPSW)" 
        <linux-omap@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] net: cpsw: fix obtaining mac address for am3517
Message-ID: <ZJcD4sqqzZCq7Fww@corigine.com>
References: <1477668756-2651-1-git-send-email-jhofstee@victronenergy.com>
 <20161028155213.2t3nwwe3lqaynaer@atomide.com>
 <d8ad5cab-5183-cddf-fa9a-4e7b9b8c9377@victronenergy.com>
 <20161028181914.mskebckucukzhxhz@atomide.com>
 <yw1x7cru445g.fsf@mansr.com>
 <ZJX9FBBvOTv10IO4@corigine.com>
 <de546232-0638-318a-535f-169184933a20@victronenergy.com>
 <675a346b-faed-4e86-87e7-b332da540055@lunn.ch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <675a346b-faed-4e86-87e7-b332da540055@lunn.ch>
X-ClientProxiedBy: AM0PR04CA0102.eurprd04.prod.outlook.com
 (2603:10a6:208:be::43) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|BY3PR13MB4993:EE_
X-MS-Office365-Filtering-Correlation-Id: 3df61491-daab-460d-6009-08db74c311de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1VrFm7t/cwc5OmeW0rbLJSGjdUl8uuFuqsZpaDxw24g7lct4ctRPxheqBgL6HaHDKkv+8ErU0fOfIluT5O1QhvdnCscS8X8K3qM7ouPjKJSJ4ILNJC6+iNdNI4EKT40keQ7RmYaah0KATLwBx1HX2wpimEy+XOkIOt3W7beVlzP1hPsH0JaHhDuspKcMOKLUIhRvuc4cn74UX4R5yxVGen2PTGpqxN5Ppa1oiXsTwJ4Kld0zlepHXCiSILrp2ZFTKjlOdlgavqxucqExG4LM2Dbdn9J7QbWhJJ8zq2EPniSEn5jYsoSoOwWWzvgE+ZARpodl1qoVqhzY6+bjdWrogQ+PVUJczgJYfptlh0zIbSNcfWFDGk2THsxObohRAaRaU+xXJw8tmXdPGhKwFh6SoSsj4iphw2LNvBagkGjWZOwVMcGZVMXsdTKFN85DEpjKLWtBacDlxee8TKYAZF+Gr7+1LrROUF5UMfq0VDr/OFjmH9n/tcioTq/XVvFqJLfSvM5OQPA1PNCMie+QwozXoLUzu/2TA0GaAoXryG9EGCI4qmle4uRmwPwe44wNq52A5i589UEDnhcZL3YEFxIvozytAq6ssebHmsfW+IDbLqE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39840400004)(136003)(376002)(366004)(451199021)(36756003)(5660300002)(44832011)(41300700001)(316002)(86362001)(66476007)(6916009)(8936002)(8676002)(66556008)(4326008)(38100700002)(66946007)(6486002)(6512007)(6506007)(186003)(4744005)(2906002)(6666004)(478600001)(54906003)(83380400001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V0ieJQ8S0XRjcJG5iAIF8S74+lZMc9M6VkEt7HN07HI+vp/RlHeUynAgSuLk?=
 =?us-ascii?Q?ShBImX6XgXPBZR+tGhmR/rqMV3a0XiWYRM+jcqveJlM0I3eG+EH/TQreVn7+?=
 =?us-ascii?Q?5dJnG0OitdZAUwpn7d+niCiwnXyokSO9f36le3AA0P/tvt7/MJ/+p9zbVG5q?=
 =?us-ascii?Q?y53m3+3b4peWPTpsqnONu9ANMpbofFd48PWayF7rCzPUfwrEZDxz29B870bz?=
 =?us-ascii?Q?QaL5HH77zdDEIWan5z+ITmJPe2C8X/HZG+3cNt6MXGMRd3abXO/FtVfpWAIm?=
 =?us-ascii?Q?mMUhL2j3cRRyV/IuinfYqEE9aqNeyGDiLDcLQDizZjTxcb3xw93X3DsmAH5W?=
 =?us-ascii?Q?HgSWbp4HC1EOqasrns2/twgTtq2cQ+8GTe4Zq+kaTmINfR4GeWi0O7SJbP/m?=
 =?us-ascii?Q?d4t7mf82XjDIlYefTJ3iaAEEBc7lmgYKWl4dMBiNH64D/FOeFa2DuHCPLDbs?=
 =?us-ascii?Q?jauHAgML4T7zPytqxLiZ2jTA7C5q7Re/6LT5i7LHWiCUHosQwzU01usXLYuu?=
 =?us-ascii?Q?rAMoXv9cen+vAldfkkJsHGFiOJx4YhD89MUaDolUpBf59bsyzVyZ7dGBdAqk?=
 =?us-ascii?Q?1gJ7mt+dy63V9StkcmqCYySlxw/F6gX3i2Mw9GmC0CY1whblin9HMDoM2fNH?=
 =?us-ascii?Q?xzK51BgaAMTDgyG25x+tpdvyV4blIOH6qkrAyvXMtZYHyO7XgQAVdjhsDqGW?=
 =?us-ascii?Q?foqHumvKgWWrktvJ8+R77nIsYKccVSS5gZF2M0xi6rBXGFuCwFRLDWrCdKtU?=
 =?us-ascii?Q?vcH/87jSf96XiFfatk8kksWvqGtDc8YkATW0oWluM6bwqGt0MN0EplVrmIdY?=
 =?us-ascii?Q?rkJxuqa0tVB3ZL6PbaMTD+A2EdCTL4jocgtKYHdP0AvowDlds51XNA3onUM1?=
 =?us-ascii?Q?LlteNcEDLraleQ8YS/q9D1sScQP4ezMvohMOfuC8pG+vlmPJ+j7BwqL+fAwx?=
 =?us-ascii?Q?kLmEJE1zB5AqbrjgrDL+78IpqcRFOmQk8blA2sS1CKQJHyGOSh2HrkNsxkQh?=
 =?us-ascii?Q?1dVW38J5z92yPZhhto3wS/uaO6Amqkiqu1FT/jToirXp8c1MrNx5z11qFfYb?=
 =?us-ascii?Q?z+CWZZztoOPxaVWvLdiUJ4xcUuyoLsqIkBXOvVGbpjyDdeSbQsH//EXDdtVI?=
 =?us-ascii?Q?pEppF2jOmVQmPdO+WpaFm0w3iUhH5knV74tne7DbhbD+vTpR0lV1YKraSM1B?=
 =?us-ascii?Q?TILWueYxxhgapvfQQ//51zw9DULl6+jYVtHybvMIYvf4hyGDhy6/FTfAQbMp?=
 =?us-ascii?Q?XGWyyeZJjAA3boNQnmaT5CwpS/7s+i7ErJdBIs/MmwKf5a83ZKxNAsqgPcbE?=
 =?us-ascii?Q?5Ws02RqJSkC9Mj4TsfVCaQjtrOoQXbCPZVtSUPKxMH9XaQVTFpk+P5Qb2jMu?=
 =?us-ascii?Q?bV/eAhmwwYnIcP6LYj/wgxi7NQRbLGh+j8XlABabCtWvGHanzVthcaJUKyja?=
 =?us-ascii?Q?4fQlkDxQMfK7t5fbIjPIQgi0mutZeDg5Le8QHbE2fC3iIvrHZzawIjqKN8J+?=
 =?us-ascii?Q?O/eHG6sE4btpGNvRJefnWz1sQiPHC83JkxUcBCffcVMec+ruuXbXEGOEUlFN?=
 =?us-ascii?Q?z37cN0TDcRdbEdGdyf5sp/lIjKKxOUR4pEKUZraEi+vagPF3gkZ+m+eogNqb?=
 =?us-ascii?Q?1dA56un7lu767XC2PBIrStLUsgwkEOyN8NfuRg9QoWjtW2n/IDOIvtOV4pQn?=
 =?us-ascii?Q?J9FTgg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3df61491-daab-460d-6009-08db74c311de
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2023 14:55:37.2263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iWoLvGJwr6E1WsVyZuWQAv0TSMwXiF/Gh6w/moXmGv8HNpt3Vux3urg2nKP3uj0895GTDcgncolZl8DWZhcPSjFncZ2UvyWaOGBY0bd7Kl0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR13MB4993
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 11:41:10PM +0200, Andrew Lunn wrote:
> > > I feel like I am missing something here.
> > 
> > That is a weird response, you feel like something is missing
> 
> There is. The patch.
> 
> Maintainers have a slightly better memory than a goldfish, but given
> the high volume of patches, we don't remember threads from 2016. Also,
> all our infrastructure has limited memory, this patch is not in lore,
> and it is not in patchworks. So in terms of getting merged, it does
> not exist.
> 
> We do however recommend that if a patch has not been merged within 2
> weeks, it is rebased, any Acked-by: etc tags are added and the patch
> reposted.

Thanks Andrew, that is also my position.

A ping for a multi-year old patch is unusual (for me).
I was wondering if there was a back story. I guess not.
