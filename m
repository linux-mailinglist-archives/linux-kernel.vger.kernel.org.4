Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EABAE664419
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 16:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238398AbjAJPHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 10:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232868AbjAJPG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 10:06:27 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36745DE41;
        Tue, 10 Jan 2023 07:05:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+Oe/NSZ33t/E3imzUysXjDhbnEPmStPVzOHalf4Xq2x/lS8WdGnseAdHPlmcvDxGhZnRZJmd4MFk9V8YowqdWrYKZvaUiGSHWnWEyIhCTsYqvYhdb0u9brROLpyvKVclXYNqKMJzEum9c0DhsIXKQFMZUHYsZcDN+J3rJSezJQfw3YQEqvgM/HYUijAvRcBI0seEAw3xAJkoV2eDFjnQW4ITxbgy8gA9K8jfYhH3PBO+gkLBZ7KM6TbV6xVyPxs0WnqH7qS8e/ylCxyXvHqFlv8YPGFCpJBMDHzmUe3QriA4CyK2YjoY11M1gIO+N1lM84kfJyazcLKaT2Rz/jxTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JXaenE0g/bxCo6iCoIj6qbxB9z3c0x9J0IBL/T722QU=;
 b=gmzz1GTwxufj/faDwJxWe5Q0MDRK0jCwrNAmaDP1xn+JhWHpRgOrzHlWe/Ze4JYdQbRys4qOG6/mk63Fs3jkp7oNIwYmqU2AGgOIzECFSEfeDvtFRI5HeU/kjbBMYIPhAXex9d9LDaFwHhF3kpqYJ5L/+K27T2TZejjSDPw5QxF8E61r8gLeWdG5qcNM4aDdJydulWfSgq8Ce8dod868WeaX1HbX58WVsPYM9A1kFs7JMmvApv+WcQijBSeQ5C61LMnNZFY0IIgX/yNOuXJt+eUL1AA3xLIJZnVYgEoneSu/gPhNudWCd/BjEfzMDbnB5LHGyGghlMIcqYm+VY5n8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=infradead.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXaenE0g/bxCo6iCoIj6qbxB9z3c0x9J0IBL/T722QU=;
 b=P0nZ7N0E/FsoaCP6PUjxSu1ueu6BSohFZgcUr01RBdVkusxxsGNZPT66wzBgRc6HrHy2nfIq4S6nfVLlmvTTACL0V07oqRC5u8FP5KGldOO0VJo2D4u60EOUPJUCkC7jIAAp0QwdzjFuEEJ68aV6VWzygIW5pHAanSk5Xg+fJe4MemWZOMkoYCAlPozOgeCFf+KTg2c1i7+BT2czisZZUIkHqdjdqPZqGGs68fdBWkLgW0Oh47BBq6UvJfYSzZ4bX2T4DvXtuENz65pR7vLhLeI/64jdPXU8bMlgProg8yFmP3Unc0zK7qDj/3PhvN1AHR41OJ4Bl+zmMl8mVRtRUA==
Received: from BN6PR17CA0055.namprd17.prod.outlook.com (2603:10b6:405:75::44)
 by CH2PR12MB4118.namprd12.prod.outlook.com (2603:10b6:610:a4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 15:05:27 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::d1) by BN6PR17CA0055.outlook.office365.com
 (2603:10b6:405:75::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Tue, 10 Jan 2023 15:05:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.12 via Frontend Transport; Tue, 10 Jan 2023 15:05:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 10 Jan
 2023 07:05:12 -0800
Received: from [172.27.11.35] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 10 Jan
 2023 07:05:08 -0800
Message-ID: <e4d40ba2-658a-8390-248a-1ca754f320cb@nvidia.com>
Date:   Tue, 10 Jan 2023 17:05:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] lib/scatterlist: Fix to calculate the last_pg properly
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-mm@kvack.org>, <axboe@kernel.dk>, <logang@deltatee.com>,
        <hch@lst.de>, <alex.williamson@redhat.com>, <leonro@nvidia.com>,
        <maorg@nvidia.com>
References: <20230109144701.83021-1-yishaih@nvidia.com>
 <Y7zyyTxdoJulq7OD@casper.infradead.org>
 <a1f3b6ad-7173-70c7-4361-d01f9af1b7d6@nvidia.com>
 <Y71t3yyFvdLXM+qd@nvidia.com>
From:   Yishai Hadas <yishaih@nvidia.com>
In-Reply-To: <Y71t3yyFvdLXM+qd@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT016:EE_|CH2PR12MB4118:EE_
X-MS-Office365-Filtering-Correlation-Id: ba42e1e2-98b2-43c4-2362-08daf31c1b51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6U7IHeH3bDU5mKdbkZ0gm02dj+bRUUqLbGXrayLevGKKZUkuTTGJ44AuTRWK8aYg7MMJ3c0wsycisWqI9f6C0iPfmLQJ4aApwISUMzza5AkAjmrFqwOdwljwl2og4oJnHOBUaxSgu3+ciTOawQSJEWRlcQSyA3UfDStemUIi0fWpxEelSILAhwCzg3Jfsm/79+OYIz7u1C0A3sVLXoxgqb9B7DC/3Zs8cAHCSzJ+Srw+pnUnL3bczLg7Mbgf11pakEKHVb5G3S1q0R4aFLc/QtMrF4b/pUa7V7XGmS2wsLe1OdCSCRmyl19L6aEK3S5kykM5ODSFf5M8N+Io8u4SGdYDcuYA9VwLDjGhdXiRZWvfSjRitLTyU2zEJQpmljzixi2lfOYD+pRoiDC/5JBarAGsm6dMxUVWJpx3Id1DVUrUQXs+J+FokGP+4MP24N3KEy74BbdNXTNle/dqQQm5RjUjfE+D2ZsGkNqg+zLcLQig/pQ76i8grHta0nCQT+0Vi1isXHL6hEFv5GVEaRW1vYJauOfgTyz6i2FbLj1nXC/3nfTSTtpNhoxdk01NjTOc9Dir9lwjkOuAHKCnxCj6+8mFBygXxb9qTBoLD1mUudSLLw8EdyA0KgANGnB0fh05sxZ6UkSEHkc+e9R/C1O/DXLCqw0vAbxrA4YJmT+XneH3en76OZtATEAneVRfzPiIhkih9nPj0LjutOhtpywexPkWSNfpRdZErj0dagiMRVI=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199015)(46966006)(40470700004)(36840700001)(36860700001)(82740400003)(2906002)(53546011)(31686004)(107886003)(7636003)(356005)(2616005)(26005)(186003)(16526019)(40480700001)(478600001)(316002)(5660300002)(82310400005)(6862004)(8936002)(37006003)(36756003)(86362001)(47076005)(426003)(40460700003)(31696002)(41300700001)(16576012)(70586007)(8676002)(70206006)(4326008)(54906003)(336012)(6636002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 15:05:26.7251
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba42e1e2-98b2-43c4-2362-08daf31c1b51
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4118
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/01/2023 15:53, Jason Gunthorpe wrote:
> On Tue, Jan 10, 2023 at 10:01:53AM +0200, Yishai Hadas wrote:
>> On 10/01/2023 7:08, Matthew Wilcox wrote:
>>> On Mon, Jan 09, 2023 at 04:47:01PM +0200, Yishai Hadas wrote:
>>>>    	if (sgt_append->prv) {
>>>> +		unsigned long paddr =
>>>> +			(page_to_pfn(sg_page(sgt_append->prv)) * PAGE_SIZE +
>>> 1. page_to_pfn() * PAGE_SIZE is spelled page_to_phys()
>>>
>>> 2. physical addresses have type phys_addr_t.  Oh, wait, paddr isn't a
>>> physical address, it's a pfn because you divide by PAGE_SIZE at the end.
>>> But you will get truncation on 32-bit, because page_to_pfn() has type
>>> unsigned long.  Anyway, this shouldn't be called paddr.  Maybe last_pfn
>>> or something?
>>>
>>>> +			 sgt_append->prv->offset + sgt_append->prv->length) /
>>>> +			PAGE_SIZE;
>> In this area of the patch I just reverted to what we had in 6.1 [1] where we
>> were good.
>>
>> I can send V1 and replace the 'paddr' to be called 'last_pfn' if it's really
>> needed.
> Please change it as Matthew describes so it is clearer
>
> Jason

OK

Once cleaning the code and renaming to 'last_pfn', could also see that 
we had to use below '- 1' instead of '- PAGE_SIZE'.

The expected diff compared to V0 can be seen below.

Will repeat some testing and send V1 once be ready.

+++ b/lib/scatterlist.c
@@ -470,18 +470,16 @@ int sg_alloc_append_table_from_pages(struct 
sg_append_table *sgt_append,
                 return -EOPNOTSUPP;

         if (sgt_append->prv) {
-               unsigned long paddr =
-                       (page_to_pfn(sg_page(sgt_append->prv)) * PAGE_SIZE +
-                        sgt_append->prv->offset + 
sgt_append->prv->length) /
-                       PAGE_SIZE;
+               unsigned long last_pfn = 
(page_to_phys(sg_page(sgt_append->prv)) +
+                       sgt_append->prv->offset + 
sgt_append->prv->length) / PAGE_SIZE;

                 if (WARN_ON(offset))
                         return -EINVAL;

                 /* Merge contiguous pages into the last SG */
                 prv_len = sgt_append->prv->length;
-               if (page_to_pfn(pages[0]) == paddr) {
-                       last_pg = pfn_to_page(paddr - PAGE_SIZE);
+               if (page_to_pfn(pages[0]) == last_pfn) {
+                       last_pg = pfn_to_page(last_pfn - 1);
                         while (n_pages && pages_are_mergeable(pages[0], 
last_pg)) {
                                 if (sgt_append->prv->length + PAGE_SIZE 
 > max_segment)
                                         break;

Yishai

