Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3209E6FF5B4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 17:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238487AbjEKPTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 11:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238460AbjEKPTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 11:19:32 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FD31FFC
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 08:19:30 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-50bd2d7ba74so80402827a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 08:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1683818369; x=1686410369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJpRi8U4anHxP91Og34clDJuvOhSvC/Ny6ZY6fVS6NA=;
        b=TmbsosqpHKsbyV71znStNqd9RFeitV2eXYJsFJpgGLAWKEAdwqfW53ks0v0R3avk2a
         OghVcmxL6fmRRmfoUA4i/6v/wgDgTX0cvj9AUrkOz/zF7mPs0BqHfcVS2hkuwk6XwS/l
         tgMfDkjGR3PYqyeIZy8t1VHU63NOqSI8LZ6E9Z0I7c7m6chu1sFS75o4OdKGtCdxWUy8
         oaGw6twk/jGvsUjdobAivroaAm9uEvUB5AgLXUEtT6Q+Mx6aT+2IUSp37uPhTN+O+//J
         sDyoZFGrkuM56fa5LetP7SulRGvgVJuU++QlN4eWnma9MIYk0XJiH3dWLRUMrxLfbRML
         2kdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683818369; x=1686410369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mJpRi8U4anHxP91Og34clDJuvOhSvC/Ny6ZY6fVS6NA=;
        b=FQHvqwxYfBITsGIZx42DTYZbY9edWbdYCAnUBYrrxRuwvkLuBJWhbx86NWPK1GQ8Zf
         9rXRWs4dlT8lLrXIOlQ7Ff9EtjjtZXne/BnD+Dn/nR0FWsZt3Gcc/fPF2TlHPVvsBh8s
         Ur2Qm0P2aEJYUUiUag52EejNGp3TjHaTej6k0Mz9As86tUwwBWxpXKIDn2l7Fjw5dwII
         IOG6mKJPA+ZF0wOhie3kzEUXMZn9O9aCoSzpljnHURthK0MmzwnPTynt0+H4zPQ/DyRV
         wWzqYPGAhCZMWPIO9UevqfOrXgRtLy1ry196qH+slCLxPCCz6KDiROOBhM2yu8uzbydE
         dA0g==
X-Gm-Message-State: AC+VfDzNb2CCpmSE918DIWg40GFPAizdw8O1J+l4IfGgjP8zCktp5R0X
        r2q2Pt9NAnYHXgEuSERQ+AX4tS59QIgkPg3Kf1z0ZQ==
X-Google-Smtp-Source: ACHHUZ622cGWEkiUpT7RoLmMpy0Uatilmpa5SvU9Xkc1QW1rLBsLFS38+mmhk0wsxGczsQ251uXMbzXui36AgnhTh7U=
X-Received: by 2002:a17:907:8a08:b0:969:2df9:a0dd with SMTP id
 sc8-20020a1709078a0800b009692df9a0ddmr12191725ejc.25.1683818368935; Thu, 11
 May 2023 08:19:28 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000019af1d05fb5fdd99@google.com>
In-Reply-To: <00000000000019af1d05fb5fdd99@google.com>
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Thu, 11 May 2023 08:19:17 -0700
Message-ID: <CAN+4W8jFTcnS-EBppkoRXmfzUOgiGNwBku69==-b-Z_2fDHfUw@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] KASAN: slab-out-of-bounds Write in copy_array (2)
To:     syzbot <syzbot+d742fd7d34097f949179@syzkaller.appspotmail.com>
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, haoluo@google.com,
        hawk@kernel.org, john.fastabend@gmail.com, jolsa@kernel.org,
        kpsingh@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, martin.lau@linux.dev, nathan@kernel.org,
        ndesaulniers@google.com, netdev@vger.kernel.org, sdf@google.com,
        song@kernel.org, syzkaller-bugs@googlegroups.com, trix@redhat.com,
        yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 5:14=E2=80=AFPM syzbot
<syzbot+d742fd7d34097f949179@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    950b879b7f02 riscv: Fixup race condition on PG_dcache_cle=
a..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux=
.git fixes
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D17eaa0c628000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Decebece1b90c0=
342
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd742fd7d34097f9=
49179
> compiler:       riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, =
GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: riscv64
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/5=
ab53d394dbf/non_bootable_disk-950b879b.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/938475579d6c/vmlinu=
x-950b879b.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/bcf263d8c574/I=
mage-950b879b.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+d742fd7d34097f949179@syzkaller.appspotmail.com

That tree doesn't have the fix yet:
https://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git/tree/kernel=
/bpf/verifier.c?h=3Dfixes&id=3D950b879b7f02#n1065

#syz fix: bpf: Always use maximal size for copy_array()
