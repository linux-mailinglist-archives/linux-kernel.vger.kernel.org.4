Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8E86C8FB8
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 18:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjCYR02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 13:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCYR00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 13:26:26 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37C49ECE
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 10:26:25 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id w9so19993682edc.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 10:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679765184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hi8j/E7y8bTSj/LAOmUph9FQ5yORTj5HDWgCIVQKKc4=;
        b=g/PBQ6Sl3AC8h70o/qg/TCbY1tJHEICWySbVrftwo+lVgIobGc+gLHa3w5XlItRdFC
         nc8I8bPnL/KWBR+h5L2DuG1sM7z7S/PucYe8HasRjKesuGIy77WE3/nWr+t6ckDxb5l2
         i2xf3n/k1CRX/pxur4YaC30seT04O89ojJYrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679765184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hi8j/E7y8bTSj/LAOmUph9FQ5yORTj5HDWgCIVQKKc4=;
        b=uuaK1QI55/nv5P48Kj6VTl05AmB8cciVBo+1Pw8P9tjAuYVN3430X74EtcSCIxrVJ6
         iIGhETtKbCqdXjSruR4zJ7s7417qTiPe+o9mZoofKy86A2I8+9YhjOjXpycXiWSZBzj2
         15S8a/flRe1r4gIav9+XRAoEoWRtldNoq0oaPQyYtZLgs4IJrvY+R4Ltjlze3RFeasLJ
         ZSF3CqxDNipzi7lUx7sHR/JdvKaxgHF6u6pcocfNKI8pDgJQUJdXIvBPJTm7SSVHWFe2
         lDA/i1ZFlqK39rOtXOjnf/ELwu21rK6grMUfkrH2QSKtIAv7x6On4m9frYMvcuHhHk8/
         C/KA==
X-Gm-Message-State: AAQBX9fxCxdyil04KuS1rKyRDA84OW8JcDoPYS3A653/f+n88q/542ON
        3kTXOvbADMxU8EHBSB1chWylt+wbUC3qP+/fIvobqHIC
X-Google-Smtp-Source: AKy350afSFkTWcuAK4m4Vte6UGSkswFp/VFJPAZ8fx+w/E28wrsFm/SqRD1NrFLCyIf69TeEfgA3Fg==
X-Received: by 2002:a17:906:f212:b0:8f6:dc49:337f with SMTP id gt18-20020a170906f21200b008f6dc49337fmr6375681ejb.43.1679765183885;
        Sat, 25 Mar 2023 10:26:23 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id ha8-20020a170906a88800b0093a6c591743sm6602374ejb.69.2023.03.25.10.26.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Mar 2023 10:26:23 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id ek18so19942187edb.6
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 10:26:23 -0700 (PDT)
X-Received: by 2002:a17:906:eec7:b0:93e:186f:ea0d with SMTP id
 wu7-20020a170906eec700b0093e186fea0dmr2870426ejb.15.1679765182826; Sat, 25
 Mar 2023 10:26:22 -0700 (PDT)
MIME-Version: 1.0
References: <ZB2GTBD/LWTrkOiO@dhcp22.suse.cz> <20230324130530.xsmqcxapy4j2aaik@box.shutemov.name>
 <CAEXW_YQj_Wg0Xx2cHT9hTrDjEtrAV-bRjgL79=76d=D5f8GnEA@mail.gmail.com>
 <CAHk-=whuXx+cyGhFKjU0qjzvgna8iDA8YcqDDyH3cQywixuMgA@mail.gmail.com>
 <20230325163323.GA3088525@google.com> <CAHk-=whd7msp8reJPfeGNyt0LiySMT0egExx3TVZSX3Ok6X=9g@mail.gmail.com>
In-Reply-To: <CAHk-=whd7msp8reJPfeGNyt0LiySMT0egExx3TVZSX3Ok6X=9g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 25 Mar 2023 10:26:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjsrGG3-gvrpPs9f56PVvwmZViPKm++TuSsHeyTQ+tRmQ@mail.gmail.com>
Message-ID: <CAHk-=wjsrGG3-gvrpPs9f56PVvwmZViPKm++TuSsHeyTQ+tRmQ@mail.gmail.com>
Subject: Re: WARN_ON in move_normal_pmd
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@suse.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 25, 2023 at 10:06=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So what I'm saying is that *if* we start out with that situation, and
> we have that
>
>     old =3D 0x1fff000
>     new =3D 1dff000
>     len =3D 0x201000
>
> we could easily decode "let's just move the whole PMD", and expand the
> move to be
>
>     old =3D 0x1e00000
>     new =3D 0x1c00000
>     len =3D 0x400000
>
> instead. And then instead of moving PTE's around at first, we'd move
> PMD's around *all* the time, and turn this into that "simple case
> (a)".
>
> NOTE! For this to work, there must be no mapping right below 'old' or
> 'new', of course. But during the execve() startup, that should be
> trivially true.
>
> See what I'm saying?

Also note that my comments about "this can be tested with mremap()"
are because the above optimization works and is valid even when old
and new are not originally overlapping, but they overlap after the
expansion.

IOW, imagine that you have a 2GB mapping, but it is not 2GB-aligned
virtually, and you want to move that mapping down by 2GB.

Now, because that 2GB mapping is *not* 2GB-aligned, it actually takes
up *two* PMD entries. But if that mapping is the only thing that
exists in those two PMD entries, and the PMD entry below it is clear
(because there is no mapping right below the new address), then we can
still do that unaligned 2GB mapping move entirely at the PMD level.

So instead of wasting time to move it one page at a time (until it is
2GB aligned), we could just move two PMD entries around.

Here's a (UNTESTED! It compiles, but that's it) user test-case for
this situation:

  #define _GNU_SOURCE
  #include <sys/mman.h>
  #include <string.h>

  /* Pick some random 2GB-aligned address that isn't near anything else */
  #define GB (1ul << 20)
  #define VA ((void *)(128 * GB))

  #define old (VA+GB)
  #define new (VA-GB)
  #define len (2*GB)

  int main(int argc, char **argv)
  {
        void *addr;

        addr =3D mmap(old, len,
                PROT_READ | PROT_WRITE,
                MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED,
                -1, 0);
        memset(addr, 0xff, len);
        mremap(old, len, len,
                MREMAP_MAYMOVE | MREMAP_FIXED, new);
        return 0;
  }

and I claim that that mremap() right now ends up doing the whole 2GB
page table move one page at a time, but it *should* be doable as just
two PMD entry moves.

See?

                Linus
