Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F6960981D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 04:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiJXCJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 22:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiJXCJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 22:09:08 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D9A70E5A;
        Sun, 23 Oct 2022 19:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666577347; x=1698113347;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=d9mDnXl4ZVKWsPKa/mZrDoM2uzwug0Z2tkuOj1Yu/vE=;
  b=i0JuxJuOvG31fSnJbWlEXTfAq/Zc3hESz/KQ4inTI4pwqeO45NknddFf
   esv6qkEdO+pRYlmLutAzNWtOXkJ/BROXu4vr8HcDxeiCsvam7xjrePsPH
   G1UN7hjLn+piLQRtq9TwpO74pW5/lsak55ya74YYeKD1yL3G+pgCNVBlP
   f27KipJllyyXCaZXjBEfEAB7S2BluGVdfyYY7qUxBCHkQp87mVlLpMoZ8
   NSGMyTtHCd2K/hN9EdjDv2kpX0W8woQPdft+Jk5CuhWBp62rnmQl5XPKp
   tkCuCXJ0cOReM2JH86UWdRFRXSKjMcJg7nlbOaelhm1Coe12PAvvK4LbO
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="333904516"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="333904516"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2022 19:09:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="720337788"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="720337788"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Oct 2022 19:09:03 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 23 Oct 2022 19:09:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 23 Oct 2022 19:09:01 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sun, 23 Oct 2022 19:09:01 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sun, 23 Oct 2022 19:09:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkzNQZeYuUf8HZJ0BV3baEzMvmxZYzxDD3TXvQ5Jn6EFvgto7niNVVVYIxmN29QoYEF3iA9edtDrmhUtXP4AWnPH5fYxNEHiiTd0xhALIbF5TNn/28bbLJqgrD8xw1h+DRnYMaRmThZaHz5YE0wTWD3GTpUQJbzUnqjEk18isEE7hqW0c/Xb+O0Z3kKsJnVvrEWTzfP541AvTgWP92ZBWzlIC5IAOLmFEvOBuzlV0Vu+2AHsDgT/sC2Cy578uzd8rrix7t0mBQrG1BSpyhnNkda+XjT+Hgs5RoBGSFPaLnVIUUkg6vBAoiDPK2D913t30k1GLcPw7vvkUvR4RVO0mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HdeEAsUXnJ1IiSHRCVPAwMFvsUmzDwNo9JCJOf9Lmsg=;
 b=hGbMedzwMm4whzeiAruln7sIhj0addF3qTGPH/Msw0GkMmLABIrdnR6ruS8owgAZaRJM71upQt8xVletJKj75pIq9H/0K0kAMDovkZ8iwIRiShckDduPLzDnE8FLfGNHADOr7ZB1GMaUrZMtzSIYhQXzm6BeNawZGCaVi6yKFWHKBLyQP7dnq7Fi/sk74M4QuChh3p8Gi8AbcET/xrpatSwzGXbWl690CKCEaV5BvFAlGG0Fe8XgH7KU6R8EHa0oRs5z3hzJTAk1pQ1ir5V+raJJ72KtHJl1ErGcV/9UPQpbcOTAFLYIqBw3WCL0BiJN5+Pvr10jzGOZmiHW2BokMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by PH8PR11MB6610.namprd11.prod.outlook.com
 (2603:10b6:510:1cd::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Mon, 24 Oct
 2022 02:09:00 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5746.023; Mon, 24 Oct
 2022 02:08:59 +0000
Date:   Sun, 23 Oct 2022 19:08:57 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Davidlohr Bueso <dave@stgolabs.net>, <Jonathan.Cameron@huawei.com>,
        <dave.jiang@intel.com>, <alison.schofield@intel.com>,
        <bwidawsk@kernel.org>, <vishal.l.verma@intel.com>,
        <a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] cxl/pci: Add generic MSI-X/MSI irq support
Message-ID: <6355f3b933235_1d21294da@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20221018030010.20913-1-dave@stgolabs.net>
 <20221018030010.20913-2-dave@stgolabs.net>
 <63546939ea062_1419294f6@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <Y1XX1tVLQoYmYnSM@iweiny-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y1XX1tVLQoYmYnSM@iweiny-mobl>
X-ClientProxiedBy: MW4PR03CA0101.namprd03.prod.outlook.com
 (2603:10b6:303:b7::16) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|PH8PR11MB6610:EE_
X-MS-Office365-Filtering-Correlation-Id: d94b0c1a-7277-49c7-a882-08dab564b654
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D+s+O/J65/IcHlNEls4veny8gatachg/DaAFRu9kSsFxs4gEYC8Z+RRHz6GvQjXetzcoGXQOKfmQaxJdG6XA8drAEOtwcGT72evrBQhkOmnTrJsTHz/4IhFs2v5F1n2ov2X8C+PATuZbCMG/fOZucZhwqkvCLuf4ysHKogQ9bQEd6xLCmY9cqzttbLyruUwi9HXkSApufxhu00GypeYA5EPbgEP3IZBsuqNTQXdnQn0LfPP7FHsossBfL/chvr8HBmFa0LhFhtwtbRIynmk+3rK6HHGFwWxpMrPoI0Z3J/Eo53qvJQpZHdxeKVHR1iFD6OshkoQcrh8AZbqFzsgeGENg8rS+DiETv78nz0YXztLvVWhQ/s544ratcUICkulC8r6+/PN2GN3EY1cAnzKG8CIQ7r/CFahctO6bzuhdEfGeuYVsysVCIYj66ZGVUyyxUZh/j3Z8P6VuV1V9LWJB++SWyiRaJWg8JVfzrPDcPcSuXvzjy4MU1DWCi0V344TXfwNrhGczzcM7C1nHgh30MfMpvqlJYEtT4/zgl/zKacFaMckGstF6cSpgFW3lPe2rLkz9Wi7I2L/y3pI1AiLp8h8QwHv+ZSSYXgrt7fxoxCbanznZdRT6WEZ67cxA/yWKoRXQvmLt5cv/RfiuXfj+5qq0asITQszI4Gmgg0F4v6mlSSQh9sPeNFF3thGZyCWt3D78bqwYJxdx25cF02cZgY+0XiYXjIqtGtYkh0SYc67NHxC5aJiQAgZgY2PDuJMz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(376002)(396003)(136003)(346002)(451199015)(66556008)(8676002)(5660300002)(4326008)(9686003)(66476007)(8936002)(110136005)(316002)(26005)(6512007)(38100700002)(6506007)(82960400001)(2906002)(186003)(86362001)(478600001)(6486002)(41300700001)(83380400001)(66946007)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Sv33cY2dUpKC5cQslJKOeeYFer2WYF5bzmrVtmYkRezb/7YGVcjh/T1Zv5jF?=
 =?us-ascii?Q?/oySnNvZcV7BCkBJcuQCxmi80KOdD6Zh8xlDH0hBxUcKCteCKQ6dkU350ZbZ?=
 =?us-ascii?Q?Y4MH/ISNPIERoDxcO9+SowMjmI5DfiIwOdp22ClWocFT4Ly4RR1U2pFHwd6l?=
 =?us-ascii?Q?qoS9cI6dbkqqHsqZjbU+dyIvVPsFsdzeEatMi3EfWQ1FjmEPg6THISOMJ/t+?=
 =?us-ascii?Q?fdYvofskhRVJr19hvQOKA3bVWeoDjgURoZnsi0oS5JW3Mlry0N2cwGrT+YrN?=
 =?us-ascii?Q?WpAAHo+Z1o8570vEC3P4eg1SR+jlCCtgljyIISvQZr2G8b0o0OMBYYWGVaH7?=
 =?us-ascii?Q?QwnKZSWClBG5f1Fh9EPBZNHRVVScAJ9q6LQnd4ryaqDLceXmYz+qkGILTFgD?=
 =?us-ascii?Q?nCIHKotiufCrRD1jIgYZ6eTbE8XQJOq5po87aHpXmpcD7SkQM/CIicJHJocQ?=
 =?us-ascii?Q?/VM9elc3QPUI72Xu0jkaLwpiSBu6Jqa1EIl70ir9kO/6WPxcfrGpUA24twvG?=
 =?us-ascii?Q?6zE3RbRhJ1u8XKt1z1rMB/KNqsjsbHSG0j2k+E4HmCa5z05J52frds1FcTD1?=
 =?us-ascii?Q?RYmp+nB4emHaXnvPYzNPMvL4oRXICBf7GTSNVChVzBUAJ/bdBFCxP57fVFdB?=
 =?us-ascii?Q?O4+MC0WsvwxOlE7h1MPU23JDn88Oc9qFa1jcdkMf5czp5EHKZl0dDAyiUK+W?=
 =?us-ascii?Q?7+xeooJvyoYDPCsZJwoDljtl3YTWJBFYcgnI7wLgmTl3F2DZuyXXAgq/mBoU?=
 =?us-ascii?Q?/zF7gTUR0kfP0F9+N+GTLn4eYa4o64qSsw/HgtxIkSKT4SFFckbzEib7/c9n?=
 =?us-ascii?Q?hfRpRKjmdY4y7FUsnEVPimZkTnBMyr3kx063rA5FpNk6Cq3nryZmtkkZxWRW?=
 =?us-ascii?Q?kRAaD3Y0vmoBqJB1aJK+PlG8QNMAEGGLV6GY0rQpHJq01AiV9t3CE9+l+Av+?=
 =?us-ascii?Q?esZONzPHlf5eMPR5zEFx1rWAJ6sE+Oy+zxMsg1mRl2aeRnWbTmx+4smGWe7i?=
 =?us-ascii?Q?B5o29ew0sWKDGNg1mUthjqwkng4d/WD8Y8GB5LQHTmdXWLKMTq95lQXFCtjp?=
 =?us-ascii?Q?kNOCPKLZzPMwnDymkP6Xs3TehZEqeAajIik7kP9IIMfESNopaTditbwQOGN0?=
 =?us-ascii?Q?FvDzCQJtCa2tiMI7cyjTrQiA7pQAvBmOnxnb2R7JkTrVo5NYKkvOwxIgLkf1?=
 =?us-ascii?Q?PeP9D9PctNilnhwEgbehuUDtjwa5xnEUX7gsHBJ0DfEXMKz4ZMQJqgVdegeK?=
 =?us-ascii?Q?vrRzjwYCZ8XHXBJp/SUBdgus3bG96CwDvgrkVNRkiggvRB5XsHOCkF/C3sOi?=
 =?us-ascii?Q?nZvkTtzDQAW7TMgdJC9WF4lr5fbLSz1BBQXaFOhPwkJTbFJpwCh8xgLsZSpy?=
 =?us-ascii?Q?0aWvbf/ePPUjerZqpCZBMgzda4nIE5e4H6fMH92+vNaXV/nUULSmQYps63OQ?=
 =?us-ascii?Q?xgchwslFK8HhsHrLMtcUQ1WjzLqHvlJNkKkGsykscvGDjw/kdFeu3vWlSJ0U?=
 =?us-ascii?Q?wHLfq/sevskCDzjWR4L2WL3N6e/GxEa8oV8b1v4JCHMYyrSNU98lQ+f/zvKi?=
 =?us-ascii?Q?OtzQq8fvR299lq4xR8w6xvBU486Kd0ZXKNYaBPpVpCKW5f7Al4AOEOokGKBM?=
 =?us-ascii?Q?Rg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d94b0c1a-7277-49c7-a882-08dab564b654
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 02:08:58.9204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5zlYL/A5fudPNcqkDpnlxUYr3p266UdjAzW2hvt3KfYHzlP1dMnuyFuVlP7zGTkRflP3znaO/+tnwi9dZM3twTMAOl0jkJ0yJ/VrQchvSJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6610
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ira Weiny wrote:
> On Sat, Oct 22, 2022 at 03:05:45PM -0700, Dan Williams wrote:
> > Davidlohr Bueso wrote:
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
> > 
> > Why is this a callback, why not just have the features populate their
> > irq numbers?
> 
> I think we have decided to forgo the callback but I'm not sure what you mean by
> 'populate their irq numbers'?
> 
> > 
> > > +};
> > > +
> > > +static const struct cxl_irq_cap cxl_irq_cap_table[] = {
> > > +	NULL
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
> > 
> > Forgive me if I have missed something, I only look at interrupt enable
> > code once every few years, and the APIs are always a bit different, but
> > is this not too early to read the message number? The number is not
> > stable until either MSI or MSI-X has been selected below at
> > pci_alloc_irq_vectors() time?
>  
> Well I keep getting wrapped around the axle on this one too.
> 
> This all started back when Jonathan originally attempted to allocate the
> maximum number of vectors a device _could_ allocate.  But it was recommended that
> we determine the max number first then allocate that number.
> 
> This seems like a chicken and egg issue.  How is the number not stable before
> calling pci_alloc_irq_vectors() when you need the max msg number in that call?

Are we talking about the same thing? I am talking about the value in the
"Interrupt Message Number" field. That depends on whether MSI or MSI-X
gets enabled. The number of vectors the device can support is static.

Since CXL is such an a la carte spec I think this is situation to just
specify a large number of amx vectors to pci_alloc_irq_vectors() and
then find out after the fact if all of the interrupt generators that
today's cxl_pci knows about in the device each got their own vector.
