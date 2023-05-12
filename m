Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97DDE7009F7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 16:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241465AbjELOHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 10:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241463AbjELOHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 10:07:21 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B781124B6
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 07:07:20 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-331663d8509so147780115ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 07:07:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683900439; x=1686492439;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jMsA1OvUqk2tsx55m7tIfaPeJf529B0QdbQS7E31h+k=;
        b=HAMtItoflvdZiEtjo8Bl+UEHJOlUHHDh822cMkyEE/SFqdkaqXLt/0jgIUivZBbdRN
         i50aJu1MjRwC1dswAvQc5lGZ+hjkuAe/eiMh9SjAgs7It5krd/OVsXkXM7i1TIFBPgVz
         xEwRW5StJBhIgrcIGwmru0vp9cfSci8wHgp6JflgW2GnLDyc1eTHdCC/JZ5ENZ9vBFh6
         nJfevIcwHw/fgYyEJLBUAxuCy1sITIJWKMrAeXvL/Tc6cFwncC7COGmkmmYlEm/q9xwW
         8ItDKUGWB1kKXLgcfC/Y/J8PO+gj2qUYBMWH5qCakHPKzplpiPdiQWK5m0L2F+SEBQf6
         5xnQ==
X-Gm-Message-State: AC+VfDy0EQQ4skbKazudaL+Ze/j1NYrCEVdSiVKOids1r8iFfAe+WR7/
        tF5heSPbvbyHeqcOmnJmuQQgDx0Uo52r/LmswjBxnK5VGGnA
X-Google-Smtp-Source: ACHHUZ78MXlEJPSlarcif/f+n4E+wXrSeNZwdz4IonDEPpF9krYy99Fg2BkvtT1Pz45rvxB1dwiGb1hHl8Vm/hIK24b49hIDwO07
MIME-Version: 1.0
X-Received: by 2002:a02:860e:0:b0:40f:7382:e4aa with SMTP id
 e14-20020a02860e000000b0040f7382e4aamr6776856jai.2.1683900439423; Fri, 12 May
 2023 07:07:19 -0700 (PDT)
Date:   Fri, 12 May 2023 07:07:19 -0700
In-Reply-To: <000000000000ea3c3105ef377a12@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000877b2c05fb7f9fd4@google.com>
Subject: Re: [syzbot] [ntfs3?] KASAN: slab-out-of-bounds Read in ntfs_listxattr
From:   syzbot <syzbot+9fcea5ef6dc4dc72d334@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        clang-built-linux@googlegroups.com, dvyukov@google.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com,
        trix@redhat.com, zengheng4@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 6e5be40d32fb1907285277c02e74493ed43d77fe
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Fri Aug 13 14:21:30 2021 +0000

    fs/ntfs3: Add NTFS3 in fs/Kconfig and fs/Makefile

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1587a32a280000
start commit:   8ed710da2873 Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1787a32a280000
console output: https://syzkaller.appspot.com/x/log.txt?x=1387a32a280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b83f3e90d74765ea
dashboard link: https://syzkaller.appspot.com/bug?extid=9fcea5ef6dc4dc72d334
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17e7ec29880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11829e23880000

Reported-by: syzbot+9fcea5ef6dc4dc72d334@syzkaller.appspotmail.com
Fixes: 6e5be40d32fb ("fs/ntfs3: Add NTFS3 in fs/Kconfig and fs/Makefile")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
