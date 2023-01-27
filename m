Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B2967F09D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 22:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjA0Vp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 16:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbjA0Vp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 16:45:26 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFAC7A4BD
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 13:45:23 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id c11-20020a056e020bcb00b0030be9d07d63so3843946ilu.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 13:45:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JjOKySvD02qbiNRroHzsUl+VbL3SPqNF9aYSI9Pxhmo=;
        b=Mbtd/+KzgJMVjINjlnjzFLfsMEjwljc/B/jjTRWyitr7qr8+iB36ZCZdD0ISDQSLWh
         dT48q64p1Yeu+Egmhn7Scif+OMK621mv+RtK2O63SiXjIAlPh/jmc9IUxZCJvr4g0aBz
         YayT6pYLUs2E7NOa82kCHwtkRJum21qWOjSI3aY5WVq5Bh8tIsDLKbBwkSrDXaeBbnu0
         NRpbd89XDzFXbdAbCFmjuyBjO0iKaMvwvBUIKb6zibHQWPhrsM435PPIgmeKDw9mzR5R
         ygg4+YX6wWbTzW+kdlnyYV9zjK6CtawPCRz73hHiACN6DB6U8mPlmsmvCPA0x4kQM60a
         cNcg==
X-Gm-Message-State: AFqh2kpGz4hg0KgH4PschWB0DQNuUf3qSvPmAMffX5oQAKM4vwoPr0c/
        vZyRb1KXYvsdcWvV9Bq7aJM/v1gwrUmJrnu1pe07raOoWtQF
X-Google-Smtp-Source: AMrXdXuprXVu0QioCRd44GzfJqotzVn6zqBkzVKpPJRXPLHeFlyIEnCB3+uHEbUdAHJaNm/89d13N+ypErN5CmqPD1Ev3+Hn97le
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:8a7:b0:30d:8748:c541 with SMTP id
 a7-20020a056e0208a700b0030d8748c541mr5208214ilt.64.1674855923113; Fri, 27 Jan
 2023 13:45:23 -0800 (PST)
Date:   Fri, 27 Jan 2023 13:45:23 -0800
In-Reply-To: <00000000000065419205cb454ac4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000058e86005f345c88f@google.com>
Subject: Re: [syzbot] KASAN: vmalloc-out-of-bounds Write in
 tpg_fill_plane_buffer (2)
From:   syzbot <syzbot+272ce7abd8e49c0ddf42@syzkaller.appspotmail.com>
To:     hverkuil-cisco@xs4all.nl, hverkuil@xs4all.nl,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        liushixin2@huawei.com, mchehab@kernel.org,
        syzkaller-bugs@googlegroups.com
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

commit 94a7ad9283464b75b12516c5512541d467cefcf8
Author: Liu Shixin <liushixin2@huawei.com>
Date:   Thu Oct 27 12:38:55 2022 +0000

    media: vivid: fix compose size exceed boundary

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10a3509e480000
start commit:   f1583cb1be35 Merge tag 'linux-kselftest-next-5.15-rc1' of ..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=9c582b69de20dde2
dashboard link: https://syzkaller.appspot.com/bug?extid=272ce7abd8e49c0ddf42
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14f79ecd300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1489a4c9300000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: media: vivid: fix compose size exceed boundary

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
