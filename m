Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80350688B12
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 00:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbjBBXqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 18:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbjBBXqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 18:46:11 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE1F72656
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 15:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675381553; x=1706917553;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=r3BfxE6IBUW1XU25YzvMHLD7714LRUaerQ4NLiaDQT8=;
  b=Go6PZLL9eyGz6GYHB0V2fKCSLpmNCcmK1HDPMIfz9QNmjnG4Xq0YrBY5
   mMyfC9ZGFCVOW1oYAXWaMd3v3tlanKf5aBaBe431ArzUK/oEXW4ajXVT1
   dG5BOHClnZlDIFkBlKXMsyb6o5c/dHKumlz3/l5OumbN2mNhNXSLFFtHB
   KQ00PqxayPNDifk1pEwjw/Ze0aSqcbYcCxJd2EojrtnvPMwaIr5yxOOCG
   J6KxxXSJrDQrHz8HdFq1Mhb7sp15n0m+M1lw6Wh9cDSYX/j/al4JU1IOI
   mjGqWroLUhFi/HRqZyFh/2shh1q7L1lPORDkL4DrDvfwQ0g10ReNQzXOh
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="355944447"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="355944447"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 15:45:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="839397863"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="839397863"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP; 02 Feb 2023 15:45:51 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 2 Feb 2023 15:45:51 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 2 Feb 2023 15:45:50 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 2 Feb 2023 15:45:50 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 2 Feb 2023 15:45:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DvUN6QOSoIf3vGTlKIQk1AoajDp5VHYqrByQ2K8FRkjgtlBJAvS9VJlnJ8Gnkol7Wi3p8RNX0dYgm1Na1Rzex1iJPin6aoWrF0+fpDuBRshARlld0/cLLO3wzyj8QkFPfAgJIR3W3wc83FSzfC5h+ldm8noJWReKUET49mhWvE74HTAtKeUgHNi4P0zBAa8Bp1gQyTuwq4jr9CpyrDOEBuPVmiX2RucNio0hsuwOlw9ARwGbQdQgfw5lhSq9q/u/iMAElkPcTECvOdq2VtS1TQ67mYeL2aPLbcn1pXBuYoHIGJiW5sfF/x7AEnbOU2FJUHgKFOifxuID7/5FXvpgnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Srfwu/d4EdTVn7gTkpAWjPA4OZtms6bM4D9BStrT+yw=;
 b=MfejScGY092XmhEAiArCW+uwiR6cZobK+r350giTgbHRZjAHZ25LCj613C7/BtKLBjDzhK0aOA2cQfCRFv14VVpCHkshqdoRiwNM/QVO7oykaFjVMrw23fFltYn7D4smX/4Hq27UGlgNXOEAP6fZYS5TIjlJsrYTYzIsE9l2inWogKqxAvgAgU8tbhuX/B1UXgHed6YNTq8yjG9R+nrl4EqTGgz3mM/bclGP+RYkQyI06hy05wLEF/zwwzeB/B/OMMDzmwG9TClTWwqnQ3Aiy+AKW09S0QajcEkwXF2W88qoT2Ai5GuHDxEF3rjZfrSj69VM+p8AHARZzrXx5Hka0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DS7PR11MB6175.namprd11.prod.outlook.com (2603:10b6:8:99::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Thu, 2 Feb
 2023 23:45:49 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.6064.025; Thu, 2 Feb 2023
 23:45:49 +0000
Message-ID: <2ad21ffe-6019-eb34-a0b3-2c9d26799269@intel.com>
Date:   Thu, 2 Feb 2023 15:45:45 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH v2 05/18] x86/resctrl: Allow RMID allocation to be scoped
 by CLOSID
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
References: <20230113175459.14825-1-james.morse@arm.com>
 <20230113175459.14825-6-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230113175459.14825-6-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0015.prod.exchangelabs.com (2603:10b6:a02:80::28)
 To CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|DS7PR11MB6175:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cbc1c3f-4833-4cd8-06f3-08db05779c62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fA+cVscD/VhrbOplgwT0dfCBy6hf87L5sCrb/WXgbr+Amc+mGS5oHYuL0NldIrPbuVrPrDpamuqEKJS3CXPnUbRjKm/JpvRwiUWvSCBBaf5BSGPRCAowr3YtQ7T7rmwykVQa9Tc2PfW1YvXeiB2GKb68I8O3PoS/4ZIQi/LMVu+jGlAG0mi3Hz98l0rG/qfGauoX6lLra3KwHrg2X0MIg4nv0lXly63tl92huYecZVPK2qjPShRlJSeGLH8CAUAgqumsYWFVQbX6JkebYqHp5SHgsYPQg/ubUbId4FsgSnGA7P43z+8xixNHEELoTn7oCNBzJwlzKDIul4vLmjLaJWl/gB2U4jzCPYShzcQpHifTeUoewXJ6JcKpRiz3DwiA418E1sa+3xPsMYKQsUFo1UBtFUpiL+uQhUh05MXjARUarYMRiO9irQ7X0trx+HdffekzpSmO2gS0Bt45Sp5YVrsXD3Yrjp2Xo3q9ggpKlWq5OIlBICO2fpXEvnT3Ewd+RRIhp99aLXtg6bcVvZzRreFNrDu7WbIumq8/BJZ/+BXRS+MJV0OivL52Pg5jpDBPfNvzKpN3Fou5wxMZ9jR9Gs4IVh8ihXu+C9x05umRzJyx7/bleFHv5FHLHVKqFaUFl/J3d062WHn0EcHTIxsqBimVEmRJio0YHQ2zbImCUddlBj8TMzybD12m4kXwT29WRGRif0FBMA/iNW4Zy57ZJMWF5CQRJPG1EnSzblSUr9A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(396003)(39860400002)(366004)(376002)(451199018)(36756003)(478600001)(82960400001)(66946007)(8676002)(4326008)(66556008)(66476007)(54906003)(316002)(6506007)(6512007)(53546011)(26005)(6666004)(186003)(6486002)(7416002)(5660300002)(41300700001)(38100700002)(2616005)(31696002)(44832011)(8936002)(31686004)(86362001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0VEZysvMTZZNU1nZWo0STlXNjNUbGpHVHVmVE5zSXNSR0J5ZDcrNklReGRQ?=
 =?utf-8?B?TExGWEU1K1Y3SWM1d3R1RTZDUjdrTlU1UDZBSHFjZkhWbmxYb1RNR0lCd0pO?=
 =?utf-8?B?QXl3cEZTRlJGL3FCOGJCUytZUUpOZFVGc0xRNW1jN2hOTEJIeHZTQm1vVGlr?=
 =?utf-8?B?emRSRVRXaVNoazhOTlFubm4zdHEyZkNSdGs5bllpU2t0dVp3UTBBSjlJNEp6?=
 =?utf-8?B?SUJBWFVKRlpOaTdUZHEwYk95ZlNHSU1xdmJjemYrOWtWNklyTkdNYlErYTBN?=
 =?utf-8?B?WXNYOGFyaUprTi83UFRmUDcvUkpTR0tKVmJRSlZYN2pZT1o3bXZ5ZTBrWHBx?=
 =?utf-8?B?dDFRcjY3cmFqSnZQc0RTUE4yeFo1TGpsaUZrdmdubit1c1RoNVY5WlB1ZzA5?=
 =?utf-8?B?bXlvVkhRWTd5ZVpDTjV6QUtLQ3NqWWJ6YmVwbmtsenVIYzlPUmd5d2lLbWFQ?=
 =?utf-8?B?VXZnNW9GSmJpV2orNCtBR2hGZjBqM3l3dDhzczhQL2pBVWtob0cvcGZhTnA1?=
 =?utf-8?B?SEN6czJNcmQwdlAwc1I5S2IwM3N6RTZzMVlRbGx2ZHlZUE1xWHY3MzJRL3pY?=
 =?utf-8?B?OVBJT3lhQndSRGRwT3lUS2Vvd0tYN01Jb0lVMHlXSXJacEIzcWx1V3plRU1H?=
 =?utf-8?B?RWlPZ2JScWNSQ2RmVEdsTzMwaWd1Z3R4anQvN0R3UGpQbVd4cFVHcEhTM2hv?=
 =?utf-8?B?L2dMaCs0b3R6ZVR5d0tlTTE4dUd3SEp2U2NEN2RMVmZnbHpBMkFHSUw3Ymhh?=
 =?utf-8?B?RlZpYnA0TUw2TkVnYjRkYWtqMjE1UDd4NThoVUpDaVp2QmpmVGNxNVV1Kzc2?=
 =?utf-8?B?Ym9ydUplTXhhSmVSZjlUSTM3UmJVeCtjbzJiczYxUkF6aExKeEptaFBvWkdR?=
 =?utf-8?B?c2tjYTVRcVdCSTU1RnBrcUpYZ3VTMzE4Mmc3NEx6ZnpOOExIMnVxM3JMTzFJ?=
 =?utf-8?B?dkhRcGFueVduNkpISkkzbDJJNHlBQ1lrc0lBY3N4MEY5dk9TZjh0NzBQT2h4?=
 =?utf-8?B?WnBiV3EwMVVQYmJpWDNFVC9uSGEvbmtJZ3h6bjlXTWlaWHFpejZMaDFoVGlJ?=
 =?utf-8?B?MUQza3hQcEllMmJSZUQ4aVBNcE1uTThWRGFSMlhVY1FrY0tYeTduNkZ2c0tx?=
 =?utf-8?B?TGlwQmMxd0IvdWNOdCt1OG50Z0hETU4yM3RmdktkclUvK1dRemFlVlFJZXlu?=
 =?utf-8?B?N25CWXpKa1VuVkY3MGNuU1B6SHhnaXVkd2RGMGtMeWM0eDN5YzhYZVJOemtF?=
 =?utf-8?B?T3FRQWhPejExcWdFRW9xMktzZmYzWXBvOHpBVHVreTFzOWxZMlJENHJPdzBX?=
 =?utf-8?B?RVFpM090T1Bhb2xkVVJPNXN5ZXlVTmdZa0R1aWsxL3dwTVFVdnBiajl3WWRS?=
 =?utf-8?B?dEZJRjJ3WWRzbFJqOStobUtCY3UvVnVzNkorRytmQVZrNmFKNGxkTFVZc1lB?=
 =?utf-8?B?WUVXRzRTZmV5cFBHalB3b3I0K3RUV2l5MnZXSGdkRkt6Q2N1RDVzV2xEcmZJ?=
 =?utf-8?B?SUNLOStQUVphZ0ZqTlAwRW95N3dRSjlTaGR4RnlzWERZQlI0YnIxVnFMVzJR?=
 =?utf-8?B?alFSWXhPRVpkOTdsdWpsZDE2ank4aHdKSDEvZnJSeFdNcUdhV25OL2ZlTFYw?=
 =?utf-8?B?UXhQcVcyUjFML3VvdjBGVmpQSGlJRkIwT1hJcm10WjFFYVJoU2ZxV0pEakdq?=
 =?utf-8?B?dno2U0RkWFpsSTBXcEE2QTY1ajdEeXBBK0lML2RERDdyWHI1VnJBMytmMDFI?=
 =?utf-8?B?YWsrUGtUejNQTXdJQitUSUJmeUN3WEg3aXZ3YVNLS0k2dTk2VGUvVjVFSkVO?=
 =?utf-8?B?WkJ3OU9BbHhKVEl1L3Q4REtGN1dzODdROW9jVC9ieXh4T1hjK0diaER6ekcw?=
 =?utf-8?B?N3R1R0NuUmVReWwydWVFdkY5cHAwek9JbFM5bUlxSDdsaXQxVE1JbXg0Z2Q3?=
 =?utf-8?B?eHRWZkJIdDF0YUdZZi9MYnN6L29JeS9yVjF2R3NSWkJTSGlhQzJvZWh3YzJl?=
 =?utf-8?B?TWQ5WXZSS08wdHZPN0dzRmZXTnZxenZxOGhMK0Q0RUpReForcTdFNkRyL255?=
 =?utf-8?B?Zm1rVHhYYVNqK0d0Tm1LdTdYODc0SURCR095UHFqL0RMd0hJSlNDZGF0QXEv?=
 =?utf-8?B?MGhWaUU1cmVHRm5xUS9nQmhoa0ZjQkxkRXlMMWtRL0dEckFGWUtTdThTV1Zm?=
 =?utf-8?B?bVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cbc1c3f-4833-4cd8-06f3-08db05779c62
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 23:45:48.8786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yWPzTococr9GNuOnTK+EE83ogJxO99eZ+womQjOrhWARNy6eUfFevB+xu+yPftTL62OgcCYTL4R3JnaBda03+ZX+PgfATd5f5DVavj23GFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6175
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 1/13/2023 9:54 AM, James Morse wrote:
> MPAMs RMID values are not unique unless the CLOSID is considered as well.
> 
> alloc_rmid() expects the RMID to be an independent number.
> 
> Pass the CLOSID in to alloc_rmid(). Use this to compare indexes when
> allocating. If the CLOSID is not relevant to the index, this ends up
> comparing the free RMID with itself, and the first free entry will be
> used. With MPAM the CLOSID is included in the index, so this becomes a
> walk of the free RMID entries, until one that matches the supplied
> CLOSID is found.
> 
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Signed-off-by: James Morse <james.morse@arm.com>

...

>  /*
> - * As of now the RMIDs allocation is global.
> + * As of now the RMIDs allocation is the same in each domain.

Could you please elaborate what is meant/intended with this change
(global vs per domain)? From the changelog a comment that RMID
allocation is the same in each resource group for MPAM may be
expected but per domain is not clear to me.

Reinette
