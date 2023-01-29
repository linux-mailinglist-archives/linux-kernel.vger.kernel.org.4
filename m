Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8681567FD80
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 09:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbjA2IAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 03:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjA2IA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 03:00:27 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD4F206A8
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 00:00:23 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id g11-20020a056e021a2b00b0030da3e7916fso5672342ile.18
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 00:00:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iWUjXLTnw3h+L3dZwm5YKP98PHZMaQaUEy4gOEVllR0=;
        b=3EzkcfWvV4MpOKV7At8dVcnJi5GVR6wvTO/XCi6qIld1Uayz8n+WzwjXBjwVSeZW6A
         /eqUGU31NPCShnO18hDmaYFHHmZZlQxiYOKIRi+I+jx/IXb7dmAQUTaZL3sNob/SK7Uc
         2Hao4iwX8j/uRjZ/v78y+T1tqBiqlrhr0SJgkmRLsb5kENV8RC8W8l2hYXfUbOgvt+dI
         Zx26NVmoJdzVanfMwN/1oZaxEGXkNM4gSoqyx3f6zsKBpBsTUM6qGLp9gzBvnD8jTfKG
         pdVYe7tWlGGnVj6Xm48VUr/SGcrBpmK3YICj6ch0ELkEwalOdOyiwRuPvR6VLUZe7zG/
         T2MA==
X-Gm-Message-State: AO0yUKWgBdT7fAnEOgKmGhnaSY4zUkBhe2wv/DcsF3Kghrx3iiYmvlzN
        OBUmI9iDc0h6nbstd7wAp2WssZo67rpPwtkidSyyKHEyEEc5
X-Google-Smtp-Source: AK7set+kUJ90GQ7HGXxpBff9eEcbdEcLgNAdzlX2Mf8X4xcjkWW2R9ZNa7JKjDRN4WMZw4u6J7f3RfS2pX3PS1zWMS+aL+pM2RyE
MIME-Version: 1.0
X-Received: by 2002:a92:3004:0:b0:310:bb17:2ffb with SMTP id
 x4-20020a923004000000b00310bb172ffbmr1222681ile.144.1674979222613; Sun, 29
 Jan 2023 00:00:22 -0800 (PST)
Date:   Sun, 29 Jan 2023 00:00:22 -0800
In-Reply-To: <00000000000076699c05ed7c54a2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000091f75805f3627ddd@google.com>
Subject: Re: [syzbot] possible deadlock in btrfs_commit_transaction
From:   syzbot <syzbot+52d708a0bca2efc4c9df@syzkaller.appspotmail.com>
To:     anand.jain@oracle.com, clm@fb.com, dsterba@suse.com,
        hdanton@sina.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
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

commit b740d806166979488e798e41743aaec051f2443f
Author: Josef Bacik <josef@toxicpanda.com>
Date:   Mon Nov 7 16:44:51 2022 +0000

    btrfs: free btrfs_path before copying root refs to userspace

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14e58bae480000
start commit:   08ad43d554ba Merge tag 'net-6.1-rc7' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d01b6e3197974dd
dashboard link: https://syzkaller.appspot.com/bug?extid=52d708a0bca2efc4c9df
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=114d3e03880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1320ea4b880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: btrfs: free btrfs_path before copying root refs to userspace

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
