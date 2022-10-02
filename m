Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F414F5F2108
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 04:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiJBCa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 22:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJBCa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 22:30:26 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1499C46613
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 19:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664677825; x=1696213825;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HHzTqsG7Sd8zIgMrT638JI8wOzYGHnsDr+zF6HDg6nE=;
  b=c1SbpHdCYGwv8BROAeZ/6idJqAzYpoRKww/F+hfNsTdCgDgeKynuKqjs
   rpeH8slzJ+Ss4TblqixrX5UCI5aewjXFo60Zh8yFbtPcdmBWPgTcipqij
   2bfvipKllCmlq6YLqqMnvHTM636IxL95gnT/SlwonQZHqbjjbxarP5rJB
   9+CjDJcz4oQ3F/Y1+kcSRnIfWxnC3ApZrnRQ40EilOjNfkRXzAkZDPSGQ
   eSadcH93t+7puSauPBKCq+BXeMzq7dnJ7/aRfatoHTio6Wj8KaBosryVD
   y+iYl7kp6U9vccqLg7nElPbucolaBbj3aJ1+7ZAktsOVjXKsFcxJdw7qL
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10487"; a="301156262"
X-IronPort-AV: E=Sophos;i="5.93,361,1654585200"; 
   d="scan'208";a="301156262"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2022 19:30:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10487"; a="653978813"
X-IronPort-AV: E=Sophos;i="5.93,361,1654585200"; 
   d="scan'208";a="653978813"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 01 Oct 2022 19:30:23 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 1 Oct 2022 19:30:22 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 1 Oct 2022 19:30:21 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sat, 1 Oct 2022 19:30:21 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sat, 1 Oct 2022 19:30:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwpDMiivLwLwYBdseYyh8Y3NTvhcXsTMkaPDDCWGhggBgso/QyzfqMy0WUUFifdGgPmxt26aL4iCwqpCv14sAT9xRVTdX/GdhcpuVY0Q3erhEXYB3E7jAdWZWmaM6eVM3mwEmHtIB3Fb1YK5Ud6JK4EycCV9JH9eet11OpuhvVtUnnpkgjJt/DtwN+dNSZ5jzBXZRQ6T9tFlxE1/aPa7GEkgHrtO0HrMBKQq3P/G0M5AdL+IostP35t6LRpe3XUBkOYvFsR/hmIo5RULS3X9qNlv81SQvoW0Qu2QAvg3pU9ziIkzFWZBZeC3VNeR+WS97H5mS6hYZ0ZJu4D/zex3Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fl+bOi7ELzPKKrIMfTlY7JU3IPSBJ6xW9/nmeiMLlvA=;
 b=BGTXiiErfXzJz2MflcTXsUc56H/MaHS+3xoNGqoyv1MLymrGkHznUQ3cbBjMcxhKCg41Ek3hKg9ZDimfxAuFt/WWL7ueycOjMZpsXM/Is+0ZzlebrirUjekHuGoTYiDT+NSENQOylXx+jRWHX4aFWWvoUvEPA2rzFC+C93qjti4cH5C5MF7fKN49jKUGLAkczPKNSTD7pdUBnKlxa4h6ByIY3nCqU2gL2f29vCXnqWdGzc3GKZ/KUaRsi5VotxMoxivJUmbi/Jru0+BE0tLkVmMBm/96mkvv/W9jazD3r9QS6uPc3chEws15bu79TTXlWcP6o104e3qfqViu2hhrNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM4PR11MB5309.namprd11.prod.outlook.com (2603:10b6:5:390::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Sun, 2 Oct
 2022 02:30:20 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::b572:2e32:300b:d14a]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::b572:2e32:300b:d14a%3]) with mapi id 15.20.5654.026; Sun, 2 Oct 2022
 02:30:20 +0000
Date:   Sat, 1 Oct 2022 19:30:15 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
CC:     Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        <op-tee@lists.trustedfirmware.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: [PATCH 3/4] tee: Remove call to get_kernel_pages()
Message-ID: <Yzj3t6PDIFNPyI35@iweiny-mobl>
References: <20221002002326.946620-1-ira.weiny@intel.com>
 <20221002002326.946620-4-ira.weiny@intel.com>
 <YzjfcW6OGcPP075q@ZenIV>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YzjfcW6OGcPP075q@ZenIV>
X-ClientProxiedBy: BY5PR20CA0017.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::30) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM4PR11MB5309:EE_
X-MS-Office365-Filtering-Correlation-Id: e54e00b0-3572-48a0-b9a1-08daa41e0d05
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zuC555orQjuDpVh1MR7w1V2Bw+c5RNenLWrIC8I8josvqLK+vnfvtPN7D+Shx8PHNr6aV+H6IM2z3uRA65WA7RpQyQBMzMowmTB53vaQim5OxCcWCVOAxSFiibRgDbC2zpnRrhVTVQFG/vE/t5qbaGKp0zEJG96zL15cXJOLN7JqLS91c1fSExSck3lpbzFSpBgSVQpuyZowyzoZOMt249gD1/5ux1xujkITnMvvQEzPZqbyJxavw7GT5WtqRYHGZwykojOg+TOlDIO7/jde2P+UgUb8N5DonDr3YSdQnAehIrw97UdaFlHdxPc3chi0AOpnks4B/rp8n34fuac7TRFs24STe+pOn7JwGxRXZvd2GcKg8JNxDOOL3ZljvXs1kLwokiY7jzKs9FahnCZXhVXf9iKMj5zbq8el0ht/z9a/5BNAbkaSCeXGG/76Yj+1i5CtL3TXzZnps/Np3kD8MdCKhLkw8wiW7V0mKqRY/B0QfoPismeYFebZhWbzmEP3XyyvRrqCUqsVyRVNHW/igobis6NWshTC5+qu5PMFtu2DcFjVwnHlH4AgKjc9V/UGcruMQZYH6w9zhY5CGUIBJ64R4BdRF2W8mY0GBJRO4mVMt86h7saLwIWFKG4yNIUXfyBTeO5Ockiy+SZfrFFvpKvd7wXKD9dcA1/2bEThOoH5MTDz3m299lNhym38hFLPe+7Fm94c8FQjT6HYX6TTtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(39860400002)(346002)(136003)(366004)(396003)(451199015)(54906003)(6916009)(316002)(2906002)(8936002)(41300700001)(6506007)(7416002)(5660300002)(6512007)(86362001)(9686003)(44832011)(8676002)(6666004)(186003)(26005)(4326008)(66476007)(66556008)(66946007)(33716001)(38100700002)(82960400001)(6486002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8/TDak67IWo8qZ1Lx2ZYMSZnF7+lXJuJvI+R0eTlOFixkE5aBc+JIA1K85N5?=
 =?us-ascii?Q?UVGBnV3Jft9BzuPmy0i24+wJ4eEhfO0QMR63U3dCFnppFh0vuDu0XgCiYja0?=
 =?us-ascii?Q?pKW8LFuySSCTIQOghX3qoPEoZktoG5DE8fI7k40C/ixL69ijpoYPQi+A85FC?=
 =?us-ascii?Q?X8kGvxac+YmcaPC1z+Z+3sBmwe/yIi5QqeBdcHQ5Yjhd1ZD/vkWucgAaOcUZ?=
 =?us-ascii?Q?utsKaZgQZTrq/551PG1Jsb4fnjVD3U/XQY1w2dg+qM0m5au+kh033KZrFpJ/?=
 =?us-ascii?Q?4B/j03oVqvAx+uaK0c5vhjR1kQKQZ6yBTgVGIJxv7dlLmdCL7SGUDUZHYChi?=
 =?us-ascii?Q?zPjq6SJSHOli8J3ISw0GGDQjtaj6Z9MWUQWOk3kVQg28o6Tfl7yXlHeeZF9S?=
 =?us-ascii?Q?H0SFZ4I8O3KozdunXBl2Rramw2LdO1p3uq13bHTiNyrMtewyreHLJteiFjjp?=
 =?us-ascii?Q?Shf0CgGemml+VsM+kxOA8a3kpE006mZBigL8wK5kvBKrqexPFA8Kv5vMmnih?=
 =?us-ascii?Q?8vrqdyNmrV8tmt2hLbFu1W613MBVwj1LH1vYbqU5sVqu9Iu6oVhMOqv3pAwS?=
 =?us-ascii?Q?EvsC2bJjcmYGJeyYEILpVu1QVXblaDad4XYWKA+CrOLieDTqOtOLYDh1vsoQ?=
 =?us-ascii?Q?480u1lizykRwhI261tKteU7b/6MO4Hg2EQxG+ZxFSaYGoB2OpxtlUSeq2Anh?=
 =?us-ascii?Q?0a/ZK5fo8ToRnUFuEIAnHST5uDS3cqa0UXYd6vEgHcBtZhnFyT79PXiQNKbC?=
 =?us-ascii?Q?jDSI/xVMu3b5LyqyFIW0SbQ9EY4GGjK4HzabghXbO/vBTBQoDsBiovL9RMW0?=
 =?us-ascii?Q?8aiXfC5HyogRbhxP1Tw+qOQw9fPff2u3bmJxhW7YAY52MtNDhaFwutSPcXvK?=
 =?us-ascii?Q?vaVld5XwsAip2MPlLXuo0YushLeBXNoOlLvycj4koS4uyHEcDxMUPVPIkIoA?=
 =?us-ascii?Q?u6crbgWYXoMsQgz10Ke3xjTSrxU5QflWNZo/udDUux0R2xa+wGGQ40OWbYWx?=
 =?us-ascii?Q?clthvaFyr48wyJjYyMyThjBGllRUEFnM/ZAJpjcMq0KyPR68jfMkTuhJf1SA?=
 =?us-ascii?Q?ID8asI07e0c7aISWjfzSuj8yxrMkeq74zskm2th596e0he+taOUe3wpA6cLk?=
 =?us-ascii?Q?pUIzguoHup0jJHBuVWvJJPlAwRMF/6H/uI4zPX/83ZCzr6ll7MUrU5N1j4q5?=
 =?us-ascii?Q?cZSNnZ9MqX0JlsnrSQyjZWkiDDRV1aPfXGNp+5YG9MlvlKcz23If1IzQvGJG?=
 =?us-ascii?Q?rLfCBUwhxWXcWXsebgIdXei/p34nJjgZYiVXHGQ2H21AQqdKrgdT9zyBV3mA?=
 =?us-ascii?Q?L3AlI30pNvopMh/y3a64gIO9lvHjAIYC7Hybaa+oviPk+MBP48529y770u5x?=
 =?us-ascii?Q?TowLHQW87uR2z9q75KmmQtceam/lYz8yL5vdJS1uxXwQXzoHUgHzDZ3//QGQ?=
 =?us-ascii?Q?wzSVwZSn5MMpEWV+Mh1TKNrkHGGmn2dZRw9CBfLcNg1+TNb4cm5BvqX7xE4K?=
 =?us-ascii?Q?87AlXk2DgafyfzTdyhje/oWDIafjSiUXJjDDTE7KwoxK64Jp1wqykWQsRElr?=
 =?us-ascii?Q?B9cUHdwiFWwsCIhEPnXx4yLzlWm8OCGAUnzoFhRE?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e54e00b0-3572-48a0-b9a1-08daa41e0d05
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2022 02:30:20.2205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gmgqsp68ivwe+chd4M8crHRP+2Cip01xUXC6j87Q39xceIcx1811mRWJ14lekdD06Vb1CeyqIUgnZUKHJgGcVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5309
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 02, 2022 at 01:46:41AM +0100, Al Viro wrote:
> On Sat, Oct 01, 2022 at 05:23:25PM -0700, ira.weiny@intel.com wrote:
> 
> >  	kiov = kcalloc(page_count, sizeof(*kiov), GFP_KERNEL);
> > @@ -38,12 +39,12 @@ static int shm_get_kernel_pages(unsigned long start, size_t page_count,
> >  	for (n = 0; n < page_count; n++) {
> >  		kiov[n].iov_base = (void *)(start + n * PAGE_SIZE);
> >  		kiov[n].iov_len = PAGE_SIZE;
> > +		pages[n] = virt_to_page(kiov[n].iov_base);
> > +		get_page(pages[n]);
> >  	}
> > -
> > -	rc = get_kernel_pages(kiov, page_count, 0, pages);
> >  	kfree(kiov);
> 
> IDGI.  The only thing in kiov[...] you are every reading is
> ->iov_base.  And you fetch it once, right after the assignment.

:-(  Good point.  Thanks for catching that.  I was too focused on just
replacing get_kernel_pages() with get_page() and I should have refactored
more.

> 
> Why bother with allocating the array at all?
> 		pages[n] = virt_to_page((void *)start + n * PAGE_SIZE);
> would do just as well, not to mention the fact that since you reject
> vmalloc and kmap, you might simply do
> 
> 	page = virt_to_page(start);
> 	for (int n = 0; n < page_count; n++)
> 		get_page(pages[n] = page + n);

I think I'd avoid the assignment in the parameter as I would miss that if I
came back and looked at this code later.

I'll get rid of the kiov in v2.

Sorry for not cleaning it up more and thanks for the review!

Ira
