Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4654D70A660
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 10:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjETI0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 04:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjETI0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 04:26:00 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DD31B7;
        Sat, 20 May 2023 01:25:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JxtJi3hBhwpTtngSb5U4jeq58G7L72hzn4zCicjDS6LV9QFpvTXBI4/1rEjdlYdc8S9gCGKBbAir9lVqvcoT01xJnREGU2u7vTXoCTkv1HFtlf/YxTeU9iDrXMOtiEZMbX243tAftOzrpucCj9Blm1oReAX6YamO8ogb2NAWtO2xi2UbV/GeD3hxHpPK+BhixNHECY8/7vYL7EoWwOhP6KyoBvLB/CUvDNauaZ1KHv36f/GU1fQN2quWvm7UtcB7e/XPe38m0rxdujHJefWYyA1ejom416g4dw1rZGHlCt9soy4DXOwWIklCkENUQ/LSfOQpL14bwVzfSg5nyi/k2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9eNvrY2hp/h3vECyAzxSh9+sFUGZVItUboxuIt1h9No=;
 b=Kumc+nQvucl7LR1x+q9OlT0GuvhDj8UjzG/vhhR7V5Et0/ELEfMEFPlofcZdVCWjqo8iRgfRn6fRfBQMB9DLP9Xnl9ejK2okzwAIAznq2I5OagT0p4hLIaPbUDUEZddyONIENhm71gub7XCYWJkoJE/UJ8GIF2/RPmbdVkSfw+GgvP1S8p2i+otF1fpKoILZu/wWtH3XI6Zul7kbZY7PsRk8QsmU5GxVpRCQS16EqZuvK8HsXOzMv9S9w+EoUPp4m7v9b3ew86lsRleXU9o24qq+QmzhNUh/yCzQCfpVhGWv/9ksmtxAfTgdZEq4+yearwkMQb+fG/ohbNj8cnq+bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9eNvrY2hp/h3vECyAzxSh9+sFUGZVItUboxuIt1h9No=;
 b=a5AN2cn3hB0D7EgfY7VKqw/644SFR7wxGt+GCNpPxReARk0iEebCEm9jCd/0IsMcMJB8hpKmGGlBkThNTgtuLunVJQ1kxu+dJdco1V9lvsnIsRwM8XhJVhhsEFjiWN+pPzf7+GC6tr+AYw/3F3Vy0ugpuY8RFX02Fem05cHmy8HDS8IAuFPibxj4zLena/cAMvTMYDsKR768qG0YTueDrpjJSGoArmYLeXMOhWm1oNPl+prHYc0Ful03ji8tHcC25+yXHWbjY08ATazRvF6QXG4o871tbUKOT4qn497qjGPX+Xw/DNkHHemluDsKCHMiGccdbWIuXdquQa2iEJAILg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6542.namprd12.prod.outlook.com (2603:10b6:8:89::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.21; Sat, 20 May 2023 08:25:54 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6411.021; Sat, 20 May 2023
 08:25:53 +0000
Date:   Sat, 20 May 2023 05:25:52 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] [suggestion] mm/gup: avoid IS_ERR_OR_NULL
Message-ID: <ZGiEEPXdAMnKqkqx@nvidia.com>
References: <20230519093953.10972-1-arnd@kernel.org>
 <5b071f65-7f87-4a7b-a76a-f4a1c1568ae7@lucifer.local>
 <ZGf1hV7iEQyqAim5@ziepe.ca>
 <1ca47b8a-292c-47ab-aa6f-ca24fdfc0d3c@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ca47b8a-292c-47ab-aa6f-ca24fdfc0d3c@lucifer.local>
X-ClientProxiedBy: BL1PR13CA0114.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6542:EE_
X-MS-Office365-Filtering-Correlation-Id: 12be1df0-fe10-4ad3-c8c0-08db590bd3c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gawYShv3vyavngNKkDPAtyshTTqJc5Pvbz5BXMicvFLrEIfWoYb1h5Pdc9zg/b8lEKFF0OBNC5AGiT6vO5/UAxpdwwGeYHLpcADu8qmZMxuHeKhxEUYUsV191EtyrHtKopz1t5hbvL0HXGB8Bx9Tsa5yMA8oPY801mcqKJxQZ+CpIlnHFbM8sgCL0KjyZGfu880MWrgM750m0Bixe9vxQ8WfRu7z2hNNRYyDaaEr+kOgsxbV1qvLKaLl+3TVGQLjwg4ugPstA8zR6cI48qkDcwa4hGOqT1J9QVGR15+EJQ57PGDUO1n4trPtPSJDJ99n/eAnEtILOl2njNkB4io7oZd4OOoHZkymUVTRwON89a7KsGaQ/mBq/dn503RcjP5ixuodbgUjVgo5f5v48FlUWn1jZfNriOh7BDa+vRWTE/ybbB9u/1QO2V51qMDv8j37zxdKQgBvtxzX0BjWjckaweUmYsGyiWMy7Z5TPbDA6u89mmnaz57YveYg0YNzb4IQdDOTYeUnzw6snhFJ6SGL3xAEnzrwqZTgsCka2Wygq8tGzx+9rqMHG08EmjMnuBql
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(396003)(346002)(136003)(451199021)(8676002)(8936002)(478600001)(54906003)(6486002)(41300700001)(5660300002)(7416002)(6916009)(4326008)(316002)(66946007)(66556008)(66476007)(6512007)(2906002)(186003)(26005)(2616005)(38100700002)(83380400001)(36756003)(6506007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+YVCb6CfRzbjlWJ0OzSt17NdufTAjKs59irVKXlmT8wr4GelbNTNEvq3JSqc?=
 =?us-ascii?Q?zGPgPrGTUJ9cyZPDc4zO715Xk8Ff6XWYo2dHFj5jw/crC236/Vtt58QTfqA2?=
 =?us-ascii?Q?nxt33/QyniM+rfdhvlNvS0hliXqUIe90CwtI1FIDti9pwUTkYq4B2caOQeu1?=
 =?us-ascii?Q?7fPlth+dzjv9ynBYrBu8dVPi4JwpB7Tz5vJdXw6ImU2W6Y5UAPI+LM9WdNbg?=
 =?us-ascii?Q?UhJw6vjd2+uQuU52Y1S2fKBT+bc/NdTJblIZ0FoNwIL0knd3iIj/aSZq6TAe?=
 =?us-ascii?Q?tq4O5nGKAjktLwP7wnp/v0H3Q4AqHl8ti83LcOA4NSr7Vp7gYQTmkSVXvkqt?=
 =?us-ascii?Q?6Z121PsOZJt9VdsSwZwWOb/X6fKkJTtUgPPF/IJ7ErmcN5IbYWy2LaIJi+wE?=
 =?us-ascii?Q?Op0oio2AHYBrlAgk4Clxo26A5y042Kh/zh+/shK732Xj8RAoa5IAmbmq4UQp?=
 =?us-ascii?Q?zWUHx07M0ist9EDVQgQSBYXyTcJT7LxCwnKeXA3SeIdqHS1c//jxCVwfKcBV?=
 =?us-ascii?Q?d+AwEP5TfoOPcJEdrDfNayQE6P7oZ+EpNRmyUDsgz8vc7M7oQNIykPblV+nV?=
 =?us-ascii?Q?szQBil2g3WsJJgd5wSSrEI7aSeilIUbixu5XvpfxSfGQAmiX9o8CT45owIhq?=
 =?us-ascii?Q?O6PEdqXu/jF3wGZJSW6xYAIZj4BAALf7f9N3QMtAXVby0C14+btMwqJRVy4o?=
 =?us-ascii?Q?V1XeJAbTnxup/jPsEWWPtrwHcL75o4YwENFjBUWfb2ua/JUNUQGXprKpPXzm?=
 =?us-ascii?Q?mhQEEoUANz+FMlKOQlwCVKNFDTBbrpzLC0poTHuVsX/yNx3ni0Uu63acssBh?=
 =?us-ascii?Q?MNux8n2ZIz3tz/Hmhhjdn/dHb945MSIG+qHQ0AI8AnKNV3TSNeNhw9BnoMsm?=
 =?us-ascii?Q?A99YZ03OT/Pwf0GDoqAigOOH14UBbPQ8ETM24bktyFZAh1kf63MzCj7jU00P?=
 =?us-ascii?Q?eiw/miGYlzciobIK/Rxnntf8rH3FW50scf7zh+V7exsviWIeooiKxZVm7hsG?=
 =?us-ascii?Q?yisxFKsmWeXycRRsvnuuDXksaM1VaD8ia7ky/+aiq1clP2G1jWEWcyiqVOfP?=
 =?us-ascii?Q?Wdpu7WZsmvmsm4tstOLnOflwpAICG6v+LEvUzQL42YXIoE1Ok4oYUt0oAOKA?=
 =?us-ascii?Q?eqyt7ZJDgmvGRz/MlUCam3PWxZHCRlaPQU4913CzW4du0ujnFNx8QQkq+mw9?=
 =?us-ascii?Q?jpuSesapgfXFtRB4LeO9bnTO+Bm4lVq/ZIY1+AgqF2rU/YvDXnKppTG29S6k?=
 =?us-ascii?Q?3RQptmqEJ/mzU9kiZnCaqIAXXNlCJoPyo3o73Eib1t38yucdWbwQBciL+mWH?=
 =?us-ascii?Q?vJQJawIeZQsyyXmLnAacv1Miz++BIDLWFg6/RoDcf3v9wTumxF2QUiSp/5CA?=
 =?us-ascii?Q?9eFwWW5x37lXekkH6PwurbPPNJ9TGwN2SpzwNviBaSzzp3n+gfh6zjwdzt1/?=
 =?us-ascii?Q?x182Ncz8zBQdPNynZRD9JTM/L0vXWE64SIS3i3redmSVVzBa2D/oawMLC3Ed?=
 =?us-ascii?Q?qCqpxe0RhG4D4e8IuhnucJCiibsKcz9FnB4mYmG5LoB+47Kap+2eJnXVw91D?=
 =?us-ascii?Q?Ksb5KchvZ922rOyg2BY4Zafdc7YKUbDBIvSxWsrw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12be1df0-fe10-4ad3-c8c0-08db590bd3c0
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2023 08:25:53.7107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WpC5RyqbWNlKmcKZ9I9sm+nYnerCOVP9R4OVmpr6ybTxNpAuVGZyBBY1acydzoqe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6542
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 20, 2023 at 06:19:37AM +0100, Lorenzo Stoakes wrote:
> On Fri, May 19, 2023 at 07:17:41PM -0300, Jason Gunthorpe wrote:
> > On Fri, May 19, 2023 at 03:51:51PM +0100, Lorenzo Stoakes wrote:
> > > Given you are sharply criticising the code I authored here, is it too much
> > > to ask for you to cc- me, the author on commentaries like this? Thanks.
> > >
> > > On Fri, May 19, 2023 at 11:39:13AM +0200, Arnd Bergmann wrote:
> > > > From: Arnd Bergmann <arnd@arndb.de>
> > > >
> > > > While looking at an unused-variable warning, I noticed a new interface coming
> > > > in that requires the use of IS_ERR_OR_NULL(), which tends to indicate bad
> > > > interface design and is usually surprising to users.
> > >
> > > I am not sure I understand your reasoning, why does it 'tend to indicate
> > > bad interface design'? You say that as if it is an obvious truth. Not
> > > obvious to me at all.
> > >
> > > There are 3 possible outcomes from the function - an error, the function
> > > failing to pin a page, or it succeeding in doing so. For some of the
> > > callers that results in an error, for others it is not an error.
> >
> > No, there really isn't.
> >
> > Either it pins the page or it doesn't. Returning "NULL" to mean a
> > specific kind of failure was encountered is crazy.. Especially if we
> > don't document what that specific failure even was.
> >
> 
> It's not a specific kind of failure, it's literally "I didn't pin any
> pages" which a caller may or may not choose to interpret as a failure.

Any time gup fails it didn't pin any pages, that is the whole
point. All that is happening is some ill defined subset of gup errors
are returning 0 instead of an error code.

If we want to enable callers to ignore certain errors then we need to
return error codes with well defined meanings, have documentation what
errors are included and actually make it sane.

> That can be a reason for gup returning 0 but also if it you look at the
> main loop in __get_user_pages_locked(), if it can't find the VMA it will
> bail early, OR if the VMA flags are not as expected it'll bail early.

And how does that make any sense? Missing VMA should be EFAULT.
 
> caller differentiates between an error and not being able to pin -
> uprobe_write_opcode() - which treats failure to pin as a non-error state.

That looks like a bug since the function returns 0 on success but it
clearly didn't succeed.

> Also if we decided at some point to return -EIO as an error suddenly we
> would be treating an error state as not an error state in the proposed code
> which sounds like a foot gun.

No, this returning 0 on failure is a foot gun. Failing to pin a single
page is always an error, the only question is what sub reason caused
the error to happen. There is no third case where it is not an error.

Jason
