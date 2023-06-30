Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA16743269
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 03:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjF3Byn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 21:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjF3Byk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 21:54:40 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE28A1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 18:54:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IHBOqyxNJQT6vbRQEkvdrdaQYN19q/Yl0qavhx8d0FGFb5UzsTufLtQvppKfAgc5C7cCI3RSS5BuXQZPm6L8KhezC4zDlc+u1rzohxKS2NjrfKnI4KnLWO5nP7231SU6CLeVMU5g9Ukwr+H/tK9OCxz1ZvCsQNiEW8rovccHcvLqGXbMYtjHFUjD59KiKVXjQqMIOyWlAwWF7qnvM8L4NrzuqJzfWjF+7F+gk5d0MH+BHT3jxmMjFR21oEp7BI5K2LTmPJebtma4M/HUnN7cD2IIvOMgVpVPAn1G8wjIjiXqm5f/vZ1fCLa5mfB/11wNkpZW17czzKXU+M+K2TDK+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7+fAGrbz5Zlv/ma+rYOPdweHu3Y3DnsGsQ3zoodr8FI=;
 b=KFV+c+IyvhvUB2Kqkt8xVR5JEPwRcOjXYuigHsPvijzUvy5sp1Nxd+SEw2r22TF8rjshAmuVmyk36a7Xm2FRRPn/WIwqKl90ZYkgZEE/pcOqdxSAoCAbvHtlmZjoyaHULOQGO819FS89vVvUY6cZ51Bb1XvfKHLr9GdE1VdOjZXqDwz82uEWSNhPr8AV65GpZ3/mymRexRSsTDZGu4Zrr7fDNi9KHJhCPvumhc4+KqVPk0te+oJezX+CJPNno3pNnJDL7aDRLXj5Jj7Fjk3wTnXQU82b+ZcBhVPr+mTrqSCcjr4dm1uURR8BZCD8XzwVWmjABz7sryQfs/jkoLospA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+fAGrbz5Zlv/ma+rYOPdweHu3Y3DnsGsQ3zoodr8FI=;
 b=s6MAIQiJV5vRkCtujbsbdCW+cCkRsy8XaykNwvWYHsEeHkhuK2xDU+yAiOZBFyIPS9QVf0PcZxl9qlOaGfNOOjiPdnWwDL9HQHpNL3E+sa2Zb7ejuZJCEwpQJhInr364ZB1i5eUjqVlpqwL+IbM9YAf2rgSn6uUTSOG4mUOveu5GX8Fsh0XAoVPtCkzS8aToxLgyuxb6UovA7ogyEdmIvumtAuVoR27gB2oZADpyPiKGwsqksZxLkVxTr6EjstRdSVWsRzJ7GATd3YKLQnOiEQfqYKSAPUWrsvWTN0WZUgEwSJkRJlYDmI2PN1mHfUst7KVzuxvM31XCtUGHO59xdQ==
Received: from BN0PR04CA0112.namprd04.prod.outlook.com (2603:10b6:408:ec::27)
 by SJ2PR12MB8847.namprd12.prod.outlook.com (2603:10b6:a03:546::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.44; Fri, 30 Jun
 2023 01:54:37 +0000
Received: from BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ec::4) by BN0PR04CA0112.outlook.office365.com
 (2603:10b6:408:ec::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Fri, 30 Jun 2023 01:54:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT053.mail.protection.outlook.com (10.13.177.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.49 via Frontend Transport; Fri, 30 Jun 2023 01:54:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 29 Jun 2023
 18:54:28 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 29 Jun
 2023 18:54:27 -0700
Message-ID: <c7bc657b-c573-032e-f76c-f5c69198b2ff@nvidia.com>
Date:   Thu, 29 Jun 2023 18:54:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 11/14] arm64/mm: Wire up PTE_CONT for user mappings
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        "Andrey Konovalov" <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        "Mark Rutland" <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20230622144210.2623299-1-ryan.roberts@arm.com>
 <20230622144210.2623299-12-ryan.roberts@arm.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20230622144210.2623299-12-ryan.roberts@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT053:EE_|SJ2PR12MB8847:EE_
X-MS-Office365-Filtering-Correlation-Id: bde1bd45-dccf-4d84-c347-08db790cf54c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GvXVnDU1RFdjaNpOOuCXaaiNFUcKevti+FNKWOF6IXMvqtjgumhpGhgMLCHk+uR8WpesijmpaMPJ0JjhfjmUS0OkEuVJeQvCgj/GEoEBI7CfTOwq73ZO5yAOfVUptoMQ0IHBwbCK6zZkpsD6FqA7jA2GGmQRyjoU7n29ZQVWAX8Mi1W8EBWr06WB91qCjw4rhl0zgcA4ZVhbMeXTHx0IputAtC8VqXksCwUaWTBCy9bdFlnq3LPwC1SVHY4PsT/vqP9J9I6Sr/m7gPJxBQ0AfZ5ocfIusm3fXjM20FwFCbwKZKGTAjC+Xhy9+9dlG4UxZAUpfcFc+HqWBnPmjd7NzTs2OYnlK8tInG2b1ILSCyLFO2/pWT2gnoO9l0ONC3o9UiIAi2LVEEoMj6bhditPQJQKxFUj+JKX1MQ1oDK+0bcb4PZqyfK51u/RK06kmlB5o6OlHSDLr0TXxIpo5Tvf79KVOtAM5MR1D/hw7MoAV8PU7AEEEvyaXysmOmvI5mKym3kyyFniMX0JYBfceu8+7rmGcsKYWK2YkX15U6LairrabJT4n1Y/hxvo1KzuOyutNYzoYgNns/zBrK/NboQFQ86567M/i32stM5iK2bVViUUj0LZ3les3SRW18dK5p8+ZI9zZJRAC9wWE4Ay4S944a/7XGk1ssV4mR7LkLvziz8zpStX7TbM/XO9hi7+tJ4jP3sx3VeVZ2AUDt+oJe5g/1tzTVIKeVPI4ZrqeIgeO8RkNao/Q0081w3jslhuv/WrMIt/ndtGRpSwW/MhAtrQy5p/VZGZQ6uzQoRxjMoPTxRnwjVWc89rS4IDuVUUBUN1ETTGKgFyj2NbfpWCbLlJvA==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199021)(40470700004)(36840700001)(46966006)(7416002)(5660300002)(54906003)(8676002)(40480700001)(8936002)(66899021)(41300700001)(86362001)(110136005)(31686004)(16576012)(7636003)(356005)(47076005)(4326008)(2616005)(921005)(316002)(40460700003)(70586007)(70206006)(2906002)(83380400001)(31696002)(36756003)(478600001)(82740400003)(36860700001)(82310400005)(426003)(336012)(186003)(53546011)(16526019)(26005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 01:54:36.3043
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bde1bd45-dccf-4d84-c347-08db790cf54c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8847
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/23 07:42, Ryan Roberts wrote:
> With the ptep API sufficiently refactored, we can now introduce a new
> "contpte" API layer, which transparently manages the PTE_CONT bit for
> user mappings. Whenever it detects a set of PTEs that meet the
> requirements for a contiguous range, the PTEs are re-painted with the
> PTE_CONT bit.
> 
> This initial change provides a baseline that can be optimized in future
> commits. That said, fold/unfold operations (which imply tlb
> invalidation) are avoided where possible with a few tricks for
> access/dirty bit management.
> 
> Write-enable and write-protect modifications are likely non-optimal and
> likely incure a regression in fork() performance. This will be addressed
> separately.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---

Hi Ryan!

While trying out the full series from your gitlab features/granule_perf/all
branch, I found it necessary to EXPORT a symbol in order to build this.
Please see below:

...
> +
> +pte_t contpte_ptep_get(pte_t *ptep, pte_t orig_pte)
> +{
> +	/*
> +	 * Gather access/dirty bits, which may be populated in any of the ptes
> +	 * of the contig range. We are guarranteed to be holding the PTL, so any
> +	 * contiguous range cannot be unfolded or otherwise modified under our
> +	 * feet.
> +	 */
> +
> +	pte_t pte;
> +	int i;
> +
> +	ptep = contpte_align_down(ptep);
> +
> +	for (i = 0; i < CONT_PTES; i++, ptep++) {
> +		pte = __ptep_get(ptep);
> +
> +		/*
> +		 * Deal with the partial contpte_ptep_get_and_clear_full() case,
> +		 * where some of the ptes in the range may be cleared but others
> +		 * are still to do. See contpte_ptep_get_and_clear_full().
> +		 */
> +		if (pte_val(pte) == 0)
> +			continue;
> +
> +		if (pte_dirty(pte))
> +			orig_pte = pte_mkdirty(orig_pte);
> +
> +		if (pte_young(pte))
> +			orig_pte = pte_mkyoung(orig_pte);
> +	}
> +
> +	return orig_pte;
> +}

Here we need something like this, in order to get it to build in all
possible configurations:

EXPORT_SYMBOL_GPL(contpte_ptep_get);

(and a corresponding "#include linux/export.h" at the top of the file).

Because, the static inline functions invoke this routine, above.

thanks,
-- 
John Hubbard
NVIDIA

