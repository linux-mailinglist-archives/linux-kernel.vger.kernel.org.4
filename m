Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F286D2BB2
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 01:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233244AbjCaXaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 19:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjCaX37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 19:29:59 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D125E12CF0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 16:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680305391; x=1711841391;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Gq/oEkpL+PwKJCH9m6+9NUzpqd78HwHIHKyS3S775Ak=;
  b=hORCpiJuOUkvtJpT2Q8t0Myxma8raKfWWOXC07LCs2uBxbtggfsON5TP
   DqnzqSRyGVIxgu1mjJeT+nDAIWUKmqIAGsXste5R10arpqihmMCUArURx
   O2PGsxaiY9UAPFAhAP2/R80UzfihBjxjvGjZgh/IFJaKMh+Y85ewUhRnl
   kh2Ji9Npmbzro9uPUeA6nDznpDJHtLB24mwMODh6MiyHHmSGZKG12iMP/
   8NIhWDAO19m8qcrsAq/3AqcbubaJonE02Jj16aI9E1lzRtcta27PZqJCy
   FnOP+ROG7daray6maeDZ5XyJB//b3jhtasLM0OaQBiSF2zzyPATqtLvOY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="427855617"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="427855617"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 16:29:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="796283440"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="796283440"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 31 Mar 2023 16:29:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 31 Mar 2023 16:29:49 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 31 Mar 2023 16:29:48 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 31 Mar 2023 16:29:48 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 31 Mar 2023 16:29:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/7MsbmbKPh0CmMwdqRKneZhG1PxgmExicq10fTmd/dC+b9otlwBVFPDcth+uwo2bo3qoCA4sIvjS3IoODipwiqvDCcMIgxDtLuAIBXWrTsjJKw3RpnVy5dZG0GSZ68Cva7RV432vPc2xR1udM8IOHqCmCF1ItBjCdQyDyJmQTqTNTSQDBWNEJuQk35b5LCzdF0yS+sjDDExoLefxAEmSCNKaFRqMpKSsgsjFAa3hgtOz3KvU6o4yR5xxwvjhrO7n74bDWfOC7ZRkrMaRxS2oaErP75T/x/SERTU4GajwWcUXcuNAhAjnjcJABWoEe3xqVpqv8h3bx1fqsw4lqseAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V6A41qdaPrhBsMvQLa5I2iiJ74r83dqfDOMuNYIWV+M=;
 b=m6f1iQjMNFJuHsdeS1ojdGTfWpbhbX7BicH2aqrBxfXeZWlfkuw8PP7rz+5seq8E9fMkQkRnYdCR3YhnHzm9V60xCKUilR1t1VlDSkEDQRYnMUd9DMdKynidkxMDEumNUi6ZUM2+E5GjadaT/V9Gs9+6BmOOZYp4j4GrMjdlQ4Vi4TZclo2qE1LAcwvQrSxFvpN8HsQtGCq/Vc/25F53vMqGjLN+UvWhDGBBPgCuVN7vlbEI7uTnfLSO0yb0RLS7EWwcTEB0JL1i+dKA9BN8Msf8ZRBSPz2FUuqOoY25sfGTAhNbUamWw80wO19LrQqnZZxWzspnLV3SkXusRvuaUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by PH7PR11MB6426.namprd11.prod.outlook.com (2603:10b6:510:1f6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Fri, 31 Mar
 2023 23:29:47 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6254.024; Fri, 31 Mar
 2023 23:29:47 +0000
Message-ID: <c429e614-fe97-1c44-287a-9c52438dbeb2@intel.com>
Date:   Fri, 31 Mar 2023 16:29:43 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.1
Subject: Re: [PATCH v3 16/19] x86/resctrl: Add cpu online callback for resctrl
 work
Content-Language: en-US
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
References: <20230320172620.18254-1-james.morse@arm.com>
 <20230320172620.18254-17-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230320172620.18254-17-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:a03:40::15) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|PH7PR11MB6426:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d955c61-37b9-4445-7121-08db323fd060
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rn6ky5dtL3qb1iiWay5NV0i69OqWopiTudI95Wt3jejHV5iJ+l1OQ71c10kDY/grd4I1W318mkN9NZ0Ll/qidfncStGfoYlj9rTQIzlkuD9g5ngfIgeAT6SSpjUww4/5JnpY6l98w+I00amusNgn4+q+u7TtO/l7KIrROo7kB3DO6bm3GGphg58lZnWZ9AsSIPSqsx1n3IIaRBpPZ2r/Z29crNaAZGPN/dEphux6ejydZl7UDNCugcPdxvQn/z6EgPGvwKY3J2o54aD+JYChFmCWq573KMN3JMj/XTWmjGvac6wPkG+b1vrzCky9nRPG4/q+s2L8+UgvW92XBZBoePc3Na2JPFoiJoSAgKrbTZ4X7BxGFfHitzQWdSfzrDhtFZNYPRPrM9XznSvW1mOiZh8WoHxrmbpXby+Yp3uYIuukg7UDfJvgDixVnT12aFQqYSP3kKH2/byOgU9JY9ZNaBQS/jGe/1+4meMlP1JIr9qWl56qIqMDcuO/h7+Z5IPFvj77eJcGWG5kxEJgiEniIx9r0mpvWi8/f3kHftk3j/m4SABv4AvS1oirg9HgFh9A7wyQDgT0mAgeo/s2FZUOwJmwFcWrOTof3/GhDEWha2N5hVCEiO3xZR8xlHAm+8Um72L2WZI51h9EJ/KAuR/4PQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(366004)(396003)(346002)(39860400002)(451199021)(36756003)(66556008)(44832011)(7416002)(8936002)(5660300002)(6666004)(2616005)(478600001)(8676002)(66476007)(6506007)(4326008)(86362001)(316002)(26005)(66946007)(31686004)(31696002)(54906003)(53546011)(38100700002)(6486002)(83380400001)(82960400001)(41300700001)(186003)(6512007)(4744005)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2ZSMnhYNEJMdUZaeW5OVGZxaW1LZXJjdTFtYlVYS2gyUjBxbDF1Q1dsNngy?=
 =?utf-8?B?blNOa2o4MlNKYzRERHBjSitobEhsWEJmaVRzVFd1NkhKRy9DNUptUWRPZjBy?=
 =?utf-8?B?a1F0bXFkMnhOQ3NVWnlGRE5kb2o4UTVuSmFIRzVlZXNOVDQrRVMzVlpTSXNG?=
 =?utf-8?B?Zmx1U0RndTE1Nll3cXdlRE1FWmp5UHdRNmZGQllkdVBWcUZBQnZUY2VUMnQ1?=
 =?utf-8?B?VHZQQmFTTVBEallTeTBCNDRzazk0Y0I3TklvL2RZanZIaGprTm80RlpoRVFa?=
 =?utf-8?B?NmU5TktWY3RxcHJMUmU5dXNVUlI1ZUpJS2VJaWFabVpDbFB0cE9VdWVCYU9y?=
 =?utf-8?B?NkhXNnpEcGh4bS90QVRQNldNeUtvNUJ5MXo2cFVRRWUrMUUyNXg1Z3FOR1lr?=
 =?utf-8?B?bEdFYU5UQ095a0xMK2V6VERBRGQrMFBQbTg3Z0hScWswUHU2dndyTDJOUzlv?=
 =?utf-8?B?bjFnaFF1Si94YjN4NXo2bmpnVFZjaHc4VmRQNVRnK09uTWtZNlNDSUlTOVBH?=
 =?utf-8?B?eE01ZVpxL2s4RmFsU1JQclkxTUZaOC9rZEswam1FbW1zbzFzTVFCSEU2aml1?=
 =?utf-8?B?U2JzRUhuRTNNaE9heW9uRTlxMzB4SlZDTVdXaXZIRTdhTm1MVkF0ZGdoS2dW?=
 =?utf-8?B?MTNzcVEyUEltZHQxbzh3N2xjTGRMUVAwVVdCNzNEV2Z6eExOdTdrbE0zMlRr?=
 =?utf-8?B?Q2JsUnUwWXQwRmM5S2RZTVZja2JtV1AxSFZFaUhwcHEyMnFGL0FtV2pTRUd3?=
 =?utf-8?B?bURzSVRhbTAvYmVZOHRoQ240RnlsdTBtZmhSL3Nnb0JTQStwM3VoN2dyMVRy?=
 =?utf-8?B?aUhtRHJUaXZMMzdoMTA0NXRRV3dHUlpkRmNiUS9wdndIQTdoY2dBUFVMSUFC?=
 =?utf-8?B?aVVkd2d0RGZuaHJWSHJiaW9EMk83cmNRenAvcFhNTGZKZ05hUm56c1EyU2Ir?=
 =?utf-8?B?RlExSk1Qb0EyREpXd2gxZmlqc1VFejg0UkRIV1dUVm5hT21IRVV0SWV6UHdt?=
 =?utf-8?B?NXg2Q2o2THVsVmgzRHNYK2RIOEZJZUFmQ2tOQU9PcFF4VFhBam16T3ZKN2dk?=
 =?utf-8?B?Sml6STlmYUxlb1VuY295dlYydDlZUmc0RWwxUVhTQU14Rkg1NE91Z2xPOTBJ?=
 =?utf-8?B?a01kcWtnckFFdEUwVHdValIzSzFrMXlnMG1VQ2JPYzhrWnlqZkw3UHlPczhU?=
 =?utf-8?B?c0pwdDNKcytxdnJsbCtHeVVtMEVvaTBONi9HSGRjbmpzV3h5eG90V244QTV2?=
 =?utf-8?B?RFhwTGhOM3NzV1o0RkFJc2dHcDN1d25CYWwrY2NSTitJNjdKTDVCUTEvY1Ri?=
 =?utf-8?B?NUNqS0t2aTd1ZUtUOGY2YXZYYzF5ZFppVlk1WEZTNkkxd2xTeVhib0tkL2Yr?=
 =?utf-8?B?Q0tzSnd0bzI1RU5IOFVXR0F4Y3hYKzZFY3l5bVZXVVIrNHVlQmhQVWpId3BL?=
 =?utf-8?B?U0VVMS9XakhqMzk3WWxRSS9BTnVaQ3BkQ2xQeUtxaXBnSWNKV2k2dnRueWZL?=
 =?utf-8?B?RjArMHNLTjNnTDRQTFRYQkttelVqU3ZrK3ErT2hnTWp5STI3cThtbWJEbFBR?=
 =?utf-8?B?aW5XNkFCSGVCRDRYNjQ3V284cVBwTjZBbWc0UTAwS1ljT0xjVGdodHhSK3FR?=
 =?utf-8?B?Wmw5T2VCS0FSV1ZNR0t4RU8vM0JUbkhTanVkWWdzTklvbGM1WWVjeDY1bHhR?=
 =?utf-8?B?c3VOV1VyREgzVmIrc3ZJT3dnRHJldnJhSWc4dnZsWnJtQjU1R3lTdDdHWjlY?=
 =?utf-8?B?dTkycG1aaVNjMUhWRVlWc01lR3ZaRE8xeGxlRlIxNmpybmIwcU8vZDZnVlRK?=
 =?utf-8?B?VitXRHl2OW1ha3AzQk4wd0gwcFdEUlVTbUNncnNVNkZIWDlCc1RIU0FQQ3Bx?=
 =?utf-8?B?cC9velJ0Ui95ajMxbUpCVDZSMTNwcHl4b0o1TnJnbDBwclRBNGlmU1ZJNmNR?=
 =?utf-8?B?eDBHOHV4dDJTT1AwcmVSaG52b1U1clRvUTFxUlFuclpvaUxtUXFTRjhWVTJU?=
 =?utf-8?B?TlRVT0lzMzhQRE1RQ3prUDU5UkRBeDNOYVJuZkM1Vnc3enA0eTV6bHNSQ2xF?=
 =?utf-8?B?RVUzZk1CZGI3RDhNYzZwS3NiMWd3V0pLSlY4QTNJb2p3eGZZaXFxSnNCVEd6?=
 =?utf-8?B?MGJuLzBldHpVUFZMOXdvcElwVFlmeER0WXVUZ3VweEtVWUFBS21WUTFXdDJY?=
 =?utf-8?B?MWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d955c61-37b9-4445-7121-08db323fd060
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 23:29:46.8767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BSo8A2zGG9KlZl0q32ELbF8C5HU5kfOy6QaBtTjAM6XZwuL3VBbqYPejGcke6oVrIV7UHxSYrPIdULqs9fT9fsCMzr3EI/A3LKnLP5ZReL4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6426
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 3/20/2023 10:26 AM, James Morse wrote:

...

> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 351319403f84..8e25ea49372e 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -603,19 +603,20 @@ static void clear_closid_rmid(int cpu)
>  	wrmsr(MSR_IA32_PQR_ASSOC, RESCTRL_RESERVED_CLOSID, 0);
>  }
>  
> -static int resctrl_online_cpu(unsigned int cpu)
> +static int resctrl_arch_online_cpu(unsigned int cpu)
>  {
>  	struct rdt_resource *r;
> +	int err;

Could you please rename err to ret? 

Reinette
