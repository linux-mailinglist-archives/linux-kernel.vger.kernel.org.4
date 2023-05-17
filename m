Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5462706D05
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbjEQPjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjEQPiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 11:38:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168A955A9;
        Wed, 17 May 2023 08:38:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E075637D1;
        Wed, 17 May 2023 15:38:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C29AAC433D2;
        Wed, 17 May 2023 15:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684337932;
        bh=ot117eyBcpKD0lDl8KwZo2loZvZmFI8RKHgET2Hw/B0=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=KeFPgiIrgtU1zQADue6RwkBhSzujQMlHuWiV8fEksVBT9qyU5/PVNZKOCYI+uhSIn
         i+9+sfpO7OHx9piHllBum6g8ODArFboBQeiVqQkArJz+bdFm7RPLWNm0o8w3fr8zPU
         eDP/osqbozuYfT13eRP2y4gx/kGvkavh6Las2OxJb233Bx6WKe21N1MEXj/j+vccPj
         k4A9o3Yk7vPeiph+MZAcchrEr7kYAMSb7kQNF+7cabp+ZZ05LOVWkBU9PmseQ+X3WQ
         QSdfaaj6jDceK5h8shLqMBm0gVRhyqnoTS/VfbBSF30iwq3IvBrOhBp4CH/DV94kLl
         9ROlmq1nfaUeg==
Date:   Wed, 17 May 2023 08:38:49 -0700
From:   Kees Cook <kees@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        syzbot <syzbot+ac3b41786a2d0565b6d5@syzkaller.appspotmail.com>,
        Kees Cook <keescook@chromium.org>
CC:     linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com,
        linux-hardening@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5Bsyzbot=5D_=5Bkernel=3F=5D_linux-next_test_error=3A?= =?US-ASCII?Q?_UBSAN=3A_array-index-out-of-bounds_in_alloc=5Fpid?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20230517-bushaltestelle-super-e223978c1ba6@brauner>
References: <000000000000c6de2a05fbdecbbb@google.com> <20230517-bushaltestelle-super-e223978c1ba6@brauner>
Message-ID: <E41CCE0E-6274-432E-841A-A79FB996CFB0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 17, 2023 1:25:08 AM PDT, Christian Brauner <brauner@kernel=2Eorg> wr=
ote:
>On Wed, May 17, 2023 at 12:40:03AM -0700, syzbot wrote:
>> Hello,
>>=20
>> syzbot found the following issue on:
>>=20
>> HEAD commit:    065efa589871 Add linux-next specific files for 20230517
>> git tree:       linux-next
>> console output: https://syzkaller=2Eappspot=2Ecom/x/log=2Etxt?x=3D17f27=
bb2280000
>> kernel config:  https://syzkaller=2Eappspot=2Ecom/x/=2Econfig?x=3D821ee=
b02ef201bcc
>> dashboard link: https://syzkaller=2Eappspot=2Ecom/bug?extid=3Dac3b41786=
a2d0565b6d5
>> compiler:       gcc (Debian 10=2E2=2E1-6) 10=2E2=2E1 20210110, GNU ld (=
GNU Binutils for Debian) 2=2E35=2E2
>>=20
>> Downloadable assets:
>> disk image: https://storage=2Egoogleapis=2Ecom/syzbot-assets/dbbd691e9e=
5a/disk-065efa58=2Eraw=2Exz
>> vmlinux: https://storage=2Egoogleapis=2Ecom/syzbot-assets/e5b9541c3979/=
vmlinux-065efa58=2Exz
>> kernel image: https://storage=2Egoogleapis=2Ecom/syzbot-assets/44cf3f3a=
aabb/bzImage-065efa58=2Exz
>>=20
>> IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
>> Reported-by: syzbot+ac3b41786a2d0565b6d5@syzkaller=2Eappspotmail=2Ecom
>>=20
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>> UBSAN: array-index-out-of-bounds in kernel/pid=2Ec:244:15
>
>Only way I see this happening is if the logic in
>kernel/pid_namespace=2Ec:create_pid_cachep() which sets the object size
>for the struct pid allocation of this pid namespace based on
>parent_pid_namespace->level + 1 is broken=2E The way this works is:
>
>    struct pid
>    {
>            [snip]
>            struct upid numbers[1];

I was *just* looking at this fake flex array during LSS last week=2E It wa=
s one of two core structs still using the ancient 1-element style=2E

>    };
>
>    create_pid_namespace()
>    {
>            unsigned int level =3D parent_pid_ns->level + 1;
>            ns->pid_cachep =3D create_pid_cachep(level);
>    }
>
>and then during fork:
>
>    alloc_pid()
>    {
>            pid =3D kmem_cache_alloc(ns->pid_cachep, GFP_KERNEL);
>    }
>
>So effectively, the wrong level must've been set in
>create_pid_namespace() so that the flexible array allocation is too
>small=2E
>
>I don't have time to debug this tbh=2E Ccing Kees maybe there's some
>flexible array stuff going on I'm unaware of=2E

Yes, I think it's due to:
https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/kees/linux=2Egit/commi=
t/?h=3Dfor-next/hardening&id=3D2d47c6956ab3c8b580a59d7704aab3e2a4882b6c

This makes the sanitizer treat only [0]-arrays as flex arrays=2E

Though I wonder why Clang hasn't warned about this yet=2E

Regardless, we'll need to fix struct pid=2E Since it uses a static initial=
izer for "numbers[0]", this will need a bit of a tweak, but I've got patche=
s for this=2E I hadn't sent them yet because I was still studying the use o=
f the "levels" member which is off by one for the count of "numbers" elemen=
ts, which some code already has to work around (using "<=3D" when iterating=
 and "+ 1" for some outputs)=2E=2E=2E



--=20
Kees Cook
