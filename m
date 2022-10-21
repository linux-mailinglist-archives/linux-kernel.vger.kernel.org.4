Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F49606CC0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 03:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiJUBA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 21:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiJUBAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 21:00:25 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE91157F4E;
        Thu, 20 Oct 2022 18:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666314023; x=1697850023;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=m016P7gP+3TJenZw04w/WmfNEiL/6SunwRa2KF9owhM=;
  b=eTRzpP7q/fb9GuVjbznU0uWme+fgMW6teJQkMMnQz55vWECJnKnyh7sA
   sltFoy5NWdBn4vVgljJf/8huC6/6NuNLpIt6z59lYb2bva1GmT+ACcIWX
   CBe3waXVlErfpKfPmCxA0bY+zW/RQjDrx6Ys2lcfWS5Ok0ywPjWrh47ds
   4V9tXrkJfiX54wTV/uGbZcRBn4pbz6lgiP7BX7RmFGfzvy05cEuRJa/9j
   LT6cp+/Y66JEogrve4VFEiC5xSjWviJBd/3Dx59HYBLWleSi4u2amHhhA
   ofKs8FU9uQTkDUqEKAj5eV4IWn++dXErppSJ5y9pMXb9E66DMBJlP5Huy
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="393178735"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="393178735"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 18:00:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="755492773"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="755492773"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 20 Oct 2022 18:00:22 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 18:00:21 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 18:00:21 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 20 Oct 2022 18:00:21 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 20 Oct 2022 18:00:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+nOeDWkS/zPY2W3jrZYHTp3k+MuBa9My3oUUV6EbaqWwUb6XbJDLkBfEhHFraM6HhzjvI1ikllg6b5Fp5+8uP6TFVal7hFwWju3GAcpimebtfxjPTk1NzfKXcOrvIdG4VSeB3Hosl5koIis5ziD9kAK/faNIWRBOF4GO6oKlHpmwMNFNIFUiMvtDoKjctFIJuX4yjwIDsjsITOzVMf5I0YRWEK+BkM+xU/6QwtLkmS8/BujnGin/lnnX935WTdBHGkq3+nD81ISQqblLNW5kXAKY6QpcsbFpHbjD2gwzL0hEtTuxoMwK9HAd3yZzDxh5u/HSxLJYWThzvY7zkt02A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ukdGQqWmWm1LjLOi+A8uITIJ/kt27vQCzucYJ3j0jHA=;
 b=HeHOIusIEX2/aBa2Tntd4InpTvEWuEYKCtI5MJlNyEL2EQF2kA1WRH+DMp2kmUARQMA2Y4XMSKIlNWoVX5Ji91yIx0qaduPPzPCwGerknQkwYNlbeEi5JjcR4Xlnkegw0BWe7O5k981QkQWhu2wa4UQHD5fEh4oz7tsWFVHWROfxA9lu+apiLXJ413i3h1e3yjyM1zLLzdOLiC5lKWXeXUz+q9Sw3osk5/VFB+uFCRfD4nNsgHz7Hv4swWby6hKepla5pJ4EnuOvm6Dlr5nX39fC3Ka1MXR4JtV9UE0nq8toNB7JoMx/X38RGfCJBmleiACMwkH9R8BIqT2FVIwcmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SJ0PR11MB5086.namprd11.prod.outlook.com
 (2603:10b6:a03:2d1::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 21 Oct
 2022 01:00:18 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5723.034; Fri, 21 Oct
 2022 01:00:18 +0000
Date:   Thu, 20 Oct 2022 18:00:15 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Robert Richter <rrichter@amd.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Dan Williams" <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        Robert Richter <rrichter@amd.com>
Subject: RE: [PATCH v2 05/12] cxl/acpi: Improve debug messages in
 cxl_acpi_probe()
Message-ID: <6351ef1f70cc6_4da329414@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221018132341.76259-1-rrichter@amd.com>
 <20221018132341.76259-6-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221018132341.76259-6-rrichter@amd.com>
X-ClientProxiedBy: BY5PR13CA0020.namprd13.prod.outlook.com
 (2603:10b6:a03:180::33) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SJ0PR11MB5086:EE_
X-MS-Office365-Filtering-Correlation-Id: 862b55e6-8000-4d47-1371-08dab2ff9efb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nq2UG4cCqYFc8DbhEQl+RNuOfKwkcNV1SZGx0aLWlbwmA4JdeRZhVYX12ga9+cEu4OPQ5rA1plLMHSAWwT+gQkA8qmcby4vqbSIC7mo76LRLdL1TXYMgdRnWwc1ce2DExwIpqW0fcdTotZJN1Sonq2oA4U3ikH7jMXWEONPAWMB7w87N8T066PUUVeUOYIK3tCrOjuhv6qJ8ZVB8zbei+LvJto+M04pncagmI39ivcerwN1WpXoUwsQTMoUqfLloIA7LeQcZdZcVrBB3lZVXaaw/dwdhS8QqQI50RH1eEF4Sz95SStUgn96S0sdMxIcfKwfem2r1Z4LxVjayrU5N2uSdzrCA0AdzGj67IkXuh8ZZdISXWlSrhSKx2QT7JXLyESJ9lnGd4Bx4sVfrwg/GAhUe0J1cqE9RepauSof91NcLGL9PfZZZSUb5I9/frvkOGx+/fWtZLsVtJH1tGKigJCddv8A4YQBjGCNyW1nqj6oa4tYASe8dw43kWUbLHzWUzcdX8Ad8XWkKHKQk5akPBE9P0SNKjAuhK5HYsDovVHLQAaxV6qxPcSiLa7Sl0sRQCWCcWoPiV74A4h9BiDXc+FGnZ+p+sX+FceZxnnG7OdUKmlwMusShjym390r7Tj/pPIGIjAwolEK1m223XCMpz+rorxQ5tQDDsbi8ZsJO2tYguN+3VnkwT7bAYfGV1G+2MCoSPPR07ZV+fWoWwCRsUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(39860400002)(396003)(136003)(346002)(451199015)(38100700002)(86362001)(82960400001)(9686003)(186003)(6666004)(15650500001)(5660300002)(6506007)(6512007)(26005)(83380400001)(66946007)(478600001)(2906002)(316002)(8936002)(6486002)(110136005)(54906003)(8676002)(4326008)(41300700001)(66476007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FnQefSK1z7tP7cEdHB6SyS2UiEbTIQ9jl8XidsuCAdV92bMh9PnWenzVzBrP?=
 =?us-ascii?Q?b4W7T1xMr4xi2KC3vbiMZuwxtCOuxadvgdoD4Wp9MTaUKFg7L3/Sp0muBmdR?=
 =?us-ascii?Q?+demJbPXihC4YMUeabMNPoYXqSHe/bxeocufPym5cjLdeO+XXPxibIPLzOFq?=
 =?us-ascii?Q?jyRJT1iSlFgaD3PUrBLRJ7YJHoLiZ97HWhnTK9+8ZBNumbqbwNjrQoccc3+l?=
 =?us-ascii?Q?SU5fQVt3Liv++cEl0JVme6ksRrYl/dJzZilCZPS75Sm9SiCpwMsuJVEc3aqX?=
 =?us-ascii?Q?6f5vUz1LBloAohfxEcHpDyUivWBkEMKBVHUjGsYLvZQ/CGpw43zmDlZryWZs?=
 =?us-ascii?Q?19R9RzYWB6bUF0nBDgFV4s1rsw2X4iQn6jgCeDaJ6QG5FvzNRpbWqTGC+9tX?=
 =?us-ascii?Q?7Uquu8BsQTWEc939G+2SN1wmyimbD6jtjlySk4jZHURbnr4Jh5fsgiqnLX2c?=
 =?us-ascii?Q?UBzjjRe/HHSGgx5Ho3nbZNjGei68cUovQbT0fxUXXPHIwNR6+ZskkIWI9kK4?=
 =?us-ascii?Q?pi3l0wj6Mx1uSeJ8sIpGmJsbcnXSs+np+IRHuWGIjrTJiAjpSsaQOdWy0hkH?=
 =?us-ascii?Q?/SAoag8Mf/GoQ0VX9+qKGz7xuc+65AzRrGmwum608S5X6gwi4nUJKLVmn2+z?=
 =?us-ascii?Q?ovQCEClZrYeG0kpBAAJCe38+3OvNRmjFNYqzAuN8hj5JryKrs1ggluLac8OL?=
 =?us-ascii?Q?ilJXOAauskLfF+NzZ4zjnfRPF0jElayrNuK9GPXrB7y2+ViQ/BLh2te9szPx?=
 =?us-ascii?Q?998i80fbbHob4ZLFgaud2CDQafPmzw5qgnuW2mSWFfb/01CfqYqL/d6RTktN?=
 =?us-ascii?Q?Jxg1H9aLTnzy/dNNV7MFNPR3jq/Jvjyl/8ndBFQFyISC+JjVb0A2CmOMAyNL?=
 =?us-ascii?Q?8cmcvxb/cbLofOKW6J3z4FSW9byeufe5MTgHXLfhfZOlSG7yLa4jiNXwZw+D?=
 =?us-ascii?Q?JY6uW01TQ111LTeTg2TT9v92u/DY+LPpH3epluJfFSEO6JrP6dYpVSFHnrD3?=
 =?us-ascii?Q?u3JS9yDtoIKktyvDP8Tvl235gjN6w1bFhkf6qreSRigpXs8cOC/9AzvK7WXf?=
 =?us-ascii?Q?MNZ84VCdv2UDbhHrAsJRN9VGR78xaP5OxhRTZQjPQXpV0X2WorA+hyzIFsqZ?=
 =?us-ascii?Q?4gOdmUBhvrsxHUgLOVt08ycSGrmRlGv1+Ci/Y805EaM1N/6gIAl+jFKHtPK/?=
 =?us-ascii?Q?isjZWvZEjhFYTYvrQcZFBeVtDSxLm7BjrBW36Vzvn/rpAXgFOHXbE+GZY+RY?=
 =?us-ascii?Q?HLtklrTl2UqU50fxxvuEHNlj2T+djQKPye3QCpbTs+52FvrtoF7HDt5vg1ar?=
 =?us-ascii?Q?fToYDOMmf93fUuU8mYt5gHLtEESyXcjNFNCGnSYMPwFXiEgDUqL+oPDITGM7?=
 =?us-ascii?Q?+f5iktZ9xl6d4Jq3gwYVtfMT7qYFPSrdholsT3WgLPj1JsHJbZV4Qf8pIIrv?=
 =?us-ascii?Q?0/+YxUC3HHmcRHUJ+tnk3g1i5j23z2y3afdExo4gJ2SbUKmx0gr9Qh4gMRFt?=
 =?us-ascii?Q?hV1JMg3TS8+0AiFyBvxbNnAtq+nKWVljKETkRoiqDxN4VgWla3UQDkcu6vCP?=
 =?us-ascii?Q?ga4JR8bf6R0MO46+Rb6zjif0gtcYq0jujbGtUKkMfsUYKVLi50dj8YBCjR/T?=
 =?us-ascii?Q?Ag=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 862b55e6-8000-4d47-1371-08dab2ff9efb
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 01:00:18.2817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WCKv7o0RhoPW9M2gHVLy7kKyeIPjFV0jWqmQFNYgmDCR/5acdy1PzcMul8NJ3fxAKfkfR6CGcIYbDeLnNwL24dYpdU/dyrNuxUyqkoxHgow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5086
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Richter wrote:
> In cxl_acpi_probe() the iterator bus_for_each_dev() walks through all
> CXL hosts. Since all dev_*() debug messages point to the ACPI0017
> device which is the CXL root for all hosts, the device information is
> pointless as it is always the same device. Change this to use the host
> device for this instead.
> 
> Also, add additional host specific information such as CXL support,
> UID and CHBCR.
> 
> This is an example log:
> 
>  acpi ACPI0016:00: UID found: 4
>  acpi ACPI0016:00: CHBCR found: 0x28090000000
>  acpi ACPI0016:00: dport added to root0
>  acpi ACPI0016:00: host-bridge: ACPI0016:00
>   pci0000:7f: host supports CXL
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/acpi.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 31e104f0210f..fb9f72813067 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -221,6 +221,8 @@ static int add_host_bridge_uport(struct device *match, void *arg)
>  	if (IS_ERR(port))
>  		return PTR_ERR(port);
>  
> +	dev_info(pci_root->bus->bridge, "host supports CXL\n");
> +

I generally advocate for drivers to be silent, but this is a fundamental
message in a place that is helpful to indicate whether platform-firmware
is doing its job correctly, and it's only once per host bridge.

Applied for v6.2.
