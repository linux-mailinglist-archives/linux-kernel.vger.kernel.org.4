Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C62464A9C0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 22:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbiLLVvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 16:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233660AbiLLVvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 16:51:20 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CCC1A05A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 13:51:15 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id o22-20020a6b5a16000000b006e2d564944aso750389iob.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 13:51:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zNaZ6e3bL8FrYNSX7WWn3R0dNj/jHy6kmI5/TdY9Eq0=;
        b=4G9KTwo6h3z7Vc1OBPbqZt09MVNs17vX6rRboGnxQtgDyueU6xffdsQBJWS8f1zfyr
         Z85tSWM24O391bQGhZ6Ius6L7Zub/w1b/JDrcaUQwWelm2tzkvd56ciLAqEl+mS2Tg+V
         /TpGzwwU6DUt3KSlP3OnNLyKzOtJ/iCoT2bnfz4vqdQhzMozfsOl+VYjWIU9RxPNEJuN
         vSe3Pq6GHEbVH6hRI7IEzkFDONOiHKxlJhNHFW65RrBKhtVo0uTmTaC1IDEAZmor8nHO
         k3/cx2oH2tM9GKP/to3TvdBMcndE/gq3eYbpwKcIR8uDfnfHdzb94ttDWlTw0EvJzUAw
         cEqA==
X-Gm-Message-State: ANoB5pmayBZsfCa2oBrkjPxaSBNnZcV5AvQRcyUs0z/vnrdE7px2XYbQ
        huiZ24wZAajKOJcJdwZzgzBSWXGSKAmGxr1A1s75EYzvFnGL
X-Google-Smtp-Source: AA0mqf6jqMv7M77OBomP7gusjfhwCXSJrdgLBkP/Vyzgisz168KR/3oWdo6DNm2uN3Cb218KYI2ME9dzW1AGiYVWs5qklDrwKrR4
MIME-Version: 1.0
X-Received: by 2002:a6b:f005:0:b0:6e2:e641:b6ec with SMTP id
 w5-20020a6bf005000000b006e2e641b6ecmr821212ioc.198.1670881875046; Mon, 12 Dec
 2022 13:51:15 -0800 (PST)
Date:   Mon, 12 Dec 2022 13:51:15 -0800
In-Reply-To: <20221212093114.3171-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009fba8605efa880f0@google.com>
Subject: Re: [syzbot] KASAN: stack-out-of-bounds Read in xfs_buf_delwri_submit_buffers
From:   syzbot <syzbot+d2cdeba65d32ed1d2c4d@syzkaller.appspotmail.com>
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

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P4099 } 2665 jiffies s: 2737 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         631aa744 Merge tag 'x86-misc-2022-12-10' of git://git...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=123cf493880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e34a07f2e864168c
dashboard link: https://syzkaller.appspot.com/bug?extid=d2cdeba65d32ed1d2c4d
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13bf14ed880000

