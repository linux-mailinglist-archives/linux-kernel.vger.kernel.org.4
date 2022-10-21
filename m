Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D1C60807F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 23:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiJUVFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 17:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiJUVFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 17:05:34 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB0719ABCD;
        Fri, 21 Oct 2022 14:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666386333; x=1697922333;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7dJmpMGVVdsvZIFDGWtxLOPyG2P5m8hOb/YZt1V4ghg=;
  b=cKtQU3SEYTTJ4K63uyYoi/yEOWW1Ljb/9UR64v7qgyiZTbBTDHYwZzDQ
   HC0/4q30ZbiS/B+5nVtAaGVh6bVFYzwSdLF1tSY6asDOyXiOJUCsDVGre
   Ao8nWnRJWvudiGTAc7DpCT4dYlcsDbBFzGx23Qy53iPfD5tFwi8dDjbR5
   Nc9Vcj6fgY/LILUbHBZTsYY6hNKlWqnYqU+8UKhRokaoDUvDwrN7uCr/E
   KKuaFx6bvwJo0fAk7w1Jar5NgUEjuzqh5oaRBfgBgv2avuWavngBIB/Hn
   1BiHO3cm1IjTtfS/7H4UVJiMCSb9jm/RlXAq9zqAJI9HwmEdXne1fIZQR
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="308789631"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="308789631"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 14:05:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="693871801"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="693871801"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 21 Oct 2022 14:05:22 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 14:05:21 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 14:05:21 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 21 Oct 2022 14:05:21 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 21 Oct 2022 14:05:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k67qudFHY8UUFH/LPz0UIpCI1cFFzzta9NOYk/UKHhPcWScidiRgTpBeE/C6kaRy1TXW2ukQrX1tmlSBhwK/RcDqcI/YiNmOzVMigvacyolD8J22ynivOzGBBe6LdE+klIXoF1c7iJ7rsDkOOLcymdB3af9owR/rr7Rnpdom3IqMKJAjfnBCGtypMAALgGVCc1pyS8Me9OvArc0aR03HY6L2H6ktSbpjfE/PJKQtmpOH6/Z+VMa/SBYl/19F3ISB6QSUttkeeI/6F02GAtVD8Bxs705gl3Xi39+t5M3lfAk8HPBzocW9eA88kdVoLKux0uN7BoXdRmkc9RfslhEKhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLGm0kxY9nPRyXGGV3yFJr1etskK7yshyLquHdvGuYo=;
 b=EWZPucpsf3wdsO78s3xmk8MEh4hgwoN51ERvphA1dMnUMizByS0XsPWjGtJy8gUNEqmdmLDNGv7sfljFDfqcfuwnBQ0ixeD9PhFe4qlza7jF7ykNQ5HjsireIhMpC3EmG6QGI5mcp3tcXJkBm3i5DQM6kyZ3LhiU5pQLarD7QACeWZjkW7U3O6b/G0pWPRk+Qjt+iUecqfjWfBxeT1BpbTEvnUBzGG+43m3qopRYa+sWm2tuvxgDlaVwb6idj1+1HKdVrniBYv+0vr3odZvMgLHZv/BNCBHTg/KoEiQB/gdu2R0UDB4ftsvqZ4X6QSxPuU1JZM5941C3rJV0hW+Mew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BL1PR11MB6051.namprd11.prod.outlook.com (2603:10b6:208:393::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 21 Oct
 2022 21:05:18 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae%8]) with mapi id 15.20.5723.033; Fri, 21 Oct 2022
 21:05:18 +0000
Date:   Fri, 21 Oct 2022 14:05:14 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <alison.schofield@intel.com>, <bwidawsk@kernel.org>,
        <vishal.l.verma@intel.com>, <a.manzanares@samsung.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] cxl/pci: Add generic MSI-X/MSI irq support
Message-ID: <Y1MJigL3JXwjgQbs@iweiny-desk3>
References: <20221018030010.20913-1-dave@stgolabs.net>
 <20221018030010.20913-2-dave@stgolabs.net>
 <20221018103619.00004c39@huawei.com>
 <20221018115227.00002a4c@huawei.com>
 <20221020223125.hyrfpt2noiicisxa@offworld>
 <Y1Idsv0Nuu+V9aMj@iweiny-desk3>
 <20221021094931.0000795f@huawei.com>
 <20221021162055.nuxvfdrfhv42nlim@offworld>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221021162055.nuxvfdrfhv42nlim@offworld>
X-ClientProxiedBy: BYAPR07CA0075.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::16) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|BL1PR11MB6051:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cafde85-dc14-468a-5508-08dab3a7f57e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZUPzHWH/plMV+gD8o1rq2UHaMGyiWvh6WFN55qRn4iR9JngRq4LYmvjGvVhm/TDaTlz0yRTIeuJuq1AkHfhvtThxWSWk3NIP04q04iZB3e4/vG7axallVQ3qs9UudUMrd2x0rw6RljLsLQ/WXOprS6TOtuJodf1hmZIwFOx1TTHElz41PRYMLx+ybITqJQosxb+y0IGK/2AlIKKMQEmo98zMEtW+wJrYjeXInG9ExUh9widTm1GmRzlgk4I//4JjdKpT0enM3YavsQKgrlaXTC+3VmcSX0R0qvjm7V8PwRyyKBmpfDf17G/4HRaWUmOkNBnSrCgQodTnwCv4BJ9gGetoPpS5hsoaQa+miE+XcY+BFa1r9G1zchLn5C4aLiEbh4Q/RBiFrYDIGuBgWm/oplrXvgiE8UwlhZ/IW0L4qu9Up4wYJFYMoXNYjE5aCtWZPzQoDCwneVbZOQg6RhsZ8Fr503OlulyDE4IKkWRbSUlgzouHXqu0vfnHqStsfrn0YJhVEFiGZ4OF0xtiXvijPWRX9hc5IYSjw7Kt/7/6bIt9AcCjyUcVWiUgsnLTfQCB35iVg8zBuGc3GUZxXcD5KEVLzohlOH5phDMgkCK3mAnbOZybNoXXP3FBKVydnEGDqggs5UStf78Ij3vYAQ6vBSaStTV49T4kL4oDLDYTUYQ7ATHEZOhR0bPSmQobASJ+w4K/TnJCQPWPkvULtLl7GdmaqklwE2fql/OWqbQFe5MUYOLI0HR+DkiQtpTN8rn9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(39860400002)(366004)(346002)(136003)(396003)(451199015)(66556008)(44832011)(5660300002)(8676002)(6666004)(66476007)(66946007)(4326008)(186003)(6506007)(41300700001)(82960400001)(2906002)(6916009)(38100700002)(33716001)(316002)(6486002)(6512007)(9686003)(8936002)(83380400001)(478600001)(26005)(86362001)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qj2tLikeyaQw7shs99IWC/cGHOEoynKPrBoOpz4vF3ix2qKhQrbRWIrvBaB0?=
 =?us-ascii?Q?IiWuJW7nCG3PYlFivBSA/RdPm6BxAypie8hYrckCmnLyNleD42RT6/b6Iz98?=
 =?us-ascii?Q?tJDSQwb3E8LM/+F8jfeCYCmBMNdmfMEcnu8nKTvCmJT++vD1SwTtMWMe/ONy?=
 =?us-ascii?Q?Jm3N3VQNWoFTxAb827ipSxhFgEwNL5Hg611b+BywZYlQ9q6TdoVVAU+hgy2U?=
 =?us-ascii?Q?VSgRzZGaZN6D8Lh7+boyAZOTIsCgxe+tEu/Bhc2uDHu0Ac2YDldcQNQhw89x?=
 =?us-ascii?Q?FaAvREaCyoR5WykYnNIaq+BTNfipOXHpIXHvr/Imaerd8mewBUZbOL2N5Y6p?=
 =?us-ascii?Q?eL7L+f6SGlYglEgTDtyilzV+acsqno8SwVWrjr63x4iiD6SER5sf7UbpuaHF?=
 =?us-ascii?Q?S7M0TbYQd1fqs7Hdl+ByjclYyI38ksms0JoI24oj9n3Joxr7Im+23pfvWwCE?=
 =?us-ascii?Q?5aD6T/bGT0Mqm4/Rcmsz+lOTFk296VOVkLBrAwKXZAHruFZfxfgyQh63mbf8?=
 =?us-ascii?Q?xVe6Die3+ptOX1d5gF6VxJRzh7zXwqyxWJN7ZvwvJBBw1NQK0Q/lG2Oa4bmP?=
 =?us-ascii?Q?QbA4VhrVMMt0cLsBDYnJj43d6UoqGmnTa/FVwy96vQSZ9CLeaC7TuVC9QvIQ?=
 =?us-ascii?Q?dAQMG+qr1caUUPtV+PxPmSmVQEZFbRZTfNatsCHC1Q5DNGaxJDaGCai2XQr6?=
 =?us-ascii?Q?wm3Uvva7bNQcjV+lEgmeDcAWYlj2t5U+6LWmvKh082BD8q5hbmRJdVaTmgxn?=
 =?us-ascii?Q?F70FHP/WhobDUo6GgmvalGWVVIKPqEdeWbfySjiqL6yP23iO3oMIw9dibbKJ?=
 =?us-ascii?Q?YNEeWY7LKcRn3u9BLS6HjWLAkl7wwYJ8Br0WVZyyOC2jKSLw6gK2kDEhxKEL?=
 =?us-ascii?Q?XgVAlkmTttoZpV3cDwllDNBL4K/cvKVTEVUJrgqS0teDsQKUjwXMJZW9mMqj?=
 =?us-ascii?Q?QTvAkYZqAcsBmMq8UDXruOMDavQiG3LiWGsQMJZ9CLn7LPFtHiYPbcdPQT7J?=
 =?us-ascii?Q?XBAqoKJpF3/9ACMgpp8cfiSW1Mh53FVo21iYc4jvu54SFcY01Ofn2chdotcb?=
 =?us-ascii?Q?+++0akJz21rXZa8t+Tz/KE7HMSrH2DipiZ3IiUpfmkyKE1SH1R0n5XwjoO8J?=
 =?us-ascii?Q?vmzWYaYu8kXErIvgxRo9Bl+DjwZQijfJE60x917bQnOETRwjX17yAEyGpnBr?=
 =?us-ascii?Q?pcucMRlj0cbB0mLipPvcEIuPv59VykRz+VLTYaBEFJ+S97e7UEjD97Y6IX+k?=
 =?us-ascii?Q?ADAGxXyD8pWXxvQ1lURo+wR5Zpo7/IIgdVqp+Gd/s7YjH55tfuHe53KvhZMr?=
 =?us-ascii?Q?50GwITeco/GkNpbNF/eC4jtk56xRjenkZjZiVHsbT3ai+W+zT5xF1PlUQKKp?=
 =?us-ascii?Q?HdmvtLC5/tRtFoT8OR0Ixng7RAft6fvXKRqUFo6Wl/2GDSJBh/QY5DGP1V+s?=
 =?us-ascii?Q?fK5CEMNpcPe7SMbjKTeTDC+Tgmfk8tFYGW1nndLFVLqoj0TCyBC+LHLuq65O?=
 =?us-ascii?Q?t+xu0D36RVa0seeO6qMMdDffMRR0AKNeWA88qnIYlGo2Z/Ob+iW6Jdp6OSjb?=
 =?us-ascii?Q?igQLAMGhOog2seulQli9LT2+CLHXeOwiis3WJIbT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cafde85-dc14-468a-5508-08dab3a7f57e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 21:05:18.7984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dMpp2gXF7YoM3c0PuUqPFLSTQOLXg41rVfzSNdF/1uehrHOuA+wFBQRE58qQgFRdHKTs1/+K+59MO9FTObdezQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6051
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

On Fri, Oct 21, 2022 at 09:20:55AM -0700, Davidlohr Bueso wrote:
> On Fri, 21 Oct 2022, Jonathan Cameron wrote:
> 
> > On Thu, 20 Oct 2022 21:18:58 -0700
> > Ira Weiny <ira.weiny@intel.com> wrote:
> > 
> > > On Thu, Oct 20, 2022 at 03:31:25PM -0700, Davidlohr Bueso wrote:
> > > > On Tue, 18 Oct 2022, Jonathan Cameron wrote:
> > > >
> > > > > Reality is that it is cleaner to more or less ignore the infrastructure
> > > > > proposed in this patch.
> > > > >
> > > > > 1. Query how many CPMU devices there are. Whilst there stash the maximim
> > > > >   cpmu vector number in the cxlds.
> > > > > 2. Run a stub in this infrastructure that does max(irq, cxlds->irq_num);
> > > > > 3. Carry on as before.
> > > > >
> > > > > Thus destroying the point of this infrastructure for that usecase at least
> > > > > and leaving an extra bit of state in the cxl_dev_state that is just
> > > > > to squirt a value into the callback...
> > > >
> > > > If it doesn't fit, then it doesn't fit.
> > > >
> > > > However, while I was expecting pass one to be in the callback, I wasn't
> > > > expecting that both pass 1 and 2 shared the cpmu_regs_array. If the array
> > > > could be reconstructed during pass 2, then it would fit a bit better;
> > > > albeit the extra allocation, cycles etc., but this is probing phase, so
> > > > overhead isn't that important (and cpmu_count isn't big enough to matter).
> > 
> > I thought about that approach, but it's really ugly to have to do
> > 
> > 1) For the IRQ number gathering.
> >  a) Parse 1 to count CPMUs
> >  b) Parse 2 to get the register maps - grab the irq numbers and unmap them again
> > 2) For the CPMU registration
> >  a) Parse 3 to count CPMUs (we could stash the number of CPMUS form 1a) but
> >     that's no advantage over stashing the max irq in current proposal.
> >     Both are putting state where it's not relevant or wanted just to make it
> >     available in a callback.  This way is even worse because it's getting
> >     stashed as a side effect of a parse in a function doing something different.
> >  b) Parse 4 to get the register maps and actually create the devices. Could have
> >     stashed this earlier as well, but same 'side effects' argument applies.
> > 
> > Sure, can move to this however with appropriate comments on why we are playing
> > these games because otherwise I suspect a future 'cleanup' would remove double, double
> > pass.
> > 
> > To allow for an irq registration wrapper that turns a series of straight
> > line calls into callbacks in an array.  The straight line calls aren't exactly
> > complex in the first place.
> > //find cpmu filling in cxl_cpmu_reg_maps.
> > 
> > max_irq = -1
> > rc = cxl_mailbox_get_irq()
> > if (rc < 0)
> > 	return rc;
> > max_irq = max(max_irq, rc);
> > 
> > rc = cxl_events_get_irq()
> > if (rc < 0)
> > 	return rc;
> > max_irq = max(max_irq, rc);
> > 
> > rc = cxl_cpmus_get_irq(cxl_cpmu_reg_maps);
> > if (rc < 0)
> > 	return rc;
> > max_irq = max(max_irq, rC);
> > 
> > ...
> > 
> > if (irq > 0) {
> > 
> > 	pci_get...
> > }
> > 
> > //create all the devices...
> 
> Yes, this was sort of what I pictured if we go this way. It doesn't make
> my eyes sore.

Ok

> 
> > 
> > > >
> > > > But if we're going to go with a free-for-all approach, can we establish
> > > > who goes for the initial pci_alloc_irq_vectors()? I think perhaps mbox
> > > > since it's the most straightforward and with least requirements, I'm
> > > > also unsure of the status yet to merge events and pmu, but regardless
> > > > they are still larger patchsets. If folks agree I can send a new mbox-only
> > > > patch.
> > > 
> > > I think there needs to be some mechanism for all of the sub-device-functions to
> > > report their max required vectors.
> > > 
> > > I don't think that the mbox code is necessarily the code which should need to
> > > know about all those other sub-device-thingys.  But it could certainly take
> > > some 'max vectors' value that probe passed to it.
> > > 
> > > I'm still not sure how dropping this infrastructure makes Jonathan's code
> > > cleaner.  I still think there will need to be 2 passes over the number of
> > > CPMU's.
> > > 
> > 
> > Primarily that there is no need to stash anything about the CPMUs in the
> > cxl_device_state (option 1) or repeat all the counting and discovery logic twice
> > (option 2).

I see what you are driving at now.  But I don't think having irq information in
cxlds is a layering violation.

> > 
> > I can live with it (it's what we have to do in pcie port for the equivalent)
> > but the wrapped up version feels like a false optimization.
> > 
> > Saves a few lines of code and adds a bunch of complexity elsewhere that looks to
> > me to outweigh that saving.
> 
> Yeah it's hard to justify the extra complexity here when the alternative isn't
> even that bad.

Lets just do this.  I don't think it matters much either and I need something
to land before the event stuff.

Ira

> 
> Thanks,
> Davidlohr
