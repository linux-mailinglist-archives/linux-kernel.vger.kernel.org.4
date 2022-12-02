Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316DE641007
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 22:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbiLBVb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 16:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234460AbiLBVb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 16:31:26 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803DEEE95A;
        Fri,  2 Dec 2022 13:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670016683; x=1701552683;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=o/H9i38P/d1mfB11eKbVOE4ogHz5Q1/tMt5K9kNBd2s=;
  b=XwDD/ITssfna7SkPWMc+oeGV5sVk2sKTAhjtt2vr6acHd5T0s+DYTRhx
   h5+7rdfXhdD+P/kcvFz2C2nYDvpFk/4gOFSszqlWeOiBpm51uDiTMIwBm
   hl0uJye2HKpxtzDN+MsYBOXKVtSEYDVudlDUEIxBdMEF18x0IwiD9EoNp
   IWsmxVht2VQgFSAcepnDZ6JJMrayvGbXiEvE92lPGhUw53VLnpfEaCZU4
   1tM+O4I6GglwX+TkrdJRJniUgEd2k5NEPAuTY5s4ga2nffVjqFZWY2AEp
   kDbptxzXTRL7KaroN72Lfct/7hPnro/vc+nFtRuS1dqb3xb5xvm2K4dq/
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="316074986"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="316074986"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 13:31:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="638881136"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="638881136"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 02 Dec 2022 13:31:22 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 2 Dec 2022 13:31:21 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 2 Dec 2022 13:31:21 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 2 Dec 2022 13:31:21 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 2 Dec 2022 13:31:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ql8NGDCF6y5pd+Q9v18Yfo7WDn/CT6G37xjY6JXHrbKUecimfJ4uYcziGVrrO1aVF3VtsEKL+nLTgycmdQEbQce1A5pkn6R0Vq3f7w2p3R1K7Ycq0ZfPEIPu+MThX02xmCeE4zqRGE+UXw4NIHsjbh/KVEoulXcdJ1yXQTpWjRtMsbtnzL4YeQc2F0c38niLfoui3hJT9OOzB+yOE9bXL6hmK/pwYwPaP66Pm8mxXJqHe79FHzXCIStExYAgawnctjvcbrVggnOAb+2xNYVQ4OPyXW12pPfv+tzU0k7usjygJJ/CN6d+AHpTu59exsRIgXdzp6yAj50wxL8mbG6ozw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KoNuU6ndhgce+cP1J2v12kzu7LLbz1sJ2n+SghVtaFQ=;
 b=GWOBuV4V0XXeAyt2ZnNhoZoZKvscz3PHqEpy+XbdrSMc+uQPuNAkZF65WhshaGbA1QGYWvWIxAAV2wRE1L6s3kNvF45R+UOPOJm3VPIEAzvyzzSRrqL/uzfv1IxVbC36mfYtN5owS2Qme4bCIFz2r+99CsH2xTS5CV8qm5OpUwGU/OHa9+R3BwBBjVwLzhhskvIuSLcH0+ZvMilt3dR1bAGzdJW3MDo9zF516IEaYqgeQSItgTEWXiGODhYNKXBNRXi6I/9PI2FHV/I1vfo05bKfKabczmCKyHFi3v6JXE6pZOPe7aBxLUskOSbju4Mtw38cn1gXm9gK8mV6pEOAxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS0PR11MB7506.namprd11.prod.outlook.com (2603:10b6:8:151::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Fri, 2 Dec
 2022 21:31:18 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%4]) with mapi id 15.20.5857.023; Fri, 2 Dec 2022
 21:31:18 +0000
Date:   Fri, 2 Dec 2022 13:31:14 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Dave Jiang" <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V2 02/11] cxl/mem: Implement Get Event Records command
Message-ID: <Y4puolf7AF9NkNJ5@iweiny-desk3>
References: <20221201002719.2596558-1-ira.weiny@intel.com>
 <20221201002719.2596558-3-ira.weiny@intel.com>
 <20221201123849.0f7802ce@gandalf.local.home>
 <Y4lCLfQrjyRtLmDM@iweiny-desk3>
 <20221201234052.35e5a001@gandalf.local.home>
 <20221202000059.50d4961e@gandalf.local.home>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221202000059.50d4961e@gandalf.local.home>
X-ClientProxiedBy: BYAPR06CA0029.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::42) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS0PR11MB7506:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ca72d23-463c-4977-97e1-08dad4ac8c3c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i5FapO4FNWbOYbmuJt2q6JBZ3WfgqNmbbQTcPhl4VC37UB1n0xWdT/K1MptZesyWF5vlasYvTgs1kfmANeZfJ5UGC3Mu59M452SIH2X3OFai4IRyM+2MvFWPnJYC1xC7fLmTL8BCQHU+kcnB2EBwvyoXRSmYVjc+Hza5q4PwhY9kUBneR0nYD24fXaBYsLQifcp8aR/pwmKUnzMijmIticOPxjCWARDC1TUjPdi+bEkl4TuaT+PSHwCVk3L0L1EqCUD1pGyv91da7DJF5rpRBPAoApo7Zv8lIc2r+5TfBRjn5CboKU5ArwsWfSmhKwWM90HfkzxzBPIceUvcT6rqynaZqEeo20bHBMELsVi8NRV7Ht9k1mI6y0vRQGXq+npm3PDTxM9KXZTU3SI6xFCS45WMmG2FY1PSexqnZTrab7VI3/2OANC/Zl18FCAtJl21W7EBOJ9mxGP/F2KhMWwyoNWKIZdddoZb806aIEpBKQUJZ8EJrorSdg/6QBwaIpcoLD3t5+v7oBOst5xKgt+Bzyxx6RVg8HsQ24gr4MVLoEjdK1pSIS4pCbR0Z4KLomCdMELWfBFmTS3s+hCz8/B4JjDIhXLIsMrBuiH0lMgr8k7RNtdk8998IbC5sSS9F3lLfUtb1ZTBojDJNjBWsWngYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(346002)(396003)(136003)(366004)(39850400004)(451199015)(4326008)(54906003)(8676002)(316002)(66946007)(66556008)(66476007)(38100700002)(82960400001)(478600001)(6506007)(186003)(6666004)(6486002)(26005)(6512007)(33716001)(6916009)(9686003)(86362001)(44832011)(5660300002)(2906002)(8936002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qNldnslcMPf4vPln8S8gjxLoRbx1AzMOrgT7pu97DyCCRHRHqK4rLaEvQ6dt?=
 =?us-ascii?Q?4YMMg9CRSuIHT+kAnf05A8Lk2FysyR+E1Cz0d6TuIm9dYKGQIqWibzrzJWbd?=
 =?us-ascii?Q?++DF6mxbMYfI4P7Pn3FEjVmqEHJmYqOOGX3wvZXEoouIIDaHKJdC0tJQCQOo?=
 =?us-ascii?Q?X1GLXxAHNLFkwrK5yvmPdLBpjdsG/oOS4CRLzfstEiDkcrSzqYoBY1pm3pwN?=
 =?us-ascii?Q?SOB0qDRLvRMd05eCeteoqLC9oTNcRfzh0fkxcbgtfiRGuvVyZs9NpgiM/1QX?=
 =?us-ascii?Q?X0tpm6L58kMfBE4FHx+/ZSLxHf8SNmB10yBMh6PKenv2uZdSGPJPouZDtZov?=
 =?us-ascii?Q?Vs4dfefZ1Tfpju/8UIuuw9K5w5Lvuboxreb5xOKl+ZNodT2AG+sG42u9xbX3?=
 =?us-ascii?Q?J7FWe2mCQ/2A+FJbtAvDG8i89X9SfYJuCdvXGOBzYjAKVL4wlFOcldqEs5Ox?=
 =?us-ascii?Q?8GgibZ5oLdR8f854lVN4nmtC9qx9HFwxy8vHxJYzyauayACSBV8Z1fS548cb?=
 =?us-ascii?Q?NPpHSciyAESWTf8FNjUV/q/fUk1elDAYWNvzGoWEum08yks0dCDLHSfMuuRi?=
 =?us-ascii?Q?bRoY7hlvsf8mEX/1wBDi7Yp4XWKzScQdGn3TxUgKT4iE38msiV7Keo6p//a/?=
 =?us-ascii?Q?GvREGM5iJOFypkg3ocqdEfmZcxOrn1K6EyuO0IssLXIyDFQT1RvtPANWd+uD?=
 =?us-ascii?Q?H8EiJK9ywn/+U5GIk5Ma8+/b7CEi/Lv9Ir/48IpegXsLQI9pgJQolMI5tKnN?=
 =?us-ascii?Q?ze713Oi0awIXKi3opcUG1bUS1P2L+9sMmsOYtITdoIRSs/qS+i9whfxyHZcN?=
 =?us-ascii?Q?OpIppITaS9Iu9ppei37KPuO6xVv1HIsHzVBC5gvzGiMyWRXHQX0SgzPizksg?=
 =?us-ascii?Q?Synou5FbzPRlQZhb2cMSCcVZ0kMomxOhaO4UblVuQyxgjfTDRDvYh5ls65jg?=
 =?us-ascii?Q?Tfec08k4kYuSCbDZ0QFzJjnRaDNnmEXGsPlo8fVDqVo12lE8tr8oZurSYvK4?=
 =?us-ascii?Q?2IKCwNyD/oI1jQYZDFg7Su31zMfHM1et2o8l/8Fdn8oTW2o0jxJDwWOAgiqf?=
 =?us-ascii?Q?Q3o5FeVmF8AdZscid3JphtGIElrtfWd2qXPMoUyq0bYOw9RSqf9Nj1Qq8Zxl?=
 =?us-ascii?Q?3/G4LrmXL3YPZqZH1JMgD1OB3lq8C8KdKiAswLZvwZktmU6/LWt0KnXHYuYL?=
 =?us-ascii?Q?/KhjvnnyIYhi3xtMoeFz87swjD2ktvdEdan4TABC9DwfOLbrNBQ2MY/lDSwM?=
 =?us-ascii?Q?Q2jTbmZliLgGl9ehn44ksPiTgtN0NM1yzpibB84XCF7sGnJ0D8xH1Mq8KWyi?=
 =?us-ascii?Q?ThAGLILTTVdxD2UruyXLw8EhwdEUmabfsZFZdT8lt8d9+a/kXM+fj8qEK+2R?=
 =?us-ascii?Q?rKj6BXZN3PM9WDe9SQ4D5xxlBibRHkgAP8e20EjWg7dP8xEB1p73mHi/npgj?=
 =?us-ascii?Q?15VBTReANOIiDCBxEmyBzH3pCEFJLwyJ/Oq4wB0n0kdsSbbCx0mWiJ07WLgw?=
 =?us-ascii?Q?D9RsxpXHqeGg45hAqOd17XoFYAOFbXjG5JmwxY66FhPCQ7xP/WCVhkiEmedg?=
 =?us-ascii?Q?Cr1bdbk1wg71or8ZBGjBnbhzjzA/HBlbv5lkib7K?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ca72d23-463c-4977-97e1-08dad4ac8c3c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 21:31:17.9841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VwU4RyAvFu9fFNYDwZGocl6ZuYvHAFbWx98xtZCyobI8KpGo8XM1x7aZeZqqhC3JOH8XY7MAF1QFpEUqqkjjKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7506
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 12:00:59AM -0500, Steven Rostedt wrote:
> On Thu, 1 Dec 2022 23:40:52 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > +#undef __print_symbolic
> > +#define __print_symbolic(value, symbol_array...)			\
> > +	({								\
> > +		static const struct trace_print_flags symbols[] =	\
> > +			{ symbol_array, { -1, NULL }};			\
> > +		__print_symbolic_str(value, symbols);			\
> > +	})
> > +
> >  #endif /* CREATE_TRACE_POINTS */
> 
> Bah, I want this outside that #ifdef
> 
> > diff --git a/include/trace/stages/stage7_class_define.h b/include/trace/stages/stage7_class_define.h
> > index 8a7ec24c246d..6fe83397f65d 100644
> > --- a/include/trace/stages/stage7_class_define.h
> > +++ b/include/trace/stages/stage7_class_define.h
> > @@ -6,7 +6,6 @@
> 
> I also don't think I need to touch stage7.
> 
> New patch:

I'm still going to defer this but will include a follow up patch to add this
back in after the bulk of the series gets in.

Thanks for helping here.  I still want to understand this all better but I have
to focus on the main features ATM.

Thanks again!
Ira

> 
> diff --git a/include/trace/define_trace.h b/include/trace/define_trace.h
> index 00723935dcc7..9d665f634614 100644
> --- a/include/trace/define_trace.h
> +++ b/include/trace/define_trace.h
> @@ -133,3 +133,24 @@
>  #define CREATE_TRACE_POINTS
>  
>  #endif /* CREATE_TRACE_POINTS */
> +
> +#ifndef __DEFINE_PRINT_SYMBOLIC_STR
> +#define __DEFINE_PRINT_SYMBOLIC_STR
> +static inline const char *
> +__print_symbolic_str(int type, struct trace_print_flags *symbols)
> +{
> +	for (; symbols->name != NULL; symbols++) {
> +		if (type == symbols->mask)
> +			return symbols->name;
> +	}
> +	return "<invalid>";
> +}
> +#endif
> +
> +#undef __print_symbolic
> +#define __print_symbolic(value, symbol_array...)			\
> +	({								\
> +		static const struct trace_print_flags symbols[] =	\
> +			{ symbol_array, { -1, NULL }};			\
> +		__print_symbolic_str(value, symbols);			\
> +	})
