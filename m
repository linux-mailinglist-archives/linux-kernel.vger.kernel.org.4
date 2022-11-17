Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682F162D407
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 08:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239296AbiKQH00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 02:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234615AbiKQH0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 02:26:24 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3E14299B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 23:26:24 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id a15-20020a056e0208af00b00300806a52b6so717402ilt.22
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 23:26:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rPPkD9xqKnwp/YGjdMZVDWgGrC9/htEwoZFuymgo5P4=;
        b=bM+EYcKr9P9MW81WY5y0ov88tgSdIdgxwWtEfJS3RbJ6EZGqb8V6WKPXk1BS6STrgz
         tH779Xqq+POBv5OCj44kXugtDIegbqpHB9Z23pJulmbeOSMT/5ZH+n7QbagDSLK52G5S
         G8XcPWDzvSAaBok44qbDUmrOG3fAplDsOz9EumzhbiX4YO9bedeBfmfyyxWpy5qcrF12
         s7WnOs5dPUXmoUU/41YbVVQW5RPtkfbcXuVd4cMGoUD+spgLkvRfpmFuYky7bLcvKBjz
         3jpzDDGLyp96LtJ9i99zQL1mxDQ3DkPnIKzC/inA0Bb6fwVpMuGKt+jDgfHKRI5dsqLq
         E6DQ==
X-Gm-Message-State: ANoB5pmI6327bavje165DQBfB9+u95kQFMwK1MzEeukaGYBMbpv0o4X/
        rmZqsAgop16azSy/Hjxp+HSdZpasfpKzbTlb/nvvOFdJSZNr
X-Google-Smtp-Source: AA0mqf5y/RluP/QBFQd6C1C7ZYqv72TGmOA4tDOZRPmkadLuAmV6rAYdlmAaQg7n8lWosrmirqFP+rTsKvul43RVyp+thnTMwE9F
MIME-Version: 1.0
X-Received: by 2002:a5d:88c3:0:b0:6d6:5fe4:8212 with SMTP id
 i3-20020a5d88c3000000b006d65fe48212mr828952iol.180.1668669983607; Wed, 16 Nov
 2022 23:26:23 -0800 (PST)
Date:   Wed, 16 Nov 2022 23:26:23 -0800
In-Reply-To: <000000000000385cbf05ea3f1862@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009ed19b05eda581e7@google.com>
Subject: Re: [syzbot] general protection fault in kernfs_get_inode
From:   syzbot <syzbot+534ee3d24c37c411f37f@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, andrii@kernel.org, ast@kernel.org,
        bpf@vger.kernel.org, brauner@kernel.org,
        gregkh@linuxfoundation.org, kafai@fb.com,
        linux-kernel@vger.kernel.org, lk@c--e.de, martin.lau@linux.dev,
        peterx@redhat.com, shy828301@gmail.com,
        syzkaller-bugs@googlegroups.com, tj@kernel.org,
        yosryahmed@google.com, zokeefe@google.com
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

commit c6a7f445a2727a66fe68a7097f42698d8b31ea2c
Author: Yang Shi <shy828301@gmail.com>
Date:   Wed Jul 6 23:59:20 2022 +0000

    mm: khugepaged: don't carry huge page to the next loop for !CONFIG_NUMA

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=179cadcd880000
start commit:   55be6084c8e0 Merge tag 'timers-core-2022-10-05' of git://g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=df75278aabf0681a
dashboard link: https://syzkaller.appspot.com/bug?extid=534ee3d24c37c411f37f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=150adc52880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=149d9584880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: mm: khugepaged: don't carry huge page to the next loop for !CONFIG_NUMA

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
