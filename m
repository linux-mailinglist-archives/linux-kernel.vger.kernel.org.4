Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6246F8CBE
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 01:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbjEEXUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 19:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbjEEXUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 19:20:07 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203F75B84
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 16:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683328806; x=1714864806;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YqrN3YGfK+Q+tx8IJHP8Bqbb0FY9BwhgQoCmnnDqzz8=;
  b=XZq3PyDbL9tfztd3mKQIjOLkKLjWOJQ9BFlqzVgj8ycWY4IjymyxdDqb
   JA/2hZjggO0O+C/aR80HtCwgPIqe/r/5oXQM1wRrYKr7BCbv95ViT21JS
   dBaGfbyQxzkKHW+xC/NHOoCfmODxl8xaQCR2y3m5zSQ8GyUNXSvpdrq2m
   2aeL0+goAH76xm954iVVUmuzxgVuCNj4s6iYT53eMeE5/JKpuYtv65ajh
   b2Cn5SvXjbVOsoknMZm3Wg08DUIJbvlmDGd5rdoQnoOJ7elKGBBLh9lDK
   io2jdG0EKHEy9G6uhfxcRDQLXG5gcInlqqBJHzsU26diuoOts0pyEXkLG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="435637954"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="435637954"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 16:20:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="728292724"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="728292724"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 05 May 2023 16:20:05 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 5 May 2023 16:20:05 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 5 May 2023 16:20:04 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 5 May 2023 16:20:04 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 5 May 2023 16:20:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XkLNHslNHR8gdt12aa/i9gsmXZhrt+1aygn6hRPuO3U+oHOIyNLxXA83nLSt6aDedw+1u6/tNOoeNeKHIkELNLIebRidlfTzVpOTU8FNi7SkReN4JfBeDjlVtO2u2hXzLTO2ir65JByLJLIfSv/c1kmf8w+z8sa7ExxjjuLWII3IK5jqoNLL4Cg1RMRNKDxW2qXYgySb0zS2tFxmInG5HtoR/lg2TheevCqgG67SbfiLRNjpD2MRUWHjRRYSM/OF/xwRhx03kSex/04xq29Ce5qeIPXMN83gXlRpJW5D0fFJrqFg7rQ439YtAV5mZdtkQwgrniY5HRPvgWxQ7xlaSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d3PO7lVKaXfFigM7eJO1FH+ZPzj9UuunBVXu/71Kw3w=;
 b=n5zysKtTxLgTggMymuLS3rHalGmTXdLg3BZqFMgz/VtHZ3XRA/+F047NBXgyEL3OY4IfPKk23gwKY7DgIu2LR2hQtW8eVXBM41q0/udufhA5zSPSg88k4akx6LltgQwQ+LjLrYFUYVnrm+dU7/AjHrIqv5XaYe8tVCfazpnQdQs1+gTWQQaZYfavBbMBUp82wvrWWphci9RQtTJkWwMzpc4nenRthPMAVAZG6+DoojMCHu8LMStjEbVyvZAh6UJQm3uIQZ1XOVd4SYaO7rkfq697MlEZkXj6atHbNnOE5Em9SWlQsgaY1OIMBRb4fgQYVHKeDQoeRtolSV8Y3Sxd3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BL1PR11MB5953.namprd11.prod.outlook.com (2603:10b6:208:384::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Fri, 5 May
 2023 23:20:02 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d%6]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 23:20:02 +0000
Message-ID: <f2e1d8d8-9687-4269-28d4-8291acf978a5@intel.com>
Date:   Fri, 5 May 2023 16:20:00 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.1
Subject: Re: [RFC PATCH 5/7] x86/resctrl: Enhance driver registration to hook
 into schemata files
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        James Morse <james.morse@arm.com>,
        "Babu Moger" <babu.moger@amd.com>
CC:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230420220636.53527-1-tony.luck@intel.com>
 <20230420220636.53527-6-tony.luck@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230420220636.53527-6-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0149.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::34) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BL1PR11MB5953:EE_
X-MS-Office365-Filtering-Correlation-Id: b99195fc-72f0-4cf4-600b-08db4dbf40d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cK4b4ugiIwYpZqycgCQnppmUVLnxZnCV7lKqYDaKRxCyp/y/eF9EvQ7O8JIn880kG3eUDt9U9YU7ayivSF62X1MXg1VNl4/WwT3vEcW6heWpT9bPw5DudgqkZT0heKEQnczt6TqtbGNlDdhNHlHuoqixSETtB7NVTyWm2y5aXYLZ1vFfEyTQatmLNhw/2pVz/Xe+rSjqi4e6s/8MuHJn6aUkXDeygX2WYleWaQnC+/Gxq/HoT+Czx0dN+UOtZot+OuoaOORaMnkEHi62cpZiAlTu+zTOH81mMaKFxNi29heohs5Zee9BHeJhH3HaI7Ef1w7CAa9c0fT4l/X8pDCwfmzf5fNqJQTcpl2jlKfUfUlO11F1FWN+0WYOSHxIsLDRlJkGIeE1KQ2Od8LRTfOREeDwLmXma8DkF8PNdSI6WfYqwoTpE7AMvgHnbGl2zVuoFrwa1rUC+RheJtTKPH3dARnZBmmB3lNhHvCiUxipUNAaBKyvUVc0fDf8v5edKixROgvCyHxFgVKGPDiPdEAPG5NfU/fR58jwW7GckC8RYfQ5g5kqn6pYhSprRvDsBbnsJVewi3CiafXNW4LJQX9Djv3CCwmO7C2QIH12CM1/ggboj9InJhSXb1rRJZSxdEdrBfjVnHp7BDbqPx6fZm9HtE0wzntgW19GlPV9tM1jca4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(39860400002)(376002)(346002)(451199021)(6512007)(53546011)(6506007)(26005)(31696002)(186003)(2616005)(31686004)(110136005)(83380400001)(36756003)(6486002)(2906002)(82960400001)(316002)(8936002)(5660300002)(478600001)(4744005)(4326008)(38100700002)(7416002)(86362001)(8676002)(44832011)(66476007)(41300700001)(66556008)(921005)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dW4wSmtPaU5CK1BkSGFrZmlKS2tlelFZNGFVVG5YZHpTaUI5d2s4M252cnJC?=
 =?utf-8?B?SWtKTVprZUtTNE1QbHBIcHowcUFkeG9uaVU5eHZKZGhwV2UzbFg0Q254djI0?=
 =?utf-8?B?YkxCS0dwbGxjRzNVZlg0N0VBakpaSW12N1BmbFFvUmY0VUxyaDdkUnhZek5r?=
 =?utf-8?B?dURadDVvOUdNOGdaNVVJUWlMWVRUS1hQM2VOb2xYa2pPTHRwczBhL0FGYlRD?=
 =?utf-8?B?M01lNlk1QldkTjNjUUp1aU5VNGFMUVZCaEZXQ0ZaaW9ZQ0FFaE1zdXgvT0Fq?=
 =?utf-8?B?WTFxOUN4L0VVUmxJMEsyMFUvZ3lwMDRWUHpUVzV1M29OL3Z0ZVpEYyt4amhU?=
 =?utf-8?B?NWlWZmVNai9qTnFTc0FIQjV2UFNIcG45bHgwZHkzQVpUcXlBS0d6ZmZremhF?=
 =?utf-8?B?eFkwb1llZXBGeHc3bVRCT0hqTlMyN0lRcTNLRG40dDZmTUJkamhsNWV3d0pO?=
 =?utf-8?B?MWRldXRHYklZNFZYVGpKLzB0SEovU0g3ZkRaTHJlTTFIeVpWc2NSRzg3MmNU?=
 =?utf-8?B?QVpjRVBYMWZ3d1FmajdHVU4rTFhNMmFySXh3N0d6N1R2UFpZYmhwa2JsaFFC?=
 =?utf-8?B?TFNqWDZyRzFjWlRqSlFXMGpCL3pZbzVPaXE3cXlmQXpmZDliRTZKNGJTZTBs?=
 =?utf-8?B?UkJ6aVJVQjY2ZVRYNzJFaUZJbkNCdys2MEdjbjNDWVNLME02cXJWOXNpQzUw?=
 =?utf-8?B?N25zaHVnV2Q1TjdqeE5KckVUbnQ0TXZNZjVndmkxd3NOTGhIK1dkaGJvbXVC?=
 =?utf-8?B?dFpVbWZTMEFvNHduTisyZEVkZDNkUWdya0Z0cWk0U0J0SHVFdk9yVENjdHlP?=
 =?utf-8?B?RDJ2OUVJUmJCMURHWHFSUFArQTFCNXVrMlVCVlNRWDdiS085bU1sY2piR3Jo?=
 =?utf-8?B?c0NZU201aFN4bWxPSFZ6dEt3ZTFnTi9MS1hyK1AzZFU1dUxLeU9qS2VkSFMx?=
 =?utf-8?B?TWtxcnNlamZEUmN0Wk9ibUtPMnhFemJ2WlJoNkhaM2RiVUFTc0ZWRGZFOGUx?=
 =?utf-8?B?ajZIZ0xZL2g2UFBUQ1RvMkFSRzVWNVlVVTk1bm9iM2NPMVJZbDEzeUo3WTBT?=
 =?utf-8?B?dVBzOUFQWHZEclhkWE5PdEU0TVF5NUppTTFwcHl6KzJ0NGs3L3ROMUJLUEVE?=
 =?utf-8?B?WUVFKzl0U09oUVgvVmpKdFNjNnlkdDZ2TG1iaGthdjY2ZUdXSm5NVjFKRVhw?=
 =?utf-8?B?QkdHblhpM293TDF4OFZVVUpQclN6TzVsV2E0UGVrbnIxL2xNTHdYazRkRGVP?=
 =?utf-8?B?U1F3M2kzZGl2Z3d3bnpzTllZeXQxa1hXRi9BeG0wa1B4TC9weFZhSldWNy9I?=
 =?utf-8?B?RUlUVHZ5N0N0VjQ4MmFVeHc0MzdqRXFPanpXN0V3MW9iMWY3eFBKcWxlSHZi?=
 =?utf-8?B?WEFHVjVvbXFrWkNiQVRRdFdaeG9Sak5WYXpHV0FYTDVLMTJyWTl1UGJRWTB3?=
 =?utf-8?B?UUc0U0txbVo5OUtsKzNzb0dQTGxZYksyRWJvQ3QrN1RCWjcwam9nOGY5bmRR?=
 =?utf-8?B?bGM4RXlJTi9PSStsdGhTSjZDS3h3Zld5K2w0WWVPSmxVVGh0UlduQkpocHRy?=
 =?utf-8?B?dWIrWnFVNktNdDNvRGVlYURLZ3haNGU4VXJkY1BLNGtNRVc1SHprcEcyNlZO?=
 =?utf-8?B?NmFCYzZldjc2U3k1ZE83aVpwbVZTOFBMT2xFRm84S0xCRThRL2M5TTdTWjND?=
 =?utf-8?B?ekRxVHJvOS9CU0JaYnpTVnZUcitlbGNmcVNqL2dxbjFKRitnUGk5OHd4anpE?=
 =?utf-8?B?SmVRQXdyNFVldnpidXFJajBjVTFCalZtS1BKcDR3ODM5b3ZPMXZaYU5xUGN5?=
 =?utf-8?B?UFloRTNFRHNSYkRCQWkrVWd5L0pRZXl1TlNqczF0ZEpzTEYwUUVhdS9KVFh4?=
 =?utf-8?B?dkcrWVREVmFoVmI3SFJOUVh3a2NNMTJVODdMWTZ1cUV3RWpzRzlUUUYwazNJ?=
 =?utf-8?B?VDRxOEE0c0tXUjdrODh5WEEyQUgxdnBCSUQrYmx6N0Jtdzg2TE1UUmc5b2sw?=
 =?utf-8?B?QzBzQ1VNOTZjZkkzdEIxMUd4UzVmSFQ0eXIybnpTMC91M3RGWTQ5QzFHY1c2?=
 =?utf-8?B?RVNyb2xma3lNVWtFTkVDRVdIdEgrL3BQUVNyb1dYWkg3UVVBeWVvRjdpYXBR?=
 =?utf-8?B?TmdTbFJtVVpCbGFQZUZ4ZkJwdUZ6TzVkSURlaDkxdGI2SitlMmFhb21vKzBL?=
 =?utf-8?B?UVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b99195fc-72f0-4cf4-600b-08db4dbf40d5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 23:20:02.5662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eWT9uGWYctQGpuqTWvWRq/aPIuH5r/5fhVtQyo8nmGEtrsLD5tU72YzAWs2ALeBGuKHq2EK+vHWQXg8OFDXUh3hciD1+uGhga0NJg33tjP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5953
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 4/20/2023 3:06 PM, Tony Luck wrote:
> Add a new configuration type "DRIVER" for lines in the schemata files
> with a show() and update() callback functions to the driver to maintain
> these lines.

If the goal is to have unique APIs for resource, could an alternative
be the have show() and update() callbacks associated with resources in
resctrl self?

...

> @@ -2390,6 +2392,9 @@ static int schemata_list_add(struct rdt_resource *r, enum resctrl_conf_type type
>  	case CDP_NONE:
>  		suffix = "";
>  		break;
> +	case DRIVER:
> +		kfree(s);
> +		return -EINVAL;
>  	}
>  

(This could perhaps be simplified to not allocate the memory in the first place?)

Reinette
