Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A936238BC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 02:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbiKJBQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 20:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbiKJBQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 20:16:56 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9159F233AF;
        Wed,  9 Nov 2022 17:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668043015; x=1699579015;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9N5cADFGU5Z0Q78hmOf91wE2WPTlH3SyJyOW4VjG2g4=;
  b=QKxh2VNV7Pfr7iNuSIgdxFeb/XeKvcJ3wlz/+VAXNmRIpAplYV7y3Wou
   HL5x5kgb491VCRH2tkiEAmJo3fwCd2oEHMEPxXNwsPs0kdQZ40b4Bd4/B
   LpJpjRFO1TXEm9efERy34YL8y3WDpwS3qjCdaxB6eN9Yn6oJSyHQsCA/h
   vWYmZUz5Y53nj5ZAH2bOo2YoNHk5AzKzxT72MRAn12s1ezIPxolx7M5YV
   shTfFQ+b4+EdZWCI1K1q6+PON6XaFaczUg/5QJOuUiQetyF1M+euYBqYq
   uUFAzQpbG+GKNHRF21uJRjm0xuZjCwxghgG8fulVjU4Jp/6Tlx4qBv6Up
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="312940720"
X-IronPort-AV: E=Sophos;i="5.96,152,1665471600"; 
   d="scan'208";a="312940720"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 17:16:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="882150660"
X-IronPort-AV: E=Sophos;i="5.96,152,1665471600"; 
   d="scan'208";a="882150660"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 09 Nov 2022 17:16:42 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 17:16:41 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 17:16:41 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 9 Nov 2022 17:16:41 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 9 Nov 2022 17:16:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GCgtOpb3co3Lr8+WPnpjOY+bWkZaiE8K2TR+EKXcvbA2Cc3yBFMa9OtRE4WZfN3njzhojl3Vtr1hEbGjb/OfyAxD/CXb7mEIdFlg2jq/HMIVWCtWX1NqtigQ1lD8C52go7e/0BmNRe2bGgGLLGb+9sEoTQLPmNmUjdrfRlSnEDvg2hoQJAiZvaLd4pMbvTy7904aWJJVqlypZOYRzSiDZ+JVHhhbo7DOAiEKbyE8xYgi0KuxSC6zYmDcLAnE3DxXo3EoGKfpTwVUyLIUMACntwQuKxkqzdp6xqUdceficG+9MjbiFNz3SoDb55SVUodZ4pcGu7+qAj33COzCi/PiGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y3Ic4OPgX+APgET+GqcMVpyKGlah/wBM9I3Di3Ei850=;
 b=Ia9d+1JgBzJSIvBp9LKqvFHwiFnIVkrJH5cSVLASVM3hIkfStIXRmJz63LGbWnOpokfbSWfyxbVwB1ZDmcocDTqUJPMtb8jrNoUZsX0WrRcWqL5Pi3nv2UbawyNnsmNiHsBlNBcHfRhKus4/h7dyzdMrdJsxiZE/URgEbw36pdCYBC6QDCEGGpRRcG7ulsyuC0RHmgPZ1uFVWsS5IITZzUQJ5eMYA54P7TmO6ktdrKQR4s6Zih61c8pOlma86bSE0QW3FkJIleRCplXYxra1LbfqOLCv4ThK9RUIUUzJs2DBTLNDsCZFK65vPfCZFumIaXYjl4wpm1EaHJW3+RwtPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by PH7PR11MB5820.namprd11.prod.outlook.com (2603:10b6:510:133::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Thu, 10 Nov
 2022 01:16:32 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::f980:8dbd:ddf0:11c0]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::f980:8dbd:ddf0:11c0%4]) with mapi id 15.20.5813.013; Thu, 10 Nov 2022
 01:16:32 +0000
Message-ID: <382ef16e-5013-c226-2601-309be952f1fe@intel.com>
Date:   Wed, 9 Nov 2022 17:16:28 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 13/14] Documentation/ABI: Update IFS ABI doc
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
 <20221107225323.2733518-14-jithu.joseph@intel.com>
 <503ba3e8-f060-002d-846a-8dec7e84c83b@intel.com>
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <503ba3e8-f060-002d-846a-8dec7e84c83b@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR07CA0070.namprd07.prod.outlook.com
 (2603:10b6:a03:60::47) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3768:EE_|PH7PR11MB5820:EE_
X-MS-Office365-Filtering-Correlation-Id: ca900b7e-3ae1-4a1e-b820-08dac2b93394
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zad7pm5YOYxSzzQ7/p+3nPhUugN1XwlStq+g44TX4fEGLp5t5Amh6AtjY58KRCwhk0DLJFtDwe+SaXi3zDCIN/sGR5G/IfRM+KYLoPB+8xEcTOBuIOl1VPNxq9yCYNbrHVVx/h2cbLZf7+QuHYDZjTpLUmquddaSObyPfG78FH1YxeKms7PAeNgpbCXs+DNU3B/vSxInCuH6ekNkPtppPYw4inh74/j4yjDV8XqvGK+p8aQo46FcBhN3ByzSteGpJEXkfQIfzynO2hQgK6NbJ4hVmcwgDFXDSSTr5cNM0zgR4huF/30KWf/D3YoUNLThL+m2thYL8lo69PaAUNHvcO5qCTfgG14mKHGM0YUez6xdRDiXhkIHzNw5r3LlFVTEdJ+Y16JJwsAdxmTwHIyTxj2EI6DxDD3FBMIRQUJAh90+RgbFn8DpZRvoK4y9tInzt/rUqBPRxBp5Hy/cxP5Iq7bX/LlWMu87Uxxc9Mug3PA1DihG2RIQQhsrsExKBrZhxaejFwWYoP4jivrjF1GrNn/mRFZV3RuqXLKu2oc6PL4IBeteNoOkhaWXx8VXcn/178m7zBiIZ7WumQwoC76ojJT2l66UrzFlMU4jMceK/0XZXFdzqQndkY9wEs5DiqXDdLCYuO77zMBTTarQnIgrEPJ7MfgAogxAAudHTuIBDH2mDoaPnkWVu7fUJ+Itv5b5CS0UmLWXgceFY3rIKdbvxH7/6/TDkQdZA4GH+wABOmDXRwOEKlG6afvoEJ2s8Y4e/PHaT4QJhhq4dGnQMOXpFqNddAJxF1mbh8sKQ5oOe+w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(346002)(136003)(376002)(39860400002)(451199015)(5660300002)(8936002)(31686004)(7416002)(2906002)(41300700001)(8676002)(66556008)(6666004)(66476007)(66946007)(4326008)(6506007)(26005)(86362001)(36756003)(316002)(478600001)(6486002)(83380400001)(2616005)(6512007)(53546011)(186003)(31696002)(38100700002)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDZ6aFhCM0NBckViNytjVmhqWVdDS2xQT3FxSyt2RitGSlJPdTVLWDg3RmZN?=
 =?utf-8?B?dVpMREZyL3RYeW9GSEpPYjZFL3VGSlZRb2lJTDk0YWllbVBKaHBQWm5maWgz?=
 =?utf-8?B?REtUbFhhYU03bUtYSm03M3ZqNmVhZ1Qrc2J3UDNZbEZHQUdFN2tHSjZXS3B0?=
 =?utf-8?B?VFBSMFEzcDFadVJYKzk4WmpsNnNic2xHTFJidmd1TzI5WW5SUmxCYW5VUEZK?=
 =?utf-8?B?dllxV1NaVDJwTkVKWXQyNUlpQ2VjTUN5QkJ6Q1JicDBxb05ORWNTNGxFcUxS?=
 =?utf-8?B?L1llVGVmbjI0MUVsTUI2ZXNhQjg2bFhtQ2oyRDFQc1ZWRmhQd0JkOFNDd0pm?=
 =?utf-8?B?bWxqVGlJRVg4N2lBL0taQVlTR3FOWFgrRkptUVNpclp6UEVUZnJBOFljSWFR?=
 =?utf-8?B?UndYNkJ3VmR5M0tVRlc2VU0zMU9NZXZQM2RQbFpKa1dBRzAyWUVvS1ZmS2Jw?=
 =?utf-8?B?SEI1V0crQW92WUNwWnlWK054ZWEybFdzbDdsaU42UWU4NmFORUQzSHM3YUpP?=
 =?utf-8?B?OWovVlJZdDJEMllBZ2o5VFlIN1BrSEVPVTVPS3Z6a0M1bG1ZVWZjc3c3aWJ1?=
 =?utf-8?B?dHZqNFI0b3FGYXFMa2JrajYxTFArNndzWnM1VU8xQXZGTXNxcGxXQm5ZL2t0?=
 =?utf-8?B?c09kU3p5OHlHVTh6TzhIVTdjVkYzc1dTYmY3T1lTMTl1TjJEVzJJMmtyWTJJ?=
 =?utf-8?B?c3RFVWNsVWFBd0UzSnJYTW5oRFdaSWtFemo1WE5pTmduMGx4VkROT0JmckJy?=
 =?utf-8?B?d25ET1hxRTdVRkhjTU9BMHZQZHZMY1FENEExZUNoaktHVFFtMEs4UldlUWQ4?=
 =?utf-8?B?cHdrSjhlcGJNeVhrV3ZOQTJuWUdVTnFzR1BKZEFHNnJ0Z0dPeXhFdkowRXBx?=
 =?utf-8?B?ODN2NGF2aUFaM1dMVHpzVUpid1huQmw1OUxYWlhZVW0rdmg4am1QdkRzSG41?=
 =?utf-8?B?YzNjWFpPKzUralMxWEpGd1V3K1VVY0hBeE85SFJpZmltNzFMandzR1JCc25L?=
 =?utf-8?B?dTl1M2JuTjYvdStEKzBJVTRzeklLczFKMDVZMFN2eGxjWTNBQzc4dGNlcTF0?=
 =?utf-8?B?T0pGQWR0RkJSOGduZGRlMnFxYlU4QnRKWEN1WENoeFhlcE1hTW5uTzhoeGMy?=
 =?utf-8?B?N1ZOWjdqZ1EvY09tbjk5WDAyMS8zZ3NLVzN0QXdUeTBHRThYa2M1emc3M0hj?=
 =?utf-8?B?cGhoMHBaVkFBblpGMGdUZzVvZlpheVpYUlBnd0JFZldUenFTbCtTMmpmS3ZZ?=
 =?utf-8?B?UzY2My8wdlE1dlEya09FRmlUSkRrdGZEWHZLd005VnY2U1RsdGlOYXl2NzBG?=
 =?utf-8?B?MDZDUDZFNWtHbGRVNUVvSXc3TDZ1Mm9rTDd5SURLQzVxM1hzVlVhZ3ROdFdW?=
 =?utf-8?B?c2ZweVFLekdYckwzUkJieG16NEFGb3haU1FLT0w1QWN0QkVpSnNDdWZLdGtH?=
 =?utf-8?B?L3hPTWVrQUtVcEZ4by8vdXF1NUxsbTFtL2VlZ21yL1ZJeGxVSXFnalhXSXVa?=
 =?utf-8?B?MGhzTE1WY1BrV1A1OEd2b0I0dUJ3c3NOZDNsdUd3WkdCQS82bGJVc25HQTJn?=
 =?utf-8?B?VW80YkxrdWxIQlc0WHdJWHdMTGMra2U4SFpveEY5NGNxNG9DNS8wdEhESjhh?=
 =?utf-8?B?TGVaZk5mcW1zTjlNQ2REQmdjdk1vbXhGVVlhbzh2SkVFaGJNdnBxQU8vSzJW?=
 =?utf-8?B?TnhHemFJQ0F6Mis4TzRmS0hibXU1bldDRERFV0piYzVENnZBYmgxRmxIMEZq?=
 =?utf-8?B?b0hSSTVNMDJmU21pRjd3VlRoZlpNZ3YzckEvZHJ2SFVjbStLSUFuQVFtME55?=
 =?utf-8?B?YTZFTDI0ek9IQUVNZi9DK0FFUlpBQ3UwODF3LzE1MCtiQWVROVpXMzB6dStC?=
 =?utf-8?B?SnFJSVk3bFNzN2o0U0pmemFrbXEzaUZjaDNsWU9WQmR6N2RhVzFOWklkVTBk?=
 =?utf-8?B?RGkyTko2MWhLRGt4TUVXVy9xM0hyeG0xd1JFdjBTK0U0WkJBbHdaRHYyczh6?=
 =?utf-8?B?cUhsOHE4UGpQUTc0R0dROHYwN0xWWVJ4aFczdHd6SWNmWUJFbEtJcEI1djhJ?=
 =?utf-8?B?NDlVSHgxMlp1TUREbGE5cGVTcFdvNXFNWVY1dWlxL051NnZIN3RMSWJsV3RV?=
 =?utf-8?B?N0EyZ3dFY0Y2UmFMMTdsK3BpNlorOEZmYXFHRXR6empUUlBSaCsya1pZMExU?=
 =?utf-8?B?WFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ca900b7e-3ae1-4a1e-b820-08dac2b93394
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 01:16:32.0375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0sBhr7JV7neDt50fmVfB7gbob1Vk19RB39Rtzi5pygLFYRxdNb0+ktmtb9awfBo6NXsQvv01ru7pYNDlIqGDZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5820
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



On 11/9/2022 3:55 PM, Sohil Mehta wrote:

> 
> A clarification below.
> 
>>   -What:        /sys/devices/virtual/misc/intel_ifs_<N>/reload
>> -Date:        April 21 2022
>> -KernelVersion:    5.19
>> +What:        /sys/devices/virtual/misc/intel_ifs_<N>/current_batch
>> +Date:        Sept 30 2022
>> +KernelVersion:    6.2
>>   Contact:    "Jithu Joseph" <jithu.joseph@intel.com>
>> -Description:    Write "1" (or "y" or "Y") to reload the IFS image from
>> -        /lib/firmware/intel/ifs/ff-mm-ss.scan.
>> +Description:    Write a number less than or equal to 0xff to load an IFS test image.
> 
> Can the number start from 0 or is it expected to start from 1? It might be useful to mention that if there is a constraint.

The driver currently doesn't do any enforcement on if the input starts at 0 / 1. If user writes 0 and if 
the corresponding file it looks for (ff-mm-ss-00.<test_type>) is present, it would load it otherwise it would
return error-code ENOENT (returned by request_firmware_direct())

> 
>> +        The number written treated as the 2 digit suffix in the following file name:
>> +        /lib/firmware/intel/ifs_<N>/ff-mm-ss-02x.scan
>> +        Reading the file will provide the suffix of the currently loaded IFS test image.


Jithu
