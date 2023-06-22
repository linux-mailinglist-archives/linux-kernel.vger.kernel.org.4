Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B2473ACEA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 01:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbjFVXHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 19:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjFVXHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 19:07:52 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A527D1FED;
        Thu, 22 Jun 2023 16:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687475269; x=1719011269;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NiIRzRxrtK5YkT5sbY7ejcQ+ZeZ9eQYqMzt8oENoQlw=;
  b=ZvH3kR7z+4PYJ3Oazfsv21DSB+W96V6W1/wFx9UlsDMek+WMr1eMhaH3
   hXursu6LaA1oCcBV0XBinHiVbonjxRdH6fuMJgttH1A9DKkGkdUWW1Kjm
   zYZE8V+WBZrp4f0Kdkz/147nDwR0v1V+h2CJ+Qwt0uOgJMFc8Le2w0+9h
   4HNhWrMLjqKhGMaD30d8dPKF4spqErSIFmjwlg1QRFPKYtncscvhigoe5
   Hh4AkZbN/VUr1N/fZf3GnK7gxs1PD0d6IB1TEPZqw7SEK4az0gVu5y+ap
   NXKJxOSU6SpyTa1TQfFSe0K9NNJen2G+e9EoLElGWQVLW/2GxwTu5qEh9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="364082420"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="364082420"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 16:07:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="709256027"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="709256027"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 22 Jun 2023 16:07:48 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 16:07:47 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 16:07:47 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 22 Jun 2023 16:07:47 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 22 Jun 2023 16:07:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZSpE0UAz4CU+bsZI0XuMMoi/Ikzq/n/E7fsBsDQe3H0n7cJcRdfWVSXhR2KHlt63d2RaTOH3KcDvlD760JDg6qaDiRaABDzFwKV5gCwkPmfAPQZ7POgHmhYsXGJ/5gr5exrQOqUcOiBhUUqPIbrwMr4rdpqD5/bvmCEBp1JlHQDWwz3p4ghLoV8Sk2nvm+Li8lvXL3gerCR5dEN3agoQjpNxLvfTsL09eR5Wa0Nl1aExs/1918OKp0wcWesBox+RQTxau7p2SSI/h/y2tr/ge0mFh6v207We4BsCFdybUvRh4STBAtEMCSQQDeiJgfby76R+Q+2XlKpAyUphr/l7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J24K3zxVziV6RugpoWNdhx2qRSKaI2b3ONfHufOKbHE=;
 b=Y0xm0cT2Otm01zeNxyVkmZX2NZL5mKGFlSaKEkR8jgZhzhJJY27yT53g3WQ9o2JozTffc3R+kCactPsIXEAkz+WA/ZVbkRrYPggtJPJildZjsirNAPy+IHtTuqiAyQxrwg9Ro93PFD1YY9b1trtTu0HXYG+2NH+BkqdOiwjQuNeBtbyiyJpKSOR2/zTbLcBodPwENdqYYpJwTzx3COeWmEnHBOMsDiMhtJaUd1eOoXJ4QoI91fY/P6aNmkwWkIthIdjc+pJ5cWKLJjUOqEz4ievl0js5rmR3ZiNA5a+Hr36+ac0GsBarQ5RrU8Nn0lSL+HGZe8kRX0z3fx5EDWafBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 23:07:45 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 23:07:44 +0000
Message-ID: <a133a5ce-26bc-b5ea-b741-0a57b6f0c03c@intel.com>
Date:   Thu, 22 Jun 2023 16:07:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.1
Subject: Re: [PATCH v6 07/27] cxl/core/regs: Add @dev to cxl_register_map
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <rrichter@amd.com>, <linux-kernel@vger.kernel.org>,
        <bhelgaas@google.com>
References: <20230622035126.4130151-1-terry.bowman@amd.com>
 <20230622035126.4130151-8-terry.bowman@amd.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230622035126.4130151-8-terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0206.namprd05.prod.outlook.com
 (2603:10b6:a03:330::31) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|CO6PR11MB5602:EE_
X-MS-Office365-Filtering-Correlation-Id: 86bc4e8a-900b-4f3f-24d7-08db73757c98
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QPfIyoJ4x58H/nj5YtQx1DZs2gONzltMQJ0U40eUxB5U0k8J7uEBMoEZw1yLWhQ91pOdhUUp754LW755L6uymY3Ab7DAvhBxgKOAOBJj22lS6+5SWZBIe1iS+Nis9j6s0tMQgTTHKyMzkHD4xDrv4eGO7vMcfrLM6gV8I2gb4QfVZrfsbhT++XcedgsTS8gLsdgimbsVPWL3O0IblfWr03rvf6IssxwbUj5yle6AP6lfC1ltMb3ssO8RZjgUjv0Dmx/hYjLuhSOoqUYJ90kRSxegUi+8ne6UfdIVkho5gJ8/cEcNPrrgbJTqDwStzKZ1k/RRBjs6DqqRcGfX9IoxbMyNSchDLHSPbd+Rz0ShZMpeO53YPn18L8m6ddBNliQp6Xu2lb8Q/hGXjPYtAJkoTC+UeP4z4WvlPeiuCBixnCYD6VZN31qZsZXXIn6A2p5aR+V0Ff/sqUi812oxPT1Y1W4cp6PN7JJHecmG9dJx7ZUajR9p0FOS9EQJ6YI1LQrtfOMg3/5B9J8N1OgELwOfbc1HLm0MXARMLrrjYOq2Jsjj9XpPoxB3lUjHOT99SBOBwJe+YKbzOgpWcIEJKm3NQoNZmIBO1w7rUcoouSf+hz0bi9AnA6HQLDbjTxyW6C7wlomexO9pDkwoBT34BUwMfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(39860400002)(136003)(396003)(451199021)(31686004)(6666004)(4326008)(478600001)(83380400001)(31696002)(86362001)(36756003)(38100700002)(2616005)(2906002)(26005)(186003)(6512007)(6486002)(82960400001)(6506007)(53546011)(8676002)(41300700001)(66556008)(66476007)(66946007)(8936002)(316002)(44832011)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REQ5VW0rR0JlQlRCdWRvbndyd09vMUtjVTZjYXJXVVZpL2UvVWZaWi9ndUR3?=
 =?utf-8?B?QjlCZDhJbzM4QjVSTjlCc2pzbTZZNURCbzQxa0RHQkZTYzNBUFpEQVZHNjJ4?=
 =?utf-8?B?MmV6NXliaHFPd3V3U3dQQ3p4RlI1dkR6aHppWWp5VWpnd0N2LzJNK0xIVE5s?=
 =?utf-8?B?QUFaVzIzaG1xeE9xR0hFWTJnSXhKN1cvM1BMaFdodUtkTU01ODJpL0o4WmYw?=
 =?utf-8?B?RlFqVk9MaWdWb3hzeFg5WUNMQXcwOEZVYXQvS1loRWZSUzljQ3RTRlQ2Z2t5?=
 =?utf-8?B?OFg1S3hzQ3dlYXIxNzRsUDd0MTE3Y1hxTVZLU3o1S0ZsZzloUHBRb0RsaEhW?=
 =?utf-8?B?cm0rbTM0UG5NT0RicEZFK0crRDQ3ZnF0V3BRODNDWDB4UDhIQlhpQjFGME5N?=
 =?utf-8?B?Y3djOTgvTGhLRC9GNHp1ZXZzRUJhV0NxajZnTkU3b2prNE9mN0RTOFM5d1B2?=
 =?utf-8?B?Y1pRY3JJUTZ5Q3VOeGloTE02aFU2b2RqREdzWkRmSjZUbkhSK0VabGR5eXg5?=
 =?utf-8?B?MWl6U3Vkb1lzS3JJOVpQMnlWZ2c3REJSYkxVTlYzTzhPU1U1NGRUdnlVUXRF?=
 =?utf-8?B?c1VkdmR0WDVqVXkvcWJlU0xoZ1RCKzl6WEtxTFE5dS9kbnpXL2pjNkhsbEYx?=
 =?utf-8?B?UmJaL3VKQ2ZMSWFUcHphaDdTRGNCYzZidk5PL3UxelNWTlNWY1JJMHRqUmw1?=
 =?utf-8?B?NGUxNnNkMHpwN2l1MjZUblU5bGJmU3BZaVBRdXN4L2JoSmtlRDFwQ2lBVkY3?=
 =?utf-8?B?Q0hqVXhpUHg0OW85Smw1S0lGaWRLdUQwRndsT1NQS1JkMHFaQjFEUFVLMjhI?=
 =?utf-8?B?citKR1BSamsvMi84c1l5ZVIvVWkxd0l3SHdOYndpZE0xUElYekx1NmNZNFd2?=
 =?utf-8?B?LzhHRzBaU05VS2RRR2phaXJBVGY4cGRHMGZvUEh5V3JhSG1FVWg4UXpHcG9H?=
 =?utf-8?B?Y0JQckNhckQwZHg2QWlVcGtCTG1HR0s5Y3d1SFZGamhvb2VrZmVsZWJ4SGlD?=
 =?utf-8?B?akJ6VW0rYlJPTGxJT3ZCNXQxdUxYSFMreDJaVlg1TXRxTm5NYzdoL3laNHlT?=
 =?utf-8?B?OGlaaFZCaGhRc3kzMXVGS3VuRFlXZXhmR1JEN1NMZ3lwc1p3WE05dVFrMHRW?=
 =?utf-8?B?bGx0V3RDNlRwWFNMSlV4amZyQ2s1ay9pVktiZUFsY0dRdGFjTnRLNjROcDlk?=
 =?utf-8?B?WGh1MEhDTjFuMFlVRytESThvVmk3dHREcWZBTW4vNUozL3NOU1JOeUJ3T1Z1?=
 =?utf-8?B?L2ZMbDlJczduKzB6K2svK1hqd2lWZEpRQmpXbTBieWVvQzg3WlNKN3VSbzE2?=
 =?utf-8?B?UG1HRW1KNEhFS3VJYVZQejV3aE5oSDB2Z2dEem9ZNzFRWXJIU0RNMEM3TEda?=
 =?utf-8?B?UldPR2h6cUx5S3IvSktRQW9rQlkvd3J3ck5hZGREQjZEcUhKS0NmemFNeUZN?=
 =?utf-8?B?VGZ6Nnh4ZHpDT2VyQ3lEVGQxbGRCZ1NyK3FYTjZ2ekQwRmdNV2JPU2hIM0Y1?=
 =?utf-8?B?aGtYWTRCdUNiWi94SlAxUThUMlAxbThmMDUzRkd5bTAwTnpWNU1oOEhNTTJn?=
 =?utf-8?B?alNqTlllTWV4QzVqNFpFMjlSc0RLZG5EZWg1Z3FpKzdyMEhmbmIvMk1BMDhH?=
 =?utf-8?B?blkyVEIyWG1jSUtCaFI4ai82bjNwVGt5MXljVHV1ZmJZbUpVbXFZenpZRTJj?=
 =?utf-8?B?ZXc1RW14Qm1PTU5kWHFCOTRBbGJYMHIxTTBMUTF3aCtGdlc2aldMcU9XRHJX?=
 =?utf-8?B?aWo2T0d3WTVmTGx1NUtDTFlvV0szd3FSN0x0VGNSOGZibFM2em9PRThFSVVy?=
 =?utf-8?B?b3E4WTRwbGMwSGQxTndnKzJwSEl2ZjlNZDAwd3p6STMxMzJqVVBaL2JWUnFM?=
 =?utf-8?B?Y0NSb0pXSUNROGFvZFBQUzNZQW1PSjQrMFkxU3BDV0tnRnJ0VThZWk1aV2x5?=
 =?utf-8?B?eDJLODVsVnh6QWJ5Nnd4SUZhYWs3eU9zWWR5QlJ6UHI1SDlNU2dkZ1RyUU8z?=
 =?utf-8?B?RWdJVHpyMlJNNmovWGtVVjRWTVUrV3JnRlI0cFJWa0FVWFZLWElQZDJ4L1lT?=
 =?utf-8?B?WVlaZjV1U2ZuaUpkUVRiZmE4bEpNWngwTzdUVWUyeWQyeGNQZTV3aXRkMnNR?=
 =?utf-8?Q?xIcSnSYYRk9BPc9wJmEnQbb8g?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 86bc4e8a-900b-4f3f-24d7-08db73757c98
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 23:07:44.3271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qgEu/cgFubT5jfFBAn4tThKHAB6QQ27KfESd7koEkLkIS6IB+cHDHy3KRyLHx6gcuOCALU3/F+YWCWIwZQLNRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5602
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/21/23 20:51, Terry Bowman wrote:
> From: Robert Richter <rrichter@amd.com>
> 
> The corresponding device of a register mapping is used for devm
> operations and logging. For operations with struct cxl_register_map
> the device needs to be kept track separately. To simpify the involved
> function interfaces, add @dev to cxl_register_map.
> 
> While at it also reorder function arguments of cxl_map_device_regs()
> and cxl_map_component_regs() to have the object @cxl_register_map
> first.
> 
> In a result a bunch of functions are available to be used with a
> @cxl_register_map object.
> 
> This patch is in preparation of reworking the component register setup
> code.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/cxl/core/hdm.c  |  4 ++--
>   drivers/cxl/core/regs.c | 18 ++++++++++++------
>   drivers/cxl/cxl.h       | 10 ++++++----
>   drivers/cxl/pci.c       | 23 +++++++++++------------
>   4 files changed, 31 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 7889ff203a34..5abfa9276dac 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -85,6 +85,7 @@ static int map_hdm_decoder_regs(struct cxl_port *port, void __iomem *crb,
>   				struct cxl_component_regs *regs)
>   {
>   	struct cxl_register_map map = {
> +		.dev = &port->dev,
>   		.resource = port->component_reg_phys,
>   		.base = crb,
>   		.max_size = CXL_COMPONENT_REG_BLOCK_SIZE,
> @@ -97,8 +98,7 @@ static int map_hdm_decoder_regs(struct cxl_port *port, void __iomem *crb,
>   		return -ENODEV;
>   	}
>   
> -	return cxl_map_component_regs(&port->dev, regs, &map,
> -				      BIT(CXL_CM_CAP_CAP_ID_HDM));
> +	return cxl_map_component_regs(&map, regs, BIT(CXL_CM_CAP_CAP_ID_HDM));
>   }
>   
>   static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 6c4b33133918..713e4a9ca35a 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -199,9 +199,11 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
>   	return ret_val;
>   }
>   
> -int cxl_map_component_regs(struct device *dev, struct cxl_component_regs *regs,
> -			   struct cxl_register_map *map, unsigned long map_mask)
> +int cxl_map_component_regs(struct cxl_register_map *map,
> +			   struct cxl_component_regs *regs,
> +			   unsigned long map_mask)
>   {
> +	struct device *dev = map->dev;
>   	struct mapinfo {
>   		struct cxl_reg_map *rmap;
>   		void __iomem **addr;
> @@ -231,10 +233,10 @@ int cxl_map_component_regs(struct device *dev, struct cxl_component_regs *regs,
>   }
>   EXPORT_SYMBOL_NS_GPL(cxl_map_component_regs, CXL);
>   
> -int cxl_map_device_regs(struct device *dev,
> -			struct cxl_device_regs *regs,
> -			struct cxl_register_map *map)
> +int cxl_map_device_regs(struct cxl_register_map *map,
> +			struct cxl_device_regs *regs)
>   {
> +	struct device *dev = map->dev;
>   	resource_size_t phys_addr = map->resource;
>   	struct mapinfo {
>   		struct cxl_reg_map *rmap;
> @@ -302,7 +304,11 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
>   	u32 regloc_size, regblocks;
>   	int regloc, i;
>   
> -	map->resource = CXL_RESOURCE_NONE;
> +	*map = (struct cxl_register_map) {
> +		.dev = &pdev->dev,
> +		.resource = CXL_RESOURCE_NONE,
> +	};
> +
>   	regloc = pci_find_dvsec_capability(pdev, PCI_DVSEC_VENDOR_ID_CXL,
>   					   CXL_DVSEC_REG_LOCATOR);
>   	if (!regloc)
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 754cfe59ae37..bd68d5fabf21 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -231,6 +231,7 @@ struct cxl_device_reg_map {
>   
>   /**
>    * struct cxl_register_map - DVSEC harvested register block mapping parameters
> + * @dev: device for devm operations and logging
>    * @base: virtual base of the register-block-BAR + @block_offset
>    * @resource: physical resource base of the register block
>    * @max_size: maximum mapping size to perform register search
> @@ -239,6 +240,7 @@ struct cxl_device_reg_map {
>    * @device_map: cxl_reg_maps for device registers
>    */
>   struct cxl_register_map {
> +	struct device *dev;
>   	void __iomem *base;
>   	resource_size_t resource;
>   	resource_size_t max_size;
> @@ -253,11 +255,11 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>   			      struct cxl_component_reg_map *map);
>   void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>   			   struct cxl_device_reg_map *map);
> -int cxl_map_component_regs(struct device *dev, struct cxl_component_regs *regs,
> -			   struct cxl_register_map *map,
> +int cxl_map_component_regs(struct cxl_register_map *map,
> +			   struct cxl_component_regs *regs,
>   			   unsigned long map_mask);
> -int cxl_map_device_regs(struct device *dev, struct cxl_device_regs *regs,
> -			struct cxl_register_map *map);
> +int cxl_map_device_regs(struct cxl_register_map *map,
> +			struct cxl_device_regs *regs);
>   
>   enum cxl_regloc_type;
>   int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 0872f2233ed0..0a89b96e6a8d 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -274,9 +274,9 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
>   	return 0;
>   }
>   
> -static int cxl_map_regblock(struct pci_dev *pdev, struct cxl_register_map *map)
> +static int cxl_map_regblock(struct cxl_register_map *map)
>   {
> -	struct device *dev = &pdev->dev;
> +	struct device *dev = map->dev;
>   
>   	map->base = ioremap(map->resource, map->max_size);
>   	if (!map->base) {
> @@ -288,18 +288,17 @@ static int cxl_map_regblock(struct pci_dev *pdev, struct cxl_register_map *map)
>   	return 0;
>   }
>   
> -static void cxl_unmap_regblock(struct pci_dev *pdev,
> -			       struct cxl_register_map *map)
> +static void cxl_unmap_regblock(struct cxl_register_map *map)
>   {
>   	iounmap(map->base);
>   	map->base = NULL;
>   }
>   
> -static int cxl_probe_regs(struct pci_dev *pdev, struct cxl_register_map *map)
> +static int cxl_probe_regs(struct cxl_register_map *map)
>   {
>   	struct cxl_component_reg_map *comp_map;
>   	struct cxl_device_reg_map *dev_map;
> -	struct device *dev = &pdev->dev;
> +	struct device *dev = map->dev;
>   	void __iomem *base = map->base;
>   
>   	switch (map->reg_type) {
> @@ -346,12 +345,12 @@ static int cxl_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>   	if (rc)
>   		return rc;
>   
> -	rc = cxl_map_regblock(pdev, map);
> +	rc = cxl_map_regblock(map);
>   	if (rc)
>   		return rc;
>   
> -	rc = cxl_probe_regs(pdev, map);
> -	cxl_unmap_regblock(pdev, map);
> +	rc = cxl_probe_regs(map);
> +	cxl_unmap_regblock(map);
>   
>   	return rc;
>   }
> @@ -688,7 +687,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   	if (rc)
>   		return rc;
>   
> -	rc = cxl_map_device_regs(&pdev->dev, &cxlds->regs.device_regs, &map);
> +	rc = cxl_map_device_regs(&map, &cxlds->regs.device_regs);
>   	if (rc)
>   		return rc;
>   
> @@ -703,8 +702,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   
>   	cxlds->component_reg_phys = map.resource;
>   
> -	rc = cxl_map_component_regs(&pdev->dev, &cxlds->regs.component,
> -				    &map, BIT(CXL_CM_CAP_CAP_ID_RAS));
> +	rc = cxl_map_component_regs(&map, &cxlds->regs.component,
> +				    BIT(CXL_CM_CAP_CAP_ID_RAS));
>   	if (rc)
>   		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
>   
