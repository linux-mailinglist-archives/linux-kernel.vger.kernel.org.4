Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D6370A2BA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 00:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjESWRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 18:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjESWRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 18:17:47 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388031A6;
        Fri, 19 May 2023 15:17:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ws0Mp9J577p71qTPdAIG+g/YiFc8VjOSp2kXp8CFYCrb0YZO4VxmFrEigU86K6J5Ssy/LdqkqvWjiBD/ITg8ycflKlr7fsXcgaB+Qdkm0Jn53214Gl1QyaBpwFL8NOuMdq96+HJDSyGdi2sjeD26E/8axzF1qZXDE2mb+RIk8SG3luzjiFIF1H7/Jp6GW/gOJrn5roG48+9/5hiJg4ObdsT7lDTcldWluSxuXS3iQuiKt6eCjYXvT0weNA5LJLVFHrxVYcVxp/CzoyxROk6m9OGqBAUZotV280EIFmhdlzMFbmo+dGTbt4ri1zjC6NE6YZpFqMUg4qiUfQDwjZ4yZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAUCDhbQEZCGF/ilN2dz/+jkvUPOVL2p3y2QDCccWYM=;
 b=M7HhtE6rj48YWDBTX5c4mY918dBGRGbHPTF1NeYlKw384K6soy96Zz7ZT0/6Apj/gRzRZIBDOmJI/IUVaCCzQJUdc6bXW78DgQsyX4E8Xb0HsZ7oDpImsbU+J+A9BkIx+6To9CPvIATAmOm15qFi0aH0fp8mZ69wiqCIoRm8PS3G3xy/sH6DRNWbGHqsbsgHbcDKKgSeHhcjPJYTiQmxeNxs1ocZ7L18JMYE10txyhm1IAtxCjxapJRJTG2ABlUXT+XmiM0/udamhg2l0DfmOIk5PecMhzEI3mcqAV2ztK+caV/1rFIdDUfZoZueQQHKNB/TWs4uqNiCeEheFsFbrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAUCDhbQEZCGF/ilN2dz/+jkvUPOVL2p3y2QDCccWYM=;
 b=fk4gZr4cnvCzmOpbS/J3nmWaCt9+DpLk7a8bOx7IXqUz4JO9idwFlAgp1xVIfXRHjbuKxwjA1bCucVKZCoS9kALFnIa2nR2l2fcnxOy22eoEzMdjSKFFZu86EGSH8DWfx4yFXSMdnFGezWqlHXTjjF92eGVQj1Rr20lr2Y0GpdkPE9luNTbV8Jp/Mq8Ix1dGZyN7CJTjuvHiJ33oD6jHKOYkaPKnagJ7CmaMXh48J7Zk7XaZndRW0DwyVlYWlddNoOqtMtzk1Z2ZCitOXFuxSF96XphCPprw+vcBnndk1hvvjZ7FNXnHHFo35HNrDTGHdEDqBmoUYAWPjopx+688BA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6531.namprd12.prod.outlook.com (2603:10b6:208:3a4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 22:17:42 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 22:17:42 +0000
Date:   Fri, 19 May 2023 19:17:41 -0300
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
Message-ID: <ZGf1hV7iEQyqAim5@ziepe.ca>
References: <20230519093953.10972-1-arnd@kernel.org>
 <5b071f65-7f87-4a7b-a76a-f4a1c1568ae7@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b071f65-7f87-4a7b-a76a-f4a1c1568ae7@lucifer.local>
X-ClientProxiedBy: BLAPR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:208:32b::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6531:EE_
X-MS-Office365-Filtering-Correlation-Id: d0340a27-a15f-4501-fa6f-08db58b6dd57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XPgdFJoTqg/lP7R9eAYEQ4eUGXekVkVBNxYjhWSG5t2GZ5E5qHAq/GzKF5niB3RcQ04wYDdCMuJHrNlJd6X3OuUjidqtR6CoL7PSc9j62lhMpZk0arHoBTyQ/QX/UImEXSu3uv3JdVBcIzofBH+FM4ZnncIxNAf9lhpNFTEH0m/iKOS3rst52R1aEvojwbXzROBnHT9YTL/X31GOCZ0I94Q8ctdnjZQvgmAARc54HaRDLt8iE2tAQdKwEmJw4o9hQG5jK+umB9fWLbcjgzotEl+gxGYLVflIWL1l8fHhFrY0IgKstjyg7DtOzrC0+wjsZZlRt6uFQ8IO6vLZ0woD4BkPPORoEjXiF8/eRw3F//YZfJMC5XCNwAW44u9YKirb9kxyI6THu7xE3wAPocs/HMxnlNvFawoOJzf6csLSbKKjCnyDUrBdVdRAH/ypNRbySGBLydg1cBzd+fqloPQdvnaaMwGrx4R7pp1PGAL5FkQ+92IN0nSDTmHAOHcbnpwq1/sVCYjX+rnEWHJNvhvLyZn/jlp//BhtwqIQctx5syz9ZVnqA+OpJcl405CuA37m
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(366004)(376002)(451199021)(66556008)(6916009)(66946007)(4326008)(66476007)(54906003)(8936002)(8676002)(478600001)(316002)(41300700001)(6486002)(2906002)(86362001)(6512007)(6506007)(26005)(9686003)(186003)(36756003)(7416002)(38100700002)(5660300002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WBS4gFEXPgyxJiS+LLiUGHQIp5ERAD1SJmnrj8pmYg5vaBYmvrM+w+1Lfjy2?=
 =?us-ascii?Q?nXSAeSNfgz7MSzVg1eXwCfB4rApYaxcVGNkBvy4F0UUjmYMqDasYnuvfZpDl?=
 =?us-ascii?Q?s3Ytaz0tK8exCWho/ARc0uRTghIBTyQvcPnaNkWgKsvXyhZGWgwzRXuQJ2em?=
 =?us-ascii?Q?XaMMuT6CH/JQqIYpHp43fpoOOevvf/gbHjgQi5mtgZD3wq7vJ8Rx3qlNH0z3?=
 =?us-ascii?Q?qxKn+J70WIJVIFVaL8mtcG4bdpVsEYygTlasFDnzgjCF7yn+F6psmc7U41j5?=
 =?us-ascii?Q?DSrGJmLBoh4NvTKC3Hk4qB3SlzBu9Exsy0mP7RB9NS49V1m7F1KFqsI/+as4?=
 =?us-ascii?Q?DJwwiE69d1Ifrw4dovWLzVZbwE2Q7tRbOYBkyQE3WHcO1UqftyOsGrDR2yAv?=
 =?us-ascii?Q?EYO+gJj3W133oZriDEeQw9bG6GNKt+RVNkyfSoRFjm174fMpWfUc1toU4oL/?=
 =?us-ascii?Q?a0i4ZHqG3/jHttuNaMfrjgz6j4gX5q+kBz7D3d1vVNreNSkFBocpXc+WPwVH?=
 =?us-ascii?Q?YEjX9FENdmfDnpBIBGk15Ef8GZMqeQmxlcy24YHnohYHRhd+03Wkuo/nKDCj?=
 =?us-ascii?Q?aDTDMpyHLi105S3nug+VLp2Uu/83zhSFbpbn8HNRaFpUZ7KP4F1AbqLQxmcz?=
 =?us-ascii?Q?AlEylOPAxnqeXWXmtCtV//jqLDw4hnBX4fhH9tNmyuHh4xRqzwqjztGlmmZW?=
 =?us-ascii?Q?FT/H2gHxIRqTIt+7tPxlr6Igxd6KSrpceDdQwf7RPwD98YjDGK5+DPNX4Hmj?=
 =?us-ascii?Q?oT9Mg2ty/UAlTkMXL+o/wNf76UBQKxWWKYdB0fQ7L4Nz008Os6aus+w1mVTf?=
 =?us-ascii?Q?a3tQ8KejuwaQxJXkiVsga2vHuw8kEpdIF7RPbDmVeBeXP96q2fUxiEzJenIa?=
 =?us-ascii?Q?GpNMDbwETVAu4DRGxaq7BI52vEddqKGvEt1uK+5WS8CjKJrYGHy/inJscX61?=
 =?us-ascii?Q?SQO7HYYJ1aOFaj9fN3ksO+sVoUR75lryab05yVymi/sN98swbCUpdERk54u8?=
 =?us-ascii?Q?sFKnt61Jp2+nYqRlBZkeiI5CQbIaHcSRLL/Lqk/l4tYk3PMJM5v8rURbXuqq?=
 =?us-ascii?Q?SGMXeYar9jCl32SSHyaW8t3kXAaIav0qel6t9C0PGZN0099a20gNLtsuiTT2?=
 =?us-ascii?Q?r1no4KwVJyeNYDhW4PrA5AM/sIMyoWnLOKWr4cseluKyckSKNIpOHNTlYF9D?=
 =?us-ascii?Q?1gf/g6hgcATFdJsJLzR/SDE9ivVxhmUZFa2Yj+wgTLfQUf9gm40IhV4vkAHU?=
 =?us-ascii?Q?nfHKQkctrGSNUVsb7FNf33JeUFkwljkvtY8tXJEGEpd8MN9z7YhTVv9UEXEk?=
 =?us-ascii?Q?V6jYaNzSDXSWZ0NM97Ye9faOmiZBZrpaM1026jaY+RTw16tlN1dsgFauDtMk?=
 =?us-ascii?Q?u6+ZCwmT4FwNuQLZAVQc574b2/j3sfj5SZlVUmx1K2/xjOJ1XdftQwDZOwmM?=
 =?us-ascii?Q?Vwc3onsoa2eUNCh8InFVDQ2+jFa+L0PLGfE6cD/zzPuGBgEFVhXb//eRo24w?=
 =?us-ascii?Q?aFSJAZ0rzHwco+9DBmKfVkD52Dlm0/SGbDh3SzhvkHgvSH8SQLr/oOi+0YGY?=
 =?us-ascii?Q?eqMPl/XwOZvrwu1fvCnV6kfMBFL6FbUyocI93C2e?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0340a27-a15f-4501-fa6f-08db58b6dd57
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 22:17:42.6361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q0P9p12xOp4wrFK2BFeijMBPS9Vdx1WNriqSI9clhhKOuVU3RBx8gbW7lqJahQgB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6531
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

On Fri, May 19, 2023 at 03:51:51PM +0100, Lorenzo Stoakes wrote:
> Given you are sharply criticising the code I authored here, is it too much
> to ask for you to cc- me, the author on commentaries like this? Thanks.
> 
> On Fri, May 19, 2023 at 11:39:13AM +0200, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > While looking at an unused-variable warning, I noticed a new interface coming
> > in that requires the use of IS_ERR_OR_NULL(), which tends to indicate bad
> > interface design and is usually surprising to users.
> 
> I am not sure I understand your reasoning, why does it 'tend to indicate
> bad interface design'? You say that as if it is an obvious truth. Not
> obvious to me at all.
>
> There are 3 possible outcomes from the function - an error, the function
> failing to pin a page, or it succeeding in doing so. For some of the
> callers that results in an error, for others it is not an error.

No, there really isn't.

Either it pins the page or it doesn't. Returning "NULL" to mean a
specific kind of failure was encountered is crazy.. Especially if we
don't document what that specific failure even was.

IIRC if you look really closely the only time get_user_pages()
actually returns 0 is if the input argument validation fails, which I
think is a bug that should be fixed.

get_user_pages() never returns 0, so get_user_page_vma_remote() never
returns NULL. Until we get there collapsing the 0 to EIO is perfectly
fine.

Jason
