Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC38372D2C8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 23:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238844AbjFLVJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 17:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239106AbjFLVIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:08:13 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2E43C2A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 14:05:26 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-33d93feefb5so42897365ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 14:05:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686603925; x=1689195925;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7bYNPnFfqHjdFQJOUIEUQGIwD79+AH+aRTvoVJort04=;
        b=S4o2yppZsDZxhh+SXqnT+fvAfVXR+/x7almEk2kVsXagNLIJNCF3Q2Z+VrKOAlKzwh
         f0ebJ0lAnydLseN0NAlFo9/FmBIaMC9/wPwvUWP1YtEEriG84UVboiGX0dtgz0/Kgozz
         A+P6itWc7oi0DMNdJHFyBvfNWcQlngKJNE8GULjXF++Ze+Z43dr3OowAZ8o67ul48k9R
         5aJKTYIyOqZDFAJQzFg8bXBDZRt1xm//Ukq/Qwzz5Zo+pJHIGL2NYlqHb+dEduX+o831
         1jHElUFflt9zzt6YfIXpmIFu+Gf45SbkIdX7kSYgZLVZwanGu8/FkbEgenxNbKE2AWsU
         1W5w==
X-Gm-Message-State: AC+VfDxiWOopto5hB+JU0QXXIdBuRkySSEol4v3bSXw4cvOR4Kxiq6Rs
        as9WoEbec0DuF8SCZNJkiNUyyF3HuJZPVzerhz51/M/MJcVb
X-Google-Smtp-Source: ACHHUZ6MBYUIqF7fHIrkzltsCk1fBPFfysvSY+EZ6WoKhDfGBvSePU/5G9r6nMuObBwYTmZVj6rUoHbL7LuSmWSfcynNp0gI/nhU
MIME-Version: 1.0
X-Received: by 2002:a92:dc09:0:b0:33e:6230:aa65 with SMTP id
 t9-20020a92dc09000000b0033e6230aa65mr5023912iln.0.1686603925323; Mon, 12 Jun
 2023 14:05:25 -0700 (PDT)
Date:   Mon, 12 Jun 2023 14:05:25 -0700
In-Reply-To: <000000000000ab092305e268a016@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d88b1e05fdf513c3@google.com>
Subject: Re: [syzbot] [gfs2?] general protection fault in gfs2_evict_inode (2)
From:   syzbot <syzbot+8a5fc6416c175cecea34@syzkaller.appspotmail.com>
To:     agruenba@redhat.com, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        rpeterso@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 504a10d9e46bc37b23d0a1ae2f28973c8516e636
Author: Bob Peterson <rpeterso@redhat.com>
Date:   Fri Apr 28 16:07:46 2023 +0000

    gfs2: Don't deref jdesc in evict

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1544372d280000
start commit:   7df047b3f0aa Merge tag 'vfio-v6.4-rc1' of https://github.c..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=474780ac1e194316
dashboard link: https://syzkaller.appspot.com/bug?extid=8a5fc6416c175cecea34
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1294d2d2280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=104a7508280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: gfs2: Don't deref jdesc in evict

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
