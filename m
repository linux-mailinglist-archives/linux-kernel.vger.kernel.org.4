Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E467707810
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 04:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjERC1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 22:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjERC1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 22:27:33 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990CD9D;
        Wed, 17 May 2023 19:27:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kbq/NIU1lyANYjalH/RrolFkovSmKY/3jEDkjQM52P+KehWjDQPfBc84lXPE8plnm/cY5YwHXuzyer7FAYCTcRX/83YOUpuJS6fXEJxS/fG0UgSYQio7pFTaATu3LEwHPRpPBcj8o3itTUKp0ixm73xf8nj6zrpMgSh7MVjktfAr5adrkJElX+AS5UaEdaYvffHczQgy3bSTpVIg5jemMvYVJY6CyAkjAbhCFViPJq6fJLNPiA8WT5VtpgGiLhsn9owJ7ZJ5iklEWSCp4e9J+r6CbyDMqhNrvD6U/QXpQCIaKUS6l/EiyOe2woMenNEklJcj5ueJuQTJUBm09fyiRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TA17vidQg/K5V/ULBHpP05WsxAv1ywnAuQwkLP1+2f8=;
 b=g58rDMrxW8X6VRT4PSvw21gRrA/w9Yqd/yhdAD9Y3bUrEiuiIZxvdYVJ8HLfbS02iHoqXjV7Z5J6L7ttzpTkc7SzVIAVZEL5tqigkt4RdcT+Gxz7GuVjTbHV5hk5kftNZ1cbd3fm0R2STOJGfRBNpk+JAYit2m7H8EsYwwIMCI51cBYQaWVxtcU8Sz82JY44cl9gLS5bEWpChbFzHQd9R5PBNcuFGUj1+ML6Y2oGJIlD3ckgt30998gaXJsASprKaDJpo6FX7MrD+tNErC2b/eW/8mQeP8m8PfyU/y7pROgw0rjbUHAPi5Uu9P2fWCR2JjGS/FGFuwZuUBbAUqwVXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TA17vidQg/K5V/ULBHpP05WsxAv1ywnAuQwkLP1+2f8=;
 b=EfQIS7yNZK/Gc7ICik+41zJnO1L48HvBwr7ODmzaaXOw8ne2hOBi/4wMpzBsZ7zuhSAU6UW4EubwV1yuEYYab2ufuo9SFldiJbriiLLon1GiBlSAqfjR3mpabVvrDzpQfq3OFYVXJKc6dD9CJOLMkqfay/KLSukiTQjlhWp1ZIg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by SN7PR12MB6791.namprd12.prod.outlook.com (2603:10b6:806:268::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Thu, 18 May
 2023 02:27:29 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::b197:512:a4ca:6e9c]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::b197:512:a4ca:6e9c%4]) with mapi id 15.20.6387.033; Thu, 18 May 2023
 02:27:29 +0000
Message-ID: <8a5eb1c2-84bc-6513-0062-32cf6bbb974d@amd.com>
Date:   Thu, 18 May 2023 07:57:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 0/2] arch/x86: Set L2 Cache ID on AMD and Hygon
 processors
Content-Language: en-US
From:   K Prateek Nayak <kprateek.nayak@amd.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, corbet@lwn.net,
        jgross@suse.com, andrew.cooper3@citrix.com, peterz@infradead.org,
        Jason@zx2c4.com, thomas.lendacky@amd.com, puwen@hygon.cn,
        x86@kernel.org, linux-doc@vger.kernel.org,
        oleksandr@natalenko.name, bagasdotme@gmail.com
References: <20230413172918.1500-1-kprateek.nayak@amd.com>
In-Reply-To: <20230413172918.1500-1-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0160.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::15) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|SN7PR12MB6791:EE_
X-MS-Office365-Filtering-Correlation-Id: 990a1a27-63e9-4d2e-c583-08db57476ce2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E6gutJn/1RyyUahE5kebUg8IEyGQIpthPD9ru7xyoCEo176OWRURTuCJdBoleVayunEF7MCsgDagoYErsIKAGxbYj4dgmegApQhL2D9eat+nFkgdvbSi/IBKGeNs5ikRAKC1cOmYsM59onfQ498byN9uI+LLr33kf1tPeE7QiipTcsophC5kJYt3M9eYOQdQnSm3eF/dm31NAR+T3AZmCHH4lEdVaSYWmXLTKXW7hzMiZhpbfMZKK81rMVNmQCDKyNyVzTjjAkbScxwHMacfiEUsrC5UZe5IeeB2+oi8na7hB7W9rReg2ONwO28sIw5N/6IKp4JbahIlpAjxnNRB4latdT0sPhKp/BVNq5j4ptofsc2ZgP2FX3q33kHrhu66tuCN9JFb/qqskpjvgsvqyN3DrEr1M5ZIpVQE4ItE/SmmSf6E+WO10qatmStC3qrC0ismDtix5KGgnBDcsVGeAEnc0E73bTO8Z5RLLwpvnwOcu5uF0fQC2NsX/vwk9azchSqwr4pulM0ERdcmI7ybPrnDes+1YGOz66m+zTDY41NccPwpuc4gXRcexx0WIJ1rw/iE/5arwSjPqwcE7OzjwMrrBmGqmhLRPfIuhGzrht6D1Fz2pCJYQT9aDTWsC4XO6L5tm3VHktlwSrSpHWRhzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(451199021)(6512007)(6506007)(53546011)(26005)(36756003)(2616005)(83380400001)(86362001)(31696002)(38100700002)(186003)(7416002)(478600001)(316002)(2906002)(41300700001)(66556008)(5660300002)(8676002)(6916009)(4326008)(66476007)(66946007)(8936002)(6666004)(31686004)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1pyay95SGtnSU1LMU5DYVVJZVkvMHJXcFRvRGVFL1FsTVd1ajRMdGRHWVd2?=
 =?utf-8?B?SzcwV2F5QnA5cEhKZTUvQmxBcm1iTDNLZXJyZE5hTUE2WGVlNmdiVUxWOEE5?=
 =?utf-8?B?bFRKK0d4TEpCMVFSUGNNU1FiVGtCZjhWSHdJclBtdHN5dDM1dHpraUdtZEI0?=
 =?utf-8?B?NHcyNlpNcVYvRnFDMlFGMWhFMit5OFp4bXVsM1FjRjhPMElEbThtTWt6bXpJ?=
 =?utf-8?B?TUU4ZVpncDVxc0tLcnF3Ym5OT2NaTlFyanMzRGhqV1FrWHRNd2JQSDJJVnBt?=
 =?utf-8?B?dFdwcU01dzFaL0kvUXVsaG4rRTV4dURSVzdJMWhVWVRLRC9ud0VVVTlkZ3NQ?=
 =?utf-8?B?MlhjeXNLWUFkanNSRHVJNG9YOE9WeC9kUzUvai9ma3RNcHdJMWVJN1lsNUtN?=
 =?utf-8?B?S21aVHpXWlJnUnZrbHpqT0xWL2VCWGJIMjlzemdMMjFnYzNwZk1JUzZRZ2NU?=
 =?utf-8?B?bDFuNDR2RnJJblZZWVhJNUs3Q3B4Y093dnhNcVgwWnBOVlM1R3MvN2p5VGhh?=
 =?utf-8?B?TnV0M2Yrcy9ES2FMS2NwK1ZST3MveGRKZFB6QmVpcmdKZk5lNkVIc2xacUR6?=
 =?utf-8?B?bXJLeGYrWitwRVl1ZXJvYVNqTUZzcWZLa2Nvc1htcUt0aDgrNjN2NWU1MzIw?=
 =?utf-8?B?QnRaZjJyeCtxQ3Jkc25ad1RSa20wWFBXdDRqWGlPRzl3NG9BZStFOGptQ3c5?=
 =?utf-8?B?ak1ocFE2cFNlVmRrd0xzQUU1V25uZW8xM2orbFZIaHFkR1dIOTVsMEpqdFg4?=
 =?utf-8?B?YURBZkh3emRRZmNrRUJlcXE1NEEzUFM3VTJKeUpGSkNUbHkvYktIN1Y3U0xn?=
 =?utf-8?B?RmxqRXBsQytmWW83Y0FjcFg0SXVoakp6ekRZZXRhM0phZ2FGM2dmbG1BdFRL?=
 =?utf-8?B?dGo3L3R0clZaWEt2dnN2R0ZQaHQ2ZlVDSXFLZHRwakwxVnU1QWJmRFplNXc1?=
 =?utf-8?B?S01tUENMdmE4VlNPVXNUbnlOTStBaXNycHQ3NzJ5VHZBTWYwZno2QVU2YlM4?=
 =?utf-8?B?MmlyNlhuazlpdmZERk9Lc2lBcGpjYm55bmF3SHVhWWErcnl4YmpuWHc2V0N0?=
 =?utf-8?B?ZWF5akoxTTRWdFhCRC8rZjk0T2dtZXpsSWFuNlRMS3Rva01Yd1hPMlFmdjNC?=
 =?utf-8?B?dWpYbHM4azF3UWo0ME03YlZGc1p4MXdXOWlVLytFNW9LZUs5dk16Q0FOc0Vt?=
 =?utf-8?B?aEIzYmhNWk1JMkE2YTA1M1N2SjNQS2Vvak82UW8xemxXbHBEak5wN2Jac2Ew?=
 =?utf-8?B?Z0hCMkhTS3QxUmJUT3lXTU10bjRBQzhLWk5teDJMR09OdHQyVk9wZDBYMTN4?=
 =?utf-8?B?Nm5jN0VJdHJYa2ZoSkQxTmVOZy9aTVFGOHhtRGt1ckI4bkVObnNzN0ErVUlx?=
 =?utf-8?B?N2pQRVUyd1dCdjV6ejRRTXNLbWFtdUV4K3lLZFRrakYzdGdFYlN2ZXZ1ZlAv?=
 =?utf-8?B?K2s1U09OYUp6czRUWlNOOFUrSTkyZ2l2eVRaRFJ2QkNYbHV0MWp3STRLTG5M?=
 =?utf-8?B?R01IQk8rcnlyazQ5NWtPaEF2SHVBQUFSVXpvdGMrYUZ4d3EwWWF3dUVOUzJW?=
 =?utf-8?B?NXA5cWRCWmRlZCtSNTQ5ZkticUpnZ1I1RW4zcTVPNlBoNHMrYXA4a1pna1lN?=
 =?utf-8?B?RmtBRk9BTkQ0VElIVWhaRDd4Wkk4WXdTS0FMYWtHN0FqL1RTaHdDd3B3YnlI?=
 =?utf-8?B?SkE0Rk1TU1N6U3ppYXlDQ1puWnNMeUNwQmZORkZjQ3R1STdYQm1ucy9oOTdZ?=
 =?utf-8?B?Y1QvSXF4VGROeU1Pek9qUzdBYlVNQUVhZnZMK2tZeDVzSHdRTDhPdDhJSHcz?=
 =?utf-8?B?bUhmZTB5aExKbWxUUDdqU3lVUGplOWlnSFVManVPSzIreWgvbDhodDY4TEo1?=
 =?utf-8?B?TTBsWnlwT3hUY21yNGJkcktxUVRhR2Q1dmpvY1V0WlE3WTZaRkVOM0VhMCtK?=
 =?utf-8?B?cjVlb0kwb2JVeW9ibkoxMDl5VTU3L29wOUJtVEhKWnJxN2xKbTUveHhHbFVy?=
 =?utf-8?B?QmNkM1hiSzk2bVlLd3BvWUJ1K1VBQlBraS9yYXBJYk5pT3NMODUxc2FUMUph?=
 =?utf-8?B?T1Mwc0NEa0RabnlkWiszblVKMTNqSjBXSStRNE9rQUptU3JzMk9ldUZxZXg3?=
 =?utf-8?Q?JshMUQDWm5jM6jKz98mrWipC2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 990a1a27-63e9-4d2e-c583-08db57476ce2
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 02:27:28.8335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tW+grYi3UGOOsQqD3bTI7dkMJeYybKzYQS1E5WDHh8vf+MZ0GErPxnGyHtQjjsAE278MS3ZJl14FFpA/kTFc9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6791
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle ping :)

On 4/13/2023 10:59 PM, K Prateek Nayak wrote:
> commit 66558b730f253 ("sched: Add cluster scheduler level for x86")
> defined cluster on x86 as the set of threads sharing the same L2 cache.
> cluster_id on x86, maps to the l2c_id which currently only Intel
> processors set.
> 
> This series sets the l2c_id on AMD and Hygon processors with
> X86_FEATURE_TOPOEXT, using the extended APIC ID and the
> "Cache Properties (L2)" CPUID (0x8000001D EAX). On AMD and Hygon
> processors without X86_FEATURE_TOPOEXT, current behavior will continue.
> 
> Following are the changes in value reported by
> "/sys/devices/system/cpu/cpuX/topology/cluster_id" on a 2P Milan system
> (2 x 64C/128T) where L2 is per-core and SMT sibling of CPU (X) is
> CPU ((X + 128) % 256).
> 
> - tip:x86/core
> 
>   $ for i in {0..255}; do\
>       echo -n "CPU$i cluster_id: ";\
>       cat /sys/devices/system/cpu/cpu$i/topology/cluster_id;\
>     done;
> 
>     CPU0 cluster_id: 65535
>     CPU1 cluster_id: 65535
>     CPU2 cluster_id: 65535
>     CPU3 cluster_id: 65535
>     CPU4 cluster_id: 65535
>     ...
>     CPU254 cluster_id: 65535
>     CPU255 cluster_id: 65535
> 
> - tip:x86/core + this series
> 
>   $ for i in {0..255}; do\
>       echo -n "CPU$i cluster_id: ";\
>       cat /sys/devices/system/cpu/cpu$i/topology/cluster_id;\
>     done;
> 
>     CPU0 cluster_id: 0
>     CPU1 cluster_id: 1
>     CPU2 cluster_id: 2
>     CPU3 cluster_id: 3
>     CPU4 cluster_id: 4
>     CPU5 cluster_id: 5
>     CPU6 cluster_id: 6
>     CPU7 cluster_id: 7
>     CPU8 cluster_id: 8
>     ...
>     CPU126 cluster_id: 126
>     CPU127 cluster_id: 127
>     CPU128 cluster_id: 0
>     CPU129 cluster_id: 1
>     CPU130 cluster_id: 2
>     CPU131 cluster_id: 3
>     CPU132 cluster_id: 4
>     CPU133 cluster_id: 5
>     CPU134 cluster_id: 6
>     CPU135 cluster_id: 7
>     CPU136 cluster_id: 8
>     ...
>     CPU254 cluster_id: 126
>     CPU255 cluster_id: 127
> 
> Note: Hygon maintainer Pu Wen <puwen@hygon.cn> has confirmed that the
> same strategy of setting l2c_id works for Hygon as well without
> requiring any change to the function
> (https://lore.kernel.org/lkml/20230411122348.GAZDVRVNvbbS8F5NUB@fat_crate.local/)
> Call to the same function has been added in the Hygon topology init path
> too. Pu Wen, can you please test this version too and let me know if the
> behavior is still as expected.
> 
> The series also adds documentation for clusters on x86 platforms and
> applies cleanly on top of tip:x86/core at commit ce3ba2af9695
> ("x86: Suppress KMSAN reports in arch_within_stack_frames()")
> 
> ---
> o v1->v2
>   - Improved documentation of cluster based on Peter's suggestion.
>   - Renamed cacheinfo_amd_init_l2c_id() to
>     cacheinfo_topoext_init_l2c_id() and added the call to same in
>     Hygon's topology init path.
>   - Collected tags for Patch 1.
> ---
> K Prateek Nayak (2):
>   arch/x86: Set L2 Cache ID on AMD and Hygon processors
>   x86/Documentation: Add documentation about cluster
> 
>  Documentation/x86/topology.rst   | 27 ++++++++++++++++++++++++
>  arch/x86/include/asm/cacheinfo.h |  1 +
>  arch/x86/kernel/cpu/amd.c        |  1 +
>  arch/x86/kernel/cpu/cacheinfo.c  | 36 ++++++++++++++++++++++++++++++++
>  arch/x86/kernel/cpu/hygon.c      |  1 +
>  5 files changed, 66 insertions(+)
> 

--
Thanks and Regards,
Prateek
