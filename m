Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13DB6622265
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 04:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiKIDEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 22:04:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKIDED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 22:04:03 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F075B10FD0;
        Tue,  8 Nov 2022 19:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667963042; x=1699499042;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7Imrio/RVZAKxA5KJy5S+2AIyNHHZPv2uH+41zMrodc=;
  b=KQpReCtmJdsqxOMgOz81OapRULZ6dmdYYIeuOK6c/EVBQURmM5yMsqao
   Qy8wV9+SLMcQxN6MqjQVRo3+NpAC0LEmVUjTc+CKUFcJdedukEOuReeXy
   R9pP03+ou6/Y1/23na2kwOrb4+sDAqrnspdBraWkvxrtU3qOo42K3Ud/2
   DQNVuBbrqe4gmasrn7LKNh7/0FjcJxxiWZGigMVEuZjDXZ+qerB/rXZvs
   e2VT73M7j+p/1O5kmR83MrapfJAXjIbCcArOZk9hoqd484woTlz4G7dsw
   NAPRJNH6gPZ51PZ+tosy97t9ANV2PxCzPLbNh0uYB2QGPLI8wpf55tqu1
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="312669235"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="312669235"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 19:04:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="614513929"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="614513929"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 08 Nov 2022 19:04:01 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 19:04:01 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 19:04:00 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 8 Nov 2022 19:04:00 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 8 Nov 2022 19:04:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iH0dj/wlkL9lcNwIAgsIgLVRMkE9wTuNVBCgbuBptBaQNQDeNLeFZHKUEVlKGyTSJEsT/M5dOUVLzJ5EwAlcEwxXFW7PQzAEf27Ho/GpPllcsZI+RIRbjuhEJkNS5GIgCmBJ3J/Km2DIDyg3XCchDtrOd+ghwj/fCWR5CmVjao0vcU4WuM1IumjPXgeK2pUp+dqw/zgHVsaNbM1UOqPqAO9QTVQ2FbH44j9CzozTYM+pceXeQGKPYqCBYdFAqSEz7dfmvIJvQ1yIQi85WQFQHfhZ1Ej2eYa3sGAQ4SbYgfKb3LfobIj3BqvjcCun3uU0nexE+AAe23C5cMw0v8opQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n1oqUvT3nsYc6RXEsN65IAs1+dPyPVKhODsLBwFIwO8=;
 b=Mo0m/vMnOg5IZYPClAxc/HQ8o2HeDWYEqSVsZWWIVwrS5LZpvEomTb2tk82Dwo8xuM/hRRSoyzus2V4OG0xjKNfjkiC9ETUtFLbln8E/oxxj4f8MWKB5mFg3AcmGEGSbYMWI/jgKSENUeewsT2R8g/DVnwMzj1iXdd8pFaF9B/vD6UI5+oeVrIQSUEmGqvrWVgMoVOZYVAVMedpH47aWkAzAHgjpnwrnTfm8VQQ7mPQMI2daXPmDZmHeqlv2JHhrme0EZH6e8lpsLkuBDZqEZX0sEoSbiahdqZyq87TCf0NpJQOITOYkQbXf2Cl17xWF8yu2aFJqSgoemVJk6NRYvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by CO6PR11MB5665.namprd11.prod.outlook.com (2603:10b6:5:354::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 03:03:57 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e475:190a:6680:232]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e475:190a:6680:232%7]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 03:03:57 +0000
Message-ID: <86c46504-f769-1187-2aba-5b8b58654b33@intel.com>
Date:   Tue, 8 Nov 2022 19:03:54 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 06/14] x86/microcode/intel: Expose
 microcode_sanity_check()
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
 <20221107225323.2733518-1-jithu.joseph@intel.com>
 <20221107225323.2733518-7-jithu.joseph@intel.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20221107225323.2733518-7-jithu.joseph@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0017.namprd08.prod.outlook.com
 (2603:10b6:a03:100::30) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|CO6PR11MB5665:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a706645-632f-489f-7502-08dac1ff0a84
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aRP/lZbrvOASghDkXMZhfnJqemXU+riYal0HA9vzwgaXR70241i71CAZ0WAgZ03OWRtaO/Xa9wRscswwj8j1oBLB50Nv2heZRo5npq33MhJbR6z2sKtT9szCBqi3DF10vh01kMqE6w9+ijJMko12R8XBJvcZX9EGncp+4o5tx984HVpyaz7fs7I4r6s7G8hYHn1ZgLNrVx7KYIKytIXMjTwwOOIXAIQEmWRvsFeFrSqvJ3EQvp0HVeKbZn7UKOpxQNNs+ZGOWr3JrRkrPDD59UAtqGxLn4xfhKGQsDJu/JsjNPEfWTjRVER0th7z8SK3YZkRmP+5yvITEdtuuwpF6sXnpAXF0p3b33a4IQKZjaaArsDRV7NCPjXUGaRbsUFDRESVdtdwbk+uRzwV7M5Q64Ha7Mme3lbWcdaL70tFSzSpxxbKWn2/wv2FiLn43C40oVSiQEflLRwgiwCZiAqg+wYfxlyAKh3BoCorhDgJv8su8GqjgxYZSPsjltbFhkUC2a5BE3DBXXe5/0ppg/Mxfwq7NEj/I5qGnjsX1pS+II9FVYO2Jb5VWvzNmPIaDG9XSig76t8e/NuC8CV+N/Cs4JFMwFge3nRtfo32leWWjiaZMLuHywyulRXjfTnkH58tGPCVTrVnfejkbjLMmW00H/gg7wqdexGQnssTbC+MaSq5SvJ/22HEUsVScASmrkrEhOGUT175CZ3IP3RQ/cI8//Dh0Kc52ePcgOkTV4vs1l6XVy2YSOqmQUYB5BeLIzzVyKoiK1mD5B5nVYBQ7Jj0HtKQkCV5DEvI2DctP/0uNLQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(346002)(39860400002)(396003)(376002)(451199015)(478600001)(6486002)(44832011)(6512007)(2616005)(186003)(2906002)(83380400001)(82960400001)(6666004)(36756003)(26005)(6506007)(4326008)(38100700002)(53546011)(8676002)(31686004)(316002)(66556008)(66946007)(66476007)(86362001)(31696002)(41300700001)(5660300002)(7416002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVRCUU1NeWZBbEQ2eENvZU05VWpHaEZGOUNzTGh2Z3JhbHZSQ1A2VHphRW8z?=
 =?utf-8?B?UFQzRzdnMDY3T3NhNm9LTkc0M3E3RjdWNUhlMzM4cEpVdUM2OGwvb2F0MUVj?=
 =?utf-8?B?ZTBIODdlTjJoYkt2MFhIM1dTWXF1K0Q4anFHdytoMGlIWWN3MGRLMEQ4dGZ0?=
 =?utf-8?B?SkZZbHJPeTdjQ2dCbW1ocGdHaEp0OThnOFJKL0x6MGhEeTh4elZQZEw1RnVR?=
 =?utf-8?B?Z0N2dGFmRkV6UmxNVTBKNm45ZTJFdkgrZTJKVUJ0RUtYQm9qczFKZzJNNGZq?=
 =?utf-8?B?Sm56UjVLOFR0a0h3RTFSaFdKb3RhWnpodFBJMnU3VlpRRXVCSWVmRFQ1NjlW?=
 =?utf-8?B?Y2FKcVM3OGp6NW5uV1N6ck9UU0JNeW1UK0NyKzRmQ1FBQ3g3UnNTYW9raWhj?=
 =?utf-8?B?NlFBWEdjc0FYWWhPZUxhMjJCMDVuNXB3d0pCNVhRbWpLMEJmUHU1ZGRPdHpD?=
 =?utf-8?B?MlVYdkhsUGVxcFNtcjdONVhJZnZvaUlLT1BiMEZsUXhONWI0TjEyR3cyTHJl?=
 =?utf-8?B?M3V4VHppWUpiMXhBRmt5bE5TOHVFblVIVk9yaDJwOFUyYjRYeG0yaW9OeStG?=
 =?utf-8?B?WU0wczVWUDNqYUFUUEI1TGJPN3Zlei93UmZaY1YrN0I2dVQ0RGZqRHpiZ0dk?=
 =?utf-8?B?UTN3WksveVp4dTVVVFJ0RDlRM2ZJc2o3Um1CSjY0TmNBdDdyK2szOCs4Rjlh?=
 =?utf-8?B?aFA5MElWRngrdU0wQUswZ2pxNENhOXVMa2E1Y1NGLzk5WngzeWVQTG5VWmRH?=
 =?utf-8?B?c28vK1EzQnNTd1M4MG1Sa3FuRFkxeXZyUFpQS3VpNVc1cU90SWlCaDdoYy9J?=
 =?utf-8?B?UFRzb0dXbndXc1VVNmZYNHJic2NtRXJRTHFRSzlvL2ZYOUgwQmF5YXNjRkJy?=
 =?utf-8?B?NSt4T1NtV0JxQVRFMElBNTRSczZ3azQraCtoUUd1bkVUYzB0Z1AxWFNwcWFK?=
 =?utf-8?B?NmI2WEhGR1BTOHIxNjhlZmhUNnVCdUtLc3lwTWJpN01QMFBtNGNPdCtuUnJK?=
 =?utf-8?B?L1c5OU1zcytFbmlsUVh0RVNsZzF5dk1jK2dRNTRDR0dBRWJsTmdIc3gxWXlL?=
 =?utf-8?B?Ui83QklUeTh1UDV3WUFKT09BY21tV2RwbFZWb015d0sxZnd4UUh2RGM3dk91?=
 =?utf-8?B?QXBsbUJ3UGxiYkN3ZnAyckd0aVF2ajJLcGxQbzk1SzVyLytUTXhTQnkrd0R4?=
 =?utf-8?B?bjhHdjVValRCdXQrV3FxK0VNajkzcTR5M1JqTHljYlBXVXgwcXBqZmtxL1V6?=
 =?utf-8?B?V2c1aDNUaU8xREoyaEVoNUhlczlzVTZJSGRsajRiRU8xV01Vd3N0cU5qeFJo?=
 =?utf-8?B?T3lXR1NsSjRSWk9UMjZxSHdkUVN6L0dPRmxkUEFxaCt1SFc3M1E1cWVLTmlv?=
 =?utf-8?B?ZzNuU0dsNHZxSTVGTklwWlFGTFNFSXF4RWk1VVJNUkdvUUhKaVowWkVFTTJM?=
 =?utf-8?B?T0hwemFkb3JvTU1ocmo5M2xoVmR5NUJKWUtwM3VaL3ZTRllXNUtUL3FOK0xI?=
 =?utf-8?B?MWk1dDgwRyszdzdwSStQZW80RXBkMVovM2M2S2xkdGsvNjBoWVUrOVVxNVZK?=
 =?utf-8?B?dFJicGhaZTg2ekxHUW5JYTFvbEJuSkx2cWdGTWhsU0hVUWZvN0ZLZnUzMWZo?=
 =?utf-8?B?SWpFQ3JlVkhzMnpSZEFmQk04bTBybmlrU011NWMvb1p0a0YwMWh6MlYxb1N1?=
 =?utf-8?B?bEhodXJwRXBRNjJEWDNveWNOUi91OEcvSk1GYm5yWThqbkZkRjNmM1J1Y2la?=
 =?utf-8?B?VEUxRXdLUkMzVkt3MnNpQ1kzdW9GR1Z6SHI0SWMzcnJiNUFodFdKaHVsVUsz?=
 =?utf-8?B?SDVuUUFTNnJVaWNUTHh4SmhLYWtIdCs0dnRRWFhBcWdHMWd6YWhIMWhYUnVv?=
 =?utf-8?B?ZE9vS21yV2g5WDNZR0p1OVhna2Z3S1p6SE53OFZ1YjJsemM3UjdVU3dZZG04?=
 =?utf-8?B?aVZDWTJITGdCTlB6cklEazN5UUVpWVprUEs0OWVsYUZPM3pHWWplK1hVU0lD?=
 =?utf-8?B?amtOUVpIZDNoTUVEa3ZDUlVwRDgyNGVFRmpKbDJhYkduZHVGUmlMclloR3ZP?=
 =?utf-8?B?VTRYaHlFa3A5R0lDb01BdWROSTRvd2RvZkMxaW5wd2RGdlVZSmRnUWg0Y0Y4?=
 =?utf-8?B?SjhuSUQwblcrTDBmMHNhMmFyaVRDeXZlbWVuNVBoNjF2dzhRdHYyRnVPRmk5?=
 =?utf-8?B?SHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a706645-632f-489f-7502-08dac1ff0a84
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 03:03:56.9401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ezoXdG8qTPo/L1QANnmQmfjnRTDu5pRvh/PJ0FpxPPWil70EWjSizJSVk9V6paJzNlKolicOffPQoahrBZgGTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5665
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

On 11/7/2022 2:53 PM, Jithu Joseph wrote:
> IFS test image carries the same microcode header as regular Intel
> microcode blobs. Microcode blobs  use header version of 1,
> whereas IFS test images will use header version of 2.
> 
> microcode_sanity_check() can be used by IFS driver to perform
> sanity check of the IFS test images too.
> 
> Refactor header version as a parameter, move it to cpu/intel.c
> and expose this function. Qualify the function name with intel.
> 
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Ashok Raj <ashok.raj@intel.com>
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>

...

> +	if (data_size + MC_HEADER_SIZE > total_size) {
> +		if (print_err)
> +			pr_err("Error: invalid/unknown microcode update format.\n");
> +		return -EINVAL;
> +	}
> +

The wording for the "bad file size" print seems to have changed during 
the move. Any specific reason for this?

> -	if (data_size + MC_HEADER_SIZE > total_size) {
> -		if (print_err)
> -			pr_err("Error: bad microcode data file size.\n");
> -		return -EINVAL;
> -	}
> -

Other than that,

Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
