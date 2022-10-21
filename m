Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2818D607F84
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 22:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiJUUJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 16:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiJUUJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 16:09:35 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F262558A
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 13:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666382973; x=1697918973;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fJP/RQVs4CJ967AHBwK+wnmIZQr8xgctBhEbsbFZQLw=;
  b=IdSy+JEBbLxaCE3o3kISYugPTpfq7hE8kHXfkHtjParFgbBSS6sIbjNQ
   LBsIJbJBPz5Kl9M6zkXgGPHuw5Y3hu14fxpgzYxS48Y/BQKxfccycVkuA
   pLUZiTOFGRlRf7YVRcFwRX/ENIl3m3bxYuScpONH3Qu7KMBx9LdLr6kwZ
   h5s2mvjpmOJHZxT3Ds7nv7sh3sM4TVWKmhyuLnsGJlmwdH9fxp2sbWVZQ
   EVuGzZRHQD+ke+qiHU7zFgfoMLP5TU5kwk0323fmMv5pBHl64Z10j4qjx
   B1dXALkLOzzXnaWozXtns3+e+HENYwYFiR9vllaExQPCbiNiN8WqyuBl0
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="369155023"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="369155023"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 13:09:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="773190921"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="773190921"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 21 Oct 2022 13:09:32 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 13:09:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 13:09:31 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 21 Oct 2022 13:09:31 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 21 Oct 2022 13:09:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CxMyldFOR8fNdcu3Gi/xBLDe1NwfYf2ZhjMwUmp0zf0GtiLKEsIhy7J6iKh/2FVPw8Z2KbQwLczK2Y6LGX2NHpAoarhpYvKZ4P6YBDFar8JTECz8X+ns57/PJugVW8m5xeQK2ZXrHclluv5IoRy2QFjo1uxPJoTdcers5rzdG4fh+4UdcM2T+unzjaH7p06dZQzmohhg0Cux5/GCIxAxWiHXI5NwGTzag+idV603k5O05hWbjNeM32gwPW8rq2YDVWEMdWfo6yR2V+C0igAgEt+JESJAMZyyoHgWrXJwN9cL+Dah0cU1nYWgZirD5IFOsnvRtPTPKIMOJrixzGyamw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5bJ5+eBA2cBY07W+SSwD8PJsLrLh4g60dkn+mvxnNuU=;
 b=Uxb40q07NquR9QIZh+OGniDvZlZmXH4KqbQr1qBazmlJ/U1j4voW/XdXWItci3NvMIZIFRCBlcF51Dz2Te97cBdYGHJBYs66qEiGsBWMcsPRqXTeMTcvR4AdZok7r9UwTxv7Nof5BP+Cm6xhgDpFjdI0ZFUJ1Um6AZx6EdT8hs7weZcyoIdIiQca1HP96j9whsZ9dePPxpNfVjxIQpG06tP3BFDzx0Cmc6jtLjULXc2yEloTtdAt3ychv4vXfPAPMhjQi/tIQrU+VOhTrdJm7SNpuKmuq346BRlnAX6aTiYh0gJiW215m/Az1pwsL0hv7lTyjkv5ZTrPRPTyQa0M4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by BL1PR11MB5461.namprd11.prod.outlook.com (2603:10b6:208:30b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Fri, 21 Oct
 2022 20:09:28 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%12]) with mapi id 15.20.5723.035; Fri, 21 Oct
 2022 20:09:28 +0000
Message-ID: <09029c7a-489a-7054-1ab5-01fa879fb42f@intel.com>
Date:   Fri, 21 Oct 2022 13:09:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.3.3
Subject: Re: [RFD] resctrl: reassigning a running container's CTRL_MON group
Content-Language: en-US
To:     James Morse <james.morse@arm.com>,
        Peter Newman <peternewman@google.com>
CC:     Tony Luck <tony.luck@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Babu Moger" <Babu.Moger@amd.com>,
        Gaurang Upasani <gupasani@google.com>
References: <CALPaoCj-zav4x6H3ffXo_O+RFan8Qb-uLy-DdtkaQTfuxY4a0w@mail.gmail.com>
 <b2e020b1-f6b2-e236-a042-4eb2fd27d8b0@intel.com>
 <IA1PR11MB6097236CFF891041DBA42ECB9B5F9@IA1PR11MB6097.namprd11.prod.outlook.com>
 <Y0BhzKkksSjSeE3W@agluck-desk3.sc.intel.com>
 <81a7b4f6-fbb5-380e-532d-f2c1fc49b515@intel.com>
 <CALPaoCjdeRjyX5L6BBX688ZM21eMwetuL9QLF1+GEDUskGcU2w@mail.gmail.com>
 <76bb4dc9-ab7c-4cb6-d1bf-26436c88c6e2@arm.com>
 <CALPaoCiKUQC+LxDwKQ0gE5AQniJi_nbzrXi_HA9ZBRtiXdw_dg@mail.gmail.com>
 <835d769b-3662-7be5-dcdd-804cb1f3999a@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <835d769b-3662-7be5-dcdd-804cb1f3999a@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0001.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::14) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|BL1PR11MB5461:EE_
X-MS-Office365-Filtering-Correlation-Id: 11549ea6-1358-43b8-3712-08dab3a0289d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lz5ZNaBd3me14/LuxFQUjVz/JEihOAR6z050UNtyRnnbRa8ufJERbBSx0JpJEunCkeGY0OvrozuhcmsfD86y/OM5o2feCJPwW/fGu3yOm/V2GMQxdxkom/WKd8dtC0mT2HdaR1bf3sDilWYOS0U/Ei/pfJkxxcUD/zzNW6Ck3FTXWb99X1aU6ISMCcVKii2bEqX6WZeFkPqAmnifmPK2yHLXctbQwSd7vvyWMb5YdS2utXsPot4MQXZqVWv1HAjwLe4S1aoy8H9WD1nG5L5Uyr5AVxrplDIB2boFIBqiVE2THHBaEyTsmNH/bHyQHohyQxWIJlf92dzu69a2devFoNzbDXlNh+4O7wn3GJe968CTy66jComOBLREpiEB/tpteNXZXMwBNwAqas6yH8EZdHTWmuJJGTH2d5l8p42WAbmFYLrTABEqebVMBgWVt6pjSZt766FCjp+Ed6g4ML0imqGgncN/kOnBIupT5QKlpTfaZhrYY4wwP52u+NZPi925WWu04qwlYS25fXg1IvU7IQSr9g6R5u5Wfl6SB3oXxvg1EX5iDqaXzKHZhNGPnVoFOAjrw7SrDUkqXMTCMYxUFopNvknchdC1e/uf/2Kn3x2jcjcaLuCRp7Q8iyJwHOiNoMOXhTo7IlBHs+V3BgJBkZ1imQ2SaJi5Je2/noVEBkqLDvmTJSkEsG3ijpBBToaiNYK+Keq+YKI873qZOvJ+FymX/dykpCdS7eqsCoi2ndWGGK7cFcAoXXJyPjvuYgn+/zmSSBTW6Gt9KMmcmNrMqScRcSa7MJwGLtcrBx3d0wk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199015)(478600001)(2906002)(44832011)(31696002)(66476007)(186003)(41300700001)(38100700002)(4326008)(5660300002)(82960400001)(8676002)(8936002)(66556008)(26005)(6506007)(6512007)(2616005)(110136005)(54906003)(36756003)(6666004)(6486002)(66946007)(316002)(53546011)(86362001)(31686004)(66899015)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFEvaHpDSVJlQThobW9OQUpobnVrT3FadjF5UmNoY2g5cGk5SGtrSzBUeVFo?=
 =?utf-8?B?eG9tS1VPbXJEa0tzWHh3VDIwNmxSSGI3bGJ4UjVPRUtXMXNXbVZ5bHRzdHNI?=
 =?utf-8?B?SzMxSHZwbC9Zc3g3c1p2RFdGRm8zWHg3UXNPZy9PZjdtN3V4bUZEOENUdE1l?=
 =?utf-8?B?TmRiU2tNeEt6TTVMVjJHNzBYbGNja3NNbjk3aHJpbm1QbEJPMzhQcTlzc21n?=
 =?utf-8?B?UHhMRTR3b0pwTDBjOFIzeGttTXo2VlNOclNjalVEY2NVUmRJd2xITkhpa0RU?=
 =?utf-8?B?WGcxYUNMUktQd2hxcmxlVkdQL0hpLzhRb0FzbFhPRmJLZzI4dG1ZTGd1b0wr?=
 =?utf-8?B?WXh1Ly9GdlBJVGZIc3ZEMHVZK0VJMFZjbks0S0o1VGp4dG93R1NLOWRVYVJF?=
 =?utf-8?B?RkZKb3VwenF1RFVvUEtPRWpxMFRCblFnYnd4dGI0cXVhR2NIUkIwQTBDdGJN?=
 =?utf-8?B?U3R2SXlOTVY5OGE3N1VGUG0vRE82YWczQW5QMHVHdVAwMlh3ajR4bW15dndB?=
 =?utf-8?B?SVBqdWRJUFZ4US9idzUxaWZHWHkzWTYrZVlIUEJXdzBBSi9iTDQ1UHdSMndR?=
 =?utf-8?B?eVI0R1NrL3VpS0cvRXRETXFwTk9FUXk4UUkxRnFxVWNqNlpRNFBaazFTRXda?=
 =?utf-8?B?dUsxTmNtY2hFQU5LN2E4NTg2UXpuUUtUazRoQUg5dVNIUWFVajRNTnhjbWw2?=
 =?utf-8?B?djlOMUxVV2lvTkJZUS8vNThHZEpsYjE3NnJMV1phL3JBUmI5WTFMQ0VmYnFi?=
 =?utf-8?B?NDI5MG9sTEJCd3V6QVFURWNobVJkVjVjNmx5Q09ON2U4Q2x3UTJUTGlEdThy?=
 =?utf-8?B?cFRTRnZKUnhJL2Vwa3lZcVBuak9MckRZOEgyOXMzcU5rOUhkK05Pbko5NnA0?=
 =?utf-8?B?bGdkUjVNZGhsRFpXZk96aHp5NWd2WlltTDVTMmZLeDBZcGk2N3N0OExsMC9k?=
 =?utf-8?B?L2RXNUlZdkFpTmZZM2UxZTdEdXM4OGpzZzFleFFZeHlPQ0VES3MwUWZpVmVJ?=
 =?utf-8?B?ZlNObkR0UGMzdGN3d2wvMTRUV1FCQlN5b0M4S0VFL1hLLytaaXJ5WXg3TGRV?=
 =?utf-8?B?d0RZZ0pjcGk1eS9qM2I4Rzd4d0FrRjlNRVIxejVwcnRJYWpKYUxFZmppVVE1?=
 =?utf-8?B?Yys3UE9rS3dUamlPTVZzTkIxSnRWRlc2MDcvWVFkc2VEOGh2OEVmanlvYlVu?=
 =?utf-8?B?OVF6TEVwWFhyV3RZUFZIaC9CbEZZU1ZsUzFvZ01vMUpkYUdzTWhoek1vVDhq?=
 =?utf-8?B?RHZ2T2VJYkNLMWYvK0NueElMWTcrNTVGengvYlNpcFJqM2cyYmt2TklCaFo3?=
 =?utf-8?B?MUxvTk0rcnp3citZTHlSdFBEWU5CWmcrcDRDTDQ4TEl5ZUM4YWJRLzU0cmZL?=
 =?utf-8?B?S2hpZk1pcjUwcFRhS1dJY3NDdndaYVJ2aFlEYTl5VHQwZGFlYkg3b09UQ1Vm?=
 =?utf-8?B?SmtQTy9HSU1CZmI4UGRYT240K1RxZTlXcGQvYjBUQTdYbjIxQjIzT3BpNVQ1?=
 =?utf-8?B?NE9ueEEzUlNBcmF0akxESHZuNjJEeWdldlpxeGJPR3VRYkxZZjhSaE5CTGlB?=
 =?utf-8?B?UUdNQ2hRclpyZlFKaFBGbGd6R0gxdEMwR1MvRmszRDhkS3BGUTRhUWpKODl3?=
 =?utf-8?B?R1Z4bFdCTHZPb2kzWEFJcVoyQWdrcnJkVjBXSFB5N0dRcUZxUXVycHdqZVNQ?=
 =?utf-8?B?VmxKdk5jcGxPS0pKTFNwakJsSVpGQ3dmcXN0MmFCYkg4emMzNzJjenByVit0?=
 =?utf-8?B?bG9qRi9UemMzd0J4c3UrNDdjZnZnZUhlQTMybFJjcDBMMnZIb2RHTjE0Mi9h?=
 =?utf-8?B?ZFYvTzJOWkEzbDFoK1g1STNoTGVJQlBCUnExL2lqMVprZC9RV2NNTUtPWHg1?=
 =?utf-8?B?Wm5BdWNONkNxQmJ1SjYwU01WMEYzTW1OS25DY01ZamJ6TmZuY1hDaXAvQ2xY?=
 =?utf-8?B?QnpQVk8vZXVNWGV1SGhEY3ZqQzNPejA1bDZmTkNTaW9VNnM0MzFPUWdCNUl2?=
 =?utf-8?B?Snp0NmtCM0FHT3JsQjQ2cXhGYUZ6YjA2djRVbWlRMWM3dUpPMnM0N1IwT3Za?=
 =?utf-8?B?MnVkczhvUHBXNFN4b2ZSZUR0cjdXSWVxOGR2UE9oOXBicUFJNCtMbS8vUlZZ?=
 =?utf-8?B?K1NrYjBGaDF5cXdvSk9GUjd4alhiSHJrSTZYT2xQUmRvOE5JRWVBYjQ4TGxo?=
 =?utf-8?B?a1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 11549ea6-1358-43b8-3712-08dab3a0289d
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 20:09:28.6221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r9A/XvL5ryAVGOVxwBu57s31zcOBb2wf5dWMm5iR+VXE/nZcmRjHoKcZl4ZhajDy1YHZ/QwXUTrD09isPIA8CeWIpaOy7RLMSBx0vNV+KKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5461
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 10/19/2022 6:57 AM, James Morse wrote:
> Hi Peter,
> 
> On 17/10/2022 11:15, Peter Newman wrote:
>> On Wed, Oct 12, 2022 at 6:55 PM James Morse <james.morse@arm.com> wrote:
>>> You originally asked:
>>> | Any concerns about the CLOSID-reusing behavior?
>>>
>>> I don't think this will work well with MPAM ... I expect it will mess up the bandwidth
>>> counters.
>>>
>>> MPAM's equivalent to RMID is PMG. While on x86 CLOSID and RMID are independent numbers,
>>> this isn't true for PARTID (MPAM's version of CLOSID) and PMG. The PMG bits effectively
>>> extended the PARTID with bits that aren't used to look up the configuration.
>>>
>>> x86's monitors match only on RMID, and there are 'enough' RMID... MPAMs monitors are more
>>> complicated. I've seen details of a system that only has 1 bit of PMG space.
>>>
>>> While MPAM's bandwidth monitors can match just the PMG, there aren't expected to be enough
>>> unique PMG for every control/monitor group to have a unique value. Instead, MPAM's
>>> monitors are expected to be used with both the PARTID and PMG.
>>>
>>> ('bandwidth monitors' is relevant here, MPAM's 'cache storage utilisation' monitors can't
>>> match on just PMG at all - they have to be told the PARTID too)
>>>
>>>
>>> If you're re-using CLOSID like this, I think you'll end up with noisy measurements on MPAM
>>> systems as the caches hold PARTID/PMG values from before the re-use pattern changed, and
>>> the monitors have to match on both.
> 
>> Yes, that sounds like it would be an issue.
>>
>> Following your refactoring changes, hopefully the MPAM driver could
>> offer alternative methods for managing PARTIDs and PMGs depending on the
>> available hardware resources.
> 
> Mmmm, I don't think anything other than one-partid per control group and one-pmg per
> monitor group makes much sense.
> 
> 
>> If there are a lot more PARTIDs than PMGs, then it would fit well with a
>> user who never creates child MON groups. In case the number of MON
>> groups gets ahead of the number of CTRL_MON groups and you've run out of
>> PMGs, perhaps you would just try to allocate another PARTID and program
>> the same partitioning configuration before giving up.
> 
> User-space can choose to do this.
> If the kernel tries to be clever and do this behind user-space's back, it needs to
> allocate two monitors for this secretly-two-control-groups, and always sum the counters
> before reporting them to user-space.

If I understand this scenario correctly, the kernel is already doing this.
As implemented in mon_event_count() the monitor data of a CTRL_MON group is
the sum of the parent CTRL_MON group and all its child MON groups.

> If monitors are a contended resource, then you may be unable to monitor the
> secretly-two-control-groups group once the kernel has done this.

I am not viewing this as "secretly-two-control-groups" - there would still be
only one parent CTRL_MON group that dictates all the allocations. MON groups already
have a CLOSID (PARTID) property but at this time it is always identical to the parent
CTRL_MON group. The difference introduced is that some of the child MON groups
may have a different CLOSID (PARTID) from the parent.

> 
> I don't think the kernel should try to be too clever here.
> 

That is a fair concern but it may be worth exploring as it seems to address
a few ABI concerns and user space seems to be eyeing using a future "num_closid"
info as a check of "RDT/PQoS" vs "MPAM".

Reinette



