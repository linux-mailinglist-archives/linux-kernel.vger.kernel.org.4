Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83BB36C5935
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 23:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjCVWCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 18:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjCVWCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 18:02:13 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694F0EC4B;
        Wed, 22 Mar 2023 15:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679522532; x=1711058532;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ftqIv0RDfg6TU0AzlZVexwtrghHIoi7mt6KiaO/sZUM=;
  b=heBCGQGy1TG3Ej04Hek/NMNXBWbbJdi5V37yx0il0JgPWyJ7b6XMVEtP
   XUqlnZWX2rFHhCH5w82Hbxr1FzK6X3MljF253AbJh0e4DEhUwMEVBad/n
   sO0jtmPNRHEyYA07D10hJWrBfWfOZwIvrH1hmBJC5u3IH3YOpNJKD+jTc
   w7FYKRhN4uboZ1jIya16fExlov0T8lHuhk/foTyZLRo96itEglIdmJrGW
   +trxg1qMDxJZgGGghy7vH3Pzd32wVR+WuL/PArs8XKyNydZWUwRltZNAh
   osR4Yrj3yK8xJCeJb11XYtBG7wMYwwQ27HOx14pRe3xk9dpvEe2azXCz+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="425629771"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="425629771"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 15:02:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="632130512"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="632130512"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 22 Mar 2023 15:02:11 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 22 Mar 2023 15:02:11 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 22 Mar 2023 15:02:11 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 22 Mar 2023 15:02:11 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 22 Mar 2023 15:02:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NvdH3kps1h4AVz4U7697sGRJXuqWR9ZmJLpDYUC58k5v43mDsSWrHdGyJ/qkdJMbkWThEQyra8EjDN3NFnv6l6MRmTmbFMBUhll8/ADDWlEPCi+XcIIEMsMvvnFwLPxRTZsXfovkSWn3xqiEwnO3e89wgqwEXVg6Ny/ti6k46F2fY1HLxnyjg3skihgyr7RJV7LZL/9/89SPheA4HpMWInWhHWTlrn/l3pS5KvMxNuSU4BaLrG6EPx7ZXMbE0F5Z6HOtF0GJlZ3+OoOMsCOwWaGOJlP3LaQsPHmwO8OVgpkHbvAKGV6qwOTK3FcpL+1sRhhSuVPo1yu3A63mEk6x3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1n8rUt757BiQMD+IqFQBtKRX32T7hX0/AGh9/kNd2TM=;
 b=KIjOoarKRUOrHcaXCTq7v8JX6tjR+MXn0oCWJoAwCqTpScsQ9jvGSY9FhGB5aeI/IKfPVXwtQzyPMXUx0WRcdhQ310EUtYg4sTy/euJ7FqCOG0QGa84OhhZqknVLqFmgdYowsDhaUc+2IZR0FDNqs5wT5iafc5aaaP24ysneneiWeZddbk+enYfxZtGJjxV45WtCTzTtSE0/nkLJMvnyEZI6hX7KuHc8L3IcZ9td2VjuCzyFxVmMXuRjMddOzNXNmo2mXe8apbuBQFcb8RNFqYbBBLfGLHp2pzA1dIyuQylz3JT23I0AaU1a+Wx09ZXPNtXn4RtsXWYeGECOzaulYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by IA0PR11MB7281.namprd11.prod.outlook.com (2603:10b6:208:43b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 22:02:08 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::e002:4146:dfae:ba77]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::e002:4146:dfae:ba77%3]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 22:02:06 +0000
Message-ID: <ffeee8d3-3b92-fe21-1b5e-1c17444a6a8b@intel.com>
Date:   Wed, 22 Mar 2023 15:02:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [tip: x86/fpu] x86/arch_prctl: Add AMX feature numbers as ABI
 constants
To:     <linux-kernel@vger.kernel.org>,
        <linux-tip-commits@vger.kernel.org>,
        "Dave Hansen" <dave.hansen@linux.intel.com>
CC:     Tony Luck <tony.luck@intel.com>, <x86@kernel.org>
References: <167951609395.5837.17233221474519558802.tip-bot2@tip-bot2>
Content-Language: en-US
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <167951609395.5837.17233221474519558802.tip-bot2@tip-bot2>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0029.namprd10.prod.outlook.com
 (2603:10b6:a03:255::34) To PH0PR11MB4855.namprd11.prod.outlook.com
 (2603:10b6:510:41::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4855:EE_|IA0PR11MB7281:EE_
X-MS-Office365-Filtering-Correlation-Id: 69cbf691-d0b8-4aff-3f44-08db2b21139c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KicYQ7M97E0XzGKVBVhdDQsHhZOTWjawudGgu37DhWZFKZAawqXxTAJxsojZbBH0Jep1VKE+biPy9DRYLZYdWp9vmoYrSkWf+/MMN2VYUiWQMrPZamlBhKOUEBjJUVCuk69KGwNYAt5oeN7lRClbblgmd9Pi3AMO4p1GhOeyob2Um3SQpZU9hTvtUmwmGEBW1fZUY6aiKXl4NvKvLG/Or/aS/NUME+6yYdz1HC2Vylvkr+XEKOJWc4oCZyqqZiww0LasCSLiI1iOarD3Czt9/SfV6ZjPFvLcAQfOaH47Ix/rNMJB9gYds14KjbjTWQMsXOMmNoQSQq2Y176ABT/QvGM0OyixQB6lXT6k37EotyerAH2F2hKEVrs2rdpfbdMnLe9mYIqioa9MlVrpbQMg3KajqrXqeyoUPxfdKSpHM4BmWMgDQK5qIbe42m+IGbbREM/usrJY4CjxMtvSoDAjAsOBtAk7MYNEuOruTTU1sKh0xG1Yev98nHAT28WqBSmJlRIVzTQ3ybJNmwEMfgvLVE7kJ+ffa3RWaMlwk2W7Wz8SLg0MzUQn7OGuRXshOrZ7V3sij3MZUnQKQK2LZpnvpa+lYVmPplgv9MUTVVhiCv/02pyVYsEQ3/qiBXUPAuzkTizOU3KIFUkAAmg9DkO5I9fNSS/Fa5YoDSBhJ+ssEQRhxeVnEoxmK4qfxZlGG3LU7QmOO743kiRP9uT+N1arqxXJ/t+IDMdwONkiAoOBAAo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(376002)(346002)(366004)(136003)(451199018)(31686004)(2616005)(83380400001)(6512007)(6506007)(5660300002)(6916009)(186003)(53546011)(316002)(478600001)(26005)(6486002)(86362001)(31696002)(4326008)(38100700002)(8936002)(8676002)(2906002)(66476007)(66946007)(82960400001)(36756003)(66556008)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFVNdU9LaWo0L2NrTk83TFZDemxaRU0wSng2THdoWEhQYmdkR1ZxZ3p5R2RU?=
 =?utf-8?B?RlJYUHEwSVM2cGhaNEZPRlVNUTR2bFdnQXpGdEtEWFBML2dFSlFjTUxBVHVK?=
 =?utf-8?B?S2VxT2RLY1lsUTRzekI2akwwTVRKMFp5QjV3c3ljeDFtbEluTytiQ0hyUWlK?=
 =?utf-8?B?QlBXU2tuc0ZYRUhBV2tQZkQ2cXU0L0EvYnk1MjJ1RE5MOGd0QXE2MmNqWTVX?=
 =?utf-8?B?TUlyU1owSnBGc0tXaXFsdHNnOWRxbUJjakgwYS9EeHlqeVIxMnlPUHV2aW52?=
 =?utf-8?B?WWJmOEJ2cU9GUnlkdlRDaHdONDFJa1BkRU5JbHNXQ2ZIazNYWFFIaVhzZkI0?=
 =?utf-8?B?VFFlVVpOUHZEUU50cUJpdDVYZXlVZWpPbmxSdkpyZ3dxUGJSTHpDVmlUSGdE?=
 =?utf-8?B?eHFZOHdxb1BWRENmWnVrTWErcXA5T3hWNGNvUWVIV08ySksreVJLVnhnYzI3?=
 =?utf-8?B?dVlDR0hGOUpmVi9NTU00cVYrZEFWNTNyWHpBY1lHbkFFQ09FT09pejVZVDdp?=
 =?utf-8?B?TnJOSnRidW1iakxMVHllbjh5RGRqNWpYK3l5SHJNeWJNc01DdnpGRTRGNy9C?=
 =?utf-8?B?eXJ1N3VFaGU0dm1yZkliM0V3ZS9NN3NOLzBEeVU3RStIejZXd1dhdHRQRjlH?=
 =?utf-8?B?K05za3lTVWxHanhaV2RUZy9FNTVabUw3QU00cXFra2hOeUQ2VmZPaVZFbzJP?=
 =?utf-8?B?U2ZPcGNPWkplaVdEcUVIc1lYU3BaYUYyZW9EOGs0TU5mbkZpUDNJZUtKajN5?=
 =?utf-8?B?OWdUK1IyYUh3a1JnQ3kva2tEMlZhYkIyODF5dTkweXhpNzF1UXFTYTVrZFB5?=
 =?utf-8?B?Z0g4N0JyZFlkaVIvU3JEZ3cvMVV3ZzJsVWNqZGRkelM2ZzN1cTlGZG1uQUpJ?=
 =?utf-8?B?L1lBaFpwRW9CY0pvalpTMzJldnBBdHE4SWgrUnpiYmpKSS8zYlorK3J1T0hT?=
 =?utf-8?B?MExJMm9oWklERzQxOHFiaVFSK3Uwd2hDUmo4MWFSUXQxc1ZRanZySUxNeDRC?=
 =?utf-8?B?OVM2YzkwUkw2MitZVHpvUmZjSDhPbTFHNkhwWTQyQVpuTlc0bWVNcjEwa0Q2?=
 =?utf-8?B?RnB1MzFHNCtUaHdUUHFOOExLd0ZMWUNqZXNFcHJGWkpmNE1zMzdOTk1RMndJ?=
 =?utf-8?B?V0QwbDBpcjA5STlZTDFwanZjeUo0RnhYWkcyZ1BVMWFDNDJLV2tUbW1HekdF?=
 =?utf-8?B?emV5L1FSZjdRYWc5Qk1nMDI1YlZKUENhQkhXMEZRb2dPMkF4Rmtld3I4RnVj?=
 =?utf-8?B?VGJmMnI1dlFWWGlpNG5nMXp6RTVmSm5DT3g4RGNHYUkrTGRxeUYwRytNYU1r?=
 =?utf-8?B?YWZORlUxUlhya25tRU1MRFFXUjVJWnI5SmNWN3RoZGZHeWdRc0pERDR4N3F5?=
 =?utf-8?B?bXZLL09KWkU3Q2piczA3anBvamJpayt0MlFOVi9LcXJzL1FMZmRmTHRDRitN?=
 =?utf-8?B?ZkNmaWhYQ1QxMzFJSlE3aDdMZ0oyc1BKUXJjMm1zVGhKeVl2UUtLckI3bEov?=
 =?utf-8?B?SU1ERy91YW5IeTVKMThNUUhiS0NyMjVDSzZaQmgxVGoxU3FkN29oU1NWSDNv?=
 =?utf-8?B?dDlLSk1VTmVPcmJPQzB0ZlVuMVNLVC9EeWFiTThyTmlHQzBEK2lWMlFIRXlJ?=
 =?utf-8?B?N05leld4aTdvQTQrbm1RMy8rbDFKTm5oOXZxNWJ3MzlZVGh3L0txN2hWSm9r?=
 =?utf-8?B?cnIvbFZNN01aVDltWVRPTUVNSTFZMldnUGlPOTU2S2JkdkMzN3kyYURNemFL?=
 =?utf-8?B?U1ZxVHJhM2JtRkVrd3VvWGpPT1QybGdPalNTR2llaGVtb1VScENpc1Z0bGJP?=
 =?utf-8?B?TDhrZnNYT3pTUTYwUU5jbjNSUEp1RGxOUnFKQVBFT21hTCswTEJlMDdjMUJk?=
 =?utf-8?B?bm9FSWYrdnRWU3lWOXpobFNQbWxpM0t3SkxxbUFCNHRXUFlEVFNPT2lqdDIv?=
 =?utf-8?B?U0YxdENCS0F3YW1EM0dmS1R6YTVXMnAyZGN5ZHVmd0JiNGp4R0tiVmdVZmRP?=
 =?utf-8?B?Uno5aVBrMU1PY2V2NGNjNzM0OEtUaWV5bXF5MFhXV1VIVXZYNm51Z1hxN3Zk?=
 =?utf-8?B?WmRqWXVROFY1UksyVTFDRFR2TmRrdkdoK1BhMnh5dUUrb0k1WEtDVWxjZVJw?=
 =?utf-8?B?S1RCNUphLzNJVU1wSmRRSlhBeVpFNDR2STN1NHhQWGp5NEdmeGFWZGhEb0k2?=
 =?utf-8?B?REE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 69cbf691-d0b8-4aff-3f44-08db2b21139c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 22:02:06.7853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lbh1qQvaIBWmA4IGGYYdYFaRk9hNinnO7O9z5011U1Sn70A7GzzONMtGW/xX8vT+Bgrg0DwC6OS8C5QcPbFBpkzRhRvOS/LEU+Be6Ye4GkQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7281
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/2023 1:14 PM, tip-bot2 for Chang S. Bae wrote:
> The following commit has been merged into the x86/fpu branch of tip:
> 
> x86/arch_prctl: Add AMX feature numbers as ABI constants
> 
> Each distinct XSAVE feature has a number assigned to it.  Among other
> things, the number determines the ordering of features in the XSAVE
> buffer and is also used to generate XSAVE bitmasks like the value
> for XCR0.
> 
> AMX state is dynamically enabled by the architecture-specific prctl().
> This prctl() takes one XSAVE feature number as an argument.  However, the
> feature numbers are not defined in any readily available userspace headers.
> The means that each userspace app trying to use dynamic feature prctl()s
> will likely end up defining their own constants for each feature.
> 
> Since these feature numbers are a part of the uabi, expose them in the
> prctl() uabi header.  Save everyone the trouble of looking them up and
> defining their own.
> 
> [ dhansen: expand changelog a bit ]

Sorry, it looks like I was not diligent enough to explain what those 
numbers are and that they are now part of the ABI.

Thank you for the write-up.

Chang
