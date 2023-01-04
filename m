Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F1865DCF2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 20:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239701AbjADTic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 14:38:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240186AbjADTiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 14:38:23 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C701325C9
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 11:38:20 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id j3-20020a056e02154300b00304bc968ef1so21545241ilu.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 11:38:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4klnHWgFntXJFe1mNy3ktVGZOT5lIaQUJZBRl6du9As=;
        b=u5USPUEFl1kF+njk1X/x9kTWVS6UNh8wQ2vW1+4UxASp6g4MDBuPzZtl7LqJwiWVPi
         M8rKPsxA+Rr8IF+DRqx1Ve+I0lDlL2TRGSjx0Qw18tI2Bh/C2lYp2+l8uFtwisfag8p2
         zxGHnkm7kLgOx32PmwrRVOgDbPHgmeuAD3qiAVpV0XlX1JnxJqhRM+E5yvHV4zoxEE36
         OsvaCSh40B8mAH5RVtzkuj2Op25IIxpIOQuKg1wcT2ub9U6rABAs4yh9sn3FJPdWVm2B
         JRmhcKTkqZVxNZD+ihuoqUdlh7cDibPx5uw3EVqlkYinIxbn6qM9eA7kwt2vZUDjj1Ob
         3WVQ==
X-Gm-Message-State: AFqh2kq6a2KKPFp2XNrOa7rwDoLjZeZbqkNojdQEbKAsvvhU7U6itvwy
        EMTWlW8EBXeXAKqu0UoxEMWqI8fj+fGF+A8PtNnVGF0fC1Cb
X-Google-Smtp-Source: AMrXdXvyG+VLSqREN5kVIlZt67ykVaVDAsb4CMVjysJYq7UJqNBRTeukgJg3xjw94TDfvueU6efvADxCWW38A/y0GwmGafcXTngs
MIME-Version: 1.0
X-Received: by 2002:a5d:9c0a:0:b0:6a1:2c0c:6084 with SMTP id
 10-20020a5d9c0a000000b006a12c0c6084mr2993349ioe.128.1672861100139; Wed, 04
 Jan 2023 11:38:20 -0800 (PST)
Date:   Wed, 04 Jan 2023 11:38:20 -0800
In-Reply-To: <00000000000099fc4705f1192c71@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a1ed5905f1755333@google.com>
Subject: Re: [syzbot] [f2fs?] KASAN: use-after-free Read in __update_extent_tree_range
From:   syzbot <syzbot+823000d23b3400619f7c@syzkaller.appspotmail.com>
To:     chao@kernel.org, daehojeong@google.com, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        rostedt@goodmis.org, syzkaller-bugs@googlegroups.com
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

syzbot has bisected this issue to:

commit 3db1de0e582c358dd013f3703cd55b5fe4076436
Author: Daeho Jeong <daehojeong@google.com>
Date:   Thu Apr 28 18:18:09 2022 +0000

    f2fs: change the current atomic write way

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15c77d38480000
start commit:   1b929c02afd3 Linux 6.2-rc1
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17c77d38480000
console output: https://syzkaller.appspot.com/x/log.txt?x=13c77d38480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2651619a26b4d687
dashboard link: https://syzkaller.appspot.com/bug?extid=823000d23b3400619f7c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12597238480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11ae9d7f880000

Reported-by: syzbot+823000d23b3400619f7c@syzkaller.appspotmail.com
Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
