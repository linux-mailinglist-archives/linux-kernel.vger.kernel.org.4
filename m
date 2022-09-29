Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560EB5EFFE9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 00:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbiI2WKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 18:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiI2WKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 18:10:50 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876851332E3;
        Thu, 29 Sep 2022 15:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664489448; x=1696025448;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qIq3AyDZfp335tpTrZH42zuDi6z7RoGEETRhuZ4458w=;
  b=mvLKLLh+lK1Hgjje7y2j5SSQESkS0IuKlh5lCYj6OQ/0XaeLhJir9fwj
   I+7eTf9rGukDBm5uAVYjIR/q1tXO21XUtQMVkDgVxjbIKgHAvYurVvitm
   IEGO49sSWeCTZ6V3KuSf+4ncq0VDbcUoItYPnLoYJfQ6PhMIgAEnheEmU
   b9BdIWfOvL61G/W53e7uQajnNGe6kirVD4TO0QYF6/pkxXYltzYKsnof0
   +Sm4mUZD7YDkuzDXlKNlG9IiSmt3mRtRBLsBtF9k7ElwdUiJyVL1Fiuku
   2ZSiUq7/dUhgU31uapJ00JLgU0AnIPTffNEQIurKR3aXEnhDKUI6u1mXx
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="366091443"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="366091443"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 15:10:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="726603363"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="726603363"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 29 Sep 2022 15:10:46 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 29 Sep 2022 15:10:46 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 29 Sep 2022 15:10:45 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 29 Sep 2022 15:10:45 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 29 Sep 2022 15:10:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DztCjSZNOdVNGfH9XG9HnLFrdBG23GN9s7Y3rMS5QN446QX+t0jHzpS3O+kRR/uxPcAFTT4f+WaMEYyPN+Bm+QP3IIKyIDxGJ4O98gFvCMz7zuW0RE1+1O+LC67YQX8fgF00ZZoBlHHiHw00w+0UrLwrdrr+cRZmETFKEbquh5jflnuteSXGrgNeERLTpBGBZ5n2R3DXZK6MBO6cDK2fnIdv6Si4xs5IQE6eJYN9ZWbNFi5MGMN/LiZab/0gcfeZHZEFeP5PR4eeR1h6wW4MpepqZ5fRY7z7HwKwiaFkevlq5ozZfyC/a5nxyo8qYwhJIm2AUgz9w9hIbmK306FCgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZj2wjXiCfdMaSYINP1YRpLNZax+wmdVn8zce8NxGkk=;
 b=QoQb/Tidid3v8f6jkosmBpRO8lCEuGhDBIo6dh3srCFrRf81DoF0XQNmAuXmpOjRuFYPFvW12pUFijIPaXYjSBxgWBnEPGRSDDNBnnF1V8VVph4dKkW9a0ruXyQzX1cLWoAO/jQ2tRiJjhNlTQpPMW+a5Glz1X0EXG2gtKigWx5PN9Vwen7UH/krxmg1QgGeU5MnpVP6j6U2cWBFjuGLebXTLRfDBbrwoVJh1c7lIWEFkJIPwH0WYviJM8IATtXRWxlG825PABvshPOsF7F/l/Vxgr6XeN7cnp5qa+uM6DCRC6gwBxS7JCsfB4gsq4Yb9jMfm8c9xIzYdKKzZCCieQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by IA1PR11MB6122.namprd11.prod.outlook.com (2603:10b6:208:3ee::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Thu, 29 Sep
 2022 22:10:36 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%12]) with mapi id 15.20.5676.015; Thu, 29 Sep
 2022 22:10:36 +0000
Message-ID: <71ca01ad-e563-3ac3-815d-0bbc3814ed6f@intel.com>
Date:   Thu, 29 Sep 2022 15:10:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.3.0
Subject: Re: [PATCH v5 12/12] Documentation/x86: Update resctrl_ui.rst for new
 features
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
References: <166431016617.373387.1968875281081252467.stgit@bmoger-ubuntu>
 <166431042060.373387.8454967155095795574.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <166431042060.373387.8454967155095795574.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::22) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|IA1PR11MB6122:EE_
X-MS-Office365-Filtering-Correlation-Id: 3277aceb-d0c8-4be2-4c5e-08daa2676f42
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xmYml8ShzkMM2emxoi8Lgze877/jagsPM7IIyiW0IC6HaGOBzJhbhafChbXPgA0x82b7IpH+rUt9GTUcyz6fo4Wb3uqZ30Fob2BTQ3O61o5oW+75R8ArT0LkwOmRGxCT7GqAq0zwRri1WMC9k1990B4tWX/Vt8SIPCC0WoUpP3bNVbCvHTV2Bi4m26AYCYbVExHXAQsTTv+pIZSavQdm5YfFE9DDOfq7Kko33kBFhqYcPJaypEmlX++UqbXtzrjKjYdo9fotFgZxjEaK1KTzhLVgFqPCOxMlRZZ83rkzHLZUyWK536ZC4ksem1kIgyr/GcT4pigGkKnsA+Z8k94GbQIdA103GMijqBdp5UjCsQbLJNFC0FXzVL18fmnvew6C7lOLsIHhkg22Eo69foKo81DQpJfHpxImGHBB7vFSC6DVDly4R9pxU62cLZEKZvTjXmpjq/oHU3xUHN0gLLOOSLSufFHU/qfe3t8eaovWAmsGB3qxuBXFnKwuAb6Pbb/daHSL9JvbiDKe5Joq3jg8VdfkBmzAPkxL0BM+jhcGYaZBS9r94S6uAOMUJzwcsTsOWwETWIELlJp2CR6d3NDa/ttLhrdt6D2ceTQcygjGGJ+NKg9W8lhfugg+hOxPoXUln1jnblbKgg5RaMjOJ6tRjm6IoIYbB5ILKd55aY4WRMcXoDSDd3GyoSMfAkJja1wQwrWvkYTKqjMwMdZBbN7c8yT/9nayR8qAv+0t0tpYFIGxlU55p/ushH6C3hLr7s/hVCZt8bdjzEeEiYTpdTiV+SHKc8XqUXo1Gpu02G1K3o8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(366004)(346002)(376002)(39860400002)(451199015)(5660300002)(26005)(6512007)(8676002)(316002)(66946007)(66556008)(31686004)(478600001)(66476007)(6506007)(8936002)(53546011)(6666004)(6486002)(15650500001)(44832011)(7416002)(2906002)(83380400001)(38100700002)(41300700001)(2616005)(82960400001)(186003)(36756003)(86362001)(4326008)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUFnR0l6MWJtc0xQUnFVZ3JYeUY3ODV0UTVnOEYyYjNoOU0wMG42bjI0TDJ1?=
 =?utf-8?B?NEJwYWhmTGx2Ny9VWWwwdkZPN1pNYWtkVnpyZForRmErQ0l2aWJmSjI3Mmwx?=
 =?utf-8?B?eGlTT3FMd1hoUXc4VnFTMXpvY01qRVJXaWVPS2VMSjF3RmJRbWl6dGN3SnMw?=
 =?utf-8?B?bFVCUDNEZTVjWkJ6d0oxT1lEU2VRTnRzcG4vQXNqMjk1OERrMTQ5cWJLajha?=
 =?utf-8?B?RXJWWEVjV2VjNW4xZGdEZ3BjaVJrNkNpZ3F6WG9hSzFLRXhubVEyQnNRdGxS?=
 =?utf-8?B?NzlTK1pFcWJDWHFURG1vMVFKV2pKcnpZVEI1VFlFYmhTM2VaYm1pcnd0WGF0?=
 =?utf-8?B?MExhZm5WdGEyaVZxVXZiYm9mOEJ1TVd5dXhVckw4Q2FGa1BtendWZjdMWE5p?=
 =?utf-8?B?MzBOV05tcS9MbFRseVV0WkF4UnV1M2lINU9vZzF0ZmQxWGwybEYzWVlvbDlQ?=
 =?utf-8?B?dUFCdkhYVmdqVkJHa1ZpYmUvVnFhNTFJTUVHNk1meHBmb3F0U3hMNmVyVmhM?=
 =?utf-8?B?ZEx5eXlKMHFEWlpFTHhIMGZjZktlYmlRcnlmci9nZkR3aHBmTTYycnFDbmY2?=
 =?utf-8?B?d2ZYNFpqUzU0ZW1kRzhEQWRMZW85SXNON2RxTmphYnV1L3p6aUZFU3orTHFv?=
 =?utf-8?B?alZtMWVZelFMNFBVZGtlam9SUDVra0VJeS9jUmlwbXdLUVRVOVdKWklkM0tF?=
 =?utf-8?B?TzBCa1BOa1NTSGtxVlRRVDR5Vmd6TEZLa2hDaVJrTnlvUjFjTS8rdnpqa0lJ?=
 =?utf-8?B?SElDYS94Q1hRK0c3ajRKc0VnS1ZpaTJVTmVRT2hlZDRXOTN1eG4yQ294QUJp?=
 =?utf-8?B?OHdac3YzTDdsN3BJVncwK2JRTmd5TFVvelkxVkE2MGlNSTZ5NWVPNHZIS281?=
 =?utf-8?B?UVY4U2p0cjk0UmR1ZG9tNnRsVEZZa3B2Z2tJODhyYTNPdzZocHpOUUsrekpJ?=
 =?utf-8?B?T1VUVlM4Tk9ORWlNcUNlcmV6a01NeUsvOVNVa2YxZFc2YzhpTlhSamd4cmJa?=
 =?utf-8?B?ZTdNbzY2MEJYclZIU2t4YVZvbmdjRm5GVExZc3NxWWJ0cmxQSG9JU0x5eTNi?=
 =?utf-8?B?eWJWRmh3SmQxNVpRbms3VzJ2VXVUTndFdy90THFCdFNZbHh3dVRMTEszWmVr?=
 =?utf-8?B?TmVMUUVLZENiZEliY0xxRWx4NzV3WEQrRENSSlRaZHFjYWNGcDlMVkE4K0Nw?=
 =?utf-8?B?S1NLa29pa2Q5YnNiREVOd09mOXBvRWdhNDhGaUgwVTFxeTZXbnVUbDU1UWtS?=
 =?utf-8?B?bzZUQWcxQjBhMkhRRlpsWnhpcHQrRkZXT2lvQXdTL0Rmbi9lbHZMQW43cXY0?=
 =?utf-8?B?eU5XZC9XZUZHVlU0NUFkakpuTWtWSjNHQjVJamp6S21YbGN0RXlsOExmRFhS?=
 =?utf-8?B?bDJYa2tZMnJQOUNlbWdocHk1cW9aU1g5SGJBTkpjNmpmajJ4bXJWZkp6YXpq?=
 =?utf-8?B?RXZKdkNyVHBXMFFvdGlrSHArdGNaQUFXZHFiNGE2QmtoWkFPUW5pR21URW9M?=
 =?utf-8?B?M2VESGFuTXVEeTFtZysrSTY4TUpiNTdFVFNDZytkN3N5ODJoT1RHMmpBdWlh?=
 =?utf-8?B?K3VIYWkyc0hhWUNKTVM2WmlPZzNYNVJhczgvNm9vUnUrdEhFZGp2Q1IvU01K?=
 =?utf-8?B?UVV4bjdNNk9BSW9YelZ6SkxsZUMxTEJySmVIdVBhUnF2L2pJclU0QnI3NjlS?=
 =?utf-8?B?eHdoSWtYLzN4ODFwUU40SWNkN3VZb29oWk9tQzZWdlhwY2tiYUwxQ093THQz?=
 =?utf-8?B?UER4UDZ2NVJDaGljdjFoU01zOXhZOWgrZW1IUnVsRW9waDQ0N0dlNnBOVXhi?=
 =?utf-8?B?V0NXaUw4Smx5b2YvbUg4di80RXU2YThmcEhBcjBId0YzTnkrRkJmY1pGVk95?=
 =?utf-8?B?RzNBYlFGNFFwNHczS0ZBOFY4T1NKa0Q3WWZ6ZmV5aXd6MzEvbnZMdDVSOHRP?=
 =?utf-8?B?K2xhSGdqUkFKcm9zaTFWMXAyU3VpVmZ6UVVzK1FWbzRIWjdrM3FMYXFESDda?=
 =?utf-8?B?N3ZZUGZrN1ZiamxWR0t6d296MkNRVTU2amJTSW14Y3hZdVVEeVM5VFYwYXNt?=
 =?utf-8?B?clBWRm1rY0VKMEZ4a2lScEpaaTIySjRvakRkVWFpUTZVNnpyV3B3UUJvclg5?=
 =?utf-8?B?U2JxcjNsSzBQMDdVNlcvdjErQnI4NmpXT1lqWlNQejBEdk9WMXpaeXdNWXJq?=
 =?utf-8?B?NWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3277aceb-d0c8-4be2-4c5e-08daa2676f42
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 22:10:36.1418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h/Ub8i4AlwUAohwdKPN8jYvJbyYpVlY9ABiF18u6EhNYHx7PmvT2WtNVMFtt+2O5whAW6xkoDOj1XdW6LMMtliQdvdHAKLzIkl74K9skfCM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6122
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

In subject: resctrl_ui.rst -> resctrl.rst

On 9/27/2022 1:27 PM, Babu Moger wrote:
> Update the documentation for the new features:
> 1. Slow Memory Bandwidth allocation (SMBA).
>    With this feature, the QOS  enforcement policies can be applied
>    to the external slow memory connected to the host. QOS enforcement
>    is accomplished by assigning a Class Of Service (COS) to a processor
>    and specifying allocations or limits for that COS for each resource
>    to be allocated.
> 
> 2. Bandwidth Monitoring Event Configuration (BMEC).
>    The bandwidth monitoring events mbm_total_bytes and mbm_local_bytes
>    are set to count all the total and local reads/writes respectively.
>    With the introduction of slow memory, the two counters are not
>    enough to count all the different types are memory events. With the

types are memory events -> types of memory events?

>    feature BMEC, the users have the option to configure mbm_total_bytes
>    and mbm_local_bytes to count the specific type of events.
> 
> Also add configuration instructions with examples.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

...

> +
> +"mbm_total_config", "mbm_local_config":
> +        These files contain the current event configuration for the events
> +        mbm_total_bytes and mbm_local_bytes, respectively, when the
> +        Bandwidth Monitoring Event Configuration (BMEC) feature is supported.
> +        The event configuration settings are domain specific. Changing the
> +        configuration on one CPU in a domain would affect the whole domain.

This contradicts the implementation done in this series where the
configuration is changed on every CPU in the domain.

Reinette
