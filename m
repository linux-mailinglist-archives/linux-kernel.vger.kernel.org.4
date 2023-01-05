Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022E165E343
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 04:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjAEDLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 22:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjAEDLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 22:11:11 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F90D4859C
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 19:11:09 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d3so38069561plr.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 19:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EhKOVmA3EBsLDZIpg+LUE1FOA36aPnSUta95vtXcQOY=;
        b=OxEV44QkKErjVtsimElo3qpQaBH1f02WauiAcJmvb8lri8HwZ7EchFdf0u/vHAtPEz
         anqM0JAYJ1d0bkDkgfBDVOeduFOA+OoJ+0DSnuMhjRUixk9lfk2iOcsv0U4J6jkCESRC
         eN8AWb2FnW0isvYdpuKUhNRLbDJRwLy7Qv33GFEjhVmIVhXYgRZCUQsKEAl96K6+/924
         qIhrsQohKGcqYAJ3fdmR7+eLq0106rtq0tLU8Q0uHqsQvt0mLxrsIErQQhWw13Kg7pOG
         PxC8fLe/yG8zLAC4kr0+cRlU/nTJepUhe+XPAgv2InF4oBjCo0ni48pclNhWxLEiYmqk
         Kj7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EhKOVmA3EBsLDZIpg+LUE1FOA36aPnSUta95vtXcQOY=;
        b=YwRT5T1W0WeGIixe1U05XW/If6r/odAelfht9+mB0rXji64eURgv0mVutehQr4clsy
         RNsNWmxezbpE779hFPXILyMQMkS03mw+2aIxwIrEWmF11N0WYEHbHl8zusES2/ga4+RB
         Fo6NvB7kxvjhrZ/IU+QFGE6cLxDCIHBEs/MtjbNpjDljwdtmZbI7d4xYym8KGmRxiFqw
         W8D+YLic3E5alOQxL/N05/bgLsoN1La1c/W2zPByO4txBCPikmO0aLddYrJR0HVMNaAm
         wLM0EPjB6CxE409FoNm+LfIpZFJy+AUG9tJpK32sqYEAU3xPz3T0fI6SglNMd1kAAVfa
         d/HA==
X-Gm-Message-State: AFqh2kroWoRz5LTqMYjXaJ9CwZgwnSbFjb0dd4VybfImU81W53i4uqHj
        Hv9iucsgTHkgQRsv9Xtq3UY=
X-Google-Smtp-Source: AMrXdXs4jN8eae84oxkgcbJGUfq9GpWzVW03+YqYS2l2u5I5rsBv//1OWluuxwOQ/W5MwjTOV40Ghw==
X-Received: by 2002:a17:902:d491:b0:192:ad82:dc98 with SMTP id c17-20020a170902d49100b00192ad82dc98mr29305954plg.34.1672888268269;
        Wed, 04 Jan 2023 19:11:08 -0800 (PST)
Received: from smtpclient.apple ([66.170.99.95])
        by smtp.gmail.com with ESMTPSA id e7-20020a17090301c700b00186c3af9644sm24914159plh.273.2023.01.04.19.11.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jan 2023 19:11:07 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [PATCH 3/3] mm/uffd: Detect pgtable allocation failures
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20230104225207.1066932-4-peterx@redhat.com>
Date:   Wed, 4 Jan 2023 19:10:55 -0800
Cc:     Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <AF984D5D-DC66-4FD3-A749-5AF6B7289E0D@gmail.com>
References: <20230104225207.1066932-1-peterx@redhat.com>
 <20230104225207.1066932-4-peterx@redhat.com>
To:     Peter Xu <peterx@redhat.com>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Jan 4, 2023, at 2:52 PM, Peter Xu <peterx@redhat.com> wrote:
>=20
> Before this patch, when there's any pgtable allocation issues happened
> during change_protection(), the error will be ignored from the =
syscall.
> For shmem, there will be an error dumped into the host dmesg.  Two =
issues
> with that:
>=20
>  (1) Doing a trace dump when allocation fails is not anything close to
>      grace..
>=20
>  (2) The user should be notified with any kind of such error, so the =
user
>      can trap it and decide what to do next, either by retrying, or =
stop
>      the process properly, or anything else.
>=20
> For userfault users, this will change the API of UFFDIO_WRITEPROTECT =
when
> pgtable allocation failure happened.  It should not normally break =
anyone,
> though.  If it breaks, then in good ways.
>=20
> One man-page update will be on the way to introduce the new -ENOMEM =
for
> UFFDIO_WRITEPROTECT.  Not marking stable so we keep the old behavior =
on the
> 5.19-till-now kernels.

I understand that the current assumption is that change_protection() =
should
fully succeed or fail, and I guess this is the current behavior.

However, to be more =E2=80=9Cfuture-proof=E2=80=9D perhaps this needs to =
be revisited.

For instance, UFFDIO_WRITEPROTECT can benefit from the ability to (based =
on
userspace request) prevent write-protection of pages that are pinned. =
This is
necessary to allow userspace uffd monitor to avoid write-protection of
O_DIRECT=E2=80=99d memory, for instance, that might change even if a =
uffd monitor
considers it write-protected.

In such a case, a =E2=80=9Cpartial failure=E2=80=9D is possible, since =
only part of the memory
was write-protected. The uffd monitor should be allowed to continue
execution, but it has to know the part of the memory that was =
successfully
write-protected.=20

To support =E2=80=9Cpartial failure=E2=80=9D, the kernel should return =
to
UFFDIO_WRITEPROTECT-users the number of pages/bytes that were not
successfully write-protected, unless no memory was successfully
write-protected. (Unlike NUMA, pages that were skipped should be =
accounted
as =E2=80=9Csuccessfully write-protected").=20

I am only raising this subject to avoid multiple API changes.

