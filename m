Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97FA8627277
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 21:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235381AbiKMUab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 15:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbiKMUa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 15:30:29 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927C912608
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 12:30:28 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id i26-20020a056e021d1a00b003025434c04eso2217481ila.13
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 12:30:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nO4A/V+XMKyBWWRWUjncAFNNvtrkiBXS4cfO5G7DtN0=;
        b=bMh4BWt1psSCuZ/yBEJDQ4xasFkZDjVEuwD/i7IZ5AclzDE/PgHFCvXPa7f+VmSnSG
         eLxn+atq7WcnJGXFCnGkwKqTWZbTgU8ljiNX0OOJFFDlf8m3bN/LCOm2dZwtjhP2iyjz
         8ybPPNO9JxiObOLUPK2sode2CCL1mSCdnuBNdDBVU17xPaTMjRU7DHfGeWvWOpwbW6Uc
         PGHsFlVCvq+brgphwuV7KWO5YektwTJIB9gt5mXVU6M2LsUkZpu5rHoyI0hY5YYpGjRG
         YjGct/2/grKeKj+ATSr0AJyjqhvHWsCbrMQAYCr5XWUztnuUxUpHlZ9OuVTqJkyy42/R
         obvQ==
X-Gm-Message-State: ANoB5pnX8knZwwuAhMj7TSfqaCCyNjUFSkmlm6o2lTRJLE+S/kg5Fqs5
        WliZ5MHGidCopLIURfen9RC9aBO+jSrKg4I5Z3bIfn6Yik+A
X-Google-Smtp-Source: AA0mqf45xp/J1UQnDD1QjPXvWlLARkynFQLjX9shzGiRTMM2C3k2crEnTy7wkF9gxgC+OExiJYjkAqFk5P9TLLwdFiaDJ+sknAMp
MIME-Version: 1.0
X-Received: by 2002:a02:602f:0:b0:375:13ba:6b08 with SMTP id
 i47-20020a02602f000000b0037513ba6b08mr4307455jac.283.1668371427955; Sun, 13
 Nov 2022 12:30:27 -0800 (PST)
Date:   Sun, 13 Nov 2022 12:30:27 -0800
In-Reply-To: <20221113115249.1845-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000511de505ed5ffe6a@google.com>
Subject: Re: [syzbot] WARNING: locking bug in hugetlb_no_page
From:   syzbot <syzbot+d07c65298d2c15eafcb0@syzkaller.appspotmail.com>
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

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P3507 } 2668 jiffies s: 2069 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         1621b6ea Merge branch 'for-next/fixes' into for-kernelci
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=108ca515880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=606e57fd25c5c6cc
dashboard link: https://syzkaller.appspot.com/bug?extid=d07c65298d2c15eafcb0
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=174f46d1880000

