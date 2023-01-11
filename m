Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710476665FB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 23:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235894AbjAKWFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 17:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236011AbjAKWFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 17:05:20 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A9D431A8;
        Wed, 11 Jan 2023 14:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673474713; x=1705010713;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=b+uBavoCG9tkPn4ogmKEsPEfFGsz4mctEVRyxTwM+WQ=;
  b=KBM6fSN9b+QhcLnlO+rDlGdxE7HTq9vmjXOjM6ApHRRLj33HnyOJJK4M
   V8e/sGc+H2hzQI6V71MWagPRgOIfYg2iB5XVHsv/bIOPlz9saxZqYwKbe
   jETz3FPjG1WCvMEcQBUq7u1wVNn2ahLiWNulIbpWi9oPqLMrYVwLdtjJ8
   JxV4dejuLZ3EaLDULim9LQ1y5/Y/jMvndq0P0XKp/dif80ZAhYDX010c4
   pPYQ1P+QWB52onqI8/q3/N9HjU5X6MFGDRBALUX09ll5bCW30dIw6zl/c
   GNmodJX+HDml8+On1C7RUyjCJgayR0sFE6cAzosdHZojxFvcwF5rvAces
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="303920051"
X-IronPort-AV: E=Sophos;i="5.96,318,1665471600"; 
   d="scan'208";a="303920051"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 14:05:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="831464570"
X-IronPort-AV: E=Sophos;i="5.96,318,1665471600"; 
   d="scan'208";a="831464570"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 11 Jan 2023 14:05:12 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 11 Jan 2023 14:05:11 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 11 Jan 2023 14:05:10 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 11 Jan 2023 14:05:10 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 11 Jan 2023 14:05:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oWg5kc+1ZI7GOGejcQb3/mEOUzXtK5f7t9xXKTextFohTbPZZR92Wb9ppgaA7JHr1h6X5RPa5659WvdYzPdB+gFS1sCoQ4k/vt/N+8EP0SvpsJ15yTOgJVBAPF2BG6dSevDqYEp4OMITm9Zs72hOSeHe/TNvA8uIc6Wbz4w853AxeNUmPI0nWsiGdqLB0s6w2kcf5H9xdFUSqziwAoNWGhGRcFPW9G+pWFoKGH7RY+5ffQQic/LYtj/vIcpoBbimgzwbTLi1rc/Xqb3UR3Nqr4o1D0pp6GjygZKWTYr7KbDLyDgKeqqujLyKgUSOLVQRIW7Hjif2zvzEmSukfslKHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aoaDqR2h5SZo4pH9sucgOKEZczToID9wF5SrpeCqxoU=;
 b=b5AC3vuf7NRWSbA2/ZFd2WwM6bEJD3QZqY/6KPHU85QAtQaACn8lyIVN+14LxfYZq4gTkvwPWuQ8jmEb8p6QKdEX+b/vXEfyADP6WFsiHK2GbMehjobhD64QjNqQngu5uMwVeKzJjRCZuHKA1K4z7IvF4HjBPTGpxnQ6zdCnwx40PIfZgS+xU3l/owUZuSSuXW/JlDWPkO8+8HtuY7OFLJh6es4q2f0kHgMuvARkSm71HXBPo4gE0U6Xb3c51YZ2MIsM9MAz2TGgN2LWShdjyEvNRf6oQCPtadCjK1MiQXhongiMP0OTR2MT5+Pa5a2a1UAxmVzOeNY6vn4xpYd2UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DM6PR11MB4706.namprd11.prod.outlook.com (2603:10b6:5:2a5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 22:04:59 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.5986.018; Wed, 11 Jan 2023
 22:04:59 +0000
Message-ID: <6390de72-36c8-39ea-7ece-eed0b464359a@intel.com>
Date:   Wed, 11 Jan 2023 14:04:54 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH v11 11/13] x86/resctrl: Add interface to write
 mbm_total_bytes_config
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <jarkko@kernel.org>, <adrian.hunter@intel.com>,
        <quic_jiles@quicinc.com>, <peternewman@google.com>
References: <20230109164405.569714-1-babu.moger@amd.com>
 <20230109164405.569714-12-babu.moger@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230109164405.569714-12-babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::11) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|DM6PR11MB4706:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d5678a0-cff1-4540-136c-08daf41fe15d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FdkFxwl4xrYyp5c4iEumF/Q7XDfegLfSvLVqV07sARJUTpeNW7QDtyoQL/L5F2jLA8Aky19WvRV6OQz4I+zjOL8TIAQx3/7pQOaT3uNEGgqH/5l5WZR0VxD6TtLIdhCx8bQxLgrpR34OCvSgC2QPtFme9uDulcatWMdY52xlEtZJ58kbNM4HcO0Gmicj5+OAtS8Xtk0kpJBGCkDaxpRV19l+clqnpZhf5iKKyEwx1tt188kI7/h9d/FcrDFCPIXO16nEYgVCRQAJBu1mbG6lmF0QFI/qppR5EfHNlw+fV9y4kgWvcJKYhFnUa1R+PGXIfhfr61ftfQqVKc2Rfoc77JbKP9b8D/Zjmc6IHAf9UvHYxmmvVIXUeHp1Qmfr8pGNB0AmGk+IJ4DFBvrSkmkA5psfakqNaNLrRA9Ze6gnWWa5isDkL3jmuGWfot1fxRJ3oNSrMpxDT18fcc0GBHQ0EyHEU5BV3XXhUElPljVm0piU1XV+Vfr7/DuGYsQ4wxwN/3BfnDEgt8CeyMoQAK+E0upnyRn/IEmeI3S15S///YhpnSM3f1eJZ2iVIA/ZwVc9gZcli1dEI5d75ZB6U55+wqHlG97HAIE+jA1R8rRsXznUGDWBGqUistzeaptJUEvMhyDkEG7oL94gHhYU1KOwlo4m2ECp2Mvex9JfBojd/94O9OGfTE7k2+WIdQYVZCOJzNHuS0iXCm28PsaaZb1ZlnDsyqMk/V+Wu8KDAQ99lME=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(39860400002)(366004)(396003)(346002)(451199015)(66946007)(66476007)(66556008)(4326008)(8676002)(316002)(2906002)(5660300002)(7406005)(26005)(8936002)(44832011)(41300700001)(7416002)(36756003)(31696002)(53546011)(6486002)(6666004)(478600001)(82960400001)(6506007)(38100700002)(2616005)(6512007)(186003)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTZnSUhxSmpTMG5OSE10a2kzTVc0Y1BLUU1td0h5ck9qTmQ3MzFQOWxkQXUz?=
 =?utf-8?B?MloxODRhQWtqaysxcFhPcFhQTjVVWFBmSGVSNWNONFZYdkI4RllNQjkzakZF?=
 =?utf-8?B?UkNSelIrWmNKVzNJRnc3RG5RNEFDYXpOQzNCcHh2S0l2QTl6Y0VkVWl5OFBx?=
 =?utf-8?B?RlZGSFVKZUtXVjFTNVlZcmFGTFpSaVFvaUVuWFJ4QkhtTzlmVzlwL2hNQWtV?=
 =?utf-8?B?OTdpZzZNUTFEbGtXMDdob1FCUWl1bU9TVXE2c1lGWjZCQnp3bllUWGwyQ1p4?=
 =?utf-8?B?T1NqMWhqcFdQTWsyQzA2VUJ2S0ZNV0J6OGsxOFBMcVJqWWI2aHg5WkxrOXVT?=
 =?utf-8?B?QmZjb1U3TmhRQXRsWEhrNGZ1QjVtNnRURE5lRjFCalNGS2E4eDNHTHVCT0Zn?=
 =?utf-8?B?NWc4Nm5HK3RFbDNxdWQzOGlmUW9OOW1HSzBxdUhVdWFvNXdyMitRWEZsWUhF?=
 =?utf-8?B?b216NWxPK1Vza0JzWGl0bWZwSFdCcDFOM2xCSzNnWmlLVWp3VjZFS2ZSa2p4?=
 =?utf-8?B?c29KZk95cFltNGFUN1FhRGtxRzJJeDczNTgwcStRTHg4WENLZC9NZDFOUVBN?=
 =?utf-8?B?TGs1aHZsRFZzSXlEZWVyZTRrRVhOMFpCblRwNHZ4eVNiYXR3MTU2SFB2a1FC?=
 =?utf-8?B?QVZkb3NlNDV1ZFNNL1hZZ3d2NThueG9Xc2pyMmI5VjRyT2dkTVYwRG5FT0J0?=
 =?utf-8?B?SVJYbS90NjRxUzNPU2kvSTEyT3JWTVF5SFBOSXVXNjNESmJEbTAxMndYUm1Q?=
 =?utf-8?B?cnlCNHo5SDY5SHU4NThnRk1WZkJqdEJqZG8rKzhBb0REMkpHL1VDQlhRVy9J?=
 =?utf-8?B?RHNjR1dzeHVtNHI0ZGF4SzNaRVVjTEExUXN2ajVYR01rQmlDZzQzWmIrcnNJ?=
 =?utf-8?B?ZGFKQXloQUM5Z0hIbkhDSU01M3g0cERxRU5STmpaNkhhelYrcDBOdXYweEdK?=
 =?utf-8?B?YzI3Y2lwY1ZZWWVOeThVMk1xZi93bUJsZVNob0tpQ0dYSmNSZUNmTVdEaVl3?=
 =?utf-8?B?ZzVoQkI5SFdaMXc1U2VkWUJvWTh4Ri9NejlLdlppY3hiOWYrV1R0azVQUk1U?=
 =?utf-8?B?RTU1YjhaVFhYQ3hPeEZaQWQ1OFEzQXNkdXEzZlFqWDVEeU43bFFBR29YbEN6?=
 =?utf-8?B?ZTJsc3FSSVZ3bFVBRkx4cGxIeEh1SDF3eVZTbkEvYkF5UGJmVjhaVndEbksy?=
 =?utf-8?B?MitxTVUzSHZPT1pIV3lPdFRoc0RaNVA3VnpTQzlMRkRIQUJwQXRpRUZDRDVu?=
 =?utf-8?B?b2kzQjJwVWZzdnFrTC9UdDdjYldhWDVkQ3hCWWhOMkNadXJiN2RMM1FjQlIy?=
 =?utf-8?B?QXhHN2xxK0FoeDQxeUNLQm9TRDY4V2ZCOGpkZnBIMjBiNlFOUVBjL0RNZHBJ?=
 =?utf-8?B?N1BZUTJ3RTBLS25GQS93S3Nvb3prKzIwbWdxL2dZLzI1VG5QTnV0RUU1R2h0?=
 =?utf-8?B?YlU2aVM3YXdPQU9lYVhma08wSU9IVXg1TjdpaWpUdldVWVJvQkdMV0l6SUJt?=
 =?utf-8?B?ZXYzQVY1TzRBKy9nSVNGb2JjT3ZLWlY4TFZWa3lsYUZBMDFQdUhSNUJCTXhO?=
 =?utf-8?B?enhxRDJnWGlwV29tK3k0bVhwbm5vVnVwSkI3b0IzQW95RTM0YnVGT1RZTXdV?=
 =?utf-8?B?bkliazVwMk5YMndHSjR3RUdtMlo0ZkQzMzdkdkJCTGdZbE9RM2NYaHdsZ0ZM?=
 =?utf-8?B?RlNidjNuN3dBQ1pvaGIyUTBvMmMxUkR6SU5PL2hTV3JiYnE5b0YxK2lLWE1x?=
 =?utf-8?B?NnZ4UTJOdnQ0TXpXTUZHdDBOdzhZbXdtV1ZFd3hDZEt0ZHVWTm9xTElyelBo?=
 =?utf-8?B?S3o1RHdFL2NlSnI5N0VHdjEzTWZnWDBmYWhzcmN3MWVMUGVaNFF0aXhrVmxk?=
 =?utf-8?B?SzF1a0o0Z3BvUktobVhnZ1NSSCt3YVlBYkYxa2MwQis2L1pSbEpKR0VKQng0?=
 =?utf-8?B?cDNhbko3NjBoVmNyU3poa1VXNG9aZzVqK25kN0xSL1doQXRBcDBaV2p2cWlt?=
 =?utf-8?B?ZWRTaC85WXc1NDZyclFveCs2cUsrM0djZ3liTzlJQ3NtL3EwWTJUWnJneGhV?=
 =?utf-8?B?dU9qK0l6RHpqdXdCaXhLVHJsZzlLNmIwODV5cktrU1gzUFhHUXh4T3hUNXpp?=
 =?utf-8?B?UkZHcC9BRVZvbkI0MnRINzBOY1JCUk4wYkVuSldQR3pqcDg3M0NidFUyQ2tH?=
 =?utf-8?B?Z0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d5678a0-cff1-4540-136c-08daf41fe15d
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 22:04:59.1172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L4ai48VasIEMsC+K+n6ddOhqIFLWNUc0518OQctl3XDqb/DrBRiQnDdFQYGWFrLy1Yl+cJMmpV5cWrbt71bqDRbn9ZykV9j3IoMcDJc8T9k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4706
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 1/9/2023 8:44 AM, Babu Moger wrote:
> The event configuration for mbm_total_bytes can be changed by the user by
> writing to the file /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config.
> 
> The event configuration settings are domain specific and affect all the
> CPUs in the domain.
> 
> Following are the types of events supported:
> 
> ====  ===========================================================
> Bits   Description
> ====  ===========================================================
> 6      Dirty Victims from the QOS domain to all types of memory
> 5      Reads to slow memory in the non-local NUMA domain
> 4      Reads to slow memory in the local NUMA domain
> 3      Non-temporal writes to non-local NUMA domain
> 2      Non-temporal writes to local NUMA domain
> 1      Reads to memory in the non-local NUMA domain
> 0      Reads to memory in the local NUMA domain
> ====  ===========================================================
> 
> For example:
> To change the mbm_total_bytes to count only reads on domain 0, the bits
> 0, 1, 4 and 5 needs to be set, which is 110011b (in hex 0x33). Run the
> command.
>         $echo  0=0x33 > /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config
> 
> To change the mbm_total_bytes to count all the slow memory reads on
> domain 1, the bits 4 and 5 needs to be set which is 110000b (in hex 0x30).
> Run the command.
>         $echo  1=0x30 > /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Thank you

Reinette
