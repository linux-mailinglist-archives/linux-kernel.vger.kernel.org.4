Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2345FFF24
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 14:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiJPM13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 08:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiJPM11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 08:27:27 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F5C3641A
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 05:27:26 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id y13-20020a056e021bed00b002faba3c4afbso7270397ilv.13
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 05:27:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=azz03TvcT1mxFATNvb208YrWn1K4n+hzSLCQr9VTN6k=;
        b=VVPc/veurQqk3vMxZrNxv6kz+6kll96PcgSuMM+AL7YR+JL+1VLooEMHsgOvfLYz7W
         mfyjB7iGHNgChJMzsZQkOkfFa66/58LZu7PlbVDvPBO4kXeYhwXU6yUSDUCsMODWOqCb
         tUwOvvTQnaonu9sVX8WYkwC9dos94mgYmOOCFAqZBwjKXUkiAmEBSU9+B7OHL3emqPyM
         f0jIO/VQ0tD5Haurolc7LGzGzLaF9NYz6wAQqmk6A8Q2tzc5xflirmdsb2tqfXwYmbZz
         AWFSdkHn2nZU/kttaT7ZDnhINzJn9hiCvzEIygEVCC1Gokyqg9Xeis4Rq8dChq8m2zsP
         BLtw==
X-Gm-Message-State: ACrzQf0nOQN0+dLFr6ED3XXzHnfKZPQ+BIwvtUU2hhG8ptv/SDjaYexz
        sbQR7iM603JtQXocODXPbFoD5jZKh1bmXxCWupVr+HnVpElu
X-Google-Smtp-Source: AMsMyM4a7qhSCCRc/XX7AHGmeXm/qwLDPeYjDvsTKFvtFN/qC2w7LWgG2Thxypd6zZyBbZqrN3t7+OBFWv0JgQoPhibW9DGJS8dQ
MIME-Version: 1.0
X-Received: by 2002:a6b:1d4:0:b0:6bb:f6c6:f03e with SMTP id
 203-20020a6b01d4000000b006bbf6c6f03emr2659356iob.165.1665923246065; Sun, 16
 Oct 2022 05:27:26 -0700 (PDT)
Date:   Sun, 16 Oct 2022 05:27:26 -0700
In-Reply-To: <20221016044826.637-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004e0e4e05eb25fbe2@google.com>
Subject: Re: [syzbot] INFO: rcu detected stall in batadv_nc_worker (3)
From:   syzbot <syzbot+69904c3b4a09e8fa2e1b@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: rcu detected stall in corrupted

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P4079 } 2683 jiffies s: 2553 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         55be6084 Merge tag 'timers-core-2022-10-05' of git://g..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=123f4ad6880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df75278aabf0681a
dashboard link: https://syzkaller.appspot.com/bug?extid=69904c3b4a09e8fa2e1b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15e1f4e6880000

