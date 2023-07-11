Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDEC74F36A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjGKP2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 11:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbjGKP2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:28:35 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F68170F;
        Tue, 11 Jul 2023 08:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689089308; x=1720625308;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BS2BcBsZ+cVYzT9qZED52WeCZjVtABRtASYJvgS1p4w=;
  b=gjeGy7vWAfijiN6EvY15OYQ3KSb8BTTp2pVUFGP08bUw1yQt0Pm4WduN
   759mV0wpmf2vBfdLTv/dNk9E8m+eoVfhauT4bHVfZTfZI3veRB91lGfIP
   tzWao7dYwroraj29RX/3+d6D2tT6/1WqZrHY8W5vNhggXVu/wuWDllfvk
   GBHxsoX87f2pC8BbxjUnQw2bUq7jiCp4JCWVQSLGmFgmNWi85ghRI/1zz
   nRhY+3A/ijamg/7FIyzw7kaBuaxaxXdFprXX4F69MhVLDk/3PpDdbiJer
   VyCK7QGGqX08/OyM2H83cMc4Rz1hpLzOMS0YTaWJfgdJjECwPxfRitley
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="367228987"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="367228987"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 08:28:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="750794350"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="750794350"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 11 Jul 2023 08:28:26 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 11 Jul 2023 08:28:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 11 Jul 2023 08:28:26 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 11 Jul 2023 08:28:26 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 11 Jul 2023 08:28:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AyPruAOIJRu1EVwdeQgDHTRCdDThul0yLmswrBwDaeSUklA4K6JAIJBr4JboMfK+X10zS+HheL7MoOrUJIGbjJTuCPQ7SUVx497m0EDNniRO4BbgUbzDv6z08fUbR5LH0BBZtEz5HD+4zCJvamsoINzY8SGjR4H0Tk5FhZCP6Ah1z9T1tJE9Eehq4qCzxVSUruH7f3nxKfbVRZsFv7cnrYr+nCXgQ0AUTTT3/FKnGPA4Yd/anDgmgwq88DHJ38wFGu7c2QPgweP9x6Fl434VXyZ2ZQ30cmfIjIH7gvpfaIZAPQXJ2dkctT2512awwYRY52h7QDP2E25seZBWbTj17w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fhRc+0MTz4cGsXSVjVJESGqLGPBk9t1VsK8PN25bLc=;
 b=MwTSlgtVPdkQA0j9KtnNh93+m4Dv1y/5ZqiWnvY8wz6kTaOmTju+mRXZbnOqGvxco27JWzAeFty26TsnGtW3Snayb71Y2zbqbXuQGCJFhxZ8Mju7UY8B+PVyMPV65Lpjt+vOb6mf0OOpcyIKTlLZ0vtEmOpED9Szttc2wuKypBS0EZ5hWaCEjctcK9vpF5AzjxE8WjUhyf/CvOXny8NgwXBRm8APaYzvJYNM+d3eZoXJoptf9BdqeUdQrZtjzBwOhm0pzT8lx6lN4Tj12tsbTwHl7aLM0R/GdjtJSo8S995UfDRdOyxpblzsBufaKgNBh+1cRF0b4JITgQfVVf1a2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by CY8PR11MB6963.namprd11.prod.outlook.com (2603:10b6:930:58::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Tue, 11 Jul
 2023 15:28:17 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6588.017; Tue, 11 Jul 2023
 15:28:16 +0000
Message-ID: <b17104fe-a743-e933-288b-9245887b3a2c@intel.com>
Date:   Tue, 11 Jul 2023 08:28:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.12.0
Subject: Re: [PATCH v2] ACPI: NFIT: limit string attribute write
To:     Ben Dooks <ben.dooks@codethink.co.uk>, <nvdimm@lists.linux.dev>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lenb@kernel.org>
References: <20230711093708.23692-1-ben.dooks@codethink.co.uk>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230711093708.23692-1-ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0248.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::13) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|CY8PR11MB6963:EE_
X-MS-Office365-Filtering-Correlation-Id: 27eabd39-36fb-4329-a0d6-08db822372c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DPb2qVxwiSEZB7tzxXiJzgLaWKGceuD7HOZWJJGGGNZhENO7+hYzATbWRSAXnVAWy8IR1O8mwXw3fyHtX8XsHGqKnP8A9N0c9qbRVP8tC9s3WvQRbX8WlfpE05J/x3hkL9MAJA4BKyqxArHkuLkUqwiAQ9qmJoFiWNPfwsAaizguLXdB2WoW1TDEX+KfFPcUYWmVGtsSXYylJwpD51J31MUCsd6V+esB0Lmp5MmhNS/Rbxwkzf0BDeEJhua5j0d4vkxziPElKEQTpuP0zisBjW4A58nevIj6RpB6YQqAF84Nh1jSrwFFucC9OliPveFp+JY4W2AqPZzDGChsspUGhiKhv/UrAGXMTPbMA8oDLlBBYwJ1oTgeJFvWxOZFvZ5LMHMai+fKbYbGnk/KBTi3EWnpRZDdhJa+JjUu5XNFh84UL5tRaVZ6/bwr9+I8ZIbgXidikdoDqBujx4/VT/eo2gTLkS10dbw6cR1h4aVUf8kVF+UhSbqRaPzlPpX56dlTJsPt3A/3ZJDoyDpe5Hl7JpksGkAe3i2VM7KXBhHh4npn9G9JLVq1W65V+4lucly1t5W3GjuU7GhdiPi3tuQ46gQg01azXVE64XMoligqaxR64GywvWGAqMV+1M4qIthRX7S1M1HiZwO11CFwOE8XAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(366004)(376002)(346002)(136003)(451199021)(31686004)(478600001)(4326008)(6486002)(6666004)(66476007)(36756003)(66556008)(41300700001)(66946007)(316002)(86362001)(6506007)(31696002)(26005)(53546011)(83380400001)(2616005)(186003)(82960400001)(6512007)(38100700002)(2906002)(4744005)(8676002)(5660300002)(8936002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkhFbUs4YTc5L2Jyd0Y2azIzU1RkZ0tXQ2x5aGRTVzNFcXFqTUxvOVdyNU1q?=
 =?utf-8?B?cForNi9GSW1YUzY1OGpJN05aTndyQnRMejNsZzRIbTBTaDMvZnNVZ3cvYWtw?=
 =?utf-8?B?Q1BDOHRxaEJZYmE5SWFoRDR6ajh5bk5CWUhVYTlSUXp0eXMvb2swNEcyQXBC?=
 =?utf-8?B?SzBPQnVsTzhsaGFaNFJxMEx2USswSnJmdjkxSFRzZXlZN3dKREZRUGRzeEk0?=
 =?utf-8?B?cDhvYUtuMmM4Z2xUTkR3Q3NRdTZtVlVwSURZYVVwOEExZXFKQ0F6OHBsVE10?=
 =?utf-8?B?bmR5WFhSTHAxTmNsMzBKSkt3ajhYTG5vS013SHoya2RJQloyWERaeGdmVncv?=
 =?utf-8?B?eGZOMnRLVVVMbmMvTWhYOTI2b1QrcU9lYUFhaXllbnNUa1FJV3BSZGVkWGFS?=
 =?utf-8?B?WjRFTEVMcTNFN1VIblVQUjNMd0dQc2JCNTBPa0JPRnRZSDZqMEdEM1hPZmxV?=
 =?utf-8?B?bjBMVmU1OXBOM3JDVHk4TDJjSGhqSGRYc2I2ZU5JWk1WTEJMcks4QUhEeTJW?=
 =?utf-8?B?L3ZEaFBHekVFcXhaQ05qV25HRW9zRjJiR0M3cHRGWlphUDdGMkU4Qk8yaVNa?=
 =?utf-8?B?WWQ3MENvMmpiYUFzTG5CbVB6clh4QWFoUW94T3k2TmZ6Q2NjYWJKYTVKbmJN?=
 =?utf-8?B?cmNYTS9lNXQ0M3hmRkJKdEdzNVlLQlFVM1VZMU92dWRZNzBUY0ZJQS9qaEtD?=
 =?utf-8?B?QUJNU0hITkpWeStCS2VDbjl1dW5JcVpmMlhXdGZCZVJYYStyZzFNMUREelMw?=
 =?utf-8?B?UWlEd29TTFFzc2tYNFpNaDNUMUNlbEFENExITHBzR2RPcGFML1Q2S2RUQXFT?=
 =?utf-8?B?NU1HV3l5UTJrMW1NM1RYRFRrWVdvUGEzNnJoU2hWdUljRWF0ZFVOK2V1YzJH?=
 =?utf-8?B?cEJaK0FtRUdEcVpmcmREek5YUkFOTGtybHgvcGczZmZvSUFqYVdoTmZqUU1j?=
 =?utf-8?B?MENJRDNTU2k4dnJBTXdBcDhxMFFEU2NBV3h6d1pCSSs0NFM4bUtxd0RVdTRh?=
 =?utf-8?B?aERFVi9DUGwzNTdqUE5SYmlaY1pjNCtSRDdpc1NmL3o1VUZMQTFCNEJDc0I2?=
 =?utf-8?B?TUc3TVlwZEozRWoyV0JaMGhuZzVxN09HSXRrMDI1YzJ5WDJmcmY3aHVHMmU1?=
 =?utf-8?B?b1cvUG84dllVZmk1Z1NDclpiV1l2bEZGTExDVDBMSGp6T0NJaGo1UkhaWDNY?=
 =?utf-8?B?TUFGckxHeWlWV3Nud1BsTDkyL1ZJM2plenlmUFEzeWx5VVZlbjAzT3IvSkVj?=
 =?utf-8?B?c0VzL29uNHlVa2N3dDRvdDRxbUdldjBPcG1McldiMTJqVlpIaGlaZ1NnZ0FY?=
 =?utf-8?B?VVlCNGJCZlZVRkdTRXpWQStXNllENnB4ay9KQVZuc2xWUmMwZWpjd3FRZWE0?=
 =?utf-8?B?bzNZMUhJRGFiWGNYaklYOVEyTG9wVG9xWGswa1BZNjhIakJWb29YYVp6TFFB?=
 =?utf-8?B?SVpJek1aUXJ0dFd5bkY0OEprVlRmVlcxeU1ZZDh4UGlWMU4wR1pXdE9EVitz?=
 =?utf-8?B?ZHNmbUdTTzlzb2R3ZDhxRWZ4U1Rhc2VISHFoazIwczFZMmt0NzFoNnhFa3FU?=
 =?utf-8?B?RTR5RlZuU3VYK0JmL0JNbEdhQlMwakVGK3JSaHNVSHFHejZHR0d3QmRYd3dP?=
 =?utf-8?B?cFNGRmhGMHI3M1NiRUNGZ1RTcHd5TVo4MXZxbHVZdGpZdWRmemdRSUlmYmdC?=
 =?utf-8?B?dE1XaFdna2RBVzhrSGpRbjFpY3RueW5mUnpwd3g1TXFaWjRzcXRZVnVCWXBN?=
 =?utf-8?B?djJFZDBZbDZpSXlLaHZlNmpyM2tJVnRWdktLTjRBYzdGMVR6Z0Y5a3hVTUNB?=
 =?utf-8?B?NWFxaytSV0NDWkRiMTZTUCtoZ0Ird2FkMW9SSlFUTzBNVVZvTkpHcDRGZ0JT?=
 =?utf-8?B?d2V2TDZ5Nm1pYkZMTHJ4R1J0Ynlsd2lnZENYS0ZtR1R1NmVuWFVkQXFjUThh?=
 =?utf-8?B?R1lKZGxoemhQcHRyN3hjbTdWQWRxcHNIcmZPZGpnbjRkaXJ1NTYxL0xaN25Z?=
 =?utf-8?B?akpZRDNldys4Q1Vid0JUekZISm9nMHdVdVcrU0pCZm9aWXJhaWMzKzAvUGdH?=
 =?utf-8?B?OXM3YWp5ZDV0ZEVRWE9OM1hucWYzclZuSjVsSjhKZFYrRTg3VTI5d3JJWDZo?=
 =?utf-8?Q?4z+hDf1NTpmdkyWjCC1NAWBcb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 27eabd39-36fb-4329-a0d6-08db822372c6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 15:28:16.7166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hUAWmpRDf+68cuAmaiW44RpVUnzZtjm50yhyTi8Uxqb5WwmX/e9P+oM7wGlRU+GQftM15LjJtMf1ys9qMCI/rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6963
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/11/23 02:37, Ben Dooks wrote:
> If we're writing what could be an arbitrary sized string into an attribute
> we should probably use sysfs_emit() just to be safe. Most of the other
> attriubtes are some sort of integer so unlikely to be an issue so not
> altered at this time.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> v2:
>    - use sysfs_emit() instead of snprintf.
> ---
>   drivers/acpi/nfit/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 9213b426b125..d7e9d9cd16d2 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -1579,7 +1579,7 @@ static ssize_t id_show(struct device *dev,
>   {
>   	struct nfit_mem *nfit_mem = to_nfit_mem(dev);
>   
> -	return sprintf(buf, "%s\n", nfit_mem->id);
> +	return snprintf(buf, PAGE_SIZE, "%s\n", nfit_mem->id);

Doesn't look like you updated your patch with your new changes....

>   }
>   static DEVICE_ATTR_RO(id);
>   
