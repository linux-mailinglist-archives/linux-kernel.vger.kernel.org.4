Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D28173C2BD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 23:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbjFWVYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 17:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233022AbjFWVX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 17:23:59 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186BE10F2;
        Fri, 23 Jun 2023 14:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687555438; x=1719091438;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/6/EOIEJOx3E695s36CiZf4hzH+40ZiSYwtAxtCqQIY=;
  b=d1IA2K+XqmEftPB0wtXyGbERtKPZGen5C3GBtVDNRTJjyuCiYi9qB2+Y
   XDmaE3Dgu5Hpb+BS7TMFyPq+L9Q2HxRogs1EROSB2KBbyFXATPZyFJ0F+
   AzElXgoObA28tdsu7Pj0McZ8FZEDiW9NjBXsdqZeUxLVz47MkblDMuPDO
   /LJG8DbFH09meCKCqg13FdGn6LA5ng9UKoHaS7o87jJm0gb2Ee4walDdK
   1rYQdI6YN7vPvOyNhk8oOd8X6nY+bNzzBK1MI83Xols+bQ3bNt4Jhum6C
   U3nQG7/qjoGlRpv0OEhPyqRnEJoaWAxKoxAu2+QA+T3tXUNvJh9osQkfs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="364309438"
X-IronPort-AV: E=Sophos;i="6.01,153,1684825200"; 
   d="scan'208";a="364309438"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 14:23:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="780733267"
X-IronPort-AV: E=Sophos;i="6.01,153,1684825200"; 
   d="scan'208";a="780733267"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 23 Jun 2023 14:23:57 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 23 Jun 2023 14:23:56 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 23 Jun 2023 14:23:56 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 23 Jun 2023 14:23:56 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.45) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 23 Jun 2023 14:23:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dxcIVVHTULUaPcR6EfgHDCRNAoZ2ynIrSetBYRi1WOjoAf30Y/rTBFdbcf+LsGeuDbd9yx2MAaD9+LvBX5f84k0Yacd0Qxj+wBJpwV34iIXLD4OMjTU7bUOqDs+Ci6U6pbKkCT89h9sAGsN8Z6t2PxCkZAoUf8B4opprA89i4LzAYyU3DDiFLPV2uyPWI+Vx3KXBQ7JVZKH6ta2pqp/7lz79glKMOerSCL5utowq9f002yhWaZQFASXm03lmbJA/Y//84erofyQ20kTOvnBToCcsqVXkeJ/hOvAL5u50eP4Z0GRlSJSzzS/UUR0YHgZCfMiOgqU+ripEvYPfEdqIKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=shflvSVxyUwOAg7TVe/2jm3cM3951pfPKglmVfuEsks=;
 b=BYp+QKGaCh8fIqtMO5cmRvL0OYfzVKn86l6ebKYPx6VZKdCI2H5JFADHLRV5LbjcvjIbflFilRn53rIHtZ1h5E3tFCJvHSSubTnl5aFRA/k2AeeHpimrIHNe/x92vL4XLGeh1Y4sXX2/HPji70tU2luEqyL1/62IqgjoE02p9sVpsm+iWGfnHp6hS4xe8d2lzLw+hUQaEgN4zK3BR9UaTdZ2sm+Rogdjn1kIzuteQX4D6WmAQzLeuOUKWDHogC2CPUnBRKy4WBbr+SNLWubfu18xqPKr5M/1ZOoHzCHmB5jObW6Cbdqh6+9x2psOnbWTOfc8UDT/C6/8qAzY3WUQ+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by IA1PR11MB7870.namprd11.prod.outlook.com (2603:10b6:208:3f8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 23 Jun
 2023 21:23:53 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6521.024; Fri, 23 Jun 2023
 21:23:52 +0000
Message-ID: <56e7a52f-ec36-9914-fd9e-073e0c976da4@intel.com>
Date:   Fri, 23 Jun 2023 14:22:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.1
Subject: Re: [PATCH v7 20/27] PCI/AER: Refactor cper_print_aer() for use by
 CXL driver module
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <rrichter@amd.com>, <linux-kernel@vger.kernel.org>,
        <bhelgaas@google.com>
References: <20230622205523.85375-1-terry.bowman@amd.com>
 <20230622205523.85375-21-terry.bowman@amd.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230622205523.85375-21-terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0193.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::18) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|IA1PR11MB7870:EE_
X-MS-Office365-Filtering-Correlation-Id: 47d41640-6d41-467d-5e35-08db74302480
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4+iDXNRL9LTu2tzA6LVIOWTsCaxCF8A+ah+ixUgYhWnhmXwmsiSJeULP4ZJpI071JI/xg5EfjHSi5X83CpGQSYx7GVnqEC2tAj23BNOeeHWvmdy0b0bFdzcoR4ZFnT+h0ka5iAUbeC6tiy31IEvMJuZCEWdCcZyIW/ip1TpilGv1v2MppUKUB7DtrohzdDE7Tecv8IehfSY4NABMC5A2oiLBqeqsG00BetKwpv7a0NmY5evRe9dcILmGmsX+6md8qdNOVTTUy8aEChVnG7FmE/TrXDnAg4tc1khiT8mWjR3dsdpd59HEQnFhj0BgyEp7kvlh/fIhN6I5/e1CTENlfh9P7AqA6SrUTAnNWwQ8FiwfHCh6rRlB8aZYvGTEhJHFdiGy7e2j+7PttolY+Wnd6vIrEZpdxI4NZDzjjUYWwX+iAmD9DUxqNRO4b1yrwu6yCrIn6cZ08ffCvKFRbTDDLHIoxRcX1uZ72nZ9tbK3+xkEFRSVs/Er9ESVhelWlF3cZcDJRPO06/KRS+MSq/jqVpdZfYvLSQomtPAXPfepnDEA7mnE2BJTGxPwQdHRNINYLYwajD7plufMDFQXhmoxJB7c3LgPa11+Fp90tJfY4AsDoRkekck/7KYCQxrl+buVanKdpJCmE5Wpr5kyRK8f0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(346002)(366004)(376002)(396003)(451199021)(2906002)(6486002)(82960400001)(6666004)(38100700002)(83380400001)(2616005)(6512007)(6506007)(53546011)(26005)(41300700001)(31696002)(86362001)(186003)(478600001)(316002)(66946007)(66556008)(66476007)(36756003)(4326008)(44832011)(5660300002)(8936002)(31686004)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHA0MjY3S0tPMzVES051QUtBTXRvTVB2RWU4WnlRT3FtdlZUbW80ZnNhUUUx?=
 =?utf-8?B?Q1NXaWxJc1hQeTFyaDhLWW8wVGVPNjFlYnVNREptQ0crRWJ4TGs3ZDBxamI2?=
 =?utf-8?B?MDZIejdzbitEZHJudnp2cWFjb05sdnhSak84Rm1EeTlnRFlLQWoxRnU0VXVh?=
 =?utf-8?B?bjE1STNTeHliVFVuclBXTldBU3VEeFNQa1N3SWZlTVNMeFl1dTB0OGZzcXF1?=
 =?utf-8?B?NDJuS0I0bU5YS0w4OEJTak5jc2JWN0JUVmY5ZmpUOW13MlljR1NYdlRZS3hM?=
 =?utf-8?B?bElqTEhPcUtOeVNya0E3Y1RIUHdIK2RmZ1pHWUs3WngxcW8rVGpMWElsZkdR?=
 =?utf-8?B?aGd5RXZKLy8zYURFbGxMaytNbDFyWkI2ODNoWXJvQlgxaEd4a0NLMDlBZGR3?=
 =?utf-8?B?ay94T3kwR3U5OTlVcysxR1pncEZNQThJcGJGbzBWMWJ2a0RJcHhuUDl5Qitq?=
 =?utf-8?B?M3AydEVsRTJ3QWRyeUVUVDJmcWJXQ0F1VW9CV3NnMFNzU3Z5WndsTTlEdDlF?=
 =?utf-8?B?YWl1LzNaM0RXT0Z5OGhsbnNVcnhUSlpTMUEwa1p2VTBPZ1UzMVBmRHFpMTF4?=
 =?utf-8?B?THU1NlhBUDRDNHlodkF4aldZbEtwY1QwZkF6QkNwdEpKd0hrTEFnMTBHOUNI?=
 =?utf-8?B?Mm1PblFBS1lQYXBrMER5UmhWM2hyOEtGMUVtMmI5aVljZE9za3FvTVNpckRH?=
 =?utf-8?B?QXBqWGxCQWU1NGQ0cnFINDFBYW9palVKL0tzZTlqNEVqTmVUMWR0RENOZk5J?=
 =?utf-8?B?dHlBZmcwbWJjcFFTeHhUOU1Uazd2dVJaTjBBdGNkOUMzcU01djNvYnZhTEMv?=
 =?utf-8?B?clo2RCtKWUxHZ1VLQ0Z0MTZwTkU0cS9LNXkrYkNEdmhTb3FIeUR6ekFkQzBV?=
 =?utf-8?B?RVNhdXBYVEhacGI2ZFFuK040N0c0Q1RBR0lvaXpER0xmcVRVL1VlZjFYZmwy?=
 =?utf-8?B?RzJhT1Nta1YrWWc0UXdYYkhMYlVQVXlBN0VUM0tLd2h3NENYS3NXdmtkdnMx?=
 =?utf-8?B?ZGRVNkxIUEhoMExoMDgyTjB6Q3RKUjFzaWxOLyt6SEVwY1hZL051aTNFdWV1?=
 =?utf-8?B?Ylp0QmRDTXpheDZlY3k2WWc2ZlZTbjVzVENZSVdIR1F6SjU2Y09aSUtFQ1Vn?=
 =?utf-8?B?TGl1M1plQlFuYWFHYVpBbVhTUzd3M0xGUlhKOGxiOEJhNTBxUUNFNDdoZnA0?=
 =?utf-8?B?Uzg5WDNaaU83Ykhnd0pDWUorTGZ2WEpzbjlNNXpnZnR1WWhxRkxQWmNPODY3?=
 =?utf-8?B?QUlPcXo5NU5PKy9qb1hCYVFwZnpXNDBxUmpSSHhhS3NYM2J6WU54Z3V5UGk1?=
 =?utf-8?B?N2ZaZWlWemgydXE3NjFudTdETnBJaytkaXQ1WkhKcTJmOHJZam9YQmJSWWVO?=
 =?utf-8?B?QUl0V1d1NnFITDBZSXRXOXpzQldCWWNjcEZTTzlOTTFjVXA2SUJ1aFBPcHZQ?=
 =?utf-8?B?UzFmaFplUFdqaU9jWTQvK2l2T3RJc1dNOUJsR1pISkhuOHh0SnpBRUt2QkpC?=
 =?utf-8?B?OVVGeDE5MktRR3RYL2FyeTNtYWRnY04xUElLdDdWVDlCTGFKUDBBMGFKRHpn?=
 =?utf-8?B?RU5RTWIvanBYZFBBNG1aK01IdVczYlFHcGl0bHhGS3h5UHpFdS9QUmx0S0RK?=
 =?utf-8?B?T1kxamgzTlNaUFdVN0ticEo3cXhaRFUxNnMxWHlCWTZUTE1rU0hKMW5RZWE2?=
 =?utf-8?B?dmdyb3ZKL3BycjhDYnpHcGoyOXZjK0F6UnpkdTgrazAwQkRReWNWTURVOVlV?=
 =?utf-8?B?cDZETEdUNFdFTnRLTEt4WFNpNUh5YkJnZEV5TCt6bjhNUDg1akl3VXpKaWJT?=
 =?utf-8?B?aWIvdmlZTFF5T0prK0hUT2Z0b3JTTFFLZU5Gb2FHeUp6SmVuVzNuNWFXY0dn?=
 =?utf-8?B?TDdFYXV5ODg0M2hsUFdQdzJpOWxrYUxxRU1JN2ZuSWlYbzFENldtMkZDWVVu?=
 =?utf-8?B?YndqaXYyeGNPcmMrMG1uSFZPaitldS9UakRTRE5DRmY4NVU3aUNaVExsY280?=
 =?utf-8?B?ZlAxQU53eU9jcGpUcVpMUzNqcHBickxSTTV6Ly9QQzJqejh5c2ZKUVYrZUNI?=
 =?utf-8?B?REN4di9uQ21PWFQ3VFVqRHc3Sjl4NjdYcFA1WXhIQytwUkJpbnVCaVp5MHNG?=
 =?utf-8?Q?DxahDfE4bCUTJXeCGqgKyWCMY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 47d41640-6d41-467d-5e35-08db74302480
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 21:23:52.4487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /eVWqlMmHW2F6VABW1Disk5qLOZC9kri0PUQERV/BjR9UsPJd5/0bvjxzdNmq2V/tL5afNlE5d/FGsfCbJGkLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7870
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



On 6/22/23 13:55, Terry Bowman wrote:
> The CXL driver plans to use cper_print_aer() for logging restricted CXL
> host (RCH) AER errors. cper_print_aer() is not currently exported and
> therefore not usable by the CXL drivers built as loadable modules. Export
> the cper_print_aer() function. Use the EXPORT_SYMBOL_NS_GPL() variant
> to restrict the export to CXL drivers.
> 
> The CONFIG_ACPI_APEI_PCIEAER kernel config is currently used to enable
> cper_print_aer(). cper_print_aer() logs the AER registers and is
> useful in PCIE AER logging outside of APEI. Remove the
> CONFIG_ACPI_APEI_PCIEAER dependency to enable cper_print_aer().
> 
> The cper_print_aer() function name implies CPER specific use but is useful
> in non-CPER cases as well. Rename cper_print_aer() to pci_print_aer().
> 
> Also, update cxl_core to import CXL namespace imports.
> 
> Co-developed-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
> Cc: "Oliver O'Halloran" <oohall@gmail.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/cxl/core/port.c | 1 +
>   drivers/pci/pcie/aer.c  | 9 +++++----
>   include/linux/aer.h     | 2 +-
>   3 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 449472fb26a8..683f40e98119 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -2058,3 +2058,4 @@ static void cxl_core_exit(void)
>   subsys_initcall(cxl_core_init);
>   module_exit(cxl_core_exit);
>   MODULE_LICENSE("GPL v2");
> +MODULE_IMPORT_NS(CXL);
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index f6c24ded134c..d3344fcf1f79 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -771,9 +771,10 @@ int cper_severity_to_aer(int cper_severity)
>   	}
>   }
>   EXPORT_SYMBOL_GPL(cper_severity_to_aer);
> +#endif
>   
> -void cper_print_aer(struct pci_dev *dev, int aer_severity,
> -		    struct aer_capability_regs *aer)
> +void pci_print_aer(struct pci_dev *dev, int aer_severity,
> +		   struct aer_capability_regs *aer)
>   {
>   	int layer, agent, tlp_header_valid = 0;
>   	u32 status, mask;
> @@ -812,7 +813,7 @@ void cper_print_aer(struct pci_dev *dev, int aer_severity,
>   	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
>   			aer_severity, tlp_header_valid, &aer->header_log);
>   }
> -#endif
> +EXPORT_SYMBOL_NS_GPL(pci_print_aer, CXL);
>   
>   /**
>    * add_error_device - list device to be handled
> @@ -1009,7 +1010,7 @@ static void aer_recover_work_func(struct work_struct *work)
>   			       PCI_SLOT(entry.devfn), PCI_FUNC(entry.devfn));
>   			continue;
>   		}
> -		cper_print_aer(pdev, entry.severity, entry.regs);
> +		pci_print_aer(pdev, entry.severity, entry.regs);
>   		if (entry.severity == AER_NONFATAL)
>   			pcie_do_recovery(pdev, pci_channel_io_normal,
>   					 aer_root_reset);
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index 97f64ba1b34a..8f124b904314 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -64,7 +64,7 @@ static inline void pci_save_aer_state(struct pci_dev *dev) {}
>   static inline void pci_restore_aer_state(struct pci_dev *dev) {}
>   #endif
>   
> -void cper_print_aer(struct pci_dev *dev, int aer_severity,
> +void pci_print_aer(struct pci_dev *dev, int aer_severity,
>   		    struct aer_capability_regs *aer);
>   int cper_severity_to_aer(int cper_severity);
>   void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
