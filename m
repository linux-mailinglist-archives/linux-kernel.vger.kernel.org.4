Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E3B653865
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 23:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234910AbiLUWLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 17:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbiLUWLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 17:11:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B002D20BCB
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 14:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671660616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ORMXOrE1l1VFBUbc91N+Gve8/Alb8MwMqSdeSP/tL+U=;
        b=J2kP9MftNwuJvOS6nSvQvO8NIPlcBze4k3CgztO7WyGpUdGc78AVCEToYh2VfzIEHiYgjW
        A9406gPsWg9d6vpNcQW6qppYpocbpEwjKrTmYIMAXzg1/qI7W2ZY9DtfhKkXLpbxt+6s+1
        8EaV0kVL2HfUJn9t6Aa2bxpLM5xc0Hk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-500-T8MmxfNZMKyDoAKQrbpEQg-1; Wed, 21 Dec 2022 17:10:15 -0500
X-MC-Unique: T8MmxfNZMKyDoAKQrbpEQg-1
Received: by mail-qk1-f200.google.com with SMTP id br6-20020a05620a460600b007021e1a5c48so59740qkb.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 14:10:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ORMXOrE1l1VFBUbc91N+Gve8/Alb8MwMqSdeSP/tL+U=;
        b=T2HpBaMGXcpRt1+RZgFc5udT6j+9BrKd1YJMZMy+qsjEozfWWTC0rTQWNBvzRZi8TJ
         0pt5kL+k+CQj9+tyeU6A6WH6cbtDBRQwbjQSGKMO5S+VPW/0bEI5mks0lToRZcUpqdQ7
         PY9Jawcd0I4xdr7LgZsiPm2S3TfTG0cqsv4OX1daPnLOmjGDqAINWqCzpqEGzZa4+lDI
         2wJzUA63Szzs9lzaJWnsBCWU389/Twwx/EvapsEmub4DLzCiiMlSp/TuxHXtEv0vTN9Y
         tBfif6WWlOGBWhxjtpAEbpmlx8iq5tT6BFLhJjg54FjnuKLwX0K3a3DuPJW/86Ws/EZO
         bssw==
X-Gm-Message-State: AFqh2ko+/MdoVtCgSO8fcVeKynKmEhR/kIMAvo+r9jXHQ6hW5BTTTmOT
        fKkIGW0o6lVJC/brgLq+eu5rcUsyow8VKrX3WM67Hiy2MGqIfEDx1D/kmlFXMWXEq47TbvZq8HO
        OVCgfLJAizUW9t/iyFAJmx/sA
X-Received: by 2002:ac8:7cac:0:b0:39c:da20:f6fa with SMTP id z12-20020ac87cac000000b0039cda20f6famr3918708qtv.30.1671660615211;
        Wed, 21 Dec 2022 14:10:15 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuiChcPtVLLjnoHJts1l6KsMm9wbb31b+CZVUw3o/igzqAZt7k+3UmeG2KkES3KSt1Vbcigfw==
X-Received: by 2002:ac8:7cac:0:b0:39c:da20:f6fa with SMTP id z12-20020ac87cac000000b0039cda20f6famr3918682qtv.30.1671660614937;
        Wed, 21 Dec 2022 14:10:14 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-45-70-31-26-132.dsl.bell.ca. [70.31.26.132])
        by smtp.gmail.com with ESMTPSA id q28-20020a05620a2a5c00b006f7ee901674sm11970353qkp.2.2022.12.21.14.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 14:10:14 -0800 (PST)
Date:   Wed, 21 Dec 2022 17:10:08 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     James Houghton <jthoughton@google.com>,
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
Subject: Re: [RFC PATCH v2 33/47] userfaultfd: add
 UFFD_FEATURE_MINOR_HUGETLBFS_HGM
Message-ID: <Y6OEQB3dLSa083F6@x1n>
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-34-jthoughton@google.com>
 <Y3VkIdVKRuq+fO0N@x1n>
 <CADrL8HXixUPyTVmYMiwc11Ot5sDMsA3x7VhgXQjimJ93MSZihA@mail.gmail.com>
 <Y6NdN2ADVCcK70ym@x1n>
 <CADrL8HXqE3s4ckxh0OU5onkhystj=1jMTS+S7GFeiO+kwBo0QQ@mail.gmail.com>
 <Y6N9G0Y2j98V8Pnz@monkey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y6N9G0Y2j98V8Pnz@monkey>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 01:39:39PM -0800, Mike Kravetz wrote:
> On 12/21/22 15:21, James Houghton wrote:
> > On Wed, Dec 21, 2022 at 2:23 PM Peter Xu <peterx@redhat.com> wrote:
> > >
> > > James,
> > >
> > > On Wed, Nov 16, 2022 at 03:30:00PM -0800, James Houghton wrote:
> > > > On Wed, Nov 16, 2022 at 2:28 PM Peter Xu <peterx@redhat.com> wrote:
> > > > >
> > > > > On Fri, Oct 21, 2022 at 04:36:49PM +0000, James Houghton wrote:
> > > > > > Userspace must provide this new feature when it calls UFFDIO_API to
> > > > > > enable HGM. Userspace can check if the feature exists in
> > > > > > uffdio_api.features, and if it does not exist, the kernel does not
> > > > > > support and therefore did not enable HGM.
> > > > > >
> > > > > > Signed-off-by: James Houghton <jthoughton@google.com>
> > > > >
> > > > > It's still slightly a pity that this can only be enabled by an uffd context
> > > > > plus a minor fault, so generic hugetlb users cannot directly leverage this.
> > > >
> > > > The idea here is that, for applications that can conceivably benefit
> > > > from HGM, we have a mechanism for enabling it for that application. So
> > > > this patch creates that mechanism for userfaultfd/UFFDIO_CONTINUE. I
> > > > prefer this approach over something more general like MADV_ENABLE_HGM
> > > > or something.
> > >
> > > Sorry to get back to this very late - I know this has been discussed since
> > > the very early stage of the feature, but is there any reasoning behind?
> > >
> > > When I start to think seriously on applying this to process snapshot with
> > > uffd-wp I found that the minor mode trick won't easily play - normally
> > > that's a case where all the pages were there mapped huge, but when the app
> > > wants UFFDIO_WRITEPROTECT it may want to remap the huge pages into smaller
> > > pages, probably some size that the user can specify.  It'll be non-trivial
> > > to enable HGM during that phase using MINOR mode because in that case the
> > > pages are all mapped.
> > >
> > > For the long term, I am just still worried the current interface is still
> > > not as flexible.
> > 
> > Thanks for bringing this up, Peter. I think the main reason was:
> > having separate UFFD_FEATUREs clearly indicates to userspace what is
> > and is not supported.
> 
> IIRC, I think we wanted to initially limit the usage to the very
> specific use case (live migration).  The idea is that we could then
> expand usage as more use cases came to light.
> 
> Another good thing is that userfaultfd has versioning built into the
> API.  Thus a user can determine if HGM is enabled in their running
> kernel.

I don't worry much on this one, afaiu if we have any way to enable hgm then
the user can just try enabling it on a test vma, just like when an app
wants to detect whether a new madvise() is present on the current host OS.

Besides, I'm wondering whether something like /sys/kernel/vm/hugepages/hgm
would work too.

> 
> > For UFFDIO_WRITEPROTECT, a user could remap huge pages into smaller
> > pages by issuing a high-granularity UFFDIO_WRITEPROTECT. That isn't
> > allowed as of this patch series, but it could be allowed in the
> > future. To add support in the same way as this series, we would add
> > another feature, say UFFD_FEATURE_WP_HUGETLBFS_HGM. I agree that
> > having to add another feature isn't great; is this what you're
> > concerned about?
> > 
> > Considering MADV_ENABLE_HUGETLB...
> > 1. If a user provides this, then the contract becomes: "the kernel may
> > allow UFFDIO_CONTINUE and UFFDIO_WRITEPROTECT for HugeTLB at
> > high-granularities, provided the support exists", but it becomes
> > unclear to userspace to know what's supported and what isn't.
> > 2. We would then need to keep track if a user explicitly enabled it,
> > or if it got enabled automatically in response to memory poison, for
> > example. Not a big problem, just a complication. (Otherwise, if HGM
> > got enabled for poison, suddenly userspace would be allowed to do
> > things it wasn't allowed to do before.)

We could alternatively have two flags for each vma: (a) hgm_advised and (b)
hgm_enabled.  (a) always sets (b) but not vice versa.  We can limit poison
to set (b) only.  For this patchset, it can be all about (a).

> > 3. This API makes sense for enabling HGM for something outside of
> > userfaultfd, like MADV_DONTNEED.
> 
> I think #3 is key here.  Once we start applying HGM to things outside
> userfaultfd, then more thought will be required on APIs.  The API is
> somewhat limited by design until the basic functionality is in place.

Mike, could you elaborate what's the major concern of having hgm used
outside uffd and live migration use cases?

I feel like I miss something here.  I can understand we want to limit the
usage only when the user specifies using hgm because we want to keep the
old behavior intact.  However if we want another way to enable hgm it'll
still need one knob anyway even outside uffd, and I thought that'll service
the same purpose, or maybe not?

Thanks,

-- 
Peter Xu

