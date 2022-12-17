Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F76A64F6AD
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 02:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiLQBK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 20:10:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLQBKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 20:10:25 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019F21D303
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 17:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671239425; x=1702775425;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XYXJ/tDCR2OFtgf1doC72YRyiM5X4DToDIaqzgsuXMI=;
  b=ZMee3jlZmSQMvX6SNm3gBpeLcnJrFwb7xjPGshH1lsIyAKKSrSNA7fk2
   EXxGt9nzBUEJp61zpqpdB9Jf1/BkUVr8vD6Ry4W3tWbvlp4397GOSQA1p
   8Va/3p9Q+S2eJ2KmYFk+BKV97sBKgloshA8CcDHYmyCg/Qn8+A0sjMoqH
   ORkuPolKxefHEUeM3KhDezxh/sNRy1bO+IVVNCs8XVCwjoy2rIYjj2xjW
   QsClUpmOtu1j5XyNG2l8SycciyPExvZZMotLyJR5rR2pP99iFkPBmsCTr
   ErSmuOWzhz2l3VQYMC1mFNR8xlUGHTq5qlQyxMBSzOvdODZSqBoVmJ6rf
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="405342890"
X-IronPort-AV: E=Sophos;i="5.96,251,1665471600"; 
   d="scan'208";a="405342890"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2022 17:10:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="600115914"
X-IronPort-AV: E=Sophos;i="5.96,251,1665471600"; 
   d="scan'208";a="600115914"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 16 Dec 2022 17:10:23 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 16 Dec 2022 17:10:23 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 16 Dec 2022 17:10:23 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 16 Dec 2022 17:10:23 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 16 Dec 2022 17:10:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZ9b82zRSIb8SVeiHk9+1bClb2biVDjVELUSeCRIWY1Y1+/79rjmT/Nh8I14IKkhur+EaoeIMwO9x1s7diBl7fp7Z9LgW5x0/PpcqdaWVrXytBjUZSt1TtEW4Nk/2UU3iTj6FJpD80eJaB3DFZd06jdAbpHcZX2S+h4p5G99fv7hVn6v4Q2Yh15E3e85qwKhhmVgU+OS40Y2A5LWDH7y2rfs6jutj4Zl9PFSqXi3oNTzq2TjH+A2zA9VbFLswRFooUItZfMchChzkouW1EKSEe/5PcmVc1xGgvv9u/f1+MGL5o+rU53BL2RKF20WB66j7EBRhisQqW5drDlKE62FiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9DIauNL+WAXBfssDwRudxOXp7sw2og/xRVIBrSDr/g=;
 b=BWTfb48tIDzCVdnyZwpE+M48Ow++ySWVe+yp4xrMHVw5D+mc/2rKwjG+UsAcQZ2+RWHQ5EkFL3pF6RVmAS05L4RvnGpUiJ2S563j5wlqDr2f9G9A1vCp68T6D+/L5ZUPDhNlmXfKJrO6P3QoUT28EsZ7nqdm1l50DwjR2qhByv3Pc6jIExC456iuiJXy/jKr3ppK1yUCfxFnk5doeJtbO+7AO4y8g8zzqKrMGMAMh4pht0B3qbPFiEohPeHboum9ZqboD5bSqgBmia0dCDl+xTThiSfCsEJdH3j+7sbNxKo9xhKDDurzCqzq5SgTDOBohs2Gg7zaKYLR0LaGYvFZRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by BN0PR11MB5694.namprd11.prod.outlook.com (2603:10b6:408:167::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Sat, 17 Dec
 2022 01:10:14 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.5924.012; Sat, 17 Dec 2022
 01:10:14 +0000
Message-ID: <ddc5535e-a67b-9079-c147-9f290fce2e3f@intel.com>
Date:   Fri, 16 Dec 2022 17:10:11 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH v2 2/2] x86/resctrl: Avoid redundant counter read in
 __mon_event_count()
Content-Language: en-US
To:     Peter Newman <peternewman@google.com>, <fenghua.yu@intel.com>
CC:     <Babu.Moger@amd.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <eranian@google.com>,
        <hpa@zytor.com>, <james.morse@arm.com>,
        <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <quic_jiles@quicinc.com>, <tan.shaopeng@fujitsu.com>,
        <tglx@linutronix.de>, <x86@kernel.org>
References: <20221214160856.2164207-1-peternewman@google.com>
 <20221214160856.2164207-2-peternewman@google.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20221214160856.2164207-2-peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0026.namprd10.prod.outlook.com
 (2603:10b6:a03:255::31) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|BN0PR11MB5694:EE_
X-MS-Office365-Filtering-Correlation-Id: 207e16f7-a823-4360-363d-08dadfcb73fe
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SJD5cUHSlxeKBCC9hceWYdKT50gkUfmacTiC1IICaP4/3peWbn41uAYnbBEnm6HheO7d7ONMOnY9jhuo846ELqt0d2rMfTt6VdODev18iMEDklAuDyxRkEDnlAZSvoq4sQNPksT0hNjg9xGAwIdV1+uZ7Fpy3Ab/BFmxddMyGyP1schf07MxBgTjFqji5tdSxrE9vPbDOihBvrcCNVC3UNmtENwljFe0DImBENzdiLrm4Mxl/iO39hbiqrLHvC2P29XSsvSULuQZLxGg6lBoWVq1ofLObalXyY5qT8DepFck7wv2liOZAGe562xPZdFTpjzov/Is/ySu2KQflRFpSUwhSaqowVv93YdQOph6GaYScZbyomj4k2KORZk/xYKpbo+yY61TUSfUgf8IMJjXn21Jj0R+vbSgDc0cSlksoXKbcWejbJuHFlsDOsXmL+20IjwQBf575uOpJiaH3PPIW8NwdG5axIog77Vv5FQhC5I82DTgIlgydoUP0BPbs61Yrv8bg/+38adthWSpsRdc7pYt9eTZFtv4jffugX/YF5fgvP3QeIhXggEMQdUTwExzlHyN2g5AKgJ/IW5yCYf89GmOyczEa2vVxLAKtTeSi37FwBQ0ko+t5NB2T68OFdtyPIZP5skrSpw8y4BTYHxeU2Zdr1nFrj8RWeEiZsgeWi6fxiV60IQoIVKc/0/sOXxZ7NGSHXVOdklVsg0CIS0njomTzGKORkcBgbihv1ysBIY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(39860400002)(396003)(346002)(376002)(451199015)(36756003)(31686004)(38100700002)(2906002)(66476007)(8676002)(82960400001)(4326008)(66556008)(66946007)(7416002)(5660300002)(83380400001)(31696002)(8936002)(86362001)(44832011)(478600001)(6486002)(6636002)(316002)(41300700001)(6506007)(26005)(2616005)(6512007)(53546011)(186003)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qm9DWjErUFNDVzlZMkZLSTZZM2MwR1pBUzlIZ0tEZ3VyMGJtc3hCY0RpbDRh?=
 =?utf-8?B?QURYZUlmK2dubkVBeW9TSDJRU3RpVG1xcDRDZjhnZG9oNkZEdzV3WWc0MHFN?=
 =?utf-8?B?RFhna2lQcWlZbWRDN3VwUGpRT3BZK0kydlh4OE4wTVd1cVV2ZjM5UkdIRDRP?=
 =?utf-8?B?QmlxaWJuWGRZYks4aTUwdlNrWUhDdm50RWYwcStlRE8veXJqamo3RWJVU2g4?=
 =?utf-8?B?WTZNY1VnY2d2bk0rT1VkczFDSkpaUWZPR3JuL2ZZbmlLenlTd3A4ZWJ5bFc0?=
 =?utf-8?B?RWVZbjAySDViMU9zT2pDVHFhVUI0dExrTkZ3SE5VQ3c3YS9jUTA4T29pcU55?=
 =?utf-8?B?aHV6TnRadmYrZC8wcXZTOGplV3owZDlySmVod25KSVo4THBLRTFqTVFNWEFI?=
 =?utf-8?B?djVuRXY3MFk3Tk1KS3dSSTh1eWFuQkZMd3BxeFVYV2VHRUFQcWxORWxwTHFh?=
 =?utf-8?B?SExvLzBzWWFxcVVOT2FSWDJjR1BhNC9jUkRldTdJT1RIUWsyRFE4QnpvMVd0?=
 =?utf-8?B?Y1R5MFRpN2xtUVFDMFBHLy93RjgwbkxkWkVOdWhqWWFZeEs5VTZqbEMzSFVD?=
 =?utf-8?B?UE9ZZGlRSGs4U0x6VVhrVjVYMTBjSlg0WENaR2lMcWNhT3NjTWVXRFBzREc1?=
 =?utf-8?B?TjBWeUxMWTRQTnhhLzRhSGFCczErbi8wMjU3dUswUnROamtDU2ZHRFlCSml6?=
 =?utf-8?B?THM3cEVmd09Ca0gyNk83QUlXQzE1SFJQS05PN2JHbUdEZ3ZZeDR4MWZxTGpQ?=
 =?utf-8?B?dHEvMFpaNW93OWhvdHA3Vm1vVjJwVmlrK1hUT2RodTRieHZSS1poOHIxNGdl?=
 =?utf-8?B?REF6OXB2cWdDVXphQUZIb2VkQ01COVRhQURmTWZTcTcydlZYemIwVWpjWXVT?=
 =?utf-8?B?bzZvK1huMWo3SVlMVmpBUnoxVnEvaHVNTjM4aTYycFE1b1h2QkR3YkF3WDE4?=
 =?utf-8?B?Mzdjb1hqNld4bG90MVpPb0pUNmJOdW5OMnhBNExNcUpzQkhFSitQblNXS09K?=
 =?utf-8?B?c05wYkg3T1J5MGJnNnpCaUZhdGcxVkNLNE4waW1JMFZkY2QyTm9odlFWd3Vk?=
 =?utf-8?B?bW82c2ozYmVsRjVZWFVNczVmRnVENWlLdG11K2toRUttd2RMeWpUT1RuWXgy?=
 =?utf-8?B?Yk9kcmM0Vlp0RzdLMFNveEsxaWQ4QlB2eUdFeXpwQm52N1o0TnRIakZSZDFj?=
 =?utf-8?B?M1JUK1ZWZDRTOEQ1NEJKeUVScndYb1pDaU5VbEJKQ1RjU0Y4dWdRbVpYVTQ5?=
 =?utf-8?B?M1Z5aU51NFZ3YjRmTVQ0YmNjWlcybnRRMk8vSDVNV0ZOK3E2dTQrQTlDdXAz?=
 =?utf-8?B?bU43TFV2c2hYY1Rja1BJL0RkbkxKcjhkUndobzRBM0JGOE4vUEtUcDE0ancz?=
 =?utf-8?B?NFAxUXlzTWN2VytaTmdjQVZ4SVJYZ1dsalhTQlBYbzZFNjkxQmJBVTVEUXd4?=
 =?utf-8?B?T0pjMFl6MGUrbHU2ZVBQZDlqeDh4MFVvTXgvalFKQWpSZ3BLbVR4ZWhpTzBj?=
 =?utf-8?B?TXRQRkZuOWFJeDFFRUdqN003NzRCaUNXRnA2SkF3NnJxM1VYN2lQOGJCMVJM?=
 =?utf-8?B?cUthc0NNTlJhZkYxVkdaZUNQUDdhcHM5NkZRMUdHa0F3OUpPa2JRR3U4VHhk?=
 =?utf-8?B?dFRPNVFrdGd3ZnBzRnhCZk50VmxJbGgwQTloRjNsdE1KVm9EUXd2a3JUejNp?=
 =?utf-8?B?bkpXU2NkVTQvTFhtcHR5T1FNV0p3UldJd3dVL0RiSkxhelZZbkJteGtwblpi?=
 =?utf-8?B?dFkxSzdjU0ZJZEdJM1ZQYWVEckVzZGlDK3pPR0pyOHptRTUwL255UjlMNEFB?=
 =?utf-8?B?aEJ2aUx5bWdWOHpqTGZOYU15NjFvak84NGJmdUtyQzBaU1RDc3BGWkw3UjlZ?=
 =?utf-8?B?aklZTVdSVjEwc3prakt1UW8rbDNoWlRYcDZWc2xNK2xWenVieUFsSTlwbTFM?=
 =?utf-8?B?aC9WYkx5c3hUMDRaaWhYekx2a2k5MlZYS0pFMmxUS0tLQmREd0Q3Mm0vUGJM?=
 =?utf-8?B?VFBINVphWUMyNlgxdE1STDZpcnNVcExucklSSVhGNFZuMjczWE5iWVBsZ3Va?=
 =?utf-8?B?S1E2WGo2ZGMyaFdZQXNiN3hMVWQ2ZGxWM21EUjF4bnhBL3JadVNUOUZHcUIy?=
 =?utf-8?B?bWRrUmdvL2VuaGZseVlFSnZ1dmRHMmVRTTNUV05RNzNWd2JFR3ZldWZETWhY?=
 =?utf-8?B?V0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 207e16f7-a823-4360-363d-08dadfcb73fe
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2022 01:10:14.5460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pwrbgKETEj6iXGAkavyPkdr9nAaPyDvLYH/dPUGkQmVskWfu4ablP3QEkJE4bbLbFSXNWHrAbxN4tGS4fWBlRRfCwOXqv/Y5U96BDleJ0ow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR11MB5694
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

Hi Peter,

On 12/14/2022 8:08 AM, Peter Newman wrote:
> __mon_event_count() does the per-RMID, per-domain work for
> user-initiated event count reads and the initialization of new monitor
> groups.
> 
> In the initialization case, after resctrl_arch_reset_rmid() calls
> __rmid_read() to record an initial count for a new monitor group, it
> immediately calls resctrl_arch_rmid_read(). This re-read of the hardware
> counter is unnecessary.

"... and the following computations are ignored by the caller during
initialization."

> 
> Following return from resctrl_arch_reset_rmid(), just clear the
> mbm_state and return.
> 
> Also, move the mbm_state lookup into the rr->first case, as it's not
> needed for regular event count reads: the QOS_L3_OCCUP_EVENT_ID case was
> redundant with the accumulating logic at the end of the function.

Starting the above with "Also" creates impression that two logical
changes are merged into a single patch. Since this is not the case you
can avoid the impression with something like:

Following return from resctrl_arch_reset_rmid(), just clear the
mbm_state and return. This involves moving the mbm_state lookup into
the rr->first case, as it's not needed for regular event count reads:
the QOS_L3_OCCUP_EVENT_ID case was redundant with the accumulating logic
at the end of the function.


> 
> Signed-off-by: Peter Newman <peternewman@google.com>
> ---
>  arch/x86/kernel/cpu/resctrl/monitor.c | 43 ++++++++++++---------------
>  1 file changed, 19 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 77538abeb72a..e708df478077 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -366,41 +366,36 @@ void free_rmid(u32 rmid)
>  		list_add_tail(&entry->list, &rmid_free_lru);
>  }
>  
> +static struct mbm_state *get_mbm_state(struct rdt_domain *d, u32 rmid,
> +				       enum resctrl_event_id evtid)
> +{
> +	switch (evtid) {
> +	case QOS_L3_MBM_TOTAL_EVENT_ID:
> +		return &d->mbm_total[rmid];
> +	case QOS_L3_MBM_LOCAL_EVENT_ID:
> +		return &d->mbm_local[rmid];
> +	default:
> +		return NULL;
> +	}
> +}
> +
>  static int __mon_event_count(u32 rmid, struct rmid_read *rr)
>  {
>  	struct mbm_state *m;
>  	u64 tval = 0;
>  
> -	if (rr->first)
> +	if (rr->first) {
>  		resctrl_arch_reset_rmid(rr->r, rr->d, rmid, rr->evtid);
> +		m = get_mbm_state(rr->d, rmid, rr->evtid);
> +		if (m)
> +			memset(m, 0, sizeof(struct mbm_state));
> +		return 0;
> +	}
>  
>  	rr->err = resctrl_arch_rmid_read(rr->r, rr->d, rmid, rr->evtid, &tval);
>  	if (rr->err)
>  		return rr->err;
>  
> -	switch (rr->evtid) {
> -	case QOS_L3_OCCUP_EVENT_ID:
> -		rr->val += tval;
> -		return 0;
> -	case QOS_L3_MBM_TOTAL_EVENT_ID:
> -		m = &rr->d->mbm_total[rmid];
> -		break;
> -	case QOS_L3_MBM_LOCAL_EVENT_ID:
> -		m = &rr->d->mbm_local[rmid];
> -		break;
> -	default:
> -		/*
> -		 * Code would never reach here because an invalid
> -		 * event id would fail in resctrl_arch_rmid_read().
> -		 */
> -		return -EINVAL;
> -	}
> -
> -	if (rr->first) {
> -		memset(m, 0, sizeof(struct mbm_state));
> -		return 0;
> -	}
> -
>  	rr->val += tval;
>  
>  	return 0;

Thank you very much.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

