Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA15D60BE24
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 01:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiJXXFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 19:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiJXXE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 19:04:59 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F566E8AC;
        Mon, 24 Oct 2022 14:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666646778; x=1698182778;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=RnL4UhgP1Iv3aA2lwc+M4ukFlyqBrBXbvDmeGjYc9R8=;
  b=KLv2/IPNb4xlmQus0v/y/z9SZ+xPLGxP4Qul1uF3MQBTTKUE0we5wvY/
   JWUZyVMUmtE7J8Pu8SBpeTbWuWnQqX+tgpoAwLsh8v2//Aj49npZw9JFi
   bEgkT0/3ztXX685FfOTHl8oy0UZnoQDYTdmSRI/hqv6nwYo8dKlDuofqs
   nik09M7yRXzAcIa+p8Dwq8JnoiFqnZ7xNyo2JqWGzzkB4cbbntgwZPQyT
   reR6wEcmHP+b8if/mv5eKzhd7Kl0bz/lFjPTr7QEGrSKbTLVrkyvy7F1q
   +uFEqHNA0ZQtZKmafguzo0KCpFIKG84lvpTvGiaIE9ykZeujsPbfqasyI
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="306257080"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="306257080"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 14:25:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="700304692"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="700304692"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 24 Oct 2022 14:25:00 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 14:25:00 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 14:24:59 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 24 Oct 2022 14:24:59 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 24 Oct 2022 14:24:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rf0k8zru2agVFIUt+Xs+pvM5y8ECADpPw1ZNsMvvzGK1lT14YNevPfts0c6Cq15yc5iWswIm+xkTU+9WeNaOkAWu1tv2AhyE2JoE2QUvLxRADrZqgvUefamW8DI+EicMVj0C3IOEuSy1a6Kd7HOE/sfyTtvEC4I40SOu/mZZuPYzLtbMm/m+3KdZkAEL+inE2RKpGKetjj+L+/l9/P77ZjhHIzbDD9kBVLwtmLNj31b2AUQpUY50Ui/01wlacX731LclPvx56JstbAee2XqtoolNsY10nirup/JAXAyoN56blEUUT20YlESygIsMrczxq0pECCBHXm6gooMwT/Mmig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMQGMO3mwP6GYG6SyzIK3eVf+IBRcQ9pWzn51FwGTKs=;
 b=aZCVe7Lwi+HBslZyDOBYoMU9cZ0dZAx/cQxGqNtwM+B9hFG0mkDpWirQgy87/1O8Mqu+pt61mcDT/i1ZD7kfJiAf9swi5R3vn64gaGNwsYYIBJem5w5lZDyoz0j9NGppVk02l6roFDU2VST02vfBOq3N+CYIj9HYoDFrDo7kWe9a32AmOgrGdNYZ1Ciak1cuNKdTqR7nI/h0G04CbI87MqP4vlB1FlhejqRo2wTbfSKgJ5UGB6v9jdMgFjJ76XjjXl9ECeSpasI7dwP4LtfAC48n2Q/CCkz/b5c0eRIM8ZC6ASXNHSV3xgrP/BZR7xAg0FxUEaisPUv5Bv84aOqj9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by PH7PR11MB6452.namprd11.prod.outlook.com
 (2603:10b6:510:1f3::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Mon, 24 Oct
 2022 21:24:57 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5746.023; Mon, 24 Oct
 2022 21:24:57 +0000
Date:   Mon, 24 Oct 2022 14:24:54 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Robert Richter <rrichter@amd.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v2 06/12] cxl/acpi: Extract component registers of
 restricted hosts from RCRB
Message-ID: <635702a652637_4da32941a@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221018132341.76259-1-rrichter@amd.com>
 <20221018132341.76259-7-rrichter@amd.com>
 <63522b53321e1_24ac29467@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <Y1b92DF0c36/QDbo@rric.localdomain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y1b92DF0c36/QDbo@rric.localdomain>
X-ClientProxiedBy: MW4PR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:303:16d::24) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|PH7PR11MB6452:EE_
X-MS-Office365-Filtering-Correlation-Id: f806e1b6-f9f3-45f7-5d90-08dab606330a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: huWgU6BW6GMGf/blWmgjMlKKoZkNWSceLSrErlpWUz0Yts7/M7/75UgehYzAFBWA+/B1U60bWwbTHsRrlqIU6d+4ZcXsGtrDU7cm3e9oG8VOM1NExVopyFhdYlflieLs1WYOZiPFEIMg5elp9QhZOZpH0G7J82AcZnVAzrh23xgVtfkIQ0+F/T62zqeXOab4CTqxMgMfZAi1OYuS1dF+gG62ewum2+lScOmOcC5QChX7Xoo6Q8aRVNIlukKcfiK5NlF+S6LJXHyl+9IFk0G5qXiWIzfOl9htwCg199LOmLpF9aX+3juTgn7ggZJ4clnqG/SOZ0/dS33CWoghFN0Tc1mYsqAUmwcTveTNgCKF4TyLH9jwWG2WE3IUgJi+FLTBLvWy0KT+V7fxRRa8rKgZovaqoP3b20InR4hEJqoHYqf2aLswcjmyXUKrMzsyv1uTV36/rnvQFWxa2nr9AWOdrsqIPVYo/Yn05ZsysReFIUwQGDu7E2ElRaWVr9xLdU6nWUb0k137D3w8zv1p2ESAyoiPqOeLfMvd4zlAvmqDrItcQJ8NVnLYH5vax7gKAbsWqZFveFhbweRPabiJ8WNVYcfLnHu39XTCuTOVbLJF7Bp+wxDs1co0XcpYjRFrOsOyWFxbTYd6RsKse3qDPhSLqhflyLXAV72eeN2he/aL7mGVA+avJLjWdyoATrRkwZWMQOV4w8XdZHqaZHzQtXceTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(366004)(39860400002)(136003)(376002)(451199015)(66946007)(9686003)(6486002)(26005)(53546011)(6512007)(38100700002)(8676002)(41300700001)(8936002)(82960400001)(5660300002)(83380400001)(66476007)(86362001)(478600001)(7416002)(110136005)(54906003)(186003)(6506007)(316002)(6666004)(2906002)(4326008)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3FBwceKGxgSuXS2/vTGwyiUOOaHn6k6lnrTy/OMS46/VrXcY09OHhE8qlx/e?=
 =?us-ascii?Q?/v1sepCUijcB7bEpYXj3NEq3aQIlY9IsgD9PfG5aT+eWu4iLyqicTZd4vdiM?=
 =?us-ascii?Q?fYEFDrIiccSikKTrw67/22vMNHlCd2y5dR56QYdI4T6r6nueB1oaZiy6ZjRl?=
 =?us-ascii?Q?/HvDmObXzfWauYcvovKpCq7KjATj9IRXyRt+bm+7MkZ0Lp1uwQQmhljx1T83?=
 =?us-ascii?Q?O9gkSKJFhehrOUU2KnhrDWR9gMHXJDLQGuYl0Cq+zqLyoJdRbe+wnClEOVts?=
 =?us-ascii?Q?wawqXCjTOJG57bAqC6GVqyUYptZWTHUYKlPalUmdkszk5+HKvyXpSX3x56Ou?=
 =?us-ascii?Q?UaBVVrOcYOuksV69nfGY3nJ95H7fpKr0c4iivsPe39HX6U/rgNCQ5IO84q8m?=
 =?us-ascii?Q?oOGHvKv8hhFuflgDlN3b3CifoSEmYWnG4t0jCdf8tSEY07cl4uAnjqpUpaJn?=
 =?us-ascii?Q?wo57olWjUpq9gVnf4YemfQgCjt/H3zqPxMkvPwIV/9/6sbzP7Bi9MT4OXDXC?=
 =?us-ascii?Q?x8XiaSnGuC1VEPJX/WyZKj4JaHXf6nsnTHvALSrdGtD0HTAgOgYlOCQGRuRe?=
 =?us-ascii?Q?0g1+FSX+iYzQrQJQ5+NYRI6MyYN2ceC27el8yrOR0avQVVkNWsmbbJdQlRNM?=
 =?us-ascii?Q?BkYBGNvDahPWAyJ4aJNi/D/CmJRN7G5nIUSmlYb5qdnRtvgvaTEUNPSAPK27?=
 =?us-ascii?Q?l+xrY0v9Sq2VFE5TUSguAM1PNAeLsH6Y4oo6fTccmbAEmLGEHby2D0EZI/N7?=
 =?us-ascii?Q?faV/rhObleWj2qEFH8w62PknLA5ddm8Zu6CHuz1P3EUZjEEMrlMnFQqqRxR9?=
 =?us-ascii?Q?QT2UPzuzZNTKOM4JtD+IHuFdbb6jhKDhFFlYhfo7Qs/jUkuXucs6ngBbdTAT?=
 =?us-ascii?Q?lWX3nSylkJg2hCmVTXDMQYWKJAcFlfIW6RhmIhsoIe5mKduJrqps2s8Vf5iE?=
 =?us-ascii?Q?yFwqbcpSP3Vaz4hevlI1AOCAMM4bw6tESrqEiExTRN8SwRq5S/g2EEFIL/Jg?=
 =?us-ascii?Q?D2XaZFjCSnusnAQpdv7HL5nL4PJqTZhCberSEBbC29znqH06HbYPWLEMqShL?=
 =?us-ascii?Q?SBuoqiyt7k5VrEEoe9S74FcJJr3AvgtrHNgXB62Y1XqfavGpishKdfqIhUSv?=
 =?us-ascii?Q?HIh25Sbi2L/J8Y4Q7FYOrhDlA118q2pMeACdV5nb+t+vXlaugpOmINrGxTYt?=
 =?us-ascii?Q?5HcSP7xz4GxAO8cR9ql4H0dzSdN/GdXDuR7PnkIAJBgN03PeIxO6VDLBEbOr?=
 =?us-ascii?Q?NZDenFFzzOnJ/MPW4m5Ak1ZqApfTM7t/PVow1q+lGAKDBmkBaZ8eTzdRwvM7?=
 =?us-ascii?Q?wN+jic/58+S9C0jpg2Uff1Egw3lQQKob962zzrtpmd1FLuBtUFJF36ndeLM+?=
 =?us-ascii?Q?u6HBYbKmp8j/aLcGWvYi8V1w2ChurZbgCId4bqXIWHPaGFT/ty9FvJD99uz7?=
 =?us-ascii?Q?1zKMa5wbCI6fiU6lbf6PkDSHw+vi3egz34U4ZqPZMcOzi/pgQL3Ta0bf39za?=
 =?us-ascii?Q?Hn3ttSJqz8n8+IQiahzQJ5nHB7CLcOyqzFOWDlVClerIf9JB3xvnICQIJjed?=
 =?us-ascii?Q?Lxd5AKMAHUCxjVJU8FYLysFf/Xmm+IwLqjvyjADY63Tk+Q6DbZZ0vvv21U5q?=
 =?us-ascii?Q?yQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f806e1b6-f9f3-45f7-5d90-08dab606330a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 21:24:57.0128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RFLjSz+QAi9cvf4w3XPqTULAKfL89fSsTDmQFjmj6Yo4k8Om1bgEQafjktOXkI72VGmvDNbEORmf+7ndDP/e58yV/+05oQqUTcLGaC//HSg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6452
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Richter wrote:
> On 20.10.22 22:17:07, Dan Williams wrote:
> > Robert Richter wrote:
> > > A downstream port must be connected to a component register block.
> > > For restricted hosts the base address is determined from the RCRB. The
> > > RCRB is provided by the host's CEDT CHBS entry. Rework CEDT parser to
> > > get the RCRB and add code to extract the component register block from
> > > it.
> > > 
> > > RCRB's BAR[0..1] point to the component block containing CXL subsystem
> > > component registers. MEMBAR extraction follows the PCI base spec here,
> > > esp. 64 bit extraction and memory range alignment (6.0, 7.5.1.2.1).
> > > 
> > > Note: Right now the component register block is used for HDM decoder
> > > capability only which is optional for RCDs. If unsupported by the RCD,
> > > the HDM init will fail. It is future work to bypass it in this case.
> > > 
> > > Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> > > Signed-off-by: Robert Richter <rrichter@amd.com>
> > > ---
> > >  drivers/cxl/acpi.c | 79 ++++++++++++++++++++++++++++++++++++++++------
> > >  1 file changed, 69 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > > index fb9f72813067..a92d5d7b7a92 100644
> > > --- a/drivers/cxl/acpi.c
> > > +++ b/drivers/cxl/acpi.c
> > > @@ -9,6 +9,8 @@
> > >  #include "cxlpci.h"
> > >  #include "cxl.h"
> > >  
> > > +#define CXL_RCRB_SIZE	SZ_8K
> > > +
> > >  static unsigned long cfmws_to_decoder_flags(int restrictions)
> > >  {
> > >  	unsigned long flags = CXL_DECODER_F_ENABLE;
> > > @@ -229,27 +231,82 @@ static int add_host_bridge_uport(struct device *match, void *arg)
> > >  struct cxl_chbs_context {
> > >  	struct device *dev;
> > >  	unsigned long long uid;
> > > -	resource_size_t chbcr;
> > > +	struct acpi_cedt_chbs chbs;
> > >  };
> > >  
> > > -static int cxl_get_chbcr(union acpi_subtable_headers *header, void *arg,
> > > -			 const unsigned long end)
> > > +static int cxl_get_chbs(union acpi_subtable_headers *header, void *arg,
> > > +			const unsigned long end)
> > >  {
> > >  	struct cxl_chbs_context *ctx = arg;
> > >  	struct acpi_cedt_chbs *chbs;
> > >  
> > > -	if (ctx->chbcr)
> > > +	if (ctx->chbs.base)
> > >  		return 0;
> > >  
> > >  	chbs = (struct acpi_cedt_chbs *) header;
> > >  
> > >  	if (ctx->uid != chbs->uid)
> > >  		return 0;
> > > -	ctx->chbcr = chbs->base;
> > > +	ctx->chbs = *chbs;
> > >  
> > >  	return 0;
> > >  }
> > >  
> > > +static resource_size_t cxl_get_chbcr(struct cxl_chbs_context *ctx)
> > > +{
> > 
> > The core logic of this looks good, but this wants to be shared with the
> > upstream port component register discovery.
> > 
> > Full disclosure I am reconciling these patches with an attempt that Dave
> > Jiang made at this topic. Since your series hit the list first I will
> > let it take the lead, but then fill it in with comments and learnings
> > from Dave's effort.
> > 
> > So in this case Dave moved this into the drivers/cxl/core/regs.c with a
> > function signature like:
> > 
> > enum cxl_rcrb {
> >        CXL_RCRB_DOWNSTREAM,
> >        CXL_RCRB_UPSTREAM,
> > };
> > 
> > resource_size_t cxl_rcrb_to_component(struct device *dev,
> >                                       resource_size_t rcrb_base, int len,
> >                                       enum cxl_rcrb which);
> > 
> > ...where @which alternates when called by cxl_acpi for the downstream
> > case, or cxl_mem for the upstream case.
> 
> Ok, I see where to go here. Could you point me to Dave's postings you
> are referring to? I checked linux-cxl and could not find anything
> related to RCRB or that changes regs.c.

He was in the middle of tidying them when you posted your series, but I
think it would not hurt to push them to a git tree so you can grab the
bits and pieces you want.

Dave?
