Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB83A616114
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 11:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbiKBKmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 06:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiKBKme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 06:42:34 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B5D2704
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 03:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667385752; x=1698921752;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fJNJvqi3oUYeF/V9sOePNBWqSHXQx4mSEla1L2xp34I=;
  b=Bh5tVn0m3WuFhZFqijt/55xyjAznUMs/Z95LEtlctzG8IRnO5deorYVI
   MwX3RlA3g9YtTls/Pi3+wkh1CV7XVoq4G2LlNPMjk4HyMHrWVB9TgztTu
   mZnEkGpwY3DWj3Kyh89mf0D02Nh7RbQOuRujCRSSCRhWg75h3O0ylbd1d
   YTItQZd6vtt6yQRVM8V0y9qc8vmrd0V8ItSEPxDjY63zldMLE0P9ddoVl
   vIS17nHArFMTxB9kXesTAZ6JO5LVMx3M2mn+mImilfYcslz/ukl1Wwmbt
   /v8qkWpUJFjaWv32Dw1ZuX3WkBlpVVHJzVPcnHcTZ9FPhTKenlY0VL63b
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="371462296"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="371462296"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 03:42:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="665515011"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="665515011"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 02 Nov 2022 03:42:31 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 2 Nov 2022 03:42:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 2 Nov 2022 03:42:31 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 2 Nov 2022 03:42:31 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 2 Nov 2022 03:42:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iiOHOhRKiFRNI4laZqYF/p9qsAx9O8mlnb8EXbvo0NUz59AUe12HjNQqG3/hnyEur49LFhOLBVSliHylPj2Aqi/YMqQ/FIQpxc06ztM+pnbF6rn17BvDMcwIQLHJCSETXfhhXg9WIQVIgml+wyxd9JN3bxQw3Cf+3vKjL6J4gf8hiUoWsGiz5JRws/Ha8U81CvPWNJWWOFTP48aJmdB24WOJONP80uXx47TgNjaT189L0r0JX9OMAEKLaJEoij6LinHT3WZ0Zs6Pbb84S8n+gV62g+WP5S1lFAkdtJ2ROBBHlBCyoDBKHsKFB7uee0WJPaQyzu0uO1W0wmQB6Apuqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EANI3LeHMjaHT6RR1/GNHC8L/3+LbbBaIh+pHg84oT8=;
 b=gQM/1Ke3dlGbgKThe+4LOR8gUp5FhNK2WPSv+wIhximEHK9czLeWoe8II7GBgXAus/LgXSPRkvvtTBAdxeNm9Lx4/gjApvI9mQVzvwwxlNMUwKIuvOODIRbAQEJBShxOJdL+djaFXHGUHdeBGys4+Gf+NAqrKbHmx+avnlklHpx4HbKVjJnIL8tMVmWiCMiSy0ZU3nYXe37ilfxJ9KKXLOBEwS/zAT8b96xFqXtKmVz8pdCSdLh9zRQWowZPZ1u2UqZS8QFwFr5L7e1Vvt5NHqX+xwkGlqdcWv4ITXVny5R6qY56xrxjhum16mnHRwVPfFGC88mP3l7yba8g08Ndgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5424.namprd11.prod.outlook.com (2603:10b6:5:39c::8) by
 PH0PR11MB5126.namprd11.prod.outlook.com (2603:10b6:510:3a::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.21; Wed, 2 Nov 2022 10:42:28 +0000
Received: from DM4PR11MB5424.namprd11.prod.outlook.com
 ([fe80::6bb8:464a:b333:6a72]) by DM4PR11MB5424.namprd11.prod.outlook.com
 ([fe80::6bb8:464a:b333:6a72%7]) with mapi id 15.20.5769.021; Wed, 2 Nov 2022
 10:42:28 +0000
Message-ID: <de2882e5-3960-92b9-1d2a-826dc6a07183@intel.com>
Date:   Wed, 2 Nov 2022 12:41:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [Intel-gfx] [PATCH] drm/i915/hwmon: Fix a build error used with
 clang compiler
Content-Language: en-US
To:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "Dixit, Ashutosh" <ashutosh.dixit@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        "Nick Desaulniers" <ndesaulniers@google.com>
CC:     <intel-gfx@lists.freedesktop.org>, <llvm@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
References: <20221024210953.1572998-1-gwan-gyeong.mun@intel.com>
 <Y1ercgaqQwfqt42U@ashyti-mobl2.lan> <87ilk7pwrw.wl-ashutosh.dixit@intel.com>
 <Y1h8yn4QHI3aBlCe@ashyti-mobl2.lan>
 <CAKwvOdkpQvk31zbipLDPXfsDZ8FpGHs9t-+9JfFQO85Bs4h=wg@mail.gmail.com>
 <877d0lxl6s.wl-ashutosh.dixit@intel.com>
 <CAKwvOdmVJn8HvfF9WTnOAc+HsdJ4c1Tdck8E7Caky7AoCq4ZTA@mail.gmail.com>
 <875yg5xgkp.wl-ashutosh.dixit@intel.com>
 <c1c548f8-71a8-0d4d-d591-58a0cd5dac20@intel.com> <8735b89vz6.fsf@intel.com>
 <166737072744.4614.10758297029461955484@jlahtine-mobl.ger.corp.intel.com>
From:   Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
In-Reply-To: <166737072744.4614.10758297029461955484@jlahtine-mobl.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0002.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::8) To DM4PR11MB5424.namprd11.prod.outlook.com
 (2603:10b6:5:39c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5424:EE_|PH0PR11MB5126:EE_
X-MS-Office365-Filtering-Correlation-Id: d7dcee7e-1386-4c38-365c-08dabcbef002
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qfP9meqZoqjMEgozdC0DQO6span22fKRGsxcUKSc7yyBC9hWKzXiCtL4R/skLAgQfydAl/fiieQ74zDXaSqexM6S19U7TDRUmIn7SLIIRvhdKBicDAQcS3TzwDXcjMqu82wjunqZPTdPqy5Utev5vsC+iNkHh9gF7Gw+pqvtu7AN7xVazK3pmJRBTR/xOaNzkAqaz2xciXh5VxBMFErMDmxfA67zQ6g+J1tSCbEt57ryzs1P4/h7h13RJ+2B04NzO60dRaZrpzw+taACcrtnQlUA1hn2ScFV5IXaHAvJ+h/ARfcKYL+A28VdCe/PPTFJwzTaywEyOiUG7OpyAZ6zEY6ATJYCmPAC/U7Vc2YgNkmpk2ZItCuxTL90h/F2PQBmmYZXo+9UvWyx+RgKPFmmMAqVr9dgvFTY2R0hM0TasIVUIgZPd9KNWUUc/ezuYxVSs6rLj3ujMVnWkQ+NXIv4ej5LWA78bz7mTnKlv9d7uLj5a7b5qyBnoSb8vgHbNjOZcmbXulN+OUclwWcAkv9nLYXJefigfjDNi58ZQT5F4uKHNQGPU56l67gDmIFZ1hWYDCY0Oqt4xQd06Wk6DfMsYHbZ8rUKV5p904bu8vl5/4FjtVR+e5GUFR6SJqimBSYkwwfnziMoXILmiIRvtpHZ2dF6JJK2Qx9rdJLnP/CbpR5E9XVs3MbNPcb2JnpuFkpwg6pvd8DgbYQ9mQSNmMD+M7Kdn+njjONZbnZTrqrcXfbuaPlKNOQVHk6b8ZAc0FsfKNesodcB2Fta/XdYmJLTx7I/MxkpOV9NUQhlC77YP4X1WbznDK5fG+fig4eCcuKL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5424.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(39860400002)(396003)(366004)(346002)(451199015)(41300700001)(31686004)(36756003)(38100700002)(66556008)(4326008)(110136005)(66946007)(66476007)(5660300002)(316002)(31696002)(86362001)(82960400001)(478600001)(966005)(6506007)(8936002)(8676002)(26005)(6486002)(53546011)(6512007)(30864003)(4001150100001)(83380400001)(186003)(2906002)(6666004)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXdMNDFNUUdocEZhUUFBNG5wS1VRTEFmSGlCR1FweVRwTGYzZlJJeTVRYUVp?=
 =?utf-8?B?U09EMExCOWZCdGJpSEdEbmhNY1djMXovWmlTclFwdTY2V2dHNUFSaGtJZlEr?=
 =?utf-8?B?YnlaNG1HbUtCUEtPb1VTazk0T2pEQTJLc2l6SVJLYnhqQkVVRldxRkhxci9O?=
 =?utf-8?B?N2lLMHUxQ0JyN1llMWpTU1FhUEh6NHpIR1pqQy91TC9KRTJvL09GdS9yWFJL?=
 =?utf-8?B?ZnR2STZoVEZmSGlobnF5VEVtNTVuNFJVZ1hNSS94WWd5Q0dDQTgzVnFDQWVY?=
 =?utf-8?B?cTdSaTlpNTI3ckl0eWdVMkdEb2theUxsQXdCMmZlN2JVWjcya0Fhcm5jVTlC?=
 =?utf-8?B?WDRPcnJuYWhhWmZNWHo3MlRnbVpsWlo1NlpZTHh3TkNnVVRTWS9TaDlXYmhO?=
 =?utf-8?B?NTBVMEFpMHVpbjRCTHYzWTdoZVd3Z3kyNU4xTnFNSGVFbUh5MmtQQXRzVFFj?=
 =?utf-8?B?ZHV4TWNYUmJiZ2JIckh1MFdsaVV3QU1lUlBvemc0K05XV0F0bzc1bFZvY05U?=
 =?utf-8?B?a0pHOUhIY1kybS9oa1p0TjJROVVBZzJKYnpzNTN2bkJBZ1JLVURmT1NCbVFT?=
 =?utf-8?B?c2lCUW12eWE5N1pKcmN3emRpNjBJbElLRUxQVFQyalZxbzJHcVcvQlBTUW5K?=
 =?utf-8?B?ZXk3VW5yZkxaZVptMHdoMWVjdjZRKzVuTm0xcXpzL2V2Yk56YUc3cWR2d0hI?=
 =?utf-8?B?QWlKYVdVNkluS3hoRUdocTkwbHQ1QmVZcUM0UzNTMXZ0UEVXZUhHMkgxRURj?=
 =?utf-8?B?clpoN1djeS9nUkVmdEVwamxNdjdUcHQ3OWVwWVJGZXdEZ1pSeUVtdEFObi9F?=
 =?utf-8?B?K2t3ZVlRcU9zQkNhZnQ2cGh4aXJKYTdEalV3RDh1TWpYSFNzSEMxRklLOHc1?=
 =?utf-8?B?NlMrY3pFMXNTSGgyUElyMlB3R0hxUlF2K0xKVjNlV0pOdXFDMEFpODkrZGtq?=
 =?utf-8?B?MjJEcGp0MzVFdXF3TzFzUy9ja2szQXdrMHV2ODRqS2U3c2IySjl1bTFlUlhL?=
 =?utf-8?B?ZlY4UDhMbUpGa1NkcGhBYmNORU1KcE5oOTBTQkd4VVd3ZFVyT1d3a3FzQjJy?=
 =?utf-8?B?NDJnNk5kRXpaNWpsRGEwR09obDZOYVEyZzlJaE9RUnVmemt3dnRST2Iyb2p1?=
 =?utf-8?B?eFp6WDJuLzJlNWN0ZklNaVZWTEdCZXNEOUh6M2xQeE1HZHNSeVVMVS9KWW5L?=
 =?utf-8?B?eXpzYWprY1g2VkNPQWVxR2U3bU9hL1hKcllrNEN5QVVXSEk3QStjdHFGUkov?=
 =?utf-8?B?cnZxWkExQUFEMFBmRitiZkNqV2VkUnF6eDhaTkFML1J4TVg0c0cyeVdQMElk?=
 =?utf-8?B?UFR5ZWJ3QWtwb1ZJZVFvS092V053cEZNUUxnNjhaeU5CMnhzMGxhZUk0NGhn?=
 =?utf-8?B?TGpTT25qSGwvTTFlZ1FkbEVLMDlsdmd3ejE4RW82U1RpdU85bGx1ZnJ2cVdD?=
 =?utf-8?B?T3k0R3FhV3doTk52UDk5UHk5Zjg0aXYxVEg1STV4cXRnbU8zNU02T1lBK2J1?=
 =?utf-8?B?akhKTDFVSUF5N3dJOGtWQWdwRzc3RTZRNVpxMnJxc1lpTnVQOVJvUlJQWnFX?=
 =?utf-8?B?bFpFUUYwUWtGeHBFb3JRMkRiSHVpdnk5a3pqMGRBK2dFZllMbEdLMDFtaWdq?=
 =?utf-8?B?clJ4dDBRVXdKckhyVkl4NVNkN1NPamxYWTVDL2tFaGRFVUNGZGYxY3g3MUJV?=
 =?utf-8?B?eVppU0d3Z3F0TGR4VHZkanhkeGkvK1loK3JzM1ZGL051NWRYUll4VmxzbDVy?=
 =?utf-8?B?ejN1ZTdCa2FBM2s0Nk5lU0VxVGNVc2dEbU15NWdMWjJESHQ3RXZ6VDVKR1RS?=
 =?utf-8?B?REtZbWxLRzVUMDJvMWdIYkFNN1dEcXBkYnNnNExkUXAvS0hUVDRqa25vU21r?=
 =?utf-8?B?WHVWQW81bUdNUTk3dVdwdGN3YlBLMGdDM3lyTzZXYXpRWnBiNFhuaXNqeGhE?=
 =?utf-8?B?ZnVzWm9nMWVEUWlLNXovTDUzVDdLL3pGMkZzL0pucnpOOEs5ejgwWHdNMSsz?=
 =?utf-8?B?THJDdnVGTmEvVDV4N2paVm16TWZaUGJHM2pHMDhxUmxYekV0cG1BS3J0T3RN?=
 =?utf-8?B?RGpjZUh6clI1OVdMWjcxOGhFNFBML3lESk9rRUdHc1ZVRUExYWx1MTB6MkYw?=
 =?utf-8?B?NzhMODVTTlVQRG1OdW9JdXlTeGRsei9rR1RFZFpPVTNHUjFFY0xhL213Zm1x?=
 =?utf-8?B?T0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d7dcee7e-1386-4c38-365c-08dabcbef002
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 10:42:28.5781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w6GA/dKrOdZRxNpdlAaVZ6T87GGwC4ctBpLrKnFQqqcqFTIkxnz2a1PbD3mkhkc7GoDAE/cKuTqMQ5xCpKe8NZCKUdLvV74LrD/WIfD0joA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5126
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/2/22 8:32 AM, Joonas Lahtinen wrote:
> Quoting Jani Nikula (2022-10-28 11:46:21)
>> On Fri, 28 Oct 2022, Gwan-gyeong Mun <gwan-gyeong.mun@intel.com> wrote:
>>> Resend, because some content was accidentally omitted from the previous
>>> reply.
>>> Please ignore the previous email.
>>>
>>> Hi all,
>>>
>>> I should have written the original commit message more accurately, but
>>> it seems that it was written inaccurately.
>>>
>>> If the FIELD_PREP macro is expanded, the following macros are used.
>>>
>>> #define FIELD_PREP(_mask, _val)                                               \
>>>        ({                                                              \
>>>                __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
>>>                ((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask);   \
>>>        })
>>>
>>>
>>> #define __BF_FIELD_CHECK(_mask, _reg, _val, _pfx)                     \
>>>        ({                                                              \
>>>                BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),          \
>>>                                 _pfx "mask is not constant");          \
>>>                BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");    \
>>>                BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
>>>                                 ~((_mask) >> __bf_shf(_mask)) & (_val) : 0, \
>>>                                 _pfx "value too large for the field"); \
>>>                BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
>>>                                 __bf_cast_unsigned(_reg, ~0ull),       \
>>>                                 _pfx "type of reg too small for mask"); \
>>>                __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
>>>                                              (1ULL << __bf_shf(_mask))); \
>>>        })
>>>
>>> Among them, a build error is generated by the lower part of the
>>> __BF_FIELD_CHECK() macro.
>>>
>>>                BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
>>>                                 __bf_cast_unsigned(_reg, ~0ull),       \
>>>                                 _pfx "type of reg too small for mask"); \
>>>
>>>
>>> Here, if you apply an argument to this macro, it will look like the
>>> following.
>>>
>>> __bf_cast_unsigned(field_msk, field_msk) > __bf_cast_unsigned(0ULL, ~0ull)
>>>
>>> The result is always false because an unsigned int value of type
>>> field_msk is not always greater than the maximum value of unsigned long
>>> long .
>>> So, a build error occurs due to the following part of the clang compiler
>>> option.
>>>
>>> [-Werror,-Wtautological-constant-out-of-range-compare]
>>>
>>> You can simply override this warning in Clang by adding the build option
>>> below, but this seems like a bad attempt
>>>
>>> i915/Makefile
>>> CFLAGS_i915_hwmon.o += -Wno-tautological-constant-out-of-range-compare
>>>
>>> The easiest way to solve this is to use a constant value, not a
>>> variable, as an argument to FIELD_PREP.
>>>
>>> And since the REG_FIELD_PREP() macro suggested by Jani requires a const
>>> expression as the first argument, it cannot be changed with this macro
>>> alone in the existing code, it must be changed to input a constant value
>>> as shown below.
>>
>> We've added REG_FIELD_PREP() precisely to avoid the problems with the
>> types and ranges, as we want it to operate on u32. It also uses
>> __is_constexpr() to avoid dependencies on compiler implementation and
>> optimizations.
>>
>> Please use REG_FIELD_PREP() and a constant value. Maybe rethink the
>> interface if needed.
> 
> Ashutosh and GG, can we get a fix for this merged ASAP. It's currently
> blocking the drm-intel-gt-next pull request.
> 
> Regards, Joonas
> 
Hi Joonas,
As a workaround patch, this patch[1] was reviewed by Ashutoshr and acked 
by Jani.

[1] https://patchwork.freedesktop.org/patch/509248/?series=110094&rev=5


Br,

G.G.
>>
>> BR,
>> Jani.
>>
>>
>>
>>
>>>
>>> diff --git a/drivers/gpu/drm/i915/i915_hwmon.c
>>> b/drivers/gpu/drm/i915/i915_hwmon.c
>>> index 08c921421a5f..abb3a194c548 100644
>>> --- a/drivers/gpu/drm/i915/i915_hwmon.c
>>> +++ b/drivers/gpu/drm/i915/i915_hwmon.c
>>> @@ -101,7 +101,7 @@ hwm_field_read_and_scale(struct hwm_drvdata *ddat,
>>> i915_reg_t rgadr,
>>>
>>>    static void
>>>    hwm_field_scale_and_write(struct hwm_drvdata *ddat, i915_reg_t rgadr,
>>> -                         const u32 field_msk, int nshift,
>>> +                         int nshift,
>>>                             unsigned int scale_factor, long lval)
>>>    {
>>>           u32 nval;
>>> @@ -111,8 +111,8 @@ hwm_field_scale_and_write(struct hwm_drvdata *ddat,
>>> i915_reg_t rgadr,
>>>           /* Computation in 64-bits to avoid overflow. Round to nearest. */
>>>           nval = DIV_ROUND_CLOSEST_ULL((u64)lval << nshift, scale_factor);
>>>
>>> -       bits_to_clear = field_msk;
>>> -       bits_to_set = REG_FIELD_PREP(field_msk, nval);
>>> +       bits_to_clear = PKG_PWR_LIM_1;
>>> +       bits_to_set = REG_FIELD_PREP(PKG_PWR_LIM_1, nval);
>>>
>>>           hwm_locked_with_pm_intel_uncore_rmw(ddat, rgadr,
>>>                                               bits_to_clear, bits_to_set);
>>> @@ -406,7 +406,6 @@ hwm_power_write(struct hwm_drvdata *ddat, u32 attr,
>>> int chan, long val)
>>>           case hwmon_power_max:
>>>                   hwm_field_scale_and_write(ddat,
>>>                                             hwmon->rg.pkg_rapl_limit,
>>> -                                         PKG_PWR_LIM_1,
>>>                                             hwmon->scl_shift_power,
>>>                                             SF_POWER, val);
>>>                   return 0;
>>>
>>>
>>>
>>> In addition, if there is no build problem regardless of the size of the
>>> type as the first argument in FIELD_PREP, it is possible through the
>>> following modification.
>>> (Since this modification modifies include/linux/bitfield.h , I will send
>>> it as a separate patch.
>>>     )
>>>
>>> However, it seems that we need to have Jani's confirm whether it is okay
>>> to use FIELD_PREP() instead of REG_FIELD_PREP() which is forced to u32
>>> return type in i915.
>>>
>>> diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
>>> index c9be1657f03d..6e96799b6f38 100644
>>> --- a/include/linux/bitfield.h
>>> +++ b/include/linux/bitfield.h
>>> @@ -9,7 +9,7 @@
>>>
>>>    #include <linux/build_bug.h>
>>>    #include <asm/byteorder.h>
>>> -
>>> +#include <linux/overflow.h>
>>>    /*
>>>     * Bitfield access macros
>>>     *
>>> @@ -69,7 +69,7 @@
>>>                                    ~((_mask) >> __bf_shf(_mask)) & (_val)
>>> : 0, \
>>>                                    _pfx "value too large for the field"); \
>>>                   BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
>>> -                                __bf_cast_unsigned(_reg, ~0ull),       \
>>> +                                __bf_cast_unsigned(_reg,
>>> type_max(__unsigned_scalar_typeof(_reg))),    \
>>>                                    _pfx "type of reg too small for mask"); \
>>>                   __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
>>>                                                 (1ULL << __bf_shf(_mask))); \
>>> @@ -84,7 +84,7 @@
>>>     */
>>>    #define FIELD_MAX(_mask)                                               \
>>>           ({                                                              \
>>> -               __BF_FIELD_CHECK(_mask, 0ULL, 0ULL, "FIELD_MAX: ");     \
>>> +               __BF_FIELD_CHECK(_mask,
>>> type_min(__unsigned_scalar_typeof(_mask)),
>>> type_min(__unsigned_scalar_typeof(_mask)), "FIELD_MAX: ");   \
>>>                   (typeof(_mask))((_mask) >> __bf_shf(_mask));            \
>>>           })
>>>
>>> @@ -97,7 +97,7 @@
>>>     */
>>>    #define FIELD_FIT(_mask, _val)                                         \
>>>           ({                                                              \
>>> -               __BF_FIELD_CHECK(_mask, 0ULL, 0ULL, "FIELD_FIT: ");     \
>>> +               __BF_FIELD_CHECK(_mask,
>>> type_min(__unsigned_scalar_typeof(_mask)),
>>> type_min(__unsigned_scalar_typeof(_val)), "FIELD_FIT: ");    \
>>>                   !((((typeof(_mask))_val) << __bf_shf(_mask)) & ~(_mask)); \
>>>           })
>>>
>>> @@ -111,7 +111,7 @@
>>>     */
>>>    #define FIELD_PREP(_mask, _val)
>>>            \
>>>           ({                                                              \
>>> -               __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
>>> +               __BF_FIELD_CHECK(_mask,
>>> type_min(__unsigned_scalar_typeof(_mask)), _val, "FIELD_PREP: ");       \
>>>                   ((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask);   \
>>>           })
>>>
>>> @@ -125,7 +125,7 @@
>>>     */
>>>    #define FIELD_GET(_mask, _reg)                                         \
>>>           ({                                                              \
>>> -               __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
>>> +               __BF_FIELD_CHECK(_mask, _reg,
>>> type_min(__unsigned_scalar_typeof(_reg)), "FIELD_GET: "); \
>>>                   (typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask)); \
>>>           })
>>>
>>>
>>> Br,
>>>
>>> G.G.
>>>
>>> On 10/27/22 9:32 PM, Dixit, Ashutosh wrote:
>>>> On Thu, 27 Oct 2022 10:16:47 -0700, Nick Desaulniers wrote:
>>>>>
>>>>
>>>> Hi Nick,
>>>>
>>>>> Thanks, I can repro now.
>>>>>
>>>>> I haven't detangled the macro soup, but I noticed:
>>>>>
>>>>> 1. FIELD_PREP is defined in include/linux/bitfield.h which has the
>>>>> following comment:
>>>>>    18  * Mask must be a compilation time constant.
>>>>
>>>> I had comments about this here:
>>>>
>>>> https://lore.kernel.org/intel-gfx/87ilk7pwrw.wl-ashutosh.dixit@intel.com/
>>>>
>>>> The relevant part being:
>>>>
>>>> ---- {quote} ----
>>>>>>> ./include/linux/bitfield.h:71:53: note: expanded from macro '__BF_FIELD_CHECK'
>>>>>>>                   BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
>>>>
>>>> So clang seems to break here at this line in __BF_FIELD_CHECK (note ~0ull
>>>> also occurs here):
>>>>
>>>>               BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
>>>>                                __bf_cast_unsigned(_reg, ~0ull),       \
>>>>                                _pfx "type of reg too small for mask"); \
>>>>
>>>> So it goes through previous checks including the "mask is not constant"
>>>> check. As Nick Desaulniers mentions "__builtin_constant_p is evaluated
>>>> after most optimizations have run" so by that time both compilers (gcc and
>>>> clang) have figured out that even though _mask is coming in as function
>>>> argument it is really the constant below:
>>>>
>>>> #define   PKG_PWR_LIM_1              REG_GENMASK(14, 0)
>>>>
>>>> But it is not clear why clang chokes on this "type of reg too small for
>>>> mask" check (and gcc doesn't) since everything is u32.
>>>> ---- {end quote} ----
>>>>
>>>>>
>>>>> 2. hwm_field_scale_and_write only has one callsite.
>>>>>
>>>>> The following patch works:
>>>>
>>>> If we need to fix it at our end yes we can come up with one of these
>>>> patches. But we were hoping someone from clang/llvm can comment about the
>>>> "type of reg too small for mask" stuff. If this is something which needs to
>>>> be fixed in clang/llvm we probably don't want to hide the issue.
>>>>
>>>>>
>>>>> ```
>>>>> diff --git a/drivers/gpu/drm/i915/i915_hwmon.c
>>>>> b/drivers/gpu/drm/i915/i915_hwmon.c
>>>>> index 9e9781493025..6ac29d90b92a 100644
>>>>> --- a/drivers/gpu/drm/i915/i915_hwmon.c
>>>>> +++ b/drivers/gpu/drm/i915/i915_hwmon.c
>>>>> @@ -101,7 +101,7 @@ hwm_field_read_and_scale(struct hwm_drvdata *ddat,
>>>>> i915_reg_t rgadr,
>>>>>
>>>>>    static void
>>>>>    hwm_field_scale_and_write(struct hwm_drvdata *ddat, i915_reg_t rgadr,
>>>>> -                         u32 field_msk, int nshift,
>>>>> +                         int nshift,
>>>>>                             unsigned int scale_factor, long lval)
>>>>>    {
>>>>>           u32 nval;
>>>>> @@ -111,8 +111,8 @@ hwm_field_scale_and_write(struct hwm_drvdata
>>>>> *ddat, i915_reg_t rgadr,
>>>>>           /* Computation in 64-bits to avoid overflow. Round to nearest. */
>>>>>           nval = DIV_ROUND_CLOSEST_ULL((u64)lval << nshift, scale_factor);
>>>>>
>>>>> -       bits_to_clear = field_msk;
>>>>> -       bits_to_set = FIELD_PREP(field_msk, nval);
>>>>> +       bits_to_clear = PKG_PWR_LIM_1;
>>>>> +       bits_to_set = FIELD_PREP(PKG_PWR_LIM_1, nval);
>>>>>
>>>>>           hwm_locked_with_pm_intel_uncore_rmw(ddat, rgadr,
>>>>>                                               bits_to_clear, bits_to_set);
>>>>> @@ -406,7 +406,6 @@ hwm_power_write(struct hwm_drvdata *ddat, u32
>>>>> attr, int chan, long val)
>>>>>           case hwmon_power_max:
>>>>>                   hwm_field_scale_and_write(ddat,
>>>>>                                             hwmon->rg.pkg_rapl_limit,
>>>>> -                                         PKG_PWR_LIM_1,
>>>>>                                             hwmon->scl_shift_power,
>>>>>                                             SF_POWER, val);
>>>>>                   return 0;
>>>>> ```
>>>>> Though I'm not sure if you're planning to add further callsites of
>>>>> hwm_field_scale_and_write with different field_masks?
>>>>
>>>> I have reasons for keeping it this way, it's there in the link above if you
>>>> are interested.
>>>>
>>>>>
>>>>> Alternatively, (without the above diff),
>>>>>
>>>>> ```
>>>>> diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
>>>>> index c9be1657f03d..6f40f12bcf89 100644
>>>>> --- a/include/linux/bitfield.h
>>>>> +++ b/include/linux/bitfield.h
>>>>> @@ -8,6 +8,7 @@
>>>>>    #define _LINUX_BITFIELD_H
>>>>>
>>>>>    #include <linux/build_bug.h>
>>>>> +#include <linux/const.h>
>>>>>    #include <asm/byteorder.h>
>>>>>
>>>>>    /*
>>>>> @@ -62,7 +63,7 @@
>>>>>
>>>>>    #define __BF_FIELD_CHECK(_mask, _reg, _val, _pfx)                      \
>>>>>           ({                                                              \
>>>>> -               BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),          \
>>>>> +               BUILD_BUG_ON_MSG(!__is_constexpr(_mask),                \
>>>>>                                    _pfx "mask is not constant");          \
>>>>>                   BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");    \
>>>>>                   BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
>>>>> ```
>>>>> will produce:
>>>>> error: call to __compiletime_assert_407 declared with 'error'
>>>>> attribute: FIELD_PREP: mask is not constant
>>>>>
>>>>> I haven't tested if that change is also feasible (on top of fixing
>>>>> this specific instance), but I think it might help avoid more of these
>>>>> subtleties wrt. __builtin_constant_p that depende heavily on compiler,
>>>>> compiler version, optimization level.
>>>>
>>>> Not disagreeing, can do something here if needed.
>>>>
>>>> Thanks.
>>>> --
>>>> Ashutosh
>>
>> -- 
>> Jani Nikula, Intel Open Source Graphics Center
