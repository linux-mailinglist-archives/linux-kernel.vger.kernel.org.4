Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB405609769
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 02:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiJXAKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 20:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiJXAKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 20:10:10 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5555840BDF;
        Sun, 23 Oct 2022 17:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666570208; x=1698106208;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Y6X0iUWomLEsNQntVGCz63y3mUx1Ed9lbNKxgbzO2h8=;
  b=BoiPWuT4c+soE4gEN1trU3+ENpvLr80TuivIxIuuAnw80NESiNWOWbti
   OmNYYMF67KdWWGbAgOVb8+V3Oj2VB6SPAx9oi9C85DKnnCHUUAEWjxbbI
   KeC2Ypb2tAWid3UiXW7JTLo3HYOzSE/mSCdwPh6+COWpaIKD8/nyH6ErT
   nJua6EN5SOYVLBHLkobcntPHIE8JnZ2sNmDBAN6IoWlGFP9N/r6y2Cri8
   OfSm/PAs+sksBj5oz89/28M47h46p3YJlRdPgRyB9GRKPUQ4+zWCHcpT9
   uBggZODMuiWcndjnlSWcOgHQY+Jdys01+zwyz/1+emj5VRJW2N23bTJdw
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="308994684"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="308994684"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2022 17:10:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="876272043"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="876272043"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP; 23 Oct 2022 17:10:05 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 23 Oct 2022 17:10:05 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 23 Oct 2022 17:10:04 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sun, 23 Oct 2022 17:10:04 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sun, 23 Oct 2022 17:10:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLRrp2Kq4WzF8sM7qU0XQPGZnPZKFkxdZvAkb20wiJKKy/sAFJdMObPLKJ9ZfNxgpJ3UN/YpffsvBxONqpy9Kwii2bMlN4GM4sgLOJKrcxRQVqUjKYfRsjfsc3XyO8YpkLUnN0mLt4xWekaEi5l1zfMRW5TzDb3s/awxiqO3UnMM7RInjLNUnbEA4hEUrLmDgXZG5WHVEDFbDhzam7qwQi6xd92g24NuNTDapkP4xXWTndfJZvMGPWELQormtsj3THv74tAK862z8AOCyUzdHnEYZ5+J+mq6/Lk26AiW5DauVKXeY1tXRE0wxKama0v8Tbs+QIzZXIpZPM2ircp6Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JjPwSkiU/4zAXN/XYM5Px791GUHNpOe1CQ5eXptLg7Q=;
 b=DxKNjY/KMDNkbu2C6F97G/EvpF6S4xyA8OPRegAD1QaDBOarf87lPxoLu8PNS8OdqkawitOBaTBVpH3FXssUaqWMohQe3/qNBe//Tn5V+rn56qrpoIlq95ipqZokQGqfpjxL3juJ9l4TOQpBHDOe4UJxLjjjvLbvlx0gucAvCE/OZ38AV5ifBpTFJDvKRF9l4Fxpk3egJ6v+EtQZFxJD62QDRwU0MbOgCoA9FlaQ747BAtu9uM2vvzMY9Kby7ZW6mAQoJHFBa2wFFD/mj2XI9sgV6YMa7UO3z85rfI1ZrnS6UL41ul0AFTxKVOd+OYqPsB+4SMmwkfUF2ojOJitbOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by IA1PR11MB6443.namprd11.prod.outlook.com (2603:10b6:208:3a8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Mon, 24 Oct
 2022 00:10:03 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae%8]) with mapi id 15.20.5723.033; Mon, 24 Oct 2022
 00:10:02 +0000
Date:   Sun, 23 Oct 2022 17:09:58 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Davidlohr Bueso <dave@stgolabs.net>, <Jonathan.Cameron@huawei.com>,
        <dave.jiang@intel.com>, <alison.schofield@intel.com>,
        <bwidawsk@kernel.org>, <vishal.l.verma@intel.com>,
        <a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] cxl/pci: Add generic MSI-X/MSI irq support
Message-ID: <Y1XX1tVLQoYmYnSM@iweiny-mobl>
References: <20221018030010.20913-1-dave@stgolabs.net>
 <20221018030010.20913-2-dave@stgolabs.net>
 <63546939ea062_1419294f6@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <63546939ea062_1419294f6@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-ClientProxiedBy: BYAPR07CA0005.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::18) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|IA1PR11MB6443:EE_
X-MS-Office365-Filtering-Correlation-Id: 7540c291-52a1-4e87-bd50-08dab55418e4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3REEAxhoTp6aryAOxV00YW2RGkCv/XSEH+Alg39wGHd8qjTa7V3WQ1BEJjpEmAl43bA6so13OdFuPCjreqHKFo215j/Xqw5zZzFhgfJJLD6xt9epWrsreWY3+hgMkTuckT5P1ny5HN11D3byu9DYv9RUdqCX3Lp8dMgIJC1hET3hWvHRRLRjGYSZoEeSH7ymAprv1nt7XzKLOMZgFQOCnUmCTQVgDQjm/+BhASFqoukoCfJDUfs4KQLeVx33MpsFh7PbwdeJGeT2/BXn7qHuEO5xfAJjcWHIa5qwWe9w5/5tl1aI4/iHTWCc/NOEAXEcqP1bXxgOj+FrP+ZuZhMRLla/AuapVuzwWYWsYvRvnj2pPusmruGgZTollBBnfpzpTtXmzy9K8Hq7nO0QM8+CCHjNOa8cysKg2EoNTlVI82RPpP21uK229lp9hIBaVtYk2hJZUJ3k88DtqTMXaTYH45OeBcGvA4t3K/Ocur5ocI6R7N5+rsKbEGy7VeAIpFV8SpEUJpDt3u/3OKHsXMSRZae77rbjLyXdBRnePwDmkpTFq4PpVqgv4EJJbFn9u1InvYEuffnrLZoIi5BPfxEGXqh0eBoo21BH0YpTswnx/XHes3Kmk2PILWOzU4k4OhTrk2bxbMFuogZvpcSuxhYEm/v5UQq/tlZWEyyja4iyUjvMH3WCWJCHzUIMemMwpY3rfLkFMniDy1DQVjW3+b0x1H3d0lvV/11qrAhe37FLv5vYla1g4vgLTjE5xOMLYSdP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(136003)(376002)(396003)(366004)(39860400002)(451199015)(6636002)(5660300002)(66946007)(66476007)(44832011)(66556008)(316002)(26005)(9686003)(41300700001)(6486002)(4326008)(8676002)(478600001)(6512007)(2906002)(8936002)(6862004)(186003)(6506007)(33716001)(82960400001)(83380400001)(38100700002)(6666004)(86362001)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iBj+/Uxak77aI5xLzUPvODBznznpHzyWWNrMAndr/D/qhar9VC4HaPNiFKyz?=
 =?us-ascii?Q?h0YUhiSdA+L9TEujHYhqqHn+XeDvtl58F8TJ2vEYshfho9hH012XP6APvHcE?=
 =?us-ascii?Q?NUWpCutJ6sEtOrqRa02IqEWOYeRsi0vJ+RWM3j36RfkXng7vsg0dBF9MVxUw?=
 =?us-ascii?Q?MLhp2yo8yJFHETdyMofXJ/p1euOvIXWbLLdUflfvNDM4junlQF5CqPWPN1hI?=
 =?us-ascii?Q?BaYX6XwiFTiGbtyA+fq37mS1OXA/P6hkFV5x0Q1GstioeWdXvxwwzdCSi9v1?=
 =?us-ascii?Q?52OFOWJe/ATyMSAMKBShAjWAlEdFAoWTeeHKJ3rKKnYlKSZaVsbjB9UiofYZ?=
 =?us-ascii?Q?XUPNSDwHzeaGgdqd1Uovsa8uQT5VPxWkpvbwoArSuFP4Jcgqx1E07GKRTpRL?=
 =?us-ascii?Q?cKN4UtOCd3mbSKke4UTmzbGJhXBWQEz9qjcTKsQiJBYZ1OeT0xn2hZ+0X21f?=
 =?us-ascii?Q?69Uz76R1b8MFJpayK0M6U/1pa5DL4mW+kYUW4ha1vOts+U5XC9QGHjOTVcoF?=
 =?us-ascii?Q?Av53gu5OrMa7mV8Epn2ODnBK81+Y7jfSu8KHppfrUSzGVoOY6Cw8sgNQ9wah?=
 =?us-ascii?Q?5CKRrKE08vWg+EAv0CX6ThDMWKm/3IJpdcL5gODhJV9FLZfUdkLWMeVVft6Y?=
 =?us-ascii?Q?tS2QJNAoL1Lm2CYvJk4plBqaAYDkIZgrnoui5BOl63y+swmLneZvqZ/2m1Fu?=
 =?us-ascii?Q?f2EJnp1mjAhy1Yoy4ebrpSfYaH47rl4rUCPH/hoigwoKhhMkrW8cfrwckeCS?=
 =?us-ascii?Q?Mh5tC9PKYxCh02hMXRWbXRsuOuBHraFXresEhyZ+N+u47+oZMlXim4rzHzY9?=
 =?us-ascii?Q?LoJx7RS/IsgPlktYPZKQyZh/r233M50kD9MHzHK7vhazU7bSRt+lcXUx6bXS?=
 =?us-ascii?Q?pZm17IXs+niUro3oFVslXRdZRvCarob+7rF8NpzwgaoT23/vr+CEZTe4RPFs?=
 =?us-ascii?Q?8v7Y0lFsvKh3eQLdxeO9QTLxoZshaDu9c9IOKHDQegcDSn5aR9PeREKUUln6?=
 =?us-ascii?Q?Zt71mw6gcwhsjeWGcxtjvJWJ0xiDh2lTKUvCHq00JXvzaV4q4p+hPlr2sG5m?=
 =?us-ascii?Q?1fdou1Mp0rYcMTJUuAu45J034ZFvDKZzH5NppXblpTyqTVpH2BE8VlPx0xXx?=
 =?us-ascii?Q?mkINCJp3UjjsMKnNO3IobZEYrgSTer8SiLOIK6aXzivZhqYnywM1fPKLTASp?=
 =?us-ascii?Q?a30BUGLdHRhtt6qgphKz1XilORb0KmW/ueVdB8VHfcMDfzX7yadPQTwqmt9R?=
 =?us-ascii?Q?IEhoPyFFDY95GRAmbMNuWDB+vn4OG+lhH9srKq9gZtEC7zXBpvbDbN2SqEkz?=
 =?us-ascii?Q?GuRxL1YtUbk9Si884yUFmzL2mj2T7EDfXFrbk7xSIWND9/KGRl1K9ZKzBrMv?=
 =?us-ascii?Q?Ls4D/qjGiFqZC0drGbQipfTDlUkCc7MoJS7AUCxQ5y202ifgDU4ry3oOBQri?=
 =?us-ascii?Q?rjaFVj3h0yd6tP6cN1I9OgxefXJg7FnZPWmGq1fKxmon94+U5EdCDozXE4Ud?=
 =?us-ascii?Q?1nYD1mnqsnTJH31BYEPRlFccZCKcSBH8RJdc2AGiB/kjqfcAQO4/gmeSZkok?=
 =?us-ascii?Q?xXrQGQ+PiER/7rUYZ5Gnp/5HeVjbUiTSGj2ohCvn?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7540c291-52a1-4e87-bd50-08dab55418e4
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 00:10:02.8214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EkSTbqZBY7VZEASp+IY+A8SvBhUZjKvVX6HJ2Apx/WREMqY0zVwY6G8rJcZZOVGx4rOsZ0aNvaLARNviRzjzBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6443
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 22, 2022 at 03:05:45PM -0700, Dan Williams wrote:
> Davidlohr Bueso wrote:
> > Introduce a generic irq table for CXL components/features that can have
> > standard irq support - DOE requires dynamic vector sizing and is not
> > considered here. For now the table is empty.
> > 
> > Create an infrastructure to query the max vectors required for the CXL
> > device. Upon successful allocation, users can plug in their respective isr
> > at any point thereafter, which is supported by a new cxlds->has_irq flag,
> > for example, if the irq setup is not done in the PCI driver, such as
> > the case of the CXL-PMU.
> > 
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> > ---
> >  drivers/cxl/cxlmem.h |  3 ++
> >  drivers/cxl/pci.c    | 72 ++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 75 insertions(+)
> > 
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index 88e3a8e54b6a..72b69b003302 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -211,6 +211,7 @@ struct cxl_endpoint_dvsec_info {
> >   * @info: Cached DVSEC information about the device.
> >   * @serial: PCIe Device Serial Number
> >   * @doe_mbs: PCI DOE mailbox array
> > + * @has_irq: PCIe MSI-X/MSI support
> >   * @mbox_send: @dev specific transport for transmitting mailbox commands
> >   *
> >   * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
> > @@ -247,6 +248,8 @@ struct cxl_dev_state {
> >  
> >  	struct xarray doe_mbs;
> >  
> > +	bool has_irq;
> > +
> >  	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
> >  };
> >  
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index faeb5d9d7a7a..9c3e95ebaa26 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -428,6 +428,73 @@ static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
> >  	}
> >  }
> >  
> > +/**
> > + * struct cxl_irq_cap - CXL feature that is capable of receiving MSI-X/MSI irqs.
> > + *
> > + * @name: Name of the device/component generating this interrupt.
> > + * @get_max_msgnum: Get the feature's largest interrupt message number.  If the
> > + *		    feature does not have the Interrupt Supported bit set, then
> > + *		    return -1.
> > + */
> > +struct cxl_irq_cap {
> > +	const char *name;
> > +	int (*get_max_msgnum)(struct cxl_dev_state *cxlds);
> 
> Why is this a callback, why not just have the features populate their
> irq numbers?

I think we have decided to forgo the callback but I'm not sure what you mean by
'populate their irq numbers'?

> 
> > +};
> > +
> > +static const struct cxl_irq_cap cxl_irq_cap_table[] = {
> > +	NULL
> > +};
> > +
> > +static void cxl_pci_free_irq_vectors(void *data)
> > +{
> > +	pci_free_irq_vectors(data);
> > +}
> > +
> > +/*
> > + * Attempt to allocate the largest amount of necessary vectors.
> > + *
> > + * Returns 0 upon a successful allocation of *all* vectors, or a
> > + * negative value otherwise.
> > + */
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
> 
> Forgive me if I have missed something, I only look at interrupt enable
> code once every few years, and the APIs are always a bit different, but
> is this not too early to read the message number? The number is not
> stable until either MSI or MSI-X has been selected below at
> pci_alloc_irq_vectors() time?
 
Well I keep getting wrapped around the axle on this one too.

This all started back when Jonathan originally attempted to allocate the
maximum number of vectors a device _could_ allocate.  But it was recommended that
we determine the max number first then allocate that number.

This seems like a chicken and egg issue.  How is the number not stable before
calling pci_alloc_irq_vectors() when you need the max msg number in that call?

The Event code seems pretty simple because we use a mailbox command to
configure which logs to use irq's and the device reports the message number for
each.  Thus we can determine the max message number Events need without
enabling anything.  But your comment about them not being stable now has me
more worried...  :-(

Confused,
Ira

> > +
> > +	/*
> > +	 * Semantically lack of irq support is not an error, but we
> > +	 * still fail to allocate, so return negative.
> > +	 */
> > +	if (vectors == -1)
> > +		return -1;
> > +
> > +	vectors++;
> > +	rc = pci_alloc_irq_vectors(pdev, vectors, vectors,
> > +				   PCI_IRQ_MSIX | PCI_IRQ_MSI);
> > +	if (rc < 0)
> > +		return rc;
> > +
> > +	if (rc != vectors) {
> > +		dev_dbg(dev, "Not enough interrupts; use polling instead.\n");
> > +		/* some got allocated, clean them up */
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
> > @@ -494,6 +561,11 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  	if (rc)
> >  		return rc;
> >  
> > +	if (!cxl_pci_alloc_irq_vectors(cxlds)) {
> > +		cxlds->has_irq = true;
> > +	} else
> > +		cxlds->has_irq = false;
> > +
> >  	cxlmd = devm_cxl_add_memdev(cxlds);
> >  	if (IS_ERR(cxlmd))
> >  		return PTR_ERR(cxlmd);
> > -- 
> > 2.38.0
> > 
> 
> 
