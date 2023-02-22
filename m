Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052EB69FF8E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 00:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbjBVXdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 18:33:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBVXdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 18:33:01 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A595245;
        Wed, 22 Feb 2023 15:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677108778; x=1708644778;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=56bmu2jUpkd5Oq/BUiwMqClbMyiJZP2lOMD1BgWDsec=;
  b=R0uytNSXuJn9al7GSfzXPOdp5bA9dPxVCGcBchct9pLEv+f621YUYB2F
   kMMbFHJqxcAMWm/g770iMDhADAkS/B8hCr4tImAPNQCjUOdIlcZbFJS1I
   bd4XSA927ZAMuGTUdCQBxfyYljBUxgl2pgRQK6m9F7xpmjejYaP+MnRkO
   1bPqBt3/eJ2zxghfyrLUDF5y7ZFJP9hpGGmORQZXViBcrPdceQv/q1dx6
   gHthBImQtRp9wp1hVQxjUW7m9KDK8e5l8VAL/IC0M1cGSqW5k7Eep0FNe
   vEnRgm4D2Oja+tIXccw2JCJzUVxxIkDpDqzjXQ0ZO+QR36nxGlwW5nwKn
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="334431009"
X-IronPort-AV: E=Sophos;i="5.97,319,1669104000"; 
   d="scan'208";a="334431009"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2023 15:32:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="796081656"
X-IronPort-AV: E=Sophos;i="5.97,319,1669104000"; 
   d="scan'208";a="796081656"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 22 Feb 2023 15:32:56 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 22 Feb 2023 15:32:55 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 22 Feb 2023 15:32:55 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 22 Feb 2023 15:32:55 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 22 Feb 2023 15:32:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hmE3eeiKOcu3vHAxWozdOR9bhJvThNzzK4XZ9esstnMPkOQl/JjCOpvpCOd8FTl1SjaG7BhKkmTgi6aaPgxrcbcD2OCUhKSU4T3wig5foJsdb48N+aFKx74e0FWZYZJroesDR8zYt7WFhdlSaDZ2sjMQyVRjXs16kRbI4nNR3Hkcrh1im8HSIJ4iyopn9CIK6xbYnO9/QtyslFylIf+axnywQ0egqmuxxV57IlsmP/59q9EtQxYDRu5LHounI//KYt52Lzx7fmY4FcRE9mNltZmuMZTOtOa8jp6PT6tOkSSd86k9AjqclmYYkHD0T4i7hMP61WzxGfxtZAxdVOeicw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/2I4LUnxRP4Sn3+7DPyp2bna3fM70nKwdT3cj3pQfU=;
 b=Vl+8od2QHqzyjDlvlHTFhAhz9+QdZU1Gdlz1irX/R0FbBvjo4qhfMNk+wD6Of61QuzOZ3s0mjggDgaa/3g3TdDfStmKIq2ncvu88E5BtT56Vr1iEAsLW3JIV91sgL3BDh0lAgl17WpCVgk7T89UdNNRR43At9x3Jwddg7eWZzMyRBDbmWKjsXZF5hBCPC0Da/dZHSpJr7y6HervXG7Gi5TmwMtND7688HGdbbMx+D+MZ0AzrcJpfhrizbKo7T2bNOEaX8FPtawRtT8ejG0JJ2D6n5x0N9FP2hgep9D5U5to/6PYj6VOP0ZQGIZx8YwrE5IH65bugID0bAwI9OMQh9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by CO6PR11MB5649.namprd11.prod.outlook.com (2603:10b6:5:35b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.20; Wed, 22 Feb
 2023 23:32:50 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::b387:57c:7240:8b72]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::b387:57c:7240:8b72%5]) with mapi id 15.20.6111.019; Wed, 22 Feb 2023
 23:32:50 +0000
Message-ID: <82a6f9b2-bb17-babd-fbe0-c4a5bec1203b@intel.com>
Date:   Wed, 22 Feb 2023 15:32:47 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
Subject: Re: [PATCH v2 4/7] platform/x86/intel/ifs: Implement Array BIST test
To:     Dave Hansen <dave.hansen@intel.com>, <hdegoede@redhat.com>,
        <markgross@kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <gregkh@linuxfoundation.org>, <rostedt@goodmis.org>,
        <ashok.raj@intel.com>, <tony.luck@intel.com>,
        <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <thiago.macieira@intel.com>,
        <athenas.jimenez.gonzalez@intel.com>, <sohil.mehta@intel.com>
References: <20230131234302.3997223-1-jithu.joseph@intel.com>
 <20230214234426.344960-1-jithu.joseph@intel.com>
 <20230214234426.344960-5-jithu.joseph@intel.com>
 <a24c65f8-978d-8968-7874-6b83e14b01ba@intel.com>
 <d9d18954-8434-4c85-88b8-8e1d99cd6a4b@intel.com>
 <dd501d6a-e7e9-be82-24fb-33b18fb6192b@intel.com>
 <b67d2125-4075-4eac-4cad-8e315b866144@intel.com>
 <5d57f42a-1bfc-5e6a-bb49-556ecb7402af@intel.com>
 <9c55a34b-c17e-2a62-9989-902ce940dde5@intel.com>
 <42ac85ea-0ffe-55fc-57c2-6f4555e8dc5b@intel.com>
 <8fb5ebbf-d468-169d-5603-b267e7b42516@intel.com>
Content-Language: en-US
In-Reply-To: <8fb5ebbf-d468-169d-5603-b267e7b42516@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0123.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::8) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3768:EE_|CO6PR11MB5649:EE_
X-MS-Office365-Filtering-Correlation-Id: 9738dfd3-c8c5-4003-5115-08db152d1c3f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o/IVa0ZwPF/l4KvtBorkVoCfTdksFje9xgulYNgREbBrgq9nP96kl+9/1CqGcUrXNjQvBcucVc7SKGeP0dVS+DXduF+NM18VK12sqWd2oz+V/4TftCACzi9FS8620+sBqXBAuYKgG9XHM66DBaExPUn0S8wO6u0eiGQT0TBFwoPHXzrLWUDvATDI3x1nXpDUhjV9vF2g4rEUCJeRkbnnCKJdahUS9VvadZd1mQIMrUIlnt99FN8NO9u4JWpDs+W14beVH+09Hfpk961GSbItgzHj5Izsm5Wqx5mGoKXnUARXvaYkUV9D1IAMYXmBZyeHcmEvXiPGzbAmhHgo+u/tIxdvXlK0GJs6mf/KcK4TUEu1Lqyk64R03w69dI00NGrIiuRSvnlWeTSgv4Rvf7+bpqORS/3CFfj9bpoILHQk76X+58xWAGTcCni4WnbQhvwJhPAvVDDnA7u8iX6myE1OLHRkT2OgXDk/DHtIcgkFv6dNZxxYTypbYgX/Dd2CT9zNYarV+Tb/eDCWeexihrMDYJjGD/P2kleACdTB5ssa491S/x2NKy7Wru2ZatSd5VpnUusk5cli9sannSjDAmoAPUZPrEHgtL9TZoGjYFNPZGKfr0EsXHfjkbO5KHqeuHZS7DLnbRtWOKR9r4u7Py2l5gyg6goCibfjliLDhZQLaryj8bITwFTQKYubbLvZQIfLj+kLMNd2sT/JkRG6pl2H3DP8tqFzSdK39P5Mhk3S9mcQJYeyr9ou2qzHNMfd1x7z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(396003)(39860400002)(376002)(346002)(451199018)(86362001)(31696002)(316002)(2616005)(31686004)(6486002)(6512007)(66556008)(5660300002)(66476007)(7416002)(2906002)(4326008)(66946007)(8676002)(41300700001)(6506007)(53546011)(6666004)(26005)(186003)(478600001)(36756003)(82960400001)(8936002)(38100700002)(98474003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3RVLzdWR3RTMmJ2TFFCUk9ZTXEzcnF6a0ltN0lGNWExWjF0cXY4c3ZRK2M5?=
 =?utf-8?B?cGZUSGt0S3AvV1IyMHAyRlBZNklqQ1RhLzUwbjZxOWVhNXpndmhsNHpOOXd4?=
 =?utf-8?B?NU02eEhzb1pNZDNrcitnQWE1RVhOb0tObzNSdzVJVnBkU0sxdjhGdXhzc0d0?=
 =?utf-8?B?MmxUV2hULzFJL2NjUTZ1aTZDWG92ckxCRHBPc2wybmcrZmsxSkJLUmZsQk1R?=
 =?utf-8?B?akV5YjlYVDl2TnJxL3pRbVB5d1RQUTA4KzVNYkFIOFJ2NmplL1J5T3VwSUk1?=
 =?utf-8?B?c3hJVUpDeTlsc2dLRUsrMDV4Ynh6cWJ3VnRHSjB1RFQvUjNyQlh0azVEU0dN?=
 =?utf-8?B?bjUxUDRKMFFhOE1QSjlyWnBxWEJVdkJYQ3hxbStQN2l0bS9qNEpmVXpXb3Fv?=
 =?utf-8?B?cWwyc0RKV0VQUWxrc2ZhbE9rWDZ6QVV6cDgvVXk1L1NORy91ZW9teVBjUFg0?=
 =?utf-8?B?K1NJcHRSVGJ4QkgzNThhc2Z3NWRJYml0dnpNRlRRajl3VUZJSjA4YTd3a2JL?=
 =?utf-8?B?TENSQzRSWWgrRW1LaUhsQ0IvUzlORG90QlVmZ1dZcVpOUE5KcTBGeEVoYkh2?=
 =?utf-8?B?R3o1ZlRWdkxNYzY5UWVsdEIxVmJ2MmxlQWJreUtQd1pZakdGYjdoWnNsa0JQ?=
 =?utf-8?B?WnZ4d3FpUHEwQzR0VTI0YlhESzgxUXJVdlBUL1ZWUzJkTjIrYjRsVXBXUVdh?=
 =?utf-8?B?TzJmMXRXWEMramNRcWdlU0EvbjVzL29MWXJRM1RVUzNIaUNUd05ZSVEyUWpl?=
 =?utf-8?B?K3dpMXJ5MS9hcXJCUFI4Zmp4aWptWWxTT1ZtZk5sWW1ZeEVXMWpmaUpITXh6?=
 =?utf-8?B?bEJsTk81TFVQNEVZK011ZlR4QlVUTGM4V1BqV1JpUVRyQld6b2FyOW1nWG9D?=
 =?utf-8?B?dkdKWUE3Ymh1ZVhjVDlnZmNTTkdhOWRKSGZWNWFJN0d4dVc1L0lVUHhZSnph?=
 =?utf-8?B?Qk4vaDJrL0l0am9Rak4yWWx6OC9oWFlycThZVU9Kbi9lQzdHYWNJSVFDV2pj?=
 =?utf-8?B?WGwrTjE2RFRTdUdxMnNGdmJ0KytRaFhtaHdjVGtySlBuNkcwWG5EV0RYbHRM?=
 =?utf-8?B?K2VPUVVQUzZ2aEllOERqSE1XSGFFdTFwT0xhTUFKb0lSUlpRdU9oeHZ2MDZt?=
 =?utf-8?B?bUR1ZXYySnRVSFYzdTZFL2RvMllIUmlVNVB2NzByS1lQSDh3UVFja3VCSjRp?=
 =?utf-8?B?ZXkxSG5Wa1pFQXNwOG13WXJ2QVRkV2RGMC8vT01nRWZTbVYvZ2FFZjA4czQr?=
 =?utf-8?B?eFgwUkY2cTFOV21vNFBMMjh6d1FGL2k1Zm1aYWxNdXhkQVNOQzhnaXRsN01W?=
 =?utf-8?B?ZlAwK3NGbDB2OWx0UFk2K2dGc0s3YTlsNHB2UlJiWmRyZEFRWXljNmgyclRQ?=
 =?utf-8?B?eHNkcSt1Qm5lTUhyUTZaWGsza2RBR1M0MHVWSTVJczAraXFFNTg2cUJaYTN1?=
 =?utf-8?B?VnV6aDBwbVViOU5WQmY5QlFqVUhpQkhmWU5PWnkrRytFSkpsMm01WEtGL3FC?=
 =?utf-8?B?b2l2SnY3Z0l0ank2cGJDYW9RUXY4cHkyYlN3dFBYRDIxMHBOblRDNUp0N0t2?=
 =?utf-8?B?cUJDRzY5enhVSUZmMndUM3U1akoya1FlNGFwMTAxdXdDbU5lY2NCUjNYNGNy?=
 =?utf-8?B?Zi9kYlg0OW1kV2VyUVl2K2kzQ05CN0FEcm52aEMzb2hiV0hXQm1zZ0RUSXFk?=
 =?utf-8?B?d0YzSXhKSnVjdnpaTDBiNHNxNzVqejVlYUZrVCs3L0VqS0F3eW51enFTbnZo?=
 =?utf-8?B?U1hCVXNNcnczQzNjNE5mNG5CL3V3bEpybHV0aWUzN01sc0pHdS9rbUtlY0kx?=
 =?utf-8?B?SEtlZkJjMExiSkovd2tvRzhVYWVrT2FrOVpIVUNmRGtqcm9HaHRac2ljbEkr?=
 =?utf-8?B?YS8rMzA4UE52ZEFTWVduNlplYmh6ekhhSlZGZE1ZSUdtSVhSeVJnSUJ0R1Yx?=
 =?utf-8?B?SkxzcFBaZDU5cGw0QkR6SEpQblNkMjlPbmVkWEZWR3diY3VzbERxdjBydUV1?=
 =?utf-8?B?SUZQWFFIZjBOZExtTjBhbzBudzNzVTEvaDRpUjdHaVhjWlRsUGRtSDdSQ25Y?=
 =?utf-8?B?MExscEhQYkVHZmFuVDZpTXpRdWRUb1BuTHRKeDRndldjNmRPRG03QU1sa0ha?=
 =?utf-8?B?M0ZzUmNWazFoU2R3aWxRaWV5WDhBTGxtVFA2MHNjNFBZVURYNlZZV2kzZzdM?=
 =?utf-8?B?L0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9738dfd3-c8c5-4003-5115-08db152d1c3f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 23:32:49.7180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pL9cOLXhc37AiJGnPDOnsDgvgnrpFq4//b6IHPRCMz68wBdHdZUXPmvieIT0nx60ol0ujUSzYkMebNA+Gs9ZhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5649
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



On 2/22/2023 2:28 PM, Dave Hansen wrote:
> On 2/22/23 14:07, Joseph, Jithu wrote:
>> Since the trace has to be explicitly enabled (I thought it is okay to
>> add a more convenient custom one only to be enabled for detailed
>> analysis when required).
> 
> 	man perf-script
> 
> You should be able to write one to do exactly what you need in about 10
> minutes.  No new tracepoints, no new kernel code to maintain.  Knock

Thanks for the pointers. I gather that user level tools might be able to format the
msr trace output in a more convenient way (perhaps as generated by the custom driver trace)

There is still the other convenience of not having to look-up the
MSRs addresses corresponding to all the individual tests and setting the filter on them to
analyze IFS test activity (rather than enabling it via echo 1 > /sys/kernel/debug/tracing/events/intel_ifs/enable)

Agreed that for array test it is a single MSR. For other test, it is 2 separate MSRs ... there could be additional
tests in the future. 


Jithu
