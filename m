Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971F5663A5F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 09:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjAJICv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 03:02:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237994AbjAJICO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 03:02:14 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F20D1AA3E;
        Tue, 10 Jan 2023 00:02:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y4u9m0vbNZGlFphIROXaY/jNw1alWhbZXuk+pStv9YbWEPDLari6aNY5cs0Hbjz7jbBkp82NPV5QDyM/tnd7N/NQxppTKMl34y4wG7RTZ/ba2a55+yVdMK10nLSnR3i0g/SOUWMOYbxFfMqHl4UU4Vr0piWWb06lTdFvTIMH3K1HOXYx9KrmZpbMSj4HNwp3aIxFg4EYvB3tJTe8/o1Bl0GctIRJSFLQlGLD03j8uX0mLHEy93+rJFX4Zvd2iFI2tLstRLlxOUITDjfnKlmya2PxHPqz2p3mLxz18Pl8gTyo3e5+ltPyNUsbgCB1oeXwDEWSzL52/OQyOLqpf8A55g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SpVoExkcuBcuyoHuL2v4vNLFRvU8SOXJmnl9zJJ8cuE=;
 b=T17+JOG3Dtq3HWOJ+jvUagUhLKWM5gHig1yPp6MXlKVB8D2UyeW/LwKYn7irepKv+z3NrRCNhtp+zA9iBM36Z/OwKB2nMIc1y+5mrdIblweFwaRdKql9oN8QsCP8mIUWd/zhK+D1odWRNZ/YnprjZeayOoMOK+cODoLGiNfMAV2vC7PVpbL7wug4HuFHa9gn1KOWLD9cGUp7MVtK/ZDySAIY6I/sFk1Pu7E/2FrfB8IunMCn/6MITzH+e2a8StU16XSjqMch+zpsMI2wa55xsFMglztoRIVJ3gQ3kDNS+DsEgc7iLu2QwGg9uKkOBYltBtqtFbzBWxNQsLXJ61Bsvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=infradead.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SpVoExkcuBcuyoHuL2v4vNLFRvU8SOXJmnl9zJJ8cuE=;
 b=YwXrGnD4a7aqwt+Eb34R5IeSJsTJOjBTKC5yJoiCEfzRPmTreu1G80198ZxVp6GNocEMAD00iujtBnSUmCQk2HZLeA8bbUpvcPhuq0AFbze8LdfMmrvsmwKLLUg8f6uPBsaaEt5Ng3fFuNnSRsmu/GoZn29zE76OeXl2gMdyBMiAKepF5T6USfN4Bb7v+NGULTyPMuLL65rgipxcitXIpBp11WMHpkL/lfXLV6eajkosz+3vFLLBKlBCkJRL7L9Ri4rVBt18BkLkyYBk/k7Okno+FqA//mP4TjjvWtX4Cj44RBSm6nu9h1RD5Y1lmSyzE3xuAD8KrCqScpMCop+wQQ==
Received: from MW4PR03CA0025.namprd03.prod.outlook.com (2603:10b6:303:8f::30)
 by DS0PR12MB6440.namprd12.prod.outlook.com (2603:10b6:8:c8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 08:02:11 +0000
Received: from CO1NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::5a) by MW4PR03CA0025.outlook.office365.com
 (2603:10b6:303:8f::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Tue, 10 Jan 2023 08:02:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT099.mail.protection.outlook.com (10.13.175.171) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18 via Frontend Transport; Tue, 10 Jan 2023 08:02:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 10 Jan
 2023 00:01:58 -0800
Received: from [172.27.11.35] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 10 Jan
 2023 00:01:55 -0800
Message-ID: <a1f3b6ad-7173-70c7-4361-d01f9af1b7d6@nvidia.com>
Date:   Tue, 10 Jan 2023 10:01:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] lib/scatterlist: Fix to calculate the last_pg properly
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-mm@kvack.org>, <jgg@nvidia.com>, <axboe@kernel.dk>,
        <logang@deltatee.com>, <hch@lst.de>, <alex.williamson@redhat.com>,
        <leonro@nvidia.com>, <maorg@nvidia.com>
References: <20230109144701.83021-1-yishaih@nvidia.com>
 <Y7zyyTxdoJulq7OD@casper.infradead.org>
From:   Yishai Hadas <yishaih@nvidia.com>
In-Reply-To: <Y7zyyTxdoJulq7OD@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT099:EE_|DS0PR12MB6440:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c396ac3-cf9d-4d17-aee2-08daf2e0fa25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LUFKLG7b3O5rS8Ew9zanhbldqPhfFh3zXG+eRTEVlyz3BeNi4BBcMu5Kvz+kpGiP+clhpKFXmA7OshR0c4i1CtTdHBvUtMc2IhJIJnnQWyem36p+4tOx0+HmcjjoEJV63k33XBSikKZhRQ9XQfrdsKN1NhksTmNLp50TMoxzWzPtiypYMZMzQKDdiAQwYT5Ivq/pPMpeX8suWcB3eF/6Y6FCeTf/QJTEQ6d1HPGg0mjVUHqW7DURZwrW9pmmglgy1Lo3GUIDiYSg6VjVKzA4YqxyfisQHeuqwglMr8kHdpMLDn4hguMWlnjeiKKKiZbpkOcDeycC7Dn+BTxYGdtoFGH861j+meGTQ8+9ITfrCV8/jvNV/rKqgDG+3TJoENU/MJ2gYfZuVTwNeBzMFRZ7WWb9MuIl0izGoiMJ4NKk9C9e3PqVKU85KGUZgsxy29CkhlJDtQlQess2J60XNFko5fPMaQiu7johbG87dMJGrrCEtzYfWxi1AUcmVZkC1TRJ6uJd0gfhrBz6TrPs8CB/NVH/ISVkaOFwFIFP3JuuJhCed39ZOa1O9ho/VFhCkBqW1WL8ojkIAabGb2cWhLn9vO1aFbPix4mRLkveGAtfT30EIMNRnTK1F/G0UOcNBGG6RrPHWzoRWo7mMft0ojmWY/QJTlTu0nzxB/IvD9DLIqtL4z5koaLlfM8PwLkRTihGqy7sjoEeG3cJe8ykzGBfduipp7TPb3P7hho9Hxwvu6bnGvdWDDceObUVZdvycoY/BBxzo2A1OuuH0Hw+3vatNWtafz6NL/aFO20OjyK2dPJ67h9cMnkV+gKQYwYVx0ZN
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(82310400005)(40460700003)(8936002)(47076005)(2906002)(5660300002)(426003)(7636003)(41300700001)(16576012)(70206006)(4326008)(316002)(70586007)(6916009)(8676002)(356005)(54906003)(26005)(82740400003)(16526019)(40480700001)(2616005)(336012)(31686004)(86362001)(186003)(36860700001)(31696002)(36756003)(966005)(107886003)(478600001)(53546011)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 08:02:10.8153
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c396ac3-cf9d-4d17-aee2-08daf2e0fa25
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6440
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/01/2023 7:08, Matthew Wilcox wrote:
> On Mon, Jan 09, 2023 at 04:47:01PM +0200, Yishai Hadas wrote:
>>   	if (sgt_append->prv) {
>> +		unsigned long paddr =
>> +			(page_to_pfn(sg_page(sgt_append->prv)) * PAGE_SIZE +
> 1. page_to_pfn() * PAGE_SIZE is spelled page_to_phys()
>
> 2. physical addresses have type phys_addr_t.  Oh, wait, paddr isn't a
> physical address, it's a pfn because you divide by PAGE_SIZE at the end.
> But you will get truncation on 32-bit, because page_to_pfn() has type
> unsigned long.  Anyway, this shouldn't be called paddr.  Maybe last_pfn
> or something?
>
>> +			 sgt_append->prv->offset + sgt_append->prv->length) /
>> +			PAGE_SIZE;

In this area of the patch I just reverted to what we had in 6.1 [1] 
where we were good.

I can send V1 and replace the 'paddr' to be called 'last_pfn' if it's 
really needed.

Alternatively, we can stay with this patch version unless you can see 
here any real issue.

What do you suggest ?

[1] https://elixir.bootlin.com/linux/v6.1.4/source/lib/scatterlist.c#L462

Yishai

