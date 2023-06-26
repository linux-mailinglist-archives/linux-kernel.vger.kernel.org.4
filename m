Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1029573EBC4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 22:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjFZUZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 16:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjFZUZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 16:25:00 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66EF199
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 13:24:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RFCpsrwulhTZ7PC8CmDVGHfskxw2u7miLvDGxpr5Fckh/SgyEk5zIIwWgksqbu9jplCB1M0jH2o+jnKhXwY+8r5pEHVXBsfVs4uCWLZv1P/VPA/4NyITwwLadWuz7TiINTcfdBA6j6xe5a9r5TrWgMsp4J19gXqhA10+Sou3+ktYkL/XDZik77md6XkyCjVWZURIHGwdqMdou+X7+0g6WG73F6In+TfUbWLR2vaGytsm9uAk2RnEk8iol7Jle6J94YLnO4ma7SkcvAvbLfQeE2hXQen0au/or5p/kX6XhiL3FgR3DreOAWyXvK7RlyPURppEmsW06//nS+Lardtncw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8FV30v/7SyUszpgdGpZM+zFJOBoGb58NutPIWI0RXY=;
 b=Cpp0PqbayNpyWRnG1GPiIJZRqIy1cKOD9rEAwmj/B0c9qU+llKodHavGJnkhJLBwnBX8c7UMnAbTtOUP+hLx4m4KISlbH0nDxFIXzzOlvsoPtWezascDgdcfBtqqKQvOspZjytncbbWfspvvvNPlyGVWB1Uj/IrNCm482FUWpL5b+/LIx2YoUSsBqj/cDVqBQztnRNRbibn6UJ893+7YT3uRfxr09VbK9ti4L+m2x/ZpEBsiEF8Wjk/heQ8RIqrMfLp7B0eICa9YiDQ/3nlxFmy3rZ2qOqhQOhPWl4Bljkkx/9NsQSCzklbqydRxGS96aKxh7SWJaEs2zP5GFpzNZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8FV30v/7SyUszpgdGpZM+zFJOBoGb58NutPIWI0RXY=;
 b=LP55g627aK5nf1Ths8ODTrsme7mZMOPayRAp0DT7Zm0N/5+PKoJI/3kyr5vmEW5h6h9brm8BhXIAGlghr6cC9hN09X5Ld+3vb00O189kDTw/Dt3TwfYb/Ct3FoOvz2eoCgHybbOEJCDlcvXQlSNNWmUgEGWwtYKP1K2DMgrC9u32KwEuvAiRXHbQtmVqPgrJXrkqPO8kcqodOwojlp+vFfSyF6t5d6TzbBAqYKLL7FNRStcIHmAKqv85GsYMYE63UPnMFLiX1phMdaCM3CVIdIuTPuYxD3mrHNhjFe1rYKLKJl+cliXuwU8wY+yqaqVzCzVPJ3sMAK5ficTwnT7MHA==
Received: from DS7PR05CA0089.namprd05.prod.outlook.com (2603:10b6:8:56::6) by
 CH2PR12MB4296.namprd12.prod.outlook.com (2603:10b6:610:af::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.24; Mon, 26 Jun 2023 20:24:56 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::1) by DS7PR05CA0089.outlook.office365.com
 (2603:10b6:8:56::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.15 via Frontend
 Transport; Mon, 26 Jun 2023 20:24:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.47 via Frontend Transport; Mon, 26 Jun 2023 20:24:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 26 Jun 2023
 13:24:46 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 26 Jun
 2023 13:24:46 -0700
Message-ID: <29f9a86d-8ee7-5e54-2979-c5fd3b6fbe2d@nvidia.com>
Date:   Mon, 26 Jun 2023 13:24:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 7/8] selftests/mm: Add -a to run_vmtests.sh
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Mike Rapoport" <rppt@kernel.org>, Yang Shi <shy828301@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        James Houghton <jthoughton@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <20230623142936.268456-1-peterx@redhat.com>
 <20230623142936.268456-8-peterx@redhat.com>
 <1f81260b-f569-87b9-a100-f6cd65ee5a5f@redhat.com> <ZJm7rzfCwtw7AnC4@x1n>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <ZJm7rzfCwtw7AnC4@x1n>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT020:EE_|CH2PR12MB4296:EE_
X-MS-Office365-Filtering-Correlation-Id: 71aabba5-1d55-419a-6c40-08db7683685a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: febtgDbBdNy1NE5HIJpGy5LtRfGU9ccXFeBNPiGLzuX9Wmj1swHxTSLasYoqx4J22y8eT+XgzNR+ZnqlTKLBGDsLrG2ifHuVWzdaLFYSt8Npz06EYyn3LYlWTwmR79/yuabspfj0z5ld4f8m+7WxzqDwxbTdcS/jnjvVjRigrocGaiN1zQhWpk1JyE14Mw77zX2ehnRI030YuxdU8XU6taIeNfWlTwjLNFHC+Fh8ScBB2lQaHgO9avWYfNZce58kjC8Xrzge91MUjJGCvchzDuUXvY5/Ub4WAip3DV6ie0LllzEi5WptysVd6NamMCTo44HhE8V+uUR853MOpTaZV/NM3Sk+oO0QNPMUvVwZtKBDSc277ZjGFQ0EuIo3AqP55YBwkA9o4IgvnRbXJ4eUilrrCZp4+MKb8/eMQTgRDvx9s8e/LSdMDHepkuU3cM72w6urnkejWwB07bVN8uGXLqdGr8zqWndaE+D+L1z2fGNNXcyk+6gq3CzhXIY3VCobqgy/JKpJEY6FyAJCAd+2jUqgPiWVFBgLVqYGQxPruCZuNRCkfkIHcUg2W2JufPkExiN33EDgvCzESmtdhu4yoJ9Lo43f4PsUGAksZ03uQv6DBhiiA6CnHUphvtFnPxSvVr3rjvEzEh0eVjDd2XbVF7ZwSlFotNgRqgNDzsiv9JA730CskcNP+85l+OXxSfxa/ooOq71xx6Sggx643TWkbsvuFdmdj91+yPnq2lyJK3Fu2jQl1WQkMX48Iw/xBspqpBRpyQ3qAHmjFc2z/iMalA==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(39860400002)(376002)(451199021)(36840700001)(40470700004)(46966006)(8936002)(8676002)(107886003)(4326008)(70206006)(41300700001)(316002)(70586007)(53546011)(186003)(26005)(16526019)(336012)(2616005)(4744005)(110136005)(478600001)(16576012)(54906003)(40460700003)(82310400005)(2906002)(5660300002)(7416002)(40480700001)(82740400003)(356005)(7636003)(36756003)(31696002)(31686004)(36860700001)(86362001)(47076005)(426003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 20:24:56.5200
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71aabba5-1d55-419a-6c40-08db7683685a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4296
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/26/23 09:24, Peter Xu wrote:
> On Mon, Jun 26, 2023 at 10:10:26AM +0200, David Hildenbrand wrote:
>> On 23.06.23 16:29, Peter Xu wrote:
>>> Allows to specify optional tests in run_vmtests.sh, where we can run time
>>> consuming test matrix only when user specified "-a".
>>
>> I'd have used something like "-e: extended tests that might be more
>> time-consuming".
> 
> '-a' stands for "all" here, I worry '-e' may be misread into running "extra
> tests only".
> 

It's getting to the point where long options would help. This one
could be "--stress-tests" or "--all", or "--include-long-running",
for example.

I hesitate to suggest it because it's extra work, but at some point
it would be nice. The options are already hopelessly un-guessable.


thanks,
-- 
John Hubbard
NVIDIA

