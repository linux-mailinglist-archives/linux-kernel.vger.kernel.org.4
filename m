Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94FA644DB4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 22:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiLFVEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 16:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiLFVEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 16:04:06 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2051.outbound.protection.outlook.com [40.107.100.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5512A973
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 13:04:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLNby+ykjQ8jA64wOVVtCIDOYmq0zR/GopYs+sEqo2KBeU4p2yXXH1hKz41bmXIyITT7Eft8Q0hrOBw8dg1EiMxmYawfeMkVzMoW36cpC2Gu22nIFx2RGi8CCjn0MOeGq5Iq6IPbXK43RnQhzPfUSpyZKa1cVwcm6XP8NtnYZTWzLznUSUwAKO3h7Jb+DjHCNBothmXT4iYcH2dybHfnBoOXphlJ35ZOQrBkmCZp2ZmRS8TfM0gOr3GxHDj5j8vJ2f9F0CYreEy4Iynv36eWXoO8kHH5PtVymQvmoLwQsFpvKi+Dr5lYpyX32BbOBaOx4gFkgYkJcLKIa/q61NP9HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3BfffQf3r2KZqmnrOfXQ1vroiqM/JIbT2fWpis2wHYw=;
 b=ePascpmV8YlpsMCHj7MPE0rYmskRQPmZa+yUfd1q/Nk4x8wZzyY2o/IKDUiF8ZervB46mbNnHXzZJGbU4TAeIk5b0UdP38tKzPK6zVhytmSf8kah23D2n4WVxN38qzXsJzoiYRlsIO1ZWCX/UTmOj0XgQod699kVZdJveLHfkQYB7/b95ZLtNKYhYXejjNnk95stgBFKlECBM1NWC4qQzccme+e9baVYq2rOeFuLyUROGPAhEERn5IWQNSLiNFAG6hM2gwO5zHALyjcv+HJnQZWNWLzYyOiTlCicITPmAwOAJFRhzUpfaFYel8VW5VWUTcI98GLYuGLj+RefUSCZdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BfffQf3r2KZqmnrOfXQ1vroiqM/JIbT2fWpis2wHYw=;
 b=By5NenyqnAS5jUxB4/5dbWMClKhWii9moaPsVP5Z8XqgqI5ISuMAfPmdwfHYEhBksAIlr9BO4JH8+76rYCmWdDsf9NjdRdryoZqXtP6mjHXyw244PkEDS1HdhnG4JA4zh+c+FToW+I0oA5iase0i68ZXlItCCP3uDRX3t46+TTBJrTO/5znk6MFcLvXhw6ZHCYFWNxs7afI9UujlXg6PlBf0qwfNszY947qQHf7KNurXTGNcXliFESlahW1P8r7dslZoIq8t3BuvJCJwCauSivNjvH7jVKEvABn/J58sXqY4tCKLN3Gum1OHWdRIgA3Oruv2zRiSn++0REUcOib2WQ==
Received: from MW4PR04CA0210.namprd04.prod.outlook.com (2603:10b6:303:86::35)
 by CH2PR12MB4892.namprd12.prod.outlook.com (2603:10b6:610:65::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 6 Dec
 2022 21:04:03 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::e) by MW4PR04CA0210.outlook.office365.com
 (2603:10b6:303:86::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Tue, 6 Dec 2022 21:04:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5901.14 via Frontend Transport; Tue, 6 Dec 2022 21:04:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 6 Dec 2022
 13:03:47 -0800
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 6 Dec 2022
 13:03:46 -0800
Message-ID: <97e3a8f2-df75-306e-2edf-85976c168955@nvidia.com>
Date:   Tue, 6 Dec 2022 13:03:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 08/10] mm/hugetlb: Make walk_hugetlb_range() safe to pmd
 unshare
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
CC:     Mike Kravetz <mike.kravetz@oracle.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        James Houghton <jthoughton@google.com>,
        "Jann Horn" <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Andrea Arcangeli" <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>
References: <20221129193526.3588187-1-peterx@redhat.com>
 <20221129193526.3588187-9-peterx@redhat.com> <Y45/5ezH6uwn7Cfy@monkey>
 <0813b9ed-3c92-088c-4fb9-45fb648c6e73@nvidia.com> <Y49xlV8I2/92Flha@x1n>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <Y49xlV8I2/92Flha@x1n>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT035:EE_|CH2PR12MB4892:EE_
X-MS-Office365-Filtering-Correlation-Id: eddc9ac8-da98-4d68-f807-08dad7cd676f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YyU4dvIlYTanvnRMWedmXUhyYPilIWBQG/khYvnCQ6IxJteqMvte32I+glC7ohDWd7pSTgJH3wdNz8E4M9+VoK5O94D9NJIVvNV2VZTxeE9EYNr1F6DcrUEskb9vLzN69pn6sYldBAJ51dBB7dBLBfb6I77EbQQjUFAGzCs6SwXhXa1L8uO1N48o59WlTxdA7IqdKZuAWb95RnKIlk4LwU9xLQmyFszv9Q4ooSp4F8ZpLSL5HIALI33VDsZCvLU4DAWeJE9DglirMqYLtSPYlxlAa+dBe68xcMTroqtrH0P7PCux/EblYtqDlzZqpnmhi6+b4cZ1PKkg/5Lc9VEFQXeJZopy9AVZKpLT4fbtVttvh0c00nrJhiM5dRKT5NvmgXsQ4UOaoNI8j11SMZ5sjGme791a6HrtTxFl+4ZM6Ee1Dy0LHFwtodQEkDRFTIu4qZAQXm4l/2itNm1/1e0h1y33ApXIcyN4QgBxoPSTE1SD38b1WN1ggp3FwljRYv6oTAQhKie6MBtGa+FmrQ3pOVW/S++JfaownM7xhn9+SG5qQ7BRcdhbqcb5CD6U9AvF9/qQ7tBvA9tNoLYK5XDpGnaZwOASom39CRo0q1hflNLjIRZ6Ub3DlJpY9EKZI+MJ63VSqR4746oYtESyB42XVq8WBBI8w8YX+yIdv8TUiPDTmNt64HeS2moaRc0lEYqzFuluaqSR9IFbdvAjkOhrIrjq++6eVheZnW9YsAWaJH0=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199015)(46966006)(36840700001)(40470700004)(31696002)(86362001)(70206006)(40460700003)(186003)(40480700001)(36756003)(16526019)(41300700001)(70586007)(336012)(8676002)(47076005)(7416002)(8936002)(426003)(2616005)(4326008)(53546011)(16576012)(5660300002)(316002)(54906003)(6916009)(478600001)(26005)(7636003)(356005)(82740400003)(82310400005)(2906002)(36860700001)(83380400001)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 21:04:02.8442
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eddc9ac8-da98-4d68-f807-08dad7cd676f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4892
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/22 08:45, Peter Xu wrote:
> I've got a fixup attached.  John, since this got your attention please also
> have a look too in case there's further issues.
> 

Well, one question: Normally, the pattern of "release_lock(A); call f();
acquire_lock(A);" is tricky, because one must revalidate that the state
protected by A has not changed while the lock was released. However, in
this case, it's letting page fault handling proceed, which already
assumes that pages might be gone, so generally that seems OK.

However, I'm lagging behind on understanding what the vma lock actually
protects. It seems to be a hugetlb-specific protection for concurrent
freeing of the page tables? If so, then running a page fault handler
seems safe. If there's something else it protects, then we might need to
revalidate that after re-acquiring the vma lock.

Also, scattering hugetlb-specific locks throughout mm seems like an
unfortuate thing, I wonder if there is a longer term plan to Not Do
That?

thanks,
-- 
John Hubbard
NVIDIA
