Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB6973225A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 00:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237966AbjFOWB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 18:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235017AbjFOWBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 18:01:10 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7B42965
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 15:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686866469; x=1718402469;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WQ1pkeoM51E0a3MTJH/xZQoNCrvOqQb6djMEtR4WLqc=;
  b=nDsRdIPssXhox70rbJ+2uy50xUrJMYNG6tf54K7lXxfLJgV3C/O1un0Y
   b8PNLhFgLZG3vwiGQjz+4JPoCgRPdWj8r9iFpfgEh82IskVki8pRXPzOg
   YAzGCLeMAFC87LzwGhDlJHGy0ML0LvWucxuPzPEk5LdDwjG6xdxrfu7Y5
   Jmjt26Dv9QYzG0djfGYj5u8mjiRMYzIlltmiA4T8kLXOGSX589e6Zo8L3
   sek4jsvaKXtga/viWDYO5Ms5cw8y3bR/AUBl140f7i8BR1bzZmbCGwzDx
   tVjvZlZI02/3NAp+EJrez/mObptg0HJxy/rUisP56/cYte+R0kfDXw26p
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="356540736"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="356540736"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 15:01:08 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="745840684"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="745840684"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 15 Jun 2023 15:01:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 15:01:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 15:01:06 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 15 Jun 2023 15:01:06 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 15 Jun 2023 15:01:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXhs+TU55GtYCESvKxqmYaOEaU/B2pwN4Qjf+X6/2qknwQpSufkaHy1Uk7SrCcTZBTrEC5BWAePeZ+sFi/tGUna1eTrXykfZcDaf+UrIZXwYBwF4zZPvMkYR/Pv2Qv01LpBj4mH5STD9dE3sbpz9L5SmHAcvR39XM88avXA/VZWM8OAJcF5rK/7bh3y0NDZfHnI9G6UmLl8O10cZOnDxxUs54gM9wsAbp14uNnWaxaW2q+PUbT4fyxjYEOAqhies149a2lQmC4oQ9wUBTgKD0zOkhPFmX3mIm9D3cBnDHN8221M6zmTMyEfcjkP7Je1bw1eA1m6ACPQDiKrHliXyjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QMG2HrvNbYxoDbUadDlpxF296GjsHrWV8+Mr2mATi/E=;
 b=eCZOzCVvhDZw2UhJIFjdRPtFF95lgQyH/n0EyUREa89S5fMvGMyYqfvLNdnc1f9KjGR194TU16y76hoMPLTzk/2YTjYsZK8Q5y2Fmf3/+cvL+wYql5dvDiqHp3DTfb0auyRCUfb13d/x+830WeGodJsRkvvilMfQvdXCydhFct/m6alIgZuqhyoU5URU/6/cEEKmyHobqsei4c3zdi/OJD+AspMJy7lbhFFkN92n2P4OQR/LH/NXOwduZvfkjs6RMI0Q8WQR3kwjALNCJRTJI+KWqhDnSPpFOmtRmOJqH4Jc2Avd+ejAmfUYVkr6eqg2IMey9b5I1ZzBLMSwpKV4Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB4781.namprd11.prod.outlook.com (2603:10b6:a03:2d8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.38; Thu, 15 Jun
 2023 22:01:04 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d%6]) with mapi id 15.20.6455.045; Thu, 15 Jun 2023
 22:01:04 +0000
Message-ID: <94153d66-4c76-40c3-79ef-d2f3a3841f24@intel.com>
Date:   Thu, 15 Jun 2023 15:01:01 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.2
Subject: Re: [PATCH v4 01/24] x86/resctrl: Track the closid with the rmid
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
 <20230525180209.19497-2-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230525180209.19497-2-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0052.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::27) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB4781:EE_
X-MS-Office365-Filtering-Correlation-Id: 94e7eec5-8c8d-4202-ebd2-08db6dec0387
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ltY4v0TUi3fw5oj6AjC9UEa6pVzjvOHxtijwoOA6Lu1lMqN3PqzUIBGGopRJupRDRc+5ZSs2pZhbJssP/doKs4GP5D7ZWUxJquEWPJSBP/nXCjlckKb2frCE7aAO7XGqIGtnymyZJAifz78weKWJ5U14Zi3BHPhuutSnR7NjQKZQilds6UO5OhgW2mkEFUxMo0W9H0AsqXXVwYvV38BgQZbafX+H559KkwbYZlbOMQcQZmIoEr9zu07hK0uiKySGo3V7DVA+3WO+TQxaT0f6XXgf1V0WFAOOZMD9DTO7RQnIOuQKq3A0uwIZBaDHmeUCt6sXk6tE9CuHFlxNFILkYusiCH3ilKtKxNY3hoTERDRLoHeJKUttrtI+yPVsTjlUjc1lGmBRr4PQaC9zPgx8WN0QHjoRhe2TozmeMW6jyCV+Uz2fCDtMIwL15RzF/RAqakN4Y9AateKUHy2JTowenDpDzwDnCN/AVzH9JrNJ+6bXIGrwBeUcZ+2n01B1Do6UDD4oSBzJfgki02w9ja2FhBbBI3VE1fs/b6Q2Zb/KRz1yfNn6lNXelipdIPfOnEhnuQz7+BOypanplSAKONQQYgC8kus+RnZ0ggbeA6C7RCMgOgUm2jMRWP/SAF7ZQpVtNoWdP3ozlS3UDxgGFDTN+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(396003)(136003)(376002)(39860400002)(451199021)(2616005)(54906003)(82960400001)(478600001)(41300700001)(8936002)(8676002)(5660300002)(4326008)(66946007)(316002)(66556008)(38100700002)(66476007)(6512007)(186003)(83380400001)(6486002)(6666004)(53546011)(26005)(6506007)(7416002)(31696002)(86362001)(44832011)(2906002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mm1MYWlKSEVxRHh4ZkZFRkY5U0hNTk00SUJpbm1tV3JtWWp2RWNKY3lDb3dz?=
 =?utf-8?B?WFh3aVhRTXdJSFpNQ3JQRzQyQkk5UllGelh5UlcyWS9USjdqeSttRkN3a3B3?=
 =?utf-8?B?Q3VzTHZmb2Z2R09nVkkxZWxzMk1XTnZjQVRYMFpXNmZCZ0FwcC8vTmFpdlps?=
 =?utf-8?B?WVNLR0kvWXVLdVdaNlNXbnJDNU5wWlZTWkdIUHZCNmlBV3RpMzRzT0p2WXdB?=
 =?utf-8?B?Z3JpWWprUThCK3NuQVk3YmIvMU8xQWpiT2cwR2JHMk5WUDdIdmRzZElPRzVn?=
 =?utf-8?B?M3FEbWpQR093bmo4bnU4MkRuaDZOSnZXOFhYWkNvNTVRaUhrWXpjR21IdE5S?=
 =?utf-8?B?bm9iSzhlcjBSemk2VXhtaFF5dUkvZExoaDRJendMQ0p0R1J0RTAySUw4dTdx?=
 =?utf-8?B?VmxGbmRDNlMxMUc0azBBdkJvRFBGbEY1d0ZvZU1hbkFuaSt3NmE3OHpKRUFY?=
 =?utf-8?B?MkFKQjJoRTUxMitqWiswTDBUTzNaVlJKTkk4akRXYWFiUVNjamR3NFZRN3hq?=
 =?utf-8?B?cjR0QkRZN0xFaVZuOTh4MnJDWlFjbjlmcTNzb0ZBUmpaYTB5WUVIbWZBNk1F?=
 =?utf-8?B?ZUlvRVBpZVNIUGtIblJDV2V6dFUyS2xkUFA3Y1FPam14UXRtSmdzMll6Zjd2?=
 =?utf-8?B?K2JQMGlIYUdEM1BoYVFHWjhpTnYxVlFTRFBNUUxSeDZ1am9rc2dBdHl6a0pR?=
 =?utf-8?B?NkJSdldlaGhjTDd0U2hBTDBDVzVpTjM0bmp6YW5ORms3b2pKQU84VEkwUmVk?=
 =?utf-8?B?clZBZUJJbG9xbUNRN0hBV3RoTHlYOUxYa3RKOTdMM2xaOElZQ2hpcWNnODVR?=
 =?utf-8?B?TlNMNGkvZXBCZVlJTVlmZ3hNL2ViRDNUaDd3T09FaHg5ZHBtRC8vRWFMREFW?=
 =?utf-8?B?TC9ZVUdIM3VFQ09vQk5HVURGcUZja3dNWFlqVG1BVHdiTjZZVHFOcjBSWW8y?=
 =?utf-8?B?NFJldVcycUtMVjhmbzBTTHU3UWc4THAvM2YxUWhpNlZPa2FNYVhkS2l4eWZ3?=
 =?utf-8?B?dWJNYVJQaXhYNEZvNzFlVWF3Wm0xL215SGRpUzdzNXd4ZVBFaVB4ZTJyQkRS?=
 =?utf-8?B?OGsveURmYjlMOGROdVczdWNxWmhFQXpONHZTVDN5ZDRlaERvSElXRGlJVDdo?=
 =?utf-8?B?c0ExWlNHZmpKcmdiQjk1NEgzTTNlTFZJUGtsUXd6OFBaQ0xHQ1VGanRvRGZ4?=
 =?utf-8?B?dldMKzY2Y1FxdnYxcmJmRjNsVDN0ZnFuaEJnaGE0YjMwR3hxbWRBclVpMEo4?=
 =?utf-8?B?TUYrWDFyZHRtSWthUEVDZ3FMdER3bURTMUhlM3JJckI3VWxLcS9ORERzTU9o?=
 =?utf-8?B?WldidUZmMGRuYjNQY0hoS2VNcmU5VzREUE1YbHM2aFRyRCsxOGJXcm9tVTR3?=
 =?utf-8?B?MVZJOStkL0QyQ3p4WGF2ZWljRXYrT2ZUTFQ0RWI3SVdHWlRqY2FNS2oyVWE4?=
 =?utf-8?B?MVVhYTJhRE10U1c0bEVWRjJEdzIyR2phODZ3UzY1aDBlYWQ0eUQ4VHB3bktn?=
 =?utf-8?B?TlFQV2gyeG9lZ3pCUVpJelNlN3BUTU5NQm8rWUpaeDNiTjlLUGxSdktCaXZY?=
 =?utf-8?B?OTh2d3ppZnF5WHdaVGdCQU5MYThBRDJna0w0bFNkYitOL2RLcGVodUdkRmdh?=
 =?utf-8?B?akd1SUtUU1luYmR4cm1YUFh6UC9ObWpXTnFDT25WTTREVEZyLzlERmFSWlVY?=
 =?utf-8?B?UkdXSlJaNWFCZStsVFZGcmllRjA3VlQ1NC9SNzh3a2p4VG1Uc0pMdjBsSURu?=
 =?utf-8?B?d00vYUpKMEJ4ditHUWVZRjJ3MzlRS0d6bG5rVjJsNk1xSk9IZ0V5ZGNLTjNv?=
 =?utf-8?B?d2RqdE5OK1EydHFDbGYwOHBlUzM2VTRQbmdQNzJrZGg3QjJQL3dBWHNlcDg4?=
 =?utf-8?B?SGtuMzB3dGlZMkhLdEZFV012WWh1bEJFL05CZ0tiRCsxZmduZjEwSTJSbzUv?=
 =?utf-8?B?LytiRkh1NzJManFPVExaN1RadlZkRFBPMVBmbzl5dXRvdzk5S2xJcUZMVGUw?=
 =?utf-8?B?STB3NmgyNHZrbVJvZGYvSkpHK3YrUWJPWXluL2JHdnBlcWJZUjNFSUNYTXkr?=
 =?utf-8?B?UDBaWk14RGJpUkNFYTFtVmZMYjBpR0pucEt2alNhK2xwdUtsVjdrMmE2eU1C?=
 =?utf-8?B?VHczc1h4M2Yra1FpcWdrVVcwOGIxc0xTSEpKSllGNUwxYzFpa1pqQVByU25Q?=
 =?utf-8?B?Y3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 94e7eec5-8c8d-4202-ebd2-08db6dec0387
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 22:01:04.3772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mAnSeIwv1VHi/GZfVlwYl+0JWAjhmIFOvdOYRhViTf5BFn/gknI0W+tviGUB9ol0J0bCQJgOviQHdgUpRqIPg4E2h9tLQYLizY9I1lwOtEE=
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
> x86's RMID are independent of the CLOSID. An RMID can be allocated,
> used and freed without considering the CLOSID.
> 
> MPAM's equivalent feature is PMG, which is not an independent number,
> it extends the CLOSID/PARTID space. For MPAM, only PMG-bits worth of
> 'RMID' can be allocated for a single CLOSID.
> i.e. if there is 1 bit of PMG space, then each CLOSID can have two
> monitor groups.
> 
> To allow resctrl to disambiguate RMID values for different CLOSID,
> everything in resctrl that keeps an RMID value needs to know the CLOSID
> too. This will always be ignored on x86.
> 
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Reviewed-by: Xin Hao <xhao@linux.alibaba.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> 
> ---
> Is there a better term for 'the unique identifier for a monitor group'.
> Using RMID for that here may be confusing...
> 
> Changes since v1:
>  * Added comment in struct rmid_entry
> 
> Changes since v2:
>  * Moved X86_RESCTRL_BAD_CLOSID from a subsequent patch
> ---
>  arch/x86/include/asm/resctrl.h            |  7 +++
>  arch/x86/kernel/cpu/resctrl/internal.h    |  2 +-
>  arch/x86/kernel/cpu/resctrl/monitor.c     | 65 ++++++++++++++---------
>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  4 +-
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 12 ++---
>  include/linux/resctrl.h                   | 11 +++-
>  6 files changed, 64 insertions(+), 37 deletions(-)
> 
> diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
> index 255a78d9d906..e906070285fb 100644
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
> +#define X86_RESCTRL_BAD_CLOSID         ((u32)~0)
> +

I do not think this name is appropriate considering that it is later used
in x86 normal operation. I understand naming is complicated, could
something like X86_RESCTRL_EMPTY_CLOSID be appropriate?

>  /**
>   * struct resctrl_pqr_state - State cache for the PQR MSR
>   * @cur_rmid:		The cached Resource Monitoring ID

...

> @@ -628,7 +640,7 @@ static void mbm_update(struct rdt_resource *r, struct rdt_domain *d, int rmid)
>  		 * the software controller explicitly.
>  		 */
>  		if (is_mba_sc(NULL))
> -			mbm_bw_count(rmid, &rr);
> +			mbm_bw_count(closid, rmid, &rr);
>  	}
>  }
>  
> @@ -685,11 +697,11 @@ void mbm_handle_overflow(struct work_struct *work)
>  	d = container_of(work, struct rdt_domain, mbm_over.work);
>  
>  	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
> -		mbm_update(r, d, prgrp->mon.rmid);
> +		mbm_update(r, d, prgrp->closid, prgrp->mon.rmid);
>  
>  		head = &prgrp->mon.crdtgrp_list;
>  		list_for_each_entry(crgrp, head, mon.crdtgrp_list)
> -			mbm_update(r, d, crgrp->mon.rmid);
> +			mbm_update(r, d, crgrp->closid, crgrp->mon.rmid);
>  
>  		if (is_mba_sc(NULL))
>  			update_mba_bw(prgrp, d);
> @@ -732,10 +744,11 @@ static int dom_data_init(struct rdt_resource *r)
>  	}
>  
>  	/*
> -	 * RMID 0 is special and is always allocated. It's used for all
> -	 * tasks that are not monitored.
> +	 * RMID 0 is special and is always allocated. It's used for the

Considering this change it may be more specific to now state that both
CLOSID 0 and RMID 0 are special.

> +	 * default_rdtgroup control group, which will be setup later. See

default_rdtgroup -> rdtgroup_default

> +	 * rdtgroup_setup_root().
>  	 */
> -	entry = __rmid_entry(0);
> +	entry = __rmid_entry(0, 0);
>  	list_del(&entry->list);
>  
>  	return 0;

...

  
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 8334eeacfec5..7d80bae05f59 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -225,6 +225,8 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
>   *			      for this resource and domain.
>   * @r:			resource that the counter should be read from.
>   * @d:			domain that the counter should be read from.
> + * @closid:		closid that matches the rmid. The counter may
> + *			match traffic of both closid and rmid, or rmid only.

It may be helpful to be specific in the references to parameters:
	closid that matches @rmid. The counter may
	match traffic of both @closid and @rmid, or @rmid only.

The "counter may match" text is not specific. Can detail be added
on what decides whether a counter matches both closid and rmid, or
rmid only?

>   * @rmid:		rmid of the counter to read.
>   * @eventid:		eventid to read, e.g. L3 occupancy.
>   * @val:		result of the counter read in bytes.
> @@ -235,20 +237,25 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
>   * 0 on success, or -EIO, -EINVAL etc on error.
>   */
>  int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
> -			   u32 rmid, enum resctrl_event_id eventid, u64 *val);
> +			   u32 closid, u32 rmid, enum resctrl_event_id eventid,
> +			   u64 *val);
> +
>  
>  /**
>   * resctrl_arch_reset_rmid() - Reset any private state associated with rmid
>   *			       and eventid.
>   * @r:		The domain's resource.
>   * @d:		The rmid's domain.
> + * @closid:	The closid that matches the rmid. Counters may match both
> + *		closid and rmid, or rmid only.

Same here.

>   * @rmid:	The rmid whose counter values should be reset.
>   * @eventid:	The eventid whose counter values should be reset.
>   *
>   * This can be called from any CPU.
>   */
>  void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
> -			     u32 rmid, enum resctrl_event_id eventid);
> +			     u32 closid, u32 rmid,
> +			     enum resctrl_event_id eventid);
>  
>  /**
>   * resctrl_arch_reset_rmid_all() - Reset all private state associated with


Reinette
