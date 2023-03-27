Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D721C6CACC3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 20:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjC0SLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 14:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjC0SLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 14:11:47 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8AF95;
        Mon, 27 Mar 2023 11:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679940706; x=1711476706;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OWH2uOgNeiZW7Bw/QuQRkVHwLq0qsNjVWxbSTLJc9OY=;
  b=Vjfsy5NJsbEGC3/TnLuPKcN8UfyPgQVR1T1fAWlmFCmggBtPa81Utfve
   SS8To+ih1XKtRpOeavFdI+UpWKVRfBro5QuTq+b+XRLSi7UST/uEBeFIR
   4jlYt/VhTRS7Oi+w8C+wSfRSAFOJfV7FPD+fycvZYBk6hxy9iyULsREAc
   vYegjsJJYkj9jLUGtxlcNAhLSRBQu2lVHdpwJL0y/etLY3KwdbJmZmVfz
   zk43xdKxt4rGbRf9LvaJUt76wWZuVJdxi8cnv3bgqcoarBUGYaOVttyhc
   gQqTuLCXXgeZ2OzeZarLbbv0nOUGw983fDtzc+U2qj6l9YbolJPQOSPK6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="342752959"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="342752959"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 11:11:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="677072639"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="677072639"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 27 Mar 2023 11:11:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 11:11:45 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 11:11:45 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 27 Mar 2023 11:11:45 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 27 Mar 2023 11:11:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HyFhoxxAqDGo/5S2F+JjtZuk5f1ESglUenoE3ZNY1S8kjx6qpjCaa+TCL/aCRpQUAjZp93VRSTGT6EKq9uLCns/V++9DgE/ONLgHihOcTyt86RpXUvPF/lNPklMtNr0RFcnlbI915aJGv7HqLx00gH3117cNNX/3qj2t+m4wQySPjyq6FI8iCv/xptqhoMFD0GjS05A9h2xkePohDIs8GPaHh9n9vPsdcrJVYU1y7SR1Ig8ArV9kgX1YdXBs3RnT5aOdr1OvxfCL5BOL/5cSiY94xjpzBH2QpLRSM2MBE4PZf7U0w/gTPJlwcWS+XLZZS/cK/8+SgH6Ujpkji/zDBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6gLsXOsLUH3S4+h37r8zhItmiJtXGMIyWV6YdVcYT8k=;
 b=StZ9LD8vcCTfPB4ZjBUe9JzgeNvPXTYeo/YeBmjYzqr2wb+BgHKW4RK88ShBbh7GEy/UQ66o0wfYTAOEkkG4aBYo/qeVXFwfbMDv0BubIxvLORs7DkH1kkpjFOjpkSkR+mIaHj+FNirFKs/Rw7whPuU8Jf0+ap1eGdF5BDrBcsaehPkrs3j5yoNYnlj3jvt+ozGC+qwD6k6BFmXL7J/IfTt94ChN0b3rRGo1MDtB2KE899j2L/ayml+smRcfYw3CiLyWNoUVMx49q5Ec5WJ4BIMhFdRS2CH9zZq7rcdVkXciQy/VUD2Xv5lvvL8nKJ13cc6nXrI0eHkpB3ImufuCWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by DS0PR11MB8205.namprd11.prod.outlook.com (2603:10b6:8:162::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 18:11:43 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::9121:8fa8:e7d9:8e46]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::9121:8fa8:e7d9:8e46%8]) with mapi id 15.20.6178.038; Mon, 27 Mar 2023
 18:11:43 +0000
Message-ID: <5ea54045-e5d6-720f-5b37-5f019c147a66@intel.com>
Date:   Mon, 27 Mar 2023 20:11:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: linux-next: duplicate patch in the pm tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Aymeric Wibo <obiwac@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <20230327074547.5c418918@canb.auug.org.au>
Content-Language: en-US
From:   "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
In-Reply-To: <20230327074547.5c418918@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0017.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::20) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5810:EE_|DS0PR11MB8205:EE_
X-MS-Office365-Filtering-Correlation-Id: b820216c-085a-428d-d297-08db2eeeb804
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sMIw8uIxV9l+CmC/sosUkax2BzG730pLO03gSZ0yOW55bImtOxiH8+Uvp+5be2rtnu+MYN55c9JFm4+v8UlVyLiZquVFWATI9ip0J61kn3G1/FrvrIQhqCr28Egi5qyMgadgwWZBIYzCwSvB4GOP1smuUgkbtH4IDXVWLv0YUpeoiYlvRrh+iR3U5VeiZe2jGMom8ex3tLwjtWMi9Oii3faXcS9CAoZ+VuDg/83cHfUVPt/ABLelyeXJiS80XV0QOTK1ZAs9NINbFl7Klw4Tt+HHogUimVtU3rScCJwu837g8YBYKHXF+NRJUUjtRwBx63giTGwjvIsGDdaLXNXi9AUycqvEU/Xe0jY9X4BAXUjGRtPv+j2y7wU/qOY5MwZzXVyZ7ocLFULQa+7xXBMOHHpya10+pdAoaAdqlUDDbzYHclNUnO+YDmbIaBZI3uNJ3sanZG+y6cziTfgGmI7i/08CMxcRqOrpn65Wlu3bdMZn8E2jQCVCmiuj03Pr+XbM/sMlFc3gqpd6uhgg+lYOtK35L1EvX2GoIQCr2ZBHEoAcT6rtKKmliQDzJ5c0dWT0lTYO+jGpfLQdN48X4A9PxymWNPGeVAo6z2B15vH3Cdtl2aGU2UYMrlF1wA5uXAf2XiSbAeFFvaRgkHuocUog1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199021)(6512007)(6506007)(26005)(54906003)(6486002)(316002)(6666004)(4326008)(186003)(53546011)(6916009)(66476007)(66556008)(66946007)(8676002)(478600001)(31686004)(41300700001)(86362001)(5660300002)(82960400001)(38100700002)(2906002)(36756003)(4744005)(2616005)(31696002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3dWN2toMG1YMVFCcEszYiswYlVVSHJOZzZidTdKa3JWVVMwd2tHRnordnRx?=
 =?utf-8?B?N21nRE9WcCtqN2ZkdmVWNnVVR3ZYTXJ2TS9MR0N2YzVESFNMbUtBdWpqbVND?=
 =?utf-8?B?bnc0UTlqcGgwVHVPYlJQS3luV2V1VTNZejNIOW9EZWN0UWZQUy9oUEFCTGVs?=
 =?utf-8?B?ZmxJV2VhZGh1VGN1b2tJT2lxV2lVVlFOK0NLMi9sdFFkaW00LzRpcmNJcytp?=
 =?utf-8?B?cFJHMVlvRHdGeWRTVlBMalFCT2pvaUVrYmpKOTJ1SktoVUZrdm9KY3RNeVlK?=
 =?utf-8?B?NEY3SGJlMGEzbTkwSGRyVFE3TmtlSjdVd3VFVlhNaXZRcjd3eXBibGxkVCtl?=
 =?utf-8?B?S3NNSzBLNmE3MHNJMW9jQU91OUh6NWRQQkxndWFYVHR6dThKWUpTRENHYU1F?=
 =?utf-8?B?RnRxeTEwczR6VitsZVN1enVQait4L3J0aEpScFdoREtmMXRveDZGai9BK3lB?=
 =?utf-8?B?dllqaGl4TU5FOWVUN2xiclRaU0lBaUd6anV2cUR1STczUzNHcHVPVzZwWUN0?=
 =?utf-8?B?Tkw5RWlIUlJZcFNzK2xUQWdrRUtUcVhJSUZpN1J5UTFQdytPa0ZzMzNwTFBt?=
 =?utf-8?B?b2tkckNjQnNHakg2a2UyZUdjN0s2TWZBcGhFZjlaSWdKeEdzN0w4SkphQXEw?=
 =?utf-8?B?WDltT1FKY0J1REFYaERIMW9nL01GaVh6aDJ3THN5VUpUT0xzcmxpamZNcFNG?=
 =?utf-8?B?akpoZm80NS9QYkVjd3RUV1VoQTNEeWVxM2syZEZ0N24vcGg5MW8yMXNYZ29I?=
 =?utf-8?B?Z3g2dlpFdExRdnNHTXBWc09kRmZQVVVRY2g0bzg0OU00OHVYQXdNQXRhZzdG?=
 =?utf-8?B?MWJqck1lWFJEcTlGRXBrRHJsOUxpUzRPc1JpU3ZPSW9QTEZWQUtHakxZeHNo?=
 =?utf-8?B?SFpHNWJNWVZEMWFuQlhzVXpwRUlZVWM5c1Z6MTBHTVo0RnJsT1B0VHZDNnNo?=
 =?utf-8?B?K0Izenp1NExyZEZsV041cEltdG9FazE1MVI0b2g3dTVoSk4vZEttUytqTTVv?=
 =?utf-8?B?cnhRVXh5UmVNaVdTZ1BJNjdtbStDWURxR1dCOEN0ZzNrejJhWkYyNGo4SnJ3?=
 =?utf-8?B?T2h2S2tVcS9RL2JRb1g2clBZK2VzbVU2NUFxbTJtcklRQVN6Z0dtYklXdEZJ?=
 =?utf-8?B?UkF1Y3BuMFJvYUpNYmhZWXNON2tNa3hycVlXQzFpNmh6YUEzd01Ub0RlTmRV?=
 =?utf-8?B?MzNDVnRDYmp4KzlVU211UjBtN0FpaXhDbWx1OVBzd3c0Uk5PYzlCdkhYb0Zi?=
 =?utf-8?B?d0J3Vm10dVFvc3NsaHJVSjA4bFppUEpyVG1JcHFBb0RETy95YjBHK3hTeUF2?=
 =?utf-8?B?UzB4S0tOT2tiOHYrREwxWmRaQnJDbm9rblR4WE1rbmtzWDQ5TXJwSzFtcnZP?=
 =?utf-8?B?dUNHeTVUZFQwamttYUE3ZWhQd1hSeVJYaEEvZE8wNEdpZnh2SVRES2xjR2pL?=
 =?utf-8?B?VDJ1NVk1MU5qeDE1TnVCZ0ljdmZ6UUR4d05FaXB4R2Jrck5CMDRxVGJWMjdl?=
 =?utf-8?B?NDc4a1VMUHlzayt0SFozUlhab2dYWEJOY0ZVQUpHemREaFdZV2tOQXlIUitn?=
 =?utf-8?B?MXhkc256dk4vNkpTVUJJY0QxQXNsRGc4QnFOdmVYRnlGSFBXYkFQNEttZjBX?=
 =?utf-8?B?OGJTeW82NlU0eTlKQVNVazRLaFFuZnBpc2hUcmJRc1BwVk4xRytDSGs1SkNy?=
 =?utf-8?B?YURPNUw1NzZLbFpMUitlTURndmFyS0J0Y0NsRmRpME9OMWk3VGQxRDdITWda?=
 =?utf-8?B?blVBQWtjd2p5RkV5T0pyWGNaWVpCOS9BRWNtVHpUMlIyZlY4Y1hEbWIvUGhx?=
 =?utf-8?B?dmNUV3FKVnJwM0tSMmxtNjh6ZW5qdXppNE04bDVpNnRoZTB2U0xQZHlUNmZE?=
 =?utf-8?B?cmNMUWVLQjRROGFoUDhEaUgvWkc4SGdqV0ljVGpYbDBEUzFKOEhZcFJVd29F?=
 =?utf-8?B?UlBXMUFyVlhYOGhlUE4rUFBxOXhDMHNWRENnS1BqMzlJSVpwTFArdmhLSjQz?=
 =?utf-8?B?MVBMQzV2emJZUDE2L1ZxSGFkSXExWldLQUg0UjNMMmxKWTlhN2NCMk9oK0t1?=
 =?utf-8?B?QnN5Zzk2L3RmdDNJTEFRanNWbUs0RVpUMlZYaHN3ODArekxCNjk4aFpRMUNn?=
 =?utf-8?B?OXZUVjJpYXgrb01MYXFXN3hkZXJ3R21CN3VEUFREdmVkU1ZvZlcrN3EwVVU1?=
 =?utf-8?B?b1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b820216c-085a-428d-d297-08db2eeeb804
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 18:11:43.1380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u7uShfNSfgED3UAxmg2H1mVNAL8Ivc0yM7kxtmp1S4X4w8PCZnyy/GBzmah3qyyD0zD8/m/aggq3WPm8La3AOd+rX/ERQqS+bPBPgBKlOZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8205
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/2023 10:45 PM, Stephen Rothwell wrote:
> Hi all,
>
> The following commit is also in Linus Torvalds' tree as a different commit
> (but the same patch):
>
>    bb796d5112d2 ("ACPI: resource: Add Medion S17413 to IRQ override quirk")
>
> This is commit
>
>    2d0ab14634a2 ("ACPI: resource: Add Medion S17413 to IRQ override quirk")
>
> in Linus' tree.

The duplicate patch should be gone from linux-next tomorrow, sorry for 
the trouble.


