Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F9E61513E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 19:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbiKASGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 14:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbiKASGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 14:06:08 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538911DDF5;
        Tue,  1 Nov 2022 11:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667325927; x=1698861927;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=t94e0v9TrA1euDGCmnVRXWxG8GY9ryuqaXfPgYuyRzE=;
  b=mPwd/3C4DQ7JBPNS7g9PxpJcCtlyyaN+yCMGHhzkPmuUyhmkMQ/HPHFl
   TjmP/EWFUjW/L/BQgrxg/lsz/IeTC46wJ4ClPApQtVbyiAahvRYSf1Bog
   gLMMFOzDBtuZHEcR8ySelqWAJQKuFS2T4ZXHwPKT1Clh5cZSjvOVZZzrJ
   3TTqTrlc2VqJXVhAx22InYv5x50KSGqOqZgpI1M2t912W82H1xIwxHdVj
   rlpvYcAydYhOgzmb/ManVyKOuGG4gFqCx9KgaR1xB+hq6UCV1S0I+1e8U
   9VYaSN1BJXyBli/hLUhMeNaExD9KUVI34ejaQkwudEPtGySkB23VsSjQM
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="310303167"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="310303167"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 11:05:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="611931633"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="611931633"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 01 Nov 2022 11:05:25 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 11:05:25 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 11:05:24 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 1 Nov 2022 11:05:24 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 1 Nov 2022 11:05:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7xGmzYxmdcbxqeB2Piu8CiZplu3B5fD3++ZCQTD9oGCRq+kohxRr46eRIp5XUo2kQX0W0R+48i6dZCFdRigKHIYeCCxj80zOgc1oEGkx7P+b1dsCCh84WSvJyUudjlzmfY2DfpPZPLoXcVFvQbkyfA1xkXRbSVWsQyYeev6bDJsiClC/4kxpj2loid257XsTatSm+d/3iqLSEXV/5VJ8N2/gOcLpowKyVPnOyCGf3MaGiI6cQfcF43JfveeT/dD0JKJjtYlqDIktKluV7MSk3URAoUBXQfXWspJJIgeQ6JgmCxQc1EPunA8gdDBKvhDl1vV/XtOm0FGYQ1Cq8xFwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LU9k/CrCCrP2PAUNj82dQ1D8JiwGsYj7Zzf0GAaMIZU=;
 b=W7b2pS8r2ANBD00KRDQa6iLy48keGZEt0bNrA5mYI+vVCNAW0rA4jy/sw+qYjKbRwDxcUXGL5tk0GqnA9Kbcv3oXL3mpTU8wc3fqihtqNL7eFm4IXz6wzIYV6RFGs5wSnRzcdVWMQL5XN6TDnBZQhxZD33XImNa0mGnEUmf5g0Z3bfed9H+nY1SQYMB6THa88GcDNYHsBVpJDL6FEeDtPyinrJ+lW5ScW0CvnQa1viIkweqxfGhPdySj+3DTapKAFsGcLv1J7JR3fd+lXcQ4gKTaTgjefdT3nmqhMYPxzuxEJaP+uMRs1iL+Huexo0r2KGeQAhSbMDCa7TfwaTgIBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3771.namprd11.prod.outlook.com (2603:10b6:5:13f::15)
 by CO1PR11MB4931.namprd11.prod.outlook.com (2603:10b6:303:9d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Tue, 1 Nov
 2022 18:05:21 +0000
Received: from DM6PR11MB3771.namprd11.prod.outlook.com
 ([fe80::c5b4:b2:b261:1562]) by DM6PR11MB3771.namprd11.prod.outlook.com
 ([fe80::c5b4:b2:b261:1562%7]) with mapi id 15.20.5769.019; Tue, 1 Nov 2022
 18:05:21 +0000
Message-ID: <adc4ab86-ce36-cdac-8f9d-ebfeae5032f6@intel.com>
Date:   Tue, 1 Nov 2022 11:05:15 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 08/14] x86/microcode/intel: Meta-data support in microcode
 file
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
 <20221021203413.1220137-9-jithu.joseph@intel.com>
 <7ceeaf97-fbc8-54ac-2041-75f2ca8bc7e2@intel.com>
Content-Language: en-US
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <7ceeaf97-fbc8-54ac-2041-75f2ca8bc7e2@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR08CA0056.namprd08.prod.outlook.com
 (2603:10b6:a03:117::33) To DM6PR11MB3771.namprd11.prod.outlook.com
 (2603:10b6:5:13f::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3771:EE_|CO1PR11MB4931:EE_
X-MS-Office365-Filtering-Correlation-Id: eed37a01-b0f7-4832-ad17-08dabc33a36d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qb90rbE/PRELbX9Q9gJ5B3NSGIYPa24WOXzT0ziUB1QtCfayj9o7XwWr40F2gVhXBvPnuh845YFPLcygNvxoqmj01XysytHLQR0wCOyOHaVU7/zdvwtPuhfMwwj34GejDI91kSskWVk3aGascilMFIK8ncL2vyWExzyRKl5qFFjK9+VJxA2wdSc2hYgOIxK/U2flvqH+Sx4fEfkmh+ThZ0Xj4Wnm2U/LUtLPlreHvQSOK1L/5y9X2En80LV+g3yBrIGChHcy9LOfgNYkQGW2QGHJK0Lr7HUP3xYiLDpGbhDzrVSot94mssqX2Ow2LuUZcArDTIX0zFxswtAlOA0A8FpiXVe23UIiLsu6+fXbwAB30m/vvlbODLwyb4RaNqi0wFUxaRt1/ib9yIXSIfcfsW8JvmyfUNn9wZZ963Rz+Hp0ynFOSFpFqIrVIOY3Gw7LrqKe07Bbw09Y1wIvdflimZwGzWs9WL9ueP+PwIPKWTsruQlRT3nFD1KN9yZa+bQfbqcZh9W0igUw9VsBn6EYM2GkWa7fDVuW5YWDt1rDUP8UzfdwsiC4joHCWpXKqJgbGS5Ck7TzgGsVZQ2tRy0lw695sjb4mhd4cxfR/I7OtSZ58sT0fW04Al88bc7SIQGMMdeqK3qKEDSzsUkr6hbkfEVRflvHNaqvSudxjBtPkFP5jnrgOrBeHh5pXDYWy2I0bjyYV98DY8M1+iB8jMdujkzS/uMXxF/22cDKY0kEJlcZ1vV777O3HW1imtV+s7oyA7US8YkcsbXSajzRfHScNfYrboqJQXwMtlt0JUiO0Bc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(346002)(396003)(376002)(366004)(451199015)(31686004)(478600001)(6486002)(2906002)(4326008)(53546011)(316002)(31696002)(86362001)(8676002)(38100700002)(186003)(6506007)(82960400001)(8936002)(7416002)(2616005)(5660300002)(41300700001)(26005)(6512007)(36756003)(6666004)(66556008)(66946007)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnFpYWpINFhiUCtQZHRRYUJFN1NuMVdDUTA0WXBuQStueUJ4Z3NqVUhsWlVK?=
 =?utf-8?B?a0RCcWhHYVN4a21IQ1c4NWd1VUNSRlpSaWl4MTdwTGtsMTdwY0YvVEQ2RVIx?=
 =?utf-8?B?WS92SllEd1FSZEF0dk96WEV1dUdQZkdvdGdBQWdjek51WllIVVkxVGRzSk1x?=
 =?utf-8?B?MFFhL3pZZDB3UWpieWFRR0l2dGZ0WnBaZHpiVUdUTXJ6K3BYODJRbGF1SStz?=
 =?utf-8?B?eVB5MnRTd1pESStwd1R6Vnc5dlJqOWY3SEVZVms0RmliRllIM3VOdzkzS3Rk?=
 =?utf-8?B?TmcwTEhINUFGaTZWY2dDNjZwOGtEaXFnL1UyZFFhNGczS1RwUTd4STVjOFlV?=
 =?utf-8?B?aXV0Wk9XSWFNMVUzUjFwWlhkbThJOWt1ZVJudGcwWkFiVEpNUWpZWWVlR2pN?=
 =?utf-8?B?MVZ1Z0ZabUFlWXZJMytvREJ2Vk5nU21ueXVZLy9tUzhVYmFhTlhFT3RsaUlJ?=
 =?utf-8?B?UzYwSkFBbmpma2Q5WUQreElEN2pheTJVNnAzQVRGbjRrMldWQjFDTjM3M0xp?=
 =?utf-8?B?YkhqblpmN3dlNEZDandyUEppNmF6WXl2ZXBPMS8wWU1VendMcU90UHBBd1kz?=
 =?utf-8?B?MHM3dGxaVU1lalA2VDdoaVdDRmNaSU1IWndDVnhBdHBrbjMxTER1cnRvTDAr?=
 =?utf-8?B?YVBQc0RpdzZUeTl2dnliWnlhSlJOdVgzWVQyQ1JDWjVXcmx1enpXbE03M1I2?=
 =?utf-8?B?ei9KNVRQTUJ1TjE5VWt1UzFOQlRud2Y2dCtLdkphMGFiVnhkYXBpRGgrYWxn?=
 =?utf-8?B?THFTU052dTZKRmRsMHVEYjVBMHc5cm5XQ1A5SWJQVzVLOWc1ZGRZYzFBS3pm?=
 =?utf-8?B?MFUvQ29Kd2hDdUloYWdKNzdtNlJvVFArMTlqODVDT2xWNEk3NFRUaGtXU3pW?=
 =?utf-8?B?WmdxOFR2R3l6ZGlXYWlaUDd5OVhuRjZvdVlERWRGSzNkSVk4OUt6REwrTTFR?=
 =?utf-8?B?b0xvamk0TkZ5R3hwdTBTNFlOQUNwN0ZmSHdyeVErZGZMZ1F6YTVOaHR1djNn?=
 =?utf-8?B?ZU5GYU55OHQzY2pGUHdZNnBQbWtkYmZseUdLdHBXSndTS2k5clZBQk15MkpV?=
 =?utf-8?B?RXFtL3RHZUhKa0FHWEl6SzdYb21vd1BqSVZtcDd4ZFVpSHphaHZWcXZ2ZzJ4?=
 =?utf-8?B?c1gydmNtMTZLVEJMYm9EVjJjdnh4TDVzSmtqc2lmQTJ2VEN0R2kwL21Jd0VD?=
 =?utf-8?B?bTZWTGg4MWJkK1BNbTdqVE45REJwZzJqYVZxUHFxQkd1aFpndG9WS1VkSmli?=
 =?utf-8?B?Wk5tOHhjaFFYZnhnOFlvVW5LeUpIc2I4TVo2bTl1eFlkZUNnQ3BuRXkrNmNi?=
 =?utf-8?B?WTB2RTdDcXBvT2VxMitPR2wwZDFFSGNlbWdmRGxyUjJpSFk0dzNNWHJXb0V5?=
 =?utf-8?B?VXZ2Sm1iWUJsNVZCMTFCa09jeHY4RzF0M1I5VFVYUURqV29aRElPbWpKT3Fr?=
 =?utf-8?B?Yi90MHZxQUZJd0wxbjFTbWk2TzZEM3FVTDdqVjd4dXRiV1doQktrRW1Pc29I?=
 =?utf-8?B?YVFtRzNWbGgvN3JUSVdXSU5CZDE1UGs1MGM2Sk4zbmEvbGUzak1nMmFLbm1B?=
 =?utf-8?B?K3NqdXFIWGFuUGN6RS9OdDdKNHlYcUsvSGZON1hnVWNiVFhuUlFzb3NLUEdj?=
 =?utf-8?B?SWl2cFE5b0h5bWZOc003Q2hzZC9YNTcxL2tyTm9mVXF1M0hTUHhYMm5RN090?=
 =?utf-8?B?QlZQbmtGWk9HVGpzNDI1ZThyeDJFWW1oUVB4RTA1dDlJV3lLUW8zcUtQQk5Q?=
 =?utf-8?B?b0Mza011Mkl1NkxJTWZ2MVlYd24zZWZpall1cUJBWXhlNkdyZjZnNGRHSEJD?=
 =?utf-8?B?WEJ6ZkVvUXF2Tm5vVkdiRHZQRUZoUFp6WlNCSFdJQ3l4KzMwRjlyWkh4dmF6?=
 =?utf-8?B?WVQ5YTk3NmZMQk5ZQWFVcUdtZXZUU1ZadWpGUDh5VUVVRlVoMDQxTEtYQkhj?=
 =?utf-8?B?cFQvSktiL3lrSjlVdlp6RDBMUjlJK3BKaXhnTEl4ck03aEQzU1lhN2FSSm5Z?=
 =?utf-8?B?dG43VXhXMW1YRGo0Qy8yU1dic1JyS0ZnQUZXOHEycVczZWFGcE80UG1OZnYx?=
 =?utf-8?B?MHB1R3BIelpIRVJ4OW1XMnVGd0krMCtUNE5kbFRMdzJ1byt0L2hvcGNYMkor?=
 =?utf-8?B?aTNOWmRMVTh0S09MZHpEelVpTURaNEc4UG1GQlhoRWo5Y3VUaWVudzRKaDRY?=
 =?utf-8?B?ZHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eed37a01-b0f7-4832-ad17-08dabc33a36d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 18:05:21.1948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i2KufUy5g8SE+riZYblbZK2Is8Pwsq/jyB4P0ov+0z5URdXH+dgn7Wvyx9I2gwiMtjsG6UlSAezN2AF1CHXkBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4931
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/1/2022 1:51 AM, Sohil Mehta wrote:
> How about?
> 
> x86/microcode/intel: Add metadata support

Will reword as you suggest above

> 
>> +struct metadata_header {
>> +    unsigned int        meta_type;
>> +    unsigned int        meta_blk_size;
>> +};
>> +
>> +struct metadata_intel {
>> +    struct metadata_header    meta_hdr;
>> +    unsigned int        meta_bits[];
>> +};
>> +
> 
> Can we avoid the meta_ prefixes in the struct variables since the struct name already includes meta?

Will do

> 
>>   #define DEFAULT_UCODE_DATASIZE    (2000)
>>   #define MC_HEADER_SIZE        (sizeof(struct microcode_header_intel))
>>   #define DEFAULT_UCODE_TOTALSIZE (DEFAULT_UCODE_DATASIZE + MC_HEADER_SIZE)
>> @@ -76,6 +89,7 @@ extern int __init save_microcode_in_initrd_intel(void);
>>   void reload_ucode_intel(void);
>>   int microcode_intel_find_matching_signature(void *mc, unsigned int csig, int cpf);
>>   int microcode_intel_sanity_check(void *mc, bool print_err, int hdr_ver);
>> +struct metadata_header *microcode_intel_find_meta_data(void *ucode, unsigned int meta_type);
> 
> Is there a difference between "ucode" and "mc"? They seem to be used interchangeably all over.
> 
> At least to keep it consistent across the exported functions, should the  parameter be named "mc"?

Will change the parameter to mc

> 
>>   int microcode_intel_sanity_check(void *mc, bool print_err, int hdr_ver)
>>   {
>> -    unsigned long total_size, data_size, ext_table_size;
>> +    unsigned long total_size, data_size, ext_table_size, total_meta;
>>       struct microcode_header_intel *mc_header = mc;
>>       struct extended_sigtable *ext_header = NULL;
>>       u32 sum, orig_sum, ext_sigcount = 0, i;
>>       struct extended_signature *ext_sig;
>> +    struct metadata_header *meta_header;
>> +    unsigned long meta_size = 0;
>>         total_size = get_totalsize(mc_header);
>>       data_size = get_datasize(mc_header);
>> +    total_meta = mc_header->metasize;
>>         if (data_size + MC_HEADER_SIZE > total_size) {
>>           if (print_err)
>> @@ -245,7 +248,7 @@ int microcode_intel_sanity_check(void *mc, bool print_err, int hdr_ver)
>>       }
>>         if (!ext_table_size)
>> -        return 0;
>> +        goto check_meta;
>>   
> 
> The code flow in this function seems a bit confusing. Can we avoid the goto and make this a bit cleaner?
> 
> There is already a check for ext_table_size above. Can the extended signature checking be merged with that?

Will modify the flow as below

-       if (!ext_table_size)
-               goto check_meta;
-
+       if (ext_table_size) {
        /*
         * Check extended signature checksum: 0 => valid.
         */
         for( ...) {

                        return -EINVAL;
                }
        }
+       }

>> +
>> +check_meta:
>> +    if (!total_meta)
>> +        return 0;
>> +
>> +    meta_header =  (mc + MC_HEADER_SIZE + data_size) - total_meta;
>> +    while (meta_header->meta_type != META_TYPE_END) {
>> +        meta_size += meta_header->meta_blk_size;
>> +        if (!meta_header->meta_blk_size || meta_size > total_meta) {
>> +            if (print_err) {
>> +                pr_err("Bad value for metadata size, aborting.\n");
>> +                return -EINVAL;
>> +            }
> 
> This seems to be returning an error only when print_err is enabled. Otherwise, it treats as a success.
> 

Thanks for pointing this, will remove the {} following the "if (print_err)"

Jithu
