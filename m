Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76148677224
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 20:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjAVTx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 14:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjAVTx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 14:53:27 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CED0FF0B
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 11:53:26 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id z12so4025374qvn.12
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 11:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ctP10EJhYVqp3z/JqewEFMYB9962mKik31Egc7xVVsA=;
        b=Rn/RqTN+UfGRkoXXBJUiiQ0VPKaSTWcruxokqyC3rqO3RTSKRu12ykm5/VACEyhGeQ
         Xbhj2TFtlMqT9DRUSG4gNVRZTVjMDWKNJKY8d25BsHzHwRMsHzyxhlqyniFNxQAbRw/r
         fk7r/Nws+N4WsOGCYZEgqS28EzgadmC0yFBaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ctP10EJhYVqp3z/JqewEFMYB9962mKik31Egc7xVVsA=;
        b=PDB8bx1qz0wK9UX7QTj7CJMtXCaHWsKKrc+PDcEx8v2uhP5pPZWRsZyV6B7sWUllcb
         dj8SC86URE9K0Uvf3gb25VwfyR+BbHDQBqu/nuIiDoGAqcN2+3YbuFGrRWaHJOUkSEBi
         klreP4W0SOT0aCaiwwHWHKgsLXwwVPONEzSU2IQ6oTBUUbBCR2wNLr9+VJLdcW48aRY0
         t8El4iJnb7SbYXdFTI6apAAD3ROi+vDCZaw69mkMVMUl1ZYlyfMrZ2sMgwTyb1Tgpb/z
         TQD81FFlDlgCNBGoTU6piWghFjs115c7vgmKef0v5mHP0CNxnqM/ubD3V3ar5op2TnJq
         b3uQ==
X-Gm-Message-State: AFqh2koTkJWbI8N1QsjGLZuKlft23ULcD8Gy53m/rctsOGtoJKxyno+L
        FaI1ZLD8//MuCr6WgZlp1JhDob/N4ak4l8VJ
X-Google-Smtp-Source: AMrXdXvbIoTbjzgT3fsHSv2IaTr4BUICpSnmfAbgJNi2qk0GvrSSIgQjjGgNpY04ULmuG5UEFSLJOA==
X-Received: by 2002:a0c:f74b:0:b0:532:31c1:6655 with SMTP id e11-20020a0cf74b000000b0053231c16655mr33128308qvo.20.1674417205343;
        Sun, 22 Jan 2023 11:53:25 -0800 (PST)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com. [209.85.222.178])
        by smtp.gmail.com with ESMTPSA id bi26-20020a05620a319a00b00706a1551408sm10712384qkb.4.2023.01.22.11.53.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Jan 2023 11:53:24 -0800 (PST)
Received: by mail-qk1-f178.google.com with SMTP id z9so5380602qkl.13
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 11:53:24 -0800 (PST)
X-Received: by 2002:a05:620a:99d:b0:705:efa8:524c with SMTP id
 x29-20020a05620a099d00b00705efa8524cmr1088535qkx.594.1674417203910; Sun, 22
 Jan 2023 11:53:23 -0800 (PST)
MIME-Version: 1.0
References: <00000000000075a52e05ee97ad74@google.com> <0000000000006e58cb05f2d86236@google.com>
In-Reply-To: <0000000000006e58cb05f2d86236@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 22 Jan 2023 11:53:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=whJ0Rya9++f5B=6euHxRGRKOYNZARxN7bZb61RmOHGnFA@mail.gmail.com>
Message-ID: <CAHk-=whJ0Rya9++f5B=6euHxRGRKOYNZARxN7bZb61RmOHGnFA@mail.gmail.com>
Subject: Re: [syzbot] [btrfs?] WARNING: kmalloc bug in btrfs_ioctl_send
To:     syzbot <syzbot+4376a9a073770c173269@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, clm@fb.com, dsterba@suse.com,
        dsterba@suse.cz, josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, w@1wt.eu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 22, 2023 at 3:14 AM syzbot
<syzbot+4376a9a073770c173269@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this issue to:
>
> commit 7661809d493b426e979f39ab512e3adf41fbcc69
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Wed Jul 14 16:45:49 2021 +0000
>
>     mm: don't allow oversized kvmalloc() calls

Heh. I assume this is the

        sctx->clone_roots = kvcalloc(sizeof(*sctx->clone_roots),
                                     arg->clone_sources_count + 1,
                                     GFP_KERNEL);

in btrfs_ioctl_send(), where the 'clone_sources_count' thing is
basically just an argument to the btrfs ioctl, and user space can set
it to anything it damn well likes.

So that warning is very much correct, and the problem is that the code
doesn't do any  realsanity checking at all on the ioctl arguments, and
basically allows the code to exhaust all memory.

Ok, there's a sanity check in the form of an overflow check:

        /*
         * Check that we don't overflow at later allocations, we request
         * clone_sources_count + 1 items, and compare to unsigned long inside
         * access_ok.
         */
        if (arg->clone_sources_count >
            ULONG_MAX / sizeof(struct clone_root) - 1) {
                ret = -EINVAL;
                goto out;
        }

but ULONG_MAX is a *lot* of memory that the btrfs code is happy to try
to allocate.

This ioctl does seem to be protected by a

        if (!capable(CAP_SYS_ADMIN))
                return -EPERM;

so at least it wasn't some kind of "random user can use up all memory".

I suspect the simplest way to make syzbot happy is to change the

        if (arg->clone_sources_count >
            ULONG_MAX / sizeof(struct clone_root) - 1) {

test to use INT_MAX instead of ULONG_MAX, which will then match the
vmalloc sanity check and avoid the warning.

But maybe an even smaller value might be more domain-appropriate here?

             Linus
