Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92D173AD8F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 02:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbjFWACM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 20:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjFWACI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 20:02:08 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4634AE2;
        Thu, 22 Jun 2023 17:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687478527; x=1719014527;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IJQYGEuq9DQ7EP7ccqcf8TNfO+qWCE7fI07Mhr0pIv8=;
  b=FbnKNQSZ4ivgkNQGMq2HPfC0+UaLxbnfpP3OKC9XUcql+tbq3zZzrLv7
   xgG73znFAnoB784mZEhOpahBurrNG+YhmUM57dqiGLmhN8aCEjf/P067T
   Zv+euGRXoFwpA2nqtJPl6OSDohWY8gQazTy1r9WHtEqKjFyksZwYrSWhU
   /9uA/oPoIooksbsql2LLnMfIRu3rykav+w4EfHTt/h7BK/TzG1YD8SCO/
   0Qe/17FQQwz35dyjINdyqoEK7RDJt8ce+tCqUFvwcRRfffpEFDW/neAgw
   O74pQ2eAwi2Dr4+L4APvqGyurlGpaythEDhovtRBKOws3+pTr5k7Rx5xO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="426625194"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="426625194"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 17:02:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="780430654"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="780430654"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 22 Jun 2023 17:02:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 17:02:05 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 17:02:05 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 22 Jun 2023 17:02:05 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 22 Jun 2023 17:02:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FsNSdNi8gsRMKwJU3ICwLR1mJD17jR7ClE7yvVa/+IPWsOUCRdVQjjDAhodgx0lOr5WJUY/p3GSVVpelLo7oxiYKtG/yqEkBVbpgKgxZUR3RJNPVeRliaoPLSwU8JW/pX3J/iS0ieCA1TfFAtK1uwBNxQuvVjNhYRRRUgOd9sdWvVEWI2sa2jLE29i3Z0l+N93ovlrNvM38+7ahilsq61wazGOCsijonXqV9X1nGUN9gT411+7lrxgAXF/pewBdW+lOoZfSEnTl35bu3B45yEOePOVyYjRA2vgoGy/xdztsSA2hOItnmA7mwHEwFevmKCTdUmNZ3Du0xloGKmHHfYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y1qPFQFIEnlqeZu2/Xm2K3UNwyU97M3slhIpdYX0Fuo=;
 b=aHf4xXVx1wKdjTRwB8FLm0wEsfxel02zE6FiZzbSdeI2npI5SXbhq2V44l9LEG653Zuhbs02CC2oN1sjNWQyEMffoniBrfOvtbmMvHZG8Lw6JOyjDPe/xH4r8dhkk27ZUOJfcJ7AGJDgaU/01OKU/8lflB+CjKjKy/7nRw7XvCzPqusqQnFYfJPoCQWATsKoC0N64GWNjOAxgR4pVLsbsd4i56GEHu0iOxDPQX/EfadR9byzE8w1o8bat3MJpeFDdRLSBkdiyobOfoGAWliviIA7BKgeBJTrCK3NW5McdzZAz4ru3YytTvvOnQ0u1RbqRK/7H3E99OBMm36Wdeqp2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SN7PR11MB6654.namprd11.prod.outlook.com (2603:10b6:806:262::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Fri, 23 Jun
 2023 00:02:01 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6521.024; Fri, 23 Jun 2023
 00:02:01 +0000
Message-ID: <515a4fe3-9905-a7b7-c666-216c60069701@intel.com>
Date:   Thu, 22 Jun 2023 17:01:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.1
Subject: Re: [PATCH v6 16/27] cxl/port: Store the downstream port's Component
 Register mappings in struct cxl_dport
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <rrichter@amd.com>, <linux-kernel@vger.kernel.org>,
        <bhelgaas@google.com>
References: <20230622035126.4130151-1-terry.bowman@amd.com>
 <20230622035126.4130151-17-terry.bowman@amd.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230622035126.4130151-17-terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0108.namprd05.prod.outlook.com
 (2603:10b6:a03:334::23) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SN7PR11MB6654:EE_
X-MS-Office365-Filtering-Correlation-Id: 98a191f6-6a0f-4519-faf6-08db737d11d6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dTCXXixj6NVX2TX/iupsc2vX9Fk2dDNa34fn8+MOjUGslWXyJstC5zYwqryTx2hX1fi7qXhY5qwuCNiQOKka1klD17LNBAyfOHqcZfYOmz/EZuJuwZ387gA0mIgZ7EGqZj3fDmdC1SA+ZfQWLqBQ5eDVVs5InfeSYx253yIRjFFWsBBDyxNFfighWgX6l6MpF2/yqyAR5X1gw8zIXvfNljWiugaMHQ5G3L3Zt8lkvGBYYU3e3ET0O3Rc495RVsLF1Mg/0rUbmRMVTwFB9OV75UzXZlKlWOeS0IB9sUuCGv7LU4KWAR4Kf56BFmthc0utupfYOip+JPI8hJV+q18p4EDu79CkQ6sJCqfqSAd7Ls91XLnm+5dETxQ8Nvw5Jq5kjg+jNsXkRYqnxdLMMeoxTeyBqQx3n5LYDCSyzYWSPQyucU9Umf2ASmPyWGUsnso/vx5OPT3pNy2zIJcuTID1gcNd0IwYRAmHN7tXGlQIBunuZkeVjo/+WT3/BirmlwwnYJj4cQiJKHnWpqjOBJuxhfdiYJyQqK2zrnRSalpShwH9MAWrvuhR7cs1v3FBJA77Z6mJtU4KIJoyjaLn4bGcMH2BNyC1a01+RsVi/kPaJFEODSvR1L4zaixO1DTvHQzHox0y/EkU+jtEwCc8uP6UVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(396003)(376002)(136003)(39860400002)(451199021)(38100700002)(53546011)(82960400001)(5660300002)(26005)(6506007)(83380400001)(6512007)(186003)(2616005)(44832011)(41300700001)(8936002)(2906002)(6666004)(36756003)(6486002)(4326008)(478600001)(66476007)(66556008)(66946007)(31696002)(86362001)(316002)(31686004)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFVCM05yc3ZhNERpeWNNbWxhSm5BVDVhbGxmbGZMTnJpK1Z5aWYxRFlvTHRW?=
 =?utf-8?B?Z01uTjQrOEtFVkxhN2UvandkQXFRTlY1anppd01EYXhtL3JLWHNxbzIrZkRB?=
 =?utf-8?B?V3JSaVozK0JIcG9CcTFoQkJDcG84VXF4WU13ZG1OMExlTi9JU05uMXhPYjhq?=
 =?utf-8?B?TUcwRjhJRjVQVlQ2OHJheFYxY0FOQmVhclVLa0hsanJQeVdvSVN0Y2VWSmFh?=
 =?utf-8?B?S05VbDgzRjhYQUZYNFBpWGRDNk9nNjVuZ0piYzNScFQ4L3FQbTJSU2tnQU9P?=
 =?utf-8?B?VSsxZXlHRXJHTzFDbFEwQ1dsU3d5MzNrUWhuTUNTeU1yelhsK3FROFhiRmZL?=
 =?utf-8?B?bWxCcU5wczZIekxPWm5WSHZvaHdxUTZRRTQ1Q09VVkJyc3NmcDZIQ2hDZytt?=
 =?utf-8?B?bGphaEppM3dQeGZWZTZaWFRudTV6MUxJZ21mTWYvcFgvcWFIWGF2SmZ6VDNm?=
 =?utf-8?B?dmJMcmNpQ09qSEY0eW5TQnJYdWNDQWpydDZqUGNXMU9nZmpnNUVURmJUWVR5?=
 =?utf-8?B?aHlpalp5aFpHSXRNd3JlWmRWQ2lNOG1oVWxaUVJ2ZUdDREhjTmgyMzkvZDBj?=
 =?utf-8?B?OWhLZWRCN3pNSXNtQStzSXdiejk5NlhOaEUxa1RyY0pQNFVwRGJ6NXp0N1Z3?=
 =?utf-8?B?aUVYb3ZZWFhCMHdCdDdIa3dwV2hXTXl4REpIS2N0Z3Z5b1N4b0V3ZitqMDZx?=
 =?utf-8?B?NXVyWVZObHYrT2xjRDM1YkpSWWJUSGkrMnU4UzJ3NHZTR05XYkkwRm1QWHcr?=
 =?utf-8?B?SENCNVZtNlZ4UldzM2hta2V2N3NuS1ZMREJyZ1hZWkI0eEZJaTJGNVF6QVpO?=
 =?utf-8?B?c0xURFFqM0xIbkVENVFON0JEU1BoaHc2QVhjMDBpOHNKUEp4ZXhmd2tpdVFC?=
 =?utf-8?B?Yi9qZVpjNXgwa2pneDVxZEpobjNzemFvNzZmbHd1bjhLTzV4SlhEb3k4alU2?=
 =?utf-8?B?am43TDFXbDNHZmtyUFFSN2t2VHByN3dTY1FtRTVoZWNiL0RwWjBTZmRQQTQ4?=
 =?utf-8?B?MExTZzhTakROVFNZdXNBT0RLWDZjMFl0TUlHczZZZnk0OVVHRjBsZ0taUlVY?=
 =?utf-8?B?R3F3Zm5PbjlXUWcvRlRxWWpvekVldVVyWTFZSUNLeWlwVlRsZ0xTNjBleEtv?=
 =?utf-8?B?dTB4bzJkdjhnS1dWMjVEelJDQWNmUFFGQkVtSUxYZlNiL25hNkpUdzdtTXJD?=
 =?utf-8?B?QkJLUm5tN1E3Q2VFdXE5bnBEd2NiaXU1cWtZd1Y2VVlqRUJlYWhjeDFqaC8v?=
 =?utf-8?B?VUg5MUoyN0tvSFhWT0ExMWxsN050TVdvZmlGYVJnMzBHbTVQRVJpcE04aUgv?=
 =?utf-8?B?Q1R2TmRLQ1VNSFFNZmFlRXdSTGhyWVVxWGpKUzZBL1BMcHVKc2dwWkZIZ2l2?=
 =?utf-8?B?NVN5WFhORWFyUHp5ZEZYZFVLTUNtYVM2d252dWVicm5qZkRSelgwbGVxM1dI?=
 =?utf-8?B?dWpCeC83UCsrRDM0OGFkRXRvTmtxaVN6anVvMEVsT3ZkZ3pvdVZEb25Zak1x?=
 =?utf-8?B?S0JnSW93RHBmdmNYbytPUHVNTHZNdUx4UVNUNlErZTNtNnV5ZkJlZURaQWdh?=
 =?utf-8?B?cXNVSGw1ekpWZmU1ZGlHNm5kSjRBd0ovajVxOHlWSitMaXV2TmZqNlBNbWc4?=
 =?utf-8?B?OGNyaWdYaEFxdHREL1M5ZEV2b0lta044TDM3R1o5ZHNlZTBBblVTUm1Icm1W?=
 =?utf-8?B?ak9TaFZCRjl1cUtXYmcvb0lHM09lZ2NVS2Z0YVRERm9lSjFNOFlGQ2V6RDh1?=
 =?utf-8?B?c0MveVlJaDdJMHJIcVhuNHF3clpXRnJFNklEdmtUTFd2bll6LzJmRFhIK2VU?=
 =?utf-8?B?disrc1ZXS2UzYVpMckVaVFdXL0hIeXp1WFIwTEhtSnh1alRQQ1lrUUJDbjRs?=
 =?utf-8?B?Q255Wmd4aHM0ZEZqeHlvTkRRemtOOXJDd2ZZZDFpMjNxVTl1UHM4ZFZaZmFM?=
 =?utf-8?B?YkVadGNRQ2hoYnhvWG5DajlzUWtKUHJGdjIrWEtjYVRGVHJRNzhhbTNpL0xi?=
 =?utf-8?B?TVB3cEh4c1NYMk4zTk4wZnNxM1cyTkllTm1PWGtkMjJEeUlRSnhLTXZjK0Z3?=
 =?utf-8?B?UlRsampLOTF4NUkvNlAzclVYdVpIejJNbTV1NHAvbERlM3k3ZldMZnQySVYy?=
 =?utf-8?B?elE3dXpFVHZLdGFQUURtdlkyclFLWTR1K1VjZW9RaFQyQk5COHl6TmRWZklN?=
 =?utf-8?B?eHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 98a191f6-6a0f-4519-faf6-08db737d11d6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 00:02:01.4223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bLq0GRDMkSWJyyt5jldIubHoXosI21EhRqNotZO7VTG2OeUqJB+aAIuukRAx+14XlUYtpye7fH43Ztcd4QpiUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6654
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
> Same as for ports, also store the downstream port's Component Register
> mappings, use struct cxl_dport for that.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/cxl/core/port.c | 11 +++++++++++
>   drivers/cxl/cxl.h       |  2 ++
>   2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 2e239fd33df9..45fe7d89f7f3 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -710,6 +710,13 @@ static inline int cxl_port_setup_regs(struct cxl_port *port,
>   				   component_reg_phys);
>   }
>   
> +static inline int cxl_dport_setup_regs(struct cxl_dport *dport,
> +				       resource_size_t component_reg_phys)
> +{
> +	return cxl_setup_comp_regs(dport->dport_dev, &dport->comp_map,
> +				   component_reg_phys);
> +}
> +
>   static struct cxl_port *__devm_cxl_add_port(struct device *host,
>   					    struct device *uport_dev,
>   					    resource_size_t component_reg_phys,
> @@ -988,6 +995,10 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>   	dport->port_id = port_id;
>   	dport->port = port;
>   
> +	rc = cxl_dport_setup_regs(dport, component_reg_phys);
> +	if (rc)
> +		return ERR_PTR(rc);
> +
>   	cond_cxl_root_lock(port);
>   	rc = add_dport(port, dport);
>   	cond_cxl_root_unlock(port);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 37fa5b565362..b1adca9b27ba 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -595,6 +595,7 @@ struct cxl_rcrb_info {
>   /**
>    * struct cxl_dport - CXL downstream port
>    * @dport_dev: PCI bridge or firmware device representing the downstream link
> + * @comp_map: component register capability mappings
>    * @port_id: unique hardware identifier for dport in decoder target list
>    * @rcrb: Data about the Root Complex Register Block layout
>    * @rch: Indicate whether this dport was enumerated in RCH or VH mode
> @@ -602,6 +603,7 @@ struct cxl_rcrb_info {
>    */
>   struct cxl_dport {
>   	struct device *dport_dev;
> +	struct cxl_register_map comp_map;
>   	int port_id;
>   	struct cxl_rcrb_info rcrb;
>   	bool rch;
