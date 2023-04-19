Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0893D6E7F3B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 18:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbjDSQLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 12:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjDSQLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 12:11:30 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D491980
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 09:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681920688; x=1713456688;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zdraRXxHYjR1KKtg3zrWF9LWEuVtxAZ2KaLse1zyw4M=;
  b=LjWsp3oVVX4U5dowKwh6u+4tqRNd1zhZnSNNDk9Fc/sXkyIGLPv3A233
   4/a/W7WqmRojFdGKAV9B8juS7CtUnBFdZLg5yeEMAPHeezpf3btB2uoYD
   jh2cnYoJZMXg+g9KFcN8CT0b6EBa/ULido7+UBIngUbag01alaudUDAqi
   2YQ4aqJpbRA/pJkUv/B6TXZzSX8uLI34+iot/lie+149SAMq3UgqiFeG3
   UL0cjWiw+yqyd4YoIxgJGKCWSDWsQBK8U78D7aI0nYcw9mChe5qgsumFQ
   kCKo88MHpLItbsxvfaSSHnAP9rqJ9tUdA3pLQApIooMXb2lj41MUOqp3w
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="410720862"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="410720862"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 09:11:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="691558132"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="691558132"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 19 Apr 2023 09:11:28 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 19 Apr 2023 09:11:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 19 Apr 2023 09:11:27 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 19 Apr 2023 09:11:27 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 19 Apr 2023 09:11:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lzi4hEm8HNjao0Wn61F7HxVakg6Cv0G7/5wUpUxS18m40rd7NKgtJp7kJJozCCiJF9fCytLaWZJpaAO7cxmXjQ8OyqYZ1rqAzTwyiY47405pzcToDwxM+zBPvAQ1oj7FmbZcpnFpCNAr+X3y3uxSEX1BoXFN8J2Pz0wqpVa3xIziJGVwDduGCWW4Tf0cGCTOQYY2Bi2ubFKYQhioXPesqT+T+AoXpjw/cDd5nLzN2K8Yi4bIaaBS5+FBOq1rXs1g1USzEaaeboyBLKoo+S4jn8JAT/+Hn3bHg24MHr6SMZbmXSfe1Ipm856ZtVPsrVdGm38U1Mt2bverzgM9uv8CRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AszBTAONZDJOqxq/JtYZD9yL+wDA+UEjHoxClVlROwY=;
 b=j8eRHvoAO/x/C1CuApenw+ia4oNmGUNRdv2aSOxCrzEAJuK3yvtiwcsj21pbkWcq8M8/mfOfGB4UMj/L9AnuSsPRrCBqCOmqEky72hFSDNVMC+DC1Mb4WdEkaxTnr5z7fTHPgL75RLam4ZqRAWKq6s95pl+I1thk4qD2vxEmTBj28aJipVj3hRjVLMP7UJ96+XK+f0qxjUP3BVQTwoG/UFdxUGOgS4rrW8bgHy1s+5Tqj7Zx9u/z4NKljX+QZ0QoqzLpQJ72BzkTjFyvr6TzOS0Sb6cXUq0GWQnvBt0CGrEF3z9xwrByd1laOgo6XqTcqKHrfn3t3VaW3/mBTEPM+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by PH7PR11MB7717.namprd11.prod.outlook.com (2603:10b6:510:2b8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Wed, 19 Apr
 2023 16:11:20 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::4bd:cce2:58ce:cd6b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::4bd:cce2:58ce:cd6b%3]) with mapi id 15.20.6319.020; Wed, 19 Apr 2023
 16:11:19 +0000
Message-ID: <2ad5f754-e0f1-899c-b7e4-0f35f47fd50b@intel.com>
Date:   Wed, 19 Apr 2023 09:11:15 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v5 2/3] x86/resctrl: Implement rename op for mon groups
Content-Language: en-US
To:     Peter Newman <peternewman@google.com>
CC:     <fenghua.yu@intel.com>, <Babu.Moger@amd.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <eranian@google.com>,
        <gupasani@google.com>, <hpa@zytor.com>, <james.morse@arm.com>,
        <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <skodak@google.com>, <tglx@linutronix.de>, <tony.luck@intel.com>,
        <x86@kernel.org>
References: <20230330135558.1019658-1-peternewman@google.com>
 <20230330135558.1019658-3-peternewman@google.com>
 <678ab8b6-9465-cdeb-da65-448c0cf075f5@intel.com>
 <CALPaoCh=1Qq5sqWpY8We8zykmmvk81YVnigtZftqMH6FefnQjw@mail.gmail.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <CALPaoCh=1Qq5sqWpY8We8zykmmvk81YVnigtZftqMH6FefnQjw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::31) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|PH7PR11MB7717:EE_
X-MS-Office365-Filtering-Correlation-Id: 26ebb8fc-b714-4709-5114-08db40f0b594
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jx/9ZN+b4SpZF1Xqq6PRvzsyehJBs7yxNjz8XjyLMi2tXBACL+AGlNfkPltxoLAzzSsfdwa8+WCySkEFCrzk0cgPUFu48D2CPsx0fW+LOZMzzcbFhIS++r+nh5T70OEvv3kjNeHDrh8zMwGQtYwb4/qgFafBvetgaxec3m2t30zpfC2tjtUx8edvxGqHzi26hxXeLp+8u2ilq/sXUVHpp1v7w3Pn4mQBpjTWTAS7gGv9Wsl7Z2O9VHm8lOFvfhKozOyfzIwv2Fm9q5N6z8P76GHC/KUtClmRqO67L/bgFHofn1sNzwxqNy1RXzrGMvtLajdsHComa//4XBFogCNvceRW6eZ4D9XhpGyw9mz5oi/YxiVU/AKarazwghkpemxf5TykfFUBF41VZ9yB+4DKIzJMMP5jdlDSI1o/sKBB7u+pj5lJ7Ya/jOc1xAm5TVUuTng04K/I6weS3oVX6MsENMCnhmytHxXFH471zzn972moEmrw/Kp4xTuRQQEO4P7v0F3a5DFHNcACYvP6Dtn5wpy1BkvrA8p47eC1mAWJBG/IF/xa0Ukw+4IV5U0VcvQmitrv2Z5IbygmuM6hHyHjvIptkE5pjvQhLNbMgSkO1onid0fow0ZHvHAw7B4Fyfh4goB0/O7dTRT4ieuUo0fo6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(396003)(136003)(346002)(366004)(451199021)(66476007)(478600001)(6666004)(38100700002)(8936002)(8676002)(316002)(82960400001)(41300700001)(6916009)(4326008)(66946007)(66556008)(186003)(2906002)(53546011)(6512007)(36756003)(26005)(83380400001)(6506007)(86362001)(31696002)(2616005)(31686004)(5660300002)(6486002)(44832011)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkJnMk5ERUZzUU8zVWVHZjRpWjlOZVZvUGJqbHBkazFmR3ZaSGRDMFhURm5k?=
 =?utf-8?B?OERiSW1ZcU43WGFkNzFuNFlpcW9MUnNZbDZNd2h6bkYwR0VSZERMMkpYa2o3?=
 =?utf-8?B?cVlzNE5CZ09sRU5hdmt1NHdOL2ltdUVhMUJOVHRMWDRTd2hvSTBhWmw4R21G?=
 =?utf-8?B?YWZGVWRZaDVGZytPaHErSnVZOFF5czNMNDVZRWNCaW9mVjdVVmxPdk9oVTBw?=
 =?utf-8?B?TUN4ams2Wk0xM0hqTjJ2QWtMTENkb2FNQ3g3dzU0dWY3djZKMHZwdndaRjNq?=
 =?utf-8?B?K3hPQXA2NFVQYTZudE5BUENkSjhTbFFkbCtUQ3h1VWtFOGtHNkFiZklibG5y?=
 =?utf-8?B?c1I0WFNuMkR6dmhhV0tGVHF1Z05vUjJVZk4za2d2blhiYWowcmJGTzl4Q2dY?=
 =?utf-8?B?TjBXanROZmJEYjJETUt1djBZV3ZJbGlqbmQ0UDV0STl0KzB5YWMwNW91bnJp?=
 =?utf-8?B?M1l1MFFTamIyeGZocU9qZmZlVldBUGtrTGpqODZYQnpQWGZQTXpzZ0FYN1ls?=
 =?utf-8?B?cUQ3RnVVZTNkeXY2V2RhQkQ2ZWRpTmxuRW1NY25Sam5DRjc1dG41WG9qR3FC?=
 =?utf-8?B?bzlzZ24vVU5LK1lOWU5sMTRoZ1VWQ3NPK1MwenRiN0RrYTVGS0czZndxd3J6?=
 =?utf-8?B?eFl3VnFMQ2RuVllMMUg5aW5EdGhUOWtJNVE5V1FRUGZucDNneTFiNW1CSnNr?=
 =?utf-8?B?K21tTkhDUmQrMnpPdHBvVmU2d0x1YXBLeGE5cmZVcUl4aStiUEVrUGNIWlFD?=
 =?utf-8?B?c1Jhdyt5Z3F5Vmdhenl5OGowZS9nOWJadi9aNWVpS3ZUSCtiOE9CUWprWERG?=
 =?utf-8?B?R1dJTmtmdW41R1pnZU0xdGV4RE5JTkpBL09DQm4weURqSDZtWWdyeGFzOWtq?=
 =?utf-8?B?ekNPeUJvRnYveXAxeE5hdEFJT2xFbGk3VDhrcUhwTG5oYVJJMjZORzA2cW1T?=
 =?utf-8?B?d3Z1YVNrbkRXN1R3dW44OTZKN1h5dEx2MGhJSDRnUHBMdWJhQklwNW1kY1E0?=
 =?utf-8?B?dXY1UXhyajVlWkRDdEp6SXdKblNHdGJadGlyN2ZBaDU2SW91ZnZKdUpHdUZl?=
 =?utf-8?B?dXpOYVRCTWl4bjFzUHdFZFQxNWhBOG5rcTV2Z2xhdzY3NlNPMHg1K0VMdWp1?=
 =?utf-8?B?WERaQWx6RFFvNWJ0RW1pNVU2YnpYaE56dW1LOTdVZm5DcFBvU1JUMVpORmVr?=
 =?utf-8?B?MDZwakdWZnpkUndZUEZTWndhVGFldkhtRnFFY3ZadTNPelZybjltUVVydUNa?=
 =?utf-8?B?dkgyM2x2MEc4elllMDJPWmhyd0owNkZXTmxLeTJ4RTB2cElRUEZlajFsT2xS?=
 =?utf-8?B?QWpuSzliRXVDeUZENWMzVml0WmdIbko2UEpId1VndE9YLzhwUk1FZEtQZ0NY?=
 =?utf-8?B?eDZRYXJkaTVjL3BSbUh6VS9vSHVzQVlHQ0NETE1kVkw3d1RKaXQyRkdWRDgx?=
 =?utf-8?B?VTkxMzdTSTBldmtyVlJ3ZnFYdzJ0RGhVaGVVS2ZmWVNTVy90dHNhSTU1RWZ1?=
 =?utf-8?B?VnRMNlFVb3YwMHV3QXJqUDdsWDlSeHM2RzFETVlvTHJuazlsUVdzZGdKU0kv?=
 =?utf-8?B?TkdYeDU2aDdoNWpqdGdBVVZtYUJlYWJtdWptSU45d2VwSlBlSTRqN1hOcUdr?=
 =?utf-8?B?Z1hGU3NWV3o3ZEJVY3dBa3hBOHB2Wi9HeVZPUHR0cGFMN0FrSDkrSGpEM2FC?=
 =?utf-8?B?VzRnL3dBNmdvdEd3TVVWVnI4eXd2eHR2Q2lHQzc1YXdzbkd5VkJmK3RXdjRB?=
 =?utf-8?B?ZnYzM3pTV2Q2OS9EZ3JNdzNtTW9QTnkrbzkzWS95NWJlMlQ1WmdQQ1o5T0l1?=
 =?utf-8?B?U3U1bTZYRzE2djQ1OThVVFNlUjFDSkpCZlZpNWtiZVFvZnJOTTZyV2Q3djlL?=
 =?utf-8?B?d1hNc0pDYU5tRHQwQ1lyVmRBc0x6N1gwck5JYlNzYnd6cXkxcXhqY21Zc2dH?=
 =?utf-8?B?djZJcDZVRUlRNnJTbFhkWXNuMW5CUTZNVGdicHNtdktweitDaFlWMm5BOTgy?=
 =?utf-8?B?NWw4MURvNVA1b25GUy9MVGsxYWU5d1EyKzcwNjBpUVd0czlHYnZDa3E0bkha?=
 =?utf-8?B?UXpRZU85RkgyazQrLzF3c2lLTGVuL1VBV3VZdVp4dnlUcnpqaWJzTi95WGkz?=
 =?utf-8?B?QnlnTmNPZzFXUFNUT2trMDlNYmFzM3VSSnhkWkxkYWpCY2ZGWUc0V25MeVJ5?=
 =?utf-8?B?L2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 26ebb8fc-b714-4709-5114-08db40f0b594
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 16:11:19.0211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jKXyb7pZmx5tOr1pd8ONFQ1yZ+7Fv6VfukxguC6tpQlYe6lLj9fVKuVEJXH7Pt7fg7cp9Vw8Ej4faIfAxjMuSSXvwZzaAX/hZskSQvI2A4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7717
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 4/19/2023 2:38 AM, Peter Newman wrote:
> On Tue, Apr 18, 2023 at 11:53 PM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
>> On 3/30/2023 6:55 AM, Peter Newman wrote:
>>> If a container manager is additionally tracking containers' bandwidth
>>> usage by placing tasks from each into their own monitoring group, it
>>
>> The above sentence seems to be missing something after the "for each".
>> It seems to still parse if "for each" is removed.
> 
> Did you mean "from each"?

I did, yes. Thanks for converting it to what I intended to write.

> In any case, I'll further disambiguate to
> this in my next update:
> 
> "If the container manager is using monitoring groups to separately
> track the bandwidth of containers assigned to the same control group,
> it must first move the container's tasks to the default monitoring
> group of the new control group before it can move these tasks into the
> container's replacement monitoring groups under the destination
> control group."

Looks good to me. Thank you.

Reinette
