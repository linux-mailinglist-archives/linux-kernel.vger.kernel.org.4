Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643A663F5DC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 18:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiLARCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 12:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiLARCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 12:02:16 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADADA555B;
        Thu,  1 Dec 2022 09:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669914136; x=1701450136;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=spi2/yoM2ZdHnlQSxnx9JzpdaE8mov78yTxgowHwLEI=;
  b=TrLgg8X4wnF6+2g30DhRWBHFe/FfJ1BJDGPI/dz8DlKF5Dr6pqBGN3ms
   4+zK918iEIWB6S9h4gEY53MaphvwWPGePHwuqvBSmzGZXprHYrAM70lcI
   ceYA5NRYMBDE3wfyLzHscApR7r6/rx8PdoVqxX5sNtLTRhF8kBgfxztvK
   79GxOEJ7Upl3Wm0npiF6N0f+8xShTiIXuwizQpRF2f2y1fyteUL8kJEES
   sC20TM4SD2w22A5g35Tfk2BBvaBwCmwC59L0A5QrqqoZA/DFhQ/HYrTk5
   81GQZwscp/vpMlzh+ZlVpBbdX7cCoFg+5U3LOhQkWQxitJRWFME80g3MF
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="314439836"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="314439836"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 09:02:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="819114211"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="819114211"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 01 Dec 2022 09:02:09 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 1 Dec 2022 09:02:09 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 1 Dec 2022 09:02:09 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 1 Dec 2022 09:02:09 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 1 Dec 2022 09:02:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWdy7gIAr1sofVgViCq2W97ONjEHyLcNggUdLn6nGSS/s+UjjYW12civwLAkhAebt8nICTo4jS27uMdhYWKDlwVXxOIheZKKxbXdXHYuCo1hBDpSZ0MFFWJDAVUvwhUmBmPvI01OsH31SE2azG5i8nT5fYkcttvXH9CRfBbvkBInGmXmJ87xpsH7I/h2K+TyG7l5pYcoCtkqO0My+D2MGgRvQduFt9sHa5PgmskViuw0Bz1DqZOjKSaOcSD/KkCCTFMI5tYl+XJoKuemD0DBzdp8/fviLikVhWI/FW3vR+EkljE183wN+S7VbJXOyW5KJf/QRUtfcrNHkDtGCVy3Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OcEEp+0KjrRu+QVdFhDBKwYNwAQbx1+/TdvQv9Ywt9w=;
 b=eJhKPAd0Tq4zXFRDrmRir3/GsiYryXJdQnP74RNvGIowR76DHm9KzFfh37L5voVqxO7zD4gJefHn5pDYfGn1+te+IZ+v/w1XhC4Va/WAB8Vd/dwVX/X4X/DBZVlNYdhCBYCfNOwLMgZryHIHjJC92i4BYpwpltXHopjYqrgOXFq7C/h/kHegnINnMlFi5ZsBmlGbPSjP7q9PoMiXu7ZNbYzJfteEuE67bGTlQIb71ndjFeMinP9wc5b7vjshsDmhnvrUE4DvZIq5V/1kOwI/tiIaBM74gT4Pb20JBbaUTbwhQpmy3pG0Xkk+zvKasSA5oMZB1Wv8/RSENdHz+xEBxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA3PR11MB7626.namprd11.prod.outlook.com (2603:10b6:806:307::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Thu, 1 Dec
 2022 17:02:06 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%4]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 17:02:06 +0000
Date:   Thu, 1 Dec 2022 09:02:01 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V2 04/11] cxl/mem: Clear events on driver load
Message-ID: <Y4jeCWOKhbQT+nlJ@iweiny-desk3>
References: <20221201002719.2596558-1-ira.weiny@intel.com>
 <20221201002719.2596558-5-ira.weiny@intel.com>
 <20221201133033.0000090f@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221201133033.0000090f@Huawei.com>
X-ClientProxiedBy: BYAPR02CA0009.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::22) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA3PR11MB7626:EE_
X-MS-Office365-Filtering-Correlation-Id: 10a1ce49-4308-4360-0ae1-08dad3bdc676
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7cYixeUtGK2GBoZJJxcvPnqS9CBjeZJFozy46xXg2lCijMsShuI1nywuno/1h2WSUMazYapxlNJbQIrhmu5hihqUZEK31yMGAh5ob6MaXUEqYaDmeXj5fy7cH5IqCKJ/mTa2ILYfEZUZZPO212I4xcFzTfbxX4uU229QI2SFCHLsB0/L5WDRhmLEvgVK/nwO8jFY0+eOMMp2b2bTcH99sadt14Xk6kE55aELAfdB3b8PP+2aJlz6atLTdctfhWEnjsKEFfXET6VWIneO+RLwOJUf/tWj1StJsoZC/udUH4X3ZrmLBqqNXlZ2YK7xDmJ5uAXkPh+i7ozr/AccN2XD5HtV5zjuMqDbhOpplUZ0Xwsw2m3Jt5hCVRfXKUE0P7tfLz52rHcLLNHKQ/ZTdl3uoWH4oG8PwlB6WZTPEDH7dWt8yoHcU58PyWEbDizVwwq4c7YrzLuy5JO2tYY7Iy2ZqAHBo+2NSNODA9CQC6juFJzt1MtPYCk4xJhoeg89/ntASXKw5SeDAq/B997c9lUBfB4YamvrUq5AwPRCi3Db+6dIlgKOwwjtRMvHR7mAZZmoC4HgqXwKfaM9QvvEFwRRT/pqTZyQwilMjRsRCSPQy9udwO6c8hydpEWXDLu8cDy1k8m+CMqQRd+uMd82NOXVytqDNphjjL73Pep/AdjSbbn64ZSDhCLajof1J8th0eXnE42Zo2amI2IqFr4wGZfehNRihLvPz/dR0S0h4K9vHCo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(136003)(39860400002)(366004)(396003)(346002)(451199015)(33716001)(66946007)(966005)(9686003)(478600001)(6666004)(316002)(26005)(4326008)(66476007)(6486002)(8676002)(8936002)(6506007)(86362001)(6512007)(2906002)(186003)(66556008)(41300700001)(5660300002)(44832011)(82960400001)(54906003)(6916009)(83380400001)(38100700002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jwJ3EO3EO52OH3gw6qCX1SrNJVYPZojnky7Rz3nahyFd4hz55CclkuOHwpBs?=
 =?us-ascii?Q?Is0jlax5vJSFP4+9Nk9SCID18OjhBIw/q2MDcwFbodGfLRMmZPaSXHHDxcY/?=
 =?us-ascii?Q?NdU/iG4lHTlOzqLBp5yPd2gaC87pXWOSQeI451KS2UGNNNiHTBlcmtN72+lT?=
 =?us-ascii?Q?/I2DH9UPlNelK4CtQwFvvql62ytWICy41MAHcPBM2waYyyGjdi6wD/bNj7v1?=
 =?us-ascii?Q?CxcAfClM65J1puxs6M8goWL+dBqPBpsfdvxKklIfDYjZnKmNt+GAGpK6RjJc?=
 =?us-ascii?Q?pX8mxj1n1Nrf6wPvRQlMaiiX17qR/fcIQZxhSq23kQwE7jXnDjN0G2TgIodx?=
 =?us-ascii?Q?FnjeRTpI2kRZzLlkmuEafDLgEMioYMU+j6iBBrLTXNA/gvVOqlNkJ/ad839J?=
 =?us-ascii?Q?Wjqs9XahH32N/TozWtFQbuLRLqqcXCe3yz0uTbADglPi+oartnrkp4FLZnbN?=
 =?us-ascii?Q?6FXWRStLLXRNxUAVnMgGivue7jW8r8P3zMGS8pDurcUFjrTXHGRkPaQRIidg?=
 =?us-ascii?Q?BQ5MMR2Cv3IusunKcj+4kesjrZGsGUJW6AVC1vMOntPGid8ZLrsGEe42Nd77?=
 =?us-ascii?Q?Qop0KNMmXbPTi2Wo3FuR1ciog8c4Sg0pgBSeD5klYWQ/nPGzrfy1nhm9Az8d?=
 =?us-ascii?Q?GPAFpc58PB5HW+zYFS1N8Vafqdgu0nzXQjg5oRzvlL6fk14fC26hAdACC9KD?=
 =?us-ascii?Q?lC3vFTpcaMrKEpI0NZq0EVaPBjG/2sLSoNZxJp8ymqSipRg4EP10E6bT0IZs?=
 =?us-ascii?Q?fbp7XMz3lp6qrpe7kYzeDIb/zP1gaeiBSOVpI4cPEn00U3pzaP3wl6z3f6ES?=
 =?us-ascii?Q?X02Njl9IE6B043AeKMNShTbn5RulNq8g+NgYRof5j1rTBlHCcGMBbCOwvBio?=
 =?us-ascii?Q?bCdVHBuHW5Rf/VE1gKXvuePIbFm59txlq2wo06VZ3qBPMk1jbz25WvhVCLTJ?=
 =?us-ascii?Q?c4sDMP8US2/8LJD2rYEb37y6edeEU26s0luKUsnY+z63N0IXPkJEGJ1OwzBx?=
 =?us-ascii?Q?H6l3XQgWtN4DkG5EFQn4S9fKR+tWB/AKY411hVjxYBwcIpnouA9hIwySfe4V?=
 =?us-ascii?Q?2LpWtKkiVGGsfNKBunlphYmXDiLcZEX0KYsFIZA8CK/C+RAPduxOQaG5rYbe?=
 =?us-ascii?Q?wEmrShBgLsE1tCbDTYxS2cP3QeSNbnh28zu7itZTW2+5DJBXr62OU67k1DWC?=
 =?us-ascii?Q?SyYR27M3w7RxD26bCZQGJOpy+eWxvilUda2rzbcmADFpYcq1jisuVz6wRyud?=
 =?us-ascii?Q?NUbZVK8HeKowiAmz7wkq91CiC9R4To2tvD+3Nz+C84cIxkL7d3B1mocG2M/o?=
 =?us-ascii?Q?IEWeQTyLk9loFfhGLD7I3pMPo1Jged72XzKV2LVn9E/b02OSgTaAFGwx5Uzv?=
 =?us-ascii?Q?0QwfL8mpWGEUtTEmqXSnkVDV4R8UkTaWwKOmNO48Vor+jT8eGzVXQ5ea3mmn?=
 =?us-ascii?Q?9wcwt/6PDPlui7D5kJ1NX2GgYwCg54YQK2QjA6NsnQ42idrPSD3Nok++8+Dk?=
 =?us-ascii?Q?Xq2sy7pvy1yL4yFT1mZhWHqpUP5nS+OgOCPRYmbljPphWmYeIS5V9w774Pdq?=
 =?us-ascii?Q?bUlhPIsDgUMt5/sUrlybFux2fDmMH0RLl9VXjokn?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 10a1ce49-4308-4360-0ae1-08dad3bdc676
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 17:02:05.9813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XnNcTTIZsI9VemMxlEmXt4PxHy/r137Dgl8BbOW8bQzS0n552TnmrSjwiTxyJvwgLPL4M4N8NV1W0wsPMSu/MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7626
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 01:30:33PM +0000, Jonathan Cameron wrote:
> On Wed, 30 Nov 2022 16:27:12 -0800
> ira.weiny@intel.com wrote:
> 
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > The information contained in the events prior to the driver loading can
> > be queried at any time through other mailbox commands.
> > 
> > Ensure a clean slate of events by reading and clearing the events.  The
> > events are sent to the trace buffer but it is not anticipated to have
> > anyone listening to it at driver load time.
> > 
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> Probably not worth addressing but there is a corner case where this might fail
> if some broken software already messed with reading out the events.

Yea they can keep the pieces if they have done that.

> 
> Imagine it read the first mailbox sized chunk, but didn't clear them...
> 
> If that happens, then we'd end up seeing the whole list, but in non
> temporal order and hence trying to clear them out of order with predictable
> fails.
> 
> Maybe this is the category of things we 'fix' if we ever hear of it actually
> happening.
> 
> So with that caveat called out so I can say 'I told you so' :), fine to keep my tag on this.

Sure!  We probably owe you this T-Shirt already!

https://www.amazon.com/Big-Bang-Theory-Informed-Thusly/dp/B06XYCSQRF

:-D

Ira

> 
> Thanks,
> 
> Jonathan
> 
> 
> > ---
> >  drivers/cxl/pci.c            | 2 ++
> >  tools/testing/cxl/test/mem.c | 2 ++
> >  2 files changed, 4 insertions(+)
> > 
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index 8f86f85d89c7..11e95a95195a 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -521,6 +521,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  	if (IS_ERR(cxlmd))
> >  		return PTR_ERR(cxlmd);
> >  
> > +	cxl_mem_get_event_records(cxlds);
> > +
> >  	if (resource_size(&cxlds->pmem_res) && IS_ENABLED(CONFIG_CXL_PMEM))
> >  		rc = devm_cxl_add_nvdimm(&pdev->dev, cxlmd);
> >  
> > diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> > index aa2df3a15051..e2f5445d24ff 100644
> > --- a/tools/testing/cxl/test/mem.c
> > +++ b/tools/testing/cxl/test/mem.c
> > @@ -285,6 +285,8 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
> >  	if (IS_ERR(cxlmd))
> >  		return PTR_ERR(cxlmd);
> >  
> > +	cxl_mem_get_event_records(cxlds);
> > +
> >  	if (resource_size(&cxlds->pmem_res) && IS_ENABLED(CONFIG_CXL_PMEM))
> >  		rc = devm_cxl_add_nvdimm(dev, cxlmd);
> >  
> 
