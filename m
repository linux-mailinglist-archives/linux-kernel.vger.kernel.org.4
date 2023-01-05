Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4D065ED2A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbjAENhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjAENge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:36:34 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346BE11B;
        Thu,  5 Jan 2023 05:36:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7hDQdcHtfi5VnzjwGNcIDyeqx8brbhcLXq3ObFaVnrRfBNjvwBAapwLrXDQjYEXuPV3EFfruR/wShN01Xg1QGBNiHeT0lMvwpFasfxcl4/EPF2fBMaVC92d9ppFC9uxvFSsBSM4z9DZu7E6FESEg/p+Ap8tzVVq9GdCZfX0mAvuYlAKN/FzFTUiYqplmbapX/Y71zaSeq7gLcdrzQXcThMKCJKm+Os6xmHy3vGd1meq4HSjHi2nKpq1i1qhIdw5P3ov9Izl9tB9VfTIzMgMaGie3GkLitFTve9qgXG+FnTh9OVMHN+hLfnSxqGPj/2BV1vn8So5ayCMYFPZHsdaYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NC+LFFaMOCdg9cRENljPstI1mJeB6F1DxAsp7K/p2dM=;
 b=dSlKC/gfUbeEiVsRJTYSLmBZLXxjtTI8vkgmOY5X4xjTco9QUQ6dt/K5SEX9W3VwurXtW6brBzCKQjFVHg30jwwtEOZEecWErKmjO9La26WYLy2Pe00h2R3n+lgQmmJyrsRhg6wssiyrYBwwYrVxeiLm5D3YtlM1tgAPT0vXF2cZjyEF2qRpzMGXU5hpLmwfqL3d3wZkKB6zkAzDxdqEvuaxaq9UBNHCrk2zbilW95Uv2XCOKPrpZz8r5C7f6Cx8amMo6eUIgEAtPRnilrJtYfNdF7fWi7yJ5AiluV7Ksw172IGs34NGMEW2BzJ+ALx5UNm7ZoEYoZbUh5LYFvtgnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NC+LFFaMOCdg9cRENljPstI1mJeB6F1DxAsp7K/p2dM=;
 b=kOJiD0aMlILdLvLrKi67AHDihwWW/yghhiPaDBpIJFcdpufpkRHMOPufELmNMur4W6qK6n71W2cUqc8z1hprMaRI5Cf+rq/lHZ2OiO0XSpibzVAgT2L5BMdBgb+7vgpXumEv6HiTaBuizqATE32pai3j9SQzYq7RxsQgdJe4qleZr9w+3cX6LzHcwNykdiMeiJk/S6wRYh0EOJcFpPxBWUB7FfdV9Qt7cwmUYlW5Lhd5yerIaIneHmhrqAWxcj0AJjAZv/cYu9ghURcwxPL2rykd99Esh5rGpiTj65NonFOfNOFtXLnjLFt5EG1YhNqrStU70di+DlNurchx9tZ4uA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL3PR12MB6451.namprd12.prod.outlook.com (2603:10b6:208:3ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 13:36:31 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 13:36:31 +0000
Date:   Thu, 5 Jan 2023 09:36:30 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yishai Hadas <yishaih@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, axboe@kernel.dk, logang@deltatee.com,
        hch@lst.de, alex.williamson@redhat.com, leonro@nvidia.com,
        maorg@nvidia.com
Subject: Re: [PATCH] lib/scatterlist: Fix to merge contiguous pages into the
 last SG properly
Message-ID: <Y7bSXpw40dgWlRYn@nvidia.com>
References: <20230105112339.107969-1-yishaih@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105112339.107969-1-yishaih@nvidia.com>
X-ClientProxiedBy: MN2PR16CA0041.namprd16.prod.outlook.com
 (2603:10b6:208:234::10) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL3PR12MB6451:EE_
X-MS-Office365-Filtering-Correlation-Id: d794914f-4bcd-4cab-59e2-08daef21dafb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KRkYcfWMTvgmpr9o9QfSDy6OjYsplBDbm5HZK3IT1ze3bBbqLegmUCOARKfnUn/bouDUbioXDbENFTQOwPW1fwx1DfncDgpS91/5kVMB5ljUeEOLlL99LCKjltdb2A1EnM/bBWrKWjq6gUZ0R8KNBY8XKL1ZCDIDDAsVEZDVMrZHcATzWvPWNUuL236moFeGAKRknoxEhnB6c3wMvaIHd3Yv52l6eGs6djetUk7rOQpHEZr+hgnu0BBdLYBAm6XUqLvW/jd0GSkGnaTYwntTEtaBlb7nwXkzqKhn9jOFbrzPpaHW2hKV7bUc2IteUDLjj9JPs32UFtlDi5TjO7okU1VLo3omViYkXDrSzgsyLmOjYTpcGmK9xnZgrFCYzQOkqhSIZ33d5BS49lLnn2BLsq26G7fpfe8Xglw4Eq9vpWWDYNXI79uYkgXLxLyu30m9MNWoNvJzPBVQvVo3CKVMSLTb0LNFTf7xNQSw8+G+UW96d2ZQg4B5o8SzX974UMDXgPiAXY68TfBxK7sQtrIKkPPW7lnU+FA+jTAAJzCQU04JTQsbt2m/jRFhPbOoQO1ZykLnHNbc9UqbgRG6zTcMZo2GFPhfqjZ6DZ/zqy2OZcKpGVVkbmpbNDwG4evfNbHdjgqJMsq2qm91OEcIIvo6+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(451199015)(6512007)(6506007)(186003)(2616005)(26005)(107886003)(83380400001)(86362001)(36756003)(38100700002)(41300700001)(2906002)(4326008)(8676002)(5660300002)(6862004)(8936002)(6486002)(478600001)(66946007)(66476007)(37006003)(316002)(66556008)(6636002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fNv4xFpAfqQjzQVbumBKtqblGr9KT2CGOvKcR9AZxQS4rEPbNUP8O6kmHk9K?=
 =?us-ascii?Q?UnDp+VZD5Mp5kNcAHIRpaWkqbo+1WetDvVeOsKwO3TzqfJ/milve28f/B88M?=
 =?us-ascii?Q?h3v7J4bDN3GR/Z7qnxxHa97WWi5Cql0zG0z/HVOMHPOHxwYLdFrHE17yvQQv?=
 =?us-ascii?Q?FrUKj+ujfC8jFhX8KsX0bbvLBMWT5uLw8+v2vilqN43+818Ep0jkt5ISoPOT?=
 =?us-ascii?Q?AlkJ4Oig3muQTLcuJh0F0j6gJ8yJsWL/FXHnUMdCjETZUXjp4ap+GwU0E1GY?=
 =?us-ascii?Q?ljSwBRzHXQi4aNk0a8vR/6P5r76WWXhC/MmCD+mYgk/nZ6GJeZXI7RAZ8s3M?=
 =?us-ascii?Q?fuoGF6j2JxdkEioh3A4MQnXsnvgar1EBLGTLL/x+5psPjeITUeI8K9f/4r6y?=
 =?us-ascii?Q?SYBHrydb1hoFf25fM7+26MIUIkkHOIdN+Z7HPf7wlct9iAXl6tLSxJGPEtia?=
 =?us-ascii?Q?241TrXQEdSM6yNuZdobZqWqRgcbKV6pvtNLR9uZY9dg0yZDkhgxYrsl15rRP?=
 =?us-ascii?Q?Hzc4Byw1G3jLDMi+9RYsYMLOw6Kc8JtlRj88gFsG+BAsHWa2Kmnv4MfGrU6Y?=
 =?us-ascii?Q?xphAHhn//BslEBW+MbBcNyBNTYnOHp3h5tn7kLNgVQ8w1nzO9IXzVItpgfuY?=
 =?us-ascii?Q?BAM7G6KhJELGy4jP4zaecn3zZMbFFnDfs7F6oxtXoByjHPUiu7VYuz24uZQn?=
 =?us-ascii?Q?e3OzU+ibBi4fJwLTdJN+YM/u2OMe33AN5aqE4gyWlAY0Xjohdqq2S5rECMdD?=
 =?us-ascii?Q?T5pHrOFo9aEomR1pUPupRXPhV723yNjzJpZM9Ay/voNCAY+g8KbnczjwHbJV?=
 =?us-ascii?Q?uSy5QDI5tKs4VL4ROasZsmpBnNEd5ARddz/aW62nkoCNSUQl0eJNM5Rm6BfA?=
 =?us-ascii?Q?Q/2D9s1suBjR+qzMbXVJ/G3njfmNi6lmO/R7vCyGUvDC+5x4tzU/Bn1gmnjx?=
 =?us-ascii?Q?oh1sS2zSB7BmBVratWmodAB5LQcqbmm9gNOiHPYdPmSJZ/OL3vSKGnpxiNRE?=
 =?us-ascii?Q?3Wt4aAh3FKK5UE5OeKhDBdynDP48z8BXT/n5TxjS5oLOaPrg9dZ3kuw2Pd57?=
 =?us-ascii?Q?Vk5wZq1YQ+pLUfpVFzvqnfHUw9SgKSj/lEVO0QwM033rkP7SywuuiXQopV1/?=
 =?us-ascii?Q?bzbWs72RTQN0WxSoSvu3fKgbN6FHwKiTy/eZyvX0IHmPFou0gkLzCrTE4TC9?=
 =?us-ascii?Q?Z9XRh+ztQIS0/bzGNf7F0hzI87IemCkk4ohWdXwP6yHZN5peeg0XJ/vvm1fY?=
 =?us-ascii?Q?UQpOA6Im+wSXkN1tfL6Kdi3q/ZTPyckcEPtoGwuyfiqbKhxqmUKHtajSzWWJ?=
 =?us-ascii?Q?OEoewiTFHgMFF+RBJxNEpHCh5ik2UmQNbriB/sJQw2+2rp0bGol8K94dA/v8?=
 =?us-ascii?Q?m054iKWZuyKkUAaPOzBEyePP8FQkFkwWvWPw9Nhv79pldsgWvbRtWeR6fOTR?=
 =?us-ascii?Q?KJRiQDdg0/jCLwiw/IxKcoj2pY2oX+z2GRGSltjWELGOEAzGNdQQ7P1hXzE3?=
 =?us-ascii?Q?sEfG2vwjsgNosgJVpAQfjMHEKV2rLGWORuUEcHYK2rRGCo8prYL+sdUNuJuD?=
 =?us-ascii?Q?ZgimkHnjehZQraMd+E3g3+kbvtQ+zYdGuzUwuURC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d794914f-4bcd-4cab-59e2-08daef21dafb
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 13:36:31.4304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4VlADibi7jvu40s4o24U/FI2lvVZBcduX/7zszRchVPoQpVhognP5ZPBETv1KCet
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6451
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 01:23:39PM +0200, Yishai Hadas wrote:
> When sg_alloc_append_table_from_pages() calls to pages_are_mergeable()
> in its 'sgt_append->prv' flow to check whether it can merge contiguous
> pages into the last SG, it passes the page arguments in the wrong order.
> 
> The first parameter should be the next candidate page to be merged to
> the last page and not the opposite.
> 
> The current code leads to a corrupted SG which resulted in OOPs and
> unexpected errors when non-contiguous pages are merged wrongly.
> 
> Fix to pass the page parameters in the right order.
> 
> Fixes: 1567b49d1a40 ("lib/scatterlist: add check when merging zone device pages")
> Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
> ---
>  lib/scatterlist.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Also, I'm looking more closely at '156 and this is not right either:

-               unsigned long paddr =
-                       (page_to_pfn(sg_page(sgt_append->prv)) * PAGE_SIZE +
-                        sgt_append->prv->offset + sgt_append->prv->length) /
-                       PAGE_SIZE;
-
-               while (n_pages && page_to_pfn(pages[0]) == paddr) {
+               last_pg = sg_page(sgt_append->prv);
+               while (n_pages && pages_are_mergeable(last_pg, pages[0])) {

This change will break things like multi-page combining, sub page
scenarios and maybe more.

The contiguity test here has to be done a phys, it should go back to
struct page to check if the pgmap is OK.

Can you fix it as well?

Thanks,
Jason
