Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D1D65C4CB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 18:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238408AbjACRMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 12:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238772AbjACRMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 12:12:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5655D8
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 09:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672765769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mP/0RVdlBQMTYiXgcESvoTIJxwn2GWQAIRYQWpydkNo=;
        b=K0Ua1+/Cx6o9KuAUqOrbv+LAfRKJFsJeDGU/3RhCHYO/oHRpjoU9cyrZysLztJbA0mXfLq
        sTVkttvXUU/Qfy0oDfU+08OL+vCrRDywqzj3yUj8sdh9d9Sr8oN+U2O8qSEr8Ck9eX0PUf
        5Z/Un8VJ32UezhTu6HOtCz00liyCffA=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-257-25M4ucMROnCcrnPilOr8Kg-1; Tue, 03 Jan 2023 12:09:27 -0500
X-MC-Unique: 25M4ucMROnCcrnPilOr8Kg-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-47e231f5a18so208925987b3.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 09:09:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mP/0RVdlBQMTYiXgcESvoTIJxwn2GWQAIRYQWpydkNo=;
        b=MEuexoZMWbGWk4cOigaizrULWqzpQJ8vZrcLN+XbdJHzJaXkn8YwSqsOqok9LHwYLk
         WCULAAqHllRwNUmf8b9ZliUv84Y6ztS5vZ62AYa0MwDvG4PAUoh10cHMmCgG8VkAUfHY
         SUqP8qw2dq+gE//07Mw2EDzJ4+cRRn3oEQAlidtjMllbMS7BlbPPyn1W0PMuTx5LuKVK
         sUokPGjStdW3RfoypKLSbTMb6JG1bcGyENQ2dJvX2EWTp9YR8TF9T9juonYPBGbVmsGo
         hJ1h8CdMpJgasnh6jxe/7YOZimVM0ObpbiK7NM2p97spQW9HS5E9CISOO8ljBRgxBsQa
         mclQ==
X-Gm-Message-State: AFqh2kqQsuanLuU7QSpvH4fSOSSI3AwRdpdWzBx28NMsE29y0cZ+hChu
        WYpcq+ySTSSVY8qupfnvDNKjncHtwhBZ6abS7i9BJivkJC/aZlp9laDLutIVJ5xXSOx4C12KeZq
        rDFavHm78Y2/p9Gt3PJANdwV0
X-Received: by 2002:a05:7508:6041:b0:46:ce19:e55 with SMTP id r1-20020a057508604100b00046ce190e55mr3381368gbr.12.1672765766997;
        Tue, 03 Jan 2023 09:09:26 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuHYwtgiy8y0HHf0RLvFlySMAwVAzGoPQEc4nS6R5L2GsLz4r79jfpK+00VRFTdeQ5yvv7P6w==
X-Received: by 2002:a05:7508:6041:b0:46:ce19:e55 with SMTP id r1-20020a057508604100b00046ce190e55mr3381342gbr.12.1672765766659;
        Tue, 03 Jan 2023 09:09:26 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-39-70-52-228-144.dsl.bell.ca. [70.52.228.144])
        by smtp.gmail.com with ESMTPSA id o5-20020a05620a2a0500b006fc2f74ad12sm22803013qkp.92.2023.01.03.09.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 09:09:25 -0800 (PST)
Date:   Tue, 3 Jan 2023 12:09:23 -0500
From:   Peter Xu <peterx@redhat.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 34/47] hugetlb: userfaultfd: add support for
 high-granularity UFFDIO_CONTINUE
Message-ID: <Y7RhQ427Qbie/NRE@x1n>
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-35-jthoughton@google.com>
 <Y6X1isYeuZMxvDEC@x1n>
 <CADrL8HWfyaQVfcrqrT7Hzt3iHGXiVzNycfCFKpD=YK-YEAX-nA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADrL8HWfyaQVfcrqrT7Hzt3iHGXiVzNycfCFKpD=YK-YEAX-nA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022 at 11:38:31AM -0500, James Houghton wrote:
> On Fri, Dec 23, 2022 at 1:38 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > James,
> >
> > On Fri, Oct 21, 2022 at 04:36:50PM +0000, James Houghton wrote:
> > > +     bool use_hgm = uffd_ctx_has_hgm(&dst_vma->vm_userfaultfd_ctx) &&
> > > +             mode == MCOPY_ATOMIC_CONTINUE;
> >
> > Do you think in your new version use_hgm can work even for MISSING by
> > default?
> 
> I don't think so -- UFFDIO_COPY will allocate a hugepage, so I'm not
> sure if it makes sense to allow it at high-granularity. If UFFDIO_COPY
> didn't allocate a new page, then it could make sense (maybe we'd need
> a new ioctl or new UFFDIO_COPY mode?). I think it makes most sense to
> add this with another series.

I forgot again on how the page cache is managed for the split pages,
sorry..  Yeah let's stick with minor mode for now.

-- 
Peter Xu

