Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42254683267
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 17:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbjAaQSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 11:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbjAaQSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 11:18:05 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E319577E7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 08:17:31 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id 8-20020a056e0216c800b00310f6cf1129so3842357ilx.15
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 08:17:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iiAqoUAhSbXRWu7WwqUljNKrMQeqVBW7GAniuAjL2v8=;
        b=l5KEtKsFHWWHiA83SzAz6y/vq/+2BCJSetxXzqQ6QQpOUVdA+C2XeXZrBi/7ojSBHh
         ZKmkluaBQxoMzcwgd+4UJkc99xqlUr/ufUJ7YmgxX9QgCZcHtjNRcs2MtPCFaPjj2w3e
         YUY0pO0z1rzMI3GhMIWqJ5g2I/oxOrO0GXb0fTQRAQ2JC+MaahZ3+vouD48W5ZHdwOJJ
         wN8auKG8WsH8Sg61bcygCJ0W/TpSZFa7oRabzxfeviQZECuYiLDpdZr7xEzLjTzWk97O
         F3MKsuKM3DNRahqoSxuPc13YC7OnVyLp9hnfl5iS4rEFE6FLcJvlJTJzRuf0HeuJOuql
         BVNw==
X-Gm-Message-State: AO0yUKULKZPOYhdYLGOTKM7UK96GhK8paENfmo/DymBRH95hqkeRiG/A
        PYQqYrGppESV334CkpSPs2LrqOyTPpWuwJV+JiK7fkrURVjt
X-Google-Smtp-Source: AK7set/OHuRu/Wj6tf33O1Z3bSTQrgB1o8gZPL+3utcc+aaXpdr8cyGKqn5K0ftPFAMPNtpPy5ckI+3V6HgyfU38NTkTGcFgjtrJ
MIME-Version: 1.0
X-Received: by 2002:a02:a418:0:b0:3a9:67b6:18bd with SMTP id
 c24-20020a02a418000000b003a967b618bdmr3800070jal.46.1675181837697; Tue, 31
 Jan 2023 08:17:17 -0800 (PST)
Date:   Tue, 31 Jan 2023 08:17:17 -0800
In-Reply-To: <0000000000008be6b405f01164f8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005eca3205f391aade@google.com>
Subject: Re: [syzbot] [ntfs3?] KASAN: out-of-bounds Read in ntfs_set_ea
From:   syzbot <syzbot+8778f030156c6cd16d72@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, ndesaulniers@google.com, ntfs3@lists.linux.dev,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
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

commit 0e8235d28f3a0e9eda9f02ff67ee566d5f42b66b
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Mon Oct 10 10:15:33 2022 +0000

    fs/ntfs3: Check fields while reading

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11d9c385480000
start commit:   02bf43c7b7f7 Merge tag 'fs.xattr.simple.rework.rbtree.rwlo..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c59170b68d26a55
dashboard link: https://syzkaller.appspot.com/bug?extid=8778f030156c6cd16d72
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=136b8f57880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=175ca3a3880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs/ntfs3: Check fields while reading

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
