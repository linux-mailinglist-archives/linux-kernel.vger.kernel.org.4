Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3097010BC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 23:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240033AbjELVLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 17:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240451AbjELVKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 17:10:42 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDD01154D
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 14:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683925745; x=1715461745;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=c7/w2GSUNPQtr1NqPzulFsKRqRIZKxttDY+A5PRq23Y=;
  b=EcvE2YFrFr6fIjVQhRFVDWmGsXF4p/nvNsNXuqQtzTs167tT/l/byIXw
   yCH2TihIAgbXs+mqHgPZpkgKUn6pC1LpvNibjuWX1eMGLYeFyLFjD3xIg
   ZsFLX4bS2IyU2ZtGEutaXe6Cp5rmNy8c1N8WJAIfL12NteT4q7p/hr+o/
   kBGQliEXmUuvcUwQsEFEQtgDTo3JWWvW8lJP4Y1zHcZn71oxRKTPQ5ZQ4
   lMXlx+0ibq4INnBUVB+q4kwROTmpSWTuI8CCRVn1OwzRRZIpD98eYzrM7
   X4NZ5jQj66O4JdBjVYal737HWOIxEdfvwzWvDvFGzTEKhfCnr2pgOC8iL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="349726536"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="349726536"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 14:08:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="789959350"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="789959350"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 12 May 2023 14:08:43 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 12 May 2023 14:08:43 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 12 May 2023 14:08:43 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 12 May 2023 14:08:43 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 12 May 2023 14:08:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gIM0Zyi3krOHw3kXIGY4PP4zKWS6fTksynZX4TTfXNIt9j0DkKyLfVFXqRIuvO7LtBgPwAFsvOuZHBIAK339uVqgAMLVi1aVY3iCNSwEqjcrVqj6e9/7wc77UxRha1KVvjzKong+2CRpk+rDwz54Ksgz+RD4CeFfrBsO1IbtNKwpTJya5nFA5rtZpXn4YGbbxb3Mu0LefQoUQk0b2D6UTLR+R5pa7gBjqgTgosSJoH/em7uI2yvR56gj7s8Bh1+hcpzy4hWgiQXZOkwktQBpWNcLwwg/29FO2YxBhfq088+mVax0QE7Cnds4yFiwRJ87mHPDj2xmgOf3LQzhIgcY/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xpCCT4uc5kIGTNgf3y3LLtKqrWGFnMc7GP4f3N5EDhU=;
 b=h7oEMa3Ipowov8fbLwBB3nLnrR+Z8my0XQ7A7SFsCeGBt6F8WhGOnaiySLGDWTgzCwmHkfrFN7l02f0+nvRhS9TFFTniInhBqgda8WUWnaegAyMyBjWof2kMIaZPA2srjzz+YTlbxf6BJvDKMko5KPfUcKE27yhef/7lZ4oBnpfYQGm3ikzlwIOnPMIIpU5pamNp0/cfrVTu1PJmmWiWeSwcX8ii/vIGtEi8buRXR6oOLx519bmdMSGLPvXOOCWOedbYMG0AhgMIsUz5SlieLSdBjYIj29C5uitlbUGyj65Bhd5SJfY5GTL36lqKAN92qaTC+YI9/6U6A8XQDyCYJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.21; Fri, 12 May
 2023 21:08:41 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d%6]) with mapi id 15.20.6363.032; Fri, 12 May 2023
 21:08:40 +0000
Message-ID: <1c3545d6-3687-a380-9e63-87be9e8b1305@intel.com>
Date:   Fri, 12 May 2023 14:08:38 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.1
Subject: Re: [RFC PATCH 0/7] Add driver registration i/f to resctrl
Content-Language: en-US
To:     "Luck, Tony" <tony.luck@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        James Morse <james.morse@arm.com>,
        "Babu Moger" <babu.moger@amd.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230420220636.53527-1-tony.luck@intel.com>
 <c0755752-ce84-b5f9-6ac6-97812e98b8c3@intel.com>
 <SJ1PR11MB60832074F3140B38C1B08596FC719@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <237603b3-f553-2ede-5725-239b65626c69@intel.com>
 <SJ1PR11MB6083CFFA8CBDD296E966EC85FC769@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <SJ1PR11MB6083031582F2A61A7D24ABAFFC749@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <b35c1b06-4236-15dc-6aed-ece8a0331c8c@intel.com>
 <SJ1PR11MB6083CB61BDCABA2930155C2AFC759@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <SJ1PR11MB6083CB61BDCABA2930155C2AFC759@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0118.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::33) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MN6PR11MB8102:EE_
X-MS-Office365-Filtering-Correlation-Id: 66f2949a-7c07-4221-9729-08db532d0fc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NMDkC2h2W3Pwb0rt3nFuqrhZlRMJyiDj2GEDVmYM+38LpjP+BLxDTyyUQIeUsqIITJkR3wYf9dYoc31CmKNdrNyti/+ffvJmSmGcQCibzgsFsGVTDfQ/K9Rdok8FD+YpUJwS2SEmH2c+yAisRfYFfRja4i0x/KaG5GoLXeLY3XsQDCLkvXhCYgoesKL6DiLWG52YztHbGYrtRF8S3TeNb80K3oY3piB1rDfOU+4UJojT24QEffLQBxnrUv1/99H8Ha2Ra9lv+ZntbcKlhyDuE9SAO/dctgbEFjaR/XnsJ5lQ/FlGA8rwicfPm3YqqzfxNnbzszlev8Hx8UDmPO8L0F95few8X5Fdc3VkTODLWV98lPkK746OoAlPFF5WMxZ9z2aKlBqswPmKS/kcelbuGbQtM8R9FblFGk7btWAy4tpHfm2lxVbHleT/u++5liPdAdHy6M2MbdBmveBV96isu7V0fYu0rBkZwIjM7WFGkHPds7A9BW2vOZst2hFqWWZbzEEaT6Q9pg6Tosnr4sY3VbiNcqF5N8lcbMAUYN4mAbfEJkvx9wKoTGlxIHHM0wdkKLGMmWb3Au4bUyb6VctFu0BAjZG0sZbC/Yt5yP/KZ/K0wJw0cj9H2LdRJ5jMRmabNaYNVSCWhY1Fn0pYfwMdDTne6245h20yzdK7cbGRW6Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39860400002)(366004)(376002)(136003)(451199021)(966005)(8676002)(5660300002)(38100700002)(6486002)(54906003)(8936002)(44832011)(7416002)(36756003)(66946007)(82960400001)(66556008)(316002)(66476007)(4326008)(478600001)(110136005)(921005)(41300700001)(31696002)(186003)(26005)(2906002)(86362001)(31686004)(83380400001)(2616005)(6506007)(6512007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHhlUkwreGt1SjJDcjdrVEtGaWUxRmd3THpaWXhoL0RuVmZZY0diOG4yL0ZJ?=
 =?utf-8?B?S2pmUUFiY0s1L2dHdkZoeFZDMnpzMXhidEExVVVyYkxRaEZGRkwyaUYrdGZi?=
 =?utf-8?B?SXRxaTQ3RVlSdnVFUUJFcnh1c1l1QVJKeTlmY1BzSjBJZm9xMjA1TnVmREo2?=
 =?utf-8?B?NlZSa0VHa21PVVZsOEdHWmFqS0NyU0pSVXFkcTd2elo2cUt3QWhDZU1KUUZh?=
 =?utf-8?B?amVkM1drS0M0UXU3UWlzUEpZTW9WOXFLZ3B4Yk5SeTVKZVFobERLNGdhVHBr?=
 =?utf-8?B?ZGdXcHRBQ1doL3k1bm1weHprQlFhdGIvSjJGUjh5TWNGbXdIcC9IZ09WMm9T?=
 =?utf-8?B?cmJ3M3NXSXowUFFjVFNpK09aQjViRDFrdkdaNDFiWVNhNUxWOEdwcFBZdHVW?=
 =?utf-8?B?OE0rbUlIQTRXY2h0M01sa2hwZ3BTQldpUXNrdUhBbmtvWjh4RS9pdXR4YWtl?=
 =?utf-8?B?aVYxSUlnUDVjdjdTeDRpc3BRL09CTHY1K1hRa0h5dGVnMjhsR1ovSzJ1aFpP?=
 =?utf-8?B?YVR2VUxTZVdKYlQ0Nkxka3pkVmxCSlFGaGZFcWNxZGU1Z3d2UTN6TjJGTjVQ?=
 =?utf-8?B?dWptRUszajZxZGswSXRaS1B2M0JmQlZrajBiK2svTWgwcUt0T3FwSm9sdVll?=
 =?utf-8?B?L05ZbnBnbDkvWFE4dWl5K2I1ZDdFUmdyZzVKUUtVYXRyT0NmRFZ0c1U0SXBJ?=
 =?utf-8?B?bm1qQ2haanExOUlCbWswUHRTNU9hYUFyR1Ryb25TM29BRXRSK0IyK3M4bVp5?=
 =?utf-8?B?a1Y1SGcwK1pSb2hNRWdRTTdyQUo0aDNURmxjdmNVR2YvQmZXcHRseUtkYUdm?=
 =?utf-8?B?eXRCcXo0YmhNSjZnZkZJWWd6R1BXM0V0Z3dsalM5NmZGSkNNQTlkcU1GNFVH?=
 =?utf-8?B?Z3dDR1FkVGVWVzQzMnhENU9yQlIvWjFyNGVWSUpZRU43dUNEbDc5alhEU2RS?=
 =?utf-8?B?Y211UDlpeFMxT0VQQ2phd0RTVXNDLy85TzhLY1JCSnF0anlaZFVLYUcwT0I3?=
 =?utf-8?B?dFVHMDRkRzA0Q1ZHUnp4cUc1cnpDcUxlTndXdzV3YmZ6K2xXKzRpSU1aTEFn?=
 =?utf-8?B?K2FMQTZtN0c3bnBBdjRVakVvYjloUGowQ21EeU9FYUVYUXhzYWVTNUhvUUFL?=
 =?utf-8?B?Mk5FYnBxYXUrRElEdCsyRHAzWFJXcTF1cFpXMEZWSFFDcXFIbGZQZDVjcmZz?=
 =?utf-8?B?cVpCaUVzVjRzK3FVSXZOTURpbVZmS3Yxb2hyY0s3UEprT082VFdnZU1lazJZ?=
 =?utf-8?B?a1BhMmlRakx0Y0REZXdGdzhXeGg3eithemJQdytLMXU5ckN0VXN3b2JPd2Ju?=
 =?utf-8?B?NlBaU25FU2hTam5TRmp4UDhwWUFEM05IamNUUVdjRmpiWWZyZmsrMFJ3azY2?=
 =?utf-8?B?Y3J1UGxPTVZXR2ttTzNoVXFPVHQ0bDl5R3o4Vk55V2tMaW5ETDdHSUNjNE9h?=
 =?utf-8?B?Y1hsNXUveEhTUlllTnJhQ0h6dnZneFRCVTc5RHBxMXBncVBTUXNNaHQwd0xh?=
 =?utf-8?B?Snp2d1lFbXRLY1FMNUVaWkZaU3pwRW1QMFFxa01yWEtiankzVGZpOEpnaFJM?=
 =?utf-8?B?S3dKSW5aWU5STzNOemlldlRWUndjNmo0eDcxL3JHWlRrbHlkbS9ILytQdC9N?=
 =?utf-8?B?eU9HaEJJT3ZRZ2hNZVJtTFdWa2xTWWJYMXFtbWY1U1lrT1d2UTRlS2xqbDll?=
 =?utf-8?B?UVczSExDSEVaS05jR2REWkdNWTRzUnNTb29aMTAycHoxaGtoUkE0QW5JVUhR?=
 =?utf-8?B?bXU4b0Y1VmVsYXlKMUNNK2FnWVRjOVF5ZXRnOGU5b2lVY0x3UE03bnF4eVp6?=
 =?utf-8?B?eWNJb2hwdFlYSjcvaTk1S0RVT0J5dnhPVjlLbjk2c25Vbmo3UHMzdUVBREhv?=
 =?utf-8?B?dzI3Y2toaE9wYVBkSzA1QzJPR0lHaVVJbkh0TStIRm9KTjhPTTluTlA4MWJi?=
 =?utf-8?B?OTg0QU9tQStsTWhEckFxVnFlYWZRbG4rek1xbVJtLzlLa3pXT0xqcHp4bE5S?=
 =?utf-8?B?YlQ2NU8zMWk2bkZTemJSeUpESHd5SDBLTGQ5SVgyNzZodkxWeEFoVHpoOURs?=
 =?utf-8?B?eCthclMzZmpEOE9lcjcvUEc3Z2V4ZGllSEVTTkNYaTE1ZE0yZlNKWXhUNXhQ?=
 =?utf-8?B?MVZ1TTcyZkdBNi9kVS84OHRkTzBMRDRvbmQ0aTJ2Rk5mYXB0YVBvcFF3bjY4?=
 =?utf-8?B?WUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f2949a-7c07-4221-9729-08db532d0fc3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 21:08:40.8316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fySI//jCvZy7e3TUMhP5z9P3YmKed+bXr349G3zdIkAVAX8WsRHR7LVuD9AQcW6CX2R8cRnTjcxYdALink8leU3qVBBdfCs8O/1R3mnGIBQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8102
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 5/12/2023 1:35 PM, Luck, Tony wrote:

>>> The driver provides a way to set param1, param2, param3 for each of
>>> the A, B, C, D instances.
>>
>> Seems like these could be some new RFTYPE_RES_XYZ files?
> 
> In my current implementation the driver can make some/all of the files added
> under the info/ directory writable. So this XYZ driver uses info/XYZ/param* files
> as the interface for the user to set the parameters.

It sounds as though you are concerned about making info/* files writable?
I am not sure because whether the files are made writable via the core or
a driver does not matter since it will still be writable from the user
interface perspective.

Please note that there already are a few info files that are writable:
info/L3_MON/max_threshold_occupancy
info/L3_MON/mbm_total_bytes_config
info/L3_MON/mbm_local_bytes_config

It thus seems appropriate to use the info/* files as global resource
configuration and files within the resource groups handling local
configurations.

>> On the model specific motivation topic: If the goal of the driver
>> interface is to support model specific changes to resctrl there is a
>> publicly available use case for consideration:
>> https://lore.kernel.org/lkml/20230421141723.2405942-1-peternewman@google.com/
>>
>> It is not obvious to me how that model specific problem could be solved
>> with this driver interface. Your insight here would be appreciated but it
>> seems to me that we will have to keep accommodating model specific code
>> in resctrl.
> 
> All my drivers are currently related to the control features of resctrl rather than the
> monitor features. I don't see a way for a model specific driver to step in and mitigate
> that particular problem that Peter has.
> 
> Seems quite hacky though. The trick with the "hard" RMID per core is going to miscount
> LLC eviction traffic. If a core is switching rapidly between tasks with different RMIDs
> that could be a significant difference from actual values.

The submission is upfront about this and indeed disables LLC occupancy 
when "soft RMIDs" are enabled.
Please do provide direct feedback to that submission.

> But requests for some model specific quirks to work around h/w limitations doesn't
> mean that we shouldn't create a driver layer for cases where it is possible to
> separate s/w into layers.

Some of my questions were trimmed from replies without answers
so I am still trying to understand the driver interface motivation that
something being model specific is hard to integrate.

Reinette
