Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509D17013DD
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 04:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241215AbjEMCGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 22:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjEMCGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 22:06:34 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9797B1BEF;
        Fri, 12 May 2023 19:06:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLJw9/Yrsia6eTM6roCz56CHSHn8V7HDsY4NaCS/TdH+/IVNaWGWntlGzju3VSqLPh39Di72TyfnzWuxBB4XNcYLi9P+HAdvsNmmkvCTlNeQBWucN+nlqSu8ngAGl//ATVDQqBmoTw620ANLCeluXASNWuq0khe+G/2HQn0u4BMRt3oQLVRwbJJfVp/UBLEHvg+cOcm0Pn8UPd14UfTsReGl41TB0kO2qhGpV6+6FdxOIwFCQJP7Nyho6bazQFVkoD/6DyKTjH+tEWVkFZrGnh3XBUtvktUAP1TdEG4OjpJAllxPyW3ukEO03yGABp/79QU2PxqVtronuhOnfI74+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oG7JYvn61Q12HdENJ4dw7LrDt1HRLBd+mOyfbd1FJsY=;
 b=WTgqBLR+RixfLUm0IoOqc1PigR5RFFhIt5Be//4ggrwI3Zix2XXK/XUF8c5Xvb6nAPrNGcuqvPy5snFsE+uMzVE6qndd17zaEBF/Gf1v+LDS6yVByuDPBlwY/jo5Rk6jwe2QuNANjXF+qonYuPnV1SmcUhb5I1/aUnI5OAsjnm3C+tfh3AGrW/78IyNyGW4cuuwxM5Cwk6dmWv6KUfw8ZlaDyVhtjY0NEznW7A+axW7aCIIYJVlWuDxGSWOA0O8FCg3OYT6Vjp6tEQqP7WAVS6AwPWSeD3VxoPcTG/7vgyuXzfX6cM6Ib8SLjaQRqfYa2pydkcbW+2ybuyKUujVWRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oG7JYvn61Q12HdENJ4dw7LrDt1HRLBd+mOyfbd1FJsY=;
 b=Y2GjO6ZTahdtYqIXvfiEddqgPnIW5iiNr3KqQ3toZUU1nfdsQ4VGgeUe530qd/MSUXRwVjkV76vmlOGNLIZUymiyzwfhP3oe1lPUdnR5jxbxYPqWzZN0VCEHJyFegYAdBAUSj8Z/bbw2rsClMLcpDxlrgGKDow4WndqUoiX1fp8x7GcgfKLaKEvtykZBuyXZVBx5dOXkHvAyeTaRg9yyl7JSVXe59JKc1T2e9FeS/YpI9HUORp6rXfBYC0u5PW8rLrLedyHN2NR6G+rq8JXLzH5/QxwizsctGcN5E5aT7kPw2D/mRYh6kbXTkCVQcLHHcJMsg9UsEUdU18VtpNie0Q==
Received: from MW4PR04CA0205.namprd04.prod.outlook.com (2603:10b6:303:86::30)
 by SN7PR12MB7371.namprd12.prod.outlook.com (2603:10b6:806:29a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.22; Sat, 13 May
 2023 02:06:30 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::d1) by MW4PR04CA0205.outlook.office365.com
 (2603:10b6:303:86::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.25 via Frontend
 Transport; Sat, 13 May 2023 02:06:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.27 via Frontend Transport; Sat, 13 May 2023 02:06:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 12 May 2023
 19:06:17 -0700
Received: from [10.110.48.28] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 12 May
 2023 19:06:16 -0700
Message-ID: <dbea2e8b-41ea-565c-a78e-61105e23fc08@nvidia.com>
Date:   Fri, 12 May 2023 19:06:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] arm64/mm: don't WARN when alloc/free-ing device private
 pages
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Feiyang Chen <chenfeiyang@loongson.cn>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <stable@vger.kernel.org>
References: <20230406040515.383238-1-jhubbard@nvidia.com>
 <CAMj1kXHxyntweiq76CdW=ov2_CkEQUbdPekGNDtFp7rBCJJE2w@mail.gmail.com>
 <a421b96a-ed4b-ae7d-2fe9-ed5f5f8deacf@nvidia.com>
 <CAMj1kXGtFyugzi9MZW=4_oVTy==eAF6283fwvX9fdZhO98ZA3g@mail.gmail.com>
 <8dd0e252-8d8b-a62d-8836-f9f26bc12bc7@nvidia.com>
 <90505ef2-9250-d791-e05d-dbcb7672e4c4@nvidia.com>
 <CAMj1kXFZ=4hLL1w6iCV5O5uVoVLHAJbc0rr40j24ObenAjXe9w@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CAMj1kXFZ=4hLL1w6iCV5O5uVoVLHAJbc0rr40j24ObenAjXe9w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT034:EE_|SN7PR12MB7371:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dc4b180-bd07-444d-1376-08db5356aac6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ofkLTJzhw6xT4ycMzyQCbOJSgxI1u9UrGLbNRz6bS7j8BdCw/vndZtwDKNy/DAviUBfVY4HpQbhWK1/lVBI1nUQ9bd817zH/VXhOoStMaYmoAISW3IiBexwfa9Y/hLZPpoo+0w9eGcyS/2dT6xilTOVO5pD2iqxHbxv1WHSnTSAl9MMkuygr/4DTbNnoV2YOPDivz2pjTJJuhiONKMpzebWw/6791NWXe/juvFBLoyzAnwksP4Fo1QqyL+dPkA6flNXSOicasPmlxT+VDU+L2eyIJZIZY36mROrhXgUfGchE0ve0GW200qZfO3EN+H4RbQhMk3TJrtXSCjrgKIPMaSqfuh78YtEJp1gt8gBfUwwl2gibuPWGfXFRkrVygSNWyPITXNTRBTiwemEk2ggzS90r3qfFDFGcv1kOXUEIDityIBpf0BrQd6jMvmKfxbJ9F1+XfG6U2SsuN5VBpMCPPiUud8GtSw30RrPeFxRzWnRWS1yGPyDwDzjVexuZ75G79QF4Wlq/L3MUPQPwCSjMOsiSp8Uc+9diMQ+lrXEbj3klWkf4TpommI8mkci10BNK6W2MSzb1Pidweq1xiKYv4qSz66UAs4kcUHe+ZQ5E8qpK/IAQQoKlsz/MEubOjIeVgxDOnatt9y7JiPtXXR+6iCL3GtQZuzgC6t51+QaOKxOs67baoiPZWo8tACsKIXiIE6MwHqLtk1cShr3UwiuG5fqNgBaDwNS/XyIy3xDWcC8ujVrHgrufUMgESOHE/oxa+ZXwjrHxJ66HiT+8IrzNag==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199021)(46966006)(36840700001)(40470700004)(36756003)(478600001)(86362001)(31696002)(54906003)(6916009)(4326008)(16576012)(70586007)(70206006)(316002)(82310400005)(40480700001)(7416002)(2906002)(8676002)(5660300002)(8936002)(4744005)(2616005)(82740400003)(41300700001)(356005)(7636003)(16526019)(186003)(36860700001)(53546011)(336012)(426003)(47076005)(26005)(31686004)(40460700003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2023 02:06:29.9520
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dc4b180-bd07-444d-1376-08db5356aac6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7371
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/23 07:42, Ard Biesheuvel wrote:
>> I'm still not sure of how to make room, but working on it.
>>
> 
> The assumption that only the linear map needs to be covered by struct
> pages is rather fundamental to the arm64 mm code, as far as I am
> aware.
> 
> Given that these device memory regions have no direct correspondence
> with the linear map at all, couldn't we simply vmalloc() a range of
> memory for struct pages for such a region and wire that up in the
> existing code? That seems far more maintainable to me than
> reorganizing the entire kernel VA space, and only for some choices for
> the dimensions.

The vmalloc approach does sound like it should Just Work, yes. I'll try it out.

And now I'm trying to remember why Jerome didn't use that approach for x86
originally. If this fixes HMM on arm64, I'll revisit that question too.

Really appreciate the help and advice here.


thanks,
-- 
John Hubbard
NVIDIA

