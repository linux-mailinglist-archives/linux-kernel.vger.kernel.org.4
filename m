Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72FBA640E6C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 20:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbiLBT1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 14:27:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232993AbiLBT1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 14:27:16 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248B8E1749;
        Fri,  2 Dec 2022 11:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670009235; x=1701545235;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=O7K7bGWCS2ybuTjU4s6mj50a3yk2tSRqCVEC7tdFKoc=;
  b=SCooPQza73dxTv+8X08CySzbjyssiUBIC5zjidzd2dDKhsLIdk5YQvIK
   jOgiZ+fU2Ials+OwAtkzYniqG0l8Ok49gs5SMNTH+PuWLlACSfva9X36q
   2wlPUfUpB0iDNPvMLQmXr2PnmSe1SHEDXdODwmOD5K+yTU5dNbHn6SIsi
   W5pkZvC8Xjt/ChbL/BwJTnrGi+fJrar2iHHOg79+1oYCSSs9L1L8LrQOC
   ESbILCn3WU9qQKBDcZsl7Dh7DIDS3qXf5yGt28xsbytUGEi9s0s9YQAir
   cyE7snJ6YqFmgXhQsjn0C7hVxx1kdb9ZQzwQn95r9KmHhc99Kc3osI8xn
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="342987312"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="342987312"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 11:27:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="638849336"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="638849336"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 02 Dec 2022 11:27:14 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 2 Dec 2022 11:27:13 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 2 Dec 2022 11:27:13 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 2 Dec 2022 11:27:13 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 2 Dec 2022 11:27:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mw/m1jPi7isoI3cTmJEhq46SJpYCZCWz79jTM+o2o3KQjW/R9Ds3nly6HNFrz5zlgXAiexOuZshcFRTpnu/SGHQ7k7MM+U1OsFBZRxwuAfr1g1uhiFiNZx2sFRPgLeltle753MYvuqrPwcI8SZUP75OlrvjZRiw52ra9xmwveNZM8x1+dv1RX9pbfL9P8HPUh9PNi3CB+FCJVg9ypAQeut60polCCjWjWgJ9wqQn1tpsU1pflAzcie+yxzUJV0gDqYyQF+HGc7j1gBtm+XWz+dwjuFFCq44nWx/upO6m9VuN18yJLPsFbp6nLtMUrel/s8FiF7OAT7Yo9Ec9IJjHaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6iUc04Xy0cr67nbjyRXw5bWhSJv6157y+mkNZFiRBgY=;
 b=l9UjvSOXZHJ0u9twRfTk8BBEZcTBvfC29kI/A+JEQPP4N5q+369q160doVsePcoMVvJvOonc/ARYaJvzajng80UDH2vUR87Udaxed8m4yXQXnVYnIpvxuG4TJ9BAu8QIyivhfRhEM06cV8oNFqJpYoTi53jmV/4mwhszL0ol0ITxwqX3zghL4tk76L1ynvxwgUZnBbnEuzBbpwc6mIbkSSaPvgX8LO2vZ+oCiZTSG7aeu2CbZNz9gPDCSsX1+Oq3fhkbAl/0BVOIjes9zrPyCUcu/slEiurVOl93qcuvKTlB91gvIRSTA6oEs9V7UO33iSb3qqqkSwMAPL2FfA7gUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by PH0PR11MB5142.namprd11.prod.outlook.com
 (2603:10b6:510:39::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Fri, 2 Dec
 2022 19:27:11 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5880.008; Fri, 2 Dec 2022
 19:27:10 +0000
Date:   Fri, 2 Dec 2022 11:27:07 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V2 03/11] cxl/mem: Implement Clear Event Records command
Message-ID: <638a518b9c9b5_3cbe0294b5@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221201002719.2596558-1-ira.weiny@intel.com>
 <20221201002719.2596558-4-ira.weiny@intel.com>
 <6389630036769_3cbe02947d@dwillia2-xfh.jf.intel.com.notmuch>
 <20221202083448.4b3b3254@gandalf.local.home>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221202083448.4b3b3254@gandalf.local.home>
X-ClientProxiedBy: BY5PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::18) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|PH0PR11MB5142:EE_
X-MS-Office365-Filtering-Correlation-Id: a0aebc22-d768-48a2-2f96-08dad49b352d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1NbajNTRvGDSa72MTQ9HXjod+mJ+w/WE/6CYp6Wkjp5ZgbfN8s8p6vv846/g3/LPXWeq6u8JeHWIsgAtz479r6etelwTQOYn3i92FGgMfocvrX203rigLY7FXYln4E04X7C20n7zcvh4403WZW/e9Wc17PJY7K2p9+xuTrXsZSN+z14zhcb777cLJOaJpdhEdxXrkFa5+gfCfJXbB6oq0mUxsdTtPU8o/R7mMfJL3/P9gAolxHNdbb9NN01UxGX0rbsxZeJnBlFlhcT/3s99IzbrtHNH5Wiu6eijiVv6KaP61TT54LSS6Kp5dDQRkhtqOczCpiLs74jQPvOMR+tncOQ8hli1mjCbxgqAua2K03Fx8JaTxM+S9UyqGzHFooOZSW+BlW8cujsKAmm0au9Wt0vMbKdw8aC+LABlpQPVUcKRD3i82E2JRH6Y/v1lHxIku+6gqk+wMbvb49vO3cqtx3YLc/6le9fbM8iEkxsnM0YcJF8d2as564+ROyqPi183Qo0aApl2oIDVrZUJ50gsmDflc+WOCd26qeSo5fH1Xzl5mQqaS4nPBvd5cRiq0IcEswp55Izq0cP5O/+O8DvbR4yaDuNYG3uFXgrotUK7d190TcUh1ELjqHU8pgvFY5Wj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(136003)(376002)(346002)(39860400002)(451199015)(66899015)(86362001)(5660300002)(2906002)(66476007)(8936002)(66946007)(4326008)(8676002)(66556008)(41300700001)(83380400001)(38100700002)(478600001)(316002)(54906003)(110136005)(6486002)(82960400001)(6666004)(186003)(26005)(6512007)(9686003)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?92cj4DVhwj6FSX+u5P89SGd+LjchKKotFzSlkRQ/TuXLmUJSK2uzdH8/aqLo?=
 =?us-ascii?Q?IFf+ZtmuP2Bn6japLSt2ux88bHDQaj3uhyeICc1AfrU/l/sm3kmK5GM4a0tG?=
 =?us-ascii?Q?twPQzR0WCJ1xSBrkIFGO/nLvXI1v8RlWCMdoXM9bHnKb3meqW88etpuPC8bf?=
 =?us-ascii?Q?nxN9V28xy2lbEMq0xtuxB987jcEldkOFPlrA0Uh/Y9GC8BCwH0M/KiL5Hhir?=
 =?us-ascii?Q?tygWGfH8WRNTBJWIoYiH02sYqkzizMBf1DVhgFYno6D5P80LKkcnJazGXZL7?=
 =?us-ascii?Q?1vCdvK4KNm35/pI6bkk6pJLQgJ+OSvmkxhdyf4lqdvutzNsRV6g/5KOt0Pc/?=
 =?us-ascii?Q?MmoWgMMXSRw9CBKX9BGxNXG/glWgjQ+jFHkOTg2FcabNz8CwCGobzUicz5pl?=
 =?us-ascii?Q?zz4RL0aq0/L3tZbpM9z+OV+iA5I8F9ySg9sieMUtLQTztQQw7KjfX3NpR7v7?=
 =?us-ascii?Q?ByEJtN5aJhaMIkyrbScHOnxVyVFjFFVYgDhtrXD+hQc80LUToBIF7r221SW9?=
 =?us-ascii?Q?vMQ+I096Lbn0CMZ+codpcSQCSPSkIxyIdwANXEX2tPi/JHTIZ/uL87gnzRIB?=
 =?us-ascii?Q?jBlsoS5syB8Pcgg394SAFspXodOQyrYW4JgY99r+AJRk7LsFt7oU+UopApwF?=
 =?us-ascii?Q?FBhE5G8BtCtzcM5iZ6VMxGXXkwRP875X0qeZ8sKMlJYpncDInn+bkO4riIoM?=
 =?us-ascii?Q?gyRlvkJt316aHn84SGsUnuCYzLqxOqye/UOrIhKIiRMQiRpArVhIw6xGbgBe?=
 =?us-ascii?Q?1EWcU4Rh94NRvNGmVO8CWr6jWqO/TWPEiq9QGLFVYcOwhKPrzRJCOH1kpwZw?=
 =?us-ascii?Q?W+znobahc1kvqBlutm57d3/mCVgt67VK4n3cwz9Fwoa5V+zpv03P42CGQLry?=
 =?us-ascii?Q?3XHfCa9ipURY1XpCycTWdOFC4GPhm/JSWvKFIGLD6mHmXfiSz/pCZ1MMEvya?=
 =?us-ascii?Q?tYn2skDlPIEek4C5LshEhgsAGhBwPBbby18B9ST7cu77zaYjxWCJg5TV8ylA?=
 =?us-ascii?Q?OMPruCDvoWcknsfPIiiwe/+HLEmLkDFAgGFrrg1kSLj0bbPvCgOD2biNDzDe?=
 =?us-ascii?Q?MYqUfw552Mx2XtVKJO3/102WINWAConF1PxnU1XrRIA6/iSiFOfU+gwoEuow?=
 =?us-ascii?Q?93x+/DngDR5BUPYhrTe4veg2vyVQyNC+I+kCT3Dnhm21gzC0AstFrtlUgvfM?=
 =?us-ascii?Q?5BAGtrLe9iI6p4DweUipVtFUpt+EnJXLWOpyYcMS2BLbrvJDtu/n575BE4oG?=
 =?us-ascii?Q?RCZa6ngBS17Lz9jcbNXwtq0pUnBZPenNs1P5WIKaTLyeEzN31/4RwDuFcrZ9?=
 =?us-ascii?Q?cdEmk2t+AtGbyHai9EugGMsU7u4ftBSIcz/mbg7yHpDUGhr+PK7ieD/z8N79?=
 =?us-ascii?Q?U4OUlHuugHYXm+HEyElUcD7FFSHYCaehVjRZGcw7NZVkGvXJrTJRhyu35sAL?=
 =?us-ascii?Q?tIli49kq/sc0fztZGONKuaOHK/yn3zrntHCMNBDiPPVwynH6Q7tZktHMFuqU?=
 =?us-ascii?Q?VnWKZ7/t9LwIpYUgp46Ck/qeR14sEnlNDgtBl3Bf2UJBYmN2UCOhw07fGzwv?=
 =?us-ascii?Q?SXHhlR679WXAtRDPqn5mRbdK215p9wGvjjcI4i4SLktMBLbPJYLc5nkIoX+U?=
 =?us-ascii?Q?FA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a0aebc22-d768-48a2-2f96-08dad49b352d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 19:27:10.7425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aKDEAMWa/UhR32D+QPn3HF4SBrzeRYGusZSJwEGKMF13lSNKt6mrjBLTzpM2dp1PkqeBWRjznaYIkHJ9ZwuLDVXy90QcTjNuXVMhD4QbcBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5142
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> On Thu, 1 Dec 2022 18:29:20 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > >  static void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
> > >  				    enum cxl_event_log_type type)
> > >  {
> > > @@ -732,13 +769,22 @@ static void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
> > >  		}
> > >  
> > >  		nr_rec = le16_to_cpu(payload->record_count);
> > > -		if (trace_cxl_generic_event_enabled()) {
> > > +		if (nr_rec > 0) {
> > >  			int i;
> > >  
> > > -			for (i = 0; i < nr_rec; i++)
> > > -				trace_cxl_generic_event(dev_name(cxlds->dev),
> > > -							type,
> > > -							&payload->records[i]);
> > > +			if (trace_cxl_generic_event_enabled()) {  
> > 
> > Again, trace_cxl_generic_event_enabled() injects some awkward
> > formatting here to micro-optimize looping. Any performance benefit this
> > code might offer is likely offset by the extra human effort to read it.
> 
> This is commonly used throughout the kernel, and highly suggested for use to
> encapsulate any work being done only for tracing, when tracing is disabled.
> It uses static_braches/jump_labels which makes the loop into a 'nop' when
> tracing is off. That is, there is zero overhead for the for loop below (and
> there's not even a branch to skip it!)
> 
> But sure, if you really don't care as it's not a fast path, then keep it
> out. I like people to keep the habit of doing this, because otherwise it
> tends to creep into the fast paths.

Duly noted. It makes a lot of sense when you are tracing in a fast path
to skip any and all preamble code. In this case we are doing it after
doing a whole series of uncached PCI mmio reads with all the stalling
and serialization that implies. 

Speaking of which, this probably wants a cond_resched() after each loop
iteration.

I'll note it is also a tracepoint that is likely to be enabled most of
the time in production.
