Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7914A6C3532
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjCUPLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjCUPK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:10:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BB47DA0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 08:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679411408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+DFoGD9BJrCFMifx1PxTOB2rujq31Ya1+80mI9jX3No=;
        b=I5pP3ZMfG+MWMIqTCtG4ezZD/sdBj4/8DtKE2eYgjg/Nb93PPoiNjhVAhkWA+88v2X/V0t
        zWRG0SMxf4V3dKrHfw7So/o6ETJU6ye9e0nRq7aeEZXnebwqbPYQFxwAy+vCZ5U6p9L4k0
        2a08HEnmRBtfBznqXVYQYlWoytC0Ark=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-O0ctqrq4Oqy09aCGbnvvsQ-1; Tue, 21 Mar 2023 11:10:06 -0400
X-MC-Unique: O0ctqrq4Oqy09aCGbnvvsQ-1
Received: by mail-qt1-f200.google.com with SMTP id u22-20020a05622a011600b003dfd61e8594so4487836qtw.15
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 08:10:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679411406; x=1682003406;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+DFoGD9BJrCFMifx1PxTOB2rujq31Ya1+80mI9jX3No=;
        b=JLs3NVeFtFXq+iamOglTCTcsKj4A2cpDwh6FWfkU1ZuqLwyjQk0Pc2HoqFHGeiwiH4
         vhyonEdGFRKPaU7yc8dKxwhAz19Ai4jTjpgXwiv3jIwRJJq1EJbuo477PXsTe38/aHSg
         R8WVrljH8wdNvSXOtZvHH/YiwXbxzHPBGSs+5PtLXqT1vLMt7H9SX4uXGa7LymK0+eD6
         MHU60waOfkFIp4herJJtGqs6jBI6BaDO2m/bSxyIPd4s3GU0i4qWR5V81m0AlAbbe6Wn
         W3gr20X9mTGZh0Y1OA0Oypiw9BYlTGz+qiCQ0CjWp/3E5XFgbubyMsnlnjP5Wf+0IeYz
         5rmA==
X-Gm-Message-State: AO0yUKWt1We1Sx6e3723wVr3Nr/U3yQ43D94iyT7BcDCd4lMwlfT5qGK
        kbyiBB7Dca8JwNsGk5cPB/YiXxuDdqag/MLfYgqRBjrm/KUqZc7sKjKCTmBYptlLWzsh29I7GSm
        ETrLHIjiVuC74QEVKpss9EuLm
X-Received: by 2002:a05:6214:519d:b0:5af:3a13:202d with SMTP id kl29-20020a056214519d00b005af3a13202dmr4203422qvb.4.1679411405812;
        Tue, 21 Mar 2023 08:10:05 -0700 (PDT)
X-Google-Smtp-Source: AK7set8W9eKuw8mGCscF9tjJFG3duBKw2qky36XBzhbw6oNhwiuWMqsmeB+rT/nlMILNCEGFQIkjlg==
X-Received: by 2002:a05:6214:519d:b0:5af:3a13:202d with SMTP id kl29-20020a056214519d00b005af3a13202dmr4203396qvb.4.1679411405533;
        Tue, 21 Mar 2023 08:10:05 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id s10-20020a05620a16aa00b0074341cb30d0sm9364657qkj.62.2023.03.21.08.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 08:10:04 -0700 (PDT)
Date:   Tue, 21 Mar 2023 11:10:02 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrei Vagin <avagin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Nadav Amit <namit@vmware.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: Re: [PATCH v11 0/7] Implement IOCTL to get and optionally clear info
 about PTEs
Message-ID: <ZBnIyjTJ5yfxpcgs@x1n>
References: <20230309135718.1490461-1-usama.anjum@collabora.com>
 <20230309115818.170dd5ef2cde7b58b9354ecd@linux-foundation.org>
 <CANaxB-wGLbM9U_dK=kzs+r5Xy358aKZ0=J_zODiLOcng+dbXog@mail.gmail.com>
 <ZBmmEfgq8QBAKPFN@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZBmmEfgq8QBAKPFN@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 02:41:53PM +0200, Mike Rapoport wrote:
> On Mon, Mar 20, 2023 at 11:30:00AM -0700, Andrei Vagin wrote:
> > On Thu, Mar 9, 2023 at 11:58 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> > >
> > > On Thu,  9 Mar 2023 18:57:11 +0500 Muhammad Usama Anjum <usama.anjum@collabora.com> wrote:
> > >
> > > > The information related to pages if the page is file mapped, present and
> > > > swapped is required for the CRIU project [5][6]. The addition of the
> > > > required mask, any mask, excluded mask and return masks are also required
> > > > for the CRIU project [5].
> > >
> > > It's a ton of new code and what I'm not seeing in here (might have
> > > missed it?) is a clear statement of the value of this feature to our
> > > users.
> > >
> > > I see hints that CRIU would like it, but no description of how valuable
> > > this is to CRIU's users.
> > 
> > Hi Andrew,
> > 
> > The current interface works for CRIU, and I can't say we have anything
> > critical with it right now.
> > 
> > On the other hand, the new interface has a number of significant improvements:
> > 
> > * it is more granular and allows us to track changed pages more
> >   effectively. The current interface can clear dirty bits for the entire
> >   process only. In addition, reading info about pages is a separate
> >   operation. It means we must freeze the process to read information
> >   about all its pages, reset dirty bits, only then we can start dumping
> >   pages. The information about pages becomes more and more outdated,
> >   while we are processing pages. The new interface solves both these
> >   downsides. First, it allows us to read pte bits and clear the
> >   soft-dirty bit atomically. It means that CRIU will not need to freeze
> >   processes to pre-dump their memory. Second, it clears soft-dirty bits
> >   for a specified region of memory. It means CRIU will have actual info
> >   about pages to the moment of dumping them.
> > 
> > * The new interface has to be much faster because basic page filtering
> >   is happening in the kernel. With the old interface, we have to read
> >   pagemap for each page.
> 
> There is still a caveat in using userfaultfd for tracking dirty pages in
> CRIU because we still don't support C/R of processes that use uffd. 

This reminded me whether the interface can also expose soft-dirty as a
ranged soft-dirty collector too to replace existing pagemap read()s?  Just
in case userfault cannot be used.  The code addition should be trivial IIUC.

Then maybe PAGE_IS_WRITTEN will be a name too generic, it can be two bits
PAGE_IS_UFFD_WP and PAGE_IS_SOFT_DIRTY, having PAGE_IS_UFFD_WP the inverted
meaning of current PAGE_IS_WRITTEN.

-- 
Peter Xu

