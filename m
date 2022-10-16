Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8518B5FFD1C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 05:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiJPDD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 23:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiJPDDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 23:03:22 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB8133402
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 20:03:21 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id j29-20020a056e02219d00b002f9b13c40c5so6744732ila.21
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 20:03:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rMEfiN7BO4ivesfe47MbVcoW3UR3nXBdQp1MPRC65ic=;
        b=B/L9rlWFwBUPRT/Bm0pyiV/IejdSeiNU6fQgC0/fBVxc8VO7MD35UWtxPMqtKX/KIz
         oQRWvXQ/7FnUC2GgyLSsBmmN2UK+TO33IT3YBu8wIwAfVGBy1vebuzP2m8y+m1kOGbL/
         7pAvX6uSDUjudk/24mrHmK9BSaNAwrLJ58UFQ1ZCk65hjreQmS4XcW0Rs90YfSiiBfjm
         XZUnDnPnrd2Jt0oxC/MXVnhXPVniFH4v0lIlP1AOSrW9c4oTOvxpuEWNTNfvOo58LuGX
         LR2oSxvMXKNZVWUfLXmWm1UTiKzkrCux5o0kQTJ6V63ECv3J5poqH6DKNicsvxvQBf4J
         R7Ww==
X-Gm-Message-State: ACrzQf3QA+OMyyOq/4kfquENxtIxadwAgsPYScAW5FEOMD/5fk2+05qF
        kLlwO4c1RRKyqL1HXUrxahG+J/pbLw+dz9iEEYQPIPtVNBDY
X-Google-Smtp-Source: AMsMyM7vnSf2Z8Oq8SYbMIhhONAQOEUVUrI3eJiS0v+BrpGtuL417oouTw8iQcNwhnzZ/N0GYQ8KP3vROjKgvBBByeGi62hqIDRB
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c09:b0:694:51c4:8282 with SMTP id
 w9-20020a0566022c0900b0069451c48282mr2009605iov.203.1665889401222; Sat, 15
 Oct 2022 20:03:21 -0700 (PDT)
Date:   Sat, 15 Oct 2022 20:03:21 -0700
In-Reply-To: <20221016014012.519-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000febc1605eb1e196f@google.com>
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

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P4088 } 2636 jiffies s: 2445 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         55be6084 Merge tag 'timers-core-2022-10-05' of git://g..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12b0a464880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df75278aabf0681a
dashboard link: https://syzkaller.appspot.com/bug?extid=69904c3b4a09e8fa2e1b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=136f787c880000

