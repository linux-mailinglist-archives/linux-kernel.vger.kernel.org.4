Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364A6728ECE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 06:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238331AbjFIEIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 00:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbjFIEIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 00:08:13 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91A0210D
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 21:08:10 -0700 (PDT)
X-QQ-mid: bizesmtp68t1686283685tsccsx5e
Received: from linux-lab-host.localdomain ( [116.30.126.15])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 09 Jun 2023 12:08:04 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: 7YFKcddXagjdBQB8X14wOagn5q/ZU+kiEGDno9gPsCtzD7q+u9kE+4bia6SJh
        da7kCbWwI1EuK7+Bp+yVQ3CXJmnLREiJ48aSwIse94PJbmTLGlvGqUiufIv/k0wMHdCTYjl
        hsYluMR9mD7M1faqrTLP41vn8NQ7Q29tLCoOyuhUbyx/6UOc69myHP5BsLjIcD8ycJqk59O
        OLnh6AM91EwjIrnzoCtrDpvLpt4HiMSZGU5iaw9NmHmRUY8X4UcSiSv4qlJIqNeyyyxV/ax
        9PVuWli4M+A/BGgwjLdZqoj5OoMw7MIPq/9EzwqkJz4SfKWFzk8GONo0T2lao/pzZOM3noC
        cRUOuxiqApGuKhRTjTRcSNqHvqS96iGS6By/O2P
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14576761874340952079
From:   Zhangjin Wu <falcon@tinylab.org>
To:     sfr@canb.auug.org.au
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, paulmck@kernel.org, w@1wt.eu
Subject: Re: linux-next: Signed-off-by missing for commit in the rcu tree
Date:   Fri,  9 Jun 2023 12:08:04 +0800
Message-Id: <20230609040804.164292-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230609082858.5e1b4424@canb.auug.org.au>
References: <20230609082858.5e1b4424@canb.auug.org.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Stephen, Willy, Thomas, Paul

> Hi all,
> 
> Sorry, the subject should have been "linux-next: fixes tag needs work
> in rcu tree".
> 
> On Fri, 9 Jun 2023 08:27:22 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
> rote:
> >
> > In commit
> >=20
> >   df772c12508a ("selftests/nolibc: syscall_args: use generic __NR_statx")
> >=20
> > Fixes tag
> >=20
> >   Fixes: 8e3ab529bef9 ("tools/nolibc/unistd: add syscall()")
> >=20
> > has these problem(s):
> >=20
> >   - Target SHA1 does not exist
> >=20
> > Maybe you meant
> >=20
> > Fixes: 6bff2a1e97e3 ("tools/nolibc/unistd: add syscall()")

Thanks, just checked the rcu/next branch of Paul, the commit is really the one
you corrected:

    Fixes: 6bff2a1e97e3 ("tools/nolibc/unistd: add syscall()")

Willy, this happened may be because of the 'int' to 'long' fixup merged to the
old "tools/nolibc/unistd: add syscall()" commit, I forgot the check of this
change in my patch.

Btw, perhaps it is possible to merge this typo fixup (tools/nolibc: fix up typo
_sycall_narg -> _syscall_narg) [1] to this commit too:

    6bff2a1e97e3 ("tools/nolibc/unistd: add syscall()")

And then update the new 'Fixes' tag in this patch:

    df772c12508a ("selftests/nolibc: syscall_args: use generic __NR_statx")

Or even merge both of them to the first one, and eventually, no Fixes lines
required.

As a summary, the following two fixes:

    df772c12508a ("selftests/nolibc: syscall_args: use generic __NR_statx")

    not merged   ("tools/nolibc: fix up typo _sycall_narg -> _syscall_narg"), see [1]

are for this one:

    6bff2a1e97e3 ("tools/nolibc/unistd: add syscall()")

Merging both of them to the above one may be a choice ;-)

Best Regards,
Zhangjin

[1]: https://lore.kernel.org/lkml/64f663e9e024564a7baca6769394f1e7d5a0422c.1686230738.git.falcon@tinylab.org/
