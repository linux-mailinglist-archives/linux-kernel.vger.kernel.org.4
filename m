Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F5072E6FE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 17:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242553AbjFMPVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 11:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbjFMPVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 11:21:31 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B7C10DA;
        Tue, 13 Jun 2023 08:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686669690; x=1718205690;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gnbaQ7r0diDa9B6Q8GFO9u9lH/nRETZ2YVcc1VAEafA=;
  b=ipyNseazyrZe5EWERQ0q4zmgBYkoDPE579ZGzrYXSAjO4J6N45oqwHjt
   GNR47afdRr1CM/fiUCzrIpKySKZcdljOsYkqsP6GkxxVefve3zdUGPdse
   lVVCOi+SP0JOYRKET/R850fYaYSBUz5vsYaHsXuTWHteZnN7obUS5XjCJ
   G0DR6ZRZIdLh8s6oV2V77dZTJM8d2F9iBq4wXEDcUvOofE1OX5wFl9w7J
   CVN4Sd1gDXWw0LFcPix204b7hObuortI+E16p+iinAzgTFpiVrso0uhQx
   gATdbw0MMAP7JYpdQ1ppKB+Ltf3ORGNuE+CuzE349lpCWdLHezSgc2T1W
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="355862846"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="355862846"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 08:21:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="714848753"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="714848753"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP; 13 Jun 2023 08:21:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 08:21:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 08:21:27 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 13 Jun 2023 08:21:27 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 13 Jun 2023 08:21:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JuETBwNbdY9dd4CXf/8h5pdSFg1b72n4bP5/ajEVEsI+Gx41L6N6GGocfiRw6HUO1q9NHoRM3lozmaZGRUePAqhTyEgSiplD2GuCt0LytRTG33xWax0GbE0BZFlb/GWxm8xGCT8FDuZeX2o7Brh1vkpiGt6dqR6V1rdrhQDHS+lC02AnpnyPs/TsH6NYvmB4fMcwq3RhEbv5DQez5xaI4FP3669Fl/uDeVvMLVXw44U7FuT6cYN9G/Us9+jG01FHw3z+2eHuFbfUREBKEr6b9gpQYGm1aNO739NAvE12FRYvaRcBDgq7QtY8gzh4FdhvKrmaq3LFq3p6MFLn5Q5sqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gnbaQ7r0diDa9B6Q8GFO9u9lH/nRETZ2YVcc1VAEafA=;
 b=Qg2BGueAPNCi95dtmsRHISubBX86V/WDk6IzC6NDvgzCtTZu3UEfZ/XZyqh4VltaVLPVtaQ3N657CUfekubbT7kPek1OH+3O+L78zVNuK7pLWGDuF4JeMTQjW1oRKTDymlSTWhDHb1bZEP5Sij0YHwagPB077nnaqCujuAW1rJHFP9Y/kyrFbxO4o7kCm9NarB3k/4G5UWboQAi3k8ADdOkNWDjs7YlE0yPgfgzobCCXcAUEc5td2FPia0GwPBiSQtNO2TKL8JaIWH4MFqFQCaoJgwU21cykpwayjnN2YUZotlOBkBDe5iNIJq31R9GNgFuAl37rZo7N3m4sHpMPiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by PH8PR11MB6777.namprd11.prod.outlook.com (2603:10b6:510:1c8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28; Tue, 13 Jun
 2023 15:21:18 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92%6]) with mapi id 15.20.6455.039; Tue, 13 Jun 2023
 15:21:18 +0000
Message-ID: <8d8c54ed-600e-b71a-b008-bae4f8180916@intel.com>
Date:   Tue, 13 Jun 2023 17:21:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2] platform/x86/dell/dell-rbtn: Fix resources leaking on
 error path
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
CC:     <linux-acpi@vger.kernel.org>, <rafael@kernel.org>,
        <ilpo.jarvinen@linux.intel.com>, <pali@kernel.org>,
        <hdegoede@redhat.com>, <markgross@kernel.org>,
        <fengguang.wu@intel.com>, <dvhart@linux.intel.com>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230613084310.2775896-1-michal.wilczynski@intel.com>
 <ZIiHaEn7nW7yAFK8@smile.fi.intel.com>
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
In-Reply-To: <ZIiHaEn7nW7yAFK8@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::10) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5603:EE_|PH8PR11MB6777:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b20e759-4c12-42d1-6f40-08db6c21d5e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BP1qRXZd0jwn4oB55kWygHnyU9mAUjR1fk2sQGtZfCj+QtKV2qlCJHmESs+sx0vN6QUcCzZlUGgxa0FPj1M5Vx2ExamY9ZuJhQSy4Azx3a0sVQivsMfKjWQ0PWUSY4ExjDTx/BQNSASDAPveun+ZxWNDDZB6pfvqlJPqdl5vQeSHDJusPFpCOw/UBXBrKnQ4iFxV6CPV/pBpIRGsYsvkYn3ud60jGxBf4JCMZv2m5WxKEPpY2CyntJExS/9KXrZ8U9SsByiEr5qES761fvC8XALyVhIYn7kkzBzj9Cyv6nEJEdozOJSHpjczU+Q0elH7KRRVV2Se/+nBL1XqLWWDOV6cmqfSsj126pdv7xd9hozk++C41gKI/b954Tae2COLWx4VhdDxt2vGXkeUah2PTXLS0W9pg1raT3/3QSVoQ7txK0I1d1gi52/o7BnYpH+QqkBdAbrB7zictETdAyrMFrebuuY6kw/b5/R2YKSk/6Y6b59qPVpSKEyfbXDOp7PHcj4GUh7jCs7O4KCzU/xy07ie6lBS5oHbPPAFZuXKPicBaRc9htbnGtfidUO+Fj7a/CQUPVe6oWSH7dIPP3olqMPhABW+I33cqcDSd8zjtr9sFb75OdPQZDlzhManS2CUdhokKaW+TodTFp8AvElxZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(366004)(346002)(136003)(39860400002)(451199021)(26005)(31686004)(38100700002)(2616005)(53546011)(6506007)(6512007)(41300700001)(83380400001)(66574015)(6486002)(6666004)(186003)(6636002)(478600001)(37006003)(66476007)(66946007)(66556008)(316002)(82960400001)(4326008)(5660300002)(8676002)(86362001)(6862004)(8936002)(4744005)(2906002)(36756003)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3VpM3NTQWZFTktiZFlId1NUOWgvZlkvUnBSUVNCbTd4NW95cnJQaDIrOGwx?=
 =?utf-8?B?QUx4aXduT2cwSWl6U2dCdkJoeVhTS2RkanE4TDhlODlzQjFqRzhsL0pMWVV0?=
 =?utf-8?B?bWhzQVE2b2JVM09NV2g4anJYL2R5bG9EcjBxZHlQZ0pVNXBJcWVkcENSYVgy?=
 =?utf-8?B?eEUydHNQelFSdVREb25rOVRuZWNVQWFkaDhVQmRnWHhvWEs4OGZodHMyVEVk?=
 =?utf-8?B?Nm5RTGZpd3hpUk5nb2I3ZVRNdDBiVVN6U3dwQWdhaThWeWFpNEtzc3BiVDNB?=
 =?utf-8?B?MVlNTm1mWFVUMHdVYkJPQzNnWnozU1k2bFlVNlI2bnQyTlJDa2tUNkZnWVNI?=
 =?utf-8?B?ZHliZ2JOa28rZVl1VkhuTkZGVjRwdG9Pb0Y3NlVhMUZvL1lKT3dZRk92Mmtz?=
 =?utf-8?B?ZG9ESHhaVkg2WWczbVBzMm9xcmFpZjVhV2J4bDNVRjdlaGNLNlRES1kxRVp3?=
 =?utf-8?B?Ny9KUGF5QnI1ZDAxVUpTcTNzK053QXhMTERCcUtuVTlaZnpwNWJCVHpUZVQ3?=
 =?utf-8?B?MndXN21XcFBBR1J3UHJyNklzeGM4S3EzRXFxVTVkcmVidnk3UVhyT3VKWHZ3?=
 =?utf-8?B?WGE2UWtQYVpMbWRGdXBSU21uWTB1M0JncTB1bnhINUp6bzBYNXlNbG8wcXU1?=
 =?utf-8?B?WlN3NDd0VXZtalZUM1BQSHNVTHZsYjZqbU5STFhlelNRMFovTlFWNDVYVEJR?=
 =?utf-8?B?bE5ONDdzWHlyZll3dXVQUDVJdGxiOHdGbU5LYTlMNVRtOHRKdVRRMy9IWER2?=
 =?utf-8?B?Rk1TYnphUmI0TWRJV1Q2ZTUxbkVZaTJtS3VZeDRRbUZuK0VrSGFCdzZPRzVL?=
 =?utf-8?B?NStQQ1QwZGluN3NiSno3ZnZNVmhFRVFiQ0VuSk5LM21FNGI4ZWdtTnJkM0o4?=
 =?utf-8?B?WWZDSlUxUEJicGdBNEoySGUxcExlTEV2Z3lZeTl0WTFvZ0h2M1NHbVlFeGpj?=
 =?utf-8?B?NmkzRzFONE1pTStYeUpLYWg3M05HTHFWcy9SU3k3MDJQQTg0RCszdEFqQ2Jo?=
 =?utf-8?B?TElCYUJOTXZYS3E3Z21KcGNPYUJLeWNlMERxQ01uU01QeWZhdVpFb05Wb0h5?=
 =?utf-8?B?eTV3VXdZWXpMZWlEcXAramRZSENKcjY0ZDdnWTE0TEhmL2xCeUJJVkVHeStI?=
 =?utf-8?B?dzluUkFrdTh1TEx6TXpnZW81L09nT0J1OFdYa01DalNLbElYNnNPU0pNcW1B?=
 =?utf-8?B?Q1puK21VM1FpWCt1M3cyaTI4Q2ZhODltL1A0MVQ3cDlaR054NVpycmRXblRS?=
 =?utf-8?B?a3pBM1RZV3pRK1ZSdWRrb2tyRjU4cjBBTmFwNmVrVVQvYlE2L20wNE5XVTNh?=
 =?utf-8?B?aGYrRG4rRmtZSVhPTEluL0hGUkhUWU9wQzVKOWNQQm1zcDB3UURtTnBZRTAz?=
 =?utf-8?B?OTVLTmJpVytqODYySFh4Z2xpUVhlbDhBM2tLRXNQY3AzejI1TWxkbWtFZ0V5?=
 =?utf-8?B?cTRqaTluUCtkRkxBbktMSEhTQTk2MW4zUWgvQm4xT3h1Wi81MnBFcld0L2JR?=
 =?utf-8?B?S1pNbkdpMTBNNWxWTmNkY0JTYXdLaC9tUEViblRCZUhwYVNVUEFTVW1vY1F0?=
 =?utf-8?B?cnh0NWFuM2JUSVF4MmVtaGVuOWhsWkt5RlRKVHBrUTJYUDkxR0pJTjFSRjlp?=
 =?utf-8?B?ZjFIcURZcXpnTmtmNSs1OWhDdmw4d0MvdHI1VkRxZVExNUF0RmlieE9UN0gv?=
 =?utf-8?B?U0tKODlMQ1dnSmh6VUxFTWZGQTJLeDU5c0JxdlkwM1JRUVp0N0h2VW5Lb05s?=
 =?utf-8?B?OUVuNW5Td0xmeXlhNC82eVF2V2NFWTc3OXZYZ2xoSzQ1ang1MmtrQlVRSHhZ?=
 =?utf-8?B?L2MxZ01oWURvTE9VSFNmYTVVNzFqWksyVHRRWXBFc2xTQURmcU4vSjlJamNW?=
 =?utf-8?B?aXdJbGtPOW1NUURkd094ZTNJUGRJQmZLNWJwK21HTmRoenVCZkpPODF0NzA5?=
 =?utf-8?B?clVDQ2JBQ0FSM1lhZXBXVmdvOHBQeEtyTkp5TU1RbFN4NEprZGJDa0ZabEtH?=
 =?utf-8?B?UDkvWG4wd21UdW9PdHlwcitqQXA3aldyaGY4ckNYVm1OMk5JMHdpOVhqQU9T?=
 =?utf-8?B?WHhPWmNyUzBQaDBSYmNnMDdvSndZUnpucDZ4MzVwVkd3eFFCejBUSEJvbWhL?=
 =?utf-8?B?KzY4WS84R0IzS2Q4SmZ2aW82amNMcWpDb3k3TDltb1ZmQjk3bk5TZThhMnBO?=
 =?utf-8?B?SHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b20e759-4c12-42d1-6f40-08db6c21d5e7
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 15:21:18.3849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nN3AuoHs/atbM73ocnq2M7h1SSI+/CibpfA5rzsztopr6V7zr7o6BCgPnTgl3+pBdDYvdwBgYF4nYlpTmohZ+kemtGUIc+pu7DfQJjy/ZhU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6777
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



On 6/13/2023 5:12 PM, Andy Shevchenko wrote:
> On Tue, Jun 13, 2023 at 11:43:10AM +0300, Michal Wilczynski wrote:
>> Currently rbtn_add() in case of failure is leaking resources. Fix this
>> by adding a proper rollback. Move devm_kzalloc() before rbtn_acquire(),
>> so it doesn't require rollback in case of failure. While at it, remove
>> unnecessary assignment of NULL to device->driver_data and unnecessary
>> whitespace, plus add a break for the default case in a switch.
>> Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Isn't also suggested by Pali?

Oh yeah, should have added a tag for Pali as well

>
>> Fixes: 817a5cdb40c8 ("dell-rbtn: Dell Airplane Mode Switch driver")
>> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> ...
>
> Hans, can it (an additional tag) be folded into applied change?
>

