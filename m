Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640B773AD96
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 02:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbjFWAEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 20:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjFWAEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 20:04:33 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F74E2;
        Thu, 22 Jun 2023 17:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687478672; x=1719014672;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aM4F1/+xpVX7x3RhmCL3m3BOPPfCYBBqtBwivtQuCv0=;
  b=bdW0MPHeX5l+E/blec4tUdwYCtJ+wlqgoaOQRhpC61e98Xfsc37rfEXo
   Wfhf3nRqHLGtDFLDGVbrPdpRrtWHY6jjI8ehkHa84DAgrASPXd9gnWGQn
   tmGrDOGTmUKsJaTPCtJId1F6MnmLQMK8VdHOfhhHWsETGT+NN2DrFapZx
   xGxr0bAh4lOu3j7mPWc3s1cCUQTxmYCsSiy/ZFY4StTaTT6rRih0AHQU3
   2M8ebTqSRv4YnO0rLEfjde9i+EUzErVJ26eZ8cg4G/2oMysDb3NHXZrnO
   lOYkJmReMKBZH6XPf89N3IwpitcX36GAtXcBMh+BRHVF8++JAbkZIOuYG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="426625926"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="426625926"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 17:04:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="780431052"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="780431052"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 22 Jun 2023 17:04:31 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 17:04:30 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 17:04:30 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 22 Jun 2023 17:04:30 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 22 Jun 2023 17:04:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nufA5hGByyi2tOgrCbQ9WtZUG3qmGWJrVowHhC8fcQzv836wPuF9EXvA15ShI9ptuWT45Qd5UqLBwBDXntU+q1IfBJlYS9VLAw/bj1PIo6VufkY5b7+3mw5/iucYXUcKI1Gkf3eSjTnOSM6HFHoRj/lbH6n1U3uKK3pT/uBJ6kT5iXLMRkZ0CUm9A9MGSiwxMUm/3f0dZeqSYIGOj02N7caXqkEi1RlA33t+z/NTxuBmoBtASvGjpobOLBQwwS6FKgT3v4wIijG8optieL08J+MMQrn83jCj08an0fSlal4lCZG7Wgj/rOiBSXOBynhygNfzvYgxlklrXP/Ubt8lNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wRbXj0cy4WKmwjbb6QzBlp9cEEHJLpcjF3VeSdCdqpk=;
 b=MWLSM0S1Yd+I4T9OUmNoTeU0wS6MBYRyvUy2xmRMaJxg95uWypiaV1ll47GEKj1lqQl07cFjo/KOTqOw43l9jqJefPw1b1ylP1LJ9gPJ49lywiJb0RcOoKplwuHKV38yhu7jf9UxJ3Bv40/8fYjPyP9BvE07uOFL9ncyRC8oWlNA38OJ/cCmyoTp7+RGQFwFY4KiQIGWTeT/jArI1eMgpMmxS6m09gxwT1D+IzvwXxuYw2ORT8eK5bu1DChGWU78/J1YSzjqeLTRyH5XbRgo8sOdnZgn6ApGnALvzH7qU9LQ1t4ehD+PPBv++QnnVybNMm0O+V9qBmspaUYWEeVUeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SN7PR11MB6654.namprd11.prod.outlook.com (2603:10b6:806:262::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Fri, 23 Jun
 2023 00:04:28 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6521.024; Fri, 23 Jun 2023
 00:04:28 +0000
Message-ID: <94ad8187-e4a3-fb9c-d043-ff1e2130b0ed@intel.com>
Date:   Thu, 22 Jun 2023 17:04:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.1
Subject: Re: [PATCH v6 19/27] cxl/port: Remove Component Register base address
 from struct cxl_port
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <rrichter@amd.com>, <linux-kernel@vger.kernel.org>,
        <bhelgaas@google.com>
References: <20230622035126.4130151-1-terry.bowman@amd.com>
 <20230622035126.4130151-20-terry.bowman@amd.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230622035126.4130151-20-terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0029.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::13) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SN7PR11MB6654:EE_
X-MS-Office365-Filtering-Correlation-Id: e4ff46d4-1758-4648-6e48-08db737d694d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R5xKSgyNBeaHkyaCJc3pdkThaQgrZe2L/2mAKgm7X5u/7QXu9qY9wUhS8GEKF0NRyqoics+5lSEMswF7E+1tr+7cG37BuCQeQb/Nz12J75SZf0YyU7Wz+B4cWPfx4d+GjOfU82F+EdPwAxmFJgHW791vyJvxZfIzLNMlO3/PX0Wo1q3hQxOl604HvkJBmTuurIywN+nGPZQmmXK4SkDTg9lv+R3nOMN8t4uHiPhklEWG6vyhDoP08mQvK12nbInL/A0j1Q9WHFTPuZqOR/arazPfvoW56JV8H23/zB64+Ge+6RNKYZSlUOPXSFQinauHwjEHCVY9Y2jBR9MsGZh80K5ciY6PyOpviebUWY4G4z1RNo1JeGzqeRM81Q6IBkigVt8SNNcQX0nEWhjx5B0CwvqpKrYCkVmGfcKhJQv0EVycoVTHF2ZoPAg/AiH0QEGdXGK5Asp/KJWEQEn0aqjf9+YSAYOso4cMKqH2ELeMTXkyHaDQLrQC90qm8HFmwuNUGmth2Y1kQCmKmriSLlny1wKgiGZ4o6ADnaSjH+dOywP3YX9LeGbev/lfZShRi7gNKHmqAMuCjJvgUX5YIkqMgcrjSUwA1Xtp0G/C5JcpnHtxh6wQEJbdkB+7l+1pMfNqeZoseaNDl+QvU7HIi0WrOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(396003)(376002)(136003)(39860400002)(451199021)(38100700002)(53546011)(82960400001)(5660300002)(26005)(6506007)(83380400001)(6512007)(186003)(2616005)(44832011)(41300700001)(8936002)(2906002)(6666004)(36756003)(6486002)(4326008)(478600001)(66476007)(66556008)(66946007)(31696002)(86362001)(316002)(31686004)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0tmQlpVeUM1YzgydFVoeGNjVmlGZE8xbW13NWFyWkZOdFY5VHp2Z1VzcGJD?=
 =?utf-8?B?aUNDT09jOUU3Sll0blVuQy85emx1ZUlpNTN2ankrWHA5bWVYRWlBQ3NaYVJ5?=
 =?utf-8?B?ZlRrbGIrYTZUdVN5dWdBL01rb3NrNC9HWWFyT3lwdk92dlFYb0EvbjM1aXhh?=
 =?utf-8?B?aDZQNXRSSzlxLzFkYWVpbzhZZG9POHpMS3g5SllPU3hHcHNiMnlJNk1keE9M?=
 =?utf-8?B?cFlFTDhwMGp2ZGw5TG9lYWdKWXJBMkoyUG5qQ0Y1Tm5FN2pRYWVzelk3c0lV?=
 =?utf-8?B?M2pPL1J3Yk52dzVsNEt1YTRnN0NrTnRhMGxZeDlnOFhlUDVQTnVhanR6Tzgy?=
 =?utf-8?B?VDV0YStNY1Y4eXZBek42Wmo3OElmbVZFYUxlaTdzTFJrd2FOQkEzWFVTbUVR?=
 =?utf-8?B?QnRmYlF6U29oNDkwNnlaZFFpNmFzOGRFMWJ6TkViaFlYVjdSRDk5ZmpvRHRq?=
 =?utf-8?B?VG9LMDVLZnI2OXJLc1AyRE9iRXd4WXRvV3labXNtTzZtRFp6UEdhZi9Zdmx0?=
 =?utf-8?B?S01VUXl0NW4zTjJpVllTaXg1ZDVzMWxLUGQxWGtoMGo1VzhmQTA2M1AzSkdV?=
 =?utf-8?B?SGxRSEIxUDRlVUY5UEM0bG5nL3UraTM1TUNZeXIyL3JqdUJ0MmIvcFROM2Fp?=
 =?utf-8?B?WmFQZ3JBWk9Zb2ZpaG9MRU41THY2YXhOYXFCUEdqTEZ2eWJNYmpJMkM1cWJ4?=
 =?utf-8?B?M0d5WTR5TW9IYmJHMkN6WW5RVFZodit4dVlERmxKREhzN0FBMm1DTFczM1Rs?=
 =?utf-8?B?VUw2WUZ5NUFBSXRVc1BPci9MbS9abjlsazA4T1hQU21RTGdNRGNRZVV5QnRC?=
 =?utf-8?B?ZUNDMy9uUm92L3RWOFZqTVpOUWZoajhmVmtFR2hlK2VZYmpOMGRmYndaQ2dK?=
 =?utf-8?B?THVMRTVPeXBVSHFDei9VM01VOG5VQU8ySGJtY290ODJlNmF2TDlqSUZ6d09F?=
 =?utf-8?B?V1NybWNNTDdMTGhSTUhoQjZlMjVIc2RQbzJ6b0ZTd0NBei9oWVVXZW85UEkz?=
 =?utf-8?B?VXJSWGZzQmdPV2Y1ODZZRVNtMm5KSnBka1Z4MUNUdXMzK2lGcnJCZnczM3RK?=
 =?utf-8?B?VVJlSnlwRk1EV3NPSUJCMnd1anh4TDlVU1dVdVBSMXBhbzVuZWwyU3JlSTk2?=
 =?utf-8?B?a1JrUHY5Rk9WZnlWeVpEQjdmNzR5aDBCTW15YTV3TWR3LzE2VWFLNy84N2dV?=
 =?utf-8?B?TlFNNXhrSnc5a1FoTWNPa1FQUFhRQkxIcUhQUHFycFJhWlhJVW9kYW1xSWZQ?=
 =?utf-8?B?M0lUeWYvWEM0YkdXa3NIdVBRdlZOaVdDQ1owRGhPL0lDak5XQkR6NVJhZXlm?=
 =?utf-8?B?Znd1NExpeUtOd3p5ZXFuNkRkV21yMHh0Ymkwa1JiTGd0L3hYS0xQblphUDNG?=
 =?utf-8?B?b01ERStUcTdaSGNqdHI2dUd1aVZQV1ZvN1ZoSHVOVU1sZG96WlRaQXpqN3JX?=
 =?utf-8?B?dmxLQk85Q2VRMGF4Q3NiTkUyUUNzMFJLaW0wMUVEWWxyTW1xVFBOK1pnZzJh?=
 =?utf-8?B?dW11cFAraDZWZXJnVXp0MEE2N21DcTA3Vm9iZXZIc1BFTlladlc1R2RtSXFp?=
 =?utf-8?B?QjRBa2tjRXlGNmkwaWxvSXhnVmxMcUsxWlloS1d1cUV1a1F2QlVpL3FvODYv?=
 =?utf-8?B?V1ZlVDhJN2RmQi9acnUyUFBKYXBXOCtQdW9tV1ZrUXBSelJTb3VYQTJiV0Vj?=
 =?utf-8?B?RnU2V1dPNkkrOGQvVUhPS0h4NWY4VGk1VTFYdUlKeE8yOFhEZGxjTWJGV1hL?=
 =?utf-8?B?ZVBudkxZbDhrcEdXNER2Z3VvdzhyajdHeWJEUy80QkhjZjRGM1pWeW8xc052?=
 =?utf-8?B?UG9PakdKSjRFSXpoTlRLUzVHK3dmWG5tQXYwV2NzNnZsZEx2dUh3dGpHNGFZ?=
 =?utf-8?B?dXg1OFBSaTNORm1lTE5XUU9TMU9tRDFydm5WRlZYK0pUSTFIcUlhdkM3T0hl?=
 =?utf-8?B?b2Y3bnN4NjJVWFl6djNXam1aN3FwS0kzNCtHakVjYklFdWNvQnVXVDdFSm9r?=
 =?utf-8?B?aDVxOHJKbjF3U2VKUCtSQzBuV0dWejgyV2FGKzJpeW0xSzByUmJ2UGZsc1FJ?=
 =?utf-8?B?ZHNZWldOcnpQNGJEVndJN3pMNmtpT3NadTFSUFVWdC9jZnoxTmw4ZkxYU29G?=
 =?utf-8?Q?yXh25M/759JjLE11FoY6iYloE?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ff46d4-1758-4648-6e48-08db737d694d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 00:04:27.9563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iELJbRZPk8kUk7233iilQ9jlmcbimuhPoOlXp//+2fYfrDwl7b91M4hIUR6L7QmkbctKA8qWliPW4dwQvqLcIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6654
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



On 6/21/23 20:51, Terry Bowman wrote:
> From: Robert Richter <rrichter@amd.com>
> 
> The Component Register base address @component_reg_phys is no longer
> used after the rework of the Component Register setup which now uses
> struct member @comp_map instead. Remove the base address.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/cxl/core/port.c | 4 +---
>   drivers/cxl/cxl.h       | 2 --
>   2 files changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 45fe7d89f7f3..cfae8307de90 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -616,7 +616,6 @@ static int devm_cxl_link_parent_dport(struct device *host,
>   static struct lock_class_key cxl_port_key;
>   
>   static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
> -				       resource_size_t component_reg_phys,
>   				       struct cxl_dport *parent_dport)
>   {
>   	struct cxl_port *port;
> @@ -667,7 +666,6 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
>   	} else
>   		dev->parent = uport_dev;
>   
> -	port->component_reg_phys = component_reg_phys;
>   	ida_init(&port->decoder_ida);
>   	port->hdm_end = -1;
>   	port->commit_end = -1;
> @@ -726,7 +724,7 @@ static struct cxl_port *__devm_cxl_add_port(struct device *host,
>   	struct device *dev;
>   	int rc;
>   
> -	port = cxl_port_alloc(uport_dev, component_reg_phys, parent_dport);
> +	port = cxl_port_alloc(uport_dev, parent_dport);
>   	if (IS_ERR(port))
>   		return port;
>   
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index b1adca9b27ba..9f46a4e1fbec 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -551,7 +551,6 @@ struct cxl_dax_region {
>    * @nr_dports: number of entries in @dports
>    * @hdm_end: track last allocated HDM decoder instance for allocation ordering
>    * @commit_end: cursor to track highest committed decoder for commit ordering
> - * @component_reg_phys: component register capability base address (optional)
>    * @dead: last ep has been removed, force port re-creation
>    * @depth: How deep this port is relative to the root. depth 0 is the root.
>    * @cdat: Cached CDAT data
> @@ -571,7 +570,6 @@ struct cxl_port {
>   	int nr_dports;
>   	int hdm_end;
>   	int commit_end;
> -	resource_size_t component_reg_phys;
>   	bool dead;
>   	unsigned int depth;
>   	struct cxl_cdat {
