Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163CE65F4D3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 20:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235756AbjAETwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 14:52:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjAETwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:52:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AA117E1E
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 11:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672948277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EjbjzkivdEfdQKhJnMwtYL1o8m0WmVhHe3G0I/dzTrU=;
        b=eY62/ajW/jPpn6FzCZfbZ7Jzjp70ueoaTgJZnKPkYr6tTNtE+7ZhmRe9DKsJ1bJvc6jxSd
        fgjrsKYe5aitSGKfi+rwlpWSHeLhddRqKxcaAJJw7E0w9zjrSBnQHrsqATcd7hG9yb7vFV
        UmmVPAdZXiSiQjQ8oYk1LXfJC2OQUlY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-612-tnZhA61vPYiLUQZkVb7Bfw-1; Thu, 05 Jan 2023 14:51:15 -0500
X-MC-Unique: tnZhA61vPYiLUQZkVb7Bfw-1
Received: by mail-qt1-f200.google.com with SMTP id y24-20020ac85258000000b003ab503f2b28so13455493qtn.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 11:51:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EjbjzkivdEfdQKhJnMwtYL1o8m0WmVhHe3G0I/dzTrU=;
        b=yvuTTgckaGQBl02sZEAOwAyg4cKJBPSWCsME2solYNtESx+C1NfTJK5yQCr5R4ddJJ
         shxyfyYm5+m/HyhnXmmQFeCncSltAtEJox6ovFU+uBEW86ZyyFgHfhyAvE7qYdC3p/eh
         qg8cahr1rHiR6Ek9MciESWSgYazIPx3kMj3fS7n0FO8OmME3htOLxbywVqx2UyIYlVfZ
         hvyjmFWAlhpQPp1rn7qm7qMDO9A+ooBEiulgOn9tNteYdj4YbScu+VMPHn2IGQqLGjM0
         YakoL7skyy2lAXStVCNaM6cJ5Tr6ESplTBipClzwDeNqmHV2X/4Kb4s1wN9L/TDfb4WE
         1i0w==
X-Gm-Message-State: AFqh2kqjLYkdKtfHmrvzJhsRUG1L9miu33SxZp9umNPBf/Ypm2Qa45eB
        63tUU/V5D/vH4egGJAnGRiLgKR9WCmCFG/1M3aeU7H3UuQHwGblConojeHSyvQseXkYNK72WpJC
        WIuPyYEfBEUjKKog+he0DgrXp
X-Received: by 2002:ac8:6f19:0:b0:3a9:84bd:7cc5 with SMTP id bs25-20020ac86f19000000b003a984bd7cc5mr80496271qtb.39.1672948275478;
        Thu, 05 Jan 2023 11:51:15 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvi5sWv8T/L86iB8C2dAti4v5sfdzxgjfhkQOp4LUK/7nJYD9pvHXMQ/BDPXf6/gLbgU1d1qw==
X-Received: by 2002:ac8:6f19:0:b0:3a9:84bd:7cc5 with SMTP id bs25-20020ac86f19000000b003a984bd7cc5mr80496251qtb.39.1672948275210;
        Thu, 05 Jan 2023 11:51:15 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-39-70-52-228-144.dsl.bell.ca. [70.52.228.144])
        by smtp.gmail.com with ESMTPSA id v7-20020a05620a0f0700b006faf76e7c9asm26204357qkl.115.2023.01.05.11.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 11:51:14 -0800 (PST)
Date:   Thu, 5 Jan 2023 14:51:13 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/3] mm/uffd: Detect pgtable allocation failures
Message-ID: <Y7cqMeTGSjsOPQ09@x1n>
References: <20230104225207.1066932-1-peterx@redhat.com>
 <20230104225207.1066932-4-peterx@redhat.com>
 <AF984D5D-DC66-4FD3-A749-5AF6B7289E0D@gmail.com>
 <cc6e17ad-1afd-5c52-a06e-1d89d1978368@redhat.com>
 <B38AB79D-51D7-4F1A-A5CB-A60A46A3E27F@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B38AB79D-51D7-4F1A-A5CB-A60A46A3E27F@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 10:01:46AM -0800, Nadav Amit wrote:
> 
> 
> > On Jan 5, 2023, at 12:59 AM, David Hildenbrand <david@redhat.com> wrote:
> > 
> > On 05.01.23 04:10, Nadav Amit wrote:
> >>> On Jan 4, 2023, at 2:52 PM, Peter Xu <peterx@redhat.com> wrote:
> >>> 
> >>> Before this patch, when there's any pgtable allocation issues happened
> >>> during change_protection(), the error will be ignored from the syscall.
> >>> For shmem, there will be an error dumped into the host dmesg.  Two issues
> >>> with that:
> >>> 
> >>>  (1) Doing a trace dump when allocation fails is not anything close to
> >>>      grace..
> >>> 
> >>>  (2) The user should be notified with any kind of such error, so the user
> >>>      can trap it and decide what to do next, either by retrying, or stop
> >>>      the process properly, or anything else.
> >>> 
> >>> For userfault users, this will change the API of UFFDIO_WRITEPROTECT when
> >>> pgtable allocation failure happened.  It should not normally break anyone,
> >>> though.  If it breaks, then in good ways.
> >>> 
> >>> One man-page update will be on the way to introduce the new -ENOMEM for
> >>> UFFDIO_WRITEPROTECT.  Not marking stable so we keep the old behavior on the
> >>> 5.19-till-now kernels.
> >> I understand that the current assumption is that change_protection() should
> >> fully succeed or fail, and I guess this is the current behavior.
> >> However, to be more “future-proof” perhaps this needs to be revisited.
> >> For instance, UFFDIO_WRITEPROTECT can benefit from the ability to (based on
> >> userspace request) prevent write-protection of pages that are pinned. This is
> >> necessary to allow userspace uffd monitor to avoid write-protection of
> >> O_DIRECT’d memory, for instance, that might change even if a uffd monitor
> >> considers it write-protected.
> > 
> > Just a note that this is pretty tricky IMHO, because:
> > 
> > a) We cannot distinguished "pinned readable" from "pinned writable"
> > b) We can have false positives ("pinned") even for compound pages due to
> >   concurrent GUP-fast.
> > c) Synchronizing against GUP-fast is pretty tricky ... as we learned.
> >   Concurrent pinning is usually problematic.
> > d) O_DIRECT still uses FOLL_GET and we cannot identify that. (at least
> >   that should be figured out at one point)
> 
> My prototype used the page-count IIRC, so it had false-positives (but
> addressed O_DIRECT).

I think this means the app is fine to not be able to write protect some
page being requested?  For a swap framework I think it's fine, but maybe
not for taking a snapshot, so I agree it should be an optional flag as you
mentioned below.

> And yes, precise refinement is complicated. However,
> if you need to uffd-wp memory, then without such a mechanism you need to
> ensure no kerenl/DMA write to these pages is possible. The only other
> option I can think of is interposing/seccomp on a variety of syscalls,
> to prevent uffd-wp of such memory.
> 
> > 
> > I have a patch lying around for a very long time that removes that special-pinned handling from softdirty code, because of the above reasons (and because it forgets THP). For now I didn't send it because for softdirty, it's acceptable to over-indicate and it hasn't been reported to be an actual problem so far.
> > 
> > For existing UFFDIO_WRITEPROTECT users, however, it might be very harmful (especially for existing users) to get false protection errors. Failing due to ENOMEM is different to failing due to some temporary concurrency issues.
> 
> Yes, I propose it as an optional flag for UFFD-WP.
> Anyhow, I believe the UFFD-WP as implemented now is not efficient and
> should’ve been vectored to allow one TLB shootdown for many
> non-consecutive pages.

Agreed.  Would providing a vector of ranges help too for a few uffd ioctls?

I'm also curious whether you're still actively developing (or running) your
iouring series.

> 
> > 
> > Having that said, I started thinking about alternative ways of detecting that in that past, without much outcome so far: that latest idea was indicating "this MM has had pinned pages at one point, be careful because any techniques that use write-protection (softdirty, mprotect, uffd-wp) won't be able to catch writes via pinned pages reliably".
> 
> I am not sure what the best way to detect that a page is write-pinned
> reliably. My point was that if a change is already carried to
> write-protect mechanisms, then this issue should be considered. Because
> otherwise, many use-cases of uffd-wp would encounter implementation
> issues.
> 
> I will not “kill” myself over it now, but I think it worth consideration.

The current interface change is small and limited only to the extra -ENOMEM
retval with memory pressures (personally I don't really know how to trigger
this, as I never succeeded myself even with memory pressure..).  What you
said does sound like a new area to explore, and I think it's fine to change
the interface again.

Thanks,

-- 
Peter Xu

