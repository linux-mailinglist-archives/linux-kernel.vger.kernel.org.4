Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FCA67650C
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 09:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjAUIDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 03:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjAUIDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 03:03:34 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139915925D
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 00:03:31 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id k7-20020a056e02156700b0030f025aeca3so5179596ilu.12
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 00:03:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9YJrK3JuBtS2QgULoPaUqzJ5BAj9a0fMy2abEiu2YnE=;
        b=HUMuca18nNorMPrT3+sFsI0RDP7TxgBmIJrv9N6ch+ubogHMEZXLei64pdaUfTL8Nm
         lKWpFTUhts+im6p4JI6tvfkVD10Muwzz4BJfUP6KzBJVF+0WoSvUZI3S5lsFSt1tTcVZ
         RH8jb47Js6Zgo0apaE+VuEG3VYwsSFbXN2yO44TO3Fo8cKgaT2XAcoqfmMrs6zCm5ZXB
         PCMxFbnIfLhAl1UVTm2U5FMHqrc9s4veGBhF4+qFQJqopQVeYqI6Vi1Hk8c8y00YTYsP
         pilHbKy29LLnPfh9Zb++BrgYgkuu5xmrzjqHCNC/gXvX1FYJa9tNW6NYpP7tLPN+ov8G
         UqRQ==
X-Gm-Message-State: AFqh2kqiRKsyzMqdzKfV5BuLZJlQFt7x739tS03/xeeADMKxwuFcJqkk
        0WlyhIFt+WF58DeaHNJ5OZzedKoIT6YmNwi+TpOqdPqLH56A
X-Google-Smtp-Source: AMrXdXtPqnQD24z4QHzns98msXfMxweBfuSES5tn2xHrqj/aTn5dDoWGXHrTuSXBwVSqBBsabEwnei4Qg/cuYibJpTSGNeCzVJQr
MIME-Version: 1.0
X-Received: by 2002:a05:6638:41a4:b0:38a:3770:2fa2 with SMTP id
 az36-20020a05663841a400b0038a37702fa2mr1739324jab.208.1674288210933; Sat, 21
 Jan 2023 00:03:30 -0800 (PST)
Date:   Sat, 21 Jan 2023 00:03:30 -0800
In-Reply-To: <0000000000003a5c4905ef1044d6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000107e1b05f2c19aa5@google.com>
Subject: Re: [syzbot] WARNING in get_vaddr_frames
From:   syzbot <syzbot+59a71007ccac79e8bb69@syzkaller.appspotmail.com>
To:     hverkuil@xs4all.nl, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, m.szyprowski@samsung.com,
        mchehab@kernel.org, syzkaller-bugs@googlegroups.com,
        tfiga@chromium.org, torvalds@linux-foundation.org
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

syzbot has bisected this issue to:

commit 6647e76ab623b2b3fb2efe03a86e9c9046c52c33
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu Dec 1 00:10:52 2022 +0000

    v4l2: don't fall back to follow_pfn() if pin_user_pages_fast() fails

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=115987c5480000
start commit:   e4cf7c25bae5 Merge tag 'kbuild-fixes-v6.2' of git://git.ke..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=135987c5480000
console output: https://syzkaller.appspot.com/x/log.txt?x=155987c5480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2651619a26b4d687
dashboard link: https://syzkaller.appspot.com/bug?extid=59a71007ccac79e8bb69
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16ee1934480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=101b997c480000

Reported-by: syzbot+59a71007ccac79e8bb69@syzkaller.appspotmail.com
Fixes: 6647e76ab623 ("v4l2: don't fall back to follow_pfn() if pin_user_pages_fast() fails")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
