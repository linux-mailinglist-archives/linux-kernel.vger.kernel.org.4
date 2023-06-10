Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0079972A8A4
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 05:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjFJDKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 23:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjFJDKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 23:10:01 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE103A89;
        Fri,  9 Jun 2023 20:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686366599; x=1717902599;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uQ4Rr2/wl4qg95NcbsPaMJ4U6eOPNM8Bnx1b6SDe1oA=;
  b=V1U8O2f5eHHX0ykepTd656ZczR8pYx7b46THv6gwKx4RD6gOx3aShN5M
   H7QY7BWTHfCXy/5rJPDdf9C6hJtLaQiJPJPOYUgkwu+25jF+je8CiMQWq
   uwNpYTweTlnZYMRyCNHGQyQ0NgORNKkJQAmjQAzCsOg/i+l49MD583EJx
   FswEDoMupEmSPW9Vi7bpD/9uFrA2GOvGWsXpnK9F4fEZ+B2Q9LN0llxFu
   siC/L7kQ3Kvtb/Oea+jxez4U5tzjW6B1JB5JgkxUarraaEJxjiY6R1ZOd
   h6fGF3yMI5pSDe89seTMP5gS1ayHY/S3JMSuCZi0a028q023OKIMg2C1d
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="421318389"
X-IronPort-AV: E=Sophos;i="6.00,231,1681196400"; 
   d="scan'208";a="421318389"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 20:09:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="713722030"
X-IronPort-AV: E=Sophos;i="6.00,231,1681196400"; 
   d="scan'208";a="713722030"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP; 09 Jun 2023 20:09:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 9 Jun 2023 20:09:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 9 Jun 2023 20:09:57 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 9 Jun 2023 20:09:57 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 9 Jun 2023 20:09:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OjJk3hhFOiHd7UoEF7MGctmWGk/jISLuvEuk7ViJkRGtNh//eh7EyKYqs9+8rDrpankJ5gsXQJ4s4mEUq/D5CU5y5Y19s8XPBz8+fMP8IiKq3mCqAFK2m08yw9mokbOoGLKLqBvj95AVJxa2QKvCEssFu6Ur6tln9ZJ8EMmHxOREfY3nAgIHtHg9xjmF6qXU19p/ibaew6GRfsJ3pwKLx9AwtilK5hPvH1nYXns9xj+EArwu+Ptyz9ofyEcqwt/4umJ/5vXyuR4ZQwkdWVxD1LusRcS1VGt7CFDDuzhvaHWcAQovJVFzRllJbSwwGtZCqeWsUijFrRU4EXSjIbYeZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQRVoBupxo3ZrUk9KZSf+22IsOxBqK1YDkBNG8EAP0U=;
 b=TjIVdrG1kqDeNiuXuHTSCSINukCSpb5hZ6Qpp5ghSd8MlJlssZQGHJKR3xXWDvVMpBoegcs3B8ikifKiqTTPNeuaghzn4+1XSOYTwxxZO9hw407s6Ycpg5XspvqlRekl1yxt2/xck9hUGQVuT3b8vv03345oVsPcl9s8byeK41dCLpMwyFB6ByH8pPC8RmZ0eqZQgusBznwVDiyZrmCLySXuVukQoH9C1z8kI9MbEGkg4rLq8PAWaOZ9GeLJtSxbTyF9yLpAyasE6jxNc2l5CI9cQEVnIZyTL1rUZROmfu3WVCJkmGNcWyJQwe49q2PGj+mUB/Z8AGzEczNmVl9o2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB8363.namprd11.prod.outlook.com (2603:10b6:610:177::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Sat, 10 Jun
 2023 03:09:57 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6455.030; Sat, 10 Jun 2023
 03:09:57 +0000
Date:   Fri, 9 Jun 2023 20:09:52 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: RE: [PATCH v5 19/26] cxl/pci: Add RCH downstream port AER register
 discovery
Message-ID: <6483e9801c0ae_e067a29432@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230607221651.2454764-1-terry.bowman@amd.com>
 <20230607221651.2454764-20-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230607221651.2454764-20-terry.bowman@amd.com>
X-ClientProxiedBy: SJ0PR13CA0173.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB8363:EE_
X-MS-Office365-Filtering-Correlation-Id: 79698fba-2ef3-4d7c-85ec-08db69602b00
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vOIflH1J2gbNiU5vBdyNKePFkJzbk1jdANPu2M9HF5yNVvcbIh1JCACIdJWLw9fJb79SKsMHN5Jimno7zikTHewYMgPJktB7vBA9zSGawtKdTuda3eH9DcGoUbwyJnJsIEzxpPkdK/jsU44PjEmGnMg44kdqdnpSm67egGerNFT3mVeeT3ZGAonVgLWTZB1hib25wYmO1dUYnQgqwP+3ioC7fmSoI1xnHjPKjooUl7bR4fKsWYhnbLHOSU/uQQxQVQSQCbJTOSpS4rAjk0xPhvT3rDckkXi8UzOtduNq1QJrZ1ePmYei8qu2GogmRkN43blFE4c8PedMjO0PYbomE3mdKHN/v0g5HqYv73hBLMtQTZ0oiG3iSA2oYj8Mmj++zRCk34dWgN5sAWYFazUkX5iXNSSlOjuduw/vl5I+H54j27tENdQwZLoRmCVUhpFGjOENcDZVqFZNJQYFTj2CxKrJalsoNlKF3BWpmLdMWFtJrnaHFgRFi3UySlFmE5ixmGPl8ZTJQbWnxgOJZQu9cg32XDAdVIWSwiu8BW/8pDZ92QqqE+MjmDNJ3xaKbcLO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(376002)(39860400002)(136003)(346002)(451199021)(2906002)(5660300002)(6486002)(86362001)(6666004)(478600001)(41300700001)(82960400001)(6512007)(6506007)(26005)(4326008)(316002)(38100700002)(9686003)(66476007)(66946007)(66556008)(186003)(8936002)(8676002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MA8p5fQUHWzMp8PThSaTCv5dv3oTz9ui1vUxkaussSJpyN1cJKON7zdWnmh0?=
 =?us-ascii?Q?lMCTmsNCz/OXT2jUKuvch5q8vANCYb2f6XhvIzALn9/E9rDURt3cDhqICB/c?=
 =?us-ascii?Q?6OdP3CPQ9hu7mvmUaQmpf7931NjLHe9JzeHIN9qaDqpO8TxXQnY4BQvhWE1n?=
 =?us-ascii?Q?mWeQnZMVFVF+rvtXunJbVglkrBaDp65eDhxKkg2QeVG+neLDYqozfRX1GSlZ?=
 =?us-ascii?Q?NTyBb3xp57Vh/HDOJiBEkId5trrvQohEtUSP/hpDxqyzZA94F7PGs1IdxTmV?=
 =?us-ascii?Q?zraOS++F6fANwrLgpdEYRKorniuJ9AvPcuFJOc835RZcKctq1wyJBa8xDIk6?=
 =?us-ascii?Q?FErD6NkXuJLEvsfLupc6yc+IalgIMKTZZZxcxBEVUxz4NfRREnIkaZUWbVm/?=
 =?us-ascii?Q?xC/Pf8LbruaxKYYnRRrV3jCASHDhNhTejkBaD24eZz+IJs5Hsz5LmQQPpPMy?=
 =?us-ascii?Q?2yBQOB82cGL1fD81CwNizaE7JftiaTJQINo3i3lIGcxmwWUrxIWyrwHfoSFB?=
 =?us-ascii?Q?Uj50FLC03ioDSCbLzS1TncCl8ny+LanfZbbRzAqq9QzLV72Ln3Z5ocdvBL/a?=
 =?us-ascii?Q?ZpEkt4z0BKSWGonD1XekXZw5ihwgXXHoftnXaWIuANVKTjqhJPuBJvM8pN/z?=
 =?us-ascii?Q?gC3HeBRxMcF0LJlYYEeFuc4GEBqKFl29A/V30LVSS4092I/u5QbFk9B0INhr?=
 =?us-ascii?Q?qs0GJzgvuhzXWodB2a1blrKQ6OKDD9kbzLJkp2neh0j6QwFUdnYvPPgKjccS?=
 =?us-ascii?Q?Og/Jr7NY6Zw8vBbmP3p8CsO2nfeTbX0kpCuvytW8EWNaet/Sa1DE0pmbGabZ?=
 =?us-ascii?Q?gnfj4gr0wGzFW8HotdqXa/Y6i+uQBXjOi+9iuW+alu9cuzf5JJJ11qRuRtZE?=
 =?us-ascii?Q?04kx/pjVJ6V7MyCdery1CeFTIG0Nf+WcYHMA4Vsn3eu7mBFxSZuD7dpwotaB?=
 =?us-ascii?Q?g5/Qto+JuNwH9lehzmBi7kTtlCZL2gduHVNyJEZhPQ3GnCgGAOgYZfjbR0WI?=
 =?us-ascii?Q?eFxr/C+XUgNqcFI4sD+sVnxrOPRIit0ueikNfVsKtTEIShnc5v+HQPxxpHNE?=
 =?us-ascii?Q?fbGI9ZDViynxLDAJEPMbVdy4gK6APjBVbf3BY09k3UuJ2EkgBboloT4BwK9F?=
 =?us-ascii?Q?Lg/f+SrtdddwplriwVYbORfcyJN8PLWp0yW5HiVF8lLz2jp/IfvWVoJF/FkI?=
 =?us-ascii?Q?CNKMztkZ473O1TxUYi6o3cNmt/1j8lblxdZnrTurCZ2BmSaqm9jTKpbYP20o?=
 =?us-ascii?Q?EalWi0gh+bIU8huHvoWgx8nH+LtkLDngcoPcYNuWm5X+f4QtiZdzJCxnCuI3?=
 =?us-ascii?Q?7nKM7JB5A4MbU23kvhgr5RGriguSQeZlhlrRELvFzN+DOWbBlauHJtqpRgcG?=
 =?us-ascii?Q?IVfuoSG/QEVsx9pFRdxhBjDMQldPE6EIdbQ3T7Uh+dlleE5eUpvG+/FXFvcU?=
 =?us-ascii?Q?ABAHbArYFDQYxz8LPlE7c3zqxuf8dmMD5xATv0JfEgPpDVebR5QYt+tOvYRU?=
 =?us-ascii?Q?xSxCPJ69JLDpieLqJ+akPBhsrzbf2KVTpU01gyE9XHihe4uN0GYg7Srw7V1Z?=
 =?us-ascii?Q?ep2LJGQt6PS4rkcYPdK670WDS8adDc89mk371NQvNOt/6JAi6sbSAJYIcbMX?=
 =?us-ascii?Q?ug=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 79698fba-2ef3-4d7c-85ec-08db69602b00
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2023 03:09:56.6034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HLDCa7KjRD2jqfbobo5V4szLtj6qb6vpfEvSYQ04wnlehcevIpg88Z3IL3VcZDTHKTMXBQi76+Da0VQS/y79dxq8oVJbTpB6vhc3Om+QaKA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8363
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Terry Bowman wrote:
> Restricted CXL host (RCH) downstream port AER information is not currently
> logged while in the error state. One problem preventing the error logging
> is the AER and RAS registers are not accessible. The CXL driver requires
> changes to find RCH downstream port AER and RAS registers for purpose of
> error logging.
> 
> RCH downstream ports are not enumerated during a PCI bus scan and are
> instead discovered using system firmware, ACPI in this case.[1] The
> downstream port is implemented as a Root Complex Register Block (RCRB).
> The RCRB is a 4k memory block containing PCIe registers based on the PCIe
> root port.[2] The RCRB includes AER extended capability registers used for
> reporting errors. Note, the RCH's AER Capability is located in the RCRB
> memory space instead of PCI configuration space, thus its register access
> is different. Existing kernel PCIe AER functions can not be used to manage
> the downstream port AER capabilities and RAS registers because the port was
> not enumerated during PCI scan and the registers are not PCI config
> accessible.
> 
> Discover RCH downstream port AER extended capability registers. Use MMIO
> accesses to search for extended AER capability in RCRB register space.
> 
> [1] CXL 3.0 Spec, 9.11.2 - System Firmware View of CXL 1.1 Hierarchy
> [2] CXL 3.0 Spec, 8.2.1.1 - RCH Downstream Port RCRB
> 
> Co-developed-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/core/regs.c | 51 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index ba2b1763042c..dd6c3c898cff 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -408,6 +408,54 @@ int cxl_setup_regs(struct cxl_register_map *map)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_setup_regs, CXL);
>  
> +static void __iomem *cxl_map_reg(struct device *dev, resource_size_t addr,
> +				resource_size_t length)
> +{
> +	struct resource *res;
> +
> +	if (WARN_ON_ONCE(addr == CXL_RESOURCE_NONE))
> +		return NULL;
> +
> +	res = request_mem_region(addr, length, dev_name(dev));
> +	if (!res)
> +		return NULL;
> +
> +	return ioremap(addr, length);
> +}
> +
> +static void cxl_unmap_reg(void __iomem *base, resource_size_t addr,
> +			 resource_size_t length)
> +{
> +	iounmap(base);
> +	release_mem_region(addr, length);
> +}

Why redo the {request,release}_mem_region() and ioremap() vs handling
this inside of the existing mapping of the RCRB in this function?
