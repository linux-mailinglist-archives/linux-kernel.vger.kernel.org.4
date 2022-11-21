Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF79632C5E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 19:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiKUSyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 13:54:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiKUSx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 13:53:58 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090ED2A25D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 10:53:57 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id s4so7862947qtx.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 10:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F3RGtc3hwYzfdRXPootOnNmarmPw3yS/xesmREyhZ8U=;
        b=i9Cj0cnu73KzMvbiv9kVOA678kptYbCMN6jfQsgdxPJCC1cb1KUs3RzzQkAiIn9bnw
         /ix8P2GC1eKOesG/hViOqu6yAm6KMYa0qL5WPdmi09xBCVj+wY0e9r9ZPbafHIiDp5vc
         smkG3aZY/j3jb0w5RbYVE75kTGC5uI8pVPdyn5UvVBmemHWhQtk0ePd128c6tF+jcrdZ
         J8fYb9yGwJ/o9z4m2K+gIbB7Ck205MMyvpEODzVcFLbhPvkR4iOA3CLE0evQXWUp3jIO
         A/RPUgbAuCpsWL5ZeB3aXfuOkn7wjlTo97nEWJiwcPK+cG/Yp+PFf9ITm0RQC4iOINUJ
         bg9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3RGtc3hwYzfdRXPootOnNmarmPw3yS/xesmREyhZ8U=;
        b=TZDUoIPAJB6dS1vu4PnvkL/wp7cUAI0fUxIKe2Qo6EMTUEOqCj1PaM1KCS2nuDsS/d
         Hqg6vWzmgDA8rpV7cGPBOleqQumvzUnP86p1rAoS99P0aVp3Rqyz7qLd/dWjAcWIkSLH
         4XAdLOR/gILNv52oD/6q2A0pVOYgVHkWw2vGbCrLiNRRDhEgswfhWcgOSfpWh1HmfYtW
         5kzLWmBYnV9bSjz0PC1L4KlYiL6NaQ2PCwpV4WfkkYfqVBygiEhMLupVkAmhNd332Smj
         2T6MnxjEXZTaVF4wuR0kjIOAijdAHmFcfP97peStD862dlD5eZJMU+QbRnxilN/WgtZV
         s/PQ==
X-Gm-Message-State: ANoB5plTdY4ikvRS3VG/efIOtlDB+T6OlGcnzk7nX/IaEE+PZ/ZMHJF2
        5WMCJiPilc2RBVHdnmn8zgE3WQ==
X-Google-Smtp-Source: AA0mqf4L9nS3TxiZ7SnyvD+WiiDkebZOY/qRJLIitYHJfXt3Y3jjhCn2FvnVxczP2Tox03hL5jk1Cg==
X-Received: by 2002:ac8:7513:0:b0:3a5:4442:80fa with SMTP id u19-20020ac87513000000b003a5444280famr5160955qtq.233.1669056836189;
        Mon, 21 Nov 2022 10:53:56 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-122-23.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.122.23])
        by smtp.gmail.com with ESMTPSA id y19-20020a05620a44d300b006f9f3c0c63csm9056145qkp.32.2022.11.21.10.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 10:53:54 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1oxBvW-009M8u-0v;
        Mon, 21 Nov 2022 14:53:54 -0400
Date:   Mon, 21 Nov 2022 14:53:54 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Li Zhijian <lizhijian@fujitsu.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [for-next PATCH 4/5] RDMA/rxe: refactor iova_to_vaddr
Message-ID: <Y3vJQkc40o5zfM5v@ziepe.ca>
References: <1668141030-2-1-git-send-email-lizhijian@fujitsu.com>
 <1668141030-2-5-git-send-email-lizhijian@fujitsu.com>
 <CAPj211to20yHUy8o-Lg6TMjB5rpwrfPCUtQqxfeDFHUDR4+wJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPj211to20yHUy8o-Lg6TMjB5rpwrfPCUtQqxfeDFHUDR4+wJw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 01:37:14PM +0100, Fabio M. De Francesco wrote:
> > -     return (void *)(uintptr_t)mr->map[m]->buf[n].addr + offset;
> > +     if (mr->ibmr.type == IB_MR_TYPE_USER) {
> > +             char *paddr;
> > +             struct page *pg = mr->map[m]->buf[n].page;
> > +
> > +             paddr = kmap_local_page(pg);
> > +             if (paddr == NULL) {
> > +                     pr_warn("Failed to map page");
> > +                     return NULL;
> > +             }
> 
> I know nothing about this code but I am here as a result of regular checks for
> changes to HIGHMEM mappings across the entire kernel. So please forgive me if
> I'm objecting to the correct changes.
> 
> 1) It looks like this code had a call to page_address() and you converted it
> to mapping with kmap_local_page().

It only worked properly because the kconfig is blocking CONFIG_HIGHMEM
so ZONE_HIGHMEM doesn't exist. These pages are obtained from GUP and
could be anything.

This is done indirectly through

config INFINIBAND_VIRT_DMA
        def_bool !HIGHMEM

But this patch is undoing parts of what are causing that restriction
by using the proper APIs. Though I'm not sure if we can eventually get
to remove it for RXE completely.

Jason


