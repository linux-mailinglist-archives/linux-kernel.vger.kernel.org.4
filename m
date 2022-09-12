Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183ED5B63CA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 00:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiILWie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 18:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiILWic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 18:38:32 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208632C12F;
        Mon, 12 Sep 2022 15:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663022311; x=1694558311;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=deHfhTwu1s0KXmuJCcnNr/b4Q0ZkVsId6LPVI/GlfiA=;
  b=Srllh+B8ilA8KiAxzyXEzA4+SpLuqcxqGqNkm7zEJs+w0+7cTTlrID8d
   zNfR0WqZHu1wX3Nxs7NQ2XBkScJc/WwvRQiqPNUOmbb6QN75v+unaClyS
   0Gw7w87f1u57dFpx2+EImKkgMBAdDjrwsZkhWBRZvUMgTAzEiDs/TJx2F
   DCDKvg4YpZwS1YnzqeSHSG5U6Znne/ZLcUp3CwyI/s692R1gdcKSkK6MQ
   abJkWp2ETZS1PWnh7iJfSm1sxTwY7URqiJsW8/U8v9CDarOYHMZYD1HTU
   g4zYvI2cxL/DjRqE5+R2hz/g3wgC8GrR1sSjhTYhY8Y6n6MyiVu0VRJiM
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="285006501"
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="285006501"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 15:38:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="616231728"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 12 Sep 2022 15:38:30 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 12 Sep 2022 15:38:29 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 12 Sep 2022 15:38:29 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 12 Sep 2022 15:38:29 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 12 Sep 2022 15:38:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iFaDrfZkT6ujxAW61LxYKVvC+pM8A/CXNc6a46KUSPjS7sxeHzyOQPuK0AXLiMi4m64LRUXiFL87Pef1hXwwJlY6b1/NupLEaL8RiDofOG9Hh4RNp/HYxbVE2FgXc8KUJwCCwiL26J8mRdrbM/2ZUa7sAM6n9Bg+1lJc/Tezhz71jVSQthIUMkaMfDOIsC5QnEVC6ZOp6fvsdzoQ0lQa5msXM7Cxx1eARJOPdx0a9jqfbGkHJQ89PuZ/jD7el01GXoqW5aNP2EBK/BNyB0Q9FGuEzlgyt37fx7XbeY7kdszM0F8pRUDlJwIDhcQpjBDnZCJmEyxZUhkBmbf8dc9QLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A7N7c04ZPYBszadk7WM/4ZgXENzjYDsndJlorhJHxvk=;
 b=kGG1TiPFD3HK3AQfjZosPwV6xHguDpXQzcJ9E0niqBWpBy4ZYNwX0gEdxRbV4s1+fxt9vCLTCe03ETGa5P4tgmC4VHu2H1f3DOlEjtL9GcdvAOLCR2YcH29WKXr7NFAxezX8xQyUuY/xvbuz4PonbVCdV0ORoWDS1a3/bPWjbG9Syls3qJMjpgSwKfwN+svra5dygTTie7oKmWxd6+IP0oy+2fCXVhGts/+uo7TcqtW7WF2ERqRlsVAzbfULAMHUWabMacLD+AXvFA7lbvmajuyTbfK4JbA7LlsVkD+1S6lZOz2dy96zbM6Jnjnz02IK81HocXh00jgPt5oWCsYWuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CY5PR11MB6140.namprd11.prod.outlook.com (2603:10b6:930:28::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Mon, 12 Sep
 2022 22:38:26 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::1967:b7cd:c851:cb91]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::1967:b7cd:c851:cb91%3]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 22:38:26 +0000
Date:   Mon, 12 Sep 2022 15:38:21 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 4/9] cxl/mem: Trace General Media Event Record
Message-ID: <Yx+03ZoI+zvylO40@iweiny-mobl>
References: <20220813053243.757363-1-ira.weiny@intel.com>
 <20220813053243.757363-5-ira.weiny@intel.com>
 <20220824171113.00006f80@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220824171113.00006f80@huawei.com>
X-ClientProxiedBy: SJ0PR03CA0101.namprd03.prod.outlook.com
 (2603:10b6:a03:333::16) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CY5PR11MB6140:EE_
X-MS-Office365-Filtering-Correlation-Id: 97d7324d-8407-4778-9ba0-08da950f81ae
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LJd6u9IrhZIMwlvZ4DjuvApEmlyrfotTbzMZbZzPiY7SM8mrto/zFw4xR+ILlOL/Hd/iNRYYLPMPpUU6YiamMYVNWfZJv521o8C+isd4eoSrba49MGaasgWH04rLqPg3ivNkuh0HjMlUDSNwaeDodhQXBUhW6Gn17AEtDAW7IOtB7hUxJ5vwy2JJQeUJRzk21bNjPzcp+ES3QfTypqeC2SJOS9SkLS9tinvFRBhExR4gyPtNJkqEV+OQxVWOqOhA8yRtQ2lrXVo2NmIevFQNzieoDIH6lQNU9LR9kbMvicg+w+62j+BCiF+EnR5V+8/IS+vVGHfmKkXewMBBaA82g3qAj6Lm0wShe5YNR4GHHY+KFtm5/5ELhgBKBvTPJYXXYfUQzBIpIY5nuvdO8hMf36f6QrdX+87L67cUh4dmXh5t2yf1JaJzlQ5jQ43YwLIjmw0lsU/Cwl8UgYeghGMh1/baos0USWDcVRRj+MD6uM6EmlG1ib/ke1ypUAtWuLWI6mpk4yY/tP2/mg2bDY48KCs44C7Wffh3G5ePrQe9zpHlUQv9UR6y3b8ECO877MYFHLOlGLo/uo1yTnv4bRS/MVvBzEUVMx5eorBAA7IPC94HzXTeDnIzS7tmtCY0NvX4lXqXlGFxLWMHCHsImq+r/H7G0krOpd6qN1LikqChEwAANNx5ByoISZfkBo00s2QCpclCfbEm9Rr/tWkFqYwcww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(136003)(376002)(366004)(346002)(396003)(451199015)(82960400001)(8936002)(44832011)(9686003)(38100700002)(6512007)(6916009)(26005)(6506007)(8676002)(66476007)(86362001)(4326008)(66556008)(66946007)(186003)(6486002)(5660300002)(6666004)(33716001)(54906003)(316002)(2906002)(478600001)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cEIUJVPMleizelSJz/1L1+YyQNkuZ+PLIEHmI+HAYkMsMTVhv1L/CCv9ohZn?=
 =?us-ascii?Q?VCrBQHR+81//KT9J2Sm7YNJsUx141krv9tg3dhwxdu6RGMy5jf871s+EYyOM?=
 =?us-ascii?Q?466eOqnw4MQCSRJzpoO3r9OpC679dWsaidFcsB4vmywa0tiE3Inr9wXHt7qr?=
 =?us-ascii?Q?FQLJsTO5hnA/9smQg7OX2mT1AtuxOpCGI6zp0luxGF3JijMB28uT2DkkhTqZ?=
 =?us-ascii?Q?OUIy+//EcD0CQnunSPmgntmWbEGgUDL6+vgnrgblb8pVqcnDAZ5z8smnhVqA?=
 =?us-ascii?Q?xRDg3pUCXgavI6HePHCMjxW2tTsThB8QqcOaP0TEe396LmmjYZ5FVZCxdXKI?=
 =?us-ascii?Q?kn8UVfFXayHUIuVxheGHOpmgwKN9hS2mEfv/zbu+J/zbAFYTnj7BAaFoixx5?=
 =?us-ascii?Q?QDnFL9SNS7PByPgmTCWZdGLag/tlV967KUmCbF8O+itctXySqr5+Jzyia0dI?=
 =?us-ascii?Q?ZewkRH0qEOLPDVFEuXyOrXAdX5+/NJC5jEnM8ygnHn7gJ9kmbjQeYUXGCpaD?=
 =?us-ascii?Q?5AdVPbRful+ULZ9Bu0NyplKphThJlKr0T9TpETvq2W75AjYZE93mGebinsN2?=
 =?us-ascii?Q?hE4Sd3KYWUMWnFmZDx6k7kHKzo3hx06KB2Ab8hkdb2gLrHcATtMNorJ9baAt?=
 =?us-ascii?Q?lRnlNYGB9K4QVIpdsDnYFK5pcv+/Ih9YXjwcS9U5hZ8Lbrt/p5TSz/toKlcc?=
 =?us-ascii?Q?WrZBV6B6iPXluBMUMvDPeCgkhxdvoNUZjmpGGFqqTr9Ksp+bi4T+emVOFXbw?=
 =?us-ascii?Q?KGCEv2HXsksvSX4pRpKSE790BwKHuSY8nvv6c/gAu1Fmt5+RPQIu5YCusUkb?=
 =?us-ascii?Q?zRoFsRpyapKNcuAVG3adHZK1LN6cUBbVef5+Gtc0g3CvpXvLkMuym3XgUxjb?=
 =?us-ascii?Q?kA4gFiwTSOwDE0awqeTC64U6+fIFKjlpFEJgv+8wrIA5zW7stqNn3JhQ3Ook?=
 =?us-ascii?Q?gnehiVJJCt6Qann2c84uLUurKdqaJnKCDZFKz1lyxWwqQfyTDU3RUUjijQCM?=
 =?us-ascii?Q?tPZ/8u4rRUhhJ9Z1f38eEXH+cBoKkmjfw6YfKkk86mDkQFptg+E2+R7+A1cN?=
 =?us-ascii?Q?3wTRXGN946hOKl6QTnduKM1uVbEYpZcYYxszOy6+xKJ/vzWf8Mawbxz7hOjB?=
 =?us-ascii?Q?MT9qS9mdyBR0YsuU6SId49A0vmRRdVH5xBAPH/IpAOvbcNDYIKeC6igmxD0C?=
 =?us-ascii?Q?ElM/d/VZOz9yOAiTjZUKmjAQ30JuqGXIYTRDYBDu3tbd2rJuJUupryuMycjs?=
 =?us-ascii?Q?Jza7qzgeYyxWOr4P1/SYRETq5hnw+HEK+BO0mncKhK9vYnGtJg46iL+kig9j?=
 =?us-ascii?Q?ZKfJVjnVSGVPXvrYU6+zYwO29mzRYfUcdYDdZpEcvjz+nXXhAXFpjHNEHYog?=
 =?us-ascii?Q?H3Rg203wl1OhLmAL/QrdbjoYGr9bHJixsy7tgzCaM+05V2amqIumfryn+nuW?=
 =?us-ascii?Q?EFGenWXIOOjS7CnCuICVdy49jI1LWr0/8502UvCJPtmHLAubH4ZQLWUYilN4?=
 =?us-ascii?Q?rht4+UfZAI1Q9elf8kGqO/zbFlC/8xsryuqaOavyryupyhwvb1foJsoy+V9Y?=
 =?us-ascii?Q?OLAsF59NXh8ceBR3YHvhZXBdDxqQpt64v8rauLuC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d7324d-8407-4778-9ba0-08da950f81ae
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 22:38:26.0830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EoUZ0RtHeySSfGEznzEbNURhehkOwbZzO+cP6kik/aCi/b9IiAXuit081pN50VAeMFc5F/REgMJV32w1WI0osQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6140
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 05:11:13PM +0100, Jonathan Cameron wrote:
> On Fri, 12 Aug 2022 22:32:38 -0700
> ira.weiny@intel.com wrote:
> 
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > CXL v3.0 section 8.2.9.2.1.1 defines the General Media Event Record.
> > 
> > Determine if the event read is a general media record and if so trace
> > the record.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> A few trivial things inline...
> 

[snip]

> > +/*
> > + * General Media Event Record - GMER
> > + * CXL v2.0 Section 8.2.9.1.1.1; Table 154
> > + */
> > +#define CXL_GMER_PHYS_ADDR_VOLATILE			BIT(0)
> > +#define CXL_GMER_PHYS_ADDR_MASK				0x3f
> 
> Inverse of mask is confusing. Just specify the full mask.

Fixed

[snip]

> > +	TP_printk("%s: %s time=%llu id=%pUl handle=%x related_handle=%x hdr_flags='%s': " \
> > +		  "phys_addr=%llx volatile=%s desc='%s' type='%s' trans_type='%s' channel=%u " \
> > +		  "rank=%u device=%x comp_id=%s valid_flags='%s'",
> > +		__get_str(dev_name), show_log_type(__entry->log),
> > +		__entry->timestamp, __entry->id, __entry->handle,
> > +		__entry->related_handle, show_hdr_flags(__entry->flags),
> > +		__entry->phys_addr & ~CXL_GMER_PHYS_ADDR_MASK,
> > +		(__entry->phys_addr & CXL_GMER_PHYS_ADDR_VOLATILE) ? "TRUE" : "FALSE",
> > +		show_event_desc_flags(__entry->descriptor),
> > +		show_mem_event_type(__entry->type),
> > +		show_trans_type(__entry->transaction_type),
> > +		__entry->channel, __entry->rank, __entry->device,
> > +		__print_hex(__entry->comp_id, CXL_EVT_GEN_MED_COMP_ID_SIZE),
> > +		show_valid_flags(__entry->validity_flags)
> 
> Can we make the printing of fields with valid flags conditional?
> Been a while since I wrote a Trace point, but I think I recall doing that..

I'm not seeing a way right off.  But I can't say it is impossible...

I'll keep an eye out as I clean the series up,
Ira

> 
> > +		)
> > +);
> > +
> >  #endif /* _CXL_TRACE_EVENTS_H */
> >  
> >  /* This part must be outside protection */
> 
