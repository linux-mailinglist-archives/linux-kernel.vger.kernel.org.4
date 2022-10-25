Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B6E60D81F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 01:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbiJYXoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 19:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbiJYXoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 19:44:04 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DDE18B16;
        Tue, 25 Oct 2022 16:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666741442; x=1698277442;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=X37EWywejJrvvmBszHU4p+IfUrQ671TZHYam/MHZXBg=;
  b=gEuJE7HyE7zHFz2w49bY0+mH8cZJForoJDwXKezMKDhKrhQK4AxkA/il
   64KEQc6qWfiabWieujMQULcBYgsk/9e1isD7kfcnitCIOnkPuCzOuaW8I
   u9c5rjuHMZmfKgEiwWt8jR99lrH7npAlxO8P5YbpteL/mr+i3ImRkJlwg
   RxptQjSjflbCId++3w3NLjcCpGZnBzWCfhmLItKdRBohSIo+tpXXP4W6s
   dXsztJG6fa/7Lro1l1W5mki7Eon3ltP/CkRdwscCaplxhWEDiC6rFvo8s
   IhFTDyzPWmLC9xIdc7rBegLN9uzU/V72iEghyZxqpcQwWgbUL4SE+4QXf
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="334428444"
X-IronPort-AV: E=Sophos;i="5.95,213,1661842800"; 
   d="scan'208";a="334428444"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 16:44:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="582961991"
X-IronPort-AV: E=Sophos;i="5.95,213,1661842800"; 
   d="scan'208";a="582961991"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 25 Oct 2022 16:44:01 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 16:44:01 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 16:44:00 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 25 Oct 2022 16:44:00 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 25 Oct 2022 16:44:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SnEvtboyps3M/aJAqI4ospYqsExpFbW5tUjBsXtoNstTeNyatWW5G4fTEt5wzpdzxLuGvCAacGdD9CLEcHHUa7s7ZK+JqxrnknaJaSAGkqB6meLuHdoK48PH9xW3R1KxlwXb7cgwIO9TwKycB5iR7nuiaq269j1/t0yph0BIluhVVTR4BT8bH267M+fxn8aKXTqvQoPFONMhIvEiqZIlnZikyxU32ruVK0HBfzpSLUDHgJOfVYDEO07lbp/gN3zcyJd9m8TcRMyewtpJaNzkb3AacHur6yY7gtz0joU/wIHo68f4sDANdXkcbcpfE6E5vfmH6d90dh+QGRWsp5w3sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ySb5UWbAVlH/sYVxMb22m9kpmxXbJ/S5KlPbPhh1i0=;
 b=cKx7aJMl2ngJhxmBXDnWNGTYUOuMXE3T1DxKaUiYAKtHvH4OudOyoUvGDFff0EDNO1KA9ATWfUbhEFHFYl6AaRtYnBTvPQ/yJ+Ev90rMwIAjrSBnxTJ7JdM5wT5hZQY1oyyB78ZpWV/VXUeK/gK6SeyasogwIK9GOuxXIwZXmB81w307wa0BJc4m5OW65R9pSyXMHHpxky15mu/GEcQE6NtwRCzAAOZb+8lq4NOSJkcn78YJaT+twTOJzXUSoHsnu+cri40H2EFjGbNLJkLw9q+el7Xzz1NjpwQaN5QxiBK4tK90HFSl+ZolJn4etDvidtUztjL/kc6OpEebZmnS+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by CH3PR11MB7201.namprd11.prod.outlook.com (2603:10b6:610:143::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Tue, 25 Oct
 2022 23:43:55 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%12]) with mapi id 15.20.5746.028; Tue, 25 Oct
 2022 23:43:55 +0000
Message-ID: <c999a7f8-b083-72a6-ff07-201369339c92@intel.com>
Date:   Tue, 25 Oct 2022 16:43:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.0
Subject: Re: [PATCH v7 05/12] x86/resctrl: Detect and configure Slow Memory
 Bandwidth allocation
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
        <eranian@google.com>
References: <166604543832.5345.9696970469830919982.stgit@bmoger-ubuntu>
 <166604559954.5345.14619487558472213422.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <166604559954.5345.14619487558472213422.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0193.namprd05.prod.outlook.com
 (2603:10b6:a03:330::18) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|CH3PR11MB7201:EE_
X-MS-Office365-Filtering-Correlation-Id: 0114b6d5-384b-4ac3-60e2-08dab6e2c755
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NhPbqqs3GGtXEZspZu1lHhzYpEHF/p8pBBaAe0v3DR12aPA93Gf1MbmScpKJ/fHx0g9BzegI1KAVpMFrwaYq7kFtrMfVKgJgCSrd9cHrKWcLoA+/aOhx3G7v/nI7ynsc/AsSu5kCR6xxEQssWUOFthXWDbw2nnWAYTjg0MetAVdkbT3AiIOK6IG/aobFuODX/miScR+yffusQxDd2KDLzy5lwln473i7e+CMjzg7BvJLR2AtyxSxm3WnxuVXx4t5n8rXzhHW5sy54sNmI4ECKJqYqWHLgVfrFPrea/qWD+A2UClD25iqm0bM4Pn+WdJMEx+WoVBZEFUwRXrxTq5NtDRpy382wG1xfZi/kdf5WOmM8ZiaSBQ2EVymtdPrF+QVsTAiustKN/cvVObsFRbJBBIhJXK9peJKw+rCZWziUx6pUVmkTu9YvX7vzJ7Jjcn2ZvDbR/8OfJME/ETHMKB0DqVoatuN1FGPiAR5WuPsrGZJYVlX2xZN4Shbw0xtBzqTEZqJszXeb5xup6VAeSLFaDPiO9xGnhD2aLgv+GC8dJkGx0As4IzEyzE4bLe1Xa7Vieu/9ikXRZwtdCDO2+AVgqa0fhRAf/lkiEF7izjlLrw28z7K7XRkR2l+GyPrkt+8Yj+O/EjYOGpd4ZfEiUhf7oheLwxKX/34JtSI6Uo8hcCdcTgKyTFw0GZQsSMuAAZJK+9eFKpMtfLO1VIUB3KdwB32wM1vveusNTFVOEse1n/g+U3PmTkCnBoRxGhsPYNRF3BcKP0AVCNls9vy6sgzm+95QYbYhhKFC7qS850VjgA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(346002)(396003)(39860400002)(136003)(451199015)(8676002)(82960400001)(83380400001)(478600001)(6666004)(4326008)(36756003)(6486002)(44832011)(41300700001)(316002)(26005)(6512007)(86362001)(8936002)(38100700002)(31696002)(2906002)(31686004)(2616005)(7416002)(186003)(5660300002)(53546011)(6506007)(66476007)(66556008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3ladm40ZVBDbFdGbE5wSUozUlRGNkN4UGQ3WWd6RUs5ZkN6Z1VIL21va2pF?=
 =?utf-8?B?MFhvMmpDa3NFcFJVdCsvdGtwaktoWkhKU0ozM1N1OWQvdTBqemJIWms2TEpr?=
 =?utf-8?B?Z1R2alZMUWJ3cUlBNmlsL0xoYlFGZmwyaE9LMGE0blJkeUpRNjlEQTdzV250?=
 =?utf-8?B?TzR1L3JOSFVuRHdzai9WclJ6dnczK1BjMU16OXoxclc2NFRacGViejRrZWtL?=
 =?utf-8?B?R1FjcVlkMm02WGdQVUdoN2VZMWdBa2F1by9lejFEcW91bDRtV1kyakJLS3FD?=
 =?utf-8?B?dGpxVWFJQXdKVVVQWldFcGJWUXZiN0E2MHJZUU9qekllTSs1V3hkS0tQWERw?=
 =?utf-8?B?djc0RXRleHdyNVFpS25qMS9uNFRqa1FROFg5bU9FNzE0L2Foai9LMWM0OXRK?=
 =?utf-8?B?YUszV2xDRTFETkdGR1JuTFVkZUc4V0pSRXdJTVdNeXJaZEx2cm9nNzhBM1pT?=
 =?utf-8?B?cXljT01GNjhpclhtWUlNRGkvRlRTMFRXUlFUV3hNSmJnM2FuYUpZZ0t1Wmxq?=
 =?utf-8?B?RVMzUzZidHVQNno5bm9SWmhQTzVEZ1MvRG84c1l0ZWVERFY4WGNjMVRpZEpa?=
 =?utf-8?B?NlkwR2F1MlE5Q0JLSWRDNVFzb1FQdWNvUlVjblNyVURNSXo4ZS9vdnBkcTl6?=
 =?utf-8?B?TlVCdmJoSnFjc2xya2pRSU90WmhjUE9SdEpKYnFqMWcvS0dvd0tMS0NBR2g3?=
 =?utf-8?B?aXJzRmZLL3A4YnI0QzNWVU8wUnB6T0N2T1k5b1lOd21wMnpRcVg3akJrTEZq?=
 =?utf-8?B?Ymg4K1ZHdUZwVXNMN3RIcGJ5bmJEMGRZT2kzSFFBbGxocVhqSUJCcklYY2pO?=
 =?utf-8?B?WStSMmdXWGVSZzBNVElNdUFyS2lIdUt0b0NkOUtPWGdjanM3WWdNRFRxT1l0?=
 =?utf-8?B?L1FjUmhBQzJqcStZREYvVFhQQjcybFdJRkErVGhqaGtuOWRTVFVtWEI0amZa?=
 =?utf-8?B?MzVGK21EdDdMcXN3VEVSWGxXTWoydVo4TXFVNi9xc0RBckVFMGhlVWlheUV5?=
 =?utf-8?B?Ni9TYU0wUGNPalNnbXpsbTNDMHIzTXZxdGhBRTViQlFsSklIOWJjTzQwZUkr?=
 =?utf-8?B?YUxFVUJZVk02cVV3U0tzUWVURDlXQUlJckZVbzJiY1dBQ25jM3hrWGYzYWRP?=
 =?utf-8?B?MEJ5SGNXTjluaERhZU5UU3FkK3lkZXJadEdiYzZlRFplUHBxaWRxcXBNNzZC?=
 =?utf-8?B?cnAvYXFqbVJWUUdINmppeENyV3VoQWZuRXo4Zmxsck1ranZ4akJQcTVGbXZr?=
 =?utf-8?B?SWhpVXdwQ0RPRi8wcmg5Vk9sbVZmc3BXdUpKUnVZTTJ2RkVCSE9DazNEclcy?=
 =?utf-8?B?UjJZc0FaV2xRNVZVUUQ5SmZlUjBXOXphc3hORWpMUlBZK2cwdHcwL1BjRDg2?=
 =?utf-8?B?cE9qM1FKeXphVyt3ZmFIcXJUa0tURGxGc2pwd0pKZzBwMlB5UTRVT3F2bUg5?=
 =?utf-8?B?eXArNHg1QmMveHFZbWJJL0tiZ3NSZmVucFhGUFdzZlFPSkg3cmZXZkhzNTZU?=
 =?utf-8?B?bXpRNXBtOG9uVXdoUmdla2prVXcrSEZSOEZLNVdnVm01T3E4VXVMV0hXaFpU?=
 =?utf-8?B?VUpmeTZJOE1QdlZ5YnEvVmU4TENLTDZzelJkaVFoUENDakJ3dU1XVGxBNUJF?=
 =?utf-8?B?ZGlvWjIwSkxqR2FxQjRtSUUxWTRva0xkVy9MazRTVXRLQTBWa1MxZnc0d1Zl?=
 =?utf-8?B?VWQ3QU9SbnJKVkx2U0VqUktBaVEyKzk1WURKUEJJTVdMTE1YSFA1enRBb21Q?=
 =?utf-8?B?QTMwY0NEYW50QkZKMldreG1qR2pTMjQvcVRIVk5iV0xPTFE1bGt0TEYrNTNq?=
 =?utf-8?B?cStjaWR5aEtTRkxJcHN6R2hoeW8wY25pejdaYzUxS1k4ZUpob3p1OGY3U1BK?=
 =?utf-8?B?L0kxcGx6YUxEbUROa0Q0dkpDeGVtdXNDNTlnTGFpL20wQ2pnQ2RqejBpbVRQ?=
 =?utf-8?B?Q0ZsVndWTHNXYzI2RGJGb0ZjaXZiSy9QU0xDMlRqMVdERUdDM254cnB6eHRU?=
 =?utf-8?B?S05YZUtXTUZTK2l6eHJKS1ozN0pyR29NZUozZkxLOVdKSGpvUmE1bTgvdGxC?=
 =?utf-8?B?UnplZ2JVS3ozWml1bkFkU3JLSGlqM0RreHpRR3dYMXBzRVk2QkcwUEdBalVF?=
 =?utf-8?B?cnlYYUgxSTdwYWRNd1FUM081R2Mzd0puVDZlMmo5SnFHRWYxc21EL25IV2NQ?=
 =?utf-8?B?c3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0114b6d5-384b-4ac3-60e2-08dab6e2c755
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 23:43:55.1815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4jVv+pt7gqnNUHjAjw28OeXPjQG4Rzva4mfN+2yEx1fokgDEH3Euyjnbf4IdqETZeTUBFJj+3TEYG+IeapQ3H+YXALL3OkuDcEbgJdjP6o4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7201
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

Nitpick in Subject ... "allocation" -> "Allocation"?

On 10/17/2022 3:26 PM, Babu Moger wrote:

...

> @@ -2845,7 +2846,8 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
>  
>  	list_for_each_entry(s, &resctrl_schema_all, list) {
>  		r = s->res;
> -		if (r->rid == RDT_RESOURCE_MBA) {
> +		if (r->rid == RDT_RESOURCE_MBA ||
> +		    r->rid == RDT_RESOURCE_SMBA) {
>  			rdtgroup_init_mba(r, rdtgrp->closid);
>  			if (is_mba_sc(r))
>  				continue;

The above hunk and the ones that follow are unexpected.

Note that the software controller, when resctrl is mounted with "mba_MBps", is 
only supported by RDT_RESOURCE_MBA. At this time this really is hard coded all
over the place, for example:

static int set_mba_sc(bool mba_sc)
{
	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
	...

}

Since SMBA hardcodes "delay_linear = false" I do not expect it to support the software
controller ... but these hunks appear to treat SMBA as though it does. It is the "MBA software
controller", not "SMBA software controller". Why does it check above if the MBA software
controller is enabled on SMBA?			

> @@ -3287,7 +3289,8 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
>  {
>  	lockdep_assert_held(&rdtgroup_mutex);
>  
> -	if (supports_mba_mbps() && r->rid == RDT_RESOURCE_MBA)
> +	if (supports_mba_mbps() &&
> +	    (r->rid == RDT_RESOURCE_MBA || r->rid == RDT_RESOURCE_SMBA))
>  		mba_sc_domain_destroy(r, d);
>  
>  	if (!r->mon_capable)
> @@ -3354,8 +3357,9 @@ int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
>  
>  	lockdep_assert_held(&rdtgroup_mutex);
>  
> -	if (supports_mba_mbps() && r->rid == RDT_RESOURCE_MBA)
> -		/* RDT_RESOURCE_MBA is never mon_capable */
> +	if (supports_mba_mbps() &&
> +	    (r->rid == RDT_RESOURCE_MBA || r->rid == RDT_RESOURCE_MBA))
> +		/* RDT_RESOURCE_MBA (or SMBA) is never mon_capable */

What does this change do? Did you mean to add a r->rid == RDT_RESOURCE_SMBA check?

>  		return mba_sc_domain_allocate(r, d);
>  
>  	if (!r->mon_capable)
> 
> 

Why are the MBA software controller resources allocated/destroyed for a SMBA resource? If
you want to support the software controller for SMBA then there are a lot of other changes
missing.

Reinette
