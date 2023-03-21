Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24166C3890
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 18:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjCURrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 13:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCURrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 13:47:10 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AA729141;
        Tue, 21 Mar 2023 10:46:41 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PgzXL6LT4z6J7GC;
        Wed, 22 Mar 2023 01:45:22 +0800 (CST)
Received: from localhost (10.126.169.70) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 21 Mar
 2023 17:46:35 +0000
Date:   Tue, 21 Mar 2023 17:46:32 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
CC:     <linux-cxl@vger.kernel.org>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <will@kernel.org>, <dan.j.williams@intel.com>,
        <bwidawsk@kernel.org>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <linuxarm@huawei.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] cxl: CXL Performance Monitoring Unit driver
Message-ID: <20230321174632.00001c5c@Huawei.com>
In-Reply-To: <52abbd9a-3a63-3dde-c20f-99787225200e@linux.intel.com>
References: <20230303175022.10806-1-Jonathan.Cameron@huawei.com>
        <20230303175022.10806-4-Jonathan.Cameron@huawei.com>
        <b766b4ca-1255-3b33-864c-0e7f9ab00e15@linux.intel.com>
        <20230306144124.00006b94@Huawei.com>
        <52abbd9a-3a63-3dde-c20f-99787225200e@linux.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.169.70]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> So each fixed counter has a dedicated event cap reg.
> >> All the configurable counters share the rest of the event cap regs.
> >> Is my understanding correct?  
> > 
> > Yes.
> >   
> >>
> >> To check the event cap, you have to go through the whole list, which
> >> seems not efficient. Have you consisdered to use other structure, e.g.,
> >> rb-tree to store the event capability information.  
> > 
> > Whilst this is a fairly short list for a given CPMU (max 32 elements),
> > there is no harm in having something cleaner. 
> > 
> > However I'm struggling a bit on what that structure should be.
> > There are two forms of indexing used.
> > 1. VID, GID and MASK all match precisely - could use an xarray, but
> >    the index created from these is too large, so I guess an RB tree.
> > 2. VID, GID and subset of MASK (no constraints on mask combinations)
> > 
> > Can't index by just VID/GID as there may well be multiple entries.
> > 
> > Can't index by VID/GID/MASK as whilst that is either unique (or there is
> > duplication we can ignore) there is no obvious way to search for
> > a subset of mask.  Could have a red black tree with lists for the nodes
> > but that's pretty ugly.
> > 
> > Any thoughts on what would work here?  
> 
> If it's a short list, I think it should be OK.
> But I think we may want to split the list into a fixed counter list and
> a configurable counter list. I don't see a reason to mix them in one
> list. It should further reduce the list. I think we may further factor
> out a wrapper e.g., cpmu_events_find_fixed_counter(vid,gid,mask),
> cpmu_events_find_config_counter(vid,gid,mask).

For this aspect, it turned out to be easier to factor out only the finding
of the event as that code rather than going all the way to the counter
(the last part only occurs in one location in current code anyway)

That allowed the same util functions to be used both to establish
visibility of the attrs and here without having to pass a nasty
flag in to say whether we should look for an available counter or not.

Thanks,

Jonathan
