Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E4E7178A1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234781AbjEaHtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234783AbjEaHtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:49:12 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC2893;
        Wed, 31 May 2023 00:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685519350; x=1717055350;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lYxOSTrvEHMXPes+xxSH7AOGMnb7kh33V4WGC73FAgw=;
  b=eTcSp0Fe7SKtjXKFO4j3fTHDVxwrJdcca22NR+McsNt+gM7nKn+2xStH
   MxdZBcRMHLy1xYPkQRj1bEaXjxxSeCjyXu34ZadZQiUbnt4fmVi6U1FyB
   G1fVRf591fE4FQCMOAs3GVbUrqGx+WQwOrYd3LJSo6Of3ywc8tqvd/CjQ
   t4/0zsjpPDt4b+7C9CoeNn89Ls+kzRbjGFnYL8XKy3fk9xQ5QWRdJlKYP
   MfvmHGvqnppkRwPWLczG7uc2BXD1DknYqEPT5et2SMU0CnFUtHRFaixvq
   PRugwyHKeaCwO3ul7mR7sfFzbWPc1EXFOzDSapDsEl7IcIZadWkHUPHTi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="344674186"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="344674186"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 00:49:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="796600777"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="796600777"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 31 May 2023 00:49:10 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 31 May 2023 00:49:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 31 May 2023 00:49:09 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 31 May 2023 00:49:09 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 31 May 2023 00:49:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=khXwEiXxasycpTQnZkz8ZJ7YlTb1U9qtRk4wNePQ0gOYhaWJytMXtHUwm7El1znDNuoncfCXJV935aVYe+0G29F1r9XWzhLP5CBWkjXGrcnb2xnPgm6oSUWm7WRVxKFjRJQ3GLQ9pOri8fRSUWdV4Ezd+cBgx6jy+tNdy3yEdqtUJeX8Hb9cyPcJF19Uk9i4XL4YVeLinamby51hwEZhgsuxWThkPmI5Je06Qyi6SxqAKMscTG7RdCy4pRk7DjsokYjEEMxmd9BRb9+ip/EpW3YuWDGanc0IRq9YKQxBlL/iwgRbj/0tYq1YAY5oGw/lFEUghcowD48rOPSYDYuZwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fhw/OcmzVcM7NA/u7pWF4FCg419B3fhfMYNLEZX9fYM=;
 b=L5nSYOsKhSwkuDP57Hlu4aRn4vOaUVo59yxbrqwlGTiaWmDy9CQ1GdGXf+FxCpfyud7KWSPjfllsa7wOpalDEQTIXlggYkg2yk5mRbeTobkkfqgy8o48j9r19sHs7bclHQs/i2yisDmF5iy6Xg2IOUrMEBt85A5tizrALdZTLWDicgdOR7jW8IzVAcz4rZFusqK03lVa0nGr5zhQcBRNf/E1WKE7QxX3Sq/TLwdkKSSNC9sIRT1Nvc5ohD3fI7dOcMWiCwhbiiJBU+8Kjl+7JnnDTVx7VhTQrhc2gKet+/Bi/t2md0W5HAWwAuLI/r8yRm2X7UOk0oRVHaEM193m3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by CH3PR11MB7675.namprd11.prod.outlook.com (2603:10b6:610:122::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 07:49:01 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92%6]) with mapi id 15.20.6455.020; Wed, 31 May 2023
 07:49:01 +0000
Message-ID: <d93db4e9-16b4-d20e-0769-d6f9b8826b64@intel.com>
Date:   Wed, 31 May 2023 09:48:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v1 2/5] ACPI: thermal: Drop redundant
 ACPI_TRIPS_REFRESH_DEVICES symbol
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
References: <5675481.DvuYhMxLoT@kreacher> <8222291.T7Z3S40VBb@kreacher>
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
In-Reply-To: <8222291.T7Z3S40VBb@kreacher>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0041.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::12) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5603:EE_|CH3PR11MB7675:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d52137f-b881-4c7f-595b-08db61ab7f2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bGOdh3/8NqIKAdncruKcQzVuDyvnDs0sy87Lon2qTLphbKpnQMhDeEuNyZa8bT+R6Pu320nemI+nNnIw23bIcbJqcCTF31mkcDGlnXhpolgZfN0cy8Km3mZkgKo3dnQYx+ziAWoURsk6v/PL/kwyCGFn7+20mIVOXRGwouIeTyIapgDS9rAzXqNeT6X8T9fhtzkcUfVSEEI8Fbmw5CFwdcbF2hHkQSiVxkUF6kjm8PdK0HUvb5vbVhmU9UDCRjEwXs02puHKyV8hxpX78SZCxlSQV4oAWKdjqDeo+6UpiKh26dDn2BmzLCR6s8S5jaJzmCU6To/ojWpFevUVCK59BoYkEE/0jf27YfrpS1gVQPH0kR4Yp/M8MZgv5N/0ZkU7Jy6Ir0rHCByzDgY2L686+jQ8jZ0aff/suHYFwkBq6YSWv0u6/vN+zzw+DrCgeOxRosb/1AxHHs351KUrvdj3Qbi3dNg6iV80DUV4Xp1q52gcAoeONnFqWVP9cP4wM8jPEdHrW8GRZQA6hv7pVLhBwC9wbCyoqHNHP18H42efONOJtBmpXZ5BSHYv0ljXYRkxeDx11BggGMV8JU6XdVrLk34fc7sjcCMcohU3GMS0yvd3HF81bQnMR5xHyxUFxoxqd9+7AX4d/Cqu+HILL4RD2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(136003)(39860400002)(376002)(366004)(451199021)(31686004)(84970400001)(6486002)(36756003)(6666004)(66946007)(66476007)(66556008)(54906003)(4326008)(316002)(110136005)(478600001)(31696002)(86362001)(186003)(6506007)(6512007)(53546011)(26005)(83380400001)(41300700001)(8936002)(8676002)(2906002)(5660300002)(2616005)(82960400001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzhiWTVQRkJFSmxXVENpZ1pWNFNRTCtlb3lKdWpmNEoyMlFuVjVNeWJlU0RP?=
 =?utf-8?B?WEhrQlJKQ1hMSUVKWi9URkZRQW5GT1BnK2NudTltWkJpUENEVFo2UTZWZ3dl?=
 =?utf-8?B?RC9ITGJZdnAxbC9lTDhwTmZhRS9OMENJWnN2UFRjMnZvZERpeU1BdDdVWnF2?=
 =?utf-8?B?Z21yKzdIcTdXT3B4NVVNQjdJSTBQUFJCZUFmT3BZOHE2Z1FNL3RuSDcxVDJ5?=
 =?utf-8?B?ZFFZTDl3Y2ZoaWh6d0hFUTE4cVRUeU8vTVlqZVptazVTa0NKRU1sNmJabSs2?=
 =?utf-8?B?a2VvY2pMaGQ1U3JjVUJNWW4vdmUydXFBQ2oxcG9peEhNSHVmUll6QnJOQnpC?=
 =?utf-8?B?Y29yUTVLd3pycUsyWVc2RG8zUnJQcGwxTXFIOWN6d1dsTHYyQnFzdzJ6emhr?=
 =?utf-8?B?QURJN1ZvOE5aQ2dzMHRISDVEcnlMY3owUC84MXhqbGpic0pwZlBnRkFvOUVw?=
 =?utf-8?B?TGdrN2NjVDg2WXp2dkZ3UUVvZzJiMkdoYkU4OXFXSTNVM09HWnV1RDRwUk5s?=
 =?utf-8?B?L0Q3ZFJEUTRPS0JZMG5QVUxjb2tRbG5tY3VrK2wzb0ZxRk03ZXdHeEtVTFBh?=
 =?utf-8?B?MC9iVGtUQVB6Tnh2VW5TamVXOEpkYjNSeTgwVVVEcFdsd1BUR3RUTjFBL1JH?=
 =?utf-8?B?SUQ0WERNUDJqNFFGblZaNDBWTzk2YmRnYkg3U0Y1NEJIWXNWYjYrV1cwNFhK?=
 =?utf-8?B?cGlJdWlIVkhQSFdSSkEvNGlhMjgyV3pqcStUY1VNOWQxRDhVcGo0cFZPRWNt?=
 =?utf-8?B?WGtrcDhydHc5MVEzWXNHM09pRnpRTjNNdVhSUkgwVDdaUzFKdlpnTGszOXFx?=
 =?utf-8?B?dG8vWWZaN2gzVGZ4YnBSQUR3S3dUM1hWL0RIR3FpMjNQZU1BVGVSaGRmK1Bu?=
 =?utf-8?B?TGZiZEhjVk56cFFCOGZZVFQxdWFFY3BqeFRwb2ZEVkNQS1Vxd1FHVXlNM1NY?=
 =?utf-8?B?aVVqN0k3ZlY5ZHlzVTY1OHlnck10UVhlSHdBbzY2eHZ4MHY2TlM4S21tZE12?=
 =?utf-8?B?Z2ZENWFVWkdwRlJYaWloTE5NZ1J1N3FndVVqUXAvYTBDTDFwRkhvWG1WM0hp?=
 =?utf-8?B?UFBKYTl3cTdKS0pucmFwV1BSWUlRSXRtMzFScGlxSU5JQ1VsZFYwMUFiR0Vv?=
 =?utf-8?B?RngxNnBUVkg0NmxLOHN5RDNtdkd6Ujk4Mmd3YzFCb3FTcVpXVjI2YU5uMWRn?=
 =?utf-8?B?SVA3Wmpab25Hei9nN3hmWk5ZZ0NKcWNCcVNaVEdmOVBzdHFIcmZZUWxNa1My?=
 =?utf-8?B?dGlOMzFIRUg2MWI3R2tFZUtlcUZhNUNpU094cm9YRVl4dWRXUE8xZWtiNDY0?=
 =?utf-8?B?RFErRTAzdVFuTkxVTGkrT0t1RDEvOUxWSVNZUjV0UG91V2xyUFB1RU4ybCtX?=
 =?utf-8?B?Rkoyd2pwZStmVVZqdlJTZzFSVmZ1VnhZRDdMcHVZN1h1RHEzVStFK2RXMllr?=
 =?utf-8?B?ZVV3MkhyUnpxRHVNdWpRb3d1c2tUVVJhaDRJenZabHVwaWRKRndkV0JiZ0hn?=
 =?utf-8?B?ZlRxcnlqako1YWJOTzJoQVUxcHlnaGlVYVZhQ0xkQXJxVjJyL3U5NDlxNGJu?=
 =?utf-8?B?MGtidTdGekJXUEJSeVpHR2FzMFY4MVVaKy9rU0JjdmZ2dGM2STBZcjlJWmNu?=
 =?utf-8?B?SE1YVVgvNVFPQ0NyOGtqcmFkbUpYdUpjR3RJdWxtSENnWDZHdkNVSlVZUFZT?=
 =?utf-8?B?Z052R2NoSmpiSzc2bGpQczlFQ2dMS1JKYkVub3JBQlZMdFRoOWtob3pDb0xJ?=
 =?utf-8?B?R2dQcFVVUzV0Q2dnTjlSV29ka3pBdU9rcFJ4eTY3aGZ1QWQycTF0b0hSQ2lQ?=
 =?utf-8?B?ckptT0tqbG1SM3JHYjNZTzh3SnVQVm1ZVkpPYzF5R2p3L1Mva2J2RGhuQXRG?=
 =?utf-8?B?cUQ4cjZZVmdiWHNLMTQyY1hOQk1lYXhMaWFONnp1bkp6bisxVDNkWi9MM0hQ?=
 =?utf-8?B?THN0Z1RRWHFXanROOUo5Rlc4OXFvbTgyd1VuWGxzQTdXU3U5WG9XM0t5SDFH?=
 =?utf-8?B?cWNkK0dBYkFFb3BET1hQOEppTVQ3S3ZIUG9OQWhMQlBTZWtNQ1FjbzRrQ01V?=
 =?utf-8?B?cFlFTUdZc0RuNVFValNNWTdJM2dQY3VIRzlqY21URkVDNTBKWmJmM29sMm1z?=
 =?utf-8?B?d3hHenBCc1lCRnhSaTYyN3cwemxYOTNaRUVIUWphUkl2NVBVMnVUenVVN0xt?=
 =?utf-8?B?eHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d52137f-b881-4c7f-595b-08db61ab7f2f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 07:49:00.7285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IertamohWYpMVUe/DIK1rs8ZZHa4Hwhm0Mnn8w2ktFiG4KxTdL3V8N+d+1gYGvvkERDi/7QWvdEc1Tpea1vGur6/M1n16XgiXnG2H1Rbnsg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7675
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/30/2023 5:44 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Drop the ACPI_TRIPS_REFRESH_DEVICES symbol which is redundant, because
> ACPI_TRIPS_DEVICES can be used directly instead of it without any
> drawbacks and rename the ACPI_TRIPS_REFRESH_THRESHOLDS to
> ACPI_TRIPS_THRESHOLDS to make the code a bit more consistent.
>
> While at it, fix up some formatting white space used in the symbol
> definitions.
>
> No functional impact.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/thermal.c |   13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> Index: linux-pm/drivers/acpi/thermal.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/thermal.c
> +++ linux-pm/drivers/acpi/thermal.c
> @@ -238,12 +238,11 @@ static int acpi_thermal_set_cooling_mode
>  #define ACPI_TRIPS_ACTIVE	BIT(3)
>  #define ACPI_TRIPS_DEVICES	BIT(4)
>  
> -#define ACPI_TRIPS_REFRESH_THRESHOLDS	(ACPI_TRIPS_PASSIVE | ACPI_TRIPS_ACTIVE)
> -#define ACPI_TRIPS_REFRESH_DEVICES	ACPI_TRIPS_DEVICES
> +#define ACPI_TRIPS_THRESHOLDS	(ACPI_TRIPS_PASSIVE | ACPI_TRIPS_ACTIVE)
>  
> -#define ACPI_TRIPS_INIT      (ACPI_TRIPS_CRITICAL | ACPI_TRIPS_HOT |	\
> -			      ACPI_TRIPS_PASSIVE | ACPI_TRIPS_ACTIVE |	\
> -			      ACPI_TRIPS_DEVICES)
> +#define ACPI_TRIPS_INIT		(ACPI_TRIPS_CRITICAL | ACPI_TRIPS_HOT | \
> +				 ACPI_TRIPS_PASSIVE | ACPI_TRIPS_ACTIVE | \
> +				 ACPI_TRIPS_DEVICES)
>  
>  /*
>   * This exception is thrown out in two cases:
> @@ -906,13 +905,13 @@ static void acpi_thermal_notify(struct a
>  		acpi_queue_thermal_check(tz);
>  		break;
>  	case ACPI_THERMAL_NOTIFY_THRESHOLDS:
> -		acpi_thermal_trips_update(tz, ACPI_TRIPS_REFRESH_THRESHOLDS);
> +		acpi_thermal_trips_update(tz, ACPI_TRIPS_THRESHOLDS);
>  		acpi_queue_thermal_check(tz);
>  		acpi_bus_generate_netlink_event(device->pnp.device_class,
>  						dev_name(&device->dev), event, 0);
>  		break;
>  	case ACPI_THERMAL_NOTIFY_DEVICES:
> -		acpi_thermal_trips_update(tz, ACPI_TRIPS_REFRESH_DEVICES);
> +		acpi_thermal_trips_update(tz, ACPI_TRIPS_DEVICES);
>  		acpi_queue_thermal_check(tz);
>  		acpi_bus_generate_netlink_event(device->pnp.device_class,
>  						dev_name(&device->dev), event, 0);
>

Looks good to me,

Reviewed-by: Michal Wilczynski <michal.wilczynski@intel.com>

Also I wonder, whether I should wait with another revision of my patchset 'Remove .notify', since it will
obviously need to be rebased on top of that changes.

>

