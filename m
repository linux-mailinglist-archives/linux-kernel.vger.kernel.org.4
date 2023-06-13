Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D673E72EB18
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 20:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjFMSiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 14:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbjFMSiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 14:38:09 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFFE19BC;
        Tue, 13 Jun 2023 11:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686681488; x=1718217488;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kmdaCBio0nJgS1DcnO2VHEIh/7/WzK9AP36HkE8Q8ow=;
  b=Iu2H4Y7ldDYXUOa/y9eX38UFjWHHSE86klCC7cIicy7NQCGcW/2NmP+Y
   RVcrNhlmK2KqxqO2hOlVvpQVrXGwdU0/a3QrANJEaHcfnWopvoWLMHI77
   FOZJ/SpYaWg08+L2ICQVsibBHZ59uA06f+9FWqhTeEW8AkIjtlwW2CdDQ
   Fh/RvBqyYs9cJOVgFrba1jjitvkLr4tD0fZHUY5fLbRWtbG7J/9S3q7Aa
   R0JS2nbb7exiH0b3O+v2F/1yy4HhARbkwSYl2FbW7XmR46wflA08mqBpO
   HC+anKQUIc8FMsS804QATbtPzgfJqpWEC0rVAOEYziHiRQbrgLamoKmYH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="422020090"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="422020090"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 11:38:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="958499236"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="958499236"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 13 Jun 2023 11:38:06 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 11:38:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 11:38:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 13 Jun 2023 11:38:06 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 13 Jun 2023 11:38:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B2mwupnxz3HmdYTvov3++Uo4DRwpZOCDEqqJUf7nYH6IitM4F5MmHf5igW9+Jbct6R5sH88D57w8lVDNdGtD1+hZBHCwUyMmudIsUPntC9XdXSJTdVswAMtV/ZVFFQmFfeRfSThr04vzZq9ar4ihcMDZzSPiYiDMLSphVefEkwmU1lwM8ZxO7ryoJY/P8RlekC22a/cjTgg9PpbvZhOk3bCkBBXBV/DwkBVcPvFS1y45pRKt9sHudjp8UxBO9P+0eG6IRlu7phqLY+aLkOaYEz7J4m6LVIQUVagdY1OpPeoIUaM7vhvBjK4OpQSey0MVXub0VyiC4zp5yNiIGIIxwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n2KIGxXBE+BHoYvWmbGFWKMYVsXJwqzymIiPT7PamG8=;
 b=Eco60T+8zdesNGLfU+2mjaToSFR5gGpGMBDpSitdZPKWroWdYUtD8IVmrBAdUkWp6W0AzLAt55ZRlsh80oh7+Pewhf5Bsn0IklUWsPghTDNXpW4kCP5q/rBfQmvGt/6PcDB9KDjg1TqbufzX25q8ht0KSx9kSLjWhUfAmcdJdEEXolLpyqeWBmV2inBxT55haWrtOsh1W/4Ge0s5RfJncEXXCq0H2J62fGWiUG4WdfhrMMWUgr35h2DGZ9inoOurlZE7DUVUlZtT2dDhvFVo5//hVH4f4kL8NovMivZN8F7CnMJ20UYXzj3FHRubv0SNiZYi9kHoTTj0RHfcxDgifQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by LV3PR11MB8458.namprd11.prod.outlook.com (2603:10b6:408:1bb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Tue, 13 Jun
 2023 18:38:04 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6455.043; Tue, 13 Jun 2023
 18:38:03 +0000
Message-ID: <9b655634-ecf6-6c87-dbba-e88df309700c@intel.com>
Date:   Tue, 13 Jun 2023 11:38:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.0
Subject: Re: [PATCH v3 3/4] tools/testing/cxl: Use named effects for the
 Command Effect Log
To:     Vishal Verma <vishal.l.verma@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Russ Weight <russell.h.weight@intel.com>
References: <20230602-vv-fw_update-v3-0-869f82069c95@intel.com>
 <20230602-vv-fw_update-v3-3-869f82069c95@intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230602-vv-fw_update-v3-3-869f82069c95@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::14) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|LV3PR11MB8458:EE_
X-MS-Office365-Filtering-Correlation-Id: 159c58db-bbad-467d-f382-08db6c3d5292
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g4O60UY4Tfy/mvpj75/Z/5fK7aJSYeQxUFNBEiULtc540S4Ag3bi0RgXEJE9gv4PoDDRN8wfSDbh8RTSqINIqkU5yunQxB+L4+Qjrwjb9Ou1RvYcD42izvSNh0jZdKG8kstyHDWav2+IAKVHfEX6tmFz6Et715n2p/3he9a+lOGXq3RSRlDDGNxgxfpQG9QgM+m1Hwfjk2k4tBYkadHdZxk5dbusHDhy2/JLGrm39OlEWVX9+/AwyfIf0Dd11aodZkIjaSvn3kpEJ7JRIdFxZzd/7xc0OHmjx7b9c1R17P0gpKPXBlNJS4vUrdrz/9d2E7n2+0qeP96oC8MI8hUQ7flI+U6n9PhMxBCdyul5L4CBMwWb/YwHuI8xR+VKyLzPmJElyb+uDQH6IFucXl2ALvWqfJv62StxJbXopOo0feEq8QDZouOBma5LTktR0MnC1NuFQ8xdzMvNP9JLtTh+ofQuhS4N0MTT/ao+P8jWyo1KXF2xKnimrD3h/B5ZJk1TKHcLoOsDn29AhHP17nXGADpvniwKNIGx7wSb1kt5/ju7kMVXV3N875+Omrt+d8qy2GOm8XMSUsxVRRr42eYiCOuIboXso618pJ72NGljwm+HspaZZT+LI14G6VUW/5/hj0d9qWxVV981ePZbNd+ddA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(346002)(376002)(366004)(396003)(451199021)(31686004)(83380400001)(66476007)(82960400001)(6636002)(4326008)(66946007)(36756003)(38100700002)(41300700001)(316002)(6486002)(6512007)(26005)(6506007)(53546011)(66556008)(107886003)(2906002)(44832011)(478600001)(8676002)(31696002)(5660300002)(86362001)(8936002)(110136005)(54906003)(186003)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnhjaFZyeVVJTmhKVFl3NDJ2c2hLUHBWY3gwdzhjR1JCSVFMaS9DMWJLZWR0?=
 =?utf-8?B?bVMvaFRkczh3dEtkQWJld3NLeERZaGtldVg3TUNRL1Q2aWdZT21EYmFScm0x?=
 =?utf-8?B?RHpOQjQ5eC9aY1h3T3d1MlBjdldUc0Fad0wxOFNxWVFHK1IyL202OWxiejNT?=
 =?utf-8?B?VXcxQlk0R0NLdko0a21PK0RKaytYTWFSZm9xSVZSOFE2N2xneWNOamUxK2t6?=
 =?utf-8?B?d3dZenB1VGMyaS9ibS9aVXBScmUvZ3lxS2FiUVVKYmtMRDNrbk9Eb2FnRDBS?=
 =?utf-8?B?WU1WMzZxUkJqVDVycy9ydlFRRDVPRm9Pd2RVdEJoQ0NFV2hubFRYMTQ4bEV0?=
 =?utf-8?B?QVR2TnMxVVZwUmVocjl2Uzgvd3Ftb0dXWklrTXUxcUVqVk9nN0NVRWM0Z1FR?=
 =?utf-8?B?bWdPL3lnZDF5cWp6bkFmc0lpZVZDbDlEQm9QTkVuNVJCQkRUeEM2cHIrd3RB?=
 =?utf-8?B?RjNsRStTQmdGZ2lROENaTXlLV0RJOFoybkVFODdMT0JiYXg4SHQrMUdKc0g1?=
 =?utf-8?B?eWt3YnlraGJub09hY0ZCZTFxQWNvZkR4KzR5ZUNPTkRRZjdhbEtqZ3pXRThK?=
 =?utf-8?B?Z29qYzRkTGVpK0Z1TnRTUGMvZEVQWmZodGJ2N3VyRHNPRzVrTTFIR3FSRHoz?=
 =?utf-8?B?V0JJcWlLVXcwemhtd3VpQjFVdm56T3RyUkZvdnBPWHMzQTZwZ0tHc3pHclZI?=
 =?utf-8?B?UGVCUlUyTEFZNVRvZWV4RXdnbS9WSlJwN1kxcmNkWE1sNE10QURKbnhIaTJj?=
 =?utf-8?B?VERXbk45ZTdsa0VxVGtkQVlVV1RwTFk5ZUl4ZHZBZDFLK3lmbUVLbHhIWFVM?=
 =?utf-8?B?aWVuckVmaGkya1F2OUNFZFBMV3k3NEo4Wmh1cFo0NkloRWxCdmJQOTM2aG43?=
 =?utf-8?B?NktmUzlIRzRhM0xoYTdsZHFFNnNLZ3NVRC85clpMaGJ1ODNpdE05d3JDNDND?=
 =?utf-8?B?eGFrT1plbU9DNmxIdGZPN05tLzlNQWtGaW9vZ3NKczg1cVB5cm9TYjRMYkJG?=
 =?utf-8?B?ZmxnRFJkRXdXRlhISUNEbjBFOGlNMU9keGQ3TUNPaDZBM1BKbkJDVkpsTU5C?=
 =?utf-8?B?NmMyZlVTanMvTUFTZ0JNWUZIQUZ3dHZDYVBudnRmL2FXMGhhdUdmQ2ljaDFR?=
 =?utf-8?B?OSs1Ym1yemRvTXRaQ3UyL0RRYkVtejNYMTB4bE1wUUlCUGpZdEZCMVRRbElV?=
 =?utf-8?B?U2dmd3NGV29tTS9BNGZFVGlSWjF6YWttaktkSkdyQ1hZVU9WdHJFTEtnZWlI?=
 =?utf-8?B?T1lzck5hRm9NYXVsTUwzN2hYYXRTcjRxRFZMdGtlb2oycDR1c3RWbE5ncWov?=
 =?utf-8?B?VWJncG9qcEVaWFVSWFpQRCtiNTJ5UUdWT3graXBtTWdtUGhLWEFVWVRZTkRo?=
 =?utf-8?B?bSt6ZG5tSVRSbjFYcEdQc0daZmNteCtReHI0Z1lXRGk0WGdaZW5JaGxFR3Na?=
 =?utf-8?B?eFVMZlIvVWpzVTFLR3FjbnFnTHI0T2Q4c1EyaldYT2lTU3dCT2RXaExTWTFh?=
 =?utf-8?B?NDBVNWpLcU90K1NzUDFBS1FwMklyVGlUWEhaaHBPU3EvZHk0R2lPWVBieGx0?=
 =?utf-8?B?QTJ3bjk5V0JTekgrOURLbkVNTnZIdUdhMUxJZGxzYzZVbkErcUdVZ2VXRno2?=
 =?utf-8?B?VElMZGl2QlhUWEtjWTRBQklET016MmRobE1WM2pteGtTTHhWanhwdFR1ME9M?=
 =?utf-8?B?Q1NLanhQU20zMWorZVIrT1BiQ2dITVNLTGRaaGNzYy85QkR4bk5RaEdIUlhV?=
 =?utf-8?B?NVFEaEZJM25GQ08xOE9HUldCOUFzVkpyL1BGMnAxT2NLM3FKWll6YjVCWEwr?=
 =?utf-8?B?YmEzaEdzMlR0aTVtT1BKcG5ERElEcVhYU1crejhhblltZUxXUmRJVTJtTExG?=
 =?utf-8?B?Y1pRRENoNEpxckwwWXl5a0ZmU3lCTzlLSWNUR3B0L2Y4djhZNnVKWC9KS3VR?=
 =?utf-8?B?aFlmWHRSMzlxMlRLbnRBODhwbTlvZE11U2s5TXVRUWhxTjAyclJkSTJOMDVh?=
 =?utf-8?B?NjBkeDBldGpXZjQ2NW1mODNUQmxJTW9pdDd1QXhDcldhQ2F2ekpVVVU3SFlS?=
 =?utf-8?B?T3NSNjRTVEZkV3VLV0R1aUpHaW9nUWYyWFpDVk1LSUd5K3FPcTdXaTRMd2dZ?=
 =?utf-8?Q?GsGJK5x+8yFR+bBeSsvQbnxhW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 159c58db-bbad-467d-f382-08db6c3d5292
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 18:38:03.8651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Z2mzXnU1YyUP8Pn1RK+HdwmzapkrVDkhB5So3wLYBXESeS0MMXmYxfBVhkLBuzMQ5CbptAitjHZPEhU4XgUbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8458
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/11/23 23:55, Vishal Verma wrote:
> As more emulated mailbox commands are added to cxl_test, it is a pain
> point to look up command effect numbers for each effect. Replace the
> bare numbers in the mock driver with an enum that lists all possible
> effects.
>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Cc: Russ Weight <russell.h.weight@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ben Widawsky <bwidawsk@kernel.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
>   tools/testing/cxl/test/mem.c | 32 +++++++++++++++++++++++---------
>   1 file changed, 23 insertions(+), 9 deletions(-)
>
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 403cd3608772..68668d8df1cd 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -21,42 +21,56 @@
>   
>   static unsigned int poison_inject_dev_max = MOCK_INJECT_DEV_MAX;
>   
> +enum cxl_command_effects {
> +	CONF_CHANGE_COLD_RESET = 0,
> +	CONF_CHANGE_IMMEDIATE,
> +	DATA_CHANGE_IMMEDIATE,
> +	POLICY_CHANGE_IMMEDIATE,
> +	LOG_CHANGE_IMMEDIATE,
> +	SECURITY_CHANGE_IMMEDIATE,
> +	BACKGROUND_OP,
> +	SECONDARY_MBOX_SUPPORTED,
> +};
> +
> +#define CXL_CMD_EFFECT_NONE cpu_to_le16(0)
> +
>   static struct cxl_cel_entry mock_cel[] = {
>   	{
>   		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_SUPPORTED_LOGS),
> -		.effect = cpu_to_le16(0),
> +		.effect = CXL_CMD_EFFECT_NONE,
>   	},
>   	{
>   		.opcode = cpu_to_le16(CXL_MBOX_OP_IDENTIFY),
> -		.effect = cpu_to_le16(0),
> +		.effect = CXL_CMD_EFFECT_NONE,
>   	},
>   	{
>   		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_LSA),
> -		.effect = cpu_to_le16(0),
> +		.effect = CXL_CMD_EFFECT_NONE,
>   	},
>   	{
>   		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_PARTITION_INFO),
> -		.effect = cpu_to_le16(0),
> +		.effect = CXL_CMD_EFFECT_NONE,
>   	},
>   	{
>   		.opcode = cpu_to_le16(CXL_MBOX_OP_SET_LSA),
> -		.effect = cpu_to_le16(EFFECT(1) | EFFECT(2)),
> +		.effect = cpu_to_le16(EFFECT(CONF_CHANGE_IMMEDIATE) |
> +				      EFFECT(DATA_CHANGE_IMMEDIATE)),
>   	},
>   	{
>   		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_HEALTH_INFO),
> -		.effect = cpu_to_le16(0),
> +		.effect = CXL_CMD_EFFECT_NONE,
>   	},
>   	{
>   		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_POISON),
> -		.effect = cpu_to_le16(0),
> +		.effect = CXL_CMD_EFFECT_NONE,
>   	},
>   	{
>   		.opcode = cpu_to_le16(CXL_MBOX_OP_INJECT_POISON),
> -		.effect = cpu_to_le16(EFFECT(2)),
> +		.effect = cpu_to_le16(EFFECT(DATA_CHANGE_IMMEDIATE)),
>   	},
>   	{
>   		.opcode = cpu_to_le16(CXL_MBOX_OP_CLEAR_POISON),
> -		.effect = cpu_to_le16(EFFECT(2)),
> +		.effect = cpu_to_le16(EFFECT(DATA_CHANGE_IMMEDIATE)),
>   	},
>   };
>   
>
