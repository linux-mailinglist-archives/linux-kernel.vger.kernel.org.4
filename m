Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F5F73225B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 00:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjFOWDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 18:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238150AbjFOWDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 18:03:36 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D532D59
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 15:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686866610; x=1718402610;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=m3lpMY+bSJniQsI2Jekm5YZlEYDLovzf4oq6h/8MTwI=;
  b=J95BNIT7wYLIc4u3DqUPjygpJqr+b8/cbnX9fwrBkzqNpQrPd+aPNf9f
   lBgUFMsUjP46spqDGsFoQmdbtnuEEWVtduudxkLStkISERdpxzvOM4GmF
   qYIIAdp1pVb/5BaEh5ZQsWYTkhcm5CfyaGUydw3btE51iRdzDUTm20TJA
   z1o46ohIE7s6iS3BM/18zg+fhPsSIAQtic+Zr9wgmUEXqOX+9UcuMI0Cv
   toyHTAfnkFj6fj4MOAFIXdngqtPh+WfP9oiNaZKJ+sFyKnx4DhBsMifmh
   KPWGgf5Tan3ts+ffb4RC0680AZ0mJsmKM35poI8M5p7k3rNcOfcoaWlCE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="356541431"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="356541431"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 15:03:29 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="745841655"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="745841655"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 15 Jun 2023 15:03:28 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 15:03:27 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 15:03:27 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 15 Jun 2023 15:03:27 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 15 Jun 2023 15:03:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VR0EmUofX07iAHUygO13jK2qXbl7bTsIjO5/UnmC20o1TtKiq4lmMwXVo2Pw/GzJRfNYz3Ivqgx4SYcoYM7qYz2Ec8y/Z4z25F7jYqGxbMv0d/t/IEo8gQstvR7T+9FwOHw7L16HDNjb57SA8dbDxhogYxiJ4lBKxgp9JbAgvNOGrHY+GzqODRIC3TQZPMLv4zJDEda08klWI9X9a4jMCk/bD6pV1zSIuyUiF0+3VISGPxGDEDr4ftZyZQYv76D8dAnELoR6uYntKuoKSEzFeU9IKmKikXnFVgKPeEKI2q3QaJqhwCswqW/u8gElmyK9GjC7DRy1M9LSh/m1lBYDFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFJWADDlPnGpPVX6fIlvknuOqB7Tol8IUQBN186m3rU=;
 b=b+PR03jJla+Mhc/3KccPfx4Aep8nLjQ09s5vIvEZ4pxULtwi5DZgzOni7JcO3YDj9WNo1IXIQiSKBQZG6NGodU9B5TKBYDrCyC93ArICKzKahbAsGOUH5GHvKOSos15Joknc3OT1pUpN1/HQTeULcLg72s3hTzsSX3Ja79S44evncsBMu1yCNXgqbamKPG6emQk0BrXjxsgTEUwmCWFuUcWzjrGqtIrRL4L07ed/KZyi8fTSOREbw6k+dd7ju5kqAHr1TJbA/FCNyMlL42sXwmydHQzDiIKf3Hyg8VkyI4y7+sZFb73oNHp1gh045RmwcdGdlT4EWhtn20nBMbV9Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB4781.namprd11.prod.outlook.com (2603:10b6:a03:2d8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.38; Thu, 15 Jun
 2023 22:03:25 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d%6]) with mapi id 15.20.6455.045; Thu, 15 Jun 2023
 22:03:25 +0000
Message-ID: <13187438-94f4-d6d0-81c2-cdedc0d0243f@intel.com>
Date:   Thu, 15 Jun 2023 15:03:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.2
Subject: Re: [PATCH v4 02/24] x86/resctrl: Access per-rmid structures by index
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
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>,
        <dfustini@baylibre.com>
References: <20230525180209.19497-1-james.morse@arm.com>
 <20230525180209.19497-3-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230525180209.19497-3-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::10) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB4781:EE_
X-MS-Office365-Filtering-Correlation-Id: 12566648-111f-4496-32e9-08db6dec5785
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Ht1h3D1ffthytRW+jR1ltvrdvDLUnKdd+ZCPp7wpNvEwnltRtawRH3V9HJhOslHzSmITwL7OOIYt15MpsZmyrg0KGNAwj6RWabnH5gbFUpFuUHttzm7oGTlwGKpapaWjR2UqlvMUzkyNIaADCg01owrqAoTv14c5sbGfqKxsYqo2WeKo2omX0LIeiMgceHzvocNK1VVe+hitfCAqaU4XcwmMg8tYrpmeA+yI16JOj9r6KjWSpYLbrR/XSAjAhfQnlxVQKCDgKMIAizJAE0Hk7X8kVD/GSKixrB6e/jVtvZrymAplTjnFvt2K6kZxB/DRzwn/umjMCssd/SBpViYQTYPEldB6ApOr53xXF2/zyhm7qE/RJgLFeEe6fSkUAZGrpdY1JGiwNUoOJqLoQ4YaK1zrwYSPH45M802ON7H66NQoenKnwfcnX6NhaLpcJxjjnhsPkJFx2TW1+ILCfH2kP2DN62SqlHoPSKCHPEMLZMShiUnfpn0u25HZwp+gaBD3LXh1K/bQzjszFN9uOQkEgixxVe04Oo3vVIERr2VF9T7WRQSjeO8o2UnKQd5Qoq9YYe43X3Ec9bIwgVq//9A3o0njcSr1hYv2glHWLVW9z/F2iLVGq/If3r0XLK8ovxyTXWODChsfnCan2EUPTUtnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(396003)(136003)(376002)(39860400002)(451199021)(2616005)(54906003)(82960400001)(478600001)(41300700001)(8936002)(8676002)(5660300002)(4326008)(66946007)(316002)(66556008)(38100700002)(66476007)(6512007)(186003)(83380400001)(6486002)(53546011)(26005)(6506007)(7416002)(31696002)(86362001)(44832011)(2906002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTJIamhwczVoOWVxUDl2NDZyVlAxYVN2d0tBeCt4RW1ubEcwMXp5ZzRNVWFK?=
 =?utf-8?B?L3dxUXJLSWNJZHI5eTB3OWQ3ckRlcUNIdWZ0QnJTakpIM0dBcjJMU1RtcGh5?=
 =?utf-8?B?dWhrRnRja1RVNGFjeTNydzdYbnpxQWt2aXJPVnFiV2g3T0FCSlhUTVVMdUVp?=
 =?utf-8?B?cFI1N1VDdldsQ2lsaDN3Y0xlU2I0TXN0alFEUXE2L1lHSVJCOHZDelNoc3ow?=
 =?utf-8?B?Sm5ySjRGTXZSM2I4aWdoVEZBK2tuUWx1MDdKWEFlMSs0eVpXam50MlBac0lu?=
 =?utf-8?B?NDZzbEw5QktKUWRFR0p1R2Ntd0IxRXlwdndQNWI0SXhEWC9IeDZyM0c0aWto?=
 =?utf-8?B?a21hRlVyYktQNjNSc1VyRmZlOEFIRTBMRFI5dnJleWhYYTl0akdPck41b01z?=
 =?utf-8?B?endPUkhsZHZaWHo2dUoxaTBzazZPM2pKcEpiQmcrQTVXWkt6VmVCUDR6Zk9k?=
 =?utf-8?B?elVMVDVrYlVuMk5Xd01LNFA2TWkxRVhwdzF2aXZBZTNIbkRFQzFpUFNlOEZr?=
 =?utf-8?B?ZGRGR3Z2VTBmNWVtMzFGaHRPZGpDeFVDMUxyZWZDZGtFSUFBU3VMVjZZODFj?=
 =?utf-8?B?aFdoOUkyYndOT1VxbmJkZG5xeVBXS1BkaS92TTY0dFpNRHRGVUVSWWJLU2tE?=
 =?utf-8?B?czkzMHRpMEtZbzNoL3dCOENvLzJFQ0ZMbnNHRjFBNEVMaVhXdCtPWE10TUtE?=
 =?utf-8?B?eGF2aDNXa0E1TER0MlFEUFR6aElZcUREM0V6OWJWZ1J0VkRUd2hqTlRkMTRS?=
 =?utf-8?B?TUlmWkJpOFZBQmNtb2g3dXA1K08zSm5ic0ZZbGZrc2FldU5ZODN3QVU0VDJs?=
 =?utf-8?B?czFtMlBKQ0EzbytvbktraGYrN3lqZk1Ha2p6cjlUL1dncCtDbkZKd1NWdTh4?=
 =?utf-8?B?ZUdzbGtPTHN3cS9NTVNHbFBjaTc1TURKUm5tNHYwcVpUSzZPWTZWWkZVNGw2?=
 =?utf-8?B?T1pCWnpEOUc2dWlXeVBnajJnSTVaam5uQUpVL2VXUHdzaEt5bVgxZC92LzFL?=
 =?utf-8?B?VGpHcWVLN0w0bUUrK1p6OHhhRWplbVc2SmZleFRhS2U4K1ZNaW5ObTZYS3Rm?=
 =?utf-8?B?ZHU4L2xzdjlYVWtVVFBFeG5OQ1k3eG5oSURkUENNM1dGTnpQSWp1N0RkUmZy?=
 =?utf-8?B?SitqRUxUR0Q4TFdBbGQ2S1NlcHE4N3U2TGRXaVhHQnQwNzc1anh4U3JSZFRQ?=
 =?utf-8?B?LzBIaUR3SU14VkZNYTNyN0szSERMeTRZdmRQRUIxR2tjQjQxR0JsMENBdmRE?=
 =?utf-8?B?S0lvUkEyL0pQR3dLRkF5ak5WTmFHcnZFV0c3N2h5VWdYSG5zTDgzK2pBenJl?=
 =?utf-8?B?UkVSYkFiSHBVeFJIc2FWOS9aVEtlbkNFMUtDeHBxTTdVdmJ6c0lxNGdrZ1Mx?=
 =?utf-8?B?TC9hVnhERXRNTWtad0NMejVXcjF3T0huaG96cWN6bVdUa3lmcEo0aE0zd0NQ?=
 =?utf-8?B?KzkxRUVXL2hrdjJUYlJFT3ZxUTU4Y3dWTUZmampkUmludkdIMFdYUE1jV3Ni?=
 =?utf-8?B?N011aExHNzY1ZEh6bXNtRHI2OG51S2Z6aDFmN2ZpZ0dxWEllS016M05mNFll?=
 =?utf-8?B?aXcrMXpsdStXRnBxM09HMTZsdFhZaTZkUVhTdXMvV25jTTJUcFQ5ZFR4VTNp?=
 =?utf-8?B?QVUwejU1SEVoaHdkVk5yaUIwSTkzSlUvYjByalEwMUhWbEZuUmNqUkF1VXdL?=
 =?utf-8?B?T1FJWGYraFoxK0MzbjlrZ2pCbVJ0S2t5QXVYRTZjTmVmemhhOTlMdFRwLzdq?=
 =?utf-8?B?bU5oNGNrZ2pTMEYrSmVTemRQRjdMajBiWDIxa3FPeUZWQVJEbVh0RjRtS0M4?=
 =?utf-8?B?UllmY3FnQlppOTVMS3JTMTZaR1lzS3dPTElhNU9GQUYrZmUzZkhuVHlWQTRr?=
 =?utf-8?B?YlZYbGFvY3BNdGcycUFaTDIzOTdsejhEQkN1Tk9ROTlQNGhlWUZISUsyYXN0?=
 =?utf-8?B?bzgzZUtZT09BaTlpNC9MY093dlcwckpaZndwdm92elJ3MktyZXZmaURXN1k4?=
 =?utf-8?B?d3Nva3JOWVZMbFV0SDFac0VKQ29ibHM2Q2VxYk5uSXU2N1FmZ1VPMFBTUlFx?=
 =?utf-8?B?M2RmWC9DL0VubEJyZC9hall2YTcrNm1zQUcxNFpaWVV0Y1pFS014Q2xKcjhp?=
 =?utf-8?B?TDVoMEk5MG0rTWVoSk05Z1dlbkNhV0QrTkJyK0JMSlNjdk1aaVBYZmozR0Fu?=
 =?utf-8?B?VHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 12566648-111f-4496-32e9-08db6dec5785
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 22:03:25.2592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uvKo+kpK+KvDrSv1Q6roWi2lM+iHXaWUVf5mauOaz6JCn+KKKoNzMnddfxhq+8b789NVNAMv2xM5Cuo6bOStFcqGYhKwuokEWmJIs5Mohfg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4781
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 5/25/2023 11:01 AM, James Morse wrote:
> Because of the differences between Intel RDT/AMD QoS and Arm's MPAM
> monitors, RMID values on arm64 are not unique unless the CLOSID is

I find the above a bit confusing ... the theme seems to be "RMID values
on arm64 are not unique because they are different from Intel".
Compare to: "One of the differences between Intel RDT/AMD QoS and
Arm's MPAM monitors is that RMID values on arm64 are not unique unless
the CLOSID is also included."

> also included. Bitmaps like rmid_busy_llc need to be sized by the
> number of unique entries for this resource.
> 
> Add helpers to encode/decode the CLOSID and RMID to an index. The
> domain's rmid_busy_llc and rmid_ptrs[] are then sized by index,
> as are the domain mbm_local and mbm_total arrays.

You can use "[]" to indicate an array.

> On x86, the index is always just the RMID, so all these structures
> remain the same size.

I do not consider this accurate considering that the previous
patch increased the size of each element to support this change.

> The index gives resctrl a unique value it can use to store monitor
> values, and allows MPAM to decode the CLOSID when reading the hardware
> counters.
> 
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v1:
>  * Added X86_BAD_CLOSID macro to make it clear what this value means
>  * Added second WARN_ON() for closid checking, and made both _ONCE()
> 
> Changes since v2:
>  * Added RESCTRL_RESERVED_CLOSID
>  * Removed a newline
>  * Repharsed some comments
>  * Renamed a variable 'ignore'd
>  * Moved X86_RESCTRL_BAD_CLOSID to a previous patch
> 
> Changes since v3:
>  * Changed a variable name
>  * Fixed various typos
> ---
>  arch/x86/include/asm/resctrl.h         | 17 ++++++
>  arch/x86/kernel/cpu/resctrl/core.c     |  2 +-
>  arch/x86/kernel/cpu/resctrl/internal.h |  1 +
>  arch/x86/kernel/cpu/resctrl/monitor.c  | 84 +++++++++++++++++---------
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |  7 ++-
>  include/linux/resctrl.h                |  3 +
>  6 files changed, 83 insertions(+), 31 deletions(-)
> 

...

> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 86574adedd64..bcc25f5339c0 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -142,12 +142,29 @@ static inline u64 get_corrected_mbm_count(u32 rmid, unsigned long val)
>  	return val;
>  }
>  
> -static inline struct rmid_entry *__rmid_entry(u32 closid, u32 rmid)
> +/*
> + * x86 and arm64 differ in their handling of monitoring.
> + * x86's RMID are an independent number, there is only one source of traffic
> + * with an RMID value of '1'.
> + * arm64's PMG extend the PARTID/CLOSID space, there are multiple sources of
> + * traffic with a PMG value of '1', one for each CLOSID, meaning the RMID
> + * value is no longer unique.
> + * To account for this, resctrl uses an index. On x86 this is just the RMID,
> + * on arm64 it encodes the CLOSID and RMID. This gives a unique number.
> + *
> + * The domain's rmid_busy_llc and rmid_ptrs are sized by index. The arch code

rmid_ptrs[]

> + * must accept an attempt to read every index.
> + */
> +static inline struct rmid_entry *__rmid_entry(u32 idx)
>  {
>  	struct rmid_entry *entry;
> +	u32 closid, rmid;
>  
> -	entry = &rmid_ptrs[rmid];
> -	WARN_ON(entry->rmid != rmid);
> +	entry = &rmid_ptrs[idx];
> +	resctrl_arch_rmid_idx_decode(idx, &closid, &rmid);
> +
> +	WARN_ON_ONCE(entry->closid != closid);
> +	WARN_ON_ONCE(entry->rmid != rmid);
>  
>  	return entry;
>  }

...

> @@ -377,14 +399,16 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
>  
>  void free_rmid(u32 closid, u32 rmid)
>  {
> +	u32 idx = resctrl_arch_rmid_idx_encode(closid, rmid);
>  	struct rmid_entry *entry;
>  
> -	if (!rmid)
> -		return;
> -
>  	lockdep_assert_held(&rdtgroup_mutex);
>  
> -	entry = __rmid_entry(closid, rmid);
> +	/* do not allow the default rmid to be free'd */
> +	if (!idx)
> +		return;
> +

The interface seem to become blurry here. There are new
architecture specific encode/decode callbacks while at the same
time there are a few requirements:
- closid 0 and rmid 0 are reserved
- closid 0 and rmid 0 must map to index 0 (the architecture
callbacks thus do not have must freedom here ... they must
return index 0 for closid 0 and rmid 0, no?).

It does seem a bit strange that the one layer provides values (0,0)
to other layer while requiring a specific answer (0).

What if RESCTRL_RESERVED_RMID is also introduced and before encoding
the CLOSID and RMID the core first checks if it is a reserved entry
being freed and exit early if this is the case?


> +	entry = __rmid_entry(idx);
>  
>  	if (is_llc_occupancy_enabled())
>  		add_rmid_to_limbo(entry);

...

> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 7d80bae05f59..ff7452f644e4 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -6,6 +6,9 @@
>  #include <linux/list.h>
>  #include <linux/pid.h>
>  
> +/* CLOSID value used by the default control group */
> +#define RESCTRL_RESERVED_CLOSID		0
> +

#define RESCTRL_RESERVED_RMID		0 ?

>  #ifdef CONFIG_PROC_CPU_RESCTRL
>  
>  int proc_resctrl_show(struct seq_file *m,


Reinette
