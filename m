Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21BE85FF207
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 18:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbiJNQIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 12:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiJNQH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 12:07:58 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4FA1BF210;
        Fri, 14 Oct 2022 09:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665763676; x=1697299676;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=B9ZNNnyDLvbBJcoJsJzUHzLJ9L28PhRsXr8cjC2YEc8=;
  b=hdT7ElQUjpl9t+18yPtDnB8QbPdzYGfZR/qipd30X4jejPLbrrJiPm1F
   Sot5WjdQVnYU15i7RIbs+wtnEdyWibNEUAqHAuFWmlABqNsCrh+UrShR/
   +wkwLbG2O4UL1nMy6PyIj89viMaCD8f8j1h2fH3WCJqNYMEsAVSh8K/oH
   ulDRKzfWYQBZbBd5cEXqrR1ew1XQ82QuiTrHch+H+BsOVgEQ94Aggq5NC
   57wPs+AAajX+kMojAkXt8N8eQtVTE/e1FhNzANzYCVcPFm80aVDHJBZK9
   +ioYiLI19axlYLp/WAnj3Vel/uyQlBTwHFXZtnb1pIi8dGs2KMECqwyJ7
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="292768265"
X-IronPort-AV: E=Sophos;i="5.95,184,1661842800"; 
   d="scan'208";a="292768265"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 09:07:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="732351769"
X-IronPort-AV: E=Sophos;i="5.95,184,1661842800"; 
   d="scan'208";a="732351769"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 14 Oct 2022 09:07:55 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 14 Oct 2022 09:07:54 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 14 Oct 2022 09:07:54 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 14 Oct 2022 09:07:54 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 14 Oct 2022 09:07:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cb4dVvqBZHLVCej5JVphftYXK/iSoCJjOKUHFxCCpNqgfLzF2LnQvJCGDz83uSxzrU0vHYGyjxaCm2racoNjKIlHxl0zNHoutRUuWuHwA7ojSJsxEvqSURUm6EkjCMjYx0/xgjyyf0uRrO9rH5gevfN1HAF8JTVj+37E1G9y1Sq2nK9UbH2MsCyWdasH5xVNJt7vByiouHOJH83uR29avjMubDkBL0zGQ8Xzh7A39HfZ9M/7ZBS+9WQTPYYHjDjmOMKav22ob4yzmvQ+vYgR5a772n781ctlCNUFtfWpln/KsGwQG2IvQKcFkt56e8hepbiNxtGqAV0nKLXlCsIODg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQDE3Ms9GxKSBAb7RWcw011jWrppdsIKgEZX4LyTLgA=;
 b=O9PE2B09I3MbfhhZPdz3f8gjXHzKEHnCzF82jPmt79Ig4efglkaxbRDC81xDyHzORl+APMyZTBUZnSb6b+H/64LykX3UtxxBewCHqrcDgCDeWzKrMYyARwa0p3hZObamlAjp7BaKv+UJbwSvgsG1LqgygNgIR7Ef1NR2uJha8c5HrRMHJ8CZPXGTMYpG0ZBNSvetOf5Uj1FISe5wF+QDwu9F3jFb9Z2nDO+z9kDmVq79pXQk385Clr+4oPierzyPhsjkBi7gIT8QLcq017bihldTAshHXvbTzA5ZS6RS+VBadcDtaebVyKC4FPN/ne+blQmOf4azMgmhsku62SA2AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BN9PR11MB5545.namprd11.prod.outlook.com (2603:10b6:408:102::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 14 Oct
 2022 16:07:52 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae%8]) with mapi id 15.20.5723.026; Fri, 14 Oct 2022
 16:07:51 +0000
Date:   Fri, 14 Oct 2022 09:07:47 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Davidlohr Bueso <dave@stgolabs.net>, <dan.j.williams@intel.com>,
        <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <bwidawsk@kernel.org>, <a.manzanares@samsung.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl: Add generic MSI/MSI-X interrupt support
Message-ID: <Y0mJU6IV+Xm8Pu/m@iweiny-desk3>
References: <20221012180432.473373-1-dave@stgolabs.net>
 <20221013131913.0000038b@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221013131913.0000038b@huawei.com>
X-ClientProxiedBy: SJ0PR03CA0294.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::29) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|BN9PR11MB5545:EE_
X-MS-Office365-Filtering-Correlation-Id: dbecadd2-9b02-4c34-053b-08daadfe3efa
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eWbkRRDi6uGh/Rtk+eLKpxp8t0552wbMULIg5jj9lct1Ebf0KmHTw61z6ZoRb38FHTBPSFcv1W2BuxnQlpOUtKfEdUjbDMplg0NBXbssZQVnkKFiv+ZLeFUwdu7fhWByUOxnrPSjAGgs9a9RTcg8dkBMBeYAtcly/kCAwlVJuWXeh2Wn8XTLUyG231Ye1KklbRlHLkson8QJBWbUNWjK7up+S5H9V7kpxot32zzmJkG1bYmk0qWnXS7lhMaW/+zUi5HwSsz8s4Ze8c22WZPP8GwG809TjCUEoz1XU7bsfU5UBJyA5AFD8BbVp/+Z9kS0Osr1kb3sD17AhfG/A7pF40BhczY/gmIqfkwerjQNJgpIIexR0mPGz/KyYCh7kH9why1xtsDfId0S19wFS0Ej9jfNNJ+vmeMfWx8AnYr3ZPqA3c2pUnYYSpB8ASCSg6tizKX80N7vyiipQHajRABAND/ddhgevcgxeu0YDI8poNrJebM1SSY5uBjVvWPkyEjxFdsl59czr69ZihFXkJmQVemSfZWvX37PLKm2Aq8r7odgedXGsg/cBzPsmU58RDVi5GDhMnoqO4tuKyD3h7VN25My77389JEoBldF/sq8HCH67v0lyDOk/L2ikY9hlo5BmSNJR0gWPda6BvJewmQa8dmbgxj/buRo1SkjtIPIlhleo/KvQ5Q0DhxzvwaLs2YUxVO1MvfWDymw3bA+D8DKUuwydhvVcPUmD0PwSCW4iZ6GjLdr7riPMDfaAdeiv1Fg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(376002)(346002)(136003)(39860400002)(366004)(451199015)(66946007)(478600001)(6486002)(33716001)(86362001)(38100700002)(83380400001)(41300700001)(8676002)(6916009)(44832011)(66476007)(6506007)(26005)(4326008)(66556008)(316002)(186003)(9686003)(6512007)(82960400001)(5660300002)(2906002)(8936002)(6666004)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Kbe3KEICOSmuNFZ8CvOlWHGgZn3K87ECKIg9wh1Ax2BNTzwYkEvmcEC7RdHh?=
 =?us-ascii?Q?bYtxzM9CxjSBiLySihZZ26w56SgneiAeQfs0Q+nFXktGJxsR3hxLjDsivv4G?=
 =?us-ascii?Q?D8V3oMlNaKmrwFIJR8p/GsPBdZyCpj4sl96I+Mm7/NJ70DcaJfr/ty+UPirm?=
 =?us-ascii?Q?aLdgsjtm0h4x50nCRjYs7A1Tu+QU7A6RG15nnOYRy8iRwt7jHKUMK1c0nSyW?=
 =?us-ascii?Q?79Z0zpmkdbMpTHBj+bOPAyS49bYwsuhPZAs3omwcj8Clr3Bk/YpfOP6UdYoN?=
 =?us-ascii?Q?heuzlWns2d3gucOqiPxfLeFr1ZRkLLU/6CN5WfoltiRNrvfOjNfDMk7bDys3?=
 =?us-ascii?Q?yIQRBYNGQPDHCsLvkiPOTwxPJoHI7YhxZQeDUzal3oIF/H2d4WVK0fwrITYr?=
 =?us-ascii?Q?YJjPVMFu+wsQKKtI4S2/5Qpd/00l8mB22eZwFCvDKnM7AqGVgRh09H2ANj+p?=
 =?us-ascii?Q?7UlmhDPdCjDhoOFEBkChmt+fKPrmTMG4CZg6xOZ2n8tEWZjudoPhIK6aa51F?=
 =?us-ascii?Q?u7UHIWFDbxrcNxH3I1xmanGqg9x5I5Qma9Q/6Yfjqaxyh+wImoi6SfDMxl60?=
 =?us-ascii?Q?nUy0SfUr2Uo/AWLyOEsqDkfKujvC0oP/PQ0+bmAEZtEQT262hQbLdXiPxid1?=
 =?us-ascii?Q?YIk/GmORTtr/uwpS7oIm6+BNNr7lRMxuKK2q7+akHz7Y0deJc9UsnwhiQr7w?=
 =?us-ascii?Q?gYGOBkuDVJMlNpopj90EeJoR/O3c2J8pdNNad6IyUI9du1CMsOH6ZhOHPmFY?=
 =?us-ascii?Q?GHF0Y0LqXJIs71fiy6UifQZA+mhqrqfmJKlc6+Ar5AGAk3mgB2gKlwAT+LeO?=
 =?us-ascii?Q?ruVA6ujpT9wk7qXJ0YBHqz+HV08oHlrKKwh9axKnsKo6fY93lhSkYy9CDTQA?=
 =?us-ascii?Q?qKnamYZuRfTtLk+ZT+thJvRP3iHQRxaID/7IiodgIw3SXOAcf5lM8z+U06SV?=
 =?us-ascii?Q?FqevI/ZSNd7UkPJvRQs3CpMJGsTJT0RQOpUFvIkdjdD4aZe4pZkcZ9LJEfWe?=
 =?us-ascii?Q?yU0EoWkjTEWsrSlCmngtS6eHP9UMmCTyXKEAmzIzfBAPUl7eM7F25GzVuT9J?=
 =?us-ascii?Q?GjWG7kKWF7CWj++CFhBqDGPn0dfgb1GflWseD7A1z27CZ/pR83982W/w548f?=
 =?us-ascii?Q?IBlfocNqWdHJwk7A+Nkg7HGTGOZbX2R67LCAMUwG6JMutmtQ0kTxL/mvWM/G?=
 =?us-ascii?Q?xCs7xHE2VZAhwX51c9Ndjm11BkMrHYqp7mT2BDxc+IvSIQ26qthcRi15uCCE?=
 =?us-ascii?Q?ix4X+p0Sjt15s0N0PWeTCLgxOhkGP7/Or6P5kfw9WtV0Bi3BYq+mfDc+DT3R?=
 =?us-ascii?Q?doHaP2ZQdpESOn6YIktM72Y64dYPvVCZ7c0Sah75xOBOwG5Aqz2j7brpTstx?=
 =?us-ascii?Q?ie7rE9wkEX962f+mn3OMQftHhf5Z5izB7BRKIEucrS9F1B+cV9K+C5upDrX3?=
 =?us-ascii?Q?YGqwU2B1Z5kUMX4eoDIGofdRycMcor5eqFFONJY8F6aOhc544dt3dqE+ccHC?=
 =?us-ascii?Q?QPWhXJhraLYbZvBtB11wIORQIxyfOkgQmb4eGV7IzM4cbVARKtrPf8NiA452?=
 =?us-ascii?Q?NGAV+gMvw1fYqaKGLdT/c8XUNne90z6YIqtVdNV6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dbecadd2-9b02-4c34-053b-08daadfe3efa
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 16:07:51.8092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mUJGF7uHs/oE1Lb/x3LWSRbGt2ojDp+j/l2W2zdUjo8AocP467Wp09Qyc5gDyAA5cQCFdkUdagt9F1ckzTnkFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5545
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 01:19:13PM +0100, Jonathan Cameron wrote:
> On Wed, 12 Oct 2022 11:04:32 -0700
> Davidlohr Bueso <dave@stgolabs.net> wrote:
> 
> > Introduce a generic irq table for CXL components/features that can have
> > standard irq support - DOE requires dynamic vector sizing and is not
> > considered here.
> > 
> > Create an infrastructure to query the max vectors required for the CXL
> > device.
> > 
> > Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> 
> Hi Davidlohr,
> 
> Basically good, but a few comments inline.
> 
> I'll role this onto front of the v2 of the CPMU set as well.

And I don't mind this landing ahead of the event stuff.  I'll take this in my
series too but expect it to drop out when applied.

Ira

> 
> > ---
> >  drivers/cxl/pci.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 63 insertions(+)
> > 
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index faeb5d9d7a7a..467f2d568e3e 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -428,6 +428,66 @@ static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
> >  	}
> >  }
> >  
> > +/**
> > + * struct cxl_irq_cap - CXL feature that is capable of receiving MSI/MSI-X irqs.
> > + *
> > + * @name: Name of the device generating this interrupt.
> > + * @get_max_msgnum: Get the feature's largest interrupt message number.  If the
> > + *		    feature does not have the Interrupt Supported bit set, then
> > + *		    return -1.
> > + */
> > +struct cxl_irq_cap {
> > +	const char *name;
> > +	int (*get_max_msgnum)(struct cxl_dev_state *cxlds);
> 
> For the CPMU case I need to walk the register locator dvsec block so need
> the callback to take the pci_dev not the cxl_dev_state.
> 
> Also need it later to map the resulting register blocks to go find the irq before
> then dropping them mappings so that the resulting CPMU device can grab them
> later.
> 
> > +};
> > +
> > +static const struct cxl_irq_cap cxl_irq_cap_table[] = {
> > +	{ "isolation", NULL },
> > +	{ "pmu_overflow", NULL },
> > +	{ "mailbox", NULL },
> > +	{ "event", NULL },
> 
> Fill these in as we provide them, not upfront. I'd rather see this
> attached to one (or possibly several) of the series that are coming along
> than stand alone.  so start off with an empty table.
> 
> 
> 
> > +};
> > +
> > +static void cxl_pci_free_irq_vectors(void *data)
> > +{
> > +	pci_free_irq_vectors(data);
> > +}
> > +
> > +static int cxl_pci_alloc_irq_vectors(struct cxl_dev_state *cxlds)
> > +{
> > +	struct device *dev = cxlds->dev;
> > +	struct pci_dev *pdev = to_pci_dev(dev);
> > +	int rc, i, vectors = -1;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(cxl_irq_cap_table); i++) {
> > +		int irq;
> > +
> > +		if (!cxl_irq_cap_table[i].get_max_msgnum)
> > +			continue;
> > +
> > +		irq = cxl_irq_cap_table[i].get_max_msgnum(cxlds);
> > +		vectors = max_t(int, irq, vectors);
> > +	}
> > +
> > +	if (vectors == -1)
> > +		return -EINVAL; /* no irq support whatsoever */
> 
> return 0 in this case.  No irqs present is a 'good' result if there
> aren't any.  Will be up to the consumers of the interrupts to get
> their own interrupt vector numbers and they should get the same
> answers!
> 
> > +
> > +	vectors++;
> > +	rc = pci_alloc_irq_vectors(pdev, vectors, vectors,
> > +				   PCI_IRQ_MSIX | PCI_IRQ_MSI);
> > +	if (rc < 0)
> > +		return rc;
> > +
> > +	if (rc != vectors) {
> > +		dev_err(dev, "Not enough interrupts; use polling where supported\n");
> > +		/* Some got allocated; clean them up */
> > +		cxl_pci_free_irq_vectors(pdev);
> > +		return -ENOSPC;
> > +	}
> > +
> > +	return devm_add_action_or_reset(dev, cxl_pci_free_irq_vectors, pdev);
> > +}
> > +
> >  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  {
> >  	struct cxl_register_map map;
> > @@ -498,6 +558,9 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  	if (IS_ERR(cxlmd))
> >  		return PTR_ERR(cxlmd);
> >  
> > +	/* TODO: When there are users, this return value must be checked */
> > +	cxl_pci_alloc_irq_vectors(cxlds);
> > +
> 
> Gut feeling is this will end up moving ahead of any of the sub device creation
> because many of them end up needing interrupts.
> 
> Also check response from the start - can't see a reason to not do so as we
> won't be registering any at all if no callbacks provided.
> 
> So I'd move it above the devm_cxl_add_memdev() call.
> 
> 
> 
> >  	if (resource_size(&cxlds->pmem_res) && IS_ENABLED(CONFIG_CXL_PMEM))
> >  		rc = devm_cxl_add_nvdimm(&pdev->dev, cxlmd);
> >  
> 
