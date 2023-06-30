Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B460B7438B7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 11:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbjF3Jwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 05:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjF3Jw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 05:52:29 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACDBE63;
        Fri, 30 Jun 2023 02:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688118748; x=1719654748;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=M1axvsu+yHD5SUjD8wsJaPSmN+57L9tC8I9uKNlSuSc=;
  b=AumNtyo+gEoAGlBdcV9wUPaxSSa9eSwca6gwLwa7Fmtj03SG7l0Sy+cu
   CV6T2KILrsFfE9K8AgWjc64qCrYZtaSIW7DusCYyQYDSqO7/XIB4SILNS
   keP0TgUjZ77bzrtL3Ikq53Oyzhl9AX9HCXgnwxy/H6yLOHedHKiXF6+Fk
   bt0tngce4u8DF9BtKSWb4L9d9bir5MVIhiaCvxOgfCt86Qd9d1AjtOTc6
   qDkMkvSRABVJ93Ba28GJYVIfG9Od2QI7sijTL7w0y+BqPdbX7vtAWUBj2
   pDkxLvqd79oolK+4GyXnm7CY1HWH091+qWvd11doI8GWDJWs/X4oBZitr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="342697875"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="342697875"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 02:52:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="841804442"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="841804442"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 30 Jun 2023 02:52:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 30 Jun 2023 02:52:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 30 Jun 2023 02:52:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 30 Jun 2023 02:52:15 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 30 Jun 2023 02:52:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HHHky2arb3YxCKJxcpDPww6fZRHDY6lrwzo3D/oWmaS0DqY1eNU2v7vNuVyxD4u3AdJ9qgurkgWfUz2+WPnmE1EwXKg0j5UPmYrG2AGPJLUfJiLl75s+o2f4//EH7ps5EaU4D8cWQxndvolJx640/dxDUGejeUlzYIJxi5RufF3MKnoNY1B5IUNQbNk8LSXvU9pLxYGNWQbcbCWpA0pZ0Tys9t9i3nZ/clMmWFAmAooJ5X8aSYt8AbIDg9Qscs8+nrdYfRLTp4YCYpdoQqddpH9hx2twV05Rc9VM93VHnZ+aVhUWZBeCOJ1VchEDNPLdrw2Phi6Vk40p7nK62Zl3/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tWuXStDzgjkST128guWuxOytq1gs9vzM2zYgXcU3764=;
 b=fDanOTQVAaJ7Z1n9GQ8biEHFxknM/htc+rIzgo1JZpih0H0Sl6aKdb88s8sDCIXgbKp66irkassBOQDiAyAFeIS4JZQ0FH8VD3k5J5Owt2NkTKo8R6kwKlWR5ZR2qnwnTVr8IlOJQxcXFgyvJ1okdP+EEhMXV3J6UkGZn+/KimxI6dmQEG72mQSfiRKwXpM6ckSPq0jG2lNbJtwKHhtu5xP0V4z6Izc9P0p2E8gcmHwj+oHTUep1TnWQWcew9Mn9m/64i+pd8ymAyFNafX5KKhYYKGqoro82aXrSBzNJyYd8yZ5f8dgCEi2zVLPgmCxUeopoY1ykp058/xUObkscpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by PH0PR11MB7711.namprd11.prod.outlook.com (2603:10b6:510:291::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 30 Jun
 2023 09:52:12 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92%6]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 09:52:12 +0000
Message-ID: <699b327d-acea-c51d-874a-85133b74a73c@intel.com>
Date:   Fri, 30 Jun 2023 11:52:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 08/10] acpi/nfit: Improve terminator line in
 acpi_nfit_ids
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <lenb@kernel.org>,
        <dave.jiang@intel.com>, <ira.weiny@intel.com>,
        <rui.zhang@intel.com>, <linux-kernel@vger.kernel.org>,
        <nvdimm@lists.linux.dev>
References: <20230616165034.3630141-1-michal.wilczynski@intel.com>
 <20230616165034.3630141-9-michal.wilczynski@intel.com>
 <CAJZ5v0hPY=nermvRKiyqGg4R+jLW13B-MUr0exEuEnw33VUj7g@mail.gmail.com>
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
In-Reply-To: <CAJZ5v0hPY=nermvRKiyqGg4R+jLW13B-MUr0exEuEnw33VUj7g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0170.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::19) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5603:EE_|PH0PR11MB7711:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f63b813-c1ad-4809-a85e-08db794fad2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FRKYAHitN5T8KGzNm1lPWfca7wNX3vXrX8wQJgi6uHFcSGjm4z4TRwZ1XZ5Iw088NRDcdrFW7GlHkOgpHl3qBgd5nF+wiJQKpcbNE/F+24zFIyCJC9ZlJXRCJ3ohzkiGvw27K0H9s8aJJ91JGdDY32s11lNE2OvGSMiNwvwrP/2qa+lA/DwK7NI3Xxy6g6n26l9WQfoWQg4lCEDcdlaQfgFWUQgU9FGmGPglVMYhxxuXyM0pzHfVN2nfoCXyQDQzr9laVfw5So3e+VFsi1P//H5wDw7UVIXejzcagXsMmwFZIZ0fzbJ9HTmsAXOMiPQG6KzkKp/gsIV4rLwDS/55s7TjhUEOmHwQM+mFUfY7Y9EDMYU4/vrem6LHVGYtvr5m+QymoLwjp/RQlwgPhgEMC3VlNu6MA8Gd6jiimrAVU7M0F7i/mYwMqcFDo0XOCh/uxb47MQZ0AyK9QSpBSMdZctA5lCdMURvcqXcXz5Nh61veuiXDOPhzv5VdUMsNFCHwTci6PebBQexXVWfyUP6cYehXYNMGS2PafWQr2L9QQGugAYtDAboWZ3Tz586Q739LLNy3LpRD6rmGMuMKhDK/nKpUeF/HpTBStHnfSOk5t7E9N70ziwWrlz4mNzo1d7OKMKyYgS5GyM7pf/eglGYyoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199021)(53546011)(26005)(36756003)(6486002)(83380400001)(478600001)(2616005)(6666004)(2906002)(6512007)(186003)(6506007)(5660300002)(6916009)(82960400001)(316002)(66476007)(38100700002)(31696002)(8676002)(8936002)(66946007)(41300700001)(4326008)(66556008)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWwrdjlxYlpNVnJvT3MrQmcvVVZtNWJ3bE91eHFqN2ZzQkV6SFVKYWdGY1cz?=
 =?utf-8?B?OW05Y1B2dTdBeGNtSXl6cm1JakZ6aGtGYUdDODZBcktJSjNkcEFNa21YQUJY?=
 =?utf-8?B?cmVxVGtPM0RPWFZydTRlWmljbE45ZmdxV0gxcmwvQW9rMjN3Z1FuUE45NG9h?=
 =?utf-8?B?UktLaU4vRDFmQThQcmFCYSswQjJJSjc1Q3pjbkNSK0RBdlF4WXprOXdTNXA1?=
 =?utf-8?B?dDFsbWprOG1TLzJvdEJQYi9uQ0NRSG1VWm1kM3k0WWpaUUt1MWdpQlE1ajNV?=
 =?utf-8?B?Vk1yaytHOU5GR3VYTVcxVzk0TitzR1V6N3R6ckQrd0Y1WS9nOUwzTWhMVWtO?=
 =?utf-8?B?NWdYRWpDaFVQZmhENWkvQjh0d0dmUTRaSUhCbTVRNlJ1bmp4amNLejVVMlRM?=
 =?utf-8?B?YVh5TW4ySStKN1NNNHVEcFdNMmlEZlJybU9WNmxiamtkZnlJNGpMOTk3TkRh?=
 =?utf-8?B?SFNPV1MzOU9yUVpFeTJJb21ZbXprcTRFS1RzbW5Ybmt3VEFCRUpyYitvWlgx?=
 =?utf-8?B?cEhMZU92STRBaW15UU9jWkFaZitHWkFCeHo0RU1FSXplOHBHOXpydWQwWkpp?=
 =?utf-8?B?US93c0Q5U1NJUW5mS1Zub3YwNXFwdEZ3bUhSZWNUN3dVdkc5OHhLeWZqQTM4?=
 =?utf-8?B?SWgrNzdwaWx0dURXSHRMZm10a0NkTkJsMnpRN09OZmNJa3NNMTEvVFY5NGxR?=
 =?utf-8?B?WnZhUW01a1Q1OWk3MDJBdVFVQnVPbXJLTGNEUUl4Z1J5dlJmbTI3Zmg2c3k1?=
 =?utf-8?B?aGVSZlRGdDdDOXJYOTd6aXBMM3lKMVVnZmJuUkpZZTI3MHV1NEMydGdCdWpE?=
 =?utf-8?B?ZllQRk9xUzZoZ2ZxUUF2YWtjRWdFcFpCRWpGWlNDdXdkWllXdCtoMlJFMnBq?=
 =?utf-8?B?azh2RXozdlB3WmJ0RnpwMEhIaTFZamNSVXZydm1MWHQyQ3JCcDdrekJnbERO?=
 =?utf-8?B?amFLSmhVTTZ4MGlQQlFMdHA2ZWt3aU10dVgwN01Eb0JnbUcrK1UvZHFaNk00?=
 =?utf-8?B?YnRuWFJNWWlSZEsvVGJqL2NDbmdpZE96Y0lKTjU4NlZJNWhSek5rM002SHlw?=
 =?utf-8?B?Wm9pK1JQM0NmYjVzUHAyQ1p6NVFPVkFOSnovUkh0WG5UUWMwNzhIZGQ4emJR?=
 =?utf-8?B?R0dHZVc1cXExVjdZcjdpRGRwZ0ozZzlIZ0VZQ1YyT0w3RkNsZmdGYjZiNUJO?=
 =?utf-8?B?KzI2L1dWeVJuV0ROYVhLdWMvMUVLMnluUjh6a284QWNNejR6RWgrdHRkZjBu?=
 =?utf-8?B?TGNQa3ZRMGFjeTYwdGlSMFlhazJyOE4xUUI2aU9adjRselpDV2FSeWtlcnBP?=
 =?utf-8?B?a052WFVRNWcxU0lqWlBqaGtGKys2NTVhR2NmVGd4Rzc4ZXBzNE1mYTNKLzRZ?=
 =?utf-8?B?Y3lnODVBQlVJSER4dlJ5ZUJsNFdPdVNoNzNJdEJSVVlPU2hVMmlGMzNpVk5I?=
 =?utf-8?B?NFJKUG9BbzI4OElPbGN1QXI2S2dhVnF4TWJxUmlvazhidjdqSjd6OVNhOTBh?=
 =?utf-8?B?Y1pKUitVMVR0YlQ0VzFrT1pXR3BwM25CSkh5ZDRNTS93ZGxLNi9qUkNqbTZj?=
 =?utf-8?B?K3d3aWgycU5UZVNKRE5Wb0M5ZFF1UmJMaEtvNEdWN3FnK3F4VEVCeC9kQ3or?=
 =?utf-8?B?NDUxUHNJWWJvUldteG5VSGs5WmgxaXREdUV3WXA4bytyVG1vSHJKTFZhR25I?=
 =?utf-8?B?Z2ZuWmZrR2ZEd055M3A4SXUrdG5BSVp6NEJWYm4xSTByV003Rmczam1oWGFJ?=
 =?utf-8?B?MUhURjJWVSszVDRWWDJGb1JBSm1ac3o0S0pKQ1JKb0d1VXRTSURUQ2g4RWRy?=
 =?utf-8?B?VzcySWNPRHpNUk9XNU5TdlQzWnFHbWdORFJGK3BNY3dYU210ckhkYytDQkFO?=
 =?utf-8?B?WXdFUUFWQlc0Nm8zU1NHOXdwN1BId0l6Ky9mOE0zNjNrRGhEUnU3M2padlZR?=
 =?utf-8?B?ckRQQUtlVW8wNU5aWEJzeTUxNDZjQkNESGw5bXl4S0VYakR2UkV1SHhLL3hq?=
 =?utf-8?B?RVlianJMTEdsaitBd0R4WDNKQitZK0VwTUQ3Sm1YWEhleFNFcDkwZmcwS0hE?=
 =?utf-8?B?K0Voei9VZGhwM29NR2ZFSFZUU3FsbU1MMGlZY3hjcTVpZU14bUswMzI2YVMr?=
 =?utf-8?B?SVQ1S2gxL3oxWFJlUU5VNDAyTVZKMXNmbGsrMitGcDdvczRpZHNqMzV4ajJR?=
 =?utf-8?B?QlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f63b813-c1ad-4809-a85e-08db794fad2e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 09:52:12.0364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GABxD61SAwWhhTJ2+XbBV11LxDMjHYCBRsIKPSb45Yqpxd9Usdxs+q2ePsIoTud0kIXvyRzKp1uH4XZpd9ZncJA7TocF+upYNXD9lRB5qIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7711
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/29/2023 6:14 PM, Rafael J. Wysocki wrote:
> On Fri, Jun 16, 2023 at 6:51 PM Michal Wilczynski
> <michal.wilczynski@intel.com> wrote:
>> Currently terminator line contains redunant characters.
> Well, they are terminating the list properly AFAICS, so they aren't
> redundant and the size of it before and after the change is actually
> the same, isn't it?

This syntax is correct of course, but we have an internal guidelines specifically
saying that terminator line should NOT contain a comma at the end. Justification:

"Terminator line is established for the data structure arrays which may have unknown,
to the caller, sizes. The purpose of it is to stop iteration over an array and avoid
out-of-boundary access. Nevertheless, we may apply a bit more stricter rule to avoid
potential, but unlike, event of adding the entry after terminator, already at compile time.
This will be achieved by not putting comma at the end of terminator line"

>
>> Remove them and also remove a comma at the end.
> I suppose that this change is made for consistency with the other ACPI
> code, so this would be the motivation to give in the changelog.
>
> In any case, it doesn't seem to be related to the rest of the series.
>
>> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
>> ---
>>  drivers/acpi/nfit/core.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
>> index aff79cbc2190..95930e9d776c 100644
>> --- a/drivers/acpi/nfit/core.c
>> +++ b/drivers/acpi/nfit/core.c
>> @@ -3455,7 +3455,7 @@ EXPORT_SYMBOL_GPL(__acpi_nfit_notify);
>>
>>  static const struct acpi_device_id acpi_nfit_ids[] = {
>>         { "ACPI0012", 0 },
>> -       { "", 0 },
>> +       {}
>>  };
>>  MODULE_DEVICE_TABLE(acpi, acpi_nfit_ids);
>>
>> --
>> 2.41.0
>>

