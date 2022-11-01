Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034A76151A4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 19:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiKAShp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 14:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiKAShm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 14:37:42 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7667E1AF00;
        Tue,  1 Nov 2022 11:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667327861; x=1698863861;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Vixn+OAUCYICXDkjZhJuixt1K2HTgAZoHIXd+dYB/oo=;
  b=d18afC6Cf1KHeD7afWlxQA6cCBjuBx4zFbXlcKNdSmFr1Ae1TqJ2eTs3
   nbgXAz4j/LSyi6814rgg6vN9rR8LnRlq2yCJaDm2p7xo5T+AH/2dVk1BG
   Sp9HcsxIA0gBtzinAqf2XkZD0rUdeu5xQae+OJ/TdOTV/bZntb4M1Qlpq
   WPflaWzObyNLvlQ5Xv9KcyOp0vBTl5bVz3p0d3bcsHMHi2ojArjPAx7KS
   DZuFj0mk1KQ7CtZT1qHLHkrSE3qyZt5HEM2pv4M0xRUkAgDAQpqCAz1at
   S5k3Hn9ek5PpS+xyDAVuUdHQ0uNrhl/lZlrHR9CZlSkBUlPAGNuRWdbeO
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="373431187"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="373431187"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 11:37:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="963221802"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="963221802"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 01 Nov 2022 11:37:40 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 11:37:39 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 11:37:38 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 1 Nov 2022 11:37:38 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 1 Nov 2022 11:37:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZCm07o+NLAwfJF8wgW0AajAUaBMr1g9GRClPDz3mHRrd4cQSCzEDNWacR+WdnKT91bbXYiTdujNre+yHQTvlZuhbFLgihIev+FlpJAvvuJeQ1iGnytyEEz9VRlXLqjIpGeLHpAKaipXQ4NQz0oZKqaGpq8EtQNlzfCn3kklHYVjJs70T94pCwpICQhJWrWDl5px2d3fbsXFRCVGEbYAivlkaR5P+Hba4E/7D3aBVeq0mSiA+985KzlgqpvLThLZz4qHFVOuQG2VJ5dTLfuDSZvq6SghGra6g8wiOAMZtlE0jH4Hxlq6WnSry7MXKzJmpLpmc5MpPvR8lYWOupr8iyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwp0NDwuJsJRUmKfJ+8MnpkVReMpFoZnXGSNu6GiseQ=;
 b=MbK3M/aoPahWM4S2uF10uHxyD2GsJh7vLk17TMVUF5umnWDhwL+ywVDR3ni2/+jTSym3/Qc/qRE9uFsW8Uyi13PHGs14bXbttz1WmELTZBqyvKCvtB7IHdlRr5KwyoBbRiDT2zoB7r5ZpmzX1uUWLzvVPb9/ZLyIqk4uRTZbwV7kShdFQd4s7uxPLKS1VKVSmaJWi/qn9X/7A4G9OJFmbcSVmKwn4OmpEiTZPlN67swJc3IV1SvP6mnQUcJpPyu+LkH3zL1114UCGxa/jOemfuWM6t05JGbJlmIMzR3m5I0PrEDVL1i/HM9xcWgehF8TGdzr+s8ZN8rufkhjWOyXDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SA2PR11MB5050.namprd11.prod.outlook.com (2603:10b6:806:fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Tue, 1 Nov
 2022 18:37:33 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e475:190a:6680:232]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e475:190a:6680:232%7]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 18:37:33 +0000
Message-ID: <8cb7050c-d8e4-08ff-fb34-1df207a738db@intel.com>
Date:   Tue, 1 Nov 2022 11:37:31 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 09/14] platform/x86/intel/ifs: Use generic microcode
 headers and functions
Content-Language: en-US
To:     Jithu Joseph <jithu.joseph@intel.com>, <hdegoede@redhat.com>,
        <markgross@kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <gregkh@linuxfoundation.org>, <ashok.raj@intel.com>,
        <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <thiago.macieira@intel.com>,
        <athenas.jimenez.gonzalez@intel.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221021203413.1220137-10-jithu.joseph@intel.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20221021203413.1220137-10-jithu.joseph@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0055.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::30) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|SA2PR11MB5050:EE_
X-MS-Office365-Filtering-Correlation-Id: f9410250-68bd-441b-a898-08dabc3823fc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SwsI9NJadIfTofooiA/NdE+WYfUYk7zfQwgzUX2B5SToKoXXEN6Kw8D0E8ZyJcT6y9cSKPdVvDbc3FUCZNtMlY7K00TLsCIm5Y44Y5oWsT2Kt/k9ouCt3iTZUUmhc1+mreVL8UtqEdhUeERLbzk9+d4O11bXGCk2xuSZAQ/ZMF7ncXcEZoWcOP78hPMxS85zT7du9P42Ga10QqSaFW4tI5SgcwG+R4HtINWSGN5bFOHKFszbUugKkrNuc83D2iNs9aesOCNDxwUKeghNgas3esFTOUtxRAseFQ9HR+Zx3+0maM/SbH6nL5O0SEaxGC7fkVSNz3zx9Mw4D/oma8YsaNclwAS1p1YCiVAJ/1nKcrlYCRS3aU77kRRXTKhaLyrD1/T+DNjvCiGy5BCCgzGqvl9m/iOTdQkrGOYL6puIKJApJvE0Ky+a1ZyxklLxa6dbI294JDLRftNuYQNqR62SOzarQOYIU1OMHm9y0XfGaQUi3Wjx6lXj8JQ9lDG32s0hhDgN7nm5u8NtFs4jTORtdxuhzTanbIRpThxhnbw10MFixCaH0JMmW2EZkwt/PG8ZgJllc5uG41oMjSJcnouCtjcRrML7xLSSWIPOeGdJZ9zw8EcYRMQyfh6uD+gYCcAM2FPUR7sMd2yCb1c9xmbGAgmRJwcesCYDirhriUbzwF4TZ89/vurXr2joDvTkQ8faMELZPO3iWOBtcCVtQGcTKBIjVfHcJiaWWUWL3NdwGKuszUg8/TYreDwQDuH8wVpYz9OcrLGxRM3/K/hKRj79P/gpJQ+z+R9Qw+OHb9Wsw53kbJVFAdGLx+Lcw+hKcXeT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(346002)(366004)(396003)(376002)(451199015)(36756003)(86362001)(31696002)(31686004)(82960400001)(38100700002)(2906002)(83380400001)(44832011)(26005)(6512007)(53546011)(2616005)(186003)(6506007)(478600001)(66946007)(41300700001)(8676002)(316002)(66476007)(8936002)(4326008)(66556008)(7416002)(5660300002)(6486002)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGlSam9BeUJUT1ZnUkRJSXl2VVFmVTNRbTM1REhGREEwc2FNakRCQkZudUpL?=
 =?utf-8?B?QTN4L0VncHRabFVNS3BTTVRQTUpZLzRpQlBKdU8zQ3JyYmZZRXRMTk9zelNK?=
 =?utf-8?B?UDlqY0Q1K0F2ZFJnUEJ1bGMxTk8wQVBBdTEwVXlUWHlZQ2RPTG5mU3N3c083?=
 =?utf-8?B?MGoySmE2Y1dJZ1pZcGJaTldKT3hGTlN2bGZRb0pLMk1OeWlNU2hFUEpDQ21p?=
 =?utf-8?B?ejJ1cnBVMnZkSmxDWENCSmRQMkpMR1c4N0RkbmJ4SVNPaWJ6NzdEY2hTdS9M?=
 =?utf-8?B?MFNDZVcxOVFxa0doYytqVnhOQmM0cDBxd09UYnFPR2piN0ZuL2RyOFdDQVZV?=
 =?utf-8?B?T2VtYmsyQ2hqaktiNU9ibWRhRXp3ZWo4WFd3MzdrQW9SMTZaTVVHeDN0SmVM?=
 =?utf-8?B?bkJYa3FuNWR2Rk8xWTdqRGNCRHpRb2o2MzJ4bVlFeStTa1dKb0VPY0JBcHFJ?=
 =?utf-8?B?RTRNNGxnMFpjM1E3RjVOQ1Y0VlBXTFVjSGxlNVJkRG5ZZU1FZFl4SFYyb3kv?=
 =?utf-8?B?V3VIMmpGUDdUUlA1N20vL3ZYVFFzZnBKUXZ5Rk1uVjNwd2JRWllkRGlZTkVZ?=
 =?utf-8?B?OEFLdVBvQXhVZVluYnVtaXd4ekNYdlphT25VeHJQS095eHB2eCs4QURGRWxK?=
 =?utf-8?B?b3JwaTBLR3hKNXVNZ1E1ZGM0Q3I5KzRzVHhWR3VaRUl4V0duMDYwcEdMMmYw?=
 =?utf-8?B?Mm8vYktiMnoxV0hDUFVzb0orUDFpbkZrNmVzWWFraFR6RUtmMVlGdDJSTEZ6?=
 =?utf-8?B?QlZkSTFIM0pNR1FCdGN4Q01yNlF3M2hOOGhoZmJ6enpVNnd2V1BCSUpiZG9P?=
 =?utf-8?B?SjM5ZGgvY3JLeG9mSDQwWUp5SjYrdkZxTmYyRmhJbURrUDJ5UnNhQytvTVVz?=
 =?utf-8?B?N1VaZEVpeG9LMEIzTTNzS0Z4empla2JvdHRmc0pQd2dPL3orRjhCWVo4b2NR?=
 =?utf-8?B?bXVXb1VkbGNXK2RUV0RYQjREUFdFay8ya3dvZGZzY1RRR2EwZ3pyanBxYzhG?=
 =?utf-8?B?bkYzdmhBeW12VE4wVGJxVlRYa3c4YW5zRTRxVWZkWnhTVHFxS25RM3JkU2Vx?=
 =?utf-8?B?VXJlNTgxWHZaVk9aVXlXTGI5NUU0NE9MVjVDMUZtZDZ1WmVOZDZVTmxIa3p0?=
 =?utf-8?B?bHlJWUtIcVlUVzlUV2kvQjBBa2UxNWFEcU5pbjBQdTRzWERsa2ZCYmNkQUs5?=
 =?utf-8?B?UFd2WnFESUY3YXExQVl1N0tVUjgxR2Mra2hXNGc1STdvaXk1dVB0Szl2TVYx?=
 =?utf-8?B?d0gzaXRmVnk0Zi9OMnBTN3BlZ2NBWnhSWmJMMkp0M25wbjVwQVltdmo1WnR0?=
 =?utf-8?B?SVZVU29RTWVHUURTc2pFTjZHNTBLcXFCRis4SGdDeDYxSmh2YWx2bHJSRmsz?=
 =?utf-8?B?RjhHdzVtM1FleE1rQVNrdUdidHM4RU5JNlA3SEdUeTBVbDhXclpHTWo0ejhQ?=
 =?utf-8?B?YnVqTUpLOHBzdXBvaUJpNW5sY1JqQVB0WTJFbjZtelVZU3pJVWQ4NjFvYXVC?=
 =?utf-8?B?RUpMSHFJOTN1bU1adnc1YVhYTWMyeE8raGRuMWdQYkljWFZaN0svVzVnVnRZ?=
 =?utf-8?B?eUNyN0RXZHFSSnFHREpzb1ZvQ1RkZ011TmhudVB3eThXNEdyZDhnRFdsMnNE?=
 =?utf-8?B?SWFZN0kyWDRFWDVvNXl0cHoxdGFRc0szOWxXeG9oUWIwUmk5N29Xc0Zqay9N?=
 =?utf-8?B?em8yRkw2bTdocHdhQTJQUlVRdWdMTjRUZWp5R01wVzZ6TkJaRVE0QVduN1VU?=
 =?utf-8?B?bDd2Mk5OMEdOWTROaDFYZGZYaGgzTG9YLzUySGZvODRvd05hS0ZKR2xCWGgr?=
 =?utf-8?B?U24xY2JIZVNjZ3dZdVRMWVBtZElPdnc4L1NHZ2lzWEdsNy9YRWJuVloxdnRY?=
 =?utf-8?B?eW9xM1QxdnFvWkpNbGZ6emd4UTd4aDJNZWhZQkdjcWtpNjFzUXdjTUhtMjA1?=
 =?utf-8?B?NFhDVjVhSkZRWGMyRmtmVkh1L1BzSEFneXptNGh6bS92U0UrQ29kQ09BN0xl?=
 =?utf-8?B?YzI2QUh6Mzl3bUtFS1pxQTU2ejRPeU5xdlU0NnJtM29vME9tdkxPTDN6VGtn?=
 =?utf-8?B?S3VBRlZEeVM3MDhJRTlCKzRnSjVwRjBNV2VNdHp6MDBDaG9OUmYyS2x3K3Ba?=
 =?utf-8?Q?FIp7DLVZ/20nmrLVC4+V+Cg+a?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f9410250-68bd-441b-a898-08dabc3823fc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 18:37:33.6485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6CAfkFRGmk6bDHfoOhMlRrfuQ8d5Fam3i6Cz0o/Q6PkT8cehQ4PrRsTRCpePK5pZrS+LJEuiTpZL1KK7aCFHuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5050
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/2022 1:34 PM, Jithu Joseph wrote:
> Newer IFS test image headers will use  microcode_header_intel->hdrver = 2,
> so as to distinguish it from microcode images and older IFS test images.
> 

IIUC, older IFS test images would no longer be supported. Have they been 
released publicly?

What would happen if someone tries to load one? I am guessing one of the 
error checks would catch it. It might be useful to describe this error 
signature in the commit message.

>   
> -	if ((data_size + MC_HEADER_SIZE > total_size) || (total_size % sizeof(u32))) {
> -		dev_err(dev, "bad ifs data file size.\n");
> +	if (data->hdrver != IFS_HEADER_VER) {
> +		dev_err(dev, "Header version %d not supported\n", data->hdrver);
>   		return -EINVAL;
>   	}
>   
> -	if (mc_header->ldrver != 1 || mc_header->hdrver != 1) {
> -		dev_err(dev, "invalid/unknown ifs update format.\n");
> +	if (microcode_intel_sanity_check((void *)data, true, IFS_HEADER_VER)) {

I referred to this in a another patch. The data->hdrver is already 
verified above, why is there a need to pass it as a parameter as well.

> +		dev_err(dev, "sanity check failed\n");
>   		return -EINVAL;
>   	}
>   
> -	mc = (u32 *)mc_header;
> -	sum = 0;
> -	for (int i = 0; i < total_size / sizeof(u32); i++)
> -		sum += mc[i];
> +	intel_cpu_collect_info(&uci);
>   
> -	if (sum) {
> -		dev_err(dev, "bad ifs data checksum, aborting.\n");
> +	if (!microcode_intel_find_matching_signature((void *)data,
> +						     uci.cpu_sig.sig,
> +						     uci.cpu_sig.pf)) {
> +		dev_err(dev, "cpu signature, pf not matching\n");

What does pf stand for? It would be good to avoid abbreviations for 
error logging.


>   /*
>    * Load ifs image. Before loading ifs module, the ifs image must be located
>    * in /lib/firmware/intel/ifs and named as {family/model/stepping}.{testname}.
> @@ -252,12 +189,11 @@ int ifs_load_firmware(struct device *dev)
>   		goto done;
>   	}
>   
> -	if (!ifs_image_sanity_check(dev, (struct microcode_header_intel *)fw->data)) {
> -		dev_err(dev, "ifs header sanity check failed\n");
> +	ret = ifs_image_sanity_check(dev, (struct microcode_header_intel *)fw->data);
> +	if (ret)
>   		goto release;
> -	}
>   
> -	ifs_header_ptr = (struct ifs_header *)fw->data;
> +	ifs_header_ptr = (struct microcode_header_intel *)fw->data;

The use of a global ifs_header_ptr seems problematic. The semaphore 
operation before calling ifs_load_firmware() makes it seem concurrency 
is expected. Can ifs_load_firmware() really be called concurrently?

If that is not true can we use a mutex for synchronization?

Sohil
