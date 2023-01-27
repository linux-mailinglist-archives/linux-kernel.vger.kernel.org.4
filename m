Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A4067F15A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 23:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjA0Wqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 17:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbjA0Wqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 17:46:34 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F95561AB;
        Fri, 27 Jan 2023 14:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674859591; x=1706395591;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Rj17w94erPYRkjOJeCU4Bi1uW5UWzuQws0CewG8cwE0=;
  b=KAE3R8uqEjIfxEzvne10DvswqjiNEQNShXLuiQIlbMjY+9yF6mQunY5X
   nrPFbzptT5svBzeqOHmDwbYNaurQ2h6z7Sp2sKNilm8D/NdkX2MEClZIH
   1T17hDu4ElEJ6RO04+MvzepZR6WjSoaBXu+3xang64/vQ3ci5shaQSXJ7
   9QceoLYJII6PnrT2axlNRyeqKb2+0SezZdlMn9i0PfTVMdIGuLD4dmTua
   mRzSTwZg3WG5GGVROnqE6XhYQ7H+vbDx4I+39uJZLiNdI3qj0C9pwMAQD
   hWg+T3xWQ8CAEDSdMlXyG4s6UDi+c9abGdPDRRWdcs/V4oyTq+VXUkXxJ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="325885163"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="325885163"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 14:46:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="663432619"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="663432619"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 27 Jan 2023 14:46:30 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 27 Jan 2023 14:46:30 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 27 Jan 2023 14:46:29 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 27 Jan 2023 14:46:29 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 27 Jan 2023 14:46:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7g583TfZBLvkt0KFaf0/SIssjf39m4yEhREvw6J82Ye6s7g0PjLWIwR3sYSfmUCNhfci02p/R9j5Pih/B9UktD3IQ9RjaeCSYp0FMs6Rq7tAik6SZhqxemRk6FuhGo4rJb/6bY7eMs/puP8n2BCL9uiQ5XzVD4jsJ17agOnUzDPSV9arN3D10b38rMd6IejKEp8vVjwCucw3+RpXFZ/Nqpj2CEX4u22FegXJt+WcDFnr6DI0p15Zpn4qlotUepBD1du0MZe56UV27fTd9yDbmkTN5TrHrMYd4THbGyppZ/KZu5QfhA/H1wPXKvW9Tnan8p2ymRYBLT84iQ9zQMVSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7yyHn78BhgbSsz+RWTLDooOpt45XZvlOr1PoR+uWkSg=;
 b=hiNSTfr1U43OeBAkc2tnZSAUGhyUcBBxCnhdJdBuCLH87cNS0mC7SkeqheYkernCGj5rYU8Kb+zWAayWI3Icsr+yG/AMvoIi5JAYJV4lAWYQEV33hA1oZDG0g5YVlcHbiOwG9AShzVCFnZWwhJ5I41l9fXXA1BNLPqV6OJOIiiO28GteZemrkz9BGlL5qPdE7rt/1a8ss9bu2+NTSgBAjnFcjfp02Hf38fnB2aO8f9GxFjNioPWtQlfSS+dQb6sPPcfwUXyX6MEbAyTHhEFfO0HWRI5y7b2//K6/X4G3V4Ivz6FvKG3oyfUACmISascRDQxt8mYxShHgYKtvs4FZjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7880.namprd11.prod.outlook.com (2603:10b6:8:f3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Fri, 27 Jan
 2023 22:46:27 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6043.022; Fri, 27 Jan 2023
 22:46:27 +0000
Date:   Fri, 27 Jan 2023 14:46:24 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v5 3/5] cxl/memdev: Add trigger_poison_list sysfs
 attribute
Message-ID: <63d4543ff214e_ea22229453@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1674070170.git.alison.schofield@intel.com>
 <fc1a2f51834888c2ea585efb0b4fa41cd251e52d.1674070170.git.alison.schofield@intel.com>
 <63d429435984f_3a36e5294b2@dwillia2-xfh.jf.intel.com.notmuch>
 <Y9RHr0kQqfLiT3Cq@aschofie-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y9RHr0kQqfLiT3Cq@aschofie-mobl2>
X-ClientProxiedBy: BYAPR06CA0010.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7880:EE_
X-MS-Office365-Filtering-Correlation-Id: f682351d-84e4-4beb-d625-08db00b852de
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B9BXSxYM0ddnNC84MyXNTwvZJ/IGHfBwNbp1mHNZ9rnG2hlxuGuDYMm7M1pw3de31TOP8PBU2VDtp5OChdWvDf/3/hFbRMZ+dvr+k29Amb0TzYunfgxqAWxvMtUkGEJpb3a1idv8WFjdKSK3LJdHhFGpD0+2q8VaoFMT11Rq+GjGkxVUafMgw/NHQ87Bai9QpPE1Hx0EKcZo6Q2kKEPXeGOeGOMIC9aqz7CEe2yGB6wMWxEmVgt398riZAY1ZddEwsoBiGAKTOl1wYK+JRKW/JDMbwrzJW/OZs30naOgEJZhtUgiyj8StOlRQ3Q9WBnrRhyIP6OnSbQlkyiNvyVC/X6Ls186cPSRFvrO5m+Lsouexud7YoSm/0WNHHGoB4/UfUH3bxPbpCjxCmPGu8Rbo6vEgITPcjk9ucqJUBeJQM2syFkFLVPOZkhmd3OZU486ws/D4af5NWva0Lnsg3dC/rt0TNCnlTqRSoGw6gfAsNOiSsE8s4KZ1PcMNPSzI63puzXbbLnO03wktwwpKbkMZUDaUqHQiatSaWx1JFMJdZ0NrQjmLnqaqeV/Y7XTh4Wb6Tkuk/5MNEWkR2REA9dMLCDDHAw2fKFFzOSRq3RgEEKJKVvIWf+YBPqA73TnerTB0qMoGLqEVg8cpBhR/DZJ6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(376002)(39860400002)(366004)(346002)(451199018)(6506007)(9686003)(6512007)(6666004)(83380400001)(26005)(186003)(316002)(6486002)(478600001)(8676002)(82960400001)(66946007)(4326008)(54906003)(86362001)(110136005)(38100700002)(66556008)(2906002)(5660300002)(66476007)(8936002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9khhcnZJ9wtR9LZ9LXuXW423dcLqkcIRg9fAqcwzsVoYnBGypU27lOHWwxDD?=
 =?us-ascii?Q?RD23KYGODTjrh3uLY67wLmgs9JlNAr9XfIo1MdezTctRLjHGnPNBRCMWZQGH?=
 =?us-ascii?Q?Ua21WOVhjFd4ylEH4sYT8IE2TsZBFm0s4210JbDZoeYvCwxi8RCK8JJZyAUu?=
 =?us-ascii?Q?R7UuedDL9Wem85NInoUt3bziZYh5TWrCYn3ubmsfiKvDmgDX36cbZmVPIiZt?=
 =?us-ascii?Q?FIVo2iJMPzqNJ2tA2wDVI5O0ObaGH2pUJhR7lBkcy98WP9kdNf0q9nypWSCV?=
 =?us-ascii?Q?hOshU+F+rGsGmO86iIFSWU7UNrkFTrJFbhY6ayGunLl6sbsRBnrEa8CsHdqX?=
 =?us-ascii?Q?6RqwOVsJUQ2nvp6NJIXzH/X2C8q5W1+vq0Asg7sap5wND8SPy4+gWXSo+sKi?=
 =?us-ascii?Q?gXki+BXwiXRonxporuqINic3fdv2ecIaUHFRLtQxEHhrvTGYXnlJHiH+2LdK?=
 =?us-ascii?Q?7hbMKQPsvPN9+eolvP/OCNaVffHM+BxTAIMyNOOpTmAHzIlpgP7HJJu78VS+?=
 =?us-ascii?Q?V5ZnrmtVRwtVn1OnyMGjYrJzYO+3AVx7CS5VsuJFCG5EdPsfHOnywUT4TV2+?=
 =?us-ascii?Q?L0CCfintgLReZWPNcdjm9TNMmyKO5h4yux/ADQqDvUFRszrkOSviDPdshC4s?=
 =?us-ascii?Q?aQnbp/cAPu30GCy7xIhTWUUpi4XiRhDVM9hZHNlmGEaCcqUxVf4DHxjEO9Zl?=
 =?us-ascii?Q?n2RwIdZHj/fPf6mM3AC02cSC9CRWzxDkIrC6p50A2CMbbLE0Q+Yz7LF6pMUs?=
 =?us-ascii?Q?qR4q0j3oi3QUOBmreZL4ZZ/WjRuwi4ISImPrCBl/bqAWIliSnttbsdpno0Sc?=
 =?us-ascii?Q?maXTgc+vK/1R05K5nLBJCYgD/LuREBQPVgKjV4T0y/lHyV3FwRJa3td5Up7N?=
 =?us-ascii?Q?tx5kcnJv94rCiCHZtYr5KeLbnNivhE283eBUbpatT/EzxuyGRsuMNZBy2u69?=
 =?us-ascii?Q?rzqlPokOV3QR65Kql1+wL8cIg5bODSeo8zRlze0LFNaMgQEMzfFlwDz+6oRZ?=
 =?us-ascii?Q?TWneXA7KtAsB5yC+58SeJJqvXc8EuIZXYhDKqfcHRopItAEFeJHwkYXk18HC?=
 =?us-ascii?Q?eQz6sdqykoynrxkXysoW51Vx1BdNPJVkK5pAXsAsfU29DnZErrFUSOvwNKB1?=
 =?us-ascii?Q?gI7vPj46iqCBrgpu8/Ug43yqyLvLWDK7BgvBGS81XLzYJJ1quQuqGvXGwbX5?=
 =?us-ascii?Q?8gAsuGuMWzLXAdFxKIJ9KO8Zto0IxgdcgsZQkMpPwkVIYjOiEjYDmZJmYqbT?=
 =?us-ascii?Q?k5vvihYmizSDphQHTaGxudND3lJCm7jnYiarkfta7zpzoP8VE7GI7duVOBXD?=
 =?us-ascii?Q?1qqpmCNJQzWAxBqgIJvFyRQ6NChUj5aCGpQsuQRWILPbHZgkFBK04REL7qyc?=
 =?us-ascii?Q?pNtfSki4mTdBMZkHYymgm15yBvtHJ0h7dyhOHZORhFbtIzfGEvoAJIVb1663?=
 =?us-ascii?Q?V0KjccjCbuy1/QCbgwhhBPETu9TV0XCcqx35CFpV9hkUwQ8+h6VitagCeGeu?=
 =?us-ascii?Q?ZY/nn6yJNb66RQAaBayI0qzNLez4YH6w395mDtzE9FkVKz5XkwFonpAOhHpM?=
 =?us-ascii?Q?c/AxM/5XqTIJRGWm3Nm2xOfbgnQ8mOMlhZtxfKvYmoQSJxrG14kwGs9Gthiw?=
 =?us-ascii?Q?cQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f682351d-84e4-4beb-d625-08db00b852de
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 22:46:27.0344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tIKpZ1kM3fzTLeH2sjc0q46Z5uuwc0kvCSFvgqgmeGHEvTin/FbFp6sb2kfTUROwB2QegtBQl6PrSvfpH7edWyAb3eauD0H0AHxrlRtEaII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7880
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alison Schofield wrote:
> On Fri, Jan 27, 2023 at 11:42:59AM -0800, Dan Williams wrote:
> > alison.schofield@ wrote:
> > > From: Alison Schofield <alison.schofield@intel.com>
> > > 
> > > When a boolean 'true' is written to this attribute the memdev driver
> > > retrieves the poison list from the device. The list consists of
> > > addresses that are poisoned, or would result in poison if accessed,
> > > and the source of the poison. This attribute is only visible for
> > > devices supporting the capability. The retrieved errors are logged
> > > as kernel trace events with the label 'cxl_poison'.
> > > 
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > > ---
> > >  Documentation/ABI/testing/sysfs-bus-cxl | 14 ++++++++
> > >  drivers/cxl/core/memdev.c               | 45 +++++++++++++++++++++++++
> > >  drivers/cxl/cxlmem.h                    |  2 +-
> > >  3 files changed, 60 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> > > index 8494ef27e8d2..df40ed09ea67 100644
> > > --- a/Documentation/ABI/testing/sysfs-bus-cxl
> > > +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> > > @@ -388,3 +388,17 @@ Description:
> > >  		1), and checks that the hardware accepts the commit request.
> > >  		Reading this value indicates whether the region is committed or
> > >  		not.
> > > +
> > > +
> > > +What:		/sys/bus/cxl/devices/memX/trigger_poison_list
> > > +Date:		November, 2022
> > > +KernelVersion:	v6.2
> > > +Contact:	linux-cxl@vger.kernel.org
> > > +Description:
> > > +		(WO) When a boolean 'true' is written to this attribute the
> > > +		memdev driver retrieves the poison list from the device. The
> > > +		list consists of addresses that are poisoned, or would result
> > > +		in poison if accessed, and the source of the poison. This
> > > +		attribute is only visible for devices supporting the
> > > +		capability. The retrieved errors are logged as kernel
> > > +		trace events with the label 'cxl_poison'.
> > > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> > > index a74a93310d26..e0af7e9c9989 100644
> > > --- a/drivers/cxl/core/memdev.c
> > > +++ b/drivers/cxl/core/memdev.c
> > > @@ -106,12 +106,49 @@ static ssize_t numa_node_show(struct device *dev, struct device_attribute *attr,
> > >  }
> > >  static DEVICE_ATTR_RO(numa_node);
> > >  
> > > +static ssize_t trigger_poison_list_store(struct device *dev,
> > > +					 struct device_attribute *attr,
> > > +					 const char *buf, size_t len)
> > > +{
> > > +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> > > +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> > > +	u64 offset, length;
> > > +	bool tmp;
> > > +	int rc;
> > > +
> > > +	if (kstrtobool(buf, &tmp))
> > > +		return -EINVAL;
> > 
> > Wait, where's the check for "if (tmp)"? Otherwise I can do "echo N >
> > trigger_poison_list" and it will still run. Should probably
> > s/tmp/trigger/.
> 
> Got it.
> (I guess I was too loose w the trigger, thinking you write anything to
> it, I'm triggering.)
> > 
> > > +
> > > +	/* CXL 3.0 Spec 8.2.9.8.4.1 Separate pmem and ram poison requests */
> > > +	if (resource_size(&cxlds->pmem_res)) {
> > > +		offset = cxlds->pmem_res.start;
> > > +		length = resource_size(&cxlds->pmem_res);
> > > +		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
> > 
> > Ah now I see why the region information is not provided in the memdev
> > triggers. I think while the scan needs to be done on partition boundary
> > basis, like you have here, I think the region lookup needs to happen on
> > a per-record basis.
> > 
> > However, that's a significant architectural change, so I am going to
> > think out loud about the implications.
> 
> I'm thinking that adding region info to the trace event isn't starting
> here. That will be looked up when we log the event. Basically assuming
> assuming find regions memdev participates in, and look for which one
> maps this DPA.

Yup, we're on the same page. Just compare the dpa of the error record to
the dpa ranges of the enabled decoders on the memdev then it is a
straightforward cxld->region de-reference from there.

> 
> > 
> > A site operator wants to know "is FRU (field-replaceable-unit) X bad,
> > and if so what's the damage?". In that report I expect they want to know
> > if poison impacts media that is allocated to a region (an imminent
> > danger) or is in free space (a problem for a later date). If the memdev
> > trigger does all the region lookup per record it provides that
> > information. Further if the memdev trigger reliably provides region
> > information it allows the region trigger ABI to be deleted. The region
> > trigger can be replaced in userspace with logic that does:
> > 
> >    set tracepoint filter to look for region_id == $region
> >    for endpoint decoder in $region
> >        trigger associated memdev
> > 
> > ...so I do think the arch change is worth it, but I am willing to hear
> > counter arguments.
> 
> My only counter argument was that we could let them have it both ways,
> but, simplifying and reducing code in kernel is good!

Yeah, in this case I think the memdev interface is -><- that close to
being a general purpose poison lister with all the relevant info in the
record. The only thing missing after the info is populated is the filter
logic, but event filtering is a first class feature of the trace events
subsystem.
