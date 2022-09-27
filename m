Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83ED05ECF38
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 23:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbiI0VWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 17:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbiI0VWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 17:22:33 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC321E1CE8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 14:22:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9gt4x2yDVxzQdn5RF4Bqq/fhfVusdBturqPczYHFWvPEOBMWyETISMkCUh3SUATpbX1c6tBOUyWbdf3T9rAIxfLs8uZp3FT+9JqbHtxghpxnYpfdicIh9CEJVSKCAuJYj2d6Bewb2elmZ40uCvDf5/VqJ4rljSOfkywGXu+MNf/XTjazURBmNF55XMKKL8XgomusXVajm+TlTzZ5Bc4SvoYgx79rCOc4mX5/FWRUhznE8OBCaErXbDDUaYY26HzpLTK3FkRyuVnrYL0S9tLcqqoGEv+blo1u2qskd9rE+he4lyFQPVPXrkGga235+tzxIWOQCerTXTpu9ZnkOG/OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7n1jw4sMICB89bK34r16G/IspEnEM0NL5EyVn85boR4=;
 b=STebcsqnqRMSwVa4KqEPFiDkG7wucF5hkWO9EdAAT6MyWTqDxHHc+uK195rCw7efC0HQNYhl3dCsZcymxNADgNifQTaGX7uWVBcjj1V7Aot8OcZ1NUaqwmTz08nIgs/A9qlbof2yn+7hXE99sFpQhXDibmVmdJ19WhPObOgVKSO8nzKcEfdnzUvfCOS+6Joa9m9DhKGZ9AWaUJbMXt0WY/u50qiwz4KFlD7LJDpr+o8FQZgmHWIXCSqfg3lQkuR9r730gE1Bohv2LwSBHrEuJZP5exSeyYWDPVBFdKe23Lbc0MKJP29J3K/J5LqOadv4WS0H6MDvMABWuKoYo4hGMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7n1jw4sMICB89bK34r16G/IspEnEM0NL5EyVn85boR4=;
 b=ZLPUjJbANO/O7935uE/bJSVAdAH5nLRE1iIP3Yxpk7GiJCBScuhaizhE/WwP21lqI2TUTQQMPkHJIGtpvi+7Dm2cI70c5lhfrXd+UfuNCJ82E6TrqTvdeYtGLvPWuOqd1n8QdD4gxLMt/+3FtAKg3au4sO+ZLekbTrpFXKddqIlxQ+ORlEV1u+l+K709Ju//bS7risTARyFhIOhqJSxD4GUJRPgwOUUEtDcN9mhdaiyL+hQny98V0oL38FASDM9ey0vikhryA/CVwcEo1AHW4SqqGDHZBk515etRi0Qzc2VaHz45/UQ6GoL/7t1nYluBgaPQm2hCOPerxaNWVmluvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by MN0PR12MB5907.namprd12.prod.outlook.com (2603:10b6:208:37b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Tue, 27 Sep
 2022 21:22:30 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::51d9:c02b:e5a1:254b]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::51d9:c02b:e5a1:254b%5]) with mapi id 15.20.5676.017; Tue, 27 Sep 2022
 21:22:30 +0000
Message-ID: <7db06e3d-5e00-2b8e-ea46-fbcdb82c4416@nvidia.com>
Date:   Tue, 27 Sep 2022 14:22:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFC PATCH v2 2/9] mm: pgtable: Add sysctl to enable COW PTE
Content-Language: en-US
To:     Chih-En Lin <shiyn.lin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Tong Tiangen <tongtiangen@huawei.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Li kunyu <kunyu@nfschina.com>, Nadav Amit <namit@vmware.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Minchan Kim <minchan@kernel.org>,
        Yang Shi <shy828301@gmail.com>, Song Liu <song@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dinglan Peng <peng301@purdue.edu>,
        Pedro Fonseca <pfonseca@purdue.edu>,
        Jim Huang <jserv@ccns.ncku.edu.tw>,
        Huichun Feng <foxhoundsk.tw@gmail.com>
References: <20220927162957.270460-1-shiyn.lin@gmail.com>
 <20220927162957.270460-3-shiyn.lin@gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220927162957.270460-3-shiyn.lin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0034.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::9) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|MN0PR12MB5907:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e5d6da1-7cec-4617-1122-08daa0ce6268
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I+N5fnPGNLgJlwYbus2rgAq9jwr+8yAW1ilnSwGwS7X82+TSXAIvdQj4ftfqXCwQad9cT1ZW1+RYGMuhSQ+G8nhdStPkuSYL8Gn5HPr43f+TS8/8/CrpIM63cW6iaNJANwsVxtIds4Hdl6bTuufcE3z1B+kHh3LlOz6DHwPeKzV4CN5japsFRbArhLGKXG2OBNkzy0Klg6/uqdysi7IS6pBtJKuUTDw4wLu2MOgyj4109xJKwr8TQSc1mAK4X/c+S2YRYsI+6EVqLT5SB4gf42+OjfwSH9DFcSkl77QfR65tWgamoXv7ZW027spS8ij4C+bAN8KjNeIHP3NUsILgakJ0wIkvqNkpmlZ/wqFDEslGBwPxmKKZtIqySc72GhIcMKKPJckRKfQ03SjLerpk7Xc9mO+J571G82ooUPNLUTeGFcoHluuAaEqfU/XML9voLvTyDTetEowh7Qu1L7/6lZ7fwnkljQdo8lQgWl1RSByrcS6+v01NPOYoHALMzPP9OwT+rJZqqN4AuBUzF7GKPnWLy3VJC20TZJ5Ifd4diFmdF9mvRr+zTFvojDpBLhO2jqO8pCeToL7vRc5ELZWAtyfCXbH1ttFB7F92ewMHBYHRnu5NsNUUtSV5IdtdhrulWIFFfdCvFqnwqM23NNTZ3M02Yae2bysR9ZbjsuPysMDfSZvLhEQABxcsejx3n1Q1tjnievK7WSLZjh22B+t2Javgc6yFpdsxFg+Z3lEAiHD1tuqsOZgo62ZLU0LoDloTlYjVqZhJg57sXuW4/NKLaULO2rbsVgCBnsjBLAftoX8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(366004)(376002)(136003)(451199015)(26005)(7406005)(6512007)(41300700001)(36756003)(53546011)(5660300002)(7416002)(6666004)(2616005)(2906002)(66946007)(8936002)(66476007)(66556008)(4326008)(8676002)(6506007)(38100700002)(86362001)(31696002)(186003)(316002)(110136005)(54906003)(6486002)(478600001)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUtoLzRBTzd3RnBJRTRMdVMzNDNDOTNZK3gwYjR2UTJMaDNlZlQ0a3R4cklk?=
 =?utf-8?B?ZFRHSmorSXNweUVJZWxLdGtiV3M4aS9yeWw4UjV2OTZIS0ZKSDNySFhsbERM?=
 =?utf-8?B?R3I0SkptSHlORjJESm51QzJoTUhCbEFTR2xTVDJXWlRaemtneVFQWlBzZUZo?=
 =?utf-8?B?NGZrQW5nSm9JaW9DSFdlbUxBTE1aWCtmZU91MWxvQ2wxRnM4TGgzcVBOWjFm?=
 =?utf-8?B?SjVaem1XK2FONGRZZ3p4bWwzNGo3M0lvSGxGNWRIUU5lbUVVR2RRLzhSRSsr?=
 =?utf-8?B?bUhnMGdYd25WbFQzcyt3Q2p4TjZJQ3g1WWQ4cFNJeDdjM2s1MTlwV0VqQUFB?=
 =?utf-8?B?NWhtTVJuZFJuZzY4eFArK3poM0o1V0ZZZEwxUlV2SDdRQThOSm5XRVpkNmFW?=
 =?utf-8?B?dGROUVJFQ3BGeFk4K2ZTLzVjWFo2cXAvVU1vVXUvVE5IMWVEcDFkYUtud3d6?=
 =?utf-8?B?MzZuSTN4YnA3WGl4cXNWV0RLRThQNWpIRHBPckliRlZhdFhEbHFoYlhKQ3Bx?=
 =?utf-8?B?aStaeWxnbi9WVVJpYVg5UytqU09LVi8zTElaZVBGMkRBbTMzWTk0eHhKR3JG?=
 =?utf-8?B?azQwalA1TzgzUWJWZDVMemxHb25UNmNQYkV6ZFVlOW5zT0lnWFh3Y3REaEww?=
 =?utf-8?B?dlQxdnRJZ1ZhNHBJRS8xSmdmVWdTNk9NRGtPcmpsdElnM1BUWXd2aCt2Mndw?=
 =?utf-8?B?UERsN1docEZVaWg5aFk2Si9wT0k0cTJlaEtmMkVWWXF5NkRmOHBBZFVkVzE1?=
 =?utf-8?B?MHhqdXBTQXR1MXlIem1EdExtM2d4TDlGOVgzenNpWW1TRXUxK09qbzN1aXk0?=
 =?utf-8?B?UkFGWXh3dEpNRkd2RDA1dGRjVzZiTXAyMUtUOGF4RVVNNlNCcDQybStzamJJ?=
 =?utf-8?B?RE5DbVdHaEI5K3g2Vm8zMXkvOEtSb1FCTUFSVDVVd1R6VU1weUg0ajBwTmIr?=
 =?utf-8?B?THgrTjk4UEwzUFNBUmo1ZlVaSFNHYmp5d0hvenF1UWRaL05sZkd4bGx6TUNG?=
 =?utf-8?B?OU9aZ2d4eFR6Ukw2TkpLR043RHIyZWd3N0l6bWtrV0orbFo2M0RSWE9sdEY5?=
 =?utf-8?B?aWcwbnk5OFQrREp0eHVPeTR3SGRSbVJHSkNNMHozalNuRFJkTURKVVJuUFhW?=
 =?utf-8?B?QVpjNGFTKzVZNVliajBmY1NzWm9XL3o1RWFIMkIzQ0xWd1plTkszdjVURnBa?=
 =?utf-8?B?RlgxOVdJeGxTbzFMbTA1amc4enNDanppYzJQL0ZQQy9FOUdTWGxlV01Ta2sv?=
 =?utf-8?B?bU8rRGdQWTFlN1djY0Fyb1BUWjgwREtzdGpEUDB5b2ZmWkh3VnRubkRUdm9W?=
 =?utf-8?B?Z25nZjlkdG1WR0t0NFkrNzRJS0JCMmljWnlXWnhocTYzVmJGZUVhWkJnRWhC?=
 =?utf-8?B?WXE3UkdKRHUrRXdUUktISEdyY2RwVG5oUjducnpmcGZPS0M5M1UrT2hJUlAx?=
 =?utf-8?B?ZjlxY24yU3h6cjk4THlkOGZud090VlRpZi9QVWt5emd6T3NXc051aWRyanVW?=
 =?utf-8?B?NExDZElqZkNIUmVnLzRwRHJRYm1nMVdGa2pkV3gzVUM4QUFvK0ttMUN0QW04?=
 =?utf-8?B?R001akVkNFdXSlJsMFJGWWZYazI0cVM5L1B4K2tQY09DSzFDbm1EaEpKamtQ?=
 =?utf-8?B?UzQ2RWVUR3hJdlJXYVNHbXlFT081R0tINzV4TEFtR3NBQkE5SGNZZ2NGbEp0?=
 =?utf-8?B?RjJFcE1HdUMzeDFXRHZTSTI5UGpDY3V6THpsdnplaTRSYjhIOWlXZSs2SW5m?=
 =?utf-8?B?aThCNW5SVGVQeTFDQnVoMnVpVUZ1SnBHdjhaSTh3WHdIV1R4YVJQTzE5VHZS?=
 =?utf-8?B?dkVSVWk2K3NuUVVxL0ZYN05qaWkrMDgvTUlkQjZwT1VxN2hNcjRXbmpJeXg1?=
 =?utf-8?B?YTVzUHdUL0VMc0N1MVo4TmNjZncxWDloZ1JuNkFqYTI3cEsvUlROTXErTjk0?=
 =?utf-8?B?ekpoKzI2S3NvcUFYV1YxODFmSWxaekMvYndTaTNDWFRldzZXbFV6Tkg5Um1y?=
 =?utf-8?B?WWJCWE85S05ieXVPY2YxWVVNNGZlYmlqMDMyQlc0ZWdMSkF0SlRncXd4NXN2?=
 =?utf-8?B?eGlXKy9vTnIzUnRMdmVEQTdxKzZmK3J1VXlhbUdTZWVUSmg5TUFLeEQ4RmpV?=
 =?utf-8?Q?5Xp/J9bsdZdirizz2iEfrJ5jH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e5d6da1-7cec-4617-1122-08daa0ce6268
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 21:22:30.2759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HylrN2uKMGbLKVVNSbvybB6v7lk84MfhGp12Or6ZDghoM1gsxMC8IInWitkn331mmbQLVtk/SlGf0huvGwtmGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5907
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/22 09:29, Chih-En Lin wrote:
> Add a new sysctl vm.cow_pte to set MMF_COW_PTE_READY flag for enabling
> copy-on-write (COW) to the PTE page table during the next time of fork.
> 
> Since it has a time gap between using the sysctl to enable the COW PTE
> and doing the fork, we use two states to determine the task that wants
> to do COW PTE or already doing it.
> 
> Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
> ---
>  include/linux/pgtable.h |  6 ++++++
>  kernel/fork.c           |  5 +++++
>  kernel/sysctl.c         |  8 ++++++++
>  mm/Makefile             |  2 +-
>  mm/cow_pte.c            | 39 +++++++++++++++++++++++++++++++++++++++
>  5 files changed, 59 insertions(+), 1 deletion(-)
>  create mode 100644 mm/cow_pte.c
> 
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 014ee8f0fbaab..d03d01aefe989 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -937,6 +937,12 @@ static inline void ptep_modify_prot_commit(struct vm_area_struct *vma,
>  	__ptep_modify_prot_commit(vma, addr, ptep, pte);
>  }
>  #endif /* __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION */
> +
> +int cow_pte_handler(struct ctl_table *table, int write, void *buffer,
> +		    size_t *lenp, loff_t *ppos);
> +
> +extern int sysctl_cow_pte_pid;

So are setting a global value, to a single pid?? Only one pid at a time
can be set up? 

I think that tells you already that there is a huge API problem here.

As the other thread with Nadav said, this is not a sysctl. It wants to
be a prctl(), at least the way things look so far.


> +
>  #endif /* CONFIG_MMU */
>  
>  /*
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 8a9e92068b150..6981944a7c6ec 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2671,6 +2671,11 @@ pid_t kernel_clone(struct kernel_clone_args *args)
>  			trace = 0;
>  	}
>  
> +	if (current->mm && test_bit(MMF_COW_PTE_READY, &current->mm->flags)) {
> +		clear_bit(MMF_COW_PTE_READY, &current->mm->flags);
> +		set_bit(MMF_COW_PTE, &current->mm->flags);
> +	}
> +
>  	p = copy_process(NULL, trace, NUMA_NO_NODE, args);
>  	add_latent_entropy();
>  
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 205d605cacc5b..c4f54412ae3a9 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -2360,6 +2360,14 @@ static struct ctl_table vm_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= mmap_min_addr_handler,
>  	},
> +	{
> +		.procname	= "cow_pte",
> +		.data		= &sysctl_cow_pte_pid,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= cow_pte_handler,
> +		.extra1		= SYSCTL_ZERO,
> +	},
>  #endif
>  #ifdef CONFIG_NUMA
>  	{
> diff --git a/mm/Makefile b/mm/Makefile
> index 9a564f8364035..7a568d5066ee6 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -40,7 +40,7 @@ mmu-y			:= nommu.o
>  mmu-$(CONFIG_MMU)	:= highmem.o memory.o mincore.o \
>  			   mlock.o mmap.o mmu_gather.o mprotect.o mremap.o \
>  			   msync.o page_vma_mapped.o pagewalk.o \
> -			   pgtable-generic.o rmap.o vmalloc.o
> +			   pgtable-generic.o rmap.o vmalloc.o cow_pte.o
>  
>  
>  ifdef CONFIG_CROSS_MEMORY_ATTACH
> diff --git a/mm/cow_pte.c b/mm/cow_pte.c
> new file mode 100644
> index 0000000000000..4e50aa4294ce7
> --- /dev/null
> +++ b/mm/cow_pte.c
> @@ -0,0 +1,39 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/sysctl.h>
> +#include <linux/pgtable.h>
> +#include <linux/sched.h>
> +#include <linux/sched/coredump.h>
> +#include <linux/pid.h>
> +
> +/* sysctl will write to this variable */
> +int sysctl_cow_pte_pid = -1;
> +
> +static void set_cow_pte_task(void)
> +{
> +	struct pid *pid;
> +	struct task_struct *task;
> +
> +	pid = find_get_pid(sysctl_cow_pte_pid);

This seems to be missing a corresponding call to put_pid().

thanks,

-- 
John Hubbard
NVIDIA

