Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEBF65F16A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 17:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbjAEQtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 11:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjAEQtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 11:49:14 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A417B94;
        Thu,  5 Jan 2023 08:49:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBlFFwPLQO/1TFReSPwfNLv3MywTb7SuI/SAggATRPHQ/wddtkoOiAuqM4hLsGOQet+kh0s1lnMFltUY9nr5xP5W0VopPwwwhR2Dusq5p6G6vAR6tOLihmlWmzWkpXa7SuUVNsec4qY2VSAFJc/YasR/psr85P4BbDeNFkcC5xFzIr5V0O/9LDgwR63XEfg+vX9l38qvFyKD7Fb6nDxV/NOX9R+mv/DwGwi5wUqWsLxCPckMHWKjU8DFeJ3/GQWH6eV9B+ozeqk7Z3G1D7rdxqBQy741inUFkGecQPJRy7juq+dUzN6A10qOmdir9If9v2trTh5PQ5fpXniSLFBdow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46HH5jU30E4uMtkSMdWxGR48qFBI2bk7uI63FWW7Pnc=;
 b=JWG4CxgkrQ7yJYoEhfMzqiC2qiacHi3k8c3t+fVh7s+MoHRkUfi7lwaAstgMPi6VeQk6OCGbubUCNrzTAe5sCNtzZHCxQZruUDH3pzAJtWbvTOMBDe0cqNTkHOR8IUCDEwF3jtH8YBDW0W7KL28CmwbxwIvjrBys3nVR94gwfy8CofTi+iYRgOGJgu/TLTKlraOWmI/xCwLZXu8Fos5SWB0FR63RM1XOMFc2eK0IvWDM6T22mclTv162lTZY3Y9pFgDom9k+JCfp3Q++GFYv0jfa14x8jp1CDY7Fja9cf2Ucl4grXh5rKFrhE/1GZhGtcZLOJQz6XLWBC0CLCGtYrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46HH5jU30E4uMtkSMdWxGR48qFBI2bk7uI63FWW7Pnc=;
 b=O5XJelbJoWlO04Gpwu4PWEfkKXLoR2zn5bsdw+TYJAlWcyZ7lvmR/DyZkuFIq76VN+I6MhNSEk2sWn9MHo1QKOlFT0ox4U/naJcyBOTa2etzkP7pY5Yq69IPJEDf8WENiDVMhZg0sZhjQm+UXXQOzlyTES0qEEl+nPcwLNqF7bL7fHTAdaM8+D30nJdearztkNMNGw694Rch8zhHyp/Eunft0woNLeGxCxbZ4aUIxzTqZp5v8w9Ap5T1peKjZlijiyP0AGdQJ+NiWAa1NltmmasMzVmtzYn8OlxO8JUf2mP1iO2RDV6wHE4kTjbXHZuhnkz3sJaSbKlK4Xrt14F4aw==
Received: from BN9PR03CA0691.namprd03.prod.outlook.com (2603:10b6:408:ef::6)
 by DS7PR12MB8347.namprd12.prod.outlook.com (2603:10b6:8:e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 16:49:11 +0000
Received: from BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ef:cafe::f6) by BN9PR03CA0691.outlook.office365.com
 (2603:10b6:408:ef::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.15 via Frontend
 Transport; Thu, 5 Jan 2023 16:49:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT010.mail.protection.outlook.com (10.13.177.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.17 via Frontend Transport; Thu, 5 Jan 2023 16:49:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 5 Jan 2023
 08:48:55 -0800
Received: from [172.27.14.162] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 5 Jan 2023
 08:48:52 -0800
Message-ID: <3b48a6c7-7834-6ca0-db85-df3c23ac745d@nvidia.com>
Date:   Thu, 5 Jan 2023 18:48:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] lib/scatterlist: Fix to merge contiguous pages into the
 last SG properly
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-mm@kvack.org>, <axboe@kernel.dk>, <logang@deltatee.com>,
        <hch@lst.de>, <alex.williamson@redhat.com>, <leonro@nvidia.com>,
        <maorg@nvidia.com>
References: <20230105112339.107969-1-yishaih@nvidia.com>
 <Y7bSXpw40dgWlRYn@nvidia.com>
From:   Yishai Hadas <yishaih@nvidia.com>
In-Reply-To: <Y7bSXpw40dgWlRYn@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT010:EE_|DS7PR12MB8347:EE_
X-MS-Office365-Filtering-Correlation-Id: 301bfc73-1c2f-41c3-dad3-08daef3cc527
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kXprou7LtqZKhBapJZ7jh0Kc0Nb7PliXo3stHLdb5P8pwLRf+E2q7DL7olvNwCtrQk8W15INd24DPG6qVrKccOivhoaW2FmAvK4zHuJIapU0Sh1JBrONAO6ZUObKjVWdaEKpWsGRoq4kbRgZ0y/389FWR32E6b7bI1i4dywavkeaMZ+05DzVJ/SDJNqT+2ezctOs9lYFeHCEmqLw3w8fe8SQRj8DOkGOb4UJRx5THJaei4sT9i5G3CVpZ8eEVxAWXx2NqysUUkxCodQLHQqWHeRxOhJ8Pj1buaCfYbyWDw7XZMVQFDLXXQtHGk+i+H5SyNufNKYJEU8bYztRuH2aPCVu7sIOHJYfaEFUSzXsBHEsU5TT8x6u1E+sEAreoN5uiJVqaxcWdp4eMv7uoxycVLR2NQijKAhkQh7qxgKIRQWNASL+I5UA1X9Z420StuefZ308hSiScsEyD67S9Vv+jYdt5rBh61LqawE4HMr4Wyl2HMTNmhz/wvFYAp8f3W/L3Z/xTAMKSFqsNCEPzO769dVaXv2gOjTZBu3O5Cgq91w9iB9qaPNB/isBwSvppR8E8msmVdJOk5DVTbXpJK+v2zAuW4zlHOHLIhDSzRaEt0rHFLCmt25AzjBtNiOe0WwUIHqq9mslru4GfE1wrWFcXSXLw9hlT+LrKSwn/M5fqMly+x/llEvnvVhUSJyxe/+kmKxFs/E5O78zqVp7cU89vkmAgsT7Z6fjRg8FvnTMtQg=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199015)(36840700001)(46966006)(40470700004)(70586007)(5660300002)(6862004)(8936002)(41300700001)(8676002)(4326008)(2906002)(16576012)(70206006)(37006003)(316002)(6636002)(54906003)(31686004)(478600001)(2616005)(336012)(186003)(26005)(82310400005)(40480700001)(16526019)(107886003)(83380400001)(426003)(53546011)(47076005)(82740400003)(7636003)(356005)(86362001)(40460700003)(31696002)(36756003)(36860700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 16:49:10.8646
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 301bfc73-1c2f-41c3-dad3-08daef3cc527
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8347
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/01/2023 15:36, Jason Gunthorpe wrote:
> On Thu, Jan 05, 2023 at 01:23:39PM +0200, Yishai Hadas wrote:
>> When sg_alloc_append_table_from_pages() calls to pages_are_mergeable()
>> in its 'sgt_append->prv' flow to check whether it can merge contiguous
>> pages into the last SG, it passes the page arguments in the wrong order.
>>
>> The first parameter should be the next candidate page to be merged to
>> the last page and not the opposite.
>>
>> The current code leads to a corrupted SG which resulted in OOPs and
>> unexpected errors when non-contiguous pages are merged wrongly.
>>
>> Fix to pass the page parameters in the right order.
>>
>> Fixes: 1567b49d1a40 ("lib/scatterlist: add check when merging zone device pages")
>> Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
>> ---
>>   lib/scatterlist.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thanks Jason

>
> Also, I'm looking more closely at '156 and this is not right either:
>
> -               unsigned long paddr =
> -                       (page_to_pfn(sg_page(sgt_append->prv)) * PAGE_SIZE +
> -                        sgt_append->prv->offset + sgt_append->prv->length) /
> -                       PAGE_SIZE;
> -
> -               while (n_pages && page_to_pfn(pages[0]) == paddr) {
> +               last_pg = sg_page(sgt_append->prv);
> +               while (n_pages && pages_are_mergeable(last_pg, pages[0])) {
>
> This change will break things like multi-page combining, sub page
> scenarios and maybe more.
>
> The contiguity test here has to be done a phys, it should go back to
> struct page to check if the pgmap is OK.
>
> Can you fix it as well?


Yes, I have locally some candidate patch as you asked, on top of this one.

I would like to run some extra testing on, then may send it.

Yishai

