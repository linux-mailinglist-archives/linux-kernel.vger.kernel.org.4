Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1EE661C61
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 03:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbjAICe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 21:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbjAICeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 21:34:24 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC218A45D
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 18:34:23 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id s22-20020a6bdc16000000b006e2d7c78010so4083062ioc.21
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 18:34:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7rcvn48tUUP2FTlVeQr9AifQJvd5jYKtHm0iLNtdMWo=;
        b=eK0C8fBRF3Xf3yknk/U4jwM8g6wcL6gETybhSgXqDfQ0lzKBIuPIlLfRxYVH3tb6yr
         bbzCbc7PU3pam6Dp8n5rfaNxlmd/xllSerLWov2grKZ2lEmjP+VcRLU65JJeNaWdIOvy
         IdISK+qySUz7O52L9g0QoiDyPzSA9BIbV2SpS6Vdask9i8zeVtgZ7hjGvzu75+67PTlT
         2LCFex2g3PrES40KVZJKlwRrxdFerpPA1tCx/Xmy7r8ceERo+fNEpCFM6JWBxeSA5SEh
         52++T2al84Xs8Pn0YNCs/ojud6iq3AX2KXS89hsieI1P0I1K6hyCTCx32FLE9BXL/GLT
         Wz8w==
X-Gm-Message-State: AFqh2kq0vI+nd6lm24DhEe0zdhVkB8W7XKZsbP1tx9c1GeC0p3CKQc4q
        mf+bQmnKiBuj2KbG7kYs+9la5TU3o32dxHWT0E2TltyyZER4
X-Google-Smtp-Source: AMrXdXtyWF6n+SkKThTewWuMsVgJytLmOd3j80ZHF91ZEghmQIZLMZWR3G3eciaEYPpa4ngxefOi+N9m74PC8PJNSe2a8p9saJ3Y
MIME-Version: 1.0
X-Received: by 2002:a5d:9655:0:b0:6df:f621:ee37 with SMTP id
 d21-20020a5d9655000000b006dff621ee37mr5198929ios.174.1673231663100; Sun, 08
 Jan 2023 18:34:23 -0800 (PST)
Date:   Sun, 08 Jan 2023 18:34:23 -0800
In-Reply-To: <4be0a7d0-a1ac-1cd4-ccba-77653342efdc@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e7f96f05f1cb9a84@google.com>
Subject: Re: [syzbot] KASAN: wild-memory-access Read in io_wq_worker_running
From:   syzbot <syzbot+d56ec896af3637bdb7e4@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P5774 } 2664 jiffies s: 2777 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         e6db6f93 io_uring/io-wq: only free worker if it was al..
git tree:       git://git.kernel.dk/linux.git io_uring-6.2
console output: https://syzkaller.appspot.com/x/log.txt?x=116df816480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2edd87fe5cbdf43f
dashboard link: https://syzkaller.appspot.com/bug?extid=d56ec896af3637bdb7e4
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
