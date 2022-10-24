Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788E160991B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 06:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiJXEW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 00:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiJXEW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 00:22:26 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716C46AA38
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 21:22:25 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id u2-20020a056e021a4200b002f9ecfa353cso8136538ilv.20
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 21:22:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MlyBCNpOtvhCz8HWK9S61rmpnR5b87b9y2Ds3Fl5h/4=;
        b=6CO7nqVOC0zMavdABLOTFPwBM01Y2KI+ZzYgaPmnrUeg2qLclm+kI1y5qy+NDSR+SI
         14KbrH/8NGw8p+ivbHbon6dxr4Fr+F22cw/vmPBQA9d/thMmNMulpT5jE7nEz0i8KFji
         6U1OCozLNeRXFMZhonx+fMwnFpQg71I1TvkSFY8fnalf4KSIj4z/N2fHyJMVfI6Ffi8W
         N+bySmM+rt7b+qm+Ixll7f7oLs0gK6r7O38Orji9Y3gDBfUzV0aHQjBC38i+hk+gqEBv
         +rzTmTJ0Pef8NCncvac2yu1amvIgyQmfWTGj8ZIqZZmcTd4ycGqGU91Rds9Y7giFGVzA
         vQYw==
X-Gm-Message-State: ACrzQf0e6UDjxDZ3svVoTJrvgIhg3z/rNjyBMqNYgz47plKDlPoUen7X
        AXVqFuIFYL0GSRt73eAGmcDx+MwvIfoGDwQfWCJuSzFuyWx1
X-Google-Smtp-Source: AMsMyM7jdGUmipeZNhGyTVAo9oa6uQw5KunSo+b1ZTD/ZdH6xF+KubgnzKlEy2BfAnNdxEis7aQbLletur558C5tR0p77a2OTxc/
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1314:b0:363:b321:8721 with SMTP id
 r20-20020a056638131400b00363b3218721mr22964828jad.271.1666585344796; Sun, 23
 Oct 2022 21:22:24 -0700 (PDT)
Date:   Sun, 23 Oct 2022 21:22:24 -0700
In-Reply-To: <20221024012302.2611-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000076ee7c05ebc0238d@google.com>
Subject: Re: [syzbot] BUG: corrupted list in p9_fd_cancel (2)
From:   syzbot <syzbot+9b69b8d10ab4a7d88056@syzkaller.appspotmail.com>
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

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P4081 } 2640 jiffies s: 2857 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         aae703b0 Merge tag 'for-6.1-rc1-tag' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=161be616880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4789759e8a6d5f57
dashboard link: https://syzkaller.appspot.com/bug?extid=9b69b8d10ab4a7d88056
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=153d373a880000

