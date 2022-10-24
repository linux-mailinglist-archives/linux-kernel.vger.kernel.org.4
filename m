Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA4160B4D8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbiJXSFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbiJXSFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:05:03 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95652196B7E
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 09:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666629952; x=1698165952;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Xn1TOqw7IhBUho1yRhZeDMBe5NzP0KIkvACmVcMyRzw=;
  b=XN2Oj4FIwLjsZ+Scc4FEzfuk+Xkx5OyXBloDkOAwkBqIMpUJqG68ZY1z
   QHS6H1AB413jfhYuX2irgLaZcomvx3VU1AsHE0F8LitVanCcp2x4ApZ7a
   bpXc6MWMoO5La934KHDsWZV0CjpODsW2cvnhOLdXaSJbcVBhdN8fzVNDi
   hioLz7PGbNK8eeuCne9TEWRZdj1vZocNz2Ngx0GTxl5AZqkCkYjZmNrHC
   bF1EREpMftFwAWvM/6NZxmys0GJpXf4mjZ6Aiq4xYzNvinfa0GHuXFjUm
   5En7LnrePuyRB8QxH90GFdZ6dr3Lm4C1sfPKLqDyDTuLrjYMcZj0iIThu
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="393784909"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="393784909"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 09:45:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="756633884"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="756633884"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 24 Oct 2022 09:45:20 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 09:45:19 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 09:45:19 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 24 Oct 2022 09:45:19 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 24 Oct 2022 09:45:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DWM16TUhCsB2S5i/pzLWG/GFhuiNcGBGR9wq8y1QyURZDJy17CNl9elXSffYYX7tF7Fh94i7By5NakabGJV6NDupl5nE5KZjPnGT90afBR21luQouuX6yxXL8fKMtJbch5kfOcM83t9GdIp2riqHQbIW/CjU5u6gCG5OyJU9lqq6JTxn7EGaf47VBYdb/UQi6vEhmzInrifHsZMIzIYh1hkPL4qJYEnk6dwOZH+ydmqSjohaQMP3WQaOI1xWfd7kVU5MxLe/DoMLskbdgeSIr0RECPV0F33yxD15UGgl6yr7XAaBuhH4HGL/wTR0DxVrlXz9GtlTg8jYZ/5lPiBfRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+Ro++tJl4/lHFYwsNwY/R84kgXEfwppF17S9pFcw4I=;
 b=gFIXx8n9jQwRn6lmWVVfE/A4og7gEC/lTu3iluonkUExrFYvuTzDp/dQhJ2PUAZqJjy39i1tejvlY2BKyVAsXIbSfiAoyRRj5XwbUmeSCc2f2O2a3Oudk/J3TV9hCs0koH58D8x67a+7DI+yt2856HbefUzanaBRss5U3HImIFdva0J1Njuae91NVCuMgI2aS05ByeZbDnDqnjqeg7ppJODZVbTQtuALOL/AUYeFvylPw9/J/f7QRcvmK7os39ayX4WU1QCq0kT/dRHUnBo2nqcfTTjEgV+TrWOT2zxR3Mlx7fpavx/o30JmUeygTGhh/XtNgMtvBBkNvSeLOzsd/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DS7PR11MB6245.namprd11.prod.outlook.com (2603:10b6:8:9a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Mon, 24 Oct
 2022 16:45:17 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%12]) with mapi id 15.20.5746.023; Mon, 24 Oct
 2022 16:45:17 +0000
Message-ID: <bbc21b48-58b5-6356-0248-656e22d95281@intel.com>
Date:   Mon, 24 Oct 2022 09:45:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.0
Subject: Re: [PATCH v2] x86/resctrl: Clear the stale staged config after the
 configuration is completed
To:     Shawn Wang <shawnwang@linux.alibaba.com>, <fenghua.yu@intel.com>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        James Morse <james.morse@arm.com>, <jamie@nuviainc.com>,
        <linux-kernel@vger.kernel.org>
References: <1665304608-120466-1-git-send-email-shawnwang@linux.alibaba.com>
 <7fa6ed4e-abae-85fb-4e95-8c73755a4263@intel.com>
 <ad08eee6-cfea-3858-0def-e2e3fef315fb@linux.alibaba.com>
 <ff44b0ff-6adb-3bae-d17e-4c341c09df5d@intel.com>
 <86fc22a2-e779-b7ab-67d6-a3aff975ae56@linux.alibaba.com>
 <30637459-7419-6497-6230-b13c73a947de@intel.com>
 <2cdfbe28-01cc-926d-2f6d-2a974a4c5a74@linux.alibaba.com>
Content-Language: en-US
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <2cdfbe28-01cc-926d-2f6d-2a974a4c5a74@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR17CA0019.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::32) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|DS7PR11MB6245:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f67b7c9-d717-4578-09f6-08dab5df21cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +lYOKoQYQLHdo20gWiNZWA7aE++ExoPCHi0KURViYCWd176WTzR5ap2mOL9vhmX/zcMUZkxNFuRgoqKxtkr2GO/JVTQYhIoG+NTDlHGOClucii0xOVOCC92E97vD8siaqOYHHys3ON6NERcWheFs4RMB/o0eN2uV6ExKxl4lblEOlOXJCCKbjMMI3b/wl/4vYbYal7pvctNay2sEZl+VFU4DZ6eg0hqcrrhZhbPpYkABJUCh7WNwpdyhoADabkqq6HQowlBA/hfm8gzNY8YPwWmKKw93tEv9c6xL7PABwNR5RKfMsXFFIHdXfbzU3a3cQCnLbOQ5xIO/Vbqt262r7P5cgggJQ2TC3SZXlhtefbndV71hCeawZenjgs+qNETemncaOOR5wvO1pcqoFn7fuhzXb1BDZxxEjhk44enF+3LGsFA6PhKZcM3zcBFYxRuwPzTsbh9kwEIcRRXUS0b7z7sPh4EaZMRgpwK2VFiA3TFmzVNTO4OhTg4LMj+khoK2rqzmqKtbzYl1gns558I5GKFJb7/Ugcto9xOIGmS/998gdnnOHKiCIpJvbpyAumFa/JqtMYa2RejmF1paoc3TtIRApvpvjx+NO8b5U7M+Xpeh10qFaflHa/Po8FKB6jTpNuTVJmTlLa4CQjJU+4bsmVhNlKmYBCIZdoF99YfYnLyhbCt6Z97nFA2gvuuogRXRbMM2iZfjQ4kLZVchv3bEF/KRiOP2Ra4HRzpKIfAMla+3jTsMd/pqVAQPhYdV3I9NIWGShOO83j7EJx4WkLNsjjy5upU3AW0aXaGKLbhy/Ss=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(39860400002)(376002)(136003)(346002)(451199015)(6636002)(31686004)(41300700001)(66476007)(4326008)(8676002)(66556008)(8936002)(44832011)(66946007)(7416002)(86362001)(2906002)(6512007)(478600001)(31696002)(26005)(6486002)(53546011)(36756003)(6506007)(6666004)(83380400001)(186003)(316002)(82960400001)(5660300002)(2616005)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uyt6d0oyVnQzMm9pTit5TkdSZDdKTzVSWnE1ZU9jNDREZWtGRVk4RmJWeVVX?=
 =?utf-8?B?TzZ3NTFJSjRqcmQ1UjNxTlVLL0FYcFFvSE5teThoaDUreW5rYVNuak9ZK2tO?=
 =?utf-8?B?cjZqK0ZneXdlREdvTHpXVnhOZ1Faa2RWZmVzN3RSZVpFZ09jeEhXZHZpU0Vh?=
 =?utf-8?B?Y0poVk1IdEE4TXhCcVVoMlN1a2k1TXpPYmk4aG15T2Y3TTBjNHdHWVB0cDQ4?=
 =?utf-8?B?eHdZME93NEUxNU9aNi9EQWZRdllMUW5ReG14bEdKZ2F5QXU2MmJGcjRyaXhx?=
 =?utf-8?B?TjRRWit5TklUMUcvczZyUmgzaGw3R2Q4TVVRYVg1Z2Q1Z09kbHI4RjYrcFdU?=
 =?utf-8?B?MWpmUmJEbTh6dVNqK3NURFBnUEtEaFM4UjNHK2RjTHNEVlQ5QjFPdDByQnB1?=
 =?utf-8?B?MlpFYlZ1ZWZISXgyd1pCVExWMzFZTUpodFRRMEhTaEN2a2dQR05vdU9xVDNB?=
 =?utf-8?B?U1FMWHVwNHFGY3h0WXZLejJoN3BNM0VZdFZyZ0xhNU5mUW8xVTNFYkN1OFBJ?=
 =?utf-8?B?RTd5eGREa0J0bHd6Z3l3VG9TZVhlcFpDSmI3ZXBlNkRsanE3REZlYU5ZaW1h?=
 =?utf-8?B?cENCdHROL1FoSVV0MExweWlvSi8wTWVEQXBQaFhpVUp4K1l4QVZTN0hIenky?=
 =?utf-8?B?Q0ZmeEUwZTJwRWJEcDFRM3Z2b2R0VVd5MTBFWmN2WkxuTC82NGIyVDBkaE9j?=
 =?utf-8?B?b0hvRHFDeDdXdDczTWxvZWp5c2QwODZjTWhmK1F5eHZtSXBmYmhVUXlQcmR1?=
 =?utf-8?B?clU4QmJWZ2h6VmkzeFN2YzRMS1lJYit0bjU0eG9PUkcya1pHRjhqSk8zUnhj?=
 =?utf-8?B?NENYYytsNlcwNDJZNXV3ZTVXaDFubmZ4a29xVUZJYlZycWJ6cCtMNmRKS3dG?=
 =?utf-8?B?RTcxQ3Z6TThVQ29kQ0lZN3R1OUtaQi9xUmRjNGwyajg1L2F3YlgyUGNaUGpH?=
 =?utf-8?B?dS9FK2dpUC9nRjQ0MERDajdjNWl3K0JBYnhUTStCSTZFV05pUkRVSVdhNFMw?=
 =?utf-8?B?Vi9jUnVxcG1XOUhTN2NZOFd2bWl0ZkN5V1JrNndRMEZVaWM1QWZKY2pKRjR5?=
 =?utf-8?B?MThEWFprWE1iSjdoVEQxVmlZaXVRMmd1eDNkTStzKzBlUE1TdG5Mc3BFYVA0?=
 =?utf-8?B?VlkyczBBSmhzK0JZR0t6Ly9ITnMxS053VFl1U2JIbUdqcHVWNFVkRDg5ZUZz?=
 =?utf-8?B?TmNZakhQUUVzUHplNFVGSzJJMzhvc1FWdVRpcDFnOUJzRDFFOTZyUFpwQ0JQ?=
 =?utf-8?B?dGYvVkNxNWZwQXVvSnFJMkM0VjZVVnZUc3JMcWNtcHpZTHlYMFN3WGNFdC81?=
 =?utf-8?B?S0xzVS9ZU29FZlhQeFpvVUNXSDdTa2RJT2JHRmZPbFJCdDBHZ1MzL1pKRTlq?=
 =?utf-8?B?UDg5ZGNWanh6OVdZT2huZTJjek51MEZiRFI3bnFlMzdlZFBlMTlnOTducEdD?=
 =?utf-8?B?ZmwyRkxVREo0YnZiSGNUai94Y0NlVHowbzFsZjc2eGtOVFRuckVscHg3YkR5?=
 =?utf-8?B?bW9rWEhzZ3VKUmRKaWllbmVSV01CL0h5RzlNZ2hYNG0yVTFYQjlXbXloUTFX?=
 =?utf-8?B?RWJsbm8zR2FHelNpQitnR3JUNlNnUUx6NjUyazBOQWg3aUhpbkM0aW55Z21F?=
 =?utf-8?B?TmpPbFNic292SHoyclQrUUxzUXFQWGlUTW1icWtWY0dmbFAzanpGRUhiSHd5?=
 =?utf-8?B?dDFFYmV0dzNLWmVoeVRxcTluTzQ5SjB6VktjK25zOVJDZzhEZnhtUHdxTklu?=
 =?utf-8?B?NUlNQVQxS2tnS25XRkFrcHBVQUEvOTMrR2YzQU5DWWIwaGJlTXVXMmRjVk5t?=
 =?utf-8?B?b2llajJqbWM1K1czbnBYZjVvWEg2THkvOXpQMzlEWVdvZVcvUUFrVThxMm9H?=
 =?utf-8?B?bnpWeSsvMm12OU1sVlU0M01FMjdIYVltN1AraHdSaVJpSGpTZHJ2TThoSE5Z?=
 =?utf-8?B?dHJuWXg2NW80QjMzYm5DQVNCZnVZS09RTllxc1kvQkhzQzFOR05hd2g5QU41?=
 =?utf-8?B?VmtGcmsvWkFpOGZXcG5Dc3NRMWNXS2l6b2FOMTc3T1ZEQ1JzbTR3cDZGY09h?=
 =?utf-8?B?TDlmRm5zc0lGa29BNWl1MkZjMFhoT0x3b1FoQlRwdm5nWG43YVlDUVpiODdQ?=
 =?utf-8?B?UUhyNUNRSW9QK21aTUM1Y1JPYmlaVCthakhaRE91WkRIUGNMQWlSRjErVE5i?=
 =?utf-8?B?bVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f67b7c9-d717-4578-09f6-08dab5df21cf
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 16:45:17.7616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FJi6SznpfoZMYtI427rCI8w3GN6GHKBqllpPiQw6pc5NkSyQQ6qLWQNLVektkNf18qvQrg1hwwb8rNGkOCkfFbCcHA6P9wvEYR5lJ5pIE3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6245
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

On 10/23/2022 7:31 PM, Shawn Wang wrote:
> On 10/22/2022 2:05 AM, Reinette Chatre wrote:
> 
> ...
> 
>>> It may not be enough to just clear staged_config[] when
>>> resctrl_arch_update_domains() exits. I think the fix needs to make
>>> sure staged_config[] can be cleared where it is set.
>>>
>>> The modification of staged_config[] comes from two paths:
>>>
>>> Path 1:
>>> rdtgroup_schemata_write() {
>>>      ...
>>>      rdtgroup_parse_resource()     // set staged_config[]
>>>      ...
>>>      resctrl_arch_update_domains()     // clear staged_config[]
>>>      ...
>>> }
>>>
>>> Path 2:
>>> rdtgroup_init_alloc() {
>>>      ...
>>>      rdtgroup_init_mba()/rdtgroup_init_cat()    // set staged_config[]
>>>      ...
>>>      resctrl_arch_update_domains()        // clear staged_config[]
>>>      ...
>>> }
>>>
>>> If we clear staged_config[] in resctrl_arch_update_domains(), goto
>>> statement for error handling between setting staged_config[] and
>>> calling resctrl_arch_update_domains() will be ignored. This can still
>>> remain the stale staged_config[].
>> ah - indeed. Thank you for catching that.
>>
>>>
>>> I think maybe it is better to put the clearing work where
>>> rdtgroup_schemata_write() and rdtgroup_init_alloc() exit.
>>>
>>
>> It may be more robust to let rdtgroup_init_alloc() follow
>> how rdtgroup_schemata_write() already ensures that it is
>> working with a clean state by clearing staged_config[] before
>> placing its staged config within.
>>
> 
> I want to make sure, do you mean just ignore the stale value and
> place the clearing work before staged_config[] is used? If so, maybe
> the only thing the fix should do is to add memset() to
> rdtgroup_init_alloc().> 

No, let us not leave stale data lying around.

The idea is that the function calling resctrl_arch_update_domains() is
responsible for initializing staged_config[] correctly and completely.
To confirm, yes, the idea is to clear the staged_config[] in
rdtgroup_init_alloc() before resctrl_arch_update_domains() is called
to follow how it is currently done in rdtgroup_schemata_write().

But, as you indicate, by itself this would leave stale data lying around.

The solution that you suggested earlier, to put the clearing work where
rdtgroup_schemata_write() and rdtgroup_init_alloc() exit, is most logical.
That makes the code symmetrical in that staged_config[] is cleared
where it is initialized and no stale data is left lying around. What was
not clear to me is how this would look in the end. Were you planning to
keep the staged_config[] clearing within rdtgroup_schemata_write() but
not do so in rdtgroup_init_alloc()? rdtgroup_schemata_write() and
rdtgroup_init_alloc() has to follow the same pattern to reduce confusion.

So, to be more robust, how about:

/* Clear staged_config[] to make sure working from a clean slate */
resctrl_arch_update_domains()
/* Clear staged_config[] to not leave stale data lying around */

Reinette


