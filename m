Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4DB738468
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 15:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbjFUNHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 09:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbjFUNHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:07:38 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B847E10FE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 06:07:36 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-25bf4b269e0so4776412a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 06:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687352856; x=1689944856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AN9rHqAMb+s9JldJn9/oqOzjlHcCzpCU13r5zGj/2KQ=;
        b=cK7F3u9YWXKESMkYMrq4CLbiYhmqAwgCfOHFwEMrXZBDvEfantgIL+FukZP7lJa0HE
         ea+9QoGvYwMLYvpCEbugNNosto1uR6rlY5mkWJTITzJG2HsAWzwIj4R3IGti2g+h74VS
         9+4U+k4MGAY/K5+AO5LbCu4ijCkdwFXd/Flus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687352856; x=1689944856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AN9rHqAMb+s9JldJn9/oqOzjlHcCzpCU13r5zGj/2KQ=;
        b=SrqIJSznO07Q7Ds87y0jkk0yFosudONRHlXaH89nF/luenSxBXDDuKZAS9OmYyLOdP
         SFaEIie6iWVIcDldXuecUAo7HSvdF8zVQXDgTVXzHk7NHaEApvKW6b5KU1//KDX5utzi
         gOE3WUXT9ZlHATml8Cj/CEuo5lhZ7Zo+wU2ucGbwg6UaMp7E1B8I9xyiF0Gx0q+u2gcr
         BZOZ5qlRW1gyK548btGGidjMV5YjWrCD6cHGt8Js+VggZfN1nX8jEPwVSgDr0Ua6MAHZ
         aEizeCm8DkwvvXGTIBt7SFgItwoLWUX8ofsk24U+F3cMRMQ7nEcQba4G4r5MoOb6k4w4
         6//A==
X-Gm-Message-State: AC+VfDyMFQMKpbPhigWmt4zaWp2bMZ6r0SlMUZbYzCoVhh6vY0yKngVn
        0BHKK2PfRgYqos6cG0G8SLbFAGSWi2bIWv2B+cOiYw==
X-Google-Smtp-Source: ACHHUZ58CXQQpAnHz3lkggiqe1EL/HQv8J6Ipct9oA7wdxqNiCgJ8ePDZU2c7RUje6+6AvX2hFO4F8Z0/irOHhzxVjI=
X-Received: by 2002:a17:90a:e385:b0:25e:e70f:423f with SMTP id
 b5-20020a17090ae38500b0025ee70f423fmr14962926pjz.19.1687352855923; Wed, 21
 Jun 2023 06:07:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230615152918.3484699-1-revest@chromium.org> <ZJFIy+oJS+vTGJer@calendula>
 <CABRcYmJjv-JoadtzZwU5A+SZwbmbgnzWb27UNZ-UC+9r+JnVxg@mail.gmail.com> <20230621111454.GB24035@breakpoint.cc>
In-Reply-To: <20230621111454.GB24035@breakpoint.cc>
From:   Florent Revest <revest@chromium.org>
Date:   Wed, 21 Jun 2023 15:07:24 +0200
Message-ID: <CABRcYmKeo6A+3dmZd9bRp8W3tO9M5cHDpQ13b8aeMkhYr4L64Q@mail.gmail.com>
Subject: Re: [PATCH nf] netfilter: conntrack: Avoid nf_ct_helper_hash uses
 after free
To:     Florian Westphal <fw@strlen.de>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kadlec@netfilter.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        lirongqing@baidu.com, daniel@iogearbox.net, ast@kernel.org,
        kpsingh@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 1:14=E2=80=AFPM Florian Westphal <fw@strlen.de> wro=
te:
>
> Florent Revest <revest@chromium.org> wrote:
> > On Tue, Jun 20, 2023 at 8:35=E2=80=AFAM Pablo Neira Ayuso <pablo@netfil=
ter.org> wrote:
> > >
> > > On Thu, Jun 15, 2023 at 05:29:18PM +0200, Florent Revest wrote:
> > > > If register_nf_conntrack_bpf() fails (for example, if the .BTF sect=
ion
> > > > contains an invalid entry), nf_conntrack_init_start() calls
> > > > nf_conntrack_helper_fini() as part of its cleanup path and
> > > > nf_ct_helper_hash gets freed.
> > > >
> > > > Further netfilter modules like netfilter_conntrack_ftp don't check
> > > > whether nf_conntrack initialized correctly and call
> > > > nf_conntrack_helpers_register() which accesses the freed
> > > > nf_ct_helper_hash and causes a uaf.
> > > >
> > > > This patch guards nf_conntrack_helper_register() from accessing
> > > > freed/uninitialized nf_ct_helper_hash maps and fixes a boot-time
> > > > use-after-free.
> > >
> > > How could this possibly happen?
> >
> > Here is one way to reproduce this bug:
> >
> >   # Use nf/main
> >   git clone git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.=
git
> >   cd nf
> >
> >   # Start from a minimal config
> >   make LLVM=3D1 LLVM_IAS=3D0 defconfig
> >
> >   # Enable KASAN, BTF and nf_conntrack_ftp
> >   scripts/config -e KASAN -e BPF_SYSCALL -e DEBUG_INFO -e
> > DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT -e DEBUG_INFO_BTF -e
> > NF_CONNTRACK_FTP
> >   make LLVM=3D1 LLVM_IAS=3D0 olddefconfig
> >
> >   # Build without the LLVM integrated assembler
> >   make LLVM=3D1 LLVM_IAS=3D0 -j `nproc`
> >
> > (Note that the use of LLVM_IAS=3D0, KASAN and BTF is just to trigger a
> > bug in BTF that will be fixed by
> > https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/commit/?id=
=3D9724160b3942b0a967b91a59f81da5593f28b8ba
> > Independently of that specific BTF bug, it shows how an error in
> > nf_conntrack_bpf can cause a boot-time uaf in netfilter)
> >
> > Then, booting gives me:
> >
> > [    4.624666] BPF: [13893] FUNC asan.module_ctor
> > [    4.625611] BPF: type_id=3D1
> > [    4.626176] BPF:
> > [    4.626601] BPF: Invalid name
> > [    4.627208] BPF:
> > [    4.627723] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [    4.628610] BUG: KASAN: slab-use-after-free in
> > nf_conntrack_helper_register+0x129/0x2f0
> > [    4.628610] Read of size 8 at addr ffff888102d24000 by task swapper/=
0/1
> > [    4.628610]
>
> Isn't that better than limping along?

Note that this only panics because KASAN instrumentation notices the
use-after-free and makes a lot of noise about it. In a non-debug boot,
this would just silently corrupt random memory instead.

> in this case an initcall is failing and I think panic is preferrable
> to a kernel that behaves like NF_CONNTRACK_FTP=3Dn.

In that case, it seems like what you'd want is
nf_conntrack_standalone_init() to BUG() instead of returning an error
then ? (so you'd never get to NF_CONNTRACK_FTP or any other if
nf_conntrack failed to initialize) If this is the prefered behavior,
then sure, why not.

> AFAICS this problem is specific to NF_CONNTRACK_FTP=3Dy
> (or any other helper module, for that matter).

Even with NF_CONNTRACK_FTP=3Dm, the initialization failure in
nf_conntrack_standalone_init() still happens. Therefore, the helper
hashtable gets freed and when the nf_conntrack_ftp.ko module gets
insmod-ed, it calls nf_conntrack_helpers_register() and this still
causes a use-after-free.

> If you disagree please resend with a commit message that
> makes it clear that this is only relevant for the 'builtin' case.
