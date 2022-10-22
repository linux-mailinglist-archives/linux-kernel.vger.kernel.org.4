Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A587608262
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 02:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiJVAAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 20:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiJVAAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 20:00:33 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC9213738D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 17:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666396832; x=1697932832;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PGHhWB7mSoL32ftdN7K/fPN7ZbwNXUB8FG1YGumXg3E=;
  b=nV6OCY+edujoJUvaS7uoxazDxHu1T+Urp+hBIViGtJmrPHVxrcvEzddD
   2lAy3BgiQ+DyUzYtzwb2Xpy8PbJYinwyXiKmCUugtTHvlAfqwHBGl+buK
   XzYxC/tq4z8rEnaAkRmDdnHnsHo300JOR91DzXCjw/qoK7zyZR8e78mSg
   q02uQk+agWeI7DjAhIABxGfm9afEQLUpb6DaPhuXeB/Qy5s4AFusMvIc0
   y9InTibGjZg2mO5qwQoVXqyEA5OlprOmKpIqvibJsjFO8ZKjfEDk33wpx
   YWm1smuUpPiQvGOPcga8vDvz/wUp0F11Vhtc27QCUptYBW/Xx1ljJV7Ku
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="294531226"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="294531226"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 17:00:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="693915699"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="693915699"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 21 Oct 2022 17:00:31 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 17:00:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 17:00:30 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 21 Oct 2022 17:00:30 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 21 Oct 2022 17:00:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=blLNN5fQIP8JtTMqTpzg2TkLb8X4NWgvIw6gf140dt0xQQTQfeXtVuXuBsDrz08ra4Q3iWPjV2CtqOWr0vpR7Gdpocqlj8ry2GVjPsf8vhqTGQvIAXWpbgAfxuATQGv2tQORHxGqt0f1eTyJUnVJ5DyhKoH6KT6Q3RJsgeQyI3yApLYez474s7SZ3u+aAbXO4K8+1Yz6zRwVPcyJ0FqjYi/YoxDrLBDoIfyeMFs85EBdo2ctVrNpnhuAqblJKd+6LkeA+gLK/2e7xHtvfG8GDzFWIlpT7V85NrgIE8bgLvtS+25gQLyZW5ovp0+ldLkzUU/8ZMAOKoEGmvdfXfCeBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAGv0KMilp6GhGZ1mtbRzBHxYfrL/KOToKjVFIXgfpY=;
 b=hzlCTxJQ1RhfMc7/dRohu64NGfUSW+Pr9WWqlXFozbts+B3XmNF27vlwsLvzL9NBdxq+wI9076RGeRcn2oGCttA+xeXDgSk5ReV8qaKkLwC0CFQD0A1Dr3vQFnsscYPetOdZN/lwkN7H8B35K/E/9+gUM4noN7YtWlNGjNsaQnMqQDP88FZkbiJQtS7FynXHJyI1ZXUVfr/5PElPQMeDfL6FZIwCvxrjaM8V64Pnq2YOak/vn1TSu7wzvzHeUMapmc1iUoMa7f9D9zvc5/jg1mnH7QM4d5biER3ztYxdbhuoUflu0FrkJ/3/BlEvEUhGNLO/5oZV8IAUWZnfkI7XIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SN7PR11MB6679.namprd11.prod.outlook.com (2603:10b6:806:269::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Sat, 22 Oct
 2022 00:00:28 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae%8]) with mapi id 15.20.5723.033; Sat, 22 Oct 2022
 00:00:28 +0000
Date:   Fri, 21 Oct 2022 17:00:24 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Matthew Wilcox <willy@infradead.org>,
        kernel test robot <yujie.liu@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        <lkp@lists.01.org>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [shmem] 7a7256d5f5: WARNING:possible_recursive_locking_detected
Message-ID: <Y1MymJ/INb45AdaY@iweiny-desk3>
References: <202210211215.9dc6efb5-yujie.liu@intel.com>
 <Y1KZ/NF5bNG1wykf@casper.infradead.org>
 <20221021133041.5811e1fb291eb6aaf122a59c@linux-foundation.org>
 <Y1Mh2S7fUGQ/iKFR@iweiny-desk3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y1Mh2S7fUGQ/iKFR@iweiny-desk3>
X-ClientProxiedBy: BY3PR10CA0014.namprd10.prod.outlook.com
 (2603:10b6:a03:255::19) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SN7PR11MB6679:EE_
X-MS-Office365-Filtering-Correlation-Id: 829da178-94bb-461e-1499-08dab3c06dae
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sPtvt1BP5//TUsqJCdI5aRHgBYDhQJGtOx4jZV4VlnTxS/cyZtKB2d3Xz8w5OksN4EMTH/gNkIL9k5D4w6dSXXVSq2fRzdlismlyUbMUuBCfY5msgXVVHd983C3zl5EHl8n22JZ6rvkoobHvJTjPqwsHYIWjmQcyZRo7ZmJh0PksN/h5Y+mlgObVcfe9EDZKpffrd8Qz8Mxq/KwiUKZKbXgiYuyrt9nXiQchQGB6szutQ/1/YHwQLSJ3WG1hpwmyqIdWdd/6Ev2Hf1dIBY/7ywuCCg7cbaD7eClWj5LoJkPEX+Vz7ii55yhX2ZRMLhIBiOvHPnhDFIP02meePCfx1N+XruopmZMcsHJnXG9rPWv49m6+oKNQjuXMNSj8UqiUInffYKGKa63VUUBmZ2bYJjTqVcG0ebCQcJ4cIG98SwR7nZzuQN6P5UvXPonjCQryx4B8ERIpSvw5dNYK+M/eZD6yw3F814hpRr7DtAVAF8NT8h+58a/3PFjXHXYidyXsjiWCZOv3S3ppeo8+Q/+PHq5h/793TIzORp7VDyDyEMIVeYwSi81vEm0t+c39okXVGABc3l9dDCkIBl5+hwStg8StW8VsRggbodM3ISwWhYwQYuYcV+nBYzFuiXlr+LD5e8pikyKihCiqLNjh15KTbpqk9OVJjZUeCpMnjKJohU/rQKlHckXt/RS1fhh0s7mxx2x905fFp2IXgr4jvhcSJqswDkTCPiy1FLMjlZLUpIUYRWHJDyXoi8FD9Gg1w/C0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(396003)(366004)(376002)(136003)(346002)(451199015)(66946007)(316002)(44832011)(4326008)(66556008)(86362001)(5660300002)(82960400001)(6916009)(38100700002)(54906003)(8676002)(66476007)(186003)(2906002)(8936002)(83380400001)(41300700001)(33716001)(478600001)(6666004)(6486002)(966005)(26005)(9686003)(6512007)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZTqJfzgoWlo54KUOUYjCZ6DfJCk8ylE64oB/mDqaZVdNxtN18vV7ZiR7+UdW?=
 =?us-ascii?Q?qlpURywM2JiEX16/OFEBgiijLpyhELFiTp1loVl823Z/PuIFsWsWROqPw1wp?=
 =?us-ascii?Q?opK9yWGLm9BLY10of47DykuNaRbqMGFL0LAC/zpu5ewP7cqoBMpssmyZ6Stb?=
 =?us-ascii?Q?jsr8JTMhB333OVe/9UCdctu8dej5pXR/jBqVHkGStpctw46HITH505/jsS9D?=
 =?us-ascii?Q?L75lAx5+0uqV1lViQMtLoWaLg7hPoX0p9aEoz9sEO2j+xAnbdpb7dqIvv8oX?=
 =?us-ascii?Q?BMKrLEl1ty1skqaTEMmh8bqT7fPE7EEFkYQNhb0YXlMaE1iT/47dxt24hdir?=
 =?us-ascii?Q?JfjmI2vt4JhBMTi4ExF7Tb/SavgeeaxjbQ4MrGvFrQgPAgHHOhh0Gzb0sas9?=
 =?us-ascii?Q?nnVap7rfwMuZtLJoC0Yt1pfiJYNGjfnqtYPFstbvKQr+DelNMV+oFj42R+aN?=
 =?us-ascii?Q?fNqDq6xUDTU5NKPtw84CHi7zwz0trMdXVuX7LbYwYNJDn7EiARjzBOPUmJuX?=
 =?us-ascii?Q?2vcs9Qow2Y4kd0NvE3qgyc/yKeFbMiZ2sOK0Zbh6lSPyC8T8vGG7CW43eZuB?=
 =?us-ascii?Q?lFhlvPWnsAFNyStk45tgy13uawmLNvC9XPchzxYZglZJaWlV85Gz6OaZ0hXd?=
 =?us-ascii?Q?paMB/ezumMJmKQnoI3YcOd6pNqWQcjFMf0QRHVWpQAoy5d3MFfPbOZb3ylxX?=
 =?us-ascii?Q?kLlDftosBkkxdWnjnyFuQJkLDiSz0RDK8FlZbXVE9YEd3AL2nidJIsCjT03J?=
 =?us-ascii?Q?8oMPc/MOa2e8uH5Va1vYoyuLiy3XjteOBDpIAVfb93mqF8UUCXBly8bj1XSk?=
 =?us-ascii?Q?tTHDBc3fnaQClqDJTDDvMr/a7FYruzS0U/8+UhSo87G/9xGFRts3qGWtaIJE?=
 =?us-ascii?Q?Hey3pmFbBJ5VSyikWIiXkJ/P0R2LPkNkPKhyK/ynjCT2UclesPzIgb01uEuO?=
 =?us-ascii?Q?V/4apRIhT3ra5wRWheRszs/bUT6PBBdqdlQcrNQ2Plsk72poTtDu+tl/u9qY?=
 =?us-ascii?Q?xx95N/YSVPO/g1xL2E98vrsMiDEMIJZ+zcJ8bK98TfEmX+yJ7Cj+QM3mirRU?=
 =?us-ascii?Q?vWFj7H34BZtc2GMg71usy1hp1jQBicwgZuohpQOAhxT7lyJo8lhGQl22IJei?=
 =?us-ascii?Q?S/nSgoTC7iAIRP42avaP4Tf79CuBLdmVaZrsTYqORFYGNfBbRiUSkeL8FZJm?=
 =?us-ascii?Q?KhJ7NUOX4XFWQ0MoH5LA/LV8D0j53bOEiE0yxC0O+kO4ax1HHmhXHmm5wFzO?=
 =?us-ascii?Q?edYVNnJoI3mRgzZrxahv67c2wIlsKHz9YyMnJ8Ok0Hhh0g3HSWSuO4c+6Q6U?=
 =?us-ascii?Q?dricsIZPjdhZ8BAOY7uzryoZcDgMq1jylKD5pFWm/qpMTtC97+RfGhnu3sTf?=
 =?us-ascii?Q?2CwcNpi7QkikXmWwbOHEJSUkxQ2sDXJvuKrVxsjXi8AOPP2bdOyJtHph+M7f?=
 =?us-ascii?Q?KEtiuTNNXIWUdFzsAe9RrggHH9I1W3s/K6CtpnnGUAkb6sqxga1FDTnKVYxq?=
 =?us-ascii?Q?7I4L3WdnBKHAcpzZqUkdmWeMlLQZ5jYqIqQ+IYN5+rhao23q4quvhLRE7Rdz?=
 =?us-ascii?Q?H9SCGD1rNC98I46cWs0qp/viFvEg9FMwL9APdVkj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 829da178-94bb-461e-1499-08dab3c06dae
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2022 00:00:28.3438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xs7SvfJYRW3jsFD8t5uLqtOqiqoVIyJwf9wX8kiQsQLNRgCNBQnqmH+pUDq6qx6shMtlb5ZRfMetpO2ka81R0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6679
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 03:48:57PM -0700, Ira wrote:
> On Fri, Oct 21, 2022 at 01:30:41PM -0700, Andrew Morton wrote:
> > On Fri, 21 Oct 2022 14:09:16 +0100 Matthew Wilcox <willy@infradead.org> wrote:
> > 
> > > On Fri, Oct 21, 2022 at 12:10:17PM +0800, kernel test robot wrote:
> > > > FYI, we noticed WARNING:possible_recursive_locking_detected due to commit (built with gcc-11):
> > > > 
> > > > commit: 7a7256d5f512b6c17957df7f59cf5e281b3ddba3 ("shmem: convert shmem_mfill_atomic_pte() to use a folio")
> > > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > 
> > > Ummm.  Looks to me like this now occurs because of this part of the
> > > change:
> > > 
> > >                 if (!zeropage) {        /* COPY */
> > > -                       page_kaddr = kmap_atomic(page);
> > > +                       page_kaddr = kmap_local_folio(folio, 0);
> > >                         ret = copy_from_user(page_kaddr,
> > >                                              (const void __user *)src_addr,
> > >                                              PAGE_SIZE);
> > > -                       kunmap_atomic(page_kaddr);
> > > +                       kunmap_local(page_kaddr);
> > > 
> > > Should I be using __copy_from_user_inatomic() here?
> 
> I would say not.  I'm curious why copy_from_user() was safe (at least did not
> fail the checkers).  :-/
> 
> > 
> > Caller __mcopy_atomic() is holding mmap_read_lock(dst_mm) and this
> > copy_from_user() calls
> > might_fault()->might_lock_read(current->mm->mmap_lock).
> > 
> > And I guess might_lock_read() gets upset because we're holding another
> > mm's mmap_lock.  Which sounds OK to me, unless a concurrent
> > mmap_write_lock() could jam things up.
> > 
> > But I cannot see why your patch would suddenly trigger this warning -
> > kmap_local_folio() and kmap_atomic() are basically the same thing.
> 
> It is related to your patch but I think what you did made sense on the surface.
> 
> On the surface copy_from_user() should not require pagefaults to be disabled.
> But that side affect of kmap_atomic() was being used here because it looks like
> the code is designed to fallback if the fault was not allowed:[1]
> 
> mm/shmem.c
> ...
>                         page_kaddr = kmap_local_folio(folio, 0);
>                         ret = copy_from_user(page_kaddr,
>                                              (const void __user *)src_addr,
>                                              PAGE_SIZE);
>                         kunmap_local(page_kaddr);
> 
>                         /* fallback to copy_from_user outside mmap_lock */
>                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>                         if (unlikely(ret)) {
>                                 *pagep = &folio->page;
>                                 ret = -ENOENT;
>                                 /* don't free the page */
>                                 goto out_unacct_blocks;
>                         }
> ...
> 
> So this is one of those rare places where the kmap_atomic() side effects were
> being depended on...  :-(
> 
> [1] might_fault() does not actually mean the code completes the fault.
> 
> mm/memory.c
> ...
> void __might_fault(const char *file, int line)
> {
>         if (pagefault_disabled())
>                 return;
> ...
> 
> > 
> > I see that __mcopy_atomic() is using plain old kmap(), perhaps to work
> > around this?  But that's 2015 code and I'm not sure we had such
> > detailed lock checking in those days.
> 
> No kmap() can't work around this.  That works because the lock is released just
> above that.
> 
> mm/userfaultfd.c
> ...
>                         mmap_read_unlock(dst_mm);
>                         BUG_ON(!page);
> 
>                         page_kaddr = kmap(page);
>                         err = copy_from_user(page_kaddr,
>                                              (const void __user *) src_addr,
>                                              PAGE_SIZE);
>                         kunmap(page);
> ...
> 
> So I think the correct solution is below because we want to prevent the page
> fault.

I was about to get this patch ready to send when I found this:

commit b6ebaedb4cb1a18220ae626c3a9e184ee39dd248
Author: Andrea Arcangeli <aarcange@redhat.com>
Date:   Fri Sep 4 15:47:08 2015 -0700

    userfaultfd: avoid mmap_sem read recursion in mcopy_atomic

    If the rwsem starves writers it wasn't strictly a bug but lockdep
    doesn't like it and this avoids depending on lowlevel implementation  
    details of the lock.
    
    [akpm@linux-foundation.org: delete weird BUILD_BUG_ON()]
    Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
    Acked-by: Pavel Emelyanov <xemul@parallels.com>
...

So I wonder if the true fix is something to lockdep?

Regardless I'll send the below patch because it will restore things to a
working order.

But I'm CC'ing Andrea for comments.

Ira

> 
> Ira
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 8280a5cb48df..6c8e99bf5983 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2424,9 +2424,11 @@ int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
> 
>                 if (!zeropage) {        /* COPY */
>                         page_kaddr = kmap_local_folio(folio, 0);
> +                       pagefault_disable()
>                         ret = copy_from_user(page_kaddr,
>                                              (const void __user *)src_addr,
>                                              PAGE_SIZE);
> +                       pagefault_enable()
>                         kunmap_local(page_kaddr);
> 
>                         /* fallback to copy_from_user outside mmap_lock */
> 
> 
