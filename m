Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA7474400E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 18:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbjF3QrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 12:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbjF3QrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 12:47:02 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0653C01
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:46:59 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b6a1fe5845so32643741fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688143618; x=1690735618;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sYWz+2+v0oWfMG7VOE8sajye5qUMu35LIpd38kZpYk4=;
        b=bE7AM12LzqFtQydt+UMBpdsl/D7OThQhEDvxHSgy4Y99IiBMNaWCq/5iTk3EZQH1NG
         xBQUEDlDuz7pPAdHmHLJnXU0YpY08GpSc+Bg+bHCisWYhFjOjJF3TP092RbotfvyB10+
         Uf/ICMbczWGwMd79Sy9q4ZC1tXR8hyvKJKcQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688143618; x=1690735618;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sYWz+2+v0oWfMG7VOE8sajye5qUMu35LIpd38kZpYk4=;
        b=PfYn/WugZspd/kr3cVnQuWBULG+56IPTZ3Pjgph3EHUsoW9JCsw82b/hqX8iOzSG5x
         mltkSbi4PaDh14s4E4AxPkGRKVQx0w6ai0hOCMyEKIktk71TBrR8vurvVBmUXO9MDM9Y
         ugEnbbPXi1IRccRfK2qgjQGKC/iBZYVjyh7zec9ImLUA/qTaDpdjQ/IXVw5+456ZLsEh
         bCG7vZ9t/BVzwbTPP5dyWULxUYc7BPKOSUmVwX2GNwRcO1TKOjEMyjZ5SYCUvnXelxOF
         APcE7Jw3BSFBCd0iQDVeIVtl5a+2+IgZzike/pCUOmZHKGjSPaRNx6UzkhnpNVkBizyI
         o14A==
X-Gm-Message-State: ABy/qLaZnhfgVYTG2U6MJyRH8uvgE1stcT1aLxCXC9d6QKQ5xeyH5vH/
        TagPf9v7UmT2x/x7jY7FEIrxYCWhtOkfSmYhUtJUlwHn
X-Google-Smtp-Source: APBJJlHosMv74xMbS9qhU22D+hYR/4GA10cFB7nJKmHy8AEiMYobO/0/wZ0hTugf4RZZ979KeLODcQ==
X-Received: by 2002:a2e:9c87:0:b0:2b1:ed29:7c47 with SMTP id x7-20020a2e9c87000000b002b1ed297c47mr2850048lji.8.1688143618087;
        Fri, 30 Jun 2023 09:46:58 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id a12-20020a05651c010c00b002b6a5dfc7f3sm2233188ljb.30.2023.06.30.09.46.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jun 2023 09:46:57 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-4fb7769f15aso3408821e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:46:57 -0700 (PDT)
X-Received: by 2002:a05:6512:3dac:b0:4f8:4245:ed57 with SMTP id
 k44-20020a0565123dac00b004f84245ed57mr3479038lfv.35.1688143616777; Fri, 30
 Jun 2023 09:46:56 -0700 (PDT)
MIME-Version: 1.0
References: <mhng-ebcc1b82-5dd0-4f2d-824e-8d9250374abf@palmer-ri-x1c9>
In-Reply-To: <mhng-ebcc1b82-5dd0-4f2d-824e-8d9250374abf@palmer-ri-x1c9>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 30 Jun 2023 09:46:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgqQCAtA4cVev0g3A6RCD16s1p-_TAUeVkGE0_yS2ehyA@mail.gmail.com>
Message-ID: <CAHk-=wgqQCAtA4cVev0g3A6RCD16s1p-_TAUeVkGE0_yS2ehyA@mail.gmail.com>
Subject: Re: [GIT PULL] RISC-V Patches for the 6.5 Merge Window, Part 1
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jun 2023 at 08:40, Palmer Dabbelt <palmer@rivosinc.com> wrote:
>
> There's one merge conflict in MAINTAINERS

Yes, but your suggested resolution is wrong. That "ACPI SERIAL ..."
entry was moved downwards to be in the right place alphabetically, so
the entry next to your new RISC-V entry actually needs to be removed.

You seem to just have kept it, so your resolution caused a dup.

The hint from git is the '++' at the beginning of the line:

> ++ACPI SERIAL MULTI INSTANTIATE DRIVER
> ++M:    Hans de Goede <hdegoede@redhat.com>
> ++L:    platform-driver-x86@vger.kernel.org
> ++S:    Maintained
> ++F:    drivers/platform/x86/serial-multi-instantiate.c
> ++

which means that git thinks that your merge added those lines from
thin air (ie they didn't exist in either parent).

NOTE! A '++' line is not a sign of a mis-merge in general. It is
*purely* a hint. It happens for perfectly fine merges when you either
end up moving lines around enough that git doesn't see where they came
from.

Or, perhaps more commonly, when the merge conflict was due to both
sides changing the same exact same code, and the merge resolution
comes from neither one directly, but is new code that has combinations
of both changes.

Anyway, don't worry about it, I appreciate the heads-up regardless and
I always do my own merge resolutions. I just decided to try to use
this as a "this is how git works" moment.

Basically, trivial merges where things were just added or removed next
to each other will normally not result in "++" or "--" lines, so it
can be a hint that something went wrong if you *thought* your merge
was trivial, but git gives that kind of output for the end result.

But don't think that "++" means "wrong". It really is just a sign that
maybe the merge resolution needed a lot of care. And sometimes it's
entirely a false positive - if git *really* understood merges 100%
correctly all the time, we'd never need any manual conflict resolution
at all ;)

                  Linus
