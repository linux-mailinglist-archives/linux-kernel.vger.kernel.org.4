Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7A26762D2
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 03:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjAUCGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 21:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjAUCG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 21:06:28 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D25858294
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 18:06:28 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id w10-20020a056e021c8a00b0030efad632e0so4948515ill.22
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 18:06:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dd5wNecq6Iwv6f1dG8KNdC3uYkQa6Cax7xeMdbKruNc=;
        b=1pornWPNhKQlFXdKC2F9aKM3y4dCT6ba2owOKR9zR/Xb4J9n3B7Jayu1RN7wuiANPI
         OP/TxHJHN3iQPGJBxxS7X6N20qGmtNJ6+EoGkBTeUKmE9UjxU01mrNPZNgn6D+OqboR9
         BRuC/m8+43hun10kA39eBGmI50m+JIoiEwX66rOJRVlP5gZLQZT4xW4SSiGwRfwBpXkg
         YMvxVhvi/DK9z6svKyn8mJxxxyLedOzz5lcvRHV1Uni6jc3qXwYsfCD+qKL44HZ7iunB
         ypnh29fTO9wpS3+S5DhdWmZiZ1f3IR26VuKpCRXif8Q9OGza6QNrD+ROu9T68bVoKWHe
         mIOg==
X-Gm-Message-State: AFqh2krCoi1gv4mAvSXyLe3lyQGngqR/yulkLFX4IcIMg71pLB/7e/sB
        inH7gQKOauFK8JTydf/sWqCDa3rVJ0RXqx2HfZCfPksyAx6I
X-Google-Smtp-Source: AMrXdXuiE0IWVmXxJeCGb0ni2t8km2avjyvmVVncmFvAcPb4QdDuRxSIc/M0BGbQD/iK6SAKylqwiFZkiLM+lWBM9yGzrPrY225N
MIME-Version: 1.0
X-Received: by 2002:a5d:889a:0:b0:6e0:34ee:4e97 with SMTP id
 d26-20020a5d889a000000b006e034ee4e97mr1273397ioo.38.1674266787394; Fri, 20
 Jan 2023 18:06:27 -0800 (PST)
Date:   Fri, 20 Jan 2023 18:06:27 -0800
In-Reply-To: <00000000000073b14905ef2e7401@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001f3d6405f2bc9d28@google.com>
Subject: Re: [syzbot] BUG: stack guard page was hit in inet6_release
From:   syzbot <syzbot+04c21ed96d861dccc5cd@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com,
        error27@gmail.com, hdanton@sina.com, jakub@cloudflare.com,
        john.fastabend@gmail.com, kafai@fb.com, kernel-team@cloudflare.com,
        kpsingh@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
        lkp@intel.com, lmb@cloudflare.com, netdev@vger.kernel.org,
        oe-kbuild-all@lists.linux.dev, oe-kbuild@lists.linux.dev,
        pabeni@redhat.com, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 38207a5e81230d6ffbdd51e5fa5681be5116dcae
Author: John Fastabend <john.fastabend@gmail.com>
Date:   Fri Nov 19 18:14:17 2021 +0000

    bpf, sockmap: Attach map progs to psock early for feature probes

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=106884b9480000
start commit:   c8451c141e07 Merge tag 'acpi-6.2-rc2' of git://git.kernel...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=126884b9480000
console output: https://syzkaller.appspot.com/x/log.txt?x=146884b9480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2651619a26b4d687
dashboard link: https://syzkaller.appspot.com/bug?extid=04c21ed96d861dccc5cd
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a1a692480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1575dc34480000

Reported-by: syzbot+04c21ed96d861dccc5cd@syzkaller.appspotmail.com
Fixes: 38207a5e8123 ("bpf, sockmap: Attach map progs to psock early for feature probes")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
