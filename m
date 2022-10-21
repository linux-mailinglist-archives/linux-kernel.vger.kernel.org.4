Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884FF606EBE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 06:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiJUEPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 00:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiJUEO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 00:14:58 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5432CDE3;
        Thu, 20 Oct 2022 21:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666325680; x=1697861680;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7S1SGRvLVvKQKL/FrIfdqHRgxMfuH0nOHbxIxttHrHU=;
  b=abOuQsLbW5vGwr7DA22jp56YE1Mqpbft8DBjVF1i3WIFgbJmOiEoyeKl
   wE+26MTu12Hf3q8V0OVLx+h9mp4l8SY9vhGnzZAlEY4IPSSKOz144k1t+
   +Xl3r0G6hSvSAogVH5XV3Kvq+yi+ArIAjj0AMJOQ2ks7de6NRFMb8clmB
   qqNGIK8uWU5y1XjREtj+IoYCubQ8ZiBR8qsFy9cjQVnLvK0j/RVm0hLjn
   zcpMslXTGlKMzs1BE7TscHjign5iGwwAvWTkXJWF8H1rRlT0X/aMqD354
   mngXcOBMuQK2yE5EDbWbbFa1q2VFZK4SKy6vkRIcFnOwJRt4CMaQ4Vls4
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="287307136"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="287307136"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 21:14:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="661361432"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="661361432"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 20 Oct 2022 21:14:37 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 21:14:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 21:14:36 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 20 Oct 2022 21:14:36 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 20 Oct 2022 21:14:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HzUvBSkH87VzLjTcWTIRJs+RYecY8N+U8AEOcERFMlPONd9cdAOOdJ8GE5C5z54zgp8xD6I3UpxbuA4H5jE2EnJu8+5Z3w0qMJCJqqNubhIc5I1DWnrUmsV8pe6f5GRm8PPre3+GRVMTt/yXrB1kUAtTEfKpSb6u7wVxFfbfbG68QwBb9q/dtxhYBUZ+bBRyXriaFaZcqJ49lvSTYh0iHbBlqZOoQzsSuBeTRI4xtuLks8M4mZBTQvdURLSWa13wbX6hx6rYj8gglxO2fa1FDkZkdp3PoqksUnmRIr56CELcsQ9HD54pmy3PZU7L72/Cx6Gyw/0WEEyg1FJuDZeGlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tEyXePDhHb2Rc6GyyL3vwc2ykHSUvbXv5GqunujpMQ0=;
 b=Fou9/tuoDEeYZ03hALGHSQ94R+ybh0KHoJASM35/mFuSj47nJNrIMA7YzU2mj7pImdyAUi1MWp0c8gELxRYIPs8cJWS7LllIa4+Va7FF5ecgaD801tVyqd+SMGFItuFddo/DB1gXbNupcE5EQBO8Xb8FNUFcbRkJKQyL2bUrxzndN0vpZmGSrkrK/SIRUqnwnbtZLZCTeGQMhD5NwJ+rf+GD4HpwIc6ep5WysSCkF2c52ay/2JnhGxbKewa0QCj8vGEa4OEiVGBtgxg0Cnw3/CPaquigL4LnpSO9+cm9/v8HnWKqZ/7SP4+harsnl6eKktuKY5KiTBxKY3v0h+shEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM8PR11MB5605.namprd11.prod.outlook.com (2603:10b6:8:26::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Fri, 21 Oct
 2022 04:14:34 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae%8]) with mapi id 15.20.5723.033; Fri, 21 Oct 2022
 04:14:34 +0000
Date:   Thu, 20 Oct 2022 21:14:29 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Davidlohr Bueso <dave@stgolabs.net>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <alison.schofield@intel.com>,
        <bwidawsk@kernel.org>, <vishal.l.verma@intel.com>,
        <a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] cxl/pci: Add generic MSI-X/MSI irq support
Message-ID: <Y1IcpaodrrVrkEcL@iweiny-desk3>
References: <20221018030010.20913-1-dave@stgolabs.net>
 <20221018030010.20913-2-dave@stgolabs.net>
 <20221018103619.00004c39@huawei.com>
 <20221018115227.00002a4c@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221018115227.00002a4c@huawei.com>
X-ClientProxiedBy: SJ0PR13CA0132.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::17) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM8PR11MB5605:EE_
X-MS-Office365-Filtering-Correlation-Id: 880bdc61-9cb7-4b3b-508e-08dab31ac299
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u13YEv1/UBDKGDTXmZ+b2wrL4VjDzvefV1SkpptvyTlnxQAjLRbdRmE7xb3hdzGbe2JGZWk5G6S6frW9ZzDqcNURgGUREQKeopJeR1ZA37NeTD3jBCAN+1Qy5jLl9jGiQ36GKhIeITTTWuPd+ECPbRLfgNDeVOu35DKyX8L515bIehDPs51m4ztrVqsBQYB2Hi1CUipbsEGLoHxQ68+EfKYl4MUXPpQXsSDXh65KdQyUUIEYlGW6jOyOlOzXTMsAIU2FEmWpgRbOteEpWxWS2RV7qQwy5viAbkCZUKF2A1jXa5l5eAatfsDOo2RJhRLD4HlnWnaGagh3PVgiANZEFsj/XbZqdJC9VfuV1aYi3d0n6O2DNrgPeuq6Q5GYaM6sKQnpGbK5HWhihSk7z3iE7s+F/7E5X5CYcu7RGhNVq+LyGFhljPJVzNBYPp7XXm2Z0jFMhtCGv7qQE4gfbEB0ysu5BeKQWqIe2gxAU2qW/3pzo1XPPibTYXQTTnI6FMA1Hcrs2J6G89RIcWeu7lpU5Jn0I77AiVK+ynWufMuTZwjKXiWTHY6Kjq7pmo/xevroy2QXqr2o5Y918+NY+2WlqZSw5VtULsWfdIYEeeZJN8W8CcIbf4FXs1sfLAVmcQPwBJVg+TOsR0ng6+r23Al1mRBCuFWnWUBOQfqXnxgkWM5ycWVpsrZpPKVcPeA+hMg2I6VrUgMd6xF5iM4ySVrswKWUXBTSesizgm/M6W5HGB2LIE8OLMFJIpPbvsElbz09xq4+io743DbGSRlmDVugRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199015)(86362001)(38100700002)(82960400001)(33716001)(6506007)(2906002)(83380400001)(316002)(478600001)(66556008)(6916009)(9686003)(186003)(6512007)(6666004)(26005)(44832011)(4326008)(8936002)(66476007)(41300700001)(5660300002)(6486002)(66946007)(8676002)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NPOaOLpDFR9scTAzRBYgJt6lTKD+BvPEbyLGPyulM+3u6EIFWdtC2lipjNGX?=
 =?us-ascii?Q?4S5P9r7h2jsOqTEn+DlDESkDmJ5Q7/txFJmnlpoddLCqfUct9WSIHvj2osB9?=
 =?us-ascii?Q?ThQgRB0KXmYDnxRItwBCChvkCr1YRYyUrcbCzt8DEkT8sWMXAWtakT+nwesK?=
 =?us-ascii?Q?BrqR+S83Du5Lmex5fZRoJLPrR1z69xd99l9TwtALyOvnRhzbVmtzAKqi7UY3?=
 =?us-ascii?Q?5BjY6rfR+DOAc7StiPr1pLzxrePs38TyDdfBH2ccOEmeyx46hTYw+Yi9U4mI?=
 =?us-ascii?Q?W1WGklOepHXdHlnT4EYXRSB/NtBPPimjA/wwjYwWt8pp/XY5K+5tJbksR7Gx?=
 =?us-ascii?Q?8HZfQVdF7YSxfx+XqiyyPcPRLxQMUBInfRy8856eBW9HiP9BGfe95Gv7A1TF?=
 =?us-ascii?Q?wFd2vosCQIwLdCHnXiLxe5OQOeOUKn3d1s9bbd2r3AOXPSADkoy77/jwHLaq?=
 =?us-ascii?Q?En1aujW+PUpUCXxtiiFwPge1BoRv0Pnwuh7p1UXFIHa8ngA1xHZsIHiH2c4K?=
 =?us-ascii?Q?Ebtjt3UBQQuTI/RjuggBg71pdp6LW698865EArBWSKrnK7zYWZ3IVYsxs/be?=
 =?us-ascii?Q?b0eifpcpK1DRn64UCPzUXBNMmpkmZ6kjb35uLWKCRq5myQMiUbf1X26LcEs8?=
 =?us-ascii?Q?R8LMGFP7Q+XZlw2ieny5yN2lOSTwiTj4iSnjzGOKb8fDF5zTeynNL1c1tlUT?=
 =?us-ascii?Q?ZbU7b517vXogS/prU+isLRIbJPe32bJSxZGEP/bPOv5v0UobOlDKStqlwkKB?=
 =?us-ascii?Q?EwijsEdhYhqaHJTesC4rWSfbdIsbQDfalnFuvFWQX2RaIaIhXm88tboS7OpO?=
 =?us-ascii?Q?Ux4gW4dVJywC7j9fJ0vbk0S0TpwsK+eVi7dZlKtimOS423G1HhOujTbpbaUy?=
 =?us-ascii?Q?4vzdzorFRwedt8ue6aQnVx9RCKUUM00qrxLSe4KP1OwAHcqrjax49Xv3KAsK?=
 =?us-ascii?Q?X5QSHrHXebKDgvoz7V9UpOvaZJcGSlW8VsdNbtPw4KmIKJe3YdNU1fnxl3dW?=
 =?us-ascii?Q?kxEE6TWH+BGULCewJStq1AxzjkjM+PCirP6gXzMnw2Kp1vYUeLzh0AxP2cC8?=
 =?us-ascii?Q?DgCPAilHUKrp6cHyjW88Dks5qUUd2HBoczFYJw+sygJyoxkoSAnW3KDgIZl2?=
 =?us-ascii?Q?u+o+9Uhu6D0JjDcEkleB4u7HIvnrIRtDp20fpE9A7Bc3j7WYsjtNcT/1146+?=
 =?us-ascii?Q?Oewed1IeSsbNWgsuCWJxDNUMjK04eCrI+XiaL0IGWoC63Vhf8LgzkccCne1j?=
 =?us-ascii?Q?TKd0V4tqSDYwDWCdPpezpeHk1el9/omFbYRMjIUdiFeZ/Q6VQRQrriIPMsN0?=
 =?us-ascii?Q?+sznWW2O1OTWj4hGKwjTh5HiUWNMt9a6+mV7666oUjZr5Q99tGgk7IZsS6Ec?=
 =?us-ascii?Q?9KrxB2Yb62Ejf10sMtW9NeH7kPFLGg20hUpcRYUv88MKMuOUs3prKZgRk9yj?=
 =?us-ascii?Q?DL/8WU05oJnFF5mY9faXdHhvDWx9k2eFTLls8uCVP+rOQTmgZwN4H9IKXKgK?=
 =?us-ascii?Q?1Q38ruiFx007fUXRuiiwziLOt1q97rkFvdDOzISOYT30ygf3ZKl8BAJpG0zQ?=
 =?us-ascii?Q?3+Ri+NXtWYjZz9gmsHrpJAy1eKYkqe5F/7mKhoew?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 880bdc61-9cb7-4b3b-508e-08dab31ac299
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 04:14:34.3101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +c+W4SPi2b/KLrQINt1W7E3zY/3f64iLqYDn7vWjXhdCRMhgfk9lAPqImPdpBLRqBdTAk8ZLWBUWTMgGZgrpDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5605
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

On Tue, Oct 18, 2022 at 11:52:27AM +0100, Jonathan Cameron wrote:
> On Tue, 18 Oct 2022 10:36:19 +0100
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> 
> > On Mon, 17 Oct 2022 20:00:09 -0700
> > Davidlohr Bueso <dave@stgolabs.net> wrote:
> > 
> > > Introduce a generic irq table for CXL components/features that can have
> > > standard irq support - DOE requires dynamic vector sizing and is not
> > > considered here. For now the table is empty.
> > > 
> > > Create an infrastructure to query the max vectors required for the CXL
> > > device. Upon successful allocation, users can plug in their respective isr
> > > at any point thereafter, which is supported by a new cxlds->has_irq flag,
> > > for example, if the irq setup is not done in the PCI driver, such as
> > > the case of the CXL-PMU.
> > > 
> > > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > > Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>  
> > 
> > A few nitpicks inline.
> > 
> > With the comment one tidied up (other one optional)
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > I'll rebase my cpmu code on top of this shortly.
> Hi Davidlohr,
> 
> Doing the CPMU rebase has shown up that using this generic infrastructure
> ends up rather ugly.
> 
> Previously I had a local array to manage the required register maps
> that was then freed.  Now I have to move that into the cxl device state
> just so I can get at it from the irq finding callback.
> 
> So I have an extra step to be able to use this generic framework.
> 
> 1. Query how many CPMU devices there are.  Stash that and register map
>    info in cxlds.  I could do this in the callback but that's really really
>    horrible layering issue as most of what is done has nothing to do
>    with finding the vector numbers.

FWIW I did this for the event stuff and did not find it so distasteful...  :-/

However the information I am stashing in the cxlds is all interrupt
information.  So I think it is different from what I see in the CPMU stuff.

> 2. The callback below to find those numbers 
> 3. Registration of the cpmu devices.
> 
> Reality is that it is cleaner to more or less ignore the infrastructure
> proposed in this patch.
> 
> 1. Query how many CPMU devices there are. Whilst there stash the maximim
>    cpmu vector number in the cxlds.
> 2. Run a stub in this infrastructure that does max(irq, cxlds->irq_num);
> 3. Carry on as before.
> 
> Thus destroying the point of this infrastructure for that usecase at least
> and leaving an extra bit of state in the cxl_dev_state that is just
> to squirt a value into the callback...

I'm not sure I follow?  Do you mean this?

static int cxl_cpmu_get_max_msgnum(struct cxl_dev_state *cxlds)
{
	return cxlds->cpmu_max_vector;
}  

> 
> So with that in mind I'm withdrawing the RB above.  This looks to be
> an idea that with hindsight doesn't necessarily pan out.
> Long hand equivalent with the specific handling needed for each case
> is probably going to be neater than walking a table of much more
> restricted callbacks.

I'm not married to the idea of the array of callbacks but I'm not sure how this
solves having to iterate on the CPMU devices twice?

Ira

> Maybe there is a nice way to fit the CPMU
> registration into this infrastructure, but I'm not immediately seeing it.
> 
> One other note inline via a compiler warning.
> 
> Jonathan
> 
> > 
> > Jonathan
> > 
> > 
> > > ---
> > >  drivers/cxl/cxlmem.h |  3 ++
> > >  drivers/cxl/pci.c    | 72 ++++++++++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 75 insertions(+)
> > > 
> > > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > > index 88e3a8e54b6a..72b69b003302 100644
> > > --- a/drivers/cxl/cxlmem.h
> > > +++ b/drivers/cxl/cxlmem.h
> > > @@ -211,6 +211,7 @@ struct cxl_endpoint_dvsec_info {
> > >   * @info: Cached DVSEC information about the device.
> > >   * @serial: PCIe Device Serial Number
> > >   * @doe_mbs: PCI DOE mailbox array
> > > + * @has_irq: PCIe MSI-X/MSI support
> > >   * @mbox_send: @dev specific transport for transmitting mailbox commands
> > >   *
> > >   * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
> > > @@ -247,6 +248,8 @@ struct cxl_dev_state {
> > >  
> > >  	struct xarray doe_mbs;
> > >  
> > > +	bool has_irq;
> > > +
> > >  	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
> > >  };
> > >  
> > > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > > index faeb5d9d7a7a..9c3e95ebaa26 100644
> > > --- a/drivers/cxl/pci.c
> > > +++ b/drivers/cxl/pci.c
> > > @@ -428,6 +428,73 @@ static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
> > >  	}
> > >  }
> > >  
> > > +/**
> > > + * struct cxl_irq_cap - CXL feature that is capable of receiving MSI-X/MSI irqs.
> > > + *
> > > + * @name: Name of the device/component generating this interrupt.
> > > + * @get_max_msgnum: Get the feature's largest interrupt message number.  If the
> > > + *		    feature does not have the Interrupt Supported bit set, then
> > > + *		    return -1.
> > > + */
> > > +struct cxl_irq_cap {
> > > +	const char *name;
> > > +	int (*get_max_msgnum)(struct cxl_dev_state *cxlds);
> > > +};
> > > +
> > > +static const struct cxl_irq_cap cxl_irq_cap_table[] = {
> > > +	NULL
> 
> That's not valid, just make it empty instead.
> 
> 
> > > +};
> > > +
> > > +static void cxl_pci_free_irq_vectors(void *data)
> > > +{
> > > +	pci_free_irq_vectors(data);
> > > +}
> > > +
> > > +/*
> > > + * Attempt to allocate the largest amount of necessary vectors.
> > > + *
> > > + * Returns 0 upon a successful allocation of *all* vectors, or a  
> > 
> > Technically not all vectors.  If we wanted to do that we could
> > just directly query that via pci_msix_vec_count() etc that gets
> > it from the MSIX capability. That's frowned upon because it's common
> > to stick lots of extra vectors on the end for stuff that linux never
> > cares about (debug etc, or optional features).
> > 
> > All vectors up to the maximum one the code uses would be more accurate.
> > 
> > > + * negative value otherwise.
> > > + */
> > > +static int cxl_pci_alloc_irq_vectors(struct cxl_dev_state *cxlds)
> > > +{
> > > +	struct device *dev = cxlds->dev;
> > > +	struct pci_dev *pdev = to_pci_dev(dev);
> > > +	int rc, i, vectors = -1;
> > > +
> > > +	for (i = 0; i < ARRAY_SIZE(cxl_irq_cap_table); i++) {
> > > +		int irq;
> > > +
> > > +		if (!cxl_irq_cap_table[i].get_max_msgnum)
> > > +			continue;
> > > +
> > > +		irq = cxl_irq_cap_table[i].get_max_msgnum(cxlds);
> > > +		vectors = max_t(int, irq, vectors);
> > > +	}
> > > +
> > > +	/*
> > > +	 * Semantically lack of irq support is not an error, but we
> > > +	 * still fail to allocate, so return negative.
> > > +	 */
> > > +	if (vectors == -1)
> > > +		return -1;
> > > +
> > > +	vectors++;
> > > +	rc = pci_alloc_irq_vectors(pdev, vectors, vectors,
> > > +				   PCI_IRQ_MSIX | PCI_IRQ_MSI);
> > > +	if (rc < 0)
> > > +		return rc;
> > > +
> > > +	if (rc != vectors) {
> > > +		dev_dbg(dev, "Not enough interrupts; use polling instead.\n");
> > > +		/* some got allocated, clean them up */
> > > +		cxl_pci_free_irq_vectors(pdev);
> > > +		return -ENOSPC;
> > > +	}
> > > +
> > > +	return devm_add_action_or_reset(dev, cxl_pci_free_irq_vectors, pdev);
> > > +}
> > > +
> > >  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > >  {
> > >  	struct cxl_register_map map;
> > > @@ -494,6 +561,11 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > >  	if (rc)
> > >  		return rc;
> > >  
> > > +	if (!cxl_pci_alloc_irq_vectors(cxlds)) {
> > > +		cxlds->has_irq = true;
> > > +	} else
> > > +		cxlds->has_irq = false;
> > > +  
> > 	cxlds->has_irq = !(cxl_pci_aloc_irq_vectors(cxlds) < 0);
> > 
> > maybe...
> > 
> > >  	cxlmd = devm_cxl_add_memdev(cxlds);
> > >  	if (IS_ERR(cxlmd))
> > >  		return PTR_ERR(cxlmd);  
> > 
> 
