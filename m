Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1706069CBE2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 14:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbjBTNSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 08:18:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbjBTNSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 08:18:45 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16505CA04
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 05:18:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 67F0BCE0FBE
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 13:18:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6880C433A0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 13:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676899116;
        bh=GlZKUnCJqUH65twZtiEVTQTDCQszZly8hq9gwbRGHjg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qD/+X1APdetLuEl/OT497kV6yMShj6Mp35mz4f13nagEZDFzWXvoMInCNMptOYhRD
         2263a3/etuC93kK+2hR/GnUuhVxU4xs3yL5nmFtf8+I0Els9YvhbKvlLDdpIF+Dzz3
         S2vP4nPO4B2PI48Nm0aQ1b6dJ7q40+I9e5xvnEAEn5TEsMNmJAH9fFMOz78yXPj+r7
         HPO/7jI36guY6oehUkcQvC0PVwwzw0Hr6iK3ljcTUk8u14HTE2Q6MUyoboz6BCu+t/
         DoGR+DZm7Z5PkDVTHDVh9WgMPgJORkVpNT2qkzEIRJBPIDPVBTExTWT/y2/SSUqW0P
         h8kazQKRSlNxw==
Received: by mail-lf1-f43.google.com with SMTP id y22so1434652lfa.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 05:18:36 -0800 (PST)
X-Gm-Message-State: AO0yUKVrAbWMQ1F5PidSP7dEiCCEMr+X71pZ3xGE1iaHfUrVz0W2kVr8
        dmZI8EoBmqVaAH0RTkrXmFpw+L8iCEY/cEtuEOA=
X-Google-Smtp-Source: AK7set/CQeWJVds+2pEuoKGTzTL8qHQBpaa7FEIMp7tvK8ndk8We0AGZQwC9wX9dQZ0J4e6mb0UMPoAwFu50kCl+8dg=
X-Received: by 2002:a05:6512:b0e:b0:4dc:8090:f94b with SMTP id
 w14-20020a0565120b0e00b004dc8090f94bmr1008879lfu.5.1676899114892; Mon, 20 Feb
 2023 05:18:34 -0800 (PST)
MIME-Version: 1.0
References: <00000000000028ea4105f4e2ef54@google.com> <Y/Nwfrb42e6MRrAi@FVFF77S0Q05N>
In-Reply-To: <Y/Nwfrb42e6MRrAi@FVFF77S0Q05N>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 20 Feb 2023 14:18:23 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGhWKPbZAeEx4HOqhswx__mY_mZCzdhgaj6eWw2z3PSQg@mail.gmail.com>
Message-ID: <CAMj1kXGhWKPbZAeEx4HOqhswx__mY_mZCzdhgaj6eWw2z3PSQg@mail.gmail.com>
Subject: Re: [syzbot] upstream-arm64 build error
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     syzbot <syzbot+f8ac312e31226e23302b@syzkaller.appspotmail.com>,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        will@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Feb 2023 at 14:07, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Fri, Feb 17, 2023 at 02:39:55AM -0800, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    2d3827b3f393 Merge branch 'for-next/core' into for-kernelci
> > git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> > console output: https://syzkaller.appspot.com/x/log.txt?x=160f19d7480000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=f5c7f0c5a0c5dbdb
> > dashboard link: https://syzkaller.appspot.com/bug?extid=f8ac312e31226e23302b
> > compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
> > userspace arch: arm64
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+f8ac312e31226e23302b@syzkaller.appspotmail.com
> >
> > failed to run ["make" "-j" "64" "ARCH=arm64" "CROSS_COMPILE=aarch64-linux-gnu-" "CC=clang" "Image.gz"]: exit status 2
>
> For the benefit of others, the actual error from the console log is:
>
>   LD      .tmp_vmlinux.kallsyms1
>   aarch64-linux-gnu-ld: ID map text too big or misaligned
>   make[1]: *** [scripts/Makefile.vmlinux:35: vmlinux] Error 1
>   make: *** [Makefile:1264: vmlinux] Error 2
>
> ... and I see the same on for-next/core with my usual fuzzing configs applied
> atop, building with GCC 12.1.0.
>
> That "ID map text too big or misalignes" error is from an assertion in arm64's
> vmlinux.lds.S, and if I hack that out, the kernel builds and the idmap text
> section is 4K aligned and ~2900 bytes in size.
>
> My config worked on v6.2-rc3, and bisecting led me to commit:
>
>   3dcf60bbfd284e5e ("arm64: head: Clean the ID map and the HYP text to the PoC if needed")
>
> ... which plays with sections a bit, but doesn't do anything obviously wrong.
>
> I think the error is misleading, and what's actually happening here is that the
> size of the .idmap.text section hasn't been determined at the point the
> assertion is tested.
>
> With my config, the Image size is ~242MiB, and I think what's happening is that
> some branches from .idmap.text to .text are (possibly) out-of-range, but the
> linker doesn't know the final position of the sections yet and hasn't placed
> PLTs, and doesn't know the final size of the sections.
>
> I don't know much about the linker, so that's conjecture, but the below diff
> got rid of the build error for me.
>

This issue was reported before here:

https://lore.kernel.org/all/CAMj1kXGAf7ikEU5jLoik0xrOde0xBg0yJkOo5=PtEtNXoUxMXA@mail.gmail.com/

and the bisect ended up somewhere else.

The issue seems to be where exactly the veneers for the entire image
are dumped, and when this is right after .idmap.text (being the last
input section with the EXEC ELF attribute), it pushes the
__idmap_text_end symbol over the next 4k boundary.

Not sure what the most robust fix would be here - we could try whether
or not placing *.text.stub input sections explicitly makes a
difference here but it still feels a bit ad-hoc (surprisingly,
.idmap.text.stub does not get flagged as an orphan input section even
though it is not mentioned in the linker script)
