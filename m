Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E93073AD5C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 01:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbjFVXuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 19:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjFVXuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 19:50:10 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D99D2121;
        Thu, 22 Jun 2023 16:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687477810; x=1719013810;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QECeKOTe33ly82afNg24TTDUBElGlctDInq1PjiqdBo=;
  b=TRai92J2aJXCz9wPQ12482B3MN0cGNobzpuKscOud66sXJzrQNeHRYNl
   hTCDX/9vwqnrMD74lGwbSpa0o/gpTuR6Hg5PeqiTC2uFjuXzvNe9D2jJW
   j+CxlKKBh71+kMnPF5LZUeIh+V3Zc6II/HsAao/LTxW6TD123zQngqhGa
   5SZzCuSsBUM6mEaCOtvl5/DOXHBuXIAwK/2nCwPnh/Afpfw9rspIS8ECM
   3bInjIMj/bICXmf+4MYCunGWT9oeEUgCt5xeAhasMNTFnJ8Epu9sSyq7k
   hCO0mNCg5cUMX+hbwMA9UdgDshWJN2YSkNDPUK6DXzn2k34+JF37T/W/a
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="390516459"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="390516459"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 16:50:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="715123931"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="715123931"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 22 Jun 2023 16:50:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 16:50:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 16:50:08 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 22 Jun 2023 16:50:08 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 22 Jun 2023 16:50:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SNvsL06Tcani2vvT/JHEJEBYox//4K7ip+C2So6L6Qju2Q0P4t6zkzkINTDfL+exWKrm+qe3FFtn5yi+gI45EVlzuB7N0Ox+jnIJbtBwrOZfPsbG1hkG3n5DY95Ds6TVAPvHyKIrGxSR8HnJh85sdCdhn16G+mFhTDRfmBGMTtuy8+f9MwPLEVC6Q4qCno/WW5yy82cJ3zZ0mzgX+v9WkHrXVbi8H/7UGqJwKzlYOPNnO7+e4gZm5r9BpVDBfRTrQzAl7C76SzNkGlgQcf7Hg1AWaf8KwFr72uvL+lR5NRt10eT4D2iboaii2jw5XNpIbHlK/Ig8RbNzFS0/9eJM6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6sylTHtZ3/8cD4QU72QHzMONWpyDBOmHWIeJYUwQ/50=;
 b=BI0YzGB7vtGKAP4NjuRAb2SL/6TwWXcdQt3SJRJyYG/2Rnz54AhPmqWz0jCKqe4Tqf7RKTKFiRLUbs/lLd90/JNP/7sPa2o4kdN4urYZQ7BC0WoYq2m5dYyhE9RtTZOBtUyeV3bI6zqKs5Xf5kI7Xspnc9ywNI0pOb+y2OSfnQlUW0PzGQ0R9ZqoPsKcHQsVxQhCGnm7ptq8JL0lpYuSgReCbTtEyouSlhh3yJaqmn6NyHAPIBETqCdewvSrSuqMgVnSKchPNmQ9paHN5dgzquZOqz0zooS0Wp/bk+xp5jF4xlVSwcA8lWyDAwpWQjLlnn23NreShPxWI6fVnePZ1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SJ0PR11MB4941.namprd11.prod.outlook.com (2603:10b6:a03:2d2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 23:50:06 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 23:50:06 +0000
Message-ID: <55979084-5034-5064-a9df-41a4e3050af9@intel.com>
Date:   Thu, 22 Jun 2023 16:50:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.1
Subject: Re: [PATCH v6 13/27] cxl/mem: Prepare for early RCH dport component
 register setup
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <rrichter@amd.com>, <linux-kernel@vger.kernel.org>,
        <bhelgaas@google.com>
References: <20230622035126.4130151-1-terry.bowman@amd.com>
 <20230622035126.4130151-14-terry.bowman@amd.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230622035126.4130151-14-terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:a03:180::20) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SJ0PR11MB4941:EE_
X-MS-Office365-Filtering-Correlation-Id: 0720872e-d6f2-42dc-a934-08db737b67cd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QKS8oD7Ar9FIlXC2W9Zja1GMI+Ne2/e4Zt5IINKLj9cAvhX18r5jP14SYAZy1jpTIZ98LEBVD93gbmCbc0uTjQhIQvyzKg59tUKuRlxi2U0gPHz8eu4QrLAjz/o4cf/YjHXR8PRfClRcvoVmAgi2sB9Kzjks38jo5EJ4P6WqsdOaIVtgcNLaokxNu3edvmTqgWAjpU5on5RHEctjbukalRqHY6PlbCuj7semfBh8uZbWQ9ekFStQSu5nCX4j/9/CJ1icCkjbWB4qTXhKjP6B++ZEVxJlV2dC4iaGNrAscM0cb6HVrhZq7/TSNnWn7qxhpsxZ9TJUJcODWkew82rMNQp8SDlYfMsDEhCwTLVUFF8oKqNHAmxHF89Sv/kJHwKufLZuFG5f6mvAVMiRu8m0ZyZ7Y4/FWqRpOIVCpOL6LwpjY+bVznM7+n4O5tEzykYMVMm6IE/uyLRFl0SqqQLmu5pqtR9WeEfKB/fngXANmYw9C7RNwcB09Sg8uMMgYiVXSZOq//XrFhYvvS0z14juIdkFUldcU4q0b3vt4bX0N6XC59m9D2pY+NPj/t6GgYYNikq4f5fTrJ52Sy603BjQnecENVEbQsxDY6iuOmQ5QnYrX5LvlP5ug/z9parK3hF2P3AP/QImKHby1VeLKjnP4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(136003)(396003)(39860400002)(346002)(451199021)(44832011)(6666004)(31686004)(26005)(6512007)(5660300002)(186003)(82960400001)(53546011)(6506007)(478600001)(38100700002)(2616005)(31696002)(2906002)(8936002)(41300700001)(8676002)(66556008)(66476007)(66946007)(6486002)(83380400001)(36756003)(316002)(86362001)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUNkdmI2VTk5TC9LUFByS01XL3ZMZlY0ajZWT2pzSnZRUmROWXhvaHNibzFD?=
 =?utf-8?B?TFdUdVJ4ZXpuc3VGcGNyN1hCdzg4ZFhhV2JpN0g1VmNkYjZHeFFiYXdmZk5r?=
 =?utf-8?B?Z2JnU0N6SGNKQzlaT2JISTVNckd4aWRCemlBamV5TmFGSzdWcldYSEpUUEM0?=
 =?utf-8?B?cFQ1clpYV1RLSnluRUhiNDRZdkt0Q0ZKOWQvbS8wWDFOSjVMblhpdjkwV1ZD?=
 =?utf-8?B?UmROUGsydFAwNWNaZHFWMnNrSWNJN2F1MkxGUXk3d0VELzBCZWlPMzdJUDc5?=
 =?utf-8?B?Qkhta0FQT1FaUmllOFl2TWZXUXhQdndwdzVQNDN1RnA2NkI5NTRqYXdSeTlL?=
 =?utf-8?B?cy8vU3JkbFEzS0c1YVRCeDZTREo5Z2M5NEl5UzMwbm1GL3MvWjNwVDBLWnln?=
 =?utf-8?B?R3phL1ZNWTNOQnFvbEJ0aE1BUjRYTWVvN0Y1TmFLUlJreVJLWDJFUHI1a24v?=
 =?utf-8?B?ZWozQzE4WFlBdjE2OUNYQmNaajBNL2R4bGtXVGVSTVNkUEtrYitoemh4VU16?=
 =?utf-8?B?VVJnQ3FKNi84V0trbWlMeThYOHFpWTcvd0FSQ1NrTzNsOHdIOFF1VCtMQ2lX?=
 =?utf-8?B?NlFvZTJZN3h1VXVzMEI4V2xJWEFKdWtOZDhHRmc4ZXE1NFJKaG1YbVZlczBm?=
 =?utf-8?B?U2JxOHl5V1M0R1dJTUdlQmg5ZnBPbjdZSHhJdnhtbkk5SDBvM1MrMkp0UDVS?=
 =?utf-8?B?SlR5ZGVFM2Vib1pDVHFBcVNyOXgvMEYrSG10dHNRQjhnd1hyOWVaUTVBY0FD?=
 =?utf-8?B?NFhIWkR0OW9TWUkvNkFDUEtaRlBYRkRIcGVyMys5c3N0VXZUU3B3WkRUZDd0?=
 =?utf-8?B?aHlRRncxWmplcmdKRHEwbDQ1WTM2WnRKU2NUT0VGUk0vNXNsSzErajNrWHFr?=
 =?utf-8?B?Q1pLVmYrQW5xdHlxZWJCcFVnQU4yOUZBL1JaTHB5NFBnb082aEJCZTlMQkZB?=
 =?utf-8?B?NnhsT0NsSlRuTFROaFVaOG0rV21YaU8vQ25TUlFZYUNkNElZUGZ1MzROWlZS?=
 =?utf-8?B?UjJ1ZHNyS0JiY0FoYVQ5NjBsWWdNdlQrZGlzRDAwWEE2ek44Mk1lMXZ4OFdx?=
 =?utf-8?B?cU14MTJpaUlsejZxWGtRcDVyWWhhMkJLU1FKeEhWcTJwUjluRVJISjFkcjJ6?=
 =?utf-8?B?THdxM2wxUVZic2tLYXY5MjJhWnRZZE81SG9YcG1oeXlLQkRpaEdTMlZjdFVn?=
 =?utf-8?B?M0hDRG5mQitCTHVLbXhtTW1nVjhKWXYzSmtzKzYyVUliQWY2OUROZ003ZFpk?=
 =?utf-8?B?RHVVTEFJUXZRWFB0dVV6d2JjMlNDeFJLSTF3OHN1Q2RudGRKZXNCMDh4OUlW?=
 =?utf-8?B?YkZwN1UwNkRickVtdHVWRzErVHdVNnlMYjI1UVcydEdYOFRxcG0vNXJsckhT?=
 =?utf-8?B?VnpIMXUzOGh6ZDhueXhJZzFEMDMrbXdGc2dmc08xc1YwY2FITkcwbGpRL21o?=
 =?utf-8?B?aWc1a2VLR0R6MGFLWlpLVFZIVFM5MHl6bW1FRGloalRmcnl1SHRoV055TTM1?=
 =?utf-8?B?RElZMDg3dnp1TnlxcDMwT1BpaU1hR1lxcFZmeHpqQXJtdDJwS2pPVnRaNWFJ?=
 =?utf-8?B?TTl2Yi9IOG9jVmJDKzFtT01JK2Jsckl0cnI0UGduWVNoRm1CZlpmd3pnSXZO?=
 =?utf-8?B?ZWVoR0Z5bEFmV0Joek1PQWRoOERDeEpZT3dPSkxBNmQ3NkVvdStzdUdvYlh6?=
 =?utf-8?B?bE1oWC93T21pTGhiTUVPYlZnaVgvSFlzTTVNc1RtRnI0YmYxRmNTakdnWFFz?=
 =?utf-8?B?ckFPdit0WDdMVjFhY0xiUEJxSktOVFYvOWE4cjYxcW1uUFV5Qm9maUFXNGRQ?=
 =?utf-8?B?N3ltSTJpektHcEw4TzBLb2Zpd0tTd0xYbTN3TldxQVZnZGtnSTFQbnZTL3Vn?=
 =?utf-8?B?Wll3cjRic0xPQ0ttU0dlcFJVeHRlUkRkYUttMDlEcFlFYTk5WXNZR3c0cFdK?=
 =?utf-8?B?Rm84VGpqTklabEwvUWxrTEpodTYrTGVic3FESEFCbzZUSUVwSnFvKzdYVVBy?=
 =?utf-8?B?L2tjMzI5VzJ1Q0FXZGxvSEd0eHp6cmhteFk0U3B1OFZzOWM0U000QVVsOGk2?=
 =?utf-8?B?NkQrMnR2a3dZMXVLVXRFNzZYbzFPU1FoV3UxRE5NQVAzRjAzRmkwTmFuZm1J?=
 =?utf-8?B?SDk1blpHWXBTU0NWVU5wRk5mVEwxUkNWSW13aHhwbkZ4d1gwdlBGMnBBTkFM?=
 =?utf-8?B?Wmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0720872e-d6f2-42dc-a934-08db737b67cd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 23:50:06.5147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iw3GbqYCFjSz2ACKi3ql4SyVhGhaMaJTfzMYM2yymVkpqQOMu7LxnuhY8BQnwPSXx8tq98lhu4cMavA7QaO1ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4941
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/21/23 20:51, Terry Bowman wrote:
> From: Robert Richter <rrichter@amd.com>
> 
> In order to move the RCH dport component register setup to cxl_pci the
> base address must be stored in CXL device state (cxlds) for both
> modes, RCH and VH. Store it in cxlds->component_reg_phys and use it
> for endpoint creation.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/cxl/mem.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 4cc461c22b8b..7638a7f8f333 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -51,7 +51,6 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
>   	struct cxl_port *parent_port = parent_dport->port;
>   	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>   	struct cxl_port *endpoint, *iter, *down;
> -	resource_size_t component_reg_phys;
>   	int rc;
>   
>   	/*
> @@ -72,11 +71,11 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
>   	 * typical register locator mechanism.
>   	 */
>   	if (parent_dport->rch && cxlds->component_reg_phys == CXL_RESOURCE_NONE)
> -		component_reg_phys =
> +		cxlds->component_reg_phys =
>   			cxl_rcd_component_reg_phys(&cxlmd->dev, parent_dport);
> -	else
> -		component_reg_phys = cxlds->component_reg_phys;
> -	endpoint = devm_cxl_add_port(host, &cxlmd->dev, component_reg_phys,
> +
> +	endpoint = devm_cxl_add_port(host, &cxlmd->dev,
> +				     cxlds->component_reg_phys,
>   				     parent_dport);
>   	if (IS_ERR(endpoint))
>   		return PTR_ERR(endpoint);
