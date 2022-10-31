Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32AEA6134F0
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 12:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbiJaLva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 07:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiJaLvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 07:51:25 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4E0EE11
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 04:51:24 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id y5-20020a056602120500b006cf628c14ddso1444728iot.15
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 04:51:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=haYtoHZzLu1c3fU5UhA6SNsl7G50nkj72w4dRbQTGJY=;
        b=ldQzHtyMBEJuxFysLPf1fJb8boj9wmpbH9wUsCKvL5L1Gq+2PYW2EuK4NJOkk5bOjC
         FJwicQQYHAH4NktuvEYc8635UGcdPdjP5kBdVcXO+kbwqkscg+moGgeXc3ksrJnkGfri
         J/D4snwRQ/z5rF6YQ1Ew7CemdX4ahGt4Z9rahmp9405jXG0DDqnahQuqXB7RUGBeEcci
         EhjY1fWQOqckY0mfdwxYqOnk8TWBloXxQ3+4Vy6//dZuoWBWZRAdgmPZnJhL6HCDoASV
         8sSPOJlEZCXXJJfBKXcXEZ2YShNW8I5KqIhSQx+7dIXnal1LTsYGn4Q69d6o+4VTVmYa
         bqKA==
X-Gm-Message-State: ACrzQf2EuKXtSIkwcn9az/dib4fc3AnDZ2SlXNpuULhh9zoQfV4qBEsM
        /amm6xHUboucBynHl0o2v1sLORt9uA07Coc2Q/zkyMWGogcy
X-Google-Smtp-Source: AMsMyM6ex36MV4sCm64SwH7pDQSoXkZTsQsQ1ixuzILeIZAl4lj0NDEDqIUdlAAG/TDwVsD2JfpNn8LNJ6qJiJmywvHWPelKBE/p
MIME-Version: 1.0
X-Received: by 2002:a05:6638:388c:b0:370:cb35:edfd with SMTP id
 b12-20020a056638388c00b00370cb35edfdmr7330870jav.181.1667217082694; Mon, 31
 Oct 2022 04:51:22 -0700 (PDT)
Date:   Mon, 31 Oct 2022 04:51:22 -0700
In-Reply-To: <0000000000000d9d6f05ec498263@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fa42c105ec5339ec@google.com>
Subject: Re: [syzbot] WARNING in btrfs_space_info_update_bytes_may_use
From:   syzbot <syzbot+8edfa01e46fd9fe3fbfb@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, clm@fb.com, dsterba@suse.com,
        hch@lst.de, josef@toxicpanda.com, linmiaohe@huawei.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org,
        willy@infradead.org
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

commit 0c7c575df56b957390206deb018c41acbb412159
Author: Matthew Wilcox (Oracle) <willy@infradead.org>
Date:   Wed Feb 24 20:01:52 2021 +0000

    mm/filemap: remove dynamically allocated array from filemap_read

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=119e21b6880000
start commit:   b229b6ca5abb Merge tag 'perf-tools-fixes-for-v6.1-2022-10-..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=139e21b6880000
console output: https://syzkaller.appspot.com/x/log.txt?x=159e21b6880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a66c6c673fb555e8
dashboard link: https://syzkaller.appspot.com/bug?extid=8edfa01e46fd9fe3fbfb
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17db9ab1880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=124e21b6880000

Reported-by: syzbot+8edfa01e46fd9fe3fbfb@syzkaller.appspotmail.com
Fixes: 0c7c575df56b ("mm/filemap: remove dynamically allocated array from filemap_read")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
