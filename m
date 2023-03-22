Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D231B6C5400
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 19:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjCVSqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 14:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjCVSq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 14:46:29 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAEF43473;
        Wed, 22 Mar 2023 11:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679510783; x=1711046783;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9GrhwlWjsr2X5BTQdvriyVvdyFhm5iA+5+4TqoHvoWo=;
  b=GjuAsje7CXr/1R8hdOEvnizwVmQBkvHdS68lElRiiILfQvDT8r1ByylA
   RU8x/xXUvFAmGEt+3Uwl2lQKTfdjQqZsCutUhRcTjTPGXtUbWyCuPRbQX
   m2tbrj7A1L/u8DIrH19NSWlfthJCaorjvU3o0QERSxrZO8eMXXUOZBN1M
   k2pyc7aaSzLL17bT6dTuO5vSSQqPWr7jcRZ2EC1q6HEgmvY79M+trEevz
   L1/PoxnOLGgleZEOzGcgzUXqTDcs4dwI48NOfDNySVc4Dn7nqvYp1wbSJ
   IaxVim3SukbtAo69HWPI+sjmGfEYEe3M1zzXDYj6Hss1uTyyrUN0UIEp+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="318957644"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="318957644"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 11:46:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="675397823"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="675397823"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 22 Mar 2023 11:46:19 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 22 Mar 2023 11:46:19 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 22 Mar 2023 11:46:19 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 22 Mar 2023 11:46:19 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 22 Mar 2023 11:46:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ga8hKNrUOvo4+CwZ30JSl5w9YnQies6NfY9HnuxZou5ltMa0ioRR1fzsk3+8I0youD5RbYm3XCYZ4fBvV+gOC5o4eEv8B9tNGEEmvSzlgZCFibyqYsdMwtLTSXvNfguPK91xHRd25QmUfu+SLyuQoucQPqZ/avOJjvra7lQbXAGDHEviu6mfjjCdLW+3dDzwuKQEvGBnK3VnuxBZnvGWDC/sr4V+71fQLOrDuu5+u3gp+eBXmr6GhxEVZ9HSLkPH5Iho2NoEmog185y7tcpMVFYXducsIDK5g0v76xvq/2Z6wLd54YMhzOgGYxc9V+IcAHQNL0xDZKWO5DgVpLiZFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xOgt77dJjJ/Xx9oSJZTGd7vQexlywDxMqBN9/FlMiaU=;
 b=QQDEt6t4FIu9Ru2BZ3ARx8YjNuVh95IhOUs5b+TdmZB7Am/1V5OeOAHoWwtzNRNbT/fFJmQtoX4ezBPrBRgiiJY4p53iCM5aAGHeJyHCQpjCdXqiL7t57Yo+ir1OyfwiFqbGuNHagrU6jmFqmsaqFgU7LoO+n+OWbT2SLRyUm5FtjHWaTU4/2JwLAkeLectoZxULpmuRiKDwJ1jU/fQy+GjybwICHu0jq2gDWWZc4Jg7L/hegdhI3MErRyAdZaneVpbUKlPy6L2FHhNn/0R34tLcn+xq6w0fVDKzjC56EfXHN2nS50qhiejJLgcjQsDyQyhgPDv8iHhu9+i7srFqmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by IA0PR11MB7912.namprd11.prod.outlook.com (2603:10b6:208:3dd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Wed, 22 Mar
 2023 18:46:13 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6178.037; Wed, 22 Mar
 2023 18:46:13 +0000
Message-ID: <b30803f3-e681-d11c-ad84-ce9677765609@intel.com>
Date:   Wed, 22 Mar 2023 11:46:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH v3 4/7] x86/resctrl: Re-arrange RFTYPE flags based on
 hierarchy
Content-Language: en-US
To:     <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>
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
References: <167778850105.1053859.14596357862185564029.stgit@bmoger-ubuntu>
 <167778868692.1053859.13490646651097380957.stgit@bmoger-ubuntu>
 <26400c6a-dcde-9ac2-df7a-117a12875f0c@intel.com>
 <c083cfb4-3282-2aeb-c704-9cc21ada918e@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <c083cfb4-3282-2aeb-c704-9cc21ada918e@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0140.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::25) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|IA0PR11MB7912:EE_
X-MS-Office365-Filtering-Correlation-Id: caf493c8-4775-4407-671f-08db2b05b5b8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HvBUt+VghPDj4/i7AVQUnKqz/q+QjzDBzfyTpczDRYwhdXZ0V/6nod1hVOJ9K28vV9rrewDORl0DgHzD9AlUi76HYNdGKCc3rFPWaQSvYq+2L9B/KMMECcQ7AQ9lTJ8G0qSZuNILAm/MVDYbjjT2xIExopF/Pikd3trttgzIttdquUbX8OnIF8z1mRyfuxEW1Dnw+9pA125Fe4ge/Vu2Foj4Io/T9LA4FcZlGRWsKhM0n55LF5B+GfVSvQ8tQHr2OYUAnC7Km6YA6i+65zil5Ch5e2jK+MyEFrNg4Zmm685GIpVgQu9H61WWKqok+754EN2xOszd/IOBUtf7edxAQVTUqY+73kBdrM/lfYTTzEe0013wFMvNo/ere1sodRI9JT73t+Ip50lqMHVMFfVeICw8nA16y/xUg6u6vPBq56TiFC0ccJZ9nQdNkcmyk4PiJjSDMP7qd2TS5WAl+Ij/Hz7fXIhXb+9RWfl+6sUhVQLXQnSBbyeDMO25nA1yvL2xl9w424IE50ew7atdclxheTr8opqA4JDkHuIHepaMSnfc8F/UKLOBfU8nUNhkrsxo892KfAppuC8nyjKkbLtG9x+foRkrH4cTeLLhcfiMVCcTgVlHv1VTrAdULeTeyDm1ldmiiyyjtK0kjyiGIuMz2NdJcfVcVIggLaJ8QVBlQJh+/T+k3cHEsl/a/z//MRwKeEVdaMmpfrudMtFO8LCAiQxrlF5eDsV5W7EBRn/l30Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(136003)(346002)(396003)(376002)(451199018)(478600001)(2616005)(36756003)(41300700001)(5660300002)(7416002)(83380400001)(44832011)(6666004)(6506007)(186003)(26005)(6512007)(7406005)(53546011)(2906002)(86362001)(31686004)(316002)(31696002)(38100700002)(6486002)(4326008)(8936002)(82960400001)(8676002)(66556008)(66946007)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TCthbXNzTldjVGU0U1Z1NDFkczFBeU16bnBDUzlCaGw0YklER3N3SktkMGpV?=
 =?utf-8?B?ZllwMUIrV2FvL2UzUjkvVGNCalBUTXFYUXhWc0J6ajhLNmJHRWNHOFltMGZz?=
 =?utf-8?B?Z0VqSmdlSVFXalJMNUl5bHNiQUNjbjN3UWFaUlE4WU92bnQwcjFCbS9qWlBU?=
 =?utf-8?B?WE4zRitsNVl2YnRjeExKZmhnaGszRVZrQ2dIT1dsamN1Qld3WHRBR0RMYkVI?=
 =?utf-8?B?c1I4ZGtSNEg3cmhGNjh4SkQ1U0dMWjZ2SjhWaXFTR3dCeFBhdEF4THg5MzZU?=
 =?utf-8?B?SlZlQlNqMGZUb05GRk11cFN5dksrc01Qd3ozT1JhcS9pQVYvMWJ4TmZRbStC?=
 =?utf-8?B?WkxyNGVBdWM0b08xeU1WNVg5Vm1LcCt1NW5xQVpHOFhyOGFUTks3TTNnaURj?=
 =?utf-8?B?ZmMvVTk1TmY2VkhKUkxTUlBLRXFtTVdqYzJReS9TbE04VURnTXltR2lVMk90?=
 =?utf-8?B?M2VWdnNrc0I4NTVEUUo5TWxTSXM3eUlDSWhXc0dtcFZsSGpUaE51bC9mZEwr?=
 =?utf-8?B?RnhQTysrZ1hWb0pIc2NzdkhrM2VQR0dsZFpzc21GYUNablFpUUVRbHVLUGl1?=
 =?utf-8?B?cTlGL3A4VmN4L3FmUFhBTDlkWDJCZkVUTjZ2K0k5c0ZTeTlRRURwQU1WSy9r?=
 =?utf-8?B?cElQM3ZROFRSN3BZc0lDSlhPZ3NFK215eTdGdDVsN2ZiNy9jZlJWZlg5d3Yw?=
 =?utf-8?B?c2pkeGhYenVpNTg2UC9xZ2drS245aUZpaCtPVlRJa01JSnJVdnhMelFwQ0FQ?=
 =?utf-8?B?ZENlZ3c4WHorOXZGTTVuV0tNQm5xdHdaQkEwdVpaaVVWVk1MaE5IZHFFT3Rs?=
 =?utf-8?B?dnVaa1pza2ppRmNZN3JhTlVnd0NPY0NoYVlaSHZ5Znk2RVZlUlZIVnlsa3RB?=
 =?utf-8?B?YWtjMXRPbEovZi9NKzQyeVhRdXJCc3B4MVZqWEIzb0JnUWpPenJTWW5UQ2dR?=
 =?utf-8?B?N2t2MUFzMU1WN1dESGJPWENLc1gwY3VJNnRnNTVlYzNxb0NCbEFOYmd1Mkls?=
 =?utf-8?B?Y0JWQzVCRmJhd1JTRFNRVzZYTzl4MVV6bkVZS0dlZEw5SVNiK2tJdVltMDVo?=
 =?utf-8?B?Rlh0Y2dIZUp5RXF1N09NZ0hLYTdhQzh0QVdpdk9DSjJCOXNVS2VKOFdtbXdP?=
 =?utf-8?B?dCtqbldEN2VqYmh4WlJBMnIveHVZRStnYWJPWWw3MnYxSTdiYitWcUhBcENs?=
 =?utf-8?B?d0dyU0lNSG56OUZuNVR6cURwZlZ3MTMrQmFzK2ZYby96YzB1eXZqQ3FkSGp5?=
 =?utf-8?B?Z3gwbXMyTnkwcVZpdFF4aVB2Y1pMZkE5UUwwaTVWa29HZk9veGxEeWpGekEw?=
 =?utf-8?B?dW1JaSs0UmpiL2hjQmlWVFZrZXNUclQ5THNSN3grNGNNeXJaRS9kRHBmOVgx?=
 =?utf-8?B?T0FYTmZJemxUaEVpVWZkR3EyUHZkc2NjNTRVYW5HcnBJQzVXSXNIQkFRckpl?=
 =?utf-8?B?VUVqQUhleDJ1SzNWa1gwTmdNVVdyQWJOTFZYTkFXT2NuRzRESkhNU1lEU1dq?=
 =?utf-8?B?WXR2enQxMFgvVmNHMzA2a1ZxbTV3NE1VVmZiNE4xTXdZODZUdGtKOUFYaWR4?=
 =?utf-8?B?T0tmWmMwblYrRHcvL0pVM2NjZituVWNYNXNFdmhGWHZUUUtlMm5EamIzTWli?=
 =?utf-8?B?NzNZOGtMWUNoVE9EaS9PeWhrVC9URUlxVm5adUpmUjlEcFNSRlNhWWt2a2Iy?=
 =?utf-8?B?TGI4eXZidVh3T3FIMEtxdmZnOVZLZHlGZTljY0VNeUtSalk3eURUKzc2bEho?=
 =?utf-8?B?QU41WmQycVVhK2xRVXhIeTViRC9wczB5ZEhSRWFITjgvMFZwMGhtYUtuaDU3?=
 =?utf-8?B?bDJzdittVSs4NitDQjNQY0RSaWF5U0Jla1p4QzNSUmhkbUpManE4S0hrbDdV?=
 =?utf-8?B?cDZRalBGUnF2anEza0p3eXdiQjV2UzBlbjJyQkZ2ek4vMzlBeHRJTGRaNDRk?=
 =?utf-8?B?SVg2TnpYUGgxMklZNE9ZOTh1dmR2YWJCU1pjRUpQUm9IWHdod3IxWWx6a25m?=
 =?utf-8?B?V3pBVjZSUEdGa3FTRE1LQWNuanJIcHI3aEJBVm9ScllvVHFSR05vWkF1R0tn?=
 =?utf-8?B?NnZveEJvK0I4QkRsNzV3ZGdXTHFuanJGY3pvUXdMeFR1cVdmVHluYytBOG9R?=
 =?utf-8?B?UlNFLzRuRjZuNlI0ZXlvTEROczJUVnNmRDhqWXhVZ0gxSENkeDJqN3NnaUdp?=
 =?utf-8?B?MFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: caf493c8-4775-4407-671f-08db2b05b5b8
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 18:46:12.9773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /SH0reAmdiAPqdW0NP2SN6XR/LGayvSw/vMAGGgQ9NKKAZM58TidudPmVgbIgIfGoKIRCWFoM+VYJ9bbJk0DYkjkrLuqRSPeU9fOwJpT5mw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7912
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 3/21/2023 8:54 AM, Moger, Babu wrote:
> Hi Reinette,
> To be honest, I had tough time understanding these flags. Also, I need to
> add more files in the future. So, I am trying make these these things
> clear before I do those changes.
> 
> These flags decoding is pretty confusing. Also, there are some flags which
> are duplicate. Not really required.
> 
> For example:
>   In group structure, we have control group or mon group. We just need two
> bits here. The code uses combination of 3 flags here.
> #define RFTYPE_BASE                     BIT(1)
> #define RFTYPE_CTRL                     BIT(4)
> #define RFTYPE_MON                      BIT(5)

Two bits are used to distinguish between files being for control or
monitoring groups respectively.

The third bit you list is used to indicate where the file is located. The
RFTYPE_BASE is the bit used to specify that the file is located within
a resource group, as opposed to RFTYPE_INFO that specifies that the file
is located within the info directory.


> Also, the flag RFTYPE_MON again used in creation on info directory.
> Basically, very confusing to add anything new.

The RFTYPE_MON indicates a monitoring file. Whether it is in the info
directory or as part of a monitoring group is specified using RFTYPE_INFO
or RFTYPE_BASE respectively.

A file can be specific to a monitoring or control group by setting
the RFTYPE_CTRL or RFTYPE_MON bits, but if it does not then control and
monitoring groups will have the file. For example, the "tasks" and "cpus"
files.
 
> I will try to minimize the changes in the next version but still make it
> clear.

ok

> 
> 
> On 3/15/23 13:37, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 3/2/2023 12:24 PM, Babu Moger wrote:
>>> RESCTRL filesystem has two main components:
>>> a. info (Details on resources and monitoring)
>>> b. base (Details on CONTROL and MON groups)
>>>
>>> The rftype flags can be renamed accordingly for better understanding.
>>> For example:
>>> RFTYPE_INFO     : Files with these flags go in info directory
>>
>> This is not a rename but the current name.
> 
> Agree. I am giving some example here. I may not need to change the text here.
>>
>>> RFTYPE_INFO_MON : Files with these flags go in info/L3_MON
>>
>> How does this improve the current RFTYPE_MON_INFO?
> 
> RFTYPE_INFO_MON -> info/L3_MON.
> 
> I tried to improve some readability based on hierarchy. Basically, looking
> at the flags we know exaclty where these files land.

It is not clear to me how switching around terms in the flag
accomplishes this. The meaning ends up the same.

>>> @@ -3218,7 +3218,7 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
>>>  	if (rtype == RDTCTRL_GROUP)
>>>  		fflags = RFTYPE_BASE | RFTYPE_CTRL;
>>>  	else
>>> -		fflags = RFTYPE_BASE | RFTYPE_MON;
>>> +		fflags = RFTYPE_BASE;
>>>  
>>
>> Is this intended?
> 
> Yes. We don't need this extra flag (RFTYPE_MON) here.

It is not used, but it reflects the resctrl design in support
of adding monitoring files. Future additions of files need not think
how such integration needs to happen since it has been solved and
is supported.

Reinette

