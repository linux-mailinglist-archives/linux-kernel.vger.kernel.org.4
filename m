Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388F4734832
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 22:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjFRUom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 16:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFRUok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 16:44:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DEB115
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 13:44:39 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687121077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ot6UN4tAxlAZgUfveKMq9QeJmZYE4keoMfZF0zVbqQI=;
        b=KNj2sn6jgBOfumsMSXySYZRJRjuU2pre7jUil4ncjVMGOWjgbynTGXFpxR5fVpXFFf7nZ2
        gbAx7yTGM7EELqgSeyGWSFa4B7btQo6DeGqHHs2lv6x4uaD7sjGbEHrA7QoXjgF/xK+WNE
        q7WPP9ei60j98j6gc78uNDR7MyBrCBoLrWFCAr5wmu3jwRyp249xcUKPDWSpP0PjeEoL/y
        UcWNqCK6tMt5Z18pXIktgGoryWJ3yF3QgNarkS9gcvUdt0IwfbjIx6/zZxr8mWTz/Uv/Hj
        LjBaeCY2rDyknLXQVboAXJTHR3yfxV8Kot4jSv8Z0BrnPE6ZDQ1YDpUO0f6f6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687121077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ot6UN4tAxlAZgUfveKMq9QeJmZYE4keoMfZF0zVbqQI=;
        b=4RG0qWSkOJUZcHcYtSVe21Y4ydtAoxuXu4h9fvcj4r/Wjovqcgr8yzo6J+CXtjkuKsMHMs
        EektSEKvsFClplBg==
To:     syzbot <syzbot+5fd924f4cd9dc1c7828c@syzkaller.appspotmail.com>,
        frederic@kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel?] possible deadlock in exit_itimers
In-Reply-To: <000000000000cf863605fe4c5f40@google.com>
References: <000000000000cf863605fe4c5f40@google.com>
Date:   Sun, 18 Jun 2023 22:44:36 +0200
Message-ID: <87v8fkqz4b.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16 2023 at 22:14, syzbot wrote:
> syzbot has bisected this issue to:
>
> commit 1b59b2577582f9cf3d0f17245675a76859175cc1
> Author: Thomas Gleixner <tglx@linutronix.de>
> Date:   Thu Jun 1 20:16:34 2023 +0000
>
>     posix-timers: Prevent RT livelock in itimer_delete()
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=106d46e3280000
> start commit:   f7efed9f38f8 Add linux-next specific files for 20230616
> git tree:       linux-next
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=126d46e3280000
> console output: https://syzkaller.appspot.com/x/log.txt?x=146d46e3280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=60b1a32485a77c16
> dashboard link: https://syzkaller.appspot.com/bug?extid=5fd924f4cd9dc1c7828c
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1401d8ef280000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=176b45cf280000
>
> Reported-by: syzbot+5fd924f4cd9dc1c7828c@syzkaller.appspotmail.com
> Fixes: 1b59b2577582 ("posix-timers: Prevent RT livelock in itimer_delete()")

I've amended the original commit as that is tagged stable.

Thanks for chatching this and reporting!

       tglx
