Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC13650C82
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 14:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbiLSNP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 08:15:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbiLSNPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 08:15:25 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4877EE0E
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 05:15:23 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id l13-20020a056e021c0d00b003034e24b866so6626933ilh.22
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 05:15:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i5pIBPsEmmbOZ3cWYLkpKPQNIVoJt0tl6jhanWf54i8=;
        b=DFBm4F7UTbCbmfAy3h5Ta63YcZdGq2oBBIhbK+6zm3Mc+NDkmXlPQ2C4L+FKujPWzY
         gUDn1jtTKoWv70gH01ItIiz09rN/CJzg6DgU3CB1goPDAPtc2OmXmJh4uuqUC9kEGNjI
         /qWzalPHuWPCXjtlLeXvGk1L91xmvP5BtXwAcMkCEdU6uusfPWAOvsm8Bk+lie3f1Y35
         lN1Z5oxzqJJ7jPwBrmjeKmzPfsYQfzwnItHM33kq+nG9BjDjfBF4QO+Ykwr0DmLljmwT
         F8P+iMlOQg2O3Wi9fLTDeAfSRhUEuFAmgehAsdLp5kwoN1+VuLj/vmNPmy0ONjIG/tV4
         rQzg==
X-Gm-Message-State: ANoB5plgiBMaYanj1xXmAXH0MzHQeWp+xK4l2ysUXF8bVOVHEc2mLlvz
        GHCA7A7D+Xo+xa6h5pmAc45jpYNXbZC+6gaxQz7cf71da78v
X-Google-Smtp-Source: AA0mqf4/oq6yF17x9pdmJqrm/OifNE6JbU1V614xKFhuKiVdYrSZZKaCzzVqr107vezsOVOHzk0npyskEk3IZpKulbYvYBeZRbiH
MIME-Version: 1.0
X-Received: by 2002:a92:db01:0:b0:302:a711:8127 with SMTP id
 b1-20020a92db01000000b00302a7118127mr37398004iln.123.1671455723251; Mon, 19
 Dec 2022 05:15:23 -0800 (PST)
Date:   Mon, 19 Dec 2022 05:15:23 -0800
In-Reply-To: <20221219124321.1504-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a473b905f02e1c4d@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in put_pmu_ctx
From:   syzbot <syzbot+b8e8c01c8ade4fe6e48f@syzkaller.appspotmail.com>
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

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P5552 } 2685 jiffies s: 2817 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         f9ff5644 Merge tag 'hsi-for-6.2' of git://git.kernel.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1337f01b880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3263313469e7ca77
dashboard link: https://syzkaller.appspot.com/bug?extid=b8e8c01c8ade4fe6e48f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10acb79d880000

