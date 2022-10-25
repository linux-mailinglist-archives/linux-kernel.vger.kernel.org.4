Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61BE660C39C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 08:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbiJYGGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 02:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiJYGGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 02:06:19 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791E32AC7E;
        Mon, 24 Oct 2022 23:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666677976; x=1698213976;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=b/pXD2QAKxSOJjC+59Qk/1nmUIA5wmcxpJHA+POodIE=;
  b=FuwgmouGuZ2W70mZhzLZRLuuocRjwH3RFeFP0i78JvFii3QWf2XzxKJM
   rNGNocohqgtC3lbB/9DVrhf7M31F1IWHRrA/ag3/F+gFC8vtfIgt/p/j8
   mSMC+xzE+B/wV/EGV/cNloTPboiy5W/KcFeamrF5gGYnqOIVtyOoSxdZp
   iyb1STNPMaUAY+etrx6aBvofkub2Eg5zOnEQCuuF20icqq5z4dDiM4ddR
   nL3hgqLC5CAXcotvZ0mVAk/a1FvM+7FORlRrkvjHXMNNDV9vFXOpgWcUd
   Sy0RLhgWOFVPJK3Z45IkAybMWb9mujscTlmsDiwCn1K4jFCwxxtJOf9D4
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="290899009"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="290899009"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 23:06:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="626316294"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="626316294"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 24 Oct 2022 23:06:15 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 23:06:14 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 23:06:14 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 24 Oct 2022 23:06:14 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 24 Oct 2022 23:06:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AKUcuFjasQ8RQB6pIFdxFcI++4GkQhcuzCJbAqVUth5TZ7kt8PPODa1O2Y0d2uW49HEHCl0zeqxCwMigXASFIkvPPtp+fYIwSAfnV0ziERaQ55TYPmJU8i+QgYtmzk275hLSbGnoel4ovmeNosHP+fNuODK9FI1kqlvEetNPJewi/qhVB2o+cQP89I29t0E34eVJaAK+8FxCcVnJfKjGY6Cj9+r0FwwRGt+Muw1ely2ZrAebgEST7uqlK50o7N9jLIfTnl/xlUwLZl6oL800vhgpgakTx39JXrlPjqk3VCa5/JjkJ0MP/gDFYvR78rZYLGypK03lip7eGadeQMuVag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HlWDkvDgrj5oxw4lPnGDA5+YEsJ1Pc2K9jZ/hFanz/M=;
 b=kQ0FI1EH2XvvpEu/vTLesy3WScy4bslrms+BGjM1nANNmxbi+D5q1MWb5OfS2A6eVIZilsPllr2F1IsZVH3aRmfBqCNvpkRrmdESDT2wklpT5nGR5w/juujW/xG4uAtHgQRUNpuvDox+Z2jiR1ogCo099WA8tlFNEq2N+TrYd6W+UgzhV+1P73lmX1Jouttn2iLE2pg2ePGaZb44o/WTDO6xPKs7CvhGaH+1NMyH2oAPEGksRRVzBTCsDtxjTuILvXtBVHqlYjUCNXS+/4WrKp/60x3cOY7jNUviRFv07/F7qzj5Lx8ds/YDzr74Y+CoUuClPtIorovo7Gls9TL91A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by CO1PR11MB4995.namprd11.prod.outlook.com (2603:10b6:303:9f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Tue, 25 Oct
 2022 06:06:10 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e475:190a:6680:232]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e475:190a:6680:232%7]) with mapi id 15.20.5746.028; Tue, 25 Oct 2022
 06:06:10 +0000
Message-ID: <8cc37fe6-86f7-bc0d-8bec-e17b061795b8@intel.com>
Date:   Mon, 24 Oct 2022 23:06:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 04/14] platform/x86/intel/ifs: Remove image loading during
 init
Content-Language: en-US
To:     "Joseph, Jithu" <jithu.joseph@intel.com>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <gregkh@linuxfoundation.org>, <ashok.raj@intel.com>,
        <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <thiago.macieira@intel.com>,
        <athenas.jimenez.gonzalez@intel.com>, <markgross@kernel.org>,
        <hdegoede@redhat.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221021203413.1220137-5-jithu.joseph@intel.com>
 <ec2a2799-9db5-8810-7a41-f9f6ca1b360b@intel.com>
 <2fce55c1-20cb-39c1-52ac-d9b3e2247296@intel.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <2fce55c1-20cb-39c1-52ac-d9b3e2247296@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0050.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::25) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|CO1PR11MB4995:EE_
X-MS-Office365-Filtering-Correlation-Id: d3c6ae4c-b331-4237-0be3-08dab64f034e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j1KpCX9P0nMwqPIiUeksrGCIeprNegJXqkYhbx3NmnTaoS5LGAxtLYGijnuiJuw48QkE9uRlE4hq9NkA1wDGkDGN690/V4KFqSnvRsIaQ7vTp0L9ywCh9tP3GCthBi+AdayKiXoZHIA0T4/MIG5VKK6u+z5wDVkr3BjOlbQjRUTjZjlJQ3tdg7SeQYiYCu57pGw7n3EzE4mu9anJJUak9RIfnikUxcWMVWoombtXPuBZkWTJ08/LkoB55jKdiwB6WLfcTqkk9NcnhBTsT9CBHGa95xS+r6px5CQNraFVDQ+zTY6fXePOJnS/L2kqG8cisT9PZGrR2s7TGWd0HojSePEVbuUyqSvaShlEA8Mq3sk7tZ0f97qlmzQyhcaAIONU9fUFrckCa8HLQ9tG1P2Chd7uKtPU8FrAGGZQzSdExKEejn7BD4fpGx44czqqU4qDAuRZrm51TcgwOdegMb0YmpIofXE4IiswhX9ca+AY/rRp4HqciKp4ZhHGUqzZ+dECWehBQuY8H03DvMJAlq68VjUeg+CR2VDtD9VTE1nlSYsK4Mra+YYl2Md32U3HCLPpZm2aiEja5qBZZOZHVKmMUw91ztGWo1XfZG5XYzjf6/lLWDLmKLIU6nykE3hoLe1gJn0fqyc6FpiXy1MqH3RUvyzbhXKnWpUNe5uXxnoMj1boR4xvQjYG6nyhEl/6M0xGicPgqGsVckq554nTOfJTzcWAP86fuZpV0a5Q2ftZ7UnJlZcBFM8d3qP5aKK9i2s83Mub6RrjS5cYjpK4iY7dPfLYTk6bObj6OPnQ3/PCDxA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(396003)(136003)(39860400002)(346002)(451199015)(36756003)(66476007)(8676002)(186003)(82960400001)(66556008)(66946007)(4326008)(2906002)(6636002)(53546011)(37006003)(2616005)(41300700001)(31696002)(86362001)(316002)(5660300002)(7416002)(6512007)(44832011)(8936002)(6506007)(26005)(6862004)(478600001)(31686004)(6486002)(83380400001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T015bFM4ODFpMFJlcS9YQ3VsTzBzNkhzelFsWmJFQy95R29oN0tzTEoycS9R?=
 =?utf-8?B?Wmh2bFhmNkR2S0dwTlNnOUlmZjJ1WTdlUEdURXYrTVY4OS94TG8wZXNpVW5k?=
 =?utf-8?B?cmNVM3dLWUd3ODNoNTJDRDdTZ2R4d3RGZitQZXpKUlVqSHA1V3d5elJMSkN0?=
 =?utf-8?B?S2JlNXRPVTZQZ3lLNlhOdGl5WUU4UzlTYlY4WjRHM0w3SVArMXMybUduZy95?=
 =?utf-8?B?YXNXOFZaakJDV0tDSTVFYi82NWJldHl5Q1VRYVEyV1ZOakNLYyt1TmpoeEFL?=
 =?utf-8?B?bEJrS3gxUnBiWVIzUzNLZXZ3YWF1bUZuYWVSUXIyRlA2OEViWnl5blJxZE83?=
 =?utf-8?B?L3hzdkQ0dGg3S3FqY3lMREtkZlllcTc5aGRKdEF3eVRSL3pJOEVRREtVNHpS?=
 =?utf-8?B?dEJVZGtnckZBcHYvUmtMRDBrYnVWS2hMSGJlRDBNTU1lK2JOc3YxU1NWVks1?=
 =?utf-8?B?ak1tVDIxalhTMG9sTDNxRXEvemVXeGVlVXZXSXYzOENKVHVOeDRrbHJQQkJV?=
 =?utf-8?B?WWNJbHdmSk5iTk04MVJOLzYxTG5hd0RVZnhTcktZOHpYQ0xuRlNXMXBxYlZm?=
 =?utf-8?B?TkFXTjdhWUk2bUMzaGF2WWxsWmVKSmFKT2Q4NHIzS29QVjBpWk5WNWJUTDc5?=
 =?utf-8?B?eEdtSFRwQitZcVYrOGhwaVNMWXRXeUxKMUlhWjc1U21paVpNbzNQRWJPT0U2?=
 =?utf-8?B?ZHIyMyt5cGxQODRNRjRPYmViM3pLL2R3em9JSDh6NjlLRGdMSWlsRXJ3VEFN?=
 =?utf-8?B?eTZiVXZiWUR4Tmp6dXk1VjZFckpFODJRenM3OXE2a041R2lsc0NGR0wrUDFl?=
 =?utf-8?B?UHdZNEl4M3gzVUtTeGkyZWNMNkJjQURaMnhPSWoyQUc0bHJxV1FEQlVzR2xt?=
 =?utf-8?B?MXoxc2xZd3Bnc00yMlNVY2FmNno3dTBDc1Mwd0VLMVZvWHlTenhpeEFmUFhR?=
 =?utf-8?B?L2J1bEFiNGoydVhMc1Z5azNJVU9hNmFQTmxaSFhWbk45ZTB2eWNCY3FXUEJ4?=
 =?utf-8?B?dmNDaGNRaUgwZGxmQjRSWjVsMDFCTkdsY0NDaklNL1pJU0FaQS9rMStjVm5P?=
 =?utf-8?B?ZVUvMUlySzRBck9CN2JRYWhvSHc5Lyt6UjFXcHh0WEx4eHB3V3dlZVAvbDF4?=
 =?utf-8?B?ZTNiL0FFaFRBZGhhbjNWdk1sY3J4Nkp3Uml2dC84Rk5zbzZEMkc2LzR6ckpl?=
 =?utf-8?B?SHY1SS9XNTU1WUUxcGd1K2pvUm1OYlNFZWp4STUwTjlGU0ltMXo1Y1dTNEp3?=
 =?utf-8?B?QThjRE1mb3M1VTk1czN3djNHSUpqelQ0UHJjM1o1S1FvMU9ZTm5tRnlrNmln?=
 =?utf-8?B?ZTIrdFQ2WmN0MTIxQ1ZpNTdwNTNFUm1BVzVOUitIV3pWY29Gb2toSUR4dHZ4?=
 =?utf-8?B?cmFWS3FhM1RIYjl3M01RSTRYczRQNVVLV2gzekthSUdYVHFrZWdNUjgvZ1dV?=
 =?utf-8?B?eVJLRStRYjFkYXFoOEFhTUJJVGJIZDZLRE12ME12MEt0YklHUk9CZExJZkhZ?=
 =?utf-8?B?MTdSV1UxQytEcTlmR0h3cW05Mk1PMFhZbEZqSkY1SG9Ha09tWEpjYUU1SllF?=
 =?utf-8?B?YndkendzT1pSWXJEOHRTY2dJejBDTVFVamlhTnEvOXhESnNWNlFOcnBneEgv?=
 =?utf-8?B?dmN5a1VZTE42dHRqT1ZOYnB3THZwditXb2gxalczUURBZmJqSnplSjExaC8z?=
 =?utf-8?B?ZlptV2lFOWZ0QjBXMEhCQmtpZHNzSGdML2szanpWRk1ndHRzMkU2SnNoRkF0?=
 =?utf-8?B?bHZIWWZoR3lLUmhwdnhod3JtR3ZlSUtZQnJId245ampiOURIdlR4bXRmeUhw?=
 =?utf-8?B?RjdFMWd4YkVkMGhUbGpUampFQVo3NUFibDhWVGhGcDgvc0JpSzY2OVAxdVVh?=
 =?utf-8?B?bXRwcFQ4azRSL0x3Y2tmYjJ1YzV5NGtFQ2E4QXdEdTZpRTdSTFhXTGRSWWcw?=
 =?utf-8?B?NElTT0NnK01ES1JLN0tZQXNnRDBLL0tBRWxFTE5iZGs2SHlHTUpGSTFhTk55?=
 =?utf-8?B?SnJoYjg3MzYyZWcwZjN3aFplSHlOYW9oYlFlaVV5aktXcXU5MWFDajZFaUp4?=
 =?utf-8?B?WTVrSS9rb0VRMitoR1VGNElqdCtVeFVqU3hVcmhqSEtveFkyTlJzcTlnTDNt?=
 =?utf-8?B?cmRYdWtaR1NmMy9CVXhNVjdGT0lwNEEzUUpIaFZkc2pOd3ZqQWZjb2RIYllm?=
 =?utf-8?B?eWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d3c6ae4c-b331-4237-0be3-08dab64f034e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 06:06:10.2026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8PQt1sZtFDngXXaFbja1IAqlCs5O0D+Ra4WUfen5cXG8YpKQujBBl2Z9iyyasZ1XA7N3x6k4NeK12Y+8NAh2QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4995
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/2022 5:41 PM, Joseph, Jithu wrote:
>>> diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
>>> index 27204e3d674d..5fb7f655c291 100644
>>> --- a/drivers/platform/x86/intel/ifs/core.c
>>> +++ b/drivers/platform/x86/intel/ifs/core.c
>>> @@ -51,12 +51,8 @@ static int __init ifs_init(void)
>>>        ifs_device.misc.groups = ifs_get_groups();
>>>          if ((msrval & BIT(ifs_device.data.integrity_cap_bit)) &&
>>
>> Is there a reason to store the integrity cap constant in the device.data global structure?
>>
>> .data = {
>>      .integrity_cap_bit = MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT,
>> },
> 
> This was originally added so that, when future additional tests are supported by the driver, support can be checked using  the same if ((msrval & BIT(ifs_device.data.integrity_cap_bit)
> Different tests would have different integrity_cap_bit assigned in the ifs_device[] array  (today it is just a single element and not an array
> 
> Note that the current series doesn't introduce this
> 
> 

Sorry, I am still not able to follow.

Let's say you have an ifs_device[] array which has different integrity 
capabilities, there would still need to be some logic in the init code 
to differentiate between the resulting action that needs to be taken? 
Currently, the init function only registers the device. Maybe some 
example/code might be helpful to drive the point.

Also, are the future additional tests expected to be added soon? If not, 
maybe we can defer this optimization until the need arrives.

Sohil



> 
> Jithu

