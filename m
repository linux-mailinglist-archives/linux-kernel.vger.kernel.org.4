Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9C1660B2C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 02:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjAGBDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 20:03:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjAGBDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 20:03:17 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416E67DE36
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 17:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673053397; x=1704589397;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3/ETeh+Csxg6ksODWzDifr3dDFXg8pWBkf2f2Siq1kg=;
  b=G/27r4+5TH4qhG10E2GEh4upL1HXvoicyQAgGxLmcTDg81oSmaD7AqNq
   AUoGIliMsXN+QFxgIsKXMD4tuFpPl0CnAgSvrPbZJaeI+BOqTyKBWR6lt
   vuRaxcyEk5Rdm1pY0XYGNe7Hwnp2TIFNojINeUJAAu611+k2unyvYEchP
   Kol7sAH/SIDizIwuBnOALHY3iY5QIyxJ3RJcbGSREeTkxzgdLzQ7FnI/8
   nyWkW+hyYv9VShGKPNRbRfshK9PChq4ATPQ/gQcMv89mtBLJa64nOptBG
   stVlMnrmbaWAGW5gxNC3hd4HXQ3Ug3pm2QXCexgTuPwYHjygE69z4doM5
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="306118035"
X-IronPort-AV: E=Sophos;i="5.96,307,1665471600"; 
   d="scan'208";a="306118035"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 17:03:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="656106726"
X-IronPort-AV: E=Sophos;i="5.96,307,1665471600"; 
   d="scan'208";a="656106726"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 06 Jan 2023 17:03:16 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 6 Jan 2023 17:03:16 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 6 Jan 2023 17:03:16 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 6 Jan 2023 17:03:16 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 6 Jan 2023 17:03:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dONW3oEmY7ZPLeSu/0DVFa5lZupBu/au4JfEGGswVAbPBSZtguqhIzPOh3WFcr8uT1QTBa++9FtY7LafM5JsccD5RNPvECXvSxYAi0h9obvxiCtYZFXUTSle4p6Yf0LzRmS/xuNxfGJ2BcfFD+Hx9hzb9ZhMmFdzJit6CceDl/o9tf5G4q6Q0buvhREIc5IyhXR+4O1+MDA2j8H0u88TCTLIhWNLYbVWbrGf+j937fU/RmDvVtw5S5Z/rhjc9q1nfeI3nX23eSbPtsgvA/WvDdvoDdZF741Ix2gBxuTS8M75k1irNSs2KFV3FntRVrovR884qdR9j0/aP+dSEIkzrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4uD9klx4lI5yLctB0YVQ9U/ihh8ATpAnseUYlj3/jTA=;
 b=Ks4xLCGRu38Bjd9/vgByXcYpmj+UZa9/SE3y52RkkhxtT6sVW5PG44BRK+uSD2BgOSnQSWaxThvcaNSfAQm3UWthIKQPEIiCjNqFklZWYShwYjaYDbNpY8XquxUBfVbU0chDJ4bRZydLVfbIyMPVQcDSu/QOq9qDjV9p1j1M7ocUD63mHQnghNw6YuX6geVQFjtUSNVjJTun8g5qFEKXOkxLs/vX8GpQ32cmtm5XZ4CwrFSgMgf4fghuNknHTP/YhtndP6RQbJf9YS5UM2epFRlOXq7QpopzCMGpRFbNUPIu65AMfLntv+THrlNvDvL0v55RB2KDga7Hp9HtlnVEkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by SA1PR11MB6848.namprd11.prod.outlook.com (2603:10b6:806:29c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Sat, 7 Jan
 2023 01:03:14 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::debd:fb21:3868:b916]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::debd:fb21:3868:b916%8]) with mapi id 15.20.5944.019; Sat, 7 Jan 2023
 01:03:14 +0000
Message-ID: <fc142051-c5a9-8e45-02cd-58b556d04b49@intel.com>
Date:   Fri, 6 Jan 2023 17:03:11 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 0/3] x86/fpu: Improve the init_fpstate setup code
To:     Mingwei Zhang <mizhang@google.com>
CC:     LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Jim Mattson <jmattson@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        "Venkatesh Srinivas" <venkateshs@google.com>,
        "Baker, Thomas" <thomas.baker@intel.com>,
        Neel Natu <neelnatu@google.com>
References: <CAL715W+k6HWJed8niOK4RWta+viLXBnLT6sZPmqdTi09FEep5w@mail.gmail.com>
Content-Language: en-CA
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <CAL715W+k6HWJed8niOK4RWta+viLXBnLT6sZPmqdTi09FEep5w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0049.namprd05.prod.outlook.com
 (2603:10b6:a03:74::26) To PH0PR11MB4855.namprd11.prod.outlook.com
 (2603:10b6:510:41::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4855:EE_|SA1PR11MB6848:EE_
X-MS-Office365-Filtering-Correlation-Id: a82931a2-e2ac-41a0-12af-08daf04af400
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GJCqIIuZIVI31rqhji0E2G3NyHPJh/OeAloz41w1CKxQsGTT71gxHy200YznglRvEcHuTYp6m2grUCpTUcEnN5gnDNTyKFQAfnx7T8sFNeOhbrqnP3W8v016nXELwGjJaqfPto8QMbu9Qq5GVGBbbzJr2QAebNdK2s7SkWvRelwAiiUu+EkZsdj2bi+UAH8ARoAra7WhWFXXEdHp2gR6slP2n0CsEnol4T21+r6pXeWyu5BUqgRew+y9aLM+BO/zkTDiJe4XEeuEXGy/Gwgi0NjkaYbmyEYFmWXU2v0AaTGWKvuo0f6foQlpkt4dPcybjwSJx69kTRQW41TEMiF1BnwGw8vHRRRQUi/OPFGAOjESRQNLB8GA0UNXWW2xJ4FoWFOVmqjKSI1uXJ3GHxZ77Du4j6Qqb/ptWlpBULGm6zBw3w5mUtHTwHdqi/jutSJ9AN8snkOjwnKq+616zyK0/2jEsHna0QWUCUbK8I+x17WphUr1IX2I0/hvMXn2jmhtYkLx54GNXBPvBzGpG/StcxH3elAR/crVnS7rsulVY+ayrgG1+uWSOKHkGQNfMy6kaw2GPe67PouOx0CoBKSqHfgxux12L5GQqnKTWXGk5c9Fs9atggkihdUbuBauJqCGhMHp9sQqT4vGt6X737J1um2Zo/EXosW2N/3HB2qHwsiiPqstn1sj/+GRD58X0zF1CTgtwqAcdga9UWXVK/XLk1DU0qWXEwoM1EnDE+8rOqwFsbJRpFM7rjuUS0T4MMarXMwutYHaG+0zl8HcsHNH1DCAajIlitnAl+7X8rQf2qw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(366004)(346002)(376002)(39860400002)(451199015)(6916009)(54906003)(6506007)(38100700002)(2616005)(6486002)(53546011)(82960400001)(966005)(36756003)(478600001)(66556008)(66476007)(316002)(4326008)(66946007)(8676002)(5660300002)(31696002)(86362001)(26005)(4744005)(186003)(6666004)(31686004)(83380400001)(6512007)(8936002)(2906002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2lHMTVxZGlVK1RmNWpZSklVZWZaREN0RlphNS8rV2tsd013SVY5WFQ1Rmpi?=
 =?utf-8?B?ZER1MVRuT0F2Nzh5SVNYTGhnTFBreWlvRU9kSUVhUnF0U1VSVG8vSnRXM3ow?=
 =?utf-8?B?UTg5MjRiS2tLTDllbXlCdzJDOGo5cUYrS2JWdktWUVBlQURjNldSVGdwOFNu?=
 =?utf-8?B?Z1Y5Y250dWJQYVdFTkQzTkxyQ2hGOEFvRGJwZ1dRdU1KOHFvY1hXNEZRK2RB?=
 =?utf-8?B?SitQb0VQZmc5THVPaHlndncxNHE3aEtmU2FVRVI4eTdKcUlIdy9LYXhoemJx?=
 =?utf-8?B?TnluU25CRnI0ZnJHblpBTXV0dThYdTNDSU45VEtidVVxZ1k4MFVQUjZOTk5J?=
 =?utf-8?B?b1d0T3A4TzlVZndlNUNzREtVQXJqa1dsTlBSRzQwSGpGRkF0ZEUrTFN4SFVW?=
 =?utf-8?B?Skh0Q0FraE8rSWR4MU9pQXRsa3p2RFVycHBXUFlXalpjQmdCcVhEcUdkL3R5?=
 =?utf-8?B?dEFZQUdpaFFBeTFCZnlITEFwa2taRWk3eUFxZ2tzc3J1aVRlWDVwNENLZlpM?=
 =?utf-8?B?WUFhSTZUTUQ5QUFub05QaDUxY2YyVHBuNFduTGR2WGpmejdXdWUwN0hsQW1K?=
 =?utf-8?B?dGwyWnhmYkhvbVpoQ3JzL08vRG1KUHJ1L1R5TXVhTm11SjRTeHdIL3NBNHpG?=
 =?utf-8?B?NXdLY0UxcFFHZVduRWlnL1ZsbFZtbWVaVWp1VTVtbFVzM2ZXZDM4clplTHFR?=
 =?utf-8?B?RnI4SCtjaTdNMUFiMTBmcmwwRnVyUGhyaEJHSnVGc2Z2djVwZE1vME1yTG0z?=
 =?utf-8?B?L00xcHNTYXN6bVhyWFlwUFFLdzFnKy9Najk4U1A2aTJNaWdwdUhlMnFGeEE5?=
 =?utf-8?B?UmVEblNlbEtwajlTRS94UkpScEwzQ2ZQanRuQTRQSFRyQWtNczVXVWpHZHZY?=
 =?utf-8?B?VFNKMVRiRWVhc0hCa0Y3ais5aE1pTzNBY1dMTzcvL3VrZHU1WVhtY2FFRm5q?=
 =?utf-8?B?Vi9INzlXRmloSHgxLytJZkNNVEVacE1uMGxtV0hYMU5rM1V3d2xYcGJ3L3V6?=
 =?utf-8?B?a2VicHpRYWRkZ3MxTVJqVlhNRS9yRXdReUd5WHFyL2RuV1pTcTZpNVhyajQ4?=
 =?utf-8?B?TXJZQkY2SWFlU3lxTkZSVUVOL3F1ZHMxcmVrQ1ZQcW5WenR2dnJTM2VCNldZ?=
 =?utf-8?B?TDZxUnQxUzMzTVJhbWVyb2xCbU9OdzdMRVRERmFWa3ozUmtUSWYwaGRRSjVr?=
 =?utf-8?B?cUFvWGx0UFBWZ0FiT2g4NVNjejh0Z1Qvd0NVS2VSUzViYTZFOHJVTlluYmFl?=
 =?utf-8?B?TVNOdXRsQnRCZVBWMUg1OEh5UjZqd0dtVll6QU9reExITlR4MmpkSHRBemRJ?=
 =?utf-8?B?SUd3S2NpL2I2Q0lyWnBiRWtMNm11VFExUjl5TFdwbEhadnlEaFMyYkRORlR4?=
 =?utf-8?B?T3owSFkxRGFTdnBvT0RtQ1lUNGhVVW0xU005QWgvbVVNSVgveE4zYVAreE1E?=
 =?utf-8?B?WG1NaEpWTDBtMXRWUzJaY2lCY0c3aGhpMnFCWWQxQUs1aTdYTGdFaFdRSTJ1?=
 =?utf-8?B?N2VCMjQxRzAvY2JXOW16OEJ2MTd0V3B3L0VmYWcxUkcraStad3QyV1hZMVA4?=
 =?utf-8?B?c0M0ZmRFOWtSNzloTERWczRtczIxQ1M0RllKV0pWV2tyR2xnekU0dFlwcXk0?=
 =?utf-8?B?OGVxNzdjeFl1K0xpcDJrcllJNDhpdS9JaGxYRXhQUVppSVlKa2lXejZidmhn?=
 =?utf-8?B?UG1qQzQ3aEcvUWlERGF1bDJna1NoaXRnaUdiV2xzOG44bUpJU2R5dmZiU1B3?=
 =?utf-8?B?eDNIZjdMWDluL21ONCsvNzJjUGlYU1VZbTNQbnNDa1BGZDJ0TmtSVzNTelRp?=
 =?utf-8?B?ZE91bEZudEZGMjdYVExNRHZpQUp4TWJ3djVWSDQxbnJsVUFYbDBIbWJaRUZG?=
 =?utf-8?B?czJzNG5kT29zV1hKakx4QzFNVnNpN3dxR0pQcVI3cUlaN3lrL0RhNlJSc1NX?=
 =?utf-8?B?K0FvRDFJczJTdXZ4SVY0c01kdGRtWFlUZVp0S3hmNkpqTEdnMDRIZ3FGM1BO?=
 =?utf-8?B?TmFiZ00wWkhlbWFMWUFwcUFOY09JUUhTalN2bHZXMmhaR2h4TVB4Z3ZVd3E0?=
 =?utf-8?B?c24va1UyRnJsTkhWRllsenozeW5ZMnJEYkF5M2tlZUZBci9FdWhqaUl2VVli?=
 =?utf-8?B?SndRY0xTN2wxVlFnRmVKK3NGNEVCREVCdUszdHRTQnFMem10OFU5UnZTVU5a?=
 =?utf-8?B?Wmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a82931a2-e2ac-41a0-12af-08daf04af400
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2023 01:03:14.0113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ll0tHJGDRy3Gihm6LEFqW9Ib4Y0yAum11B8Gn8Es3R2hUjUaVnJfy/kwZnvkIg6Nk4l/9o64FG3ZtciENq6qdecpCiAqKm4Wr+h5g/EcYyc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6848
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/2023 3:08 PM, Mingwei Zhang wrote:
> 
> Is there any update for this code? I haven't seen any updates since
> this version.
Hi Mingwei,

Oh, this series was merged. So did the followup fix [1].

They are included in v6.1 [2,3].

Thanks,
Chang

[1] 
https://lore.kernel.org/lkml/20221021185844.13472-1-chang.seok.bae@intel.com/
[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a401f45e38754953c9d402f8b3bc965707eecc91
[3] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=471f0aa7fa64e23766a1473b32d9ec3f0718895a
