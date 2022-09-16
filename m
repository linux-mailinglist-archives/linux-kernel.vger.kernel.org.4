Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2061A5BB1DF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 20:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiIPSM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 14:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiIPSMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 14:12:53 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948B6ABD78;
        Fri, 16 Sep 2022 11:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663351972; x=1694887972;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kUmIezqBx3yKL+vlhBnizFSGhJLnfNf0qGCZxAHgT6Y=;
  b=N11a1tw7v+XLGrkBRJ5F/HcPeBjPAsQmSS7wqlJjz8s4Ra1bAKpWrjsm
   9+EgdmrDq77DaRvHupPEr//GBJ3hHh9Ynuqh00BN7M3YI0EKZU21J7/TW
   uESUdpY40jOB8nSzYy6JesrOfLP+hLrjgDbgdYQzGVMfbtZgR9n+h4LnS
   KkyCXY0pE+gNhMJulVRaRz1BiDwjeUv+Vnv9rT0NgKSEmv9m/QoN14i+2
   bB9HcmRc/DI4hIBxxKFIna4aHUkJI9jWkRstag/Fv9KHQeqBZQurET3yo
   ljNOfkoomHo6tCxhTp6Z1GiAFq23zDoCLF5DiIww8+X5iYd+hAl0Edfck
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="299039803"
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="299039803"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 11:12:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="706834541"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Sep 2022 11:12:33 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 16 Sep 2022 11:12:33 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 16 Sep 2022 11:12:32 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 16 Sep 2022 11:12:32 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 16 Sep 2022 11:12:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d1S9j47m6uUzkeyAlW93+iotlkbcT/imomnY0UGXvMZIG/lWMQLrwN/CS4tJTrWBXutl0R9ZyG5Br6Ts9tPOpMHOHvdKF17uTADMWNyDse4mKU25qLuuHX2XsoaVyY+XtCJd7VvZSw/pvyewXQ/sNm9Jwg06RUBZkH4clsxTg1amkTJoYBd+28z3X0ZlFAf5QhQhQ20GJLFaPuqZMNET6JPQAWVJXz9gLul6L9UTKhABgfQOXxn3ArjSbHwwfC4j30mACiZpL4dSB3NEVUS5wZU4usnVWewRfFDdUJX2rmosewGB2pXvWVYfgjBIYzgQq3qh/qJYxulxy7/9Xjwztw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=080xC6ClrDjaHsBDR2qmTrscQ7kphuWERmFWU7S+c1s=;
 b=VSz3fs+HCwNjhYIgAWxyGPKZYFhowJYOL6KiwgDpFJk0Esy4xcQjWs9FVvzEvKEz5NGWAywz80oEl/D54BJrQ37uuMBXFcF8H27Zv/gVPpuMuAx1bA5a/lIzeslcA+PiBsUOkWHQItsKcQpnwymp7UEbbl+DOhn5yTkkJdI/Pj10yyBnv+2ssjl3rm4csjuFectBOkVihOVcNqBLcHl5gVk2iNWktdzlfFaBuozX2AlOWerFV2ea7/s5D4WTtNoT4GzMgJJm7nI50ASTn5nixv297mLKCPt03hfKa2IOVhbBkPiuoOJ+m02D/UN3pwZOcMuF6LR8wHynNOoSDSnyjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SN7PR11MB6945.namprd11.prod.outlook.com
 (2603:10b6:806:2a8::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Fri, 16 Sep
 2022 18:12:30 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5632.016; Fri, 16 Sep 2022
 18:12:30 +0000
Date:   Fri, 16 Sep 2022 11:12:27 -0700
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
        Len Brown <lenb@kernel.org>, Robert Richter <rrichter@amd.com>
Subject: RE: [PATCH 15/15] cxl/acpi: Specify module load order dependency for
 the cxl_acpi module
Message-ID: <6324bc8b6c2df_2a6ded2944@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220831081603.3415-1-rrichter@amd.com>
 <20220831081603.3415-16-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220831081603.3415-16-rrichter@amd.com>
X-ClientProxiedBy: BYAPR05CA0053.namprd05.prod.outlook.com
 (2603:10b6:a03:74::30) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SN7PR11MB6945:EE_
X-MS-Office365-Filtering-Correlation-Id: e542ff41-7d46-4253-d9dd-08da980f04c0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iBwLGWi5RRRjBPmdsel2Dy17cZOhqEBWBf7rTJAwjVgjWQeK3JoxPUIVbQ30lIu06CFnBkGTxGRrPXGGyv/oTTjLphETM/Pl8CxsBV38Lfu0LE7N6eLiDwfQ5Uwk9XNiJJ6r5pUhQ8p5t5FT0EYX0UlTp7DDIV1Zvle1nOTweIuOab+9V/us8VYz2V82TJXxXl7ELlD9pyOncpQqIh4VICj26yj5zXF46yu+SIMVwOkLXqNTPQwNViiFT+jOOPqQmBCIfRO/sbJ/ohl6ciRqw0oeW+meVJHvNbeD4SwtIv8JvRUERtskWXYBB/O0eeQlKnls1Qi8D9dKTljUAhSZwXbc3z3mfrm9dRFgyNyC64gG5Vz4/+RAJtbX3FoQ+sM9jiAQWLOD+it2sCPKjKOJ8M0KSHfQZTo5D1jwpwIhBqeB+j8sm/W2IDKfDqtqAp4eSOKlpPtQGzxgk/4fK6CVE2QlBd+GIgSZwA7Q3NSGwgmz5x2wLo2tI+Y07B/09967G/CDk+I7XbqjGcbT7DpHzBtcNP/NTc/DbkXBUvM9WF+MEHE4ETmmQ3orRvUqzkBIO2mwvJjlMKi4z1EPqrbzRBVWNPtCHh9cx9q95/ysfKzXeZGQMwv0wuUPdfDc6tDd04iJ6pxOBwoVh/uICBtbmhRzDtvta63Wb0O9k41Las3Ja9wYFDsjl9EVSy70pUKe8bg5MOvgm2h4wKxbVMtcuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(376002)(39860400002)(136003)(346002)(451199015)(6506007)(86362001)(110136005)(83380400001)(6486002)(4326008)(478600001)(41300700001)(8676002)(66476007)(66946007)(38100700002)(6666004)(66556008)(316002)(54906003)(9686003)(26005)(5660300002)(2906002)(6512007)(186003)(8936002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZynD0frR+vxbQ8eDXB6V0oPR5JceNZWpNgj1LgPDmzJdz7Ox4srEx06ZP6hH?=
 =?us-ascii?Q?Ty6rN14L5sKIc/RZARcyqT94sAF0ocYrkXBVYupQObabGFvmtGvemMnCdC/x?=
 =?us-ascii?Q?0eoH6qxNE3k3uhpHefEYXQclPeszXm9vpAhKxcuICaXEcD1TussJkPmCwNwk?=
 =?us-ascii?Q?RsHfwqngzfH2GRIqIj3nh1qjwl/kgOXp/dXx4/nteMiUysj+yk2zFEmYJzns?=
 =?us-ascii?Q?3R6KxbPJTemM1uriQ+AvAbxPzRkaWdp+7vg1tEks4FxLeggyYCVclkFVjsdM?=
 =?us-ascii?Q?tQC5E0t+4oP+9dmiAKIDl9NhWswRE745ecc1TSl4ny3uL57Y+SqwGmwyJGay?=
 =?us-ascii?Q?Q8JHcsDkIGioWwIRfQalTE1EPHRsNz/zq4e2ZhiITiXXFb873FNSj3Sqk5kc?=
 =?us-ascii?Q?5P2JHAitJovChxHg5k0f7n1KJXtBDuARoNTRG+ebU5t98tSj6jpoVZMvNUHz?=
 =?us-ascii?Q?S3lmYutUkCMHZ4U72lnTwbR8a4byBdsPCgj7NTtVR4/om1kHpmapM2lie8s6?=
 =?us-ascii?Q?qR2u7XgvCCh7gWsef+UDYbCj1mScfQgIbDxCe8TYTWWDLO6Kbmu4TuyttP0F?=
 =?us-ascii?Q?NS4442Y8Pgl6QJrvj//zb0oxsTWxTKGogQq+E2pA0Rzj06zqw6u8cXZ0r+OU?=
 =?us-ascii?Q?BSAjJPV9PqnhsNj+Q1V7fLnlDr+4R+5pJ3WMkj2IFObcwuYog0a3TQQrvAWi?=
 =?us-ascii?Q?UzQwSZcWtaW/fE/yEnP2m99dzzee1VsXloywhmH/6TyXedrY4nUxoVRfird0?=
 =?us-ascii?Q?uaW7rN+3fae/v10f+bHCrmRFlP2Cx5HqZW4DxDRk3v5a8HX1SrFrOlCDYweI?=
 =?us-ascii?Q?VflEIfCLYPcrp8fC3msQfrIPPSKk6FHSNVekY1YFWoX9nXH8a/67JsshU7KM?=
 =?us-ascii?Q?LArxtvryX98zIdyNvBMGbagjWMlbXKX3mitKPIVclEaTdg6bpiFgvgV6hKx9?=
 =?us-ascii?Q?cPs7PHlVxIw7T9SkIRfg6leHN/ho2oC4vtMws6Ef4ykERjSw8ugrV32XsqqH?=
 =?us-ascii?Q?zDmTL4hHthUeNxidzQfj01Cgr0D7kDEstuMInxruM8T7N2Z7RHquwiw3QsE2?=
 =?us-ascii?Q?7JCABxy5N36Q6GY5S6kT2vq6zkOixTntYPdPcxP38h401xWfHhih+krnlxrS?=
 =?us-ascii?Q?BDFxkLM1kNYli7bQO55tsJZTqxS80BAUGuvc35U/UdRoJQCWy1HWQAgffxrK?=
 =?us-ascii?Q?qbh/N42ZYic69ZtSEY3Eigqz1PqagJDSF1f+Lhsq4VSmRgaPqbRW4yrxVGTY?=
 =?us-ascii?Q?DohIgwbWoGLJ0mrOVLgrXWoDKdKC/TuBCZL/MLtsSh4jNWcpn8Qt7IsZdyKU?=
 =?us-ascii?Q?okNfMGr0hYjyAHklIiee4DqOYT5fshCiv3IijTy67jMraL0mjqrDrmOlRctB?=
 =?us-ascii?Q?8CwNnVxlKEhzY3CjId0Piu6bDL4QNArC9cjBJd/bCg7xlz3r3FR8aERCCEK7?=
 =?us-ascii?Q?OqQnDOLhLyXYf58mBug1VLbhg6MX8JcWwihWgm2djQlXE3nFFEA2XkwqyNU4?=
 =?us-ascii?Q?MPVcydt7aufwuomVfQuVvsBdZ1Fo/MkLSrTjnXuMDDENeal9qMwofKY6CMca?=
 =?us-ascii?Q?B2PmmCMZ8yZr8dfMWoYtBca4a+yBEFc2zQNXKsfLHnkgewXaOpW6BSc/pdpo?=
 =?us-ascii?Q?MA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e542ff41-7d46-4253-d9dd-08da980f04c0
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 18:12:30.0994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GDLCg9YN08XFTiXLbDuXgsL0Z3csVmFwcgP9bVNfhTs+DIa0InF//rwy62xE95//qTOe1umZfVj1SdLG2HfUPi2Xe1vs5XRhsJzJ9YgqnWA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6945
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Richter wrote:
> In RCD mode the CXL mem dev may be detected on the PCI bus before a
> CXL host is brought up. This may cause a CXL mem initialization
> failure as it expects the CXL host already detected.

This is not unique to RCD mode. It is mitigated by the cxl_bus_rescan()
at the completion of cxl_acpi_probe().


> Address this by
> specifying the module dependencies using MODULE_SOFTDEP().
> 
> The following additional dependencies exist:
> 
>  * cxl_mem depends on cxl_acpi: The CXL hosts must be discovered
>    before the CXL device is initialized.
> 
>  * cxl_acpi depends on cxl_port: The acpi driver adds ports to the cxl
>    bus, the port driver should be loaded before. This might also work
>    if modules are loaded in different order, but a) it aligns with the
>    existing cxl_mem/cxl_port softdep and b) it always guarantees a fix
>    module load order.

Why does a fixed module load order matter?

> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/acpi.c | 1 +
>  drivers/cxl/mem.c  | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 56b2d222afcc..63a1cb295c07 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -834,3 +834,4 @@ module_exit(cxl_host_exit);
>  MODULE_LICENSE("GPL v2");
>  MODULE_IMPORT_NS(CXL);
>  MODULE_IMPORT_NS(ACPI);
> +MODULE_SOFTDEP("pre: cxl_port");

The only reason cxl_acpi would need to preload cxl_port is if it wanted
to do something like:

port = devm_cxl_add_port(...);
if (port->dev.driver)
	/* do something with an enabled port */
else
	/* do something else if the port failed to enable */

> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 64ccf053d32c..ae13ec7d9894 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -128,3 +128,4 @@ MODULE_ALIAS_CXL(CXL_DEVICE_MEMORY_EXPANDER);
>   * endpoint registration.
>   */
>  MODULE_SOFTDEP("pre: cxl_port");
> +MODULE_SOFTDEP("pre: cxl_acpi");

There is no strict requirement that CXL topologies be limited to ACPI
platforms. Per above, the cxl_mem driver will attach when the CXL root
device finally appears, and async out-of-order arrival is ok.
