Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A231D6D2BAA
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 01:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbjCaXZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 19:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjCaXZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 19:25:08 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4232DF76F
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 16:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680305107; x=1711841107;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MTsTWWyoiBChCw8J/a4Mp+kDk4pGehN468zO27wKi/0=;
  b=T7nx+8PjI+VpkR8HYAfYo3XYMPKPT9xCC1DLhn1qpdZQiLFUk94VPtmR
   69RvbwRoQQJBAAYgs2Z2QaWzQxugjGKG1l4kLWJ/phrJSy3xfNZiPwBik
   G+g+E7Zy62rwXfYWiBkrtXI1DJlUyuv7ozEMyNkp1+ruGUqdZLVelgMiE
   I5i2/+zL3x8++0i+TWRI1Ogeg/nuFb8MdB4p7PS6O1zomAqySszuR2F7h
   gBW6S2HkQLcNb1Qt7JDnpZQ0pQl+ZlcyJGaUYZfs/c25XLKk8pF0hoO6k
   DhLtsYihmvSvJFtdu4I0yzU2+hHTMf4inIXCPA0D94MVS/+0XOAOJvnok
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="321230608"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="321230608"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 16:25:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="715625357"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="715625357"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 31 Mar 2023 16:25:06 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 31 Mar 2023 16:25:05 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 31 Mar 2023 16:25:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 31 Mar 2023 16:25:05 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 31 Mar 2023 16:25:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RNlrEb1O8WEBCwQMrkvPFT2RcMZycf43xPa3PnRGrHzmdhDNNKNAo9+skMbpl5USuI8NxDgXTOL6Vyjwg7yVFoaGoenawJw6OriJs81Hdx5TPkQPr42pupD/k00oulUAFtRb/MCF99+0YAcElSVoDBznRHku/S2PQfKuNe+rCQ0FGpmfeZaBjf19jQtxSWBNzJI6sulUXcvXf8GxCkMQSVh9g/lzX0kM8Mcp8MIYeROy/NZcT9yaMQ7VzNINfpYwhQxlIWHkBF2T/aJ9cKnUWd9c65nucYycxNB5xfad2K6jxUCdptWofZxuaJdzpshgr6lAQZhCMOU2aUfqpCzIWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BOO3zoZp3empOP/vxW0jes3eDlaNsqHbwmZbAtx0uw4=;
 b=VWU/RHU/SeY08MRN4kPVDbdLkGh32/y94x6p1LEOXer/4izIBr4j6VIiRxaEwyOoLI2tygyBqmWK+B9hcsno/pnCh87o+6j92Pf3JwbIat3bR6Kr1msUzUKvY2FfhQP+ysFnPM22yZwZ7ZXAziy8wHRW6zdsv3Vxqa/q3zG/uRtKgWZB8drN8S9qbRFYz66d5TaMRFzUfMImYImBuqW9+P1h3mTtK2YBlMsyP8+KELHdHzeSr/bMpTyr3eTMPFS4CDvToTCOWSNY3emjIaBTITlN2PqX6ziN68z+g0Nv7l+ooAkKKrKNp2Rg4pM1+ktwXY/JqcNmk4g/z9onB0VeGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by PH7PR11MB6426.namprd11.prod.outlook.com (2603:10b6:510:1f6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Fri, 31 Mar
 2023 23:25:03 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6254.024; Fri, 31 Mar
 2023 23:25:03 +0000
Message-ID: <3145caff-4e73-0ef2-5bc2-70cdfe7953e9@intel.com>
Date:   Fri, 31 Mar 2023 16:24:59 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.1
Subject: Re: [PATCH v3 08/19] x86/resctrl: Add cpumask_any_housekeeping() for
 limbo/overflow
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
 <20230320172620.18254-9-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230320172620.18254-9-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0008.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::13) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|PH7PR11MB6426:EE_
X-MS-Office365-Filtering-Correlation-Id: c781b1b3-eea6-496f-bd0b-08db323f273e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 74xt755OczAJW/Us+MjqCzd/+qhSSmaRcItRbTQTYnU1I7hGl4D1/xxa0pjKsmseYkNvFtQnommBWVU3ohThqvUYGEsI+jOaaP7+d09TGtjAB7FUu1aPXviR67L0F60ykaO8Uw1aVHh4OVJhIvzUNpliWpOsFrHAdhk8gGle4vYPUwG8y3z0v3ZH+Dhe98EZge+oTcf0BY4y+jPlzEitSYO86kG6Bgvnh9gdgs7iCdKmZfQBsa3i9CG4eIMjRBMltCj3Tk24xBOgLiMT6icUynLvDUDFVyyH0ZZKz5UaNZGGqwijB8J4gb1MVPtg14MIQackJM25Z6bv9WrG8hXwy4gnWrLDOJu8BCzu4UB4DkiRmbcOGW6zu+baNSfPY49IBQYDl6yfDgDBeSzTIpx6/vdS7QeZkmJ4GKne4shwvgzbzwac0ZRGMvV3uVX4TvgzvXepMYKIscRSWn+oUlU0R5nNbi8Qz81jYeb391Z1Nz32RPkxojSqW/FhmCpyFUjJw6WHxqeV5ZNIEBsuCqFdkZqImxkRC2V2yJYZ6roIFY+DpqoM11D4RMjByZvFIJZKr+hH28N0sr6sXsSYBawXKrF2gsKivA4ibx2UL/HeaMArQNwvId12aUL3TbvJPaaLcbUN1h7dkKz63wZqnrWGVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(366004)(396003)(346002)(39860400002)(451199021)(36756003)(66556008)(44832011)(7416002)(8936002)(5660300002)(6666004)(2616005)(478600001)(8676002)(66476007)(6506007)(4326008)(86362001)(316002)(26005)(66946007)(31686004)(31696002)(54906003)(53546011)(38100700002)(6486002)(83380400001)(82960400001)(41300700001)(186003)(6512007)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXBSMlJ4RTgrTHVxdjFkR1BvMHFEMUZBcm9ZbnNHSzlvOUs3bGpCelpiMGRI?=
 =?utf-8?B?MkRubGo1cTR2OE9ISXJtMTV4bzgzY2pOaDJMeHhXVFpZR2o2eHlFdXM3OWU0?=
 =?utf-8?B?eUJzNFJoaTZFakhYVWdJYkhCZk12Q2NQS3d0RTNYNFNlRHRkQTZYREN1dlhR?=
 =?utf-8?B?MWVJZlRka3l1UVJmTHZDZlVlZXpyK3JuWUxpaEtORDVXZjhpeWovcXllcUU2?=
 =?utf-8?B?dlg0WWI5UmdCWTB6ekJtenJkbUxUOGhmVmlFT2N1cFRjdTFBc2FNK0Z3aS9k?=
 =?utf-8?B?bnRpeWp4eFN5WkRDNEkrcjU4R3IrNzlJRmJWcnZhUGVyZmtTenB6aXNPR2pz?=
 =?utf-8?B?TnZjVFlTb1lHY0VRZzIwd3M4MytNQ0lRMG1iR3d5bEhzQ09KM2RXOGtxUmhH?=
 =?utf-8?B?NGZoaFBFazFqUHF0WExJWlB0S0ppVndPS3ZTTDF2NTJXZ1JuRFliNWRYcGFy?=
 =?utf-8?B?UitkelJodGFIK2dGLytWSkxkRExEYVhITzhvVW8xaW5XRnkvNHYzTnNianly?=
 =?utf-8?B?T3ZtYXY3dEt1cTl6L2MwVHN2OWlndG1VRjE4MExQRW1yRGlVNzVqUGhmb0l4?=
 =?utf-8?B?V2F1b1QzdTNPOWI2SzRKMVpoMFRaVmk3NWV2Vko0cEVsWW5OODJUVEYxVTYr?=
 =?utf-8?B?L2NXclo4Sjhiakt4MVl4eG02dDl0bXRMc3dhNkV4YVhWMHVUa2dzMURscUlG?=
 =?utf-8?B?Und6OUR2Z04yREVHcEJYUWkvSTlkbUVVeW93Nnczb1RLMkJlQzlMQkJtVGo5?=
 =?utf-8?B?TzdJdWhqaG94aUNhY0pjTkt3UDJYanVsUmRQMDhXRG15MXBKNHI5dXpwQ0pC?=
 =?utf-8?B?d3NWcVYxQ0UzZnBabkNGdDVlem9QOS9zRmhaSXVQNytvUFpPcU96Q2lvZHJn?=
 =?utf-8?B?VnhCeUV0TkhpVVppMnRpYnQ4TWpmWkMydUhMK1lWclZmNEhiVmgzODg4c04r?=
 =?utf-8?B?enhUL05Wdk9pUmIvdUh3NE4zTXpVN0xpTHpFYjZGY1o5a2FobGxiSGUwWW5W?=
 =?utf-8?B?clFZN0pLVEROZ3NENHJmNTZvZXlDbUZyeHZreGdnbzZZQXdkZVMyeisxOFho?=
 =?utf-8?B?Wit6ck01WlN3RlpTZnVlV2FPYlc0TkVrUHpRdUpwYnRpTE5NZ0x6VkZjRkRs?=
 =?utf-8?B?ZkRHbEtNL3hZc1ZpNllzMGF2SVdwbGdaVlJxVGJYa3EzVVh4c3VaYzQvVzJw?=
 =?utf-8?B?MGgxREJQbTFSYjFJUXIzUXhpQW9mKzYzM0NwaERGQ2QxTEJIMkFyRWtLdFF2?=
 =?utf-8?B?T3FybUdweE56d2tqc2x3VUJnVFV0TTBrdStBUGwweGFpN0MyNWdyMWNybFBO?=
 =?utf-8?B?bDdLQ1c3VU90RExTOURXRCsyZlJwVFA1T0cvdWVRWE82bGQxc3ZMeUwrVVpX?=
 =?utf-8?B?SGo4dG5vdHMvVXgxMHpCWjRkOE10bnl6KzVrVlZFNUFzenYrOHNFTGZXMjdr?=
 =?utf-8?B?M3ZzemhES3VLQkZwenZMRGN6bXc4b3Q3YlR3NjlDS3hVWG5XTmdtaTQybGtz?=
 =?utf-8?B?dWNtR1Fkcko2Y2gxaTZodUZRWFZzWWxBenc2cXoyUEY5bnpLU1ZuYnpsOTdL?=
 =?utf-8?B?Wkh0NEU2YXA1UmhGM285THluZHJjUU1XTDZXZzJ2ck5IRHlyMU5XZ0plTnpv?=
 =?utf-8?B?bnNOdjl6TkppVUNObGoraGJBWmVCR1pkUTJkaHhNOXZwZ1cvbldQUkZXOS9L?=
 =?utf-8?B?cmVEaDh3SHNvS1J0VVE3QUZ5dlN0UXdPb3RFUDhHWTRoYm1Pdno4UkZreDJF?=
 =?utf-8?B?MHhqN255OEhKQTFrSGxlRERoLzRGenZKTElRYisyNnUwRk9JUGNxa0E0am5a?=
 =?utf-8?B?dXlYUHRYR2EwMzhJV29BMG95R3NYaGNHK1JXNWQ0bWFSa2ZVdUt3eHl1Y3Fx?=
 =?utf-8?B?NExCYnp3MlFjVlZhM1hoeXJuSWJXS2h4cWZveGJrMWozcmpjbngraWM0RHV4?=
 =?utf-8?B?eDFNMlRoUmxJbXFnY21iNWxhSjdLWmtRalNDZXNyUS85VTVVN2xTc0RvQ05x?=
 =?utf-8?B?aERwVGVQNnI1UWprT3JqVGl6d0pCR3hvWnZid053aExFeVcwSXJYMTVnaWhs?=
 =?utf-8?B?Zy9qSlA0eU9DN2IvOUt4cFZ2RkFVSVRGU0tsSWVHVDhXK2tKeTNhd09EeUt5?=
 =?utf-8?B?SGxEMzZIcjZQYUVTTTE4dW1sQ0VtOFhsZllkMkoyeXp4YzNKNXc1S3JDUDBG?=
 =?utf-8?B?YWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c781b1b3-eea6-496f-bd0b-08db323f273e
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 23:25:02.9821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yP4yeiQUjWtcL241z/h00wgFbtYZ1zud9gGz8dk1bcigL2DeDvlW97eluRFPzAqmQCQtIvJMyqpUmDe7BYeRl74X77lf4W4DK6pQyzzyM4c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6426
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 3/20/2023 10:26 AM, James Morse wrote:
> The limbo and overflow code picks a CPU to use from the domain's list
> of online CPUs. Work is then scheduled on these CPUs to maintain
> the limbo list and any counters that may overflow.
> 
> cpumask_any() may pick a CPU that is marked nohz_full, which will
> either penalise the work that CPU was dedicated to, or delay the

penalise -> penalize

> processing of limbo list or counters that may overflow. Perhaps
> indefinitely. Delaying the overflow handling will skew the bandwidth
> values calculated by mba_sc, which expects to be called once a second.
> 
> Add cpumask_any_housekeeping() as a replacement for cpumask_any()
> that prefers housekeeping CPUs. This helper will still return
> a nohz_full CPU if that is the only option. The CPU to use is
> re-evaluated each time the limbo/overflow work runs. This ensures
> the work will move off a nohz_full CPU once a houskeeping CPU is
> available.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/x86/kernel/cpu/resctrl/internal.h | 23 +++++++++++++++++++++++
>  arch/x86/kernel/cpu/resctrl/monitor.c  | 17 ++++++++++++-----
>  include/linux/tick.h                   |  3 ++-
>  3 files changed, 37 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 87545e4beb70..0b5fd5a0cda2 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -7,6 +7,7 @@
>  #include <linux/kernfs.h>
>  #include <linux/fs_context.h>
>  #include <linux/jump_label.h>
> +#include <linux/tick.h>
>  #include <asm/resctrl.h>
>  
>  #define L3_QOS_CDP_ENABLE		0x01ULL
> @@ -55,6 +56,28 @@
>  /* Max event bits supported */
>  #define MAX_EVT_CONFIG_BITS		GENMASK(6, 0)
>  
> +/**
> + * cpumask_any_housekeeping() - Chose any cpu in @mask, preferring those that
> + *			        aren't marked nohz_full

"Chose any cpu" -> "Choose any CPU"

> + * @mask:	The mask to pick a CPU from.
> + *
> + * Returns a CPU in @mask. If there are houskeeping CPUs that don't use
> + * nohz_full, these are preferred.
> + */
> +static inline unsigned int cpumask_any_housekeeping(const struct cpumask *mask)
> +{
> +	int cpu, hk_cpu;
> +
> +	cpu = cpumask_any(mask);
> +	if (tick_nohz_full_cpu(cpu)) {
> +		hk_cpu = cpumask_nth_andnot(0, mask, tick_nohz_full_mask);
> +		if (hk_cpu < nr_cpu_ids)
> +			cpu = hk_cpu;
> +	}
> +

I think as a start this could perhaps be a #if defined(CONFIG_NO_HZ_FULL). There
appears to be a precedent for this in kernel/rcu/tree_nocb.h.

Apart from the issue that Ilpo pointed out I would prefer that any changes outside
resctrl are submitted separately to that subsystem.

...

> @@ -801,6 +803,11 @@ void mbm_handle_overflow(struct work_struct *work)
>  			update_mba_bw(prgrp, d);
>  	}
>  
> +	/*
> +	 * Re-check for housekeeping CPUs. This allows the overflow handler to
> +	 * move off a nohz_full CPU quickly.
> +	 */
> +	cpu = cpumask_any_housekeeping(&d->cpu_mask);
>  	schedule_delayed_work_on(cpu, &d->mbm_over, delay);
>  
>  out_unlock:

From what I can tell the nohz_full CPUs are set during boot and do not change.


> @@ -814,7 +821,7 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
>  
>  	if (!static_branch_likely(&rdt_mon_enable_key))
>  		return;
> -	cpu = cpumask_any(&dom->cpu_mask);
> +	cpu = cpumask_any_housekeeping(&dom->cpu_mask);
>  	dom->mbm_work_cpu = cpu;
>  	schedule_delayed_work_on(cpu, &dom->mbm_over, delay);
>  }
> diff --git a/include/linux/tick.h b/include/linux/tick.h
> index bfd571f18cfd..ae2e9019fc18 100644
> --- a/include/linux/tick.h
> +++ b/include/linux/tick.h
> @@ -174,9 +174,10 @@ static inline u64 get_cpu_iowait_time_us(int cpu, u64 *unused) { return -1; }
>  static inline void tick_nohz_idle_stop_tick_protected(void) { }
>  #endif /* !CONFIG_NO_HZ_COMMON */
>  
> +extern cpumask_var_t tick_nohz_full_mask;
> +
>  #ifdef CONFIG_NO_HZ_FULL
>  extern bool tick_nohz_full_running;
> -extern cpumask_var_t tick_nohz_full_mask;
>  
>  static inline bool tick_nohz_full_enabled(void)
>  {

In addition to what Ilpo pointed out, be careful here.
cpumask_var_t is a pointer (or array) and needs to be
allocated before use. Moving its declaration but not the
allocation code seems risky.

Reinette

