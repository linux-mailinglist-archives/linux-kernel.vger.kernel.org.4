Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0003B656D04
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 17:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbiL0QjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 11:39:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiL0Qip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 11:38:45 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06299BE21
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 08:38:45 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id y8so12825467wrl.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 08:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9wRW7TKueArBUfnnmbZEuYC3CJj8NI6TnvFxQoqEUT0=;
        b=d+xPdL7coIPZRO5nn3egLZtv3PN3VOJ1gOzyBA88vkN76zmYEbmNdb7rYq3FKGyYib
         2iOrcnGeRaD4g6aVanQdshfYBFpmcmkZk3xaTZgYTYkR+o5teU0meZ2Nml2vsrXU04h5
         NOTcMmDdprrOZFPXI+uRWD3nX4cRr18qmGbwJOymdbC8EgUkyVEIG2rtv7BsToVxi2Yp
         GIF5Ped4Rh1RWbRTDe8BL4VPvbQemc6yd98J44QhIKFibik3LmMw5RmNvx0Yb7xxjdiW
         5XWacGwoRjdndljAlRWYgdrLkZLpf93vpyhXVqYv5WMU9KpAhIMjpvmertNO0e6zylMa
         A9WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9wRW7TKueArBUfnnmbZEuYC3CJj8NI6TnvFxQoqEUT0=;
        b=qjvyFHxdEF3dFrhb21GFlvIN4PC7rISMCVKSpZBLTIz5tBlcEx1D/TQmqk7yqydGGk
         l4S3g381gYxnC2GGhATSJKPSjHQBjN9QWeNoWSlfsFcuc645hMSEW4oPO2aIxavnf2pB
         lAcbVol7NBn/8mQobpKSg3A9zipcFFQWnJuSp40mEAGC5obdZD+DPgh0pXR7U5R1pfmU
         18VvBLDlIisFpUuQmpcf/XhBiyGmVJVKfcTZQX0kOChZwE9IHSUPWtx9v6SYx2caWinu
         5fiDQWzgIpKWom0KoJUyQEDuYdEtKJOuDYf619PlBf10KoRDsobsXoSzbhzVspPOW7xe
         mG0g==
X-Gm-Message-State: AFqh2koV3+JE90vJptxhyUBsmKpT/Mqvmk7J2VmV1KgAdtHAD/+uRU3t
        XY65CyJMeZy3nbCM1EeN7ErNi5ANMxchWgNJVo7tmg==
X-Google-Smtp-Source: AMrXdXulvcqn/NRP4iH9vac6EaXPEKPPRWSKSTz2F5SIQeb7alwXkcTKKoAkkvl9ZqJaxCOXFKKZIINgT/H8rNkezn8=
X-Received: by 2002:a5d:4574:0:b0:272:859c:54fb with SMTP id
 a20-20020a5d4574000000b00272859c54fbmr604144wrc.355.1672159123482; Tue, 27
 Dec 2022 08:38:43 -0800 (PST)
MIME-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-35-jthoughton@google.com> <Y6X1isYeuZMxvDEC@x1n>
In-Reply-To: <Y6X1isYeuZMxvDEC@x1n>
From:   James Houghton <jthoughton@google.com>
Date:   Tue, 27 Dec 2022 11:38:31 -0500
Message-ID: <CADrL8HWfyaQVfcrqrT7Hzt3iHGXiVzNycfCFKpD=YK-YEAX-nA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 34/47] hugetlb: userfaultfd: add support for
 high-granularity UFFDIO_CONTINUE
To:     Peter Xu <peterx@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 1:38 PM Peter Xu <peterx@redhat.com> wrote:
>
> James,
>
> On Fri, Oct 21, 2022 at 04:36:50PM +0000, James Houghton wrote:
> > +     bool use_hgm = uffd_ctx_has_hgm(&dst_vma->vm_userfaultfd_ctx) &&
> > +             mode == MCOPY_ATOMIC_CONTINUE;
>
> Do you think in your new version use_hgm can work even for MISSING by
> default?

I don't think so -- UFFDIO_COPY will allocate a hugepage, so I'm not
sure if it makes sense to allow it at high-granularity. If UFFDIO_COPY
didn't allocate a new page, then it could make sense (maybe we'd need
a new ioctl or new UFFDIO_COPY mode?). I think it makes most sense to
add this with another series.

Thanks,
- James
