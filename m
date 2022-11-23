Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01CBB636624
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 17:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239197AbiKWQrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 11:47:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239169AbiKWQrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 11:47:07 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19891BF5A3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 08:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669222027; x=1700758027;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9dU9vCqaoBKqWYz7SlLzogLoDvv4Fzvi5ULdDrY5tf4=;
  b=FyRevW8IRQTBNAIicepd62WKsDt8lzYcwOJieWtEk6UXIa+esHmL7xgd
   QL7hhtSRfycq8K7qsJ+ii0fklMVKauGs2SpnUEiSGtCIBU7Sxx1T1Mosl
   FTCviGCgrwQBndZujcoqhFR/hXsW6jpPPVD3thFAim6f9lscygDuvKahh
   2A4J/Y+lWp1opunuHTkQFzpKXCFhQC4En7gqddGarjua38yFkPGBUUeiK
   uIEJU8BbjVgWnGBFDNApj1kvGDB8BvGDnaMoLXNXdPpKbIngiJUtvFp9u
   933zPHb7mRXd5lvB7fGoCjpwFDk8i14aKVcw0befRgO+l5Sw28GA5TExj
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="312808064"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="312808064"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 08:46:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="619682689"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="619682689"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 23 Nov 2022 08:46:58 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 08:45:50 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 08:45:49 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 23 Nov 2022 08:45:49 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 23 Nov 2022 08:45:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQfBbx3i6NkJH+vGPY80xpoUY+7WY/Ax/+uW0YXsh5aFuyHRYAH1LobETDK48L4J7uOYMkGP/tzRWlkzPQmyDkb7Nd7qw+0dVMyfx7+v/50yHLMauJsl8lsmhhcomEbrdEAXApOPI3niXFCHMRAH9jNacshGWYSzOB4Fk9IOu20ZUFtUANc3WPS91qqDiPcZHKrBcVMYzQ8/RdeLcoEx9EPiEWf6R+vcDmTeod8v3f7MqE5NinlntNKzhCetT+zt60hVPHNoI6IirSoymf30OV/Q2MQFoPWPJtefXbQ3y+vs6wSJcwSWnWaj1XMYt5W7WIta0em+bCtF7BNkg7M75w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOxCcIGuC5ywZadokTirr1/2WRtbpjLA2CcDAyE1bE4=;
 b=ZMAZKAJ4fu6dcdX6I43nExAgt+ZWVzLY/W6cR09vGJbXDtQMjIrgs6x4R6gqrb3OLYQu2GLq7Ct5NrlJkKAFNdNClbALQXWIGXWNq7lsEQUg3TgdJS+wt/sz0gg0NxLv70SiRdTLaxtnzGCIXSxqT+VQsuTK+Rkkyj+Nxevb/wsJs0f+PUaWbo5hub3w8lhJG4FRKJawWNKQQiGB5cQEZYdRV8vi7YpCNdBwV7BXlVZOytH0qhqYrsnxgyJl5yPRlgx/dASLWrc2e72tKPDNcrWe2Oyo6XBDTEsdejZO2VTJJbKMKPUWxKJTJZHnjmw8T4SbZK9N76KVnsrtzuu4LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DM4PR11MB6120.namprd11.prod.outlook.com (2603:10b6:8:af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.11; Wed, 23 Nov
 2022 16:45:45 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::6005:96bf:e2e1:2f7a]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::6005:96bf:e2e1:2f7a%12]) with mapi id 15.20.5834.015; Wed, 23 Nov
 2022 16:45:45 +0000
Message-ID: <1b130af3-65fa-5a1c-cd07-5d2acacbd26a@intel.com>
Date:   Wed, 23 Nov 2022 08:45:41 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH v3 1/2] x86/resctrl: IPI all CPUs for group updates
Content-Language: en-US
To:     Peter Newman <peternewman@google.com>
CC:     <fenghua.yu@intel.com>, <bp@alien8.de>, <derkling@google.com>,
        <eranian@google.com>, <hpa@zytor.com>, <james.morse@arm.com>,
        <jannh@google.com>, <kpsingh@google.com>,
        <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <tglx@linutronix.de>, <x86@kernel.org>
References: <20221115141953.816851-1-peternewman@google.com>
 <20221115141953.816851-2-peternewman@google.com>
 <54e50a9b-268f-2020-f54c-d38312489e2f@intel.com>
 <CALPaoCh9e5PB+fx2k6qBfOjduA01Rr2ZxdJFg4oocJtJ0aSYjQ@mail.gmail.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <CALPaoCh9e5PB+fx2k6qBfOjduA01Rr2ZxdJFg4oocJtJ0aSYjQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0095.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::36) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|DM4PR11MB6120:EE_
X-MS-Office365-Filtering-Correlation-Id: dd7db666-787a-4ebd-ff51-08dacd72299e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zyy1DAhjteakzV+GgQ6vCRwMErvB9ecWTFEi6uUlh0n6dRgwms4CpmQpkd8hFHT0INQELyfLaC/955eFUyCEkPUHY+ZXCJ/7IsHDJvv1X5OIaXNlQ/CHP+ddNCUm1uF9nFKIo2cVaIO1sz1e7fL/URizMIkzXko9Mz/dvXMuKSnNGOmNESOU2OBFRZ3RhWRbLm8fvZiWtiLaT9zG+STbZXPRBYiSn5KZa7flZAvaxJojM4rDeWhVC8BPaGgajdc3EkVoGz9AtTmCg6P1vO6NPWBMEJnSJMcMQN1cZ+2sSSfNhZNx8H3IeB0LZH7XHixe8DwlAKYHBQ0j1YHB//m009faclqKLu4FadvmAm8bLVErFCyoGMym5Fb/ScmU8Eg8oY+MsEzw7I6O58uZQIp5E9KbnX/z1yen5VliG27wcq7XpzugH7bWSHru9VVBGzMnKK+xWCrQtKQxnKDjWQ+o34SLgnOjTg3dK1P7rIoOUm/w6BSRUk1+oCSiCuA2r3fckE3MhqAHvz9ZTvL1WRLQ3+2GffMZU8dEfDQXmgMvb8UUA+Lax9mIITUmdDLODVHpvdxYxI3aJqZi/71R6TMhPfkjozqFM836pypk/AMs6xALryS1uN6+wVsFR/yKU2mwM8AR9r1XClxgm+pGCFN136/HLk5uN60GnZW11MTgcuRC/uUF2+Hk2yhgq9bXhzB99SsaGr+4/aHSHP/F3arXI8Px3YoypxvzFxnE0qp2l0M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199015)(15650500001)(31696002)(6666004)(86362001)(2906002)(6486002)(31686004)(53546011)(6512007)(6506007)(66556008)(2616005)(26005)(66946007)(6916009)(4326008)(8676002)(316002)(7416002)(36756003)(44832011)(83380400001)(66476007)(5660300002)(478600001)(186003)(41300700001)(82960400001)(38100700002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHpncUV0RjRvdkdna3ZOVGZ6UmxlSHRGTWpLZk9YOG1zTVJnQjF0YWk2SlFt?=
 =?utf-8?B?OXZ4MHROLzB1UmI2V1VEWkc2bWdHdCtjc0R6aWdqbGx3MHNQczRsS0dPSkxw?=
 =?utf-8?B?czNrdzJuSGVHOUlFb3hqaXBwTW92UFVsS0NYOVRmaHNHeWZTODFGQmdSSXJa?=
 =?utf-8?B?YlArVkM5QmdZZktteXlaTDFGQ2hYZGEyRkE5RkRZYjh3QlFaVnVUSWJjUUFN?=
 =?utf-8?B?UTFCOGNTR0x0cUtkeFNEUVA3MEppQ1pReVBmMnBrSDRmQ0N0QXF4cVZQeWcz?=
 =?utf-8?B?RXg2N0J4VlNicjFmRy9HUUQ5ZFUzTCtZYUNHU0tCMnFFMndBalpkRkFwdGVz?=
 =?utf-8?B?b0ZkbW1QeWt0b2N0Q1NaUzhObTBvKys2c0IrZElEdVIzbXVDMDdYM25ORGQw?=
 =?utf-8?B?R1dmKytNWG5CSVQwczBONE80ckd1OWx2bWVWQ2o5Z0tZeTJ0WFRkSmFhNlhi?=
 =?utf-8?B?REFKYnRPUk1IYnpvakRzYkZHTkRDTERXVjlZdFNtdjVFU2d1RTNTdTkyYW85?=
 =?utf-8?B?RW5GelZyc0ZMODVTOVNvVFdEU3RkS0lRdTN0cmk2RnRaQkxoWWUwRFp5cHVq?=
 =?utf-8?B?N3Mxa1I5SXZEVGNuTnArdHdZZVVGMTFrYjcrY3Y5UGVId1pKdlh0TFlTR05K?=
 =?utf-8?B?c3NXNTB5MDFIalhlUTFjTzc5Z0tBc2FnTTg5Wkp3SUhzU3lUTWdwcFV2Mjk0?=
 =?utf-8?B?bUNRWkpGaVdybE5uSEhwZGJkaHlZMDBsQnVVdHFOdmY2UlNLamx3Z0Naa1VH?=
 =?utf-8?B?UXhuaFpzN08rZU1XYjlxbi9IZlJtMlY0VG1jZWJKQ3l4WDFTN3NXWnVNOEV4?=
 =?utf-8?B?RWdGNzQ3THlJaDl6Y0Y5S2haSEMwSUVOTmFhNG5wMEkxRTduTWxnbEVSTFBj?=
 =?utf-8?B?Y0VHUnpNOVB5TmZjSlljcENOQ08vY2UzK0VuMmRhMzR5QUdZaWF6dDIrTUpu?=
 =?utf-8?B?UFpxSW0ycUhKWDB6ZjJBNjJBS2ovOUhvTUc4RVFvRytQTmNZWFh3ajY5R2Uv?=
 =?utf-8?B?NHdYc3JXakZ6SGM4Qit6MFUrZ1lnc0YrOVVOMWpvdHNOSFZ4dEo1VHlmVzJK?=
 =?utf-8?B?R2RaY3cwR29xSHJaRFdJc3VaQnFKSHJlUGp6M1ArN3VldlhmdG1QZmR2Nms5?=
 =?utf-8?B?THBQa28xaDJ5cjQyWVdVRFlURnZ4c0hQbU15RUtrUkJSaEk3T0UzWmhxRVJj?=
 =?utf-8?B?dHRha2RjTFRpdWd2ZDRLQXpkblU0Z2VEbmpxc2hnNDBlbnU0TmdnWHFtZWN6?=
 =?utf-8?B?bGsyUTNOQW8ySUtsMjhRRzZYNFB2Smw4OVBkbU1GMzNCTmVXMTVwc29pcWYv?=
 =?utf-8?B?RTB4UHVETFp4K0xBTkprUTE2T1oza2RnL0pqRmZpVWsyT0NQNzhReS9KNzRF?=
 =?utf-8?B?Q0VaWkMxRXUyVjhhUkVINXZYV0JsNzRsQnVwa0Nic0EreXVJQlpSQk9rVHRL?=
 =?utf-8?B?MVhVQVRjVXBlY2U3NHI4dFc4endIRUpxRXJscVJBNWZwVTBkWmxXaW1yWlRC?=
 =?utf-8?B?YVRNcXVwVExUNVBTR0x5dTJ5cU9aZlRERUxvTndPSWZsMTJ5Sm1qUGIwZDRu?=
 =?utf-8?B?b2x3WHJsZnd0MWk3TFhpSGxueTdBUVdwejVNeUpSUXdlZlI0YnhQQ1B4T25K?=
 =?utf-8?B?Z2lHMEZZRjUwVyszUkFYOEtGRDNWUlVZc2JLV2hQZU1acFNYQnJTM1R6UTNU?=
 =?utf-8?B?Y25ldFNLS2k2YURZZUQyWCtRM3pXTEZIVHY0bVowZEdMYWxPZU9FeC9wM3NP?=
 =?utf-8?B?YnFEYmcxVkkxbGtHREtXODlrVVBaNU83TzBjYjVRYll3UnQrRk9RRTg4aG54?=
 =?utf-8?B?eUtTcmxLa2FwS0hCNEhTdXBLT1M2Ynk4amRaYTRUWWUzcjEzTHFyN3BnZHJV?=
 =?utf-8?B?QlI0WjhKNndKYzBOZ2hZWloyTXUvYTJyNko0Wk5xSEg5NzJndVkrRytRaTdh?=
 =?utf-8?B?clA3a2ZSK05jRkdqblRaeFR6ZmM2Sk5PcndORGxDM0JFWWFMaHdyQ0ozWHRp?=
 =?utf-8?B?MkxvYkcra3o1UGZoNERpS0FjcUZiNXI2YXozMVRPUGs0K1hTbzZBdTBQWjRq?=
 =?utf-8?B?MEJoWWFFWmU5ZjNWZFZUdEpMUm1PSUNYSXhLYWhhVWFPTlhEdFFUMGN5VGxX?=
 =?utf-8?B?alBybkFWN3FudTZHaW5lNzNYWi9JU0tNZStKMkhXaVl2VGU1ZUhuMUk5Nnk3?=
 =?utf-8?B?UVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd7db666-787a-4ebd-ff51-08dacd72299e
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 16:45:45.1628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: olo1zkuj49m+qlEVo+R8BtS8ecfyNVYe+7ak8Mj++qr3EaOUZtUCdMBXjx0SHu3MqsI/OMc3txf8xWPF5th4AMVZsMX5J9S3t7jHoUTjLBM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6120
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 11/23/2022 3:09 AM, Peter Newman wrote:
> On Mon, Nov 21, 2022 at 10:53 PM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
>> On 11/15/2022 6:19 AM, Peter Newman wrote:

...

>>> search the entire tasklist for group members which could be running on
>>> that CPU. This needs to be done while blocking updates to the tasklist
>>> to avoid leaving newly-created child tasks assigned to the old
>>> CLOSID/RMID.
>>
>> This is not clear to me. rdt_move_group_tasks() obtains a read lock,
>> read_lock(&tasklist_lock), so concurrent modifications to the tasklist
>> are indeed possible. Should this perhaps be write_lock() instead?
>> It sounds like the scenario you are describing may be a concern. That is,
>> if a task belonging to a group that is being removed happens to
>> call fork()/clone() during the move then the child may end up being
>> created with old closid.
> 
> Shouldn't read_lock(&tasklist_lock) cause write_lock(&tasklist_lock) to
> block?

Apologies, yes, you are right. I was focusing too much on the detail of
task_struct::tasks being a RCU list and lost sight of the actual lock
obtained (rcu_read_lock() vs read_lock()) in this instance. 

Reinette
