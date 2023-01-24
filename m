Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA80F67938F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 09:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbjAXI5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 03:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbjAXI5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 03:57:18 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25DC3D08C
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 00:57:17 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id b21-20020a5d8d95000000b006fa39fbb94eso8459300ioj.17
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 00:57:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TlqNjgd3eRIYDTKHlZ6hEp0r6nIEjM/F53EV9FU/n5g=;
        b=LpzB5NhEJVs9dbQdHtUWTwLbaxTsMfdvGjStlX1wdCOOceO2t587k8eMGxVBCjOSCf
         KbNzXqOnBmwQVCCWWpL73iW1fALiOQtEO5sy3YKqFPa2S68TMxUXfKV0w9ImoCZE/JsC
         u1K4DjTf273cVu5vPbPG8Kb4EzQrgjvWZouJZSluKjI/gLI69Ft8t+XaEv75aFhFKInA
         3q3TBeRWkALRWEvKRh7ckOiVgXgH7seIiwKTdBBndXCginQClreepCary7t1bEWl7x3f
         Iky96XBgBfbKzS1uypJFYoFj7lBUJVsjcOKBfI+rhMdiC1UKC77F4Kv49Y1pdf9LFKsi
         sWNg==
X-Gm-Message-State: AFqh2krvE9N8bDiTkxUldBRxToFQJ9J6KnNpNpsRzM6ndjOfGnrqEYaO
        L6bf9RlHZ26f1DRuwA2JKRWDpMvdcpd+RrKoDYpH/v3cE2Oe
X-Google-Smtp-Source: AMrXdXsUCkXvgb7fvzNjYB6vnqz4sxeezDwrNKweS81JCSIk15mqbkNS22G0WGDO5DzSrUWEHro13o0p3tgMObQkCGbbSKHQrrHp
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d99:b0:30f:11bc:cc6e with SMTP id
 h25-20020a056e021d9900b0030f11bccc6emr2638812ila.87.1674550636901; Tue, 24
 Jan 2023 00:57:16 -0800 (PST)
Date:   Tue, 24 Jan 2023 00:57:16 -0800
In-Reply-To: <000000000000e4630c05e974c1eb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000defd4b05f2feb35c@google.com>
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in evict
From:   syzbot <syzbot+6b74cf8fcd7378d8be7c@syzkaller.appspotmail.com>
To:     feldsherov@google.com, hirofumi@mail.parknet.co.jp, jack@suse.cz,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 4e3c51f4e805291b057d12f5dda5aeb50a538dc4
Author: Svyatoslav Feldsherov <feldsherov@google.com>
Date:   Tue Nov 15 20:20:01 2022 +0000

    fs: do not update freeing inode i_io_list

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=111208cd480000
start commit:   b229b6ca5abb Merge tag 'perf-tools-fixes-for-v6.1-2022-10-..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d3548a4365ba17d
dashboard link: https://syzkaller.appspot.com/bug?extid=6b74cf8fcd7378d8be7c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1353a3e2880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16163dce880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: do not update freeing inode i_io_list

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
