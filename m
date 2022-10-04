Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2365F474C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 18:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiJDQPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 12:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiJDQPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 12:15:39 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E675A891;
        Tue,  4 Oct 2022 09:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664900137; x=1696436137;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sZP+8nP2ChYLKrrz183BVlSY0bI2MIt6fH9t+qvW5tQ=;
  b=HkvZxxncTkhDhedl3qjFyA4UNgZ0dROxSbRoUpIYRPXtq+Jqi+hG1sqk
   ZGL7gfiGv9PSOhdu/2VIka/23bAbqfV5ub28mtv+dhewOnYTeSbQJ6l8C
   NgFzHaOqipOCxz4ifa/FkMtYNNK1VwFnQSTFqZvsN5HttC/cWx4zbKavS
   s4iwMeILPqQ73V9U36juucvuJC9eCN9JyYq/suWs7mpfcgzM+tvALzp32
   MKTvcxY3t/fxRVFq433jMDdlc8ApyTCdjlOruvPiUn6mc2ZvsNdxWBgFm
   i/jb4D9CPgxwplbTpfh6tnlttIyXh/7ooT/r9/wuJX4GGacTTKwYh29Pv
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="286143072"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="286143072"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 09:15:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="728277316"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="728277316"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 04 Oct 2022 09:15:35 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 4 Oct 2022 09:15:35 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 4 Oct 2022 09:15:35 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 4 Oct 2022 09:15:35 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 4 Oct 2022 09:15:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5yOJ6V9/Xw5zikBmbmHCFBkl2V18Nv8umKOPSlCg8oYw3B9BnMwtpp/6QsG774oVXsXfFAHGvevR8T38yp9xTHNvEhYwop3pNt/2jM9eimizA3hwgQPnZsEGKbtJZUyR2DcjNouqEfDXbpAkH7WM8jzKVSZFmrpAIyGMKSWggFmVxmR/dWlu4DLlRhmWsw00tAXxqjKlDISB6LS6iZXb7NIivIIRPHsJiRqvI0ElTWe3FohGXAd2QvsHTYYLik0XcQQ/FwELPPA4hEkuMACNT/zaoyTmslvhuUiolbx2wgoG8RrMpVVPnBFBAFU8JUPNe+Q29GanwSsxiIW+DA1nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0PuKOT5O7/nL5j3VkKZWHpIwt0Z73yyainkMS1i4nI=;
 b=SdJVNALZ5b8RME3QA4oFf6411EZQU4fWOq/z3QE5a17+AZypoPvPeT30PeVk77QGuE6Wpy4HUIoZEcTpwaANSRla318JFPyeocOvCNitAub32DUOH+6rPaFw6EcXKhJGa+C7YnFIIzkOj0RQy68Aj1ZSYS49hYF0vsvc/XUlSterWlX1Phr0zAw/tkbpw6qHINoswNx6dLr4fksx5LwGCbY27WPDnsUt5mLrn5t+6M76oRAXG8gQTfdMD2NX0gZImaG1xdQ8PMOfHT8DdgsVUx1iBcAAQ2OfKdkjbYRiNyuWdEA6yD04kZAbPX9Mp3egmbVOcbC7VnQ862D+G97Q1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by MW4PR11MB5911.namprd11.prod.outlook.com (2603:10b6:303:16b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Tue, 4 Oct
 2022 16:15:25 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%12]) with mapi id 15.20.5676.031; Tue, 4 Oct 2022
 16:15:25 +0000
Message-ID: <c4560cfe-f116-9f9d-1e60-b7ee932fb4b6@intel.com>
Date:   Tue, 4 Oct 2022 09:15:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.3.1
Subject: Re: [PATCH v5 12/12] Documentation/x86: Update resctrl_ui.rst for new
 features
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
        <eranian@google.com>
References: <166431016617.373387.1968875281081252467.stgit@bmoger-ubuntu>
 <166431042060.373387.8454967155095795574.stgit@bmoger-ubuntu>
 <71ca01ad-e563-3ac3-815d-0bbc3814ed6f@intel.com>
 <05f0ff0c-b328-46ac-c1fa-7aac09fbb9bc@amd.com>
 <39c3bf58-052d-fbab-3bbd-029f5507ff23@intel.com>
 <d60a73cd-3228-84bc-dd49-52ccb9fd0015@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <d60a73cd-3228-84bc-dd49-52ccb9fd0015@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0040.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::15) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|MW4PR11MB5911:EE_
X-MS-Office365-Filtering-Correlation-Id: 0867389a-0db0-4f2d-bde2-08daa623a51f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XO6Udt/r7E+2ROLcswQOUIH2iEbgRauTZcKJ1wk07eEIBzDD0CLalnyGAhwhRhtbPOk15CkYVWz/jfO0iiyELR5MRFlMAVyhCtxjxGUGeQL5eI0O2VfO1cOjAwS+1sIM/s5bLUOmo2+oawozEjw3XCXu3ztnWGyeesevXMeG7PKEq1VHq5+fhB6oLp3zs3CGzACazj1JHZFMt7zBw7JABqW/CIgxySvPdoFM0AU8ZJqLtPnQNefzTjU1t26I+cQwz0SYbReQB2Z3WdSyWiSFZac4AJc4H5RrIX7i5GblVultqy6HrG7Uq/VVRGnTixn9kM3neN/9gnON+A8XcIKh142+auB7b3Cpp3kZKRyH8CqWMmXsG5Zs3XKloBNaezAYVqEI0hlam0sfIfKKje462PtpuIH0WRJsSBVSnk2pp1cp/O+o6XKLbS+298kR8QdxoBb1QMi2HlpYwvWChG2dYt1jMmsuhhX5uwToBmWa6XsoCI0VE+svaWdPbC5fKJHAOo0W/5ikP/6XUGWH/t+Jfums5kr5gQvFKliQq9Y1lo7NLrZaWqfYdTL6WmVPaHsVjlrSvCa3xpaGBx0k/M7MWWfvG8CcerWoh3jb3Ulq5ymB310MHf0UfCWM1A1+q+ns571zxqBMDP5oRFHFvG/UOftrQmZ8QIvKAfXZUEWTvwo5eAV997pyj9r5sUwE7uBpJAkuKAI7/Q0x+mjvCb0M7xafC4XL8MHqlS37rxUP8PNqF7QnpoELP8X4lyB96rOP6/VcS9Kjag6wD6cst9aC4qtvO88JSdL27tqJAB7Zaz4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(396003)(366004)(136003)(376002)(451199015)(26005)(6512007)(6486002)(53546011)(6506007)(2616005)(31686004)(478600001)(4326008)(86362001)(316002)(31696002)(8676002)(38100700002)(82960400001)(36756003)(8936002)(186003)(6666004)(83380400001)(66476007)(2906002)(15650500001)(66946007)(66556008)(44832011)(5660300002)(41300700001)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkpjQ3hrWEJ0MEF3emNEOUVzcFY1UkcwOVRnSEpiWms5Z1FEdlhWQkFjTVUx?=
 =?utf-8?B?SE1IRFMxZ3pzMFhnZ201cCtCNWROSngrYWh1aFpWb05KWkxhcjBvQW14ZVJQ?=
 =?utf-8?B?bHBoZDdnV1Vwcm9ReGhTOUZHWTcxRmF2K2RIRUZqbjI5UFJpdG5xc1REVFdG?=
 =?utf-8?B?SllLREpKTXU5cWowME4ydHErbFJwVW0rNS9XaERPcThiSkFUQ2pxeFBrVGkz?=
 =?utf-8?B?d0JYR2FVMVFkZFk2Z2tLbVdIYlJEcW9tRUFZcThIK1VMSloxQUVBK3M4T3lH?=
 =?utf-8?B?cmRiV1l0Y3RMSnIzTHZ5bS8yZkdmUGg4Y3VIRVZ1YzFwZHZYRjgyN21pSWlT?=
 =?utf-8?B?RzVLNzBXOGhWTDNFdEFkS3ZOTEM0cHloK1MvWDZXSE1XbE5MbXlxU2hocjZq?=
 =?utf-8?B?MloyNWtOcDM3VmRNak9TQXN3WWV5NC9ISTZ6L0VmNFFoeFFNdlJZbEF1ekR1?=
 =?utf-8?B?Vk5BZlMrUmxSaDJtbStpVUFhRUJqakNNYi9xQmZ0TGlMS0ZMSG9HbGRQWXR1?=
 =?utf-8?B?cEk0Mzg0aVZRQlpvR0NMN05BTUJ2WWd5U3BzUmgzV3pubnIxSkZHY24yVzkx?=
 =?utf-8?B?c2NTeEFEVDczSVlTeXJhb2t0UzRZOFprNHJydmlEVExqdkJvVVM5eHJqcEY0?=
 =?utf-8?B?Qkpua21jR0FpdkxEd3VzNFVzc3VBNXBYQzZZeXVDRm5qZ2hxWHF1U3JqTWpU?=
 =?utf-8?B?eVUrSm9XVWlEZ2pKKzlNazc5MjNTNWkyTDFtM29sZVlkeUlyV1l5SDVOdFd0?=
 =?utf-8?B?bmVwUThxSU5HTjN4ZElTWmVBUVlUVXRNbkJldzhzYUJxU1JkTUlqRDM4UHN6?=
 =?utf-8?B?bU8rWFFWV3Bna0VTR3hPYUdicmt0STEwaXhHQUNMVU5uWk85YjZSNHcybEtI?=
 =?utf-8?B?Rmpqc29VeVZzU0NkQm13eTFFTWh0UTAySHdyOVZ1aVk1N21jR0tUY3V3OHNL?=
 =?utf-8?B?RXlvUGdKMFZSUWRRbjYwQmMyLzBySSs5bEtrYzFsTU1NbmFxV1krZ2xsdzBZ?=
 =?utf-8?B?NjF3V2NxWU9SRW1RUXBMano2d3V3a3RPYno1RmxXbmpObS9hVE9aSEwwQ0VJ?=
 =?utf-8?B?MlpzSUxteENQdWRxSHhvYzZCa1JjNUMzeHYrYnZyN2EwM3JRbmNoN1lqTFFT?=
 =?utf-8?B?Vkt3cjF1NEhvQUphVWxpQ1g4ajlhZUN4cUdqUUZmM051SE1mWXRPMjlnQVdP?=
 =?utf-8?B?aEpjalJTV2x1WTZFRW03MGtRWGJEazgzbk9pdlhieDIxaUtGQVI3WFVUcDR0?=
 =?utf-8?B?clZ2N1ErU0VzSXlxcXVVY0NJaTNpVmgvTyt5UmZueW1GSUdkV0VOc1lWVita?=
 =?utf-8?B?a2JCZ0NzRVZFazdMTlFETWdWTmhOUWR0RWNuN0wybUIzUGZ3VGJOWkNpZW5V?=
 =?utf-8?B?SFFGNXo0d01KWVA1c09EaVBLbUpsVjBOOVBYL2NjS3dFUE5QTy9QaHZlTlJl?=
 =?utf-8?B?aWlLMU5NNDBOS0pTUmx2MEx2T1F4bVVOQ0QxWW1VaEdkT0tmcW9LbmpybHV1?=
 =?utf-8?B?Ym1YYW9RNTdDS3p5ajUzdktOZSs1eHJMdVFRckRsc0ZleHdacDRRdDFtVXVz?=
 =?utf-8?B?SkxvNmFJQW9TSzVBam5FUVdWSC9qb2NTYVdtS25ETkJCNUpkeUZISGp1aldk?=
 =?utf-8?B?VTJ0VXBmVXVLdzUyM2VxK3ZOdWR2NzlRemNuVHFBVmsyVW84NEhjTGJ3TkRO?=
 =?utf-8?B?WXdEbGZyaDNSODFuN0RyeGZHd3U5Wk50bzh3V1doNWhONm8xZWJGQ1pQbHB3?=
 =?utf-8?B?QnVWWHVRc0VDN0pqT1RCcCtvYzlLaDZ3cWhtNmdKOGYvbEtjQWtQTzVDZDQ4?=
 =?utf-8?B?M1VGRkwyeERXVlMrVVBZUWQ2WkFBU0VucVhlenpBd3F5WE5GQ2JtRjJ0eDFp?=
 =?utf-8?B?dWcvSHp1di9yZXB2MFZRcnZQZ3hUcWN1b21idGlOVjUvZnJ2QWFIUlJLOFRj?=
 =?utf-8?B?cUwvY3pvQStGMDdkeEhHcS9ZTXViTXdiMFVHVFIvclhHY0tRMmhkVFVNRGNh?=
 =?utf-8?B?NjNSWkczUWRNZjF3VVd1dmxCVWU2b05OZXVyMTB2bC9DWnFnQU5QazhqTzE5?=
 =?utf-8?B?WlQ5NnhMb25tcEEwMmFDaGNSL1VsaHZvUmU3dTRKQTZydXMxSVcvVFo3TWJn?=
 =?utf-8?B?dzZ0S2pVWnlaSTZvdC96bVhxVzdHeGlmNHJpTTBpQ2xBb2sxSzBtajFQWGYx?=
 =?utf-8?B?aXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0867389a-0db0-4f2d-bde2-08daa623a51f
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2022 16:15:25.3702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t/xqxKGMI8IYQ4PrSlUiH7CpVSbV7w8ps9X0jz4ZoupA4nLoE3QmFefVlQ8KCRkHTuFqA3KzTo1c1Es2yn3QCbJzcgTQqJ1jHhG3wtVEcOY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5911
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 10/4/2022 7:00 AM, Moger, Babu wrote:
> On 10/3/22 10:36, Reinette Chatre wrote:
>> On 10/3/2022 7:28 AM, Moger, Babu wrote:
>>> On 9/29/22 17:10, Reinette Chatre wrote:
>>>> Hi Babu,
>>>>
>>>> In subject: resctrl_ui.rst -> resctrl.rst
>>>>
>>>> On 9/27/2022 1:27 PM, Babu Moger wrote:
>>>>> Update the documentation for the new features:
>>>>> 1. Slow Memory Bandwidth allocation (SMBA).
>>>>>    With this feature, the QOS  enforcement policies can be applied
>>>>>    to the external slow memory connected to the host. QOS enforcement
>>>>>    is accomplished by assigning a Class Of Service (COS) to a processor
>>>>>    and specifying allocations or limits for that COS for each resource
>>>>>    to be allocated.
>>>>>
>>>>> 2. Bandwidth Monitoring Event Configuration (BMEC).
>>>>>    The bandwidth monitoring events mbm_total_bytes and mbm_local_bytes
>>>>>    are set to count all the total and local reads/writes respectively.
>>>>>    With the introduction of slow memory, the two counters are not
>>>>>    enough to count all the different types are memory events. With the
>>>> types are memory events -> types of memory events?
>>> Ok Sure
>>>>>    feature BMEC, the users have the option to configure mbm_total_bytes
>>>>>    and mbm_local_bytes to count the specific type of events.
>>>>>
>>>>> Also add configuration instructions with examples.
>>>>>
>>>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>>>> ---
>>>> ...
>>>>
>>>>> +
>>>>> +"mbm_total_config", "mbm_local_config":
>>>>> +        These files contain the current event configuration for the events
>>>>> +        mbm_total_bytes and mbm_local_bytes, respectively, when the
>>>>> +        Bandwidth Monitoring Event Configuration (BMEC) feature is supported.
>>>>> +        The event configuration settings are domain specific. Changing the
>>>>> +        configuration on one CPU in a domain would affect the whole domain.
>>>> This contradicts the implementation done in this series where the
>>>> configuration is changed on every CPU in the domain.
>>> How about this?
>>>
>>> The event configuration settings are domain specific and will affect all the CPUs in the domain.
>> There remains a disconnect between this and the implementation that writes the
>> configuration to every CPU.
>>
>> You could make this change to the documentation but then the
>> implementation needs more than "Update MSR_IA32_EVT_CFG_BASE MSR on all
>> the CPUs in cpu_mask" - that comment needs to highlight that the
>> implementation does not follow the architecture and scope rules nor how
>> configuration changes are made in the rest of the driver and why. Previously [1]
>> you indicated that this is based on guidance from hardware team so perhaps you
>> could document it as a hardware quirk related to this feature? At the minimum
>> it should acknowledge the disconnect.
> 
> ok. I could document this in the code patch 9([PATCH v5 09/12]
> x86/resctrl: Add sysfs interface to write mbm_total_bytes event configuration.
> Something like this.
> 
> /*
> +        * Update MSR_IA32_EVT_CFG_BASE MSR on all the CPUs in cpu_mask.

Since multiple MSRs are impacted, how about:

"Update MSR_IA32_EVT_CFG_BASE MSRs ..."

> +        * The MSR MSR_IA32_EVT_CFG_BASE is domain specific. Writing the

"The MSRs offset from MSR MSR_IA32_EVT_CFG_BASE are scoped at the domain
level. Writing any of these MSRs on one CPU is supposed to be observed
by all CPUs in the domain."

> +        * MSR on one CPU will affect all the CPUs in the domain.

Since this is not the case, perhaps it should be " ...
is supposed to affect all the CPUs ..." instead?

> +        * However, the hardware team recommends to update the MSR on
> +        * all the CPU threads. It is not clear in the document yet.

To be consistent, could "CPU threads" be "CPUs"?

Could you please be specific about which document you refer to? Although,
I do not think that writing the last part about "the document" adds value
here. You are representing AMD with this submission and you document that
you are following the guidance from the hardware team in this regard. 
I think that is sufficient.
 

> *        * Doc will be updated in the next revision.

This is a change that will be made to the kernel source ... what does
"next revision" mean when somebody reads this comment in a few years?

Putting all of the above together, how about:

"Update MSR_IA32_EVT_CFG_BASE MSRs on all the CPUs in cpu_mask. The MSRs
offset from MSR MSR_IA32_EVT_CFG_BASE are scoped at the domain level.
Writing any of these MSRs on one CPU is supposed to be observed by all
CPUs in the domain. However, the hardware team recommends to update these
MSRs on all the CPUs in the domain."

Reinette
