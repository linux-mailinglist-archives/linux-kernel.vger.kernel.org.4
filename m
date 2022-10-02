Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF915F2534
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 22:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiJBUEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 16:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiJBUEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 16:04:20 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1527303F8
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 13:04:19 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id o2-20020a6b5a02000000b006ad1ff1dbd6so445391iob.13
        for <linux-kernel@vger.kernel.org>; Sun, 02 Oct 2022 13:04:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=alt+Pnmjzew3cSMHF8D4f4jTWwNd/We9mTfqo5aLOos=;
        b=jWCJciuExzQb4BxgbmGriAJZ2QdTxqKt1n03s5Xtu4cP76iXc8t2bH732uulPtFME2
         hZ88MKbi0CsG7u4q47N3b8u5VIPcrJW8A86UDyBc1SfTZ9Q98BLN7c1U1T6u+FbrxPWM
         5wFSt3CHKRO0Oy8vhALF7H929DpF+Gmdvc1wOXdYIcy/aZYQbq7kP4Vi68nb9aj3BMni
         TzJjY+5S+YKLDet1syOm4q8aPSJU8KDdTCaGhemRu9a+Hfnms/EyqKOrqwTgGYT4gpjc
         tNqfJVBNntnnRb9JJCZSozQto46INwgSvsFdN8JXfiwleNGrtwx1bvNzPy0dz9WUKVwe
         pa7g==
X-Gm-Message-State: ACrzQf3xDx8AcVBdV8QewnoCaY79z0xejEFAs102YZwdRjQd1nqfaq99
        dmbrL/ePqyYwh1lIrFKw52AsPzyw1WWeH/InQr7M/2SpP9Zc
X-Google-Smtp-Source: AMsMyM6VLcxZo3tjaJFXzbN/lsdTicHGhkOT9Fp7uoyQ4GhRHFgxHmgHscdmxDLKobMFvIgDK8W1sDcVNrnUqYDMsKocGpjcH2gM
MIME-Version: 1.0
X-Received: by 2002:a05:6638:150c:b0:35a:f7a9:c3d8 with SMTP id
 b12-20020a056638150c00b0035af7a9c3d8mr9235231jat.38.1664741059255; Sun, 02
 Oct 2022 13:04:19 -0700 (PDT)
Date:   Sun, 02 Oct 2022 13:04:19 -0700
In-Reply-To: <000000000000eca83705e9a72fb9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007ae43605ea12bb12@google.com>
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Read in ntfs_trim_fs
From:   syzbot <syzbot+b892240eac461e488d51@syzkaller.appspotmail.com>
To:     abdun.nihaal@gmail.com, almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev,
        skhan@linuxfoundation.org, syzkaller-bugs@googlegroups.com,
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

syzbot has bisected this issue to:

commit 6e5be40d32fb1907285277c02e74493ed43d77fe
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Fri Aug 13 14:21:30 2021 +0000

    fs/ntfs3: Add NTFS3 in fs/Kconfig and fs/Makefile

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17b6daf4880000
start commit:   f76349cf4145 Linux 6.0-rc7
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1476daf4880000
console output: https://syzkaller.appspot.com/x/log.txt?x=1076daf4880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba0d23aa7e1ffaf5
dashboard link: https://syzkaller.appspot.com/bug?extid=b892240eac461e488d51
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=133c8540880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11b74870880000

Reported-by: syzbot+b892240eac461e488d51@syzkaller.appspotmail.com
Fixes: 6e5be40d32fb ("fs/ntfs3: Add NTFS3 in fs/Kconfig and fs/Makefile")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
