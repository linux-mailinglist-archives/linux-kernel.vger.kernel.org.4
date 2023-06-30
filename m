Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5277074390D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 12:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbjF3KLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 06:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjF3KLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 06:11:00 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4A11FC1;
        Fri, 30 Jun 2023 03:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688119859; x=1719655859;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eupqN0zNYSFRa2FE6UQo6i2UxssIWUWnZkr+9BK9aYQ=;
  b=NkNY69RakbF0fwTV6ZqZnjiOPud6Nrh2i/Ud2PVcXQkgvKshQq1hUqov
   96Stwz9J45beT556zQCM7KLfc0+fqmgdtkT/+K/rdItbxcgqMuxrcPgti
   pHT7b8Ed8j+lCIwZWP3oN/c3EbMrsHiF3zuW02h/eVVtbSjdCIFgqeA2O
   Jkn+9S3mZdRdaaugOiRKAidAkbvZQoVmMtc21JOiS/PKgF4HdkLUqoHgs
   pgfOdi1wkPO23YYiEmJKUBtD1BEc7peFIcMmXvjWB2GsFZc12t0uuw+NH
   un8P2o2JvxiTeVOmmarfW04PflKJQ9JaKP83DcnQfA3MVZGpiav1EhV0i
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="342701243"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="342701243"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 03:10:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="891708995"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="891708995"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 30 Jun 2023 03:10:57 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 30 Jun 2023 03:10:57 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 30 Jun 2023 03:10:56 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 30 Jun 2023 03:10:56 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 30 Jun 2023 03:10:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bT71ay1YJkdEGQSZDgPCR2CqiT4BkEPBRtqkbJRKXeS+RJbaKnYFgpo8V9FXkK/j2E7ZKHLjQM8owU6ntzTEjELZPVUgOW33iMCSOYUWVmnUFDK3Z/YSVP/RSZE2ciKSbZkCCOMKdocYakNVxr1iskuu3sKmmB3rmAME49wg3TNip0qWfhvPDkEnJzWl+5soxnZxiktzCxr8Y7poPHtncnEkQ6ULtG4w4zUOaWEmK4lMJk7k9kn6ZdHWa0F+0IRQI0u5c3kK2mqH4qkYxhn67hwOJDiD6gI5LD4J20P6SMVDIb9szTC8UBDFdu6kevptwq/MyBeNXbhcuTg9nT09GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oO3NYU1rtEHhXygi4taV64NdDkXLKRWrkM1gnkeCJzk=;
 b=QzC9lhj5F9ilmJGRSUT0Z8hLZYGgA3baZwOG/2J7mXQiBt9fZ9XRQ9mTpCi3iTdj3EfrNrCyaH0pBLRQ64YhyVXExHdwftmFVSz0HyfJud63hkkti7+8IM2H6vFQCT/PUpXsrL3V2p/juddc5HQHtiEyiLRtOe0UHP6jH/crvbo8RoxykNRyqgyI5Ol2zaEK/0MT23xY08tMVLYsKFgvhBQ5zE0nfqJJaKHCNXssG5OoG668Y1VY+YSxD9tKnGa/8SCYq1LvQWYbNiQDiTy7bVnRdZnLj08g58a6ASJ2J3ZWcGbRgiZYk7bpu1BAGvxMQmjZUOkEMWQ0790ndosIgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by DS0PR11MB7579.namprd11.prod.outlook.com (2603:10b6:8:14d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.15; Fri, 30 Jun
 2023 10:10:54 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92%6]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 10:10:54 +0000
Message-ID: <175a9095-bd8a-4384-c573-cfe8267a8417@intel.com>
Date:   Fri, 30 Jun 2023 12:10:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 08/10] acpi/nfit: Improve terminator line in
 acpi_nfit_ids
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>,
        <linux-acpi@vger.kernel.org>
CC:     <rafael@kernel.org>, <vishal.l.verma@intel.com>, <lenb@kernel.org>,
        <dave.jiang@intel.com>, <ira.weiny@intel.com>,
        <rui.zhang@intel.com>, <linux-kernel@vger.kernel.org>,
        <nvdimm@lists.linux.dev>
References: <20230616165034.3630141-1-michal.wilczynski@intel.com>
 <20230616165034.3630141-9-michal.wilczynski@intel.com>
 <649deeb7c0e94_11e6852949@dwillia2-xfh.jf.intel.com.notmuch>
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
In-Reply-To: <649deeb7c0e94_11e6852949@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0327.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:87::6) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5603:EE_|DS0PR11MB7579:EE_
X-MS-Office365-Filtering-Correlation-Id: d8653ef0-9a2f-4dc8-182a-08db795249f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y/lG25jacltsDEAoMJW3oslBn2xwxvnxjzM9hiXW0ciQlRSQMuW579MYeF0E9wSE/Mm6x38DoUhNTHeHN4G/08J4KaRUDi0v/6p9oSXAwJidFVPKJirWa/4ntBq4wJEVkQyocCeZW/J/+bo3bQsBfCGxNdY6wZtoBBkmGA0HjkJO3BCPn7dbX36iDfh5BGak/FPgRdtSgo82Mx97CSZSBMeAZIRM+7aHzsYRLUHBXRGlDt1mOFzwyxiuezd582+GEEav3WpsruedmzKrGG0kc3w5ne7964wq48NQO7kGSq81RBoCCbZ7Xoz51/PSsyt0BLTLbhNkyYtjzHMUY2tuv/R0aT4AstjLcbcvrjnVZWPadXYnT1TqlER/1B/rswetc7QsIyDPuJHF7ZhSIqYWnG3LkzAErYnq4uG1gvOKySahqvMTCsGVF5t+6IieQ07KOSxiSu6HgOQnMrMa42xsoGAYDMscYvX8eEBx8H7xzxxNa4AF985LJJRuIWYnCI2wNX0WQE0YwghBM01LStGbvrDY2mjvje8e0tMp4SJ3EKvhnOSMcxNGZxIMc6LHYioBwmeiWG2xDWpEhtmsUdMhitOD99rjqa8FFI2DGJg0ixL6ZyLkXIbfgNCVChSI2W76iL5f/ZieCIArFCYDfPrxsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199021)(82960400001)(38100700002)(86362001)(36756003)(31696002)(31686004)(4326008)(6486002)(8676002)(41300700001)(6506007)(5660300002)(478600001)(6512007)(53546011)(8936002)(26005)(2616005)(186003)(83380400001)(2906002)(66946007)(66476007)(66556008)(6666004)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFI3R08xWTI3UGpldENTNDBoNUZ6SXJDazExZ0IrNitqdGxabDJEam5SbTJ2?=
 =?utf-8?B?d1VEZXlXNXY3NE9QUUFyL3NMa09kYUJSdlhGWk1vcUJPNEM5R0NjeW1ocnp3?=
 =?utf-8?B?MkszTTFDaFhkcUNzRHg2K0loYTg2cEMwdzRjcTNNVkViblA0U1hndTEreVMv?=
 =?utf-8?B?WmRMQjgrNlFaUWlidkczNSsyaTUzVWF4YUJKNTNDb0FkYWxtSUNTaXQzT1hB?=
 =?utf-8?B?WUJ1SWJUWStqV1ZVcW40cjFQem92OVhkMXl4QTBxL3AwY2FHZEd1Q2V4QXV4?=
 =?utf-8?B?ajhvQTJsWEFHUkVtc0ZoWU5JTzlRSnMrQTdCTkxWOWF5MXVHN1c5b2dJRGJn?=
 =?utf-8?B?eFVZY1lScXpMekt3TG1oWjBkdEdCb2VFMlZ2azhGODFISmFyWGh2cGVNZFQ3?=
 =?utf-8?B?NWJTVHF4clFYU1BoMkhRZTdzdEtqNDJqSElVVXIwZ3pXeHAxWmJ1eTNpZVp6?=
 =?utf-8?B?ZS94Q0IvSkU2TnRiNkVQTEhGZmt4L3haWFl0QVQvenJjYmt4R2R3ZmM0VFdK?=
 =?utf-8?B?ZHVieFJKNms2MEtqMU5TSUZzMXBaeVF3ZHE1Z3FRYUw5RHFxZkRhS1RRWStx?=
 =?utf-8?B?d0JUL2F5YlpxUzBzdDYzSmJ5eWVGU2JEaTNzVDRNUHYzT1QzeFRPMDRNeEkr?=
 =?utf-8?B?eWlPR2p4UVlNVElnK2FOSXlEeU4yMXVkRklFTjBPRVNLMGhTdjFaVHpiUzl0?=
 =?utf-8?B?VUR1S0Nib2dQYTFhUDdFalgwWU5RQW1lem5tOXQwVnN6bk5BODEyYTlGVTVC?=
 =?utf-8?B?ZnBLZTBHUHMzZVEyYU9BcC9GelhBVjA1NGtleDlQZFk1K0JUa0VObEhJdU0r?=
 =?utf-8?B?VlZySlkyOUJWVGpDSTZvL2tGeUgwSGxtQzZuSmdQWWpuQjkxclRGTmhHOVZ4?=
 =?utf-8?B?dlZ0eUY5UTQ1bGxGUEluS1FjbVNMTjU1c0xja0lkbk90ZmVTVUJXSjh2c3pE?=
 =?utf-8?B?NW1qakhDU2pLM3JoMTgxWEczUlFnY2diNjQyNmwwV2xKczFIODY4dXZYakZX?=
 =?utf-8?B?R1B1aTVYai9lV3lRK0pRS000WURyeG4yRW5mMk9xWWE2bHFrTks0M0llWmhC?=
 =?utf-8?B?MlVzOGdoNUxJOHByZHR6RUw0OE1FZktaRjRmc0tHaFlyN1ptNW9HT2pzd2x2?=
 =?utf-8?B?RXdhVDVEUGJRbGpHNDVTTnJ2ZVA5ZXJPeG5NZ0ZUTFlYZ2JZVFdvMkxZZDdV?=
 =?utf-8?B?cjRnVE9yZG9PNm50em1CYVR1RmIyS0tqN09kSm5YOHNleTM3WVpXWnZsWDc4?=
 =?utf-8?B?S0N2TWVlYXV4M1FXUWZ0eGVnUE1uZlh6aWcyRnFtZmp2VytqMUhYVmRPTnhH?=
 =?utf-8?B?Tlk2cnRqUlcrTjU4MTNrdjFiemFSSlJKSkhjbTlONzJzVHJPSi9zWDJQQlhH?=
 =?utf-8?B?d0xiclBXNmFEbmJzbVZSQ3lwRWZhUXFUSE15bGd3MzhiMklXa29UcTdWTFRS?=
 =?utf-8?B?VDI4NEVpNXpiNStEVDhJazZ6bC9CZENnMmRXYlZlVENYdlRkQm9ueDZ4d1Jz?=
 =?utf-8?B?K1pseXhEVGk4NGtCK05CSUFaNnIzR3paaDFwTy9OZmpHazNtYWRUZVVuay9Z?=
 =?utf-8?B?N1Nmak5ORFlsUjZXVVIvUnkyS05DalJ5VUlndnV3REpTd01lK2ZZNFNyekx0?=
 =?utf-8?B?M3NWQko1MWpuVFN0WWdsb2hWQjc0bUdRT0c0dm5GdHUyelpzek9qK3ZPMDFk?=
 =?utf-8?B?aWc4cnFQNFl4VXVUZDVUYStJbEw1T2QvOWxXcjkrR2xaU2ljTE1FQ1NudWV6?=
 =?utf-8?B?Zk9ZaU5JcmZoWE1wMVhxNEZzc3N4RlllekpFOHh2cFZlaDE4QzA0WDQ5Mnc1?=
 =?utf-8?B?NHZRY1BadGhEazZPVnhSWmtpSEZoZVdWbnFIbmxpd3Zja3RDZU5tM2dXdmYr?=
 =?utf-8?B?RU80NkQvbVFncmhJMkY0QUlRUEZLSk1mSmFRMkN4YWlJWldqNEJqdFEvS0tN?=
 =?utf-8?B?RkVwWEl5SktIZlFCZU1uVllIYmF0bldsWENzVUhScWd4Q01xeWNXSVFKWlNY?=
 =?utf-8?B?RkxlMGljUG85N2p4WDNWVjV6RlpNNVJnbXBKbjRRTUJqK0plaTFqZlM5MzlP?=
 =?utf-8?B?MnhhY2NGanltQkJkOGIxTXRKczhhbEtweTUzRmpZOUVjTGFQd2p5djBHOENv?=
 =?utf-8?B?TFdoUGhIQzlKVDJUL2JEV0lrd2Vyb0s4bUtyakpOSk82S21xTzNxZlR5MUZH?=
 =?utf-8?B?OUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d8653ef0-9a2f-4dc8-182a-08db795249f2
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 10:10:54.0256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QPLOSBt5PdTHjndkr2zZ/RpNzgiossFCFeRwlPCLNruHqVlAwMLAxgxuQ1J3ZwR55rfRRWC1RGwSCSEy+EZwkKxcbw1E8uWLzb6fmZln3mY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7579
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



On 6/29/2023 10:51 PM, Dan Williams wrote:
> Michal Wilczynski wrote:
>> Currently terminator line contains redunant characters. Remove them and
>> also remove a comma at the end.
>>
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
>>  	{ "ACPI0012", 0 },
>> -	{ "", 0 },
>> +	{}
> Looks like a pointless change to me.

It's not very consequential, but isn't totally pointless in my view:

"Terminator line is established for the data structure arrays which may have unknown,
to the caller, sizes. The purpose of it is to stop iteration over an array and avoid
out-of-boundary access. Nevertheless, we may apply a bit more stricter rule to avoid
potential, but unlike, event of adding the entry after terminator, already at compile time.
This will be achieved by not putting comma at the end of terminator line"



Anyway I can drop this change, it's just confusing everyone


