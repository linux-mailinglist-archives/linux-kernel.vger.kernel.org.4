Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62DA62D084
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 02:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbiKQBSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 20:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiKQBSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 20:18:40 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756871C121;
        Wed, 16 Nov 2022 17:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668647919; x=1700183919;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cllx0O8b7BqbZz99h3skNUyjIdNByyHuXQ2b+6DrF7c=;
  b=Br3GcqnstGrtXCMi+hH0FYVU0UgW5d9Q8DhnPpWj4em3HNFY7w9V9nsB
   WWiMWnT/JzGro2lM+t0Jxy8XycBOoh8KKnT2o3BpwwlUvu9G5x+jpgPAr
   QLmsZjLdtkt+4RoYmifMajCGDB+NobXsGMh7nYWM6knwzMYDCabyJaeCO
   SpyWaRcWjdaUEFYVqMEvzdVAOpwnIF4TkiRA3Vhh4T6Agt+zGR7G08GUC
   Gs+iPUY6w4KwaIb0b/kK89Bx1GSiAxt3gT9EW5YhJ7pxDQzYdqQJg6+rB
   ymoWpO2mNfxnKcgEldQcM2cPQxqdj1iPNPATES/nUxp407FMvoVgwIIfl
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="300249901"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="300249901"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 17:18:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="703113257"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="703113257"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 16 Nov 2022 17:18:26 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 17:18:26 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 17:18:25 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 16 Nov 2022 17:18:25 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 16 Nov 2022 17:18:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Whi/9JJBmSVkUJx45HgCZss8btyAhTKSSvAi4CamjIFeC5opGFiUIs754fBQA/yxtMlgmKAY1rvodCwHshXknKgQS//XU408ZjqU5AQZaH+UFL9FS4lv6gkBaE7KwbjE3IeVKrKXONND7zuXZ+RGoZsJQJ+EmMkZCdbkYeLLlT1VOmdaDVGeBh+IeimYWz8A9LPd3geKZNU/nYCWcY8u6xnJZwMc6RrqklZcZAQzbudTHEo9sOJ1AOY21Fh+THJtgw2ZrqqQjNhIXnWuB+bVZ1PK90wGDTqSGAsMoS2RLiPxuxzvOXVURWQX/9mztY8AqUl5jV+nQ3Pwzn/ckAdU3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4bSAtreKH97soEj/eO8kUvt5nJXJN5Zb5iXfdFZG4Ls=;
 b=deVoR//zNwj5Xf0npRpx2ytcC3DbP8FgOpTuAwE92YD2CPpoy0hWz9SD26/eHDj5JKxCjjhpR4r79pEE5uClm8oF3FxUMZ9JMmKhtbBdno06EnD/kbGOEbE1AqOevmBNsHIaTx+navlkDRfjvFiSuo1c+aXDlR7iiEUfPyJxZkCOIT6xPJA358Ull5tcYCYgZZ2fjIOTgiZaLgLbzY8Zc5n3lcRVw67WfIs8+YGEMEP5jzls/o1cz8k9ZfREL7H3bv+kZCBvs/bbgoVyqscRknnROmogFZMVmvZnSpixFFRzGefbbJbaRY/g9J1iiXpWfC32Q6abiL3Jpkhykl9ZFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB7478.namprd11.prod.outlook.com (2603:10b6:510:269::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Thu, 17 Nov
 2022 01:18:23 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%5]) with mapi id 15.20.5813.019; Thu, 17 Nov 2022
 01:18:23 +0000
Date:   Wed, 16 Nov 2022 17:18:19 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 05/11] cxl/mem: Trace General Media Event Record
Message-ID: <Y3WL2+xhA/VttQt8@iweiny-desk3>
References: <20221110185758.879472-1-ira.weiny@intel.com>
 <20221110185758.879472-6-ira.weiny@intel.com>
 <20221116153106.000025d7@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221116153106.000025d7@Huawei.com>
X-ClientProxiedBy: BYAPR08CA0024.namprd08.prod.outlook.com
 (2603:10b6:a03:100::37) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB7478:EE_
X-MS-Office365-Filtering-Correlation-Id: a156a55a-5faa-439a-43bb-08dac8399f00
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: remf0963DH8jTwTrtktf2SptT4+M0F6p1B9/4kqs6DP0b12jOJqtbd9biwoZjzivo0151dKui9rQLEA/MgRQNn1EtrVU0iFJBrDWQXpDvf4iRCykMBoA0MKIfL196lUy4bjnJiCJUlSDpiq7eaDADNh6O+c9EZWS9l3iJ+ZKDiA8uDgh8+Q0U9psWJKsUDehANPcf3ksJXxB9Kh6DViYLviD9uEHa3+iAYs5w+IslsY8n68xLLNSIgBwzmaqDutLJS59cBlllRwWZQlM9bFmZmEYivNKsib9sE+UmDmb4pXY4fF5OMxLZ4wCB5GsC9f3kdDBJXWCJVIqrsJBFdjWjJyKav/+5ScR1uQGhakvHAffWxBIi2XzrrgARGy3LWUNbBr4UDzkZsAzIRTAPOM21qXQfdtaOP+2tdJbljDuYPrsNexCQiCzqRd5gbAznL2ZmJNf/2EViS7K7gZmtto17CISb5LXknkGM+AdxQNjxIc9Bb0E0i1WIzgg2BRlp2vZjDXgrqigOMD9tKsVON88gQOvRYxtyPug8DiY2RZRIcFmUBChOw3/oAuBFlaAfiL3/1XdogJfH1fF1vfstOm8wlWzHEX+97PZSOejeuWuTwQv35OlBONLUWjEFDlIm/g7txNeKJJIvdpxsJ0BZJ9/s00pCBzGaxY9Qyl5eHgCowJHKfhxIuSdeG22o86yvR52K8RsEkMXY4MAxtrb11SDjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(366004)(396003)(346002)(376002)(39860400002)(451199015)(66556008)(66946007)(26005)(6512007)(9686003)(8676002)(4326008)(316002)(186003)(8936002)(5660300002)(6916009)(54906003)(41300700001)(6506007)(83380400001)(66476007)(2906002)(86362001)(38100700002)(82960400001)(33716001)(44832011)(6486002)(6666004)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1ZGiV9AVQzvwI1Ou2GSBW2fh7+sGBydShwg04GRKunRmjFzIjygk1F3Yog0i?=
 =?us-ascii?Q?Z7APKtNWNosSUtj0YsJ51D8+r/o8f922haScpEe1gTl8QiXQ6iHzCfymLD1u?=
 =?us-ascii?Q?X0eWpVEpks7QK8mKtULjsGlJBQa0PuFRdcwEJop5N/83I1aNwYo2qmzs5C4P?=
 =?us-ascii?Q?O3tUwSZERtdouSyymC/NdvTSjx+Qyf6QL0oYqfUDv52xcinR5f7OSif68rQ7?=
 =?us-ascii?Q?Ev6cQuR35m3+19op+2RJ+Pu6VY74IAMD0SyskcxMIRCVnk2BJB9ipYwg1tfu?=
 =?us-ascii?Q?D+5dYgmTJYRuNr+pxHNjlbBxUVI11Dj5CfysgcXOdWUiN7T74JFksSVMZNfX?=
 =?us-ascii?Q?tpU9/P1HsG/Fwyl/vsK6tCspkmT9+0pC8zjMCKcEsIlu0U/aO7OueEZ4PjjL?=
 =?us-ascii?Q?O6mkLAkZ88YCXu/xBWyN0y3X6oAnXQgVpRMWdH4yrZb1yTthRVsMakWzLpVq?=
 =?us-ascii?Q?1UfngyKqh9fwlcQ5OlRKLak5iw81+XG2a29KYtYDCN5Moj/RKLdZqeL2Xfsu?=
 =?us-ascii?Q?ei9ZvKZJql1nrwgjtCNjQUH3nHca+drcs2QQUg9d2Wy+c8QtsHf9fddeoqoG?=
 =?us-ascii?Q?ze9tLC1SL67MzI5DGw6DX/JNje8OrfgYbtFj5oUitEOTdtpQhGiVfQDycKwe?=
 =?us-ascii?Q?D+OzpSKQt4sXu7jgZVk9gTQ2+XmTgHszNN+uvNpibZGzT6W9c1q7K7qE/jwD?=
 =?us-ascii?Q?7M1am5J2ybU6nXAaE+h2XlHcJ6nU57icrJVnwL4s5jWBzuHJ0vAPa+8PZdKF?=
 =?us-ascii?Q?JPVhs2ltdxBZLSk9Q1LoLzJCT0brGDEhDFHggcsrgs2cVifaYQvX8mVRMSuw?=
 =?us-ascii?Q?30G2vUiKslMayTgyzVsL0VCTZbxAQkPRIzYZUfRMTdgKdqFf2eDq6ZXUzetA?=
 =?us-ascii?Q?aLIldLuUqkmt978DbBD8z8fkNyguxt2PT4iMgzumhPdxPrRDQNvZYkcGslbI?=
 =?us-ascii?Q?EUU/FHoolU2Ckw6tm2joTjGhQM8STC3vzXWYoiKNQ8IwpKO34t0fD921WmRh?=
 =?us-ascii?Q?4vsECSasTxyMJZSsOESj+Nt4tZ76YC5TAqXsh0T+sw24q2ImYaEDaQV4iWJf?=
 =?us-ascii?Q?5J3uW7tr+Kwqg2acdgml+sKr5+5u8QabuEKEycq+HE5fy02OGQeDnNu0L88s?=
 =?us-ascii?Q?299USee7M4b6T1i9amO1dlZMlNs2pWuu6YbgzMDZTb81H1m+N330fvgifsg3?=
 =?us-ascii?Q?9yBHzPrTRVJnZwxYjd99kaDMEPJZY1BRDFY6k3RjBhaRt4Xl3hWymzRpEBc7?=
 =?us-ascii?Q?uyXgSb7xtVlSCTmWIq7+XC/J4MD2Ofbk9Tc44l+/hIUsj6/SGlyr7cRYjufn?=
 =?us-ascii?Q?0FIDr/T8CcuQJ8nBIBqM5Su6Je6TWP6F9SgGvLJ67rGejwNXH14VnkNtMk9p?=
 =?us-ascii?Q?kNlBWzYzX9MjypP2rvOOqTtfT6WJxGYn/bCAeehMugPLGMvk/we3/CLPzS5S?=
 =?us-ascii?Q?loas0BIayPIJv2IfQztDnUyDfkNdu4BaWE16krBDK5Baqsx9DD6x/XpjmEuW?=
 =?us-ascii?Q?F0b/TXiqkcozbpYrEv55UmrvxM5412JGcwtrcLhPnr3ewzycLBLDNh+lZDIz?=
 =?us-ascii?Q?E2XbiU4zp29bmUtRQ7dTacf5a2/RgG3swynNfk4s?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a156a55a-5faa-439a-43bb-08dac8399f00
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 01:18:23.3725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6anwS2Esvb7t9fG+8v046ODpzpqkqd/OXu3l0UKa7mCPzSbhVkxrjL62couM4eetfY2WkO/aVQ8pyYo3h/KMsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7478
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

On Wed, Nov 16, 2022 at 03:31:06PM +0000, Jonathan Cameron wrote:
> On Thu, 10 Nov 2022 10:57:52 -0800
> ira.weiny@intel.com wrote:
> 
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > CXL rev 3.0 section 8.2.9.2.1.1 defines the General Media Event Record.
> > 
> > Determine if the event read is a general media record and if so trace
> > the record as a General Media Event Record.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> A few v2.0 references left in here that should be updated given it's new code.
> 
> With those tidied up

Fixed.

> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

And thanks!
Ira

> 
> 
> > diff --git a/include/trace/events/cxl.h b/include/trace/events/cxl.h
> > index 60dec9a84918..a0c20e110708 100644
> > --- a/include/trace/events/cxl.h
> > +++ b/include/trace/events/cxl.h
> > @@ -119,6 +119,130 @@ TRACE_EVENT(cxl_generic_event,
> >  		__print_hex(__entry->data, CXL_EVENT_RECORD_DATA_LENGTH))
> >  );
> >  
> > +/*
> > + * Physical Address field masks
> > + *
> > + * General Media Event Record
> > + * CXL v2.0 Section 8.2.9.1.1.1; Table 154
> 
> Update to CXL rev 3.0 as I think we are preferring latest
> spec references on any new code.
> 
> > + *
> > + * DRAM Event Record
> > + * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
> > + */
> 
> > +
> > +/*
> > + * General Media Event Record - GMER
> > + * CXL v2.0 Section 8.2.9.1.1.1; Table 154
> Update ref to r3.0
> Never v or the spec folk will get irritable :)
> 
> > + */
> 
> 
> 
