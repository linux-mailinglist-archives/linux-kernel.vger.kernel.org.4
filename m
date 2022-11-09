Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4DC62229B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 04:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbiKIDaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 22:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiKIDaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 22:30:07 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909E6E0FA;
        Tue,  8 Nov 2022 19:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667964606; x=1699500606;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KOZSHN4cRfz6coHSE1HIkTrMhSdTZeLYPkB6eH0aCr0=;
  b=LNJArNBB2UY8qjUDammA2uFJPwqPFfCld2cwdyRAmTVbbzrgVWZUMGHl
   5jN/BwK0qbtinKi6bz6clT1n3+IkDHFfPjKX6pUGsimkzWKMBI5F+hh24
   27AzccVj6jgugm2IR+MlC32HhozJs+8rcBIkXx0ij/fcmk4FG+tpgkNVx
   g11VfmZvmVghhXR7z51Ymjx7+VdEfyusb6lJ8JUePwlxKGlte8smFloFu
   6/h3ElJFx/h/griSYf/9DDU2n1AksShqRj4x78pibpeB31CObQcNpfO7U
   bshjQeYj6zt1xBtUjA1ck4htrSBexq+h4/WciA82cVtxQxEaGPhjwpcUQ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="310873183"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="310873183"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 19:30:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="639038921"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="639038921"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 08 Nov 2022 19:30:06 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 19:30:05 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 19:30:05 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 8 Nov 2022 19:30:05 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 8 Nov 2022 19:30:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nkR6KAswJu04zyvdLEeWrIMBwBL+AZwLrQfzRhZ1hhhz7GTyA3KpEVZa5eru4guCMII25R4//KVcMF9x/p9sJ13Kc9k8EIIvFaKvNs1CqYR6nqW045wSzoNyR3M4b6bfOaUuYWtIXIRfhfrG4rrDHT2Q/cP8cgExaDX+nu6dKhhXAOlxY/OEKD0wGA8zGd1HoYtv1FcPP6Yv6bgbEHg9+ud/NtwblfOFQ1Lko37P3axqF7TiXJW2KC1yGuBZKReHZBAwJF/+tZliWAUoUUG5VcZyjgTlxj8ATtdVEezgNbF5YlOhEnyhOyr6Bm94Zd5eBCJTNGIlccdag2DfbwI9nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gIYun6rI224NnkaEm6iUXDLFh/apmhYvjECFttbB2FQ=;
 b=dEtdQAXE7A/DzDqE8ncWtx3nnmPhU+2GAge3op/DhZsj76iX1xGUutgHFNtSdeyr1duwEdzRTMtwV+yy/n7gy1R4CKblmDsnNi/sFRN+aVPU8ejWmyHEP+jeKhVu40o7BU4g16p0tb5XaZT36enBmn1cFHV0SC4aw3HP1N9lZSG/07R1qBgwVXsEh+MSBzqumvKFSyXI5NQphXGiPnfacLPheKIBtB70MocX6DfccUATxz2qDc2lBBfDbHg1Dw5FWZS06iQorCLSD+aE14WWd4wI3FG83a0s/U2jWhuA4jAmlfqmXLPTYLy42V7PvBAG5fJEwVBf8m/lQagXt8Rt0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by DM6PR11MB4594.namprd11.prod.outlook.com (2603:10b6:5:2a0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 03:30:02 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::f980:8dbd:ddf0:11c0]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::f980:8dbd:ddf0:11c0%4]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 03:30:01 +0000
Message-ID: <501caac0-57f1-7db2-b030-b6d4f13ab3ca@intel.com>
Date:   Tue, 8 Nov 2022 19:29:58 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2 06/14] x86/microcode/intel: Expose
 microcode_sanity_check()
Content-Language: en-US
To:     Sohil Mehta <sohil.mehta@intel.com>, <hdegoede@redhat.com>,
        <markgross@kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <gregkh@linuxfoundation.org>, <ashok.raj@intel.com>,
        <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <thiago.macieira@intel.com>,
        <athenas.jimenez.gonzalez@intel.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221107225323.2733518-1-jithu.joseph@intel.com>
 <20221107225323.2733518-7-jithu.joseph@intel.com>
 <86c46504-f769-1187-2aba-5b8b58654b33@intel.com>
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <86c46504-f769-1187-2aba-5b8b58654b33@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR07CA0072.namprd07.prod.outlook.com
 (2603:10b6:a03:60::49) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3768:EE_|DM6PR11MB4594:EE_
X-MS-Office365-Filtering-Correlation-Id: dbe8d697-615c-4ea2-1a0e-08dac202af75
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OPMPbRgEvOmL2QJ3REkpRk65QGNP0tX86MGMhflhFnm5TBvVCupz1pVIRVzwh+/avoV3TVbx6oAh8zuLTfq9D9rp20bgwLVGgnepcL7ld0ytBtNdxQREp68KVbyTq2czXh16ByS4TZTPWuIlWjxDiLL/7Zkv3HILKc7P49sEOh02i6I6NKAcdDr+dgnEHaxMQhWoTa7lNL2CEAgNk+MaVwAL85GfU/AeQSsUP8pCVTcp3hFs6frkDVvVsMT6JkHbVDlYoVa/NmrAvrHhw9WsGlVx5Izr0yFNFNldrzgX5gJvKnmnFo8zOriwkaT58LjOqfGzxfMrCcLrZXTGZJWfmNNMSQv/7D8Pvk1jOE8/NEOc2J41gA7h7v4YItMFn1JeJAEuRcLy6RpzhvhmcFM6Q6CBixZDJLOEAtpJPBBWkzNAqCR1SZqCsgaFfhYp4pIdmZ80OD9mfC70o3TnYrCT7Lag7+vaB2ZzFKGT0ziyBl7G9pCBiQk2s4gqRv/3e358l/AW0iAMbzRGijyuqh831YYBHIwxqevLz8Pbbes6PyPaRlG3tMR6pBBNZQNIi5ohjZflwWOI08nuhRVUWh9VMV8DnL22e3pPmsz9efwVyHHQ/mKxtSWAWZOrW/WBJ1LAqcQSYvvEmv61Lx/EKYhJPUG1CARbiv0/IuHoMEBD8bJcCwSPJEdYS5aETs2p9XyihAroIMCvWX8TrINYV1l6OmWVqOxN9nW53mAA8T1q+5aW5VJI+wsTiVlZEmAZUET7e/CSfPdWOG/dxgGZ9/DT/LXk6ltvxOh6Sd43NFLYG84=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(39860400002)(396003)(376002)(136003)(451199015)(478600001)(6486002)(2906002)(2616005)(186003)(83380400001)(6666004)(82960400001)(4326008)(26005)(38100700002)(6512007)(36756003)(6506007)(8676002)(53546011)(31686004)(316002)(66556008)(66476007)(8936002)(86362001)(31696002)(66946007)(7416002)(5660300002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekRITGNidG0yVGF2YWNzTG5EaWg4WnV6cUpwYUc5TzBoVkJCMi9ra2hYOGtN?=
 =?utf-8?B?ZGdpcVR6QTVZU3dvTi8xb0JkSmNRbUxqMEc1ZEpISk5ERlNRbThhU0RPT3NM?=
 =?utf-8?B?cnpYMUxIb1dNZzIyUnpqekVnbWRuREZGa0N5M05IQWNqTjNRZGViYUs1M2N0?=
 =?utf-8?B?eTdVTjhuanpnUWEvemp0Y3hqVHEwNlZLYXNHWlNvQjBDK3dtZnl3WEllS3dL?=
 =?utf-8?B?L3R2MjlnaUVPeEQwZ2pqZ01CSWR2cE5KSkh1ZTZSWlVhTys1SzRBbTc5dk1J?=
 =?utf-8?B?bEttV25vb0d6S25zdFhuL2xLaitnSnhWQVczd1YwbWxieE1MOEpMb2x5RUNk?=
 =?utf-8?B?RVNPeVUxdlRJUXYrYlJtTitLRzhpV2NlbllEZWtCUHlySmVIdVVSWlEwcEpP?=
 =?utf-8?B?TWxUR3FsVk0weGxGMTJDcXRSY2p2SElrN1ZIVXZPVWRDVzJLQ1VSNGI1SU1u?=
 =?utf-8?B?YUhhYkJMMC8vdk1rSGpSSTAxSUxHaXZSbHNrQjFzclROc1ZsRkI2dG5KSVov?=
 =?utf-8?B?VHoyeFZseEM1dWNxVVBHbzY2Z3pvNGlERS9wNktvVXY0ZjZ1VUtEOXFxSW5z?=
 =?utf-8?B?R1FXMllQVzR5c3BEZDE0WFhYZVlmTFdIb1VZU0V5QnVjNDZlMjZMTDBML05o?=
 =?utf-8?B?K0tpcWNZZVJKUzhuTCtJeVdFcWlWbnZUOS9GejllNXR6MjgzMzE0SWVhT2l4?=
 =?utf-8?B?M2ZIdHNMbXg1eHJDS0tFdWZsNEFjZDhDb3RKQW9GWjJmZHJFeDljTjZNMld1?=
 =?utf-8?B?M01OK2lyRGMvVUhQOUVIZEFycVVkREN3TEhKdzVyZUxXOFNrQmJHQ3AvVHZx?=
 =?utf-8?B?MXRORU1PNWVuOFh3aW1tZTE5NlZvVDZTSW9SNjYvSm5PRVpZWDJBR0RNNTh2?=
 =?utf-8?B?YkJzVWJ1Qkt4dnJ4cGE3bm1EYzdHUlJhdjZmU25sRFlWVjFZSDNZWXdvY1NM?=
 =?utf-8?B?em81YXFpRHJ5RVFtZ1FxOTlqZHRrbi9oOWtONEVPbE9IdUI0Ynl5YkNnUS9t?=
 =?utf-8?B?NWJiekh2eEN5dEVkeHliZ0owcGZ2VjlORWFDSzd1ZXZqUXFpS0lqRzJOQUJu?=
 =?utf-8?B?SEV3UTVNT0g2VHlqaERsYkltTFZ5a1FYTjljWUw1aUtnS21GdGQyejBISVJm?=
 =?utf-8?B?L1VJSWVUTmplbnRES1JDTzgvaitxbGdnZ2YxVGJueVdRejNSSWhQQTBuWXly?=
 =?utf-8?B?VWFXRVVjM3JTY1dMVkVjWkV2cUg1aUVsMno1cG5mbVdlWjAxK3o4cEc2d2E5?=
 =?utf-8?B?ZTJmdjhCNXNSNlpvZnhNZHc2NGxtMGNsaXRoL1hTOFVUVi9yVzJVWFpKTFRy?=
 =?utf-8?B?S2R1Vk9iWFBLbUtSUnZaSU9qMms0Q1Y5Tkh0akFvUkgvVmNOSXhvUkNpQjZp?=
 =?utf-8?B?a25WNVR2U1F5WDdoa1A0MTdZUHI3UEJaSXQxN3NmMUc0bVcyZEt3eVB5akVk?=
 =?utf-8?B?aHVQcWJUV2hWUjNZdk9aMXh1WmpIQnJ6clV5cnZFbXAxRUtnamFDZDN2ekNJ?=
 =?utf-8?B?eEc1MmF2WnQxZGxNaU9nRjA3eWZlQlBKVUxJRS9xcUhUQ2E2NUtlQTc0WFZP?=
 =?utf-8?B?U0tCcUhsRzd0TFQ0bDZLUHlmY1k5QmlnUE9Ec3p5TFFaRUp2S1VCRWdzS0Rj?=
 =?utf-8?B?dWtBTStnSjlYTmcvQ2FTRTRiS1dURW5YSlo2TDk1dHpXc2t6aXY2RlhTQ2tH?=
 =?utf-8?B?R2FZL3lvN0F6TkhXc25vc2d4Rk1LMjhGamdyY3JIdlJWdVY0elAwMWpLZldi?=
 =?utf-8?B?NFFUMVJpdWUxdCtONkR3ejYrRDBldllnWkI1UXo5Mk93NStMaWU2V0tQekN4?=
 =?utf-8?B?eDhKamhjOHB4dm5Qak4wd0o4QStEY2dLSkZwcVVqT0xteTNLaEFxeG1ibzkv?=
 =?utf-8?B?ekZRbnlMdTRBZ0owazJ1TVpxT0d1KzUrWlQrek9ueW02cjlmMEs1NS9zekdK?=
 =?utf-8?B?K1RZekg1a2R1enhka2V1NWtwanJoVkpNQTkrZ1EwaEl3RDBGdVowZk4rRE9s?=
 =?utf-8?B?ZWU1aE10eHBuRU5BL0hLMnM4ak5kdEZRWERBZ1YzY25XYkd0Z2dOREYrc2Qv?=
 =?utf-8?B?bmxLb2RTVGN4Q0VQN3RjN2pDZTJOaFN2K092eEVFY2NhTTlOVFZreGlUMzhs?=
 =?utf-8?B?M2dUUzEyTXdzK3lLa1puNVM2QzliUFVKUFQ5ZHJ0TWVCUXNLMC9CWEo4TCtF?=
 =?utf-8?B?aWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe8d697-615c-4ea2-1a0e-08dac202af75
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 03:30:01.7006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AHFMaIU56jdDFecEeYPbYGHj7fKlsT46rzVNF6GEFs+Z++sM5Rd3YFclm4tTA23Gm/CoJr9/sVlEGP1DBoWvNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4594
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/8/2022 7:03 PM, Sohil Mehta wrote:
> On 11/7/2022 2:53 PM, Jithu Joseph wrote:
>> IFS test image carries the same microcode header as regular Intel
>> microcode blobs. Microcode blobs  use header version of 1,
>> whereas IFS test images will use header version of 2.
>>
>> microcode_sanity_check() can be used by IFS driver to perform
>> sanity check of the IFS test images too.
>>
>> Refactor header version as a parameter, move it to cpu/intel.c
>> and expose this function. Qualify the function name with intel.
>>
>> Reviewed-by: Tony Luck <tony.luck@intel.com>
>> Reviewed-by: Ashok Raj <ashok.raj@intel.com>
>> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> 
> ...
> 
>> +    if (data_size + MC_HEADER_SIZE > total_size) {
>> +        if (print_err)
>> +            pr_err("Error: invalid/unknown microcode update format.\n");
>> +        return -EINVAL;
>> +    }
>> +
> 
> The wording for the "bad file size" print seems to have changed during the move. Any specific reason for this?

Thanks again Sohil for reviewing.
Only the next print, associated with the version check was meant to be modified. 
Looks like I mistakenly updated the one above also.
I will await all comments and correct this in the next revision.

> 
>> -    if (data_size + MC_HEADER_SIZE > total_size) {
>> -        if (print_err)
>> -            pr_err("Error: bad microcode data file size.\n");
>> -        return -EINVAL;
>> -    }
>> -
> 
> Other than that,
> 
> Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>

Jithu
