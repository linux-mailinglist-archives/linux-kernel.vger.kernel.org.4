Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683156D3CCB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 07:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjDCFWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 01:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbjDCFWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 01:22:36 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24EA729B
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 22:22:31 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id o20so26100972ljp.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Apr 2023 22:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680499350;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jUeHmCJsOZ15PCrqzcT9jzXjr3pnWja6Yvf/jMIqo2g=;
        b=j+RcIrwYkSlV0YsZT6a7Nf5HnHoAQSZ5ar7sxcirSl8tA/ufCzd8S5ChCjyn49dNLZ
         DOYh+dIX7kd8l+M5Lr10gCwZ9o13cUXR0x1FBDCl5E+RJ7pLbNf3mw/sKF8XluszxVDE
         WLZt8FdFbljpgPY5WgixNhMpwmvW9L56RwDNCSCpz9CJOEldq4Y8rC8ceuEO97/r2kdd
         32q4sPDrTfcwDsTHJJd4UhD/+jU5wfpd0oG/5pTd1RTIWqXT9W8oejAZa9Gm6WGCmt1U
         YSBV/PvJBrQTbDXwtwFVl8j/hRRHM6A1YjeZ804weVkPTwUe1a5RwQYgu2BlR/a4taEQ
         966g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680499350;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jUeHmCJsOZ15PCrqzcT9jzXjr3pnWja6Yvf/jMIqo2g=;
        b=jOwjTa3XkvrdCBCXSB7c2WILR1B5949m40gQHznumAeQ2+ND3qwVubSd8QFq24TywN
         sDwECHNM74FbvO6/7PXfOHCinHOjHovzke6m5ZojAffjyBSVigEAbrhcA5CU6hT02p4x
         ielI3LTDgL9OaoKxmsg8nTYEWkk9URTid1VrQbAtbhjrhMgtIrteiDtgUzytyhpvTLoq
         QLMW0YzhOebYPC9AJKpDJ8afImRsMvalDyf6RhgpGpnfFqurX7K77/TkiLM9GdP6Zeu2
         Msgu7/Abqv95ehs3jXRUbQSjTztkXjluBSr1LGob5iZ1nZJf5xJYQOtrL2SboYXsYhxX
         4dFQ==
X-Gm-Message-State: AAQBX9dPW3hfqjlmdLPEeGx0n4jl+YCBTN/BmMK7wNASJ6397PcRw+Jz
        JKTHEY0cHYT/lksVSDAN10s5RpKEs9RT0CGbRzPfYOgH3HDV5UHSFQWqXw==
X-Google-Smtp-Source: AKy350YlQtUmLZ7Czl4MVNVUU0dkpMyMaTqGUafG6y3WfwxlWynWEYHavh0E8wZK7Jf4BaXGtJDyYCgLSUqYLTL9DJg=
X-Received: by 2002:a05:651c:104d:b0:298:b32c:e4f0 with SMTP id
 x13-20020a05651c104d00b00298b32ce4f0mr10553618ljm.8.1680499349842; Sun, 02
 Apr 2023 22:22:29 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000055cd8405f84c5386@google.com> <2023040205-apostle-retention-cebd@gregkh>
In-Reply-To: <2023040205-apostle-retention-cebd@gregkh>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 3 Apr 2023 07:22:16 +0200
Message-ID: <CACT4Y+YCB72OU81V370RXfWM=+472xNhyPF_WmVYo=cw5Fbzyg@mail.gmail.com>
Subject: Re: [syzbot] [kernel?] WARNING in class_register
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     syzbot <syzbot+ca3d9f693dfa69f61371@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Apr 2023 at 10:45, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sat, Apr 01, 2023 at 01:39:42PM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    a6d9e3034536 Add linux-next specific files for 20230330
> > git tree:       linux-next
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=1496edcdc80000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=aceb117f7924508e
> > dashboard link: https://syzkaller.appspot.com/bug?extid=ca3d9f693dfa69f61371
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14f57859c80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=167cc501c80000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/ec1f900ea929/disk-a6d9e303.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/fabbf89c0d22/vmlinux-a6d9e303.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/1ed05d6192fa/bzImage-a6d9e303.xz
> >
> > The issue was bisected to:
> >
> > commit dcfbb67e48a2becfce7990386e985b9c45098ee5
> > Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Date:   Fri Mar 24 10:01:31 2023 +0000
> >
> >     driver core: class: use lock_class_key already present in struct subsys_private
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10190b49c80000
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=12190b49c80000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=14190b49c80000
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+ca3d9f693dfa69f61371@syzkaller.appspotmail.com
> > Fixes: dcfbb67e48a2 ("driver core: class: use lock_class_key already present in struct subsys_private")
>
> Should already be fixed by:
>         https://lore.kernel.org/all/2023040126-blandness-duckling-bd55@gregkh/
> which was a different syzbot-reported issue with this same commit.

Let's tell syzbot so that it reports similar bugs in future:

#syz fix:
driver core: class : fix slab-use-after-free Read in class_register()
