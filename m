Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F07F7438BD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 11:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbjF3Jz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 05:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjF3Jz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 05:55:26 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58F5E63;
        Fri, 30 Jun 2023 02:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688118924; x=1719654924;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mGOBHE/3NC97jmNMFOCzCJqu/w5zDpZnNsfaFYHvIak=;
  b=FPxrm+ARR0qKiqttkOOJnoHMv9XraPCFwFxPNOWbiq1ZbYBJZNQTksMi
   wpWHmaKPOYwWa41InUOEt9NBpy/707fkVtzJwSWawv0/4mzSWcYnekmLw
   ekbBrHO+L2l/QzG+1lfxyCVs8CITV4KMGbluzp0E2G1Z3i1EGmva4RXqu
   bfSs2Upo3lC4AOLFftojJm1Y32En3+Grr2/3eFU+I4V+roAlRB2GHyKuv
   MJQaVlfeFnfKpMUrKnj6QoeEpDlwkHa0RY1qOeRvSwVSkFwDBp+oYArvi
   qCI/0zVykvlBQtsal9SW+lVhRtO+xc3CG5sf32YJ/fW7stkZR0D3zQT3Z
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="342698503"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="342698503"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 02:55:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="841804869"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="841804869"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 30 Jun 2023 02:55:13 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 30 Jun 2023 02:55:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 30 Jun 2023 02:55:13 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 30 Jun 2023 02:55:13 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 30 Jun 2023 02:55:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkZqE4/vJ1Dbr3OvF9muR0UFbycNd2xRzbeE+0ZQ6W90AlYL1vEN+u5xHNFn+4pgGJov176oY3lRy3dSSfthrxKyn4tXHZiqgFQI7UUURYhSUsD5vCsWUNAq/W8dXlj4l40fKV5h0uPzAndCkejphkSNZdMRpa5XHpFVwm+6X1Xgoe9QdmYB74hr7nnISMXot/BgwKODj6WOrrwGCCTvmflGMMQE7wtKzKs0Hs9uYD5XscovXOz8v2rc2KNGHTKVevzzJ3A2AYV43WiHenUzgsR00QerUTdOJDNcLaClFLmcAp0SgC9Avz1kBVwFlq65+YtO7netIGe0fYhYv3znYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rgtMyvjFKruqqqgTrLYDtA/JOelV2w9E7ZapX56JFwQ=;
 b=UOktKmQgYe3WJOB3lUsPS5Rr1XvfjiNMmgvnaKG6wOs/zzfqJr3lXo9BOYiwxsNAT6X6w3E6AzCATLtgfElmgLEXQoJ2nzqtIxFOkhULJ2LG6WraACxEREd5gbznce0RZSycSUwegsM7p6y5if4oxWGfht8W/tMv9nz467NHfQ0GY6f5Jdl4YXT86AvAuJDHPEPWM7mgFplGFZ7oMO0hGX5a+l7FU8lAUuD+z0x5d54UUTGkJksM3VP4xZo8pS/z0jTznReOleLxUaQ5s9JVFcCSWRAEaOPjXxeZnWLmn/z35oWHvvI5c0iMf8pq4pud2pcx97VINkugw0mM2uWLnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by PH0PR11MB7711.namprd11.prod.outlook.com (2603:10b6:510:291::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 30 Jun
 2023 09:55:09 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92%6]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 09:55:09 +0000
Message-ID: <d4ebf8ba-6f95-d20c-d7fb-e97b6535f71f@intel.com>
Date:   Fri, 30 Jun 2023 11:55:01 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 09/10] acpi/nfit: Move handler installing logic to
 driver
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <lenb@kernel.org>,
        <dave.jiang@intel.com>, <ira.weiny@intel.com>,
        <rui.zhang@intel.com>, <linux-kernel@vger.kernel.org>,
        <nvdimm@lists.linux.dev>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20230616165034.3630141-1-michal.wilczynski@intel.com>
 <20230616165034.3630141-10-michal.wilczynski@intel.com>
 <CAJZ5v0gcokw72q5uX-3pbBEZtJdCaWHN1vat8yPNQ3SXMgeD4g@mail.gmail.com>
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
In-Reply-To: <CAJZ5v0gcokw72q5uX-3pbBEZtJdCaWHN1vat8yPNQ3SXMgeD4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0107.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::17) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5603:EE_|PH0PR11MB7711:EE_
X-MS-Office365-Filtering-Correlation-Id: 29f2a3bf-ac1a-43bd-57b8-08db795016c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nZeMMY6UT83l8fO2U9CmzSekfBXMXhGk9dNWaKx0QXTbWcS0tBn/17NMkfDjXQfWOBy+qlO6jFAR/a6q7yuxDiooOu/OCNQEilOU31MBJ0OcEYn5OsVvcbh2UbcPCJJvxfrl7HVrCEDDWyQ8P5SGsjKYUdDvzouOBu6zi1Yrb2y/DkMJ/5CwHvbkUW07CM9N/hibNlIt2OLqEYT6VpnzHnWXPuLIQhE6CBgasu7l2blpOA9WvtD2iHitdMDiNrCcjgCKSlkmJHgJiPb2IiQffJJf1jily7XJeeizuuzs8f6gW/UJs9bu0Pa/5Q3vIDUOK2hPEpQQxPQKb6+95g5lDWmZA1S4R+vnfn1rKGhWecB0YPRLkpzUJOBkgEiQ84ySytCILKXuI9P4tJoN8krfiA2uAHF1B0mxN/YylNFVNuXe8J/2dJqK5ZkBnMDufW8xG2LfPqAQ8NoQremWGaJYXnXqol9welsfsmah7chf7bboq/h62KutIXMM5KIqiDxVQvwrEeN0dFkbSAYfsRmOzk8UVX78bjK4Rk1QPZJ3xrUT1JnUWKzSyHPE9M1mSrzjxpPp1V69aZNWmUWTEufZoocMHW7Q35N+g5SHzWn9zFkjnOCtqkPImtWZ6aN+Uqd1znH4wGaXmfqWeTN1v1Nmow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(376002)(136003)(346002)(39860400002)(451199021)(31686004)(66899021)(26005)(53546011)(36756003)(6916009)(82960400001)(316002)(5660300002)(66476007)(41300700001)(66946007)(86362001)(4326008)(66556008)(31696002)(38100700002)(8936002)(8676002)(6486002)(107886003)(6506007)(6512007)(186003)(478600001)(83380400001)(6666004)(2906002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFIvMWtQZ3hJTlc3bnRiWE1QOS92UU5ESnBMZmFQOHMxRXE0ZFQxZzJBbTAz?=
 =?utf-8?B?ZFZ0b1pJeW5lYlI0VXNuMXF2ckpRM1dxTXFzaFJSdndHNGdja1o1aGt1ZEJF?=
 =?utf-8?B?Q3BXdWhoQkJWTjQxVDEvdzRFNGlQSTdOL0lxYkFWZG5pZ1BjOWJSbkNrV21E?=
 =?utf-8?B?RGcvVWlHN0UyV2JhRThxUUZGQ1JVMHd4TWM3ZGJSeDBmM3p5dWd5bXdTZzZV?=
 =?utf-8?B?NDJReHhLVGVQcFUzbVN2S1kzazZUTmh6SEtPUHFiSlErUEc1T1p0NVQ3VVlr?=
 =?utf-8?B?WEdKWWNUdXpZSldNQUdPekRZbGQ3dENDQzBGVU9JUklrZFFFTXUvL3dJbkVP?=
 =?utf-8?B?Tk9MbUFnZjJFbWE0ekNEckw3V21GMjFLbTNZVGs0N0llL3JDRHFOTDJpVWZO?=
 =?utf-8?B?SEZIMmZtNnBGcjJGcHNCTC90emJaNG1PclBSL3U0OFBPTExRK3YyeFlNNkRw?=
 =?utf-8?B?NGZXa2lFSmpub0VNN3R0VTl1VjhKN3gzeFZ3NjhrNVNFK3ZRTTAyYVkxNFl2?=
 =?utf-8?B?c2xVVjhrVGlIcGUrdDBYSnY1R1RIc2xQamxDMFpBK01RTVdpMVdmbnU4L0Vq?=
 =?utf-8?B?RkY0UW5HUHlSeHl0Wk05bDFYUGdpeE5PYUdYT2hyRnlyYjQ3dkZ5blN1M2dQ?=
 =?utf-8?B?V3hzeUI1em1OYmdKNTgyVXNaV2NhVXN4QkpTYllkZHBaelZvQ2ZIenIxT1Z0?=
 =?utf-8?B?K2I5ZVFhTi8rZmkzVUxsNTc0bThCakRWcFZjUFI4NUl3UjFucDE0dmV4TjlE?=
 =?utf-8?B?Tks4Z3JRRStTdTgxblhDNEMrQlFxbm9aVE9IencxbVVKNC9qMS9oUW9OKzZR?=
 =?utf-8?B?MmdMT0xxYnJzU0lvemx0Z2RFcnhacTUvbyswRDNXZFpyVWJZZnpleitsdDlh?=
 =?utf-8?B?Q3FZUi9qOHRBaHRNRkhmYy9WWVVQQ296U1phY3R2VWZ1QVFPWldUTjJOU0pK?=
 =?utf-8?B?eXNTVGdBYVZBdkZnWThENm5heUJtR29UVlBMemhNTmpRRTN1emdCWk53S0hC?=
 =?utf-8?B?a2V3ajd6RGJYeVZKV2hYdU5xaDJ2SGs4d2RDcXV2anVDZGhoNW11bnRKVTRm?=
 =?utf-8?B?aTFteU5VZmNROVVncy8xQW9TdGhNY1hIOFJyUTczSDlJS0piMVpZamc0UDVF?=
 =?utf-8?B?eHUrd1p2RHNxbjdSZzBkcHdIc1pQbmQ5cFcxaU0wZmQ5bVI1UU55Qm9KYlha?=
 =?utf-8?B?cXBDbVdYeTNSU3RLWVZaeUFoVjFHRkhWdEtuWHppcm9kT3A4b3ZzMTNlYktQ?=
 =?utf-8?B?R3VnNEttQzdoQzUxRUQvMll4bXcyT0lxNm5MeUxFd2lpTFpGOVJpR1l1VTRE?=
 =?utf-8?B?TS9DQUxXamtrbDgvV1hGbVVIYnVwZVBOT0F2NisxSWRMVjNrTTVOWEFWWWxm?=
 =?utf-8?B?QkpRRks2ZDBhdjZMTFl6U2NtTC9kRTdIamJJTlJmVG94bURzaG5qZ3dKNk5H?=
 =?utf-8?B?empKRnk1M2lFeDA4ZmR6aE1iV3FGekx6M1hpMExlSHp6ekJMd2xBS3RiV0dw?=
 =?utf-8?B?WW1iMUhDSnp4dzhQWEJmbDBhNVdBYldzQlduTVhzbFI2aFhWNW1XcWdNNTZY?=
 =?utf-8?B?dTQvMytiRURLQXVpS3ZLSkVmKzRJWnhZNTE1dUxOWi9QTEVhWHpuZ3Q4T2dy?=
 =?utf-8?B?MWl6VmVPYW9XeUhTcjRDL3B5WHArQ2JlMWhJd1AvYm1MZk1pWHlXMGdOZTdD?=
 =?utf-8?B?bUhTTjFsOVFMRnpIdFRQQ2liUGxQd3RBcHhpcnRKcnNIaUdEb2tvV2FvV1BL?=
 =?utf-8?B?cUU3dnhCZTNiaUNmOFJ0bHM4RlVRSmEvNU9lVTVBcGppSGJmVjN2clFmYzRw?=
 =?utf-8?B?M2tkSUl6UlFTb200eE5MYjdkd1FUMFBVd1JLQ2RjeTRVZlJaUWFsT2c4dnN5?=
 =?utf-8?B?d1JSZ0F3RnRwdXArVjNiRS9iay9yNi9jRWhyOEVhZkdGM2U4RXNzOWFZZ3N4?=
 =?utf-8?B?UTh5ZWdEV0F4eGdIMExTS1hqNGlLd2UwL0lQMWFOZG1XQ2xhY3B5ZGlpME55?=
 =?utf-8?B?UlJqZmFtWDZOUG9WM09yZGVQR2hONW5aQ2FoL0JYeVZKUFJ3ZnNIaFFxUTRx?=
 =?utf-8?B?UEJZVVdQSTZTRithQjdQbDhJVWcvalF5a001ZXJvaWRtTEpCem4vRlhheklE?=
 =?utf-8?B?d0lVVURyRjMvdkJXT2dzUVhlZWpFN1dhemVpVFBlcWIyZ0FDeURzNFAvT2Rx?=
 =?utf-8?B?bEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f2a3bf-ac1a-43bd-57b8-08db795016c6
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 09:55:09.1727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ffg3bojvhTDTInUU0QUNWJL8v0ZIlogR+Ml6dx8fGbuJ7RLTDxHS0BAJCqPwOfdjCTrYCiuIfbb7jYgN7/2y3TgXMX40ET4Fw/1tYdCvchs=
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



On 6/29/2023 6:18 PM, Rafael J. Wysocki wrote:
> On Fri, Jun 16, 2023 at 6:51 PM Michal Wilczynski
> <michal.wilczynski@intel.com> wrote:
>> Currently logic for installing notifications from ACPI devices is
>> implemented using notify callback in struct acpi_driver. Preparations
>> are being made to replace acpi_driver with more generic struct
>> platform_driver, which doesn't contain notify callback. Furthermore
>> as of now handlers are being called indirectly through
>> acpi_notify_device(), which decreases performance.
>>
>> Call acpi_dev_install_notify_handler() at the end of .add() callback.
>> Call acpi_dev_remove_notify_handler() at the beginning of .remove()
>> callback. Change arguments passed to the notify function to match with
>> what's required by acpi_install_notify_handler(). Remove .notify
>> callback initialization in acpi_driver.
>>
>> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
>> ---
>>  drivers/acpi/nfit/core.c | 24 ++++++++++++++++++------
>>  1 file changed, 18 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
>> index 95930e9d776c..a281bdfee8a0 100644
>> --- a/drivers/acpi/nfit/core.c
>> +++ b/drivers/acpi/nfit/core.c
>> @@ -3312,11 +3312,13 @@ void acpi_nfit_shutdown(void *data)
>>  }
>>  EXPORT_SYMBOL_GPL(acpi_nfit_shutdown);
>>
>> -static void acpi_nfit_notify(struct acpi_device *adev, u32 event)
>> +static void acpi_nfit_notify(acpi_handle handle, u32 event, void *data)
>>  {
>> -       device_lock(&adev->dev);
>> -       __acpi_nfit_notify(&adev->dev, adev->handle, event);
>> -       device_unlock(&adev->dev);
> It's totally not necessary to rename the ACPI device variable here.
>
> Just add
>
> struct acpi_device *adev = data;
>
> to this function.

Sure, is adev a preferred name for acpi_device ? I've seen a mix of different naming
in drivers, some use device, adev, acpi_dev and so on. I suppose it's not a big deal, but
it would be good to know.

>
>> +       struct acpi_device *device = data;
>> +
>> +       device_lock(&device->dev);
>> +       __acpi_nfit_notify(&device->dev, handle, event);
>> +       device_unlock(&device->dev);
>>  }
>>
>>  static int acpi_nfit_add(struct acpi_device *adev)
>> @@ -3375,12 +3377,23 @@ static int acpi_nfit_add(struct acpi_device *adev)
>>
>>         if (rc)
>>                 return rc;
>> -       return devm_add_action_or_reset(dev, acpi_nfit_shutdown, acpi_desc);
>> +
>> +       rc = devm_add_action_or_reset(dev, acpi_nfit_shutdown, acpi_desc);
>> +       if (rc)
>> +               return rc;
>> +
>> +       return acpi_dev_install_notify_handler(adev,
>> +                                              ACPI_DEVICE_NOTIFY,
>> +                                              acpi_nfit_notify);
>>  }
>>
>>  static void acpi_nfit_remove(struct acpi_device *adev)
>>  {
>>         /* see acpi_nfit_unregister */
>> +
>> +       acpi_dev_remove_notify_handler(adev,
>> +                                      ACPI_DEVICE_NOTIFY,
>> +                                      acpi_nfit_notify);
>>  }
>>
>>  static void acpi_nfit_update_notify(struct device *dev, acpi_handle handle)
>> @@ -3465,7 +3478,6 @@ static struct acpi_driver acpi_nfit_driver = {
>>         .ops = {
>>                 .add = acpi_nfit_add,
>>                 .remove = acpi_nfit_remove,
>> -               .notify = acpi_nfit_notify,
>>         },
>>  };
>>
>> --

