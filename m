Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6984688B0D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 00:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbjBBXo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 18:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbjBBXon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 18:44:43 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1020825E22
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 15:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675381483; x=1706917483;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aDsmZV/jIIyNn0phTeUJDlOX6DwcDL2HqdvTVLYArAg=;
  b=PrnpnWl/XOe33BKu1bLqsyZfVKrbhCHZdqKNtpFtXXwrVQoSJwbeWcja
   iCeGNSfBEI2RBiunE1dgvZ76aXXebZv5jJcbs2++Y6zwVpSh8HAzKwKza
   Mebu8BpXCaR0HI4xWz5YyeY5/zkY1mA0KchP8fghmAl0g7OkGiwosdxj9
   RuubXz1JJMSV1TN83niCMh1LrevmftZfXGQm6RjBtg9NEN/59B6mlpaF2
   hqYK0d45M1cE8pneoan1X3d2KPj0476rIkecSedHlJXaWNd9TizkvJ/9R
   CYltn12eHV3Bj9gisJLWTMs/wycud/ucIOlmIeruNmB2qTwl9W8Vj23/X
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="327249715"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="327249715"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 15:44:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="665508298"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="665508298"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 02 Feb 2023 15:44:41 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 2 Feb 2023 15:44:41 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 2 Feb 2023 15:44:41 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 2 Feb 2023 15:44:41 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 2 Feb 2023 15:44:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QhFCOGITNUJqUCLmWFuZSrN/6lMdcgs7YuDKdbxIw6wnJN+DxOfAeIwIlCkfDhGCZyHAspCWPNbjygPlLzrlfMj6MENVckUrGGbEfVfMnmmtfSpsbnMuJ+smr4IfEqDfHGsT3QYJQkXPY4EKOGAqEstPBEDgxb+tCQALXiulEgfMI0RdRBZYXppkSEdiCgqKvBmAaqsJFvYCSztcXbiL17SlmLLw0R7EzgyA8awO919h0aWRDoEqtJM8G1q6KzenrsQKearhREwdlCo0VR1uhKMe1sDcah4qJHNPtX/YXdKWDQCS0TO+EPCjZ2Kh5e7R7VXIHf8lAg9/Da4jEoti4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/cB2ukJBGXdJXqopAWL9RyY0rOSr0B+YWyjZoUc26mQ=;
 b=XNelPnMoiQuArR/3AnWXrVP9zT3BPHrZhQ7ZYgue7YdMRMuEwVLcHzDKdVQAdEqPV7hwI4j0RJNakyZIZU3XsZ8j+RQ4PRliM4GPKYTRY3TKBhl6ME1rzI0+0qXNHKLMfUq717vkDhORYwsapm16c12fnEwqleLpX6cqJoW4nJoAGJQygpcmUK0m8mP731mBmx9mcHTWYx2Bj/nXU9i6pANvGPOZE1/n/PY/IMFHVTW3sLW+WpueFCL/aaKI8C8Ge5FegXlSsHz1a1dAPgyHK8KAGB0LnyklBKEz2DOpE/vEnLGeUiBc5l7yfnRPL6X5+8RMRvYhvohoxhvDovEVfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DS7PR11MB6175.namprd11.prod.outlook.com (2603:10b6:8:99::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Thu, 2 Feb
 2023 23:44:39 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.6064.025; Thu, 2 Feb 2023
 23:44:39 +0000
Message-ID: <8d56cbf0-7522-6718-a38e-164dee9464bd@intel.com>
Date:   Thu, 2 Feb 2023 15:44:35 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH v2 02/18] x86/resctrl: Access per-rmid structures by index
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        <carl@os.amperecomputing.com>, <lcherian@marvell.com>,
        <bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
        <xingxin.hx@openanolis.org>, <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>
References: <20230113175459.14825-1-james.morse@arm.com>
 <20230113175459.14825-3-james.morse@arm.com>
Content-Language: en-US
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230113175459.14825-3-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0127.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::12) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|DS7PR11MB6175:EE_
X-MS-Office365-Filtering-Correlation-Id: 094c0717-95b9-435c-8c17-08db057772ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eUG0fu6mNI2obe/osBOK9d1lH9Ndkk+eCuiVgq6/UaPRY1uus4WW/PHcxqvd93VLOQOtj5bHJvgHBqyxs2NH6bn4cm9e0AEtbsJx2bDS9ml28pkRFdSLEmeJWs8NbX7VcKQiJE22FmlsYr6wiVKEUa7XfjGP+PMueqo0FOyC5itKapNB2u0ZZOqBda0lCMg3lML+y8ezJwJd0hfMDsJGJYaVUtpQv6PyOFEJDLZ1DpV5vLVdRkBa4ATWtc7b7O9Li6gcA4twM/w20PsYTwvBMmkykpyVfwkDlXrwAX9xxb3NaPGEh6pzkeaYnOquA5qPfl/t1Vnb+M5cbFJZCWOIerIdp/1v35X08UJfyEPjqodsQOz8JSguNFc5f0Jds2BIRZTMIESfwTFXRbfgDPnxqI4hLKIIVwaybMOVqFzT83UBZTpqhgNylMkS5jup0rlgu7fmoh6cWWo4kuXN4pFgzROd0JTGR+uZDGeJl+oul2zLChOCyvMQhi+gG7MdbjSe6p3C/2VmDZYGmNcB+/qVVqFXDn8O2DsG7KgQ8+FYbJlRSeZeWnoLoMzuICNtM7sO9Tv969F6eFZfI8hCK9FKwis72oXlaDRr7NCGazo4cEpv25+90FrcqwpdvCCZtB/LHfoQKJ4p0O2wi/8XsKsxMn+eh2SLzvXfts2l7wPqWRHlK6lUdxr0lZc3YU6bG38OZEnGF93BIFkKaCt8HZzW/6htYQ8hVnLjRjOsns8AKBU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(396003)(39860400002)(366004)(376002)(451199018)(36756003)(478600001)(82960400001)(83380400001)(66946007)(8676002)(4326008)(66556008)(66476007)(54906003)(316002)(6506007)(6512007)(53546011)(26005)(6666004)(186003)(6486002)(7416002)(5660300002)(41300700001)(38100700002)(2616005)(31696002)(44832011)(8936002)(31686004)(86362001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elBEcEpPZHBTS0hNMXROU0pKazRLS0Y4a2VjblVtNzhpQ0RRYzRoc0hGY2xz?=
 =?utf-8?B?Smp6VnBEK0ErY1d3RWY3SEZNNmluZlNiZ20xUHNLN3U5OVBYMkU3bU1YU0hp?=
 =?utf-8?B?UjREUnplWktwaElkSEo4UWRWSENQTzErMlRFaE1UbWpobEhYWTErYjEzYnVV?=
 =?utf-8?B?VlU4RFA1cVlER0kyaXk5c0RuMUE4NVg5Tmozd2UzMEFwZlhDdklmNzRkWGJS?=
 =?utf-8?B?b3Q4WWtRT1hnM0k4aTJpbE04QnU2SmFPa0M2Nk5qMnpOU0FKaXk2aklDdGtB?=
 =?utf-8?B?WTAvWjVSaWtzRjZKVmhpM0pWTWR1d2tTVHFzeC9kdGtCMXBsMWNNUE1VT2VN?=
 =?utf-8?B?eVdCSWRzTXE0TTNqYmpzYmMyM04yaEptcTVnTmtGMGlNeHFrMzlXdWJSWW50?=
 =?utf-8?B?TkFqQmc3aEtkb1FKa2dLV0VmVlZUeUY5VDA4RU10ck5yUEs5aXBBbDJoMk9U?=
 =?utf-8?B?SFZCRG1xaU9XU0FXeEJpMXRZNmhZRUliWkt2ek1ENHJNUzIwRFhSSGF0NlA2?=
 =?utf-8?B?YTZoVm9KaHY3eVlnci9Idk1US0szY2phRWZHZnlYaGlTK2dDdkpRRDF2cnI3?=
 =?utf-8?B?UDRPMGo2b2RxcGkxM2k1WFIwNDU1eUZhQVRHbjBaRGFjeHFQT2h3SllQVzg1?=
 =?utf-8?B?K1FLdE9tMlpFSEREVUYrdncxZ2RPdXpyM3ZXbHFWMStKZGlrZzRpK0s3akNH?=
 =?utf-8?B?aHFqcGVwRTgrTlZ0dWlKcHZ3VGtCakora3FMNzE4QitmaDg5dFkySlVGd3NZ?=
 =?utf-8?B?VFB4SzR6b3pGUUhUc2J1SWhiRVNPa3Z1U1pGRWJxQUkvaU9MOFQvbzE5TEJS?=
 =?utf-8?B?K2lrVHpQazRNMmIwV3lPNGRpQklpVHBtODBKUE9JZFM2aDduZVdMMlF2VGR3?=
 =?utf-8?B?SzQ5elBwKzVQbUFzY29UZzBTMXptWTNRWFdVNG9oTXVLOUhFZjdYTysrM1Ba?=
 =?utf-8?B?bzRuVGVQSG1Id1hwcWw3ZFpISDh4ZW5MblVnSkI2b1RRZU54aGlmR0dQeFdN?=
 =?utf-8?B?V1JQYmkxc1BWRjZQZDNQanhqQlE4Y1o5N2sySnUrN05pLzRjMDNRcHRQZ2w0?=
 =?utf-8?B?a0hyNU8vak5BUUZGeXRMRUhyUVVXeis5REwzS1NtOE5KN3I2V1NPWVJDL0JY?=
 =?utf-8?B?TXlyZmRVUTZ4a0FmOFNaZSs1ZlJVajFlZ09MVXB4RWdVWEw4dWJJalV4d1Z2?=
 =?utf-8?B?YWFzaEpGcm5PSEdmenQ0SE1sU1hISXRmRlFCTDJQM0k1RXByRzY5aHBZMjFu?=
 =?utf-8?B?ZTdoUkJpQXUveDl5ek1hcDJLeEk4YWhqRDQ0M0RkUmw2S2J0Y3BHNUY5eTRr?=
 =?utf-8?B?QVZDOVd4SXpWZHdqR3Q5b1l1ajU3c2ZDVmZvSkpRcVhEQ04yaDdBQ0VCcU43?=
 =?utf-8?B?QjdZY3VQV0s5alU4eXBZUlZ4blorZzliMWY5ZDNwS014L2pSdEdRbVc2Tklj?=
 =?utf-8?B?VElwMzdEY0t0UWV6VzFTTzF2VVhuZXdxTHp0cHE4b1dOalZTdHpCeHdubWZp?=
 =?utf-8?B?VlJPM2xwYkk5MTRiMlpOQlV1WmhPYUZmeWM1UWl2NzdLUFlSTk5QOS9BZGp0?=
 =?utf-8?B?RFo5cnpkcWR4dTIrbFhHSUdjb1dGd0xmU2UxZDZCTjRTRzV1cmNybGhDSzkw?=
 =?utf-8?B?Zkw5Q3NOekc5Qm9Cd0ExcHBnelJTZ3pSUU5FNVdkZjM4am1ueUhXM0M4K2Vn?=
 =?utf-8?B?N2NBam9zZm1XY3lLUUpGK2lCUHVpMTl3RmdDbDdCS1o0OGRVMENERzA1d28y?=
 =?utf-8?B?bXNFN0VDZU5LRHEzdWZBb01QeVlmbTBTTGdDeEh6NGJEWEt4K2hRUjNlTk16?=
 =?utf-8?B?SklMa1p5eFNqR28zT3RVZHFwRHJ2ZlhiZTlpTFFlMU5FRVZjY1dXbW0wRkpk?=
 =?utf-8?B?V1JNZlRCMEJGZGt5Y212RVFQOEdZWG1OQ1AwSm1EWEhwWFI2cEplaUpUSVVy?=
 =?utf-8?B?UFJ3azBpcDlFY0lOTEhSZVhjMFMxaVNXdVl0b2ZUT1FXWG9aelAxR3FJRE1i?=
 =?utf-8?B?NXYyNUNxWGhzVTBmWk04YlpLcEN5cTdzY3FPSmQ3aC9PT2RTWU04NmwxMS9w?=
 =?utf-8?B?UkZJbUZuUzkvcXV3WjJ0VjgvanBRc2x2RDUyUmFDTkxrUVpnamxpTnZXZzJk?=
 =?utf-8?B?T2piMVJjMWFoeWpHS0dxWnExd2N6TUt5RGxQRnd0REw0YVovUlVKRTNKYjNo?=
 =?utf-8?B?Nmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 094c0717-95b9-435c-8c17-08db057772ae
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 23:44:38.9626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z6gTztKTBfzf7svT9GR/sqJSwZqrf+qvDVtZwliOkK+XWIpnhX6Mno9aK08Wn91eQ8AfcbS08HL7z9L2TqrbEgi7v/5sIqmScSAPrD8I+Do=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6175
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 1/13/2023 9:54 AM, James Morse wrote:
> Because of the differences between Intel RDT/AMD QoS and Arm's MPAM
> monitors, RMID values on arm64 are not unique unless the CLOSID is
> also included. Bitmaps like rmid_busy_llc need to be sized by the
> number of unique entries for this resource.
> 
> Add helpers to encode/decode the CLOSID and RMID to an index. The
> domain's busy_rmid_llc and the rmid_ptrs[] array are then sized by

busy_rmid_llc -> rmid_busy_llc ?

Could you please also mention the MBM state impacted?

> index. On x86, this is always just the RMID. This gives resctrl a
> unique value it can use to store monitor values, and allows MPAM to
> decode the closid when reading the hardware counters.
> 
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v1:
>  * Added X86_BAD_CLOSID macro to make it clear what this value means
>  * Added second WARN_ON() for closid checking, and made both _ONCE()
> ---
>  arch/x86/include/asm/resctrl.h         | 24 ++++++++
>  arch/x86/kernel/cpu/resctrl/internal.h |  2 +
>  arch/x86/kernel/cpu/resctrl/monitor.c  | 79 +++++++++++++++++---------
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |  7 ++-
>  4 files changed, 82 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
> index 52788f79786f..44d568f3577c 100644
> --- a/arch/x86/include/asm/resctrl.h
> +++ b/arch/x86/include/asm/resctrl.h
> @@ -7,6 +7,13 @@
>  #include <linux/sched.h>
>  #include <linux/jump_label.h>
>  
> +/*
> + * This value can never be a valid CLOSID, and is used when mapping a
> + * (closid, rmid) pair to an index and back. On x86 only the RMID is
> + * needed.
> + */
> +#define X86_RESCTRL_BAD_CLOSID		~0

Should this be moved to previous patch where first usage of ~0 appears?

Also, not having a size creates opportunity for inconsistencies. How
about ((u32)~0) ?

> +
>  /**
>   * struct resctrl_pqr_state - State cache for the PQR MSR
>   * @cur_rmid:		The cached Resource Monitoring ID
> @@ -94,6 +101,23 @@ static inline void resctrl_sched_in(void)
>  		__resctrl_sched_in();
>  }
>  
> +static inline u32 resctrl_arch_system_num_rmid_idx(void)
> +{
> +	/* RMID are independent numbers for x86. num_rmid_idx==num_rmid */
> +	return boot_cpu_data.x86_cache_max_rmid + 1;
> +}

It seems that this helper and its subsequent usage eliminates the
need for struct rdt_resource::num_rmid? Are any users left?

Reinette
