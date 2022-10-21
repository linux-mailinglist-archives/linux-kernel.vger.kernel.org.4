Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C41D606F50
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 07:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiJUFRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 01:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiJUFRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 01:17:15 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE0422AB70;
        Thu, 20 Oct 2022 22:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666329434; x=1697865434;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8lCc425o7i6jSaWU/HDjc1MQViDHwvGfYIlJtLsLnJQ=;
  b=j/RWXJnF5+Oe5jxVY1532A0epqyrsiZMQFOZdGdM3tfvVg9lxYlSglxn
   bJwjaW3zsMPIldt8nJtDIxtB5fm5TqQpMl3CB5yAv9auVTKBSGpqptkMm
   uFwbXMlMTP6GjXliGdrJZriT0oGzA/774h3JL7ttK3tZ6NhGnzuvfqe3v
   7EfX4cJsU3AJDlS7+PbE0UniCCbf4SqTEiLi1BD6fwW/OaHcOQ8DeJhw/
   ib9WzqgxnlQqFp1bJ27SFRa/qfvYg27RZnWfLi9ygkAGE5cr8wclYBf+b
   06bhDnKFjN03ec1WS7b5c+BEXj/TpnvqgJGTZgpa/p8zNVf7Pnh43c/LE
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="306904825"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="306904825"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 22:17:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="735326597"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="735326597"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 20 Oct 2022 22:17:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 22:17:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 22:17:13 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 20 Oct 2022 22:17:13 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 20 Oct 2022 22:17:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k55gcY3yOSQ86xmc4FT78e42pNUt+7M5deHoUr89uR3mzibtJiI9pb60+dumb7qRwHLb5ZNKr74PQrrTzPH2rnnYruKpRplVNYj0F/A68m1iV/VvZBBLzvCFx0zXYU6zCW6U4zFVIty2QqJigLahDOv9iRDPM5B/OMCOHCKPU6ZrjYZ88oVaJWNzU9bJR/HxdEbdvcH/d456WWQHx1E5p70JzZmoXwB8h6y8XrYgd57VgpIyZgBaPhTyU1D5ZvQ+w1E635K2PZFvIbs76KrFiJcNHz+nPXYq32RyU4YyNF/FdDx+ct0xEeRA7g7K8sJxu9hy5Qb3Tw/PJdE3/hGcrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x21Qes4NoUP2MKExFQAyX8PZAuz9dL17+Shdt7H8vNU=;
 b=Fy2fxB3lSLrnq2cFjSEabmIxrfmdSfXnlY32C61CEoAnDZ9TKcvXSzNuqgj0tLcG8/tyy/kMyCXOsdPMoAppIMuy4bZqk+sqFIECWVp6VdkxAXgrdPzAf3siodx6VA4WF6AyB43XrqY0cQ4kh+poxAHAklDVlGwX3FWZmffnFWfeVCY9MZ4Hh8O99xlOq4dVB8rFLkIrQ+5FFNVhNSBowWW/2qfYWMgM9n9Gj2/qEGhu+8PTPgnLVzmyoCGnRVRpRyqyu4U5hBq58d6acB1CwdizfAcVE/xU73h34+DvwbbLGxZTCws4Nk8EhmLXUXyMyJIG3PrfgwpnpI0U1ogTEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SJ0PR11MB6813.namprd11.prod.outlook.com
 (2603:10b6:a03:47f::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 21 Oct
 2022 05:17:11 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5723.034; Fri, 21 Oct
 2022 05:17:11 +0000
Date:   Thu, 20 Oct 2022 22:17:07 -0700
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
        Robert Richter <rrichter@amd.com>,
        Terry Bowman <terry.bowman@amd.com>
Subject: RE: [PATCH v2 06/12] cxl/acpi: Extract component registers of
 restricted hosts from RCRB
Message-ID: <63522b53321e1_24ac29467@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20221018132341.76259-1-rrichter@amd.com>
 <20221018132341.76259-7-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221018132341.76259-7-rrichter@amd.com>
X-ClientProxiedBy: BY5PR13CA0011.namprd13.prod.outlook.com
 (2603:10b6:a03:180::24) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SJ0PR11MB6813:EE_
X-MS-Office365-Filtering-Correlation-Id: 26f2c06d-52ed-4527-0b71-08dab32381ef
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jD65yVvVsOVOUFmNogsPRKN0vWUYY4OIY6XW6YasGL3CL5ckR0AtqOSzMNQrSEp6CLUuLDuy8abGj9XKwSfWEbn0DN3TlnoTMW6v8dNWapb0pkrhVBGlSoKLj9/bFOZVq56WoBl+t6gtIP+aBfJL9MFDBod/ofutGAPf+sUWhIbMI4fEeMYa+rGGnMcHIeS/mOKtqAlap5onbdASilhbQM9oiNWoYA8wN0bdn4fm9sPRiog+IkCzfCGX/DiyTtu6UxmjRthZT0/S5LD20kRZcPYHt84iSDuvYNfUm+N9Nkw/ag0J55/VN5Af8y82kdvhRqc+Ms5Lsf/L9yW60/6YfR5rxVOzgchREYrNGXVsMLfxK48zfAEgO9+SRR6/vTl9dQJriy+DQSoNjBgqJf/ONvred7Qa6CQJCtU3A19JTr9gwhewSTU5ODS5VjGehnkvZjbsSL09C9nCLKl/SyFaipbpsDmfzd4/p768oYKKh3wOVmswywqqxXpSIYwppQMF8cA+uGX1EgaWoYt/Xc9dE9kWplGzI2kItVm+6Cha1qXw+kdmrGRWLh6q5HuPgqMmKEDCALsVZERRm+YGAlBr2ikGw87qebFHDPdRDDll0ZElJWoXcRQpUbaCB9vHvXfkT1QDD2If1tka0c3zvq5bb+CbsbJ50F49qnpxP6n1jdlv72UuhKYRk3Qph0WLI7wIrQDjmcT/9Ur3Pos7eYPXN6sG4XrRU2iiTtMr+tBrvFw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(136003)(366004)(396003)(39860400002)(451199015)(6486002)(186003)(5660300002)(316002)(83380400001)(2906002)(86362001)(7416002)(38100700002)(4326008)(41300700001)(8936002)(8676002)(6666004)(9686003)(478600001)(6512007)(966005)(26005)(6506007)(66946007)(66476007)(110136005)(54906003)(66556008)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8BDCGL1UULjNatSM7zTq4u91cGJQCaXvOr89eed+q9vfxz0bQ+paklTthsvQ?=
 =?us-ascii?Q?fu8bcYvUn+AWJY2xcdP4WILmoaBIFtWXLzZg1tlGVNMYv9DYHd05zr+snm21?=
 =?us-ascii?Q?oi5Tdeo3OkvYPo9XAaqfqIpAFJ+F0uo0YdpaP8jbLGBCMTTTtJf4HfYzjqFl?=
 =?us-ascii?Q?xpi5EB9/D8re/TUEXTRTd3MCNqBBJpLsrnzx320caIVsA7P4QNWK6q8Vbqrs?=
 =?us-ascii?Q?YIl7MljSFYZNcc6pbAPSy2QbQYRmmvuTZe8f7QkobU4zqI1PqL7KGHstEQjZ?=
 =?us-ascii?Q?OgMn/8yx/SGsTVSc+ALzusvBpnwvFI/sqe8NyLyr70HM/35V9iEz1u9ZMgxM?=
 =?us-ascii?Q?3liya8luEVTc2xd/ITGdxCrYKm/KC2aEsqA3hsCDKp+gzYZ7xI6FttF0RIiR?=
 =?us-ascii?Q?TqX53hPtNBvHWnCoAO4DKsVrnBJd+wPKa2HSi5vMSrp9Mg7PeNwcCaZUkIAi?=
 =?us-ascii?Q?KduhwF3wflPAzIW0DAynfEU1V3UicJY8gr524CT0fIF1Ups4KASu4Y21zakL?=
 =?us-ascii?Q?xDRpNnpoJPi/MgyfEt4g9yav3tMk2TqDGUOltgc+G7IHcw0H6U4Xg5nZy1Je?=
 =?us-ascii?Q?lboSab17qYlaQ1kP8Vy5v/Y5TAusO/X6NAKHgw0U0r+zmtR/92CTRZpfHdqf?=
 =?us-ascii?Q?8jJYAik1d2phRHjViMEaOaFf/ccmODT8CfZjSljLps8nCsR1uAkNo54rZ8Nb?=
 =?us-ascii?Q?1XqsTXA9um6y4QKd5pdLg4/j+Ml9IN3Qz8u3E+nvXIP+RIBJQLD1tqzo8+KP?=
 =?us-ascii?Q?cqo7Fl/w2GSy1yF8crWCwXb8KRTM65u+ly0yZysEAoyxx2EeH+F4AjkulEgR?=
 =?us-ascii?Q?2fDbC24jJZgjeb/5rWj47gQcX2IGh8R69BGz2weadpn6DRiILk6Fp8OTB2gN?=
 =?us-ascii?Q?0ZNhOliTWLQcZswibxKAXcPiQitcx90Wn9z3dOOT7AvknvGMzGSpD0Xbdekh?=
 =?us-ascii?Q?ewT1xACnqA92PPTECc3hS08awxRTlJ0H8RJsQnUDGe/nwRFU27E+rIGWFJRz?=
 =?us-ascii?Q?JSVojeIQ29o0PMghHWoG3RqM3EES71I5nk59yirdblvylRso/dW05ooax3ca?=
 =?us-ascii?Q?jwWGJDseFCNbPuFqkJFZZ5iLZgIyIBvwZ+Ou+Jy/1i1qQkUED6NB6Uac3T5x?=
 =?us-ascii?Q?tyEkLBEq0ZEmyuLWuT9XO9sMx2VXhZBXEnqzSzSAHXbHGWJsLdT2uWhFjfk1?=
 =?us-ascii?Q?eLclg0BnYEwrN7cLOkB7BhxjvBBnIgFSSNgWvctQkUuLcimsAi8BIOmqRNpd?=
 =?us-ascii?Q?0ZzkUN6PcaClKlYx+srQfoHaF6dGjhEVmP25zyKaGUyOpG3IJUmhHYWJjgWI?=
 =?us-ascii?Q?2lKU+lqoWJU93mOiE7h54jYhm8k53tbpSYrjpE+JH/FtlL1sf7sUv+sAZOth?=
 =?us-ascii?Q?sA4PgRTOfEVDwLCf2fV2AFUOQ4Mjxkc724BMqQ9h8AGHZiB2FgzJw0tXvzQS?=
 =?us-ascii?Q?255DkqFXX3UnT8nfUJFvzXRj1rbNtWjWVC5XKkAwIbauDbu64KnJdmg5gbC7?=
 =?us-ascii?Q?zeTxdmFdLkQl3O0zIusaLRG4WcoCmFSucuVUwjSvuE78xWDcNMOGxGloOwSl?=
 =?us-ascii?Q?pyYX36Q2945z2btpNI93C1O62vIJEp76hmjRljt5j3T6l+InQaTsXUrVhO/o?=
 =?us-ascii?Q?Zg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 26f2c06d-52ed-4527-0b71-08dab32381ef
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 05:17:11.3844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KDOdYYWIuZ+RDsjQXgHRrG8iWMDczekKXcWuxPmHdrZIrPcfEQRGJx0QUO4wrODskbR3D9CmYYO5QMiwD0Y3vMf/8niOlR6/mzwXWsU+zdE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6813
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Richter wrote:
> A downstream port must be connected to a component register block.
> For restricted hosts the base address is determined from the RCRB. The
> RCRB is provided by the host's CEDT CHBS entry. Rework CEDT parser to
> get the RCRB and add code to extract the component register block from
> it.
> 
> RCRB's BAR[0..1] point to the component block containing CXL subsystem
> component registers. MEMBAR extraction follows the PCI base spec here,
> esp. 64 bit extraction and memory range alignment (6.0, 7.5.1.2.1).
> 
> Note: Right now the component register block is used for HDM decoder
> capability only which is optional for RCDs. If unsupported by the RCD,
> the HDM init will fail. It is future work to bypass it in this case.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/acpi.c | 79 ++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 69 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index fb9f72813067..a92d5d7b7a92 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -9,6 +9,8 @@
>  #include "cxlpci.h"
>  #include "cxl.h"
>  
> +#define CXL_RCRB_SIZE	SZ_8K
> +
>  static unsigned long cfmws_to_decoder_flags(int restrictions)
>  {
>  	unsigned long flags = CXL_DECODER_F_ENABLE;
> @@ -229,27 +231,82 @@ static int add_host_bridge_uport(struct device *match, void *arg)
>  struct cxl_chbs_context {
>  	struct device *dev;
>  	unsigned long long uid;
> -	resource_size_t chbcr;
> +	struct acpi_cedt_chbs chbs;
>  };
>  
> -static int cxl_get_chbcr(union acpi_subtable_headers *header, void *arg,
> -			 const unsigned long end)
> +static int cxl_get_chbs(union acpi_subtable_headers *header, void *arg,
> +			const unsigned long end)
>  {
>  	struct cxl_chbs_context *ctx = arg;
>  	struct acpi_cedt_chbs *chbs;
>  
> -	if (ctx->chbcr)
> +	if (ctx->chbs.base)
>  		return 0;
>  
>  	chbs = (struct acpi_cedt_chbs *) header;
>  
>  	if (ctx->uid != chbs->uid)
>  		return 0;
> -	ctx->chbcr = chbs->base;
> +	ctx->chbs = *chbs;
>  
>  	return 0;
>  }
>  
> +static resource_size_t cxl_get_chbcr(struct cxl_chbs_context *ctx)
> +{

The core logic of this looks good, but this wants to be shared with the
upstream port component register discovery.

Full disclosure I am reconciling these patches with an attempt that Dave
Jiang made at this topic. Since your series hit the list first I will
let it take the lead, but then fill it in with comments and learnings
from Dave's effort.

So in this case Dave moved this into the drivers/cxl/core/regs.c with a
function signature like:

enum cxl_rcrb {
       CXL_RCRB_DOWNSTREAM,
       CXL_RCRB_UPSTREAM,
};

resource_size_t cxl_rcrb_to_component(struct device *dev,
                                      resource_size_t rcrb_base, int len,
                                      enum cxl_rcrb which);

...where @which alternates when called by cxl_acpi for the downstream
case, or cxl_mem for the upstream case.


> +	struct acpi_cedt_chbs *chbs = &ctx->chbs;
> +	resource_size_t component_reg_phys, rcrb;
> +	u32 bar0, bar1;
> +	void *addr;
> +
> +	if (!chbs->base)
> +		return CXL_RESOURCE_NONE;
> +
> +	if (chbs->cxl_version != ACPI_CEDT_CHBS_VERSION_CXL11)
> +		return chbs->base;
> +
> +	/* Extract RCRB */
> +
> +	if (chbs->length != CXL_RCRB_SIZE)
> +		return CXL_RESOURCE_NONE;
> +
> +	rcrb = chbs->base;
> +
> +	dev_dbg(ctx->dev, "RCRB found for UID %lld: 0x%08llx\n",
> +		ctx->uid, (u64)rcrb);
> +
> +	/*
> +	 * RCRB's BAR[0..1] point to component block containing CXL
> +	 * subsystem component registers. MEMBAR extraction follows
> +	 * the PCI Base spec here, esp. 64 bit extraction and memory
> +	 * ranges alignment (6.0, 7.5.1.2.1).
> +	 */
> +	addr = ioremap(rcrb, PCI_BASE_ADDRESS_0 + SZ_8);

No failure check? This also only needs to map 4K at a time.

> +	bar0 = readl(addr + PCI_BASE_ADDRESS_0);
> +	bar1 = readl(addr + PCI_BASE_ADDRESS_1);
> +	iounmap(addr);
> +
> +	/* sanity check */
> +	if (bar0 & (PCI_BASE_ADDRESS_MEM_TYPE_1M | PCI_BASE_ADDRESS_SPACE_IO))
> +		return CXL_RESOURCE_NONE;
> +
> +	component_reg_phys = bar0 & PCI_BASE_ADDRESS_MEM_MASK;
> +	if (bar0 & PCI_BASE_ADDRESS_MEM_TYPE_64)
> +		component_reg_phys |= ((u64)bar1) << 32;
> +
> +	if (!component_reg_phys)
> +		return CXL_RESOURCE_NONE;
> +
> +	/*
> +	 * Must be 8k aligned (size of combined CXL 1.1 Downstream and
> +	 * Upstream Port RCRBs).
> +	 */
> +	if (component_reg_phys & (CXL_RCRB_SIZE - 1))
> +		return CXL_RESOURCE_NONE;

This is open-coding the IS_ALIGNED() macro. More importantly, why is it
using RCRB size for the component register block alignment? The
component lock is 64K, and at least for CXL 2.0 devices it is 64K
aligned (8.1.9.1 Register Block Offset Low), so I am not sure what this
check is for?

---

Given that there are actual CXL RCH platforms in the wild I want this
topic branch to be the first thing queued for v6.2. To help us
coordinate I pushed:

https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=rch

...with the patches from this set accepted so far. You can use that as
the baseline for the next spin.
