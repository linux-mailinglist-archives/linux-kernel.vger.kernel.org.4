Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4F367F18D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 23:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbjA0W5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 17:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjA0W5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 17:57:43 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9E6448F
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 14:57:42 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id nm12-20020a17090b19cc00b0022c2155cc0bso6085477pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 14:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uB+yn62SNGaWhnX+fqEdSTvlJtnDndypAJXkN5qE33U=;
        b=W4hO39Wk6cmIujhnDK3J/FU10QCBNOIGO5SGMgjELJaoGXcWYIvg/e30vUn6T+n+rk
         ymicSJsDr76lPqzMYQH1mxntDvtqfsScQ83wQXUtaFcVFrj5i+6HqBEmfI2JdcI2W8/e
         pC+ayUq3ohYQZPDEegGDT3NaaTFJsDeUcvyam9DYOBJo3izG+5BVsXP5gnJxq7xHDofE
         Pv4Sd5XT9oQHbmv8UVRvXXGeoCgb8DxQLP1wHUhE5Kb3nyRv1loeGNOCjccLP0GCVC0B
         Gg/YpZ6dP/w/AGr6lhHpmAkNe3TgF3CvA8Yipanu5GWTJQPXUFaslphav/lkhccA2VS5
         xvKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uB+yn62SNGaWhnX+fqEdSTvlJtnDndypAJXkN5qE33U=;
        b=rKwJCMb5eY6TZPv+CuVK1Gk6R3z5Y141IlzSmefTU7KHL9A3wlVjRE3donbhDtOiqF
         xdHS1Wx3GhoTY07UJu9gOQc56J1r79WNWbVybjMxidWL/43rCtG3AEOMZh31Xgi7+QXW
         LaCpoD8+1XD6+GFhgENMKhgWca1Z1SmyAWVN+/xtzkaZ27cPBMWRI55CovgJ48q7PZru
         ga9RKzs5b/oUrfvtREx/m2wefBxSfXmuzgbeyRDVtT7mezwrJHDqD90VjqCFGIT8DfHQ
         ykn5w+2llcJjOwsb2gu3WIfvgjxptt7SMI5NE0/BpCLPE00IWwC7fpPtxKjlttyDtOvn
         3NgA==
X-Gm-Message-State: AFqh2kqqiVLkB+FS3zsOIstxUK1BKrwbc6Flow1je2vgBVX3QnjkZPv7
        lynNRsh0qLNpP1AROdg/PEuU7TCVZcSD61EJ6EcB
X-Google-Smtp-Source: AMrXdXvBKpJ1Zh1gYfC1P8Jx+VUDzIcL3XGdMGBkNJZMGwWSnIhw3xeRWsJ5AA7DB//+NWwRLAK8EKPx7NzFn5qakDM=
X-Received: by 2002:a17:90b:3903:b0:225:de08:b714 with SMTP id
 ob3-20020a17090b390300b00225de08b714mr5014603pjb.193.1674860261791; Fri, 27
 Jan 2023 14:57:41 -0800 (PST)
MIME-Version: 1.0
References: <cover.1674682056.git.rgb@redhat.com> <68eb0c2dd50bca1af91203669f7f1f8312331f38.1674682056.git.rgb@redhat.com>
 <CAHC9VhSZNGs+SQU7WCD+ObMcwv-=1ZkBts8oHn40qWsQ=n0pXA@mail.gmail.com> <6d3f76ae-9f86-a96e-d540-cfd45475e288@kernel.dk>
In-Reply-To: <6d3f76ae-9f86-a96e-d540-cfd45475e288@kernel.dk>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 27 Jan 2023 17:57:30 -0500
Message-ID: <CAHC9VhSfG6Oddk3qeFYiwkE5orRKs_PCLAD+F0yK-fRx27UTwg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] io_uring,audit: audit IORING_OP_FADVISE but not IORING_OP_MADVISE
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Richard Guy Briggs <rgb@redhat.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, io-uring@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>, Stefan Roesch <shr@fb.com>,
        Christian Brauner <brauner@kernel.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 5:45 PM Jens Axboe <axboe@kernel.dk> wrote:
> On 1/27/23 3:35?PM, Paul Moore wrote:
> > On Fri, Jan 27, 2023 at 12:24 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> >>
> >> Since FADVISE can truncate files and MADVISE operates on memory, reverse
> >> the audit_skip tags.
> >>
> >> Fixes: 5bd2182d58e9 ("audit,io_uring,io-wq: add some basic audit support to io_uring")
> >> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> >> ---
> >>  io_uring/opdef.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/io_uring/opdef.c b/io_uring/opdef.c
> >> index 3aa0d65c50e3..a2bf53b4a38a 100644
> >> --- a/io_uring/opdef.c
> >> +++ b/io_uring/opdef.c
> >> @@ -306,12 +306,12 @@ const struct io_op_def io_op_defs[] = {
> >>         },
> >>         [IORING_OP_FADVISE] = {
> >>                 .needs_file             = 1,
> >> -               .audit_skip             = 1,
> >>                 .name                   = "FADVISE",
> >>                 .prep                   = io_fadvise_prep,
> >>                 .issue                  = io_fadvise,
> >>         },
> >
> > I've never used posix_fadvise() or the associated fadvise64*()
> > syscalls, but from quickly reading the manpages and the
> > generic_fadvise() function in the kernel I'm missing where the fadvise
> > family of functions could be used to truncate a file, can you show me
> > where this happens?  The closest I can see is the manipulation of the
> > page cache, but that shouldn't actually modify the file ... right?
>
> Yeah, honestly not sure where that came from. Maybe it's being mixed up
> with fallocate?

That was my thought too when I was looking at it.

> All fadvise (or madvise, for that matter) does is
> provide hints on the caching or access pattern. On second thought, both
> of these should be able to set audit_skip as far as I can tell.

Agreed on the fadvise side, and probably the madvise side too,
although the latter has more options/code to sift through so I'm
curious to hear what analysis Richard has done on that one.

-- 
paul-moore.com
