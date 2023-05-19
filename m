Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D9370910E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 09:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjESH5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 03:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjESH5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 03:57:02 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F51DC
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 00:56:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WS5J9XtdUTMPS1VuYiHAKEmCLMERZhWP+ZuSAUuzDXg5F4vAKxUE8VNeejqof2yxP8z2Nam9GDuNoV+OY82l4pLrAnaAg4YHN7jyNVCxKULK6Eof4ofzHzqx+pPUGibz32spWYHRtboS+RD484+ge5zAYUuIKb3w/1QT5x13Dr0JKTy7N/ShocKl1etSJPOeCaRefuzaXEvth3INFvhFE2X1zAp/+TAGJN25GeVT3WGI03ipZ1huG99LznsH+WyshnzcGOaQF+AmcxH77VF55zBCgLgQiG26N54gM1WOV39ysjFkgPmk/TCt7BoGG2XmcUtgkikNUkly8eWL0fhpBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NTmaBXc3bVbFP7YcP5dFAQy/Yojx9SPnVeOVoeIO+EY=;
 b=GSvHEk3rPoUK9URyT8XajWvj5S4rzxeZb2o8TurVTBBps35OXhFWtC7SQPTY4DqTVVIhyXW4dPP6+8Oqxbt3DTCfh6fjeRmBm0NHzF31UEwJdx5yalFWRojnCYYLQQ1msKqx6A3SWuITw3Nfa23+xC5ENaHdwGmQq5kgShiZbbDKu0XfDp+AZ30lnhwaUgbbrBGCIHK7G4vKo61mSdoNmG5+4QUlbZQnjS7uAAseNGsojcmwgRl8+oPORqeifvmou5ngFtFuhhEzrk39b9CTo5ooWWF74w21cA+BiAgMI7qNHv4KTahtkt3dAmjajw7DNTfsd4VaO43NLIBgc/Yh9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTmaBXc3bVbFP7YcP5dFAQy/Yojx9SPnVeOVoeIO+EY=;
 b=rq5rqTQrxMqYw7OQbrfFJtP2WfFhv7ED0PTGW2OyNiIHYeIUPpZPyUGsEDa4ouFDjdI8gSjRUFcEoZNOWVfZZGhYeueB6QAYqdQqjPEeFFvFiMPU0f9VfRRJRLSobEhRs6GbohpJ0ylzD3Op1jTzZ8bvXaguvrYAqTHVO2wE1+Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by BL1PR12MB5223.namprd12.prod.outlook.com (2603:10b6:208:315::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 07:56:55 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::e58a:85b5:25a4:8cd2]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::e58a:85b5:25a4:8cd2%6]) with mapi id 15.20.6387.033; Fri, 19 May 2023
 07:56:55 +0000
Message-ID: <226b9290-deea-53f5-54b3-42ee52c67e1d@amd.com>
Date:   Fri, 19 May 2023 13:26:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH V2 1/1] sched/numa: Fix disjoint set vma scan
 regression
To:     Raghavendra K T <raghavendra.kt@amd.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, rppt@kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Aithal Srikanth <sraithal@amd.com>,
        kernel test robot <oliver.sang@intel.com>
References: <cover.1684228065.git.raghavendra.kt@amd.com>
 <b0a8f3490b491d4fd003c3e0493e940afaea5f2c.1684228065.git.raghavendra.kt@amd.com>
Content-Language: en-US
From:   Bharata B Rao <bharata@amd.com>
In-Reply-To: <b0a8f3490b491d4fd003c3e0493e940afaea5f2c.1684228065.git.raghavendra.kt@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0141.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::21) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|BL1PR12MB5223:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ba029e5-c96f-4387-efe9-08db583e9cfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K/bY6GtfXu6L8cfK/Jo1GeuYhiQqKDqvjtwAfo+ql3usplW60MydnfnUX5Gpdu2EGLkGFHxBJQKiqybNEx4ASsqZFUQeLWdmrx8TMNeYJI/T/gVe3Phtl06KcOz1ix3YfJfVKnPSt/R3SrE7qp2IT8XFCaMvQWMUsi3P35sOjrBqUg5EwwURjgtbCn8TOwyUI5fryjCodb5PTwF+6QcBO2oSnEtwuIO+nkmYfXep8OYfqL3DR4kKI0nq5P0KrSMgGa6HLWKHhwyukfwew7iWyDBg9DIm3s4HzApaC1mvUFVZwYQAA46AcPkqAM+e2SyX/t778iCsU3irO29Vq0t9Cm+Deq95zKY6K2PjeicwLIl8heA2kjNFOua8MbrJI8vuAEMKEn5I6mVQl/NzXmPRTupMVhhW8oGFs+FJPdcuErCZb99bETZ13o1gGWI7kOc31d0y2E4Ec/X/hhEyKgo7gUAyws3GBgeeqCSvg7h8muAjpTkg82OpJX31EA7LKfrMx5mdyvID4WASUr2KKqOUpuIF0hnYZwKQ5n9jAJ/jWaneoHCjDvgMhbtLPEBksx8YT2dunOocc5AtkQIIMaWt78dRSf3GdIVMrB2QJrqV+dFZq5CxA/IUIBh0cEiHX9ZStpklZ2DmGY2pETaXEKC29NUbtaJznNyGJtGSP814rMw1L3SfY1OGyiRCMzXghQC1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(451199021)(966005)(6486002)(6666004)(38100700002)(53546011)(26005)(186003)(6512007)(6506007)(2616005)(83380400001)(36756003)(2906002)(66556008)(66476007)(66946007)(316002)(4326008)(86362001)(7416002)(8676002)(8936002)(31686004)(5660300002)(31696002)(41300700001)(54906003)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wm9wMTlKQjZadGxyZ0x1ODZTVmRyUFV0dlNJcGFKYloxeEVVYnhWdkhueW0x?=
 =?utf-8?B?TkZQUTZtTENQbXNJLzl4ZEtQSkZWM3Z5TjNLWUFHV3hrWExsL1cyaElMdmpp?=
 =?utf-8?B?K0ZOZ2pZajNQa1BsYXVKWnhhWnlVQllWVXdpdHdWQUEzaFhSbXI0b01SdTlS?=
 =?utf-8?B?V0JYYUV2QkxGeS84emlBSDNESjh1VVNFR3BGSlZwN0F4dGUySmJ4RVU1ZkEr?=
 =?utf-8?B?QjNTVXVtRm9oRjMyTEV0bWFEM2ZoSStGOFJBSkI1Vkt6YW1MazRkOUZ2bEEz?=
 =?utf-8?B?emZrSDB5bjRVdURjVW90dW54OFBxZ1RFODRvbzdQeHVJN2tNVUw1WlBzT09t?=
 =?utf-8?B?WHVXMlR2MnQybnJReEVuMUNGM01SOTkzQlBoTjhSSkJaVkNLd3dLVHVLUVVj?=
 =?utf-8?B?c3p4U0Q0ZnI1cUUxVXo0dXJwQXJtUWhOZGlaZlRuZ3N2aXpBam84dEFmMHZa?=
 =?utf-8?B?djJlOXN6ZnpZdHIzdFNGN3gxdE5HSlc4VW9lU25RN25ZSnMvS0RGWFU5eGRM?=
 =?utf-8?B?Wks4VUxiMGVja1k4VGxNWlAxdk9UeWtpQUhhTDRidS9TZERQU1FhU3hZaXc2?=
 =?utf-8?B?Q0loQnhsWEVSVks4ZWRvTS9ES255NllBTktBT2VmYlljZzJmRHZzNVcxRGUz?=
 =?utf-8?B?bW5WVDl3ZFJTZWZyLzZHaEVnUm8xUko0bit2Nm96Y0Q2VkhhRkxKTUtJTWFs?=
 =?utf-8?B?SGQxUzFsaUt4Y0hnNU84S3dnS2VJMERlR0FFK0VPMFd2T1lkZ0tIWlR6OTdT?=
 =?utf-8?B?VHhXRGp1bWhzUm1Pa0M0amlrNXJUTlJnaGluUWJGR1o2TUdlTlprZzRiUWsr?=
 =?utf-8?B?TzFRUlJXbXdpY1dKeHpmbkYwc1JtRnhBV25NUWNUdTcvOFhPNWJvNElRTUZy?=
 =?utf-8?B?MzA1UFJoZEx2SG8vMDNidkx6Q01yOGZSMDNLSlE0VDYzQTBHTDBWOVQwaVlQ?=
 =?utf-8?B?KzhmakQwbnc5R1NZcDFUeXIzeGlQeXhERDc2MzQxNnRuSWhmWXJFU0I2VTFy?=
 =?utf-8?B?V1hnSDBNcThwRVlmZEdsV0ZxYjlLL21DVG9DdzN0aFZaMGYyZjZmV2FaZjFN?=
 =?utf-8?B?WnRDbElydDRtaHpHdkIzbWxqY1Zmc2x3azNmdW1vdWZ6RnVHNGUvajRTNnVG?=
 =?utf-8?B?aExoankrSGU1YjRyaFNYTGlQQ3UrNktPTTNwS2ZpamJBVkhRc0VXN1NYRW9T?=
 =?utf-8?B?UVRpcFd1MG1majBMNXhQaHc0M0lIcnBiZ1VLNzE5VXA4MDQ0ZWUwYllSd25N?=
 =?utf-8?B?ckF2OEZyOFlxaUxxQkpqbmUrZmRadERtUGkzYUlQRzI4MlRrTjFFS0FlS2Fu?=
 =?utf-8?B?WmlTZDAzNHFKSENPaThaTlIrOW9lT3ZPclI4L2hYL3ZYWWFOY2MwVWtrQ0Z6?=
 =?utf-8?B?TGJDYklJQUpmQjQ3Y3M3VENSVU83Q3FPKzMvd2hBeFhBTWtoYUkwZHY3eVBz?=
 =?utf-8?B?Uk9QVnpIZmptVyt0UHdxTm1vWDNrN2N5RWR6WnlHYk5OOHh0RWxHVkZyN2hN?=
 =?utf-8?B?cXJvV2lNVCtXWkFOVWFaRUZ4bllaRk4ya2xVYjhWRE1mOHo2VUZQSWxab3Ir?=
 =?utf-8?B?Yk9INUtaK05NSkNNVS9SSlJQT1ozUGxDSlcxekx5STNqcHJGWC9HTWpmTWpG?=
 =?utf-8?B?dXZmWnFKQ1QyakhEb1lMTXkwMVp5TWQ3eGhpN0ZEYXRDSU1vQ3RBVFdTYW1i?=
 =?utf-8?B?MVpZUFIzQ1NRS0R1dG9oNlB2L2tma1hsMHR0d3NFaGxVcGpOejB5RlpRYXli?=
 =?utf-8?B?cGdMdXFPVE4vOG8xUVpXdGQ1d2FOUUVPalJHMWhFM1M3b3pvL2pYNGR1OVN1?=
 =?utf-8?B?d001KzNaWXlWVFI0UzlkNzhtQkZ5UVBXRDJqMnA0N1ZjWFF4T1V4VGluVVBG?=
 =?utf-8?B?a3Ayak5qYjJYYk1TbUVScjI5WUNXNkkyMmdQczczN01uVHUza2NsZ3lKbXd2?=
 =?utf-8?B?L2JRUUVVMWRrQjVkcDV2UjI0M3hzREt2QlQ1MnBIeEh6MDlNbVowUXBMeG1B?=
 =?utf-8?B?UU5NWlRKUENiL25EYUZiNzRNLzZmUC9yOUVTdzFoNHljRGhMeXpoN1pUbkxE?=
 =?utf-8?B?RkxDSjU2bXpPOEczY042dzRQOVQySDJDaVFwM2FyYTNFUXFpa2FuejlEakhD?=
 =?utf-8?Q?kirEQ5k9EtI+m0YEbtR0cvgFn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba029e5-c96f-4387-efe9-08db583e9cfe
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 07:56:55.2682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LNTs3wkSAaKFj3rlI1HygBLWkmwG/o/ByQqywv1gcxkJxsie2ESDUb/DMLnaW0/fFMmWSapRixTrhZ6FMMO1CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5223
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-May-23 2:49 PM, Raghavendra K T wrote:
>  With the numa scan enhancements [1], only the threads which had previously
> accessed vma are allowed to scan.
> 
> While this had improved significant system time overhead, there were corner
> cases, which genuinely need some relaxation. For e.g.,
> 
> 1) Concern raised by PeterZ, where if there are N partition sets of vmas
> belonging to tasks, then unfairness in allowing these threads to scan could
> potentially amplify the side effect of some of the vmas being left
> unscanned.
> 
> 2) Below reports of LKP numa01 benchmark regression.
> 
> Currently this was handled by allowing first two scanning unconditional
> as indicated by mm->numa_scan_seq. This is imprecise since for some
> benchmark vma scanning might itself start at numa_scan_seq > 2.
> 
> Solution:
> Allow unconditional scanning of vmas of tasks depending on vma size. This
> is achieved by maintaining a per vma scan counter, where
> 
> f(allowed_to_scan) = f(scan_counter <  vma_size / scan_size)
> 
> Fixes: fc137c0ddab2 ("sched/numa: enhance vma scanning logic")
> regression.
> 
> Result:
> numa01_THREAD_ALLOC result on 6.4.0-rc1 (that has w/ numascan enhancement)
>                 base-numascan           base                    base+fix
> real            1m3.025s                1m24.163s               1m3.551s
> user            213m44.232s             251m3.638s              219m55.662s
> sys             6m26.598s               0m13.056s               2m35.767s
> 
> numa_hit                5478165         4395752         4907431
> numa_local              5478103         4395366         4907044
> numa_other                   62             386             387
> numa_pte_updates        1989274           11606         1265014
> numa_hint_faults        1756059             515         1135804
> numa_hint_faults_local   971500             486          558076
> numa_pages_migrated      784211              29          577728
> 
> Summary: Regression in base is recovered by allowing scanning as required.
> 
> [1] https://lore.kernel.org/lkml/cover.1677672277.git.raghavendra.kt@amd.com/T/#t
> 
> Reported-by: Aithal Srikanth <sraithal@amd.com>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/lkml/db995c11-08ba-9abf-812f-01407f70a5d4@amd.com/T/
> Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
> ---
>  include/linux/mm_types.h |  1 +
>  kernel/sched/fair.c      | 41 ++++++++++++++++++++++++++++++++--------
>  2 files changed, 34 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 306a3d1a0fa6..992e460a713e 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -479,6 +479,7 @@ struct vma_numab_state {
>  	unsigned long next_scan;
>  	unsigned long next_pid_reset;
>  	unsigned long access_pids[2];
> +	unsigned int scan_counter;
>  };
>  
>  /*
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 373ff5f55884..2c3e17e7fc2f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -2931,20 +2931,34 @@ static void reset_ptenuma_scan(struct task_struct *p)
>  static bool vma_is_accessed(struct vm_area_struct *vma)
>  {
>  	unsigned long pids;
> +	unsigned int vma_size;
> +	unsigned int scan_threshold;
> +	unsigned int scan_size;
> +
> +	pids = vma->numab_state->access_pids[0] | vma->numab_state->access_pids[1];
> +
> +	if (test_bit(hash_32(current->pid, ilog2(BITS_PER_LONG)), &pids))
> +		return true;
> +
> +	scan_size = READ_ONCE(sysctl_numa_balancing_scan_size);
> +	/* vma size in MB */
> +	vma_size = (vma->vm_end - vma->vm_start) >> 20;
> +
> +	/* Total scans needed to cover VMA */
> +	scan_threshold = (vma_size / scan_size);
> +
>  	/*
> -	 * Allow unconditional access first two times, so that all the (pages)
> -	 * of VMAs get prot_none fault introduced irrespective of accesses.
> +	 * Allow the scanning of half of disjoint set's VMA to induce
> +	 * prot_none fault irrespective of accesses.
>  	 * This is also done to avoid any side effect of task scanning
>  	 * amplifying the unfairness of disjoint set of VMAs' access.
>  	 */
> -	if (READ_ONCE(current->mm->numa_scan_seq) < 2)
> -		return true;
> -
> -	pids = vma->numab_state->access_pids[0] | vma->numab_state->access_pids[1];
> -	return test_bit(hash_32(current->pid, ilog2(BITS_PER_LONG)), &pids);
> +	scan_threshold = 1 + (scan_threshold >> 1);
> +	return (READ_ONCE(vma->numab_state->scan_counter) <= scan_threshold);
>  }
>  
> -#define VMA_PID_RESET_PERIOD (4 * sysctl_numa_balancing_scan_delay)
> +#define VMA_PID_RESET_PERIOD		(4 * sysctl_numa_balancing_scan_delay)
> +#define DISJOINT_VMA_SCAN_RENEW_THRESH	16
>  
>  /*
>   * The expensive part of numa migration is done from task_work context.
> @@ -3058,6 +3072,8 @@ static void task_numa_work(struct callback_head *work)
>  			/* Reset happens after 4 times scan delay of scan start */
>  			vma->numab_state->next_pid_reset =  vma->numab_state->next_scan +
>  				msecs_to_jiffies(VMA_PID_RESET_PERIOD);
> +
> +			WRITE_ONCE(vma->numab_state->scan_counter, 0);
>  		}
>  
>  		/*
> @@ -3068,6 +3084,13 @@ static void task_numa_work(struct callback_head *work)
>  						vma->numab_state->next_scan))
>  			continue;
>  
> +		/*
> +		 * For long running tasks, renew the disjoint vma scanning
> +		 * periodically.
> +		 */
> +		if (mm->numa_scan_seq && !(mm->numa_scan_seq % DISJOINT_VMA_SCAN_RENEW_THRESH))

Don't you need a READ_ONCE() accessor for mm->numa_scan_seq?

Regards,
Bharata.
