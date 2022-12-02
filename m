Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89F463FD0E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 01:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbiLBA3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 19:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbiLBA2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 19:28:49 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42AEDCD78D;
        Thu,  1 Dec 2022 16:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669940631; x=1701476631;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jx08TtEYNeYqM65uIb6Fo6H1XybhlChNwaglLtx7E0I=;
  b=EujZTfHWQFCPxMlp2keaeFFiHN4zGO3+2Iyce3Ao4obJmbBzUFwbfzMc
   jGZVt5BzUytEIF1ZVqvG5eh0y34b8SAcb3HXacC4v296D7heOFDPAwbIh
   sxcsa+28ioZ4wKKmHl1qwV5bY2TfwsKiPqeq0rSy1HNS4K5xZxayKEA7V
   sFFTMCsiCwob2DaQqQmVGeVndUxYRTr63QxDgqeKOrQNqVweICUSxa/ht
   h/AcImNnTN8/ZnsCYHM/N0oRNYayB12t/4FuwLRdXjIgZwFmiX74mu3eV
   wmmAdlzkwJaejuPb6LKJjDa3Yb9rTbDP/AYy/Q2vtGEG76lojzhdgrnfi
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="296186568"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="296186568"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 16:23:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="713422754"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="713422754"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP; 01 Dec 2022 16:23:39 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 1 Dec 2022 16:23:39 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 1 Dec 2022 16:23:38 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 1 Dec 2022 16:23:38 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 1 Dec 2022 16:23:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ie1CXF2vJ8IqsrLkIEAoXkjLxasqJxNCk4Abcf73Jl/Sq987Pk3Go2NzjWOQAdBd7NhvVrEpWKh3LbaD3pM0TJSTmktxhz6ClsLKx/NFSf8dZKDsIe47YvZ7ueAi37SGGQyfwXY5kdkKEinb/AQWE9eojP6IpOG70k0U4wrwz1wjchOCxWyt7G9GKbBG6Ip46vJVJXuOLWwkvC4k8sQk6jZa4jmOqH4qAqqH/3wnIdth16FcM35rpdvz/kvTZNoiXCoTFubdeG1cDm1EYxl6wvTO2VhMVoJsSvIRNy6aYKEPVQpLRedXYy7FxK1xs4u+WSdr/N69609jByHCQMfiFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=brV9GKBx6NgLJCM3L9OG0MqK9RKHgg7nguJpOuxXmcI=;
 b=OGsNtJsU3MaJBvseeky31oVL1AIpCg9Jm8SROjKgILRywlahvFOK5JOMrC8SWSg1PKjNSdjGtO3tijc7DpWbU2yWjmceCvOvqPjMXS/CN6mcCEn6crg+E1/VIwFBZDg05FrkC8K28cpvvZApSPg1TH/pMJCT7g1OR2o2eq8gvbLWfZU/dP67MhETVEpao+hv5n2GR9YgtHSsjYAxHferOMGilTJ5w+TauYyWYpDNxNLvuAoWYSgoycdLAgEjCPVDasAdFQNpgEsBYScmmN3k+Ke8uitAX7/24TsyHzBMLNbnaDddH3Kq4ycWElKYukPciTrW2irncpIFJOxm/Hk9VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by CH0PR11MB5457.namprd11.prod.outlook.com
 (2603:10b6:610:d0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Fri, 2 Dec
 2022 00:23:29 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5880.008; Fri, 2 Dec 2022
 00:23:29 +0000
Date:   Thu, 1 Dec 2022 16:23:21 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC:     Davidlohr Bueso <dave@stgolabs.net>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dave Jiang <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH V2 01/11] cxl/pci: Add generic MSI-X/MSI irq support
Message-ID: <63894579bf550_3cbe029458@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221201002719.2596558-1-ira.weiny@intel.com>
 <20221201002719.2596558-2-ira.weiny@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221201002719.2596558-2-ira.weiny@intel.com>
X-ClientProxiedBy: SJ0PR03CA0172.namprd03.prod.outlook.com
 (2603:10b6:a03:338::27) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|CH0PR11MB5457:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ad93b26-b386-4d77-90d1-08dad3fb6fd6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4xjexBOXYShUikgnCyZAB7kzZ7xfLm9Yg28sHedQcQbsecb1SfHXwIca9/fPjyey5xVYn78KswONic5Fx5tsk2MD83D+4K9DB/kOMMQEb94BB6PJ2VmL8cbzjX93kXabTFyPZdQwvCWYaRWpcgrVaHv5py/3VIvRMToxoXLx71ovlsmOmRtwW+Vm2d+iSHpam1O1jpNudTDWNNzoXm7FxUYOiD88r9/bm3350si+elXpXiEL11hFBTjBXorvcvVa4QuxunV+NFYuyBgLwcEF9HcjSRtODkzWKSz8fsftqSNoVv0zbqm01F1p5kZVpKHD+diYPGmzRfROCyBrXJ6OBDbxjAgKUGcoddiM277WgveeHqkEXDMSwT+c7SdZB6U8OwCcEyQC8h5cF5+w/iI8YuTETVt/UIP/EHcLfzAFvBBt6lcNh0cYQxB5OaRbooxSPt6XwsFeX8g7gJy4+0FqCZ6wy1skTijm+VRXlMhL/BKrhNJqRlu2oT14xpgciYjPMu67FQPSRS19HbpnR+5vFmFuO0ukd1A269LdJ7E+tX5FG2bMW2EToV5LgXe3oocIfexAXeHW/Q9A67x1TKr6s4VqY4Lq/F6X8Yss+ZSqFP7B6nB3p5q0VZpnGO4DS2AbUpKqHHRsTlQssxxgN3Y99KeK6eVDG4uIE/JU5wdJnHboxgrb4YT/QfB5iTAJn4Cv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(396003)(346002)(39860400002)(376002)(451199015)(66899015)(83380400001)(6512007)(86362001)(6200100001)(9686003)(6506007)(6486002)(38100700002)(82960400001)(186003)(5660300002)(41300700001)(26005)(6666004)(478600001)(66946007)(8676002)(66556008)(66476007)(4326008)(6862004)(8936002)(54906003)(316002)(2906002)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e5+qfybx51vk803eXqY2G21yCjWtm6xYYDb2+FESuwnEX9QW87bpUCiACX3e?=
 =?us-ascii?Q?5jBGcBiNAVqEpCM/h/knQwdoBckEeSdq/J42EM4lZ4nM8R2sluFuSW45hDIu?=
 =?us-ascii?Q?5KeMJ2Rdstn72BSMCfJbYgv54QTqLFSqkyeR+g+SZITmlEambVDLNtkh0+wu?=
 =?us-ascii?Q?NujQE9npwc43WIO88mDBWAb5UqyyfwsU59cLx2o/HF2NNeuxGpr7uD4tpqA6?=
 =?us-ascii?Q?dQciBfZ7psQpRxU+AL0gzTpyFs/t6i8RL35stdNtJskDKNCWY0Dp3qSJD5aD?=
 =?us-ascii?Q?rIburv4TY5SdOhESKikXoluEp4ah2N1BRtDrMJKUW/JxUuRZDNLOVmmrtZeW?=
 =?us-ascii?Q?wgUKcOIC/NrUuoTyoFSJJnGrUgDC5fjZdtn0m7SPgBTb28le4txMJ3ue1Enx?=
 =?us-ascii?Q?Ddce0lqUqJdbuydQiuP5n7SyB2tVk9N69+49FbcfNOb56+5aCMhi5dFc3QZo?=
 =?us-ascii?Q?L0/Smn7fSihWnqb3z8TmvwG1yljBORj/bkmGWQKPwwoEVlOZIOM56Cw5T2Cw?=
 =?us-ascii?Q?2t81OGhRWmPxOCNoiQ/46yTCSAoZ5F7v9DCn++rlZ3SfvUPyJcBhGLf7DWs9?=
 =?us-ascii?Q?pT0awEzhxxE5P/ernKwC5zMWfAXerMLDtwBxGGKhthlVlMdC9FOTDJxDmvJo?=
 =?us-ascii?Q?K7HQ2yUeqh7sDHi1sUzquc8eW+36eG1nwdrgKw7gTgwIr11uWs1T0+LhqdnB?=
 =?us-ascii?Q?GM7emi9qZ50P688xvkPkYgpLG12Z5h8y0ZwFAGag5lRtS0n3trbMljGYCSkt?=
 =?us-ascii?Q?4Cc2muZVb7RWGjCztoBhz97tSxwST+HHGVeAHV0A+lp8AU71DQP/E+BFBa0J?=
 =?us-ascii?Q?hzla/1CqfEA8t5vbEgg5BTsBKfjD7+xSe4t3ME2LK/OaUAwqcL4AawGoCgu6?=
 =?us-ascii?Q?WNF6+0bMZpWv31sUw4MsWTLIgm4f6XcxYzsQYgqt3TTo4b6TqCuprMUTN00P?=
 =?us-ascii?Q?82UnonZLN5uKxFHV/Xgp20hkoEJs30mXd7KDT5BHiCb+iH1j3OMZj2R50X19?=
 =?us-ascii?Q?yEh8ao3g36ayNcUWHhXqQy+3e6NPiuZC7BD/fPfsGUEddAqDMFgNjtUPJg0M?=
 =?us-ascii?Q?gN6jV425agGPJvH1cj2DdRpmWWDJGLH9aT5rjOtmuHOiX7ikc4ATPF2LD/QU?=
 =?us-ascii?Q?3qzWyy3t+rNB0Mk2+xXPXKmbHh7S6S0z2i2H+QEs79Rd1edN8/+TfQw94Hl9?=
 =?us-ascii?Q?x2GDinrPpPR2kEwXfUg9e8VGQgc42sVDbGPJ2Pc8KbpDR/rGWbPrk5KQjE4e?=
 =?us-ascii?Q?sEiYGksF9FKoBJKBMKn3u0GcC9tgX6oijtZBgiZlwYoWg4/41im3eA2S1MnB?=
 =?us-ascii?Q?yqtDp1DwCqjBAzzbqwB6b33Rt6WBqYbr9jQorSl3p26xNrwFI3pEg8RCPZD+?=
 =?us-ascii?Q?Zrs/QkrmFQP+0h7gu6uoCX+HZQ6Hj87sFZwHZySPFCG4bZPIPmKoxUAh86mC?=
 =?us-ascii?Q?WbJL3622pB/1F6eS6oV9658KRDeMzQ8AOqQBk714fuZBqtBu9xE1jExvo/+o?=
 =?us-ascii?Q?xW7/v3llGmgmbFXZEvFu+D6d1juxxfBjG4T1fFpnpsUzHZxtimLB6Km01IHI?=
 =?us-ascii?Q?1N3oTJtGlyNQ8rCDjAanIXd8RFWMGg2ZjQAFYRYi5Mmec9lSp1893k1RrhW8?=
 =?us-ascii?Q?xA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ad93b26-b386-4d77-90d1-08dad3fb6fd6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 00:23:29.6368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oMuECQauUQxeuEoNaJPp65JWfzr4c54QsL2pCer1Rh18jtL2FtBywedMWUZ0A9tQk6dOAz1vuNPxeMTT+qX8COEDKuPJOZWDWZZ4nL/Lkqk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5457
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ira.weiny@ wrote:
> From: Davidlohr Bueso <dave@stgolabs.net>
> 
> Currently the only CXL features targeted for irq support require their
> message numbers to be within the first 16 entries.  The device may
> however support less than 16 entries depending on the support it
> provides.
> 
> Attempt to allocate these 16 irq vectors.  If the device supports less
> then the PCI infrastructure will allocate that number.

What happens if the device supports 16, but irq-core allocates less? I
believe the answer is with the first user, but this patch does not
include a user.

> Store the number of vectors actually allocated in the device state for
> later use by individual functions.

The patch does not do that.

I know this patch has gone through a lot of discussion, but this
mismatch shows it should really be squashed with the first user because
it does not stand on its own anymore.

> Upon successful allocation, users can plug in their respective isr at
> any point thereafter, for example, if the irq setup is not done in the
> PCI driver, such as the case of the CXL-PMU.
> 
> Cc: Bjorn Helgaas <helgaas@kernel.org>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> 
> ---
> Changes from V1:
> 	Jonathan
> 		pci_alloc_irq_vectors() cleans up the vectors automatically
> 		use msi_enabled rather than nr_irq_vecs
> 
> Changes from Ira
> 	Remove reviews
> 	Allocate up to a static 16 vectors.
> 	Change cover letter
> ---
>  drivers/cxl/cxlmem.h |  3 +++
>  drivers/cxl/cxlpci.h |  6 ++++++
>  drivers/cxl/pci.c    | 23 +++++++++++++++++++++++
>  3 files changed, 32 insertions(+)
> 
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 88e3a8e54b6a..cd35f43fedd4 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -211,6 +211,7 @@ struct cxl_endpoint_dvsec_info {
>   * @info: Cached DVSEC information about the device.
>   * @serial: PCIe Device Serial Number
>   * @doe_mbs: PCI DOE mailbox array
> + * @msi_enabled: MSI-X/MSI has been enabled
>   * @mbox_send: @dev specific transport for transmitting mailbox commands
>   *
>   * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
> @@ -247,6 +248,8 @@ struct cxl_dev_state {
>  
>  	struct xarray doe_mbs;
>  
> +	bool msi_enabled;
> +

This goes unused in this patch and it also duplicates what the core
offers with pdev->{msi,msix}_enabled.

>  	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
>  };
>  
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index eec597dbe763..b7f4e2f417d3 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -53,6 +53,12 @@
>  #define	    CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK			GENMASK(15, 8)
>  #define     CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK		GENMASK(31, 16)
>  
> +/*
> + * NOTE: Currently all the functions which are enabled for CXL require their
> + * vectors to be in the first 16.  Use this as the max.
> + */
> +#define CXL_PCI_REQUIRED_VECTORS 16
> +
>  /* Register Block Identifier (RBI) */
>  enum cxl_regloc_type {
>  	CXL_REGLOC_RBI_EMPTY = 0,
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index faeb5d9d7a7a..8f86f85d89c7 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -428,6 +428,27 @@ static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
>  	}
>  }
>  
> +static void cxl_pci_alloc_irq_vectors(struct cxl_dev_state *cxlds)
> +{
> +	struct device *dev = cxlds->dev;
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	int nvecs;
> +
> +	/*
> +	 * NOTE: pci_alloc_irq_vectors() handles calling pci_free_irq_vectors()
> +	 * automatically despite not being called pcim_*.  See
> +	 * pci_setup_msi_context().
> +	 */
> +	nvecs = pci_alloc_irq_vectors(pdev, 1, CXL_PCI_REQUIRED_VECTORS,
> +				   PCI_IRQ_MSIX | PCI_IRQ_MSI);

clang-format would scooch that second line in for you.

Might also be worth a comment for the next person that goes looking for
why this isn't PCI_IRQ_ALL_TYPES.

From CXL 3.0 3.1.1 CXL.io Endpoint:
A Function on a CXL device must not generate INTx messages if that
Function participates in CXL.cache protocol or CXL.mem protocols.


> +	if (nvecs < 0) {
> +		dev_dbg(dev, "Failed to alloc irq vectors; use polling instead.\n");
> +		return;
> +	}
> +
> +	cxlds->msi_enabled = true;
> +}
> +
>  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct cxl_register_map map;
> @@ -494,6 +515,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> +	cxl_pci_alloc_irq_vectors(cxlds);
> +
>  	cxlmd = devm_cxl_add_memdev(cxlds);
>  	if (IS_ERR(cxlmd))
>  		return PTR_ERR(cxlmd);
> -- 
> 2.37.2
> 


