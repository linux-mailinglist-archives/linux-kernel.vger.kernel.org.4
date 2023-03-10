Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606376B5235
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 21:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjCJUxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 15:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjCJUxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 15:53:40 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FD4D5153
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 12:53:35 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id k13-20020a056e021a8d00b0031bae68b383so3240053ilv.18
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 12:53:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678481615;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PMB/Bp6i/Q7Jf3FSJY4xm55f2UsK69n5jbmE0xmzr4M=;
        b=WgJa2SZPOuak3mASMbXpLRWIR/dAV5QO+iDth5ZZh5fVHwpKhqFPqlqn7JEJ9LMPJT
         D2lmIiP7p3KFfU6wzvGKVf5agEqod/WtLNHHFh8k2Njp2YRpRVUDuycf90KQBXubrl6b
         yl6Wk70qZlA26R3K3CkFoTDojFgplT/fH8bMoer87OQXq5aFgyKAnoSsio9x6eftgNLS
         +RxE1xpnCxjiIgHVR5G49PO3jikBX8tP4zAqR88/q4MQO2ReBuicVBIj8RGpov4Z+U4d
         N93S/W6pmhiF3To0b8QNu5aGMYzU9DjUHT9iELVLoONbvjSRQVfBSFQnaHPG+enroW28
         UvaA==
X-Gm-Message-State: AO0yUKXOyujdi7S0kj2ls/oxwMrrolzGIMZUtIT88uScN11StBkg6fLi
        +UYo3RBYt2KqOGbUsvA9sBCW9nkGN6cBYaBE9lAriTMwglx0
X-Google-Smtp-Source: AK7set9523d3PJoqOfR2jEMGN0JGPyrp3GPsfgPrueAkojOmuzZ/Lc+Gh00c5VF4ZxpG5/AcRFQhRemv9BGvgc9A0DHDXETLa/gz
MIME-Version: 1.0
X-Received: by 2002:a6b:6a0a:0:b0:745:b287:c281 with SMTP id
 x10-20020a6b6a0a000000b00745b287c281mr12293597iog.2.1678481614899; Fri, 10
 Mar 2023 12:53:34 -0800 (PST)
Date:   Fri, 10 Mar 2023 12:53:34 -0800
In-Reply-To: <0000000000008af58705e9b32b1d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006b11b005f691f4b9@google.com>
Subject: Re: [syzbot] unexpected kernel reboot (8)
From:   syzbot <syzbot+8346a1aeed52cb04c9ba@syzkaller.appspotmail.com>
To:     alexandr.lobakin@intel.com, dvyukov@google.com,
        jirislaby@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, miklos@szeredi.hu, mingo@kernel.org,
        nogikh@google.com, penguin-kernel@I-love.SAKURA.ne.jp,
        penguin-kernel@i-love.sakura.ne.jp, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 7734a0f31e99c433df3063bbb7e8ee5a16a2cb82
Author: Alexander Lobakin <alexandr.lobakin@intel.com>
Date:   Mon Jan 9 17:04:02 2023 +0000

    x86/boot: Robustify calling startup_{32,64}() from the decompressor code

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14606624c80000
start commit:   1fe4fd6f5cad Merge tag 'xfs-6.2-fixes-2' of git://git.kern..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=edc860b1c9b6751
dashboard link: https://syzkaller.appspot.com/bug?extid=8346a1aeed52cb04c9ba
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12baac4a480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=118bf42c480000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: x86/boot: Robustify calling startup_{32,64}() from the decompressor code

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
