Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606D268ABE9
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 19:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbjBDShx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 13:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233327AbjBDShv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 13:37:51 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EEA7F74A
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 10:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675535870; x=1707071870;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hH6yuZT85wCHh5tiW6DyiuPtm3EREOL4GEpcgM/BMIU=;
  b=RxMh4IsiSG86kBK82Sakzw+iHs7Cn8NKhc2lj5XCTrJHf5PXsk1ksCKa
   vtLckT2omXjnrcF/0nPH4qIAQcrblAcg3mOCxRj3IFr3O7zIXO1tJsYcn
   e0oOQo7SoCz/9clQKhZ3PbJMYaqCGsPBomeTgpbS/I2CB6PGN47GEQZyj
   HL9DiwJ6KraIRdlhL5d+SF8LnIi38an4bdzp/mcJwgjXL/T+e2vl36O/C
   izM+xWLtkrGier83mQe9H69/+9TjKpPxDXxBqdFzP3YX2q0rcP25kUEcl
   1qVq7/15NPYkgNSKXRkTHrAYuSuYIIq9BpYMBaGK019T/gHRuebukjehC
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10611"; a="356321125"
X-IronPort-AV: E=Sophos;i="5.97,272,1669104000"; 
   d="scan'208";a="356321125"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2023 10:37:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10611"; a="616046649"
X-IronPort-AV: E=Sophos;i="5.97,272,1669104000"; 
   d="scan'208";a="616046649"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 04 Feb 2023 10:37:49 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sat, 4 Feb 2023 10:37:49 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sat, 4 Feb 2023 10:37:48 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sat, 4 Feb 2023 10:37:48 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sat, 4 Feb 2023 10:37:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IEjPTQAj7cLVg9TUtw1fLzVwy/WOn3LYrNsjGc5ld7NjbB/RJciUHcK1L9v185G9gSPbL7iUyUFwP1ViGvvSXCccUqVj/U1ZSDkayQ0yImN/TbqzzBYRUPDTJiih9sG0oK2TpN6m1LgJVbZhRg6VlK08qKVO6Z3DGY1/YdXRPVeMrtR1YyRXnvHPwbh1hV7we+JcGsJ8mRNR3e8i8Eq7nWBoEinQzipzeXqjQVVGgianrEV+a27+pLHh1g5vO1fDxccILWOukBZjDZBqIqaLP+LYcPPxWaZtsM2q2VEhj7EK7rK+rbRKCxLPiGQN0bud399foMo1cCTvM7q558eJWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ThXmh+ljJNhaZHoVTjCUm2H9c50zUD/1MaC/YO7feos=;
 b=dVTeRpGe8kueJZv5tO3x6rbiGjKGwn7Fu0xlFlJqE1H2ockzrwQ8hA1pFtAYVtIsmqyEhCI53Oi6DjR/NjvtnVBBDrKgNItRHkq7i320GoEMwMHoJ1WVgclhFLMHxLVzcLxfstE8Fr2ON+BSJ5yawvvo+PrIuMMTosChk81PjXfRJ4mscg3kVSOy/1pBPwIN7Gm6PsAKSydEmQK5nv0N1IJ4s8ummA7MGDtNrYcF/61z2vGufUnsWZLjYZnkbLGlT5QCVyTm8WyoH8gOl7kXtX/oxPze5PLEOVdTyaoU9IblwVMFYZVLD3KkbQb56YFebvacAJtU/rNYTwv95kc+yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BL1PR11MB5237.namprd11.prod.outlook.com (2603:10b6:208:310::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.32; Sat, 4 Feb
 2023 18:37:47 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6%9]) with mapi id 15.20.6064.027; Sat, 4 Feb 2023
 18:37:46 +0000
Date:   Sat, 4 Feb 2023 10:37:42 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Christoph Hellwig <hch@lst.de>, Ira Weiny <ira.weiny@intel.com>
CC:     Sumit Garg <sumit.garg@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Christoph Hellwig" <hch@lst.de>, <linux-kernel@vger.kernel.org>,
        <op-tee@lists.trustedfirmware.org>, <linux-mm@kvack.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 1/4] highmem: Enhance is_kmap_addr() to check
 kmap_local_page() mappings
Message-ID: <63dea5f637532_f9c512941c@iweiny-mobl.notmuch>
References: <20230203-get_kernel_pages-v2-0-f1dc4af273f1@intel.com>
 <20230203-get_kernel_pages-v2-1-f1dc4af273f1@intel.com>
 <20230204065001.GA18482@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230204065001.GA18482@lst.de>
X-ClientProxiedBy: SJ0PR03CA0058.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::33) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|BL1PR11MB5237:EE_
X-MS-Office365-Filtering-Correlation-Id: 88d90800-421f-4166-7603-08db06dee8ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m0Tnun56eEnBtY6vnUZkcOjd7Qj94E0S3RQn9yAa4KOOxMtAmI9yIO6wSpLic+qfsRZ9etlVdr/YSDcaewthzr4sUyfdn8aeWZeqz2cznX/SEkmaUJWhVOdOGzu3rjQ9txAQp9MDDG8qfG25Fh6MDnSNAvpMDlJkTS9m4m7ctEXQ41hFMGhQWLgXsH5iMTmY/siddbBTYAEstrRe7hMJyXLQoq9ydtJkKpVjae7ys9CnjqTr2AbfTS598Gv9ZEAy/jv6MIJbsMtpfOhJfMSoOYN5O8vPRPUUWq/7xNw2jP4LSmS4ecHJzpHjWN9gclnOb6/x/0woN7oxcFT51R1Ees3mb18ZiqUazXDItVY2JnlSSlk+XOxoV10to01uouEIceVpDUsJ6szRMkZZS8aDEaud8/cb40i0+RNqPW4lfu+BNPiqBtHN9WjbduNNNQMzFLky1zu4wIy/6sPhJGR5oj2hwJB5PFI3WkpKjkoJn786lP82LQh3Dnvvx1R63U73PaLIqa/kBsMizfDLgotFqTG0m6iUKT/x+8xBRGwMw4yRsPu/3W0LrGrBTumX/kOeYF97EjUQ0lAt1Dm1l+OIGMT03Can+cFRUqKOYaqS0BY6b7Tcm15ZoPsaEhzmjiv+U4l/dAwTCW0YdC8eAU/btw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199018)(478600001)(6486002)(66556008)(2906002)(66946007)(6666004)(66476007)(4326008)(6506007)(6512007)(26005)(186003)(9686003)(8676002)(44832011)(4744005)(41300700001)(8936002)(7416002)(5660300002)(38100700002)(86362001)(82960400001)(316002)(54906003)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3SfAAxXYwqcZw6zRNpR5N27hzwVYVkWDEGYjeo70+oWjSlKrOxGWO3FbgawE?=
 =?us-ascii?Q?wYmr3rZg3RTaq1DC+oyn86FdO+PapH0uMgj3W6aTDD8HU8+uBTneHBs931dh?=
 =?us-ascii?Q?l2ueTaPBWYxfV+euqItR/uBGmwgEWN4cprOsS37nNvQbxJpdOlfOILiVt8Pd?=
 =?us-ascii?Q?PGOfb0dHWsTeiidVaNCZ1mlEKsgHW/2UZlPWbxn+A+mWQA6g9uOq/qG7bI8f?=
 =?us-ascii?Q?roVFfBr3g068K/oZD4kzbrPvKrOKk3zbe1r4rATPx1LGsIJbawueIwW90z5I?=
 =?us-ascii?Q?93H2j0MjtLNnccgNsjtcmE3O+CcYpIkOwMBh99wENbGc482O57gDhgacevte?=
 =?us-ascii?Q?/LjUm85ifZwT1ScVyhvgF1MnbIdIzBdiErmk/cbK9QkZjeFpJ2R7Pj7DwCYo?=
 =?us-ascii?Q?pHA7dyFoLA8zHkq3JlxSAEHEYRaSN/7HwQ2lwt7ElbiLyogJsWbsOrkmxh/+?=
 =?us-ascii?Q?e0MFNjLfTNUsEOjSZLm29u7MxmINd/h5yNI0JC+PGoyA/D8tGS2zQXv+4YiS?=
 =?us-ascii?Q?B1o9WadItiQuJuDaMDupH6smHtfbc3RYw39xFDoXN42xTYUs+s+ggCbDGHWX?=
 =?us-ascii?Q?Agj2QJnjKkO8xjj7Di38mXnFlet4joDxycFSKY5CGeIQy6kFh5IiTu0a+yyR?=
 =?us-ascii?Q?kmy3B78QoImGReaiALo69/rZzQH6Zeeg0SAqtb2ceA2EsIEUu1w0UvQqZlFf?=
 =?us-ascii?Q?B6JldexGWxFysJrezWQov6vFDWZeMLBcn2z4zZ0YqH0BtBw2h/1CmHJkUFLY?=
 =?us-ascii?Q?8SpN72KbLh/BtGYHZ1+68lALHV8pm4KmQBHsPflO5rgZGFKZql8kgD8+BegB?=
 =?us-ascii?Q?URrXtmB4LHQYPYrEanjmrPUrW7n9bLTUSjMX1xrrBeu1r82KlzAnj5XAsgN9?=
 =?us-ascii?Q?yfJ953ceE/oFXi7YJ3OaEISVoRnhjQuccpe94EAqu1c0QibzfeDYj3Bim+Ye?=
 =?us-ascii?Q?QBbtn+1H5/ZmscClu0XKsIH5J/ZEHwfGReQ46iw9Mxl+cymrXgsLj/YV9KwM?=
 =?us-ascii?Q?vjEovcM72+tZ1fsZYPyDnM8WgmLnQHzo9WJAgrF0E54iBipOlKDwXzrEiYJj?=
 =?us-ascii?Q?XEi5QlXdfI/UcGb/ozeL2nknwHn5cwTSk4mEBhxspajWqcm76L5VWuA+gmlE?=
 =?us-ascii?Q?IO7SYB4o5QHI18hc0SFEUewvPpp/Qm+beBOIV5kIDupMbnk6B5VYfs6u3efv?=
 =?us-ascii?Q?loQMjA3C2TLLCdcPxeTHWamSnp5jNbVdK0y0SYQOsjCMTtaKsMl/lpV3m8wj?=
 =?us-ascii?Q?9zjMvJ1LbAxCk1NvHi1FKbhVgKmxK7sITL35M0dUIcFf5nEoTFDyssaqQ+3j?=
 =?us-ascii?Q?GgbRBdEONKP9Ehk1VgV/ONFZ/p7ibMpv47lx8kF5uPU7b+kOSvqPXNNvLmNZ?=
 =?us-ascii?Q?7OoZqhy83n0SDjHW2ej2JqtVZB0LnMr6+6CE3rPXa+dcSaXNUSPPp3/0ZGdx?=
 =?us-ascii?Q?BdAhQ2RIUbO5b79dodmxUAxdk7w5/bWfiHtLXV1gl7SF60Tn1W01RD12ZfEO?=
 =?us-ascii?Q?39rhJeO0Jp8u+BsNgaRcEo919pywyF6al+M45PnwMWhnqMVzNe8vzWxa8Qmg?=
 =?us-ascii?Q?oWbPo+tb8kxL2G2npGeTiAfz/t0bsX6I+YwSF+hj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d90800-421f-4166-7603-08db06dee8ba
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2023 18:37:46.2753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GyWx2OzUkY4NEQCOaqy4BFmy2b6i3WHJ7baeNrQcNZBzAJG6QpEysvDUirXpzHujAoi26NXG8K08cLDY6wc2LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5237
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

Christoph Hellwig wrote:
> On Fri, Feb 03, 2023 at 08:06:32PM -0800, Ira Weiny wrote:
> > -	return addr >= PKMAP_ADDR(0) && addr < PKMAP_ADDR(LAST_PKMAP);
> > +
> > +	return (addr >= PKMAP_ADDR(0) && addr < PKMAP_ADDR(LAST_PKMAP)) ||
> > +		(addr >= __fix_to_virt(FIX_KMAP_END) &&
> > +		 addr < __fix_to_virt(FIX_KMAP_BEGIN));
> 
> Isn't the second check inverted?
> 

The enum map runs from top down.  So I believe this is correct.  I tested
it with a different series and it worked.

Ira
