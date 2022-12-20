Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A026522A2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 15:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233669AbiLTOcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 09:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233963AbiLTObv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 09:31:51 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604DA1C125
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 06:31:50 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id i20so11011085qtw.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 06:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T/NCsYKC04yFcK1fgm0juUVbSixz96HJYgI6+8cFKck=;
        b=aW5RhtAsBkNvIR682pacJYjMBchjsl6CBpgm1GNt+MoU0xR7oZIbXklJVEhSA5imlQ
         5u50ol+9QlNXecXRFfrW9BlWpiEgwr54V46RQJ7vPMFVZN8nUM7UL5cjfEyDNsEd6TlT
         I+s90R9sBzg5F4fXqzDg5UVxzzA1ZnYyjdfck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T/NCsYKC04yFcK1fgm0juUVbSixz96HJYgI6+8cFKck=;
        b=U08ljPEwrZBmz3a5FyMFGOQeMwzO7zj0gzNnC35JmA9zl1BgXJg51hdmwWo+f5ta4X
         DH0WhvOBBhaaC9SaVhGAi1Bdk/SN7l09KVXDsm8yDeHx2SD6QqbajlZ4Hw3Og+TgqjFM
         75YHYM6G3ZESAn843v+ekEPghvqBsD7hfITzLyE/geUNGPDMhlkwbPPNzA8bQCkUUq0U
         3OJxb5AO117Ur1wM7Vj1vY/D3dJ1wmmoVgqAH8OTt19vV35eBx5Jd8xncngz96XjDdza
         j7guQQGuq2YMT40jn/7jNDhW3Hb0JJ2qeJSlDwSg5OJodJpHb0FYMWl1d/NHv5VFwAL1
         D7Aw==
X-Gm-Message-State: AFqh2krTHwaA2BXoyrL3kOftBvDG4vsw6zHIeZ23gT8n7ZsLQYVXeetn
        VHQD3OXJQ2zz2sptasaIyErNQcr1uJVyJon4
X-Google-Smtp-Source: AMrXdXsCRj9Pmxa5q2umb+Blj/7/hNErZHQ7myf5yb/YoY1+jH8v5DtW9mHsbf20O2C/lJiX+cNp1Q==
X-Received: by 2002:a05:622a:5987:b0:3a9:80b3:435f with SMTP id gb7-20020a05622a598700b003a980b3435fmr17831014qtb.12.1671546707254;
        Tue, 20 Dec 2022 06:31:47 -0800 (PST)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com. [209.85.222.182])
        by smtp.gmail.com with ESMTPSA id v23-20020ac87497000000b003a689a5b177sm7698886qtq.8.2022.12.20.06.31.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 06:31:46 -0800 (PST)
Received: by mail-qk1-f182.google.com with SMTP id f28so5324161qkh.10
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 06:31:46 -0800 (PST)
X-Received: by 2002:ac8:4988:0:b0:3a7:ef7b:6aa5 with SMTP id
 f8-20020ac84988000000b003a7ef7b6aa5mr8424356qtq.436.1671546695878; Tue, 20
 Dec 2022 06:31:35 -0800 (PST)
MIME-Version: 1.0
References: <20221219153525.632521981@infradead.org> <20221219154119.154045458@infradead.org>
 <Y6DEfQXymYVgL3oJ@boqun-archlinux> <Y6GXoO4qmH9OIZ5Q@hirez.programming.kicks-ass.net>
In-Reply-To: <Y6GXoO4qmH9OIZ5Q@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 20 Dec 2022 08:31:19 -0600
X-Gmail-Original-Message-ID: <CAHk-=wi493ukLwziiqofe=WCSfUU8Qa+LK0mp_GrGWKV3NnTpQ@mail.gmail.com>
Message-ID: <CAHk-=wi493ukLwziiqofe=WCSfUU8Qa+LK0mp_GrGWKV3NnTpQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 05/12] arch: Introduce arch_{,try_}_cmpxchg128{,_local}()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>, corbet@lwn.net, will@kernel.org,
        mark.rutland@arm.com, catalin.marinas@arm.com, dennis@kernel.org,
        tj@kernel.org, cl@linux.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, Herbert Xu <herbert@gondor.apana.org.au>,
        davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, joro@8bytes.org, suravee.suthikulpanit@amd.com,
        robin.murphy@arm.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux.dev,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 5:09 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Dec 19, 2022 at 12:07:25PM -0800, Boqun Feng wrote:
> >
> > I wonder whether we should use "(*(u128 *)ptr)" instead of "(*(unsigned
> > long *) ptr)"? Because compilers may think only 64bit value pointed by
> > "ptr" gets modified, and they are allowed to do "useful" optimization.
>
> In this I've copied the existing cmpxchg_double() code; I'll have to let
> the arch folks speak here, I've no clue.

It does sound like the right thing to do. I doubt it ends up making a
difference in practice, but yes, the asm doesn't have a memory
clobber, so the input/output types should be the right ones for the
compiler to not possibly do something odd and cache the part that it
doesn't see as being accessed.

              Linus
