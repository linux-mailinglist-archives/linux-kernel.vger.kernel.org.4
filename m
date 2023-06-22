Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF18E73AD88
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 01:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjFVX61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 19:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjFVX6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 19:58:25 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929331BC6;
        Thu, 22 Jun 2023 16:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687478303; x=1719014303;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DPJAtpDBR/DtF9RZlAEySZib5imQtu9SYYPS9/ump4o=;
  b=nShyQYe7pNAJPVX9GfgDHJrc9f1Soigf89dMewMtyGaXKnvzH1heUK9G
   vRF4UqbTUbZwnelTtYrV1s25n6JRBRFv+ea0pjrqD5WoIsuA0EBOCopW3
   taztpuPv4etYnoQ2MoFP43WbG9zaPY0ZNuUDC13qiuWMUNBZWGA17+Ytm
   WFf2UV8cV4OyKA9AtQbthV5kjs/0cc6+o164pbzYvA/cl/p0AijM0XwiD
   syHKQqH2SGJACS2XhbKzWjJczyo8rZ//FeIl1yiwLQcLhqpoMo7YqYyDe
   m71FEv4m5tG25RtFvn+H0XtxyFRQCdnC9YsMJnrznjGqRv9tCpIcv3aIn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="447020640"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="447020640"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 16:58:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="961772907"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="961772907"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 22 Jun 2023 16:58:22 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 16:58:21 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 16:58:21 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 22 Jun 2023 16:58:21 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 22 Jun 2023 16:58:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0lXfW6K7drHjol0kGzifs7BKA56x3TqoZDdR1wYWDJzyepg6kDfQeSSSpEwJdonp6xU9R7Ia34CNWY0WeNwh+ITziF/JGDOE4Nx0A6/dwXT9MaabplN350/XcY7rnzky9sQZwa6qSHO2hbzhNssvHUCDK5lM0wsb8Cqe8d3ai17XJxIL7MINO/Gz5mBgze1W/JxVgejla15Urr8zYYI6+1/1Qnj1Dh+hEWzT78Nz2FbhxOTZRMKP0dI8ki/dk7MKWwUuzAO1FjxaJ4tnm6WB6F+0AIQokd2Tw1DX4NEyTP1ZvKczR0eR57asAq1jVVAk5ecPbMqnKypoSQMdvOVYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=00e5vp4+HJIrtjA4KZUaMJM2DBt0JOsOn/0J+lgghz0=;
 b=l/lCjgmJL3aS7R/vzQzoDR6L6mFMjF1oAozDTAZW+fhHUHlf64t5VfhyUnOUMvgwODvCBgqQ8f42FKu/p4IwBZ9rBjuqkIss/G1DATr+pBzHc0cM7roQbUuLR4m4uLwscbFwmzK5kOzYd9g2ptMKl7Lq/tlrqClvgYv377hxwGoEBfORrF97IjtaPrgOQgZIz8G5uDNAI+HJ/DkUbWtFDTtc5fC9CSytt03fEJRxqxaliSNEqfpYfDo5bv/Xh+tJo0ubeiB4uy8oqkBKqoIufdGOsysKcqiX9zERYSCxT8tqjSeRj83thqKr5qd4ril41RDZEMUmTYMMY+KyJopLRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by CO6PR11MB5649.namprd11.prod.outlook.com (2603:10b6:5:35b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 23:58:13 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 23:58:13 +0000
Message-ID: <43eee2aa-8a3d-fa8c-c311-937fe2b02928@intel.com>
Date:   Thu, 22 Jun 2023 16:58:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.1
Subject: Re: [PATCH v6 14/27] cxl/pci: Early setup RCH dport component
 registers from RCRB
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <rrichter@amd.com>, <linux-kernel@vger.kernel.org>,
        <bhelgaas@google.com>
References: <20230622035126.4130151-1-terry.bowman@amd.com>
 <20230622035126.4130151-15-terry.bowman@amd.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230622035126.4130151-15-terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0154.namprd05.prod.outlook.com
 (2603:10b6:a03:339::9) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|CO6PR11MB5649:EE_
X-MS-Office365-Filtering-Correlation-Id: 0093dd63-eb23-4dc7-c5e8-08db737c89df
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6jN0H7tXQY9pED0jfnhH0LdTxx8Szk8B6+ZaoNOklCnTIg9HNSeKYwXnJX7cCvkChTyWgJmmzRJ9B0sM7wlaW4JY+8s11cNToSQnHuR3E72eIdbVewYcvg5AS0tn7sfmyerj0nlzrVloGkJzmVGcs5rMHfNmcp+XKyQA/BkTbJgy17/JnvLFWHNSTPS21YOfPLfThSnEXnfFr6YZ5LyXt27/KlUOn5A6Nhd5dIYPM9+PstQ5aKd9IWw6ZuxoQdWdQO3Mxt61M+6bpqrh2N9wZpcQUtjs6MIV9UJe6V6xLyhFKme4fYn5m3z5fMuxjpCcJH4ozXujgSIstmJ7KUsf2bDO5ZBeXlliTrDjHwPKm4WtwNtB6KolwGBbIyL+FEgcqkMNUiDjAdR+p6hxTgJ/m1NlUP1saHCYj0/PacETLorjttboTbVU996nWGiShGQi6iYLWmHRCjajhv1Mt1EdgQ8iUBXboEyNHQqBamijEWYQqpNNAPPyVXn7I+DVrtk+MJlheHwIGGPLGqoiqS0jAWcYPuwQLATfMKXDYqKIBSGVVpTwsbiyz73XEqfStqRxnRyS431hFUV1anhV3b0dfSR9HgXwHqc8m8X9Gw70FdYdIaUT7yR6T9BgieaNBQQYFtE7UyeALmsvzA/EJV6Xhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199021)(8936002)(38100700002)(2906002)(2616005)(66556008)(66946007)(66476007)(4326008)(31696002)(86362001)(36756003)(316002)(83380400001)(8676002)(41300700001)(6486002)(186003)(53546011)(5660300002)(82960400001)(6512007)(6666004)(44832011)(31686004)(26005)(478600001)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXNxUE9OcG9hM01qSFRZdjczaFV5dTlwTndxNEZyTXlkRmVFR002U1V2WUpY?=
 =?utf-8?B?cUhObXVkc3VsTXBwM3VsYmYvWW9lNzB0RmtaQ3JRRlhqbUZyVFVOWTFhQUVp?=
 =?utf-8?B?aXNrQzhkU1BXaEt2VXBmQzRRL0hNWitIVnNlV1BSWG1vckpuT01FamRmRW1y?=
 =?utf-8?B?Y0FEaDFES1gxRjZ1cDB6Yjhnajc4SEhtU2ZKcmpLY0cwOG9QUUZ4SEtYQjg4?=
 =?utf-8?B?SThmQ3ZKU3FjUmxGUUpsZm1NbGFaSWdEaHZkY3FlYUwwZlh4dHVrTVNLVzVU?=
 =?utf-8?B?WFFYUWoxc2M2M2I2NFlFd2ZKK2ZSQlc5M21JcDNpb0prQnJLUS8yRThsT282?=
 =?utf-8?B?N3ZzaWdrYnNnbmJtZXo0MWpuZjNFdXg4K0YrUTRQT0N0aHhjRGhmRVZaUWEv?=
 =?utf-8?B?cEtXZmFRMDBzZE85S2hMaDU5ME52c3JVTFJDOUZrNGlFL2h1NXYxUklPMGRs?=
 =?utf-8?B?VnJtYjRWQlRJMDdMaDUyY3Qyay92aVJ6WEZ6azdCd0Z0UVpJemhzdHpjeDNI?=
 =?utf-8?B?cWhhRnJBSW02V2N5UXdSSUNmOG42eWFjRkZBNTFHTzZuZm81WGRHZmJCdk1J?=
 =?utf-8?B?b0hLN3ZvSGxrSjNlSmZzbUc1cmM5WmR0MWwvMmhVNHNQT1JzZUlYc1g4SXJ6?=
 =?utf-8?B?U2pFekFRem1USTdBL3ZJU3I0TmNEdkpmY01kVEY5a2o1ZHlyNTFWQ0tCcDlt?=
 =?utf-8?B?RnBuOENvZTVpVHBSN0dQaWswaFliczJWUzFJVVN3d3NwUGpEVi9qblZxL2RX?=
 =?utf-8?B?VWpHckJZNk9NT1J0ZUNuOVhYQ1NFRlJkSitlS2lReDEyb2JIVFVDb2FhZDJk?=
 =?utf-8?B?ZlZXSzBqOFp5MmZnZGl1Q213RzJDdG55MEw0S2svb3BlOVpCdGtYbGZmL2hS?=
 =?utf-8?B?VWN1TXFrMGs2dE1jTnI5K1FkOEtjbFNYN3V2M2s1cnlwVEVwei9IUVFubVJV?=
 =?utf-8?B?UWM1bkU5ZWFqc2xmeDdHeGhOZHpKVnEyNit5ME8xY2E1S1V3ZG1mYk5WZ2RT?=
 =?utf-8?B?YVVReGlzNGtVV3Uwd1Y3ZXpqQjVnb1hZQ3VwUlAvQ2Y4YUxNeUxOdDBBYTRU?=
 =?utf-8?B?amN2WHFWZnIxM3E3ZVJPak5POWJieGpWM2kvZ3lqZ0xvRDR4ZllQdUNpaVl4?=
 =?utf-8?B?TC96ZGVJWjZ4ZVc5NGZVbUVxRUhlbjlpTUZYYUR2WGVZTytiQTBlYnYzU2Zu?=
 =?utf-8?B?R21DakJ5NkVTeW5iSytONjNwR0VPL1V6YUxaZHJwZHJubmViVHVEVnhNdUlE?=
 =?utf-8?B?aitpQlVkN0JNSVM1alJlR002SU40TDloLzVpcmN5Q2ExWU5acnBsQkdXS3ox?=
 =?utf-8?B?TXkreGVqNmZidUhRbUVZUVo1Z0RoZ0wrdTBpMzFCa2ZmQmc1NmdhVnJvbDZR?=
 =?utf-8?B?WkIxYmNxMnRoK0VIUEFaQkhmMUF5S2xjM2pxeUNkdHQzZFlNSVg4aldtcEYy?=
 =?utf-8?B?UEd3VjVHQW9qZXJjU3hWcGpud0VCaEFqeXpsd21LS2pab0dTUnZrb2Q2VURt?=
 =?utf-8?B?N0UyVksvSVdNWDdLdklUQml0dEtydDJGM2d1S0hnRnhMQlcrTmVaQ0VQVndL?=
 =?utf-8?B?bkRGWUhITGV0YUI1YmgzdGdTM2dFUE1lLzREWEFBUzRFWG92dGdzUEp2Rm9J?=
 =?utf-8?B?NEtJeFRzdHlNUzlRQTVGNVpnbG1PTVUwMVJqZFgvakJ4aFlTS2EzVVRhZ2NF?=
 =?utf-8?B?Zm9JbkJVUkE2cmFrRmdOQ29najlnTGRIR3lLV0paQmMyVy9oRkI1YnhNYXpx?=
 =?utf-8?B?ZUNHeTdYQXA1d2VtT21Ka0p5bGVLOVJZYjlsQWlpZG0wczRkaEM1ODJKOUFV?=
 =?utf-8?B?QXdBb1poWWVnNzNndXJIR1N2RFFxMm5STDNJZ3l4VTNvWWVIaXdaSXMvS1dH?=
 =?utf-8?B?dHhWSVMvQnN2RnpyNzFCY0VZZHd4ZGFEUHhtTFpJUE8yRW50Q3ZOcVp1dXBS?=
 =?utf-8?B?U3J3N2lad1Rzem85MGgwaERyNnYrR3loQ21SM24wRmluMWtXM3RjdEZ2bkMy?=
 =?utf-8?B?MDAwckIzUzJ1Um9FUTBrNEZzVlNNa0VyMGpvNW9YTVR2YlEwRUZ0WnBOUVhp?=
 =?utf-8?B?aHVZR1puN3pLQ0hjQXdXTUJXUXJVUlIrYmZacjYrcHNCdGpNU1lkKzl0WElN?=
 =?utf-8?Q?8FrC4cUDRXs3wsBdIqAlkCuN/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0093dd63-eb23-4dc7-c5e8-08db737c89df
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 23:58:13.0868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0AOyY3051YKFx04Pb1mVLuiVsc9s9QmptUA9m5Geqez5eqJ3H6eDJvlLiG00SxLi+OvDWCL4ghnVVShDv5dEEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5649
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
> CXL RAS capabilities must be enabled and accessible as soon as the CXL
> endpoint is detected in the PCI hierarchy and bound to the cxl_pci
> driver. This needs to be independent of other modules such as cxl_port
> or cxl_mem.
> 
> CXL RAS capabilities reside in the Component Registers. For an RCH
> this is determined by probing RCRB which is implemented very late once
> the CXL Memory Device is created.
> 
> Change this by moving the RCRB probe to the cxl_pci driver. Do this by
> using a new introduced function cxl_pci_find_port() similar to
> cxl_mem_find_port() to determine the involved dport by the endpoint's
> PCI handle. Plug this into the existing cxl_pci_setup_regs() function
> to setup Component Registers. Probe the RCRB in case the Component
> Registers cannot be located through the CXL Register Locator
> capability.
> 
> This unifies code and early sets up the Component Registers at the
> same time for both, VH and RCH mode. Only the cxl_pci driver is
> involved for this. This allows an early mapping of the CXL RAS
> capability registers.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/cxl/core/port.c |  7 +++++
>   drivers/cxl/cxl.h       |  2 ++
>   drivers/cxl/mem.c       |  9 -------
>   drivers/cxl/pci.c       | 57 ++++++++++++++++++++++++++++++++++-------
>   4 files changed, 57 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index e0d2e7596440..679226023f0c 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1480,6 +1480,13 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>   }
>   EXPORT_SYMBOL_NS_GPL(devm_cxl_enumerate_ports, CXL);
>   
> +struct cxl_port *cxl_pci_find_port(struct pci_dev *pdev,
> +				   struct cxl_dport **dport)
> +{
> +	return find_cxl_port(pdev->dev.parent, dport);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_pci_find_port, CXL);
> +
>   struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd,
>   				   struct cxl_dport **dport)
>   {
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 7fbc52b81554..fe95f08acb69 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -664,6 +664,8 @@ struct cxl_port *find_cxl_root(struct cxl_port *port);
>   int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
>   void cxl_bus_rescan(void);
>   void cxl_bus_drain(void);
> +struct cxl_port *cxl_pci_find_port(struct pci_dev *pdev,
> +				   struct cxl_dport **dport);
>   struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd,
>   				   struct cxl_dport **dport);
>   bool schedule_cxl_memdev_detach(struct cxl_memdev *cxlmd);
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 7638a7f8f333..205e2e280aed 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -65,15 +65,6 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
>   		ep->next = down;
>   	}
>   
> -	/*
> -	 * The component registers for an RCD might come from the
> -	 * host-bridge RCRB if they are not already mapped via the
> -	 * typical register locator mechanism.
> -	 */
> -	if (parent_dport->rch && cxlds->component_reg_phys == CXL_RESOURCE_NONE)
> -		cxlds->component_reg_phys =
> -			cxl_rcd_component_reg_phys(&cxlmd->dev, parent_dport);
> -
>   	endpoint = devm_cxl_add_port(host, &cxlmd->dev,
>   				     cxlds->component_reg_phys,
>   				     parent_dport);
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 945ca0304d68..99a75c54ee39 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -274,27 +274,66 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
>   	return 0;
>   }
>   
> +/*
> + * Assume that any RCIEP that emits the CXL memory expander class code
> + * is an RCD
> + */
> +static bool is_cxl_restricted(struct pci_dev *pdev)
> +{
> +	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
> +}
> +
> +static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
> +				  struct cxl_register_map *map)
> +{
> +	struct cxl_port *port;
> +	struct cxl_dport *dport;
> +	resource_size_t component_reg_phys;
> +
> +	*map = (struct cxl_register_map) {
> +		.dev = &pdev->dev,
> +		.resource = CXL_RESOURCE_NONE,
> +	};
> +
> +	port = cxl_pci_find_port(pdev, &dport);
> +	if (!port)
> +		return -EPROBE_DEFER;
> +
> +	component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);
> +
> +	put_device(&port->dev);
> +
> +	if (component_reg_phys == CXL_RESOURCE_NONE)
> +		return -ENXIO;
> +
> +	map->resource = component_reg_phys;
> +	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
> +	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
> +
> +	return 0;
> +}
> +
>   static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>   			      struct cxl_register_map *map)
>   {
>   	int rc;
>   
>   	rc = cxl_find_regblock(pdev, type, map);
> +
> +	/*
> +	 * If the Register Locator DVSEC does not exist, check if it
> +	 * is an RCH and try to extract the Component Registers from
> +	 * an RCRB.
> +	 */
> +	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev))
> +		rc = cxl_rcrb_get_comp_regs(pdev, map);
> +
>   	if (rc)
>   		return rc;
>   
>   	return cxl_setup_regs(map);
>   }
>   
> -/*
> - * Assume that any RCIEP that emits the CXL memory expander class code
> - * is an RCD
> - */
> -static bool is_cxl_restricted(struct pci_dev *pdev)
> -{
> -	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
> -}
> -
>   /*
>    * CXL v3.0 6.2.3 Table 6-4
>    * The table indicates that if PCIe Flit Mode is set, then CXL is in 256B flits
