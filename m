Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C614860949D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 18:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbiJWQIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 12:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiJWQIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 12:08:22 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2521768CC1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 09:08:22 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id y4-20020a5e9204000000b006bbffbc3d27so5185613iop.5
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 09:08:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7epgeZqNBvzj5gC80crbhaYdIlZKNwX+R2sHVW9JIwU=;
        b=Jnd1SSR/bCHV8DrkVC73AslbDB66WTWcAqZEqwloYjxz0+WtSAFPSuIWIZFQ1mp8Af
         Y7o6CjACIsOAgZTQ+w1eLmuS8ErmZpqKJd9iBRGCNffDSb28asxnCg1O1BILGr7IWFzM
         +ccMlsdFBn9HhWZyb3eTKtdoC+BTwZmvzrdQDYaYBcxawxGk61EF0sZ77/nx/dz4xApA
         wWEW5p2wk7M+n92Sj2cqRbPsi0c8sX1ic2hxIDBpv+7mJCUgbBk7IjkQWIn4jCyLjotC
         c3MjRDtHD5qQQ8NuG1ngpqCPwDfvxFvriD4puxEaUm7vAeOWiAea4svjruTwnEdeGG1k
         H0Gw==
X-Gm-Message-State: ACrzQf0Q89wxXQlJYFnZqoBC6ZO0CLR1yLhdx5vsXg269Oq9kjynV8ga
        D1hpevn/e3sYweO5lEJZ9CYle7w1KLdORfGlK4SjUbqTWWub
X-Google-Smtp-Source: AMsMyM6TO/k+QCLX9WfdzBnG78z+vPeyhly4YZIJ5p/YulzmSNVhV+TjvSklvG4Qwu1aUUs8aCONRfydYwYAccWPqIYLVfWpYe/N
MIME-Version: 1.0
X-Received: by 2002:a05:6638:140b:b0:363:fdeb:fc6d with SMTP id
 k11-20020a056638140b00b00363fdebfc6dmr19614493jad.135.1666541301496; Sun, 23
 Oct 2022 09:08:21 -0700 (PDT)
Date:   Sun, 23 Oct 2022 09:08:21 -0700
In-Reply-To: <20221023135812.2493-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000047843305ebb5e2df@google.com>
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

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P4079 } 2646 jiffies s: 2653 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         d47136c2 Merge tag 'hwmon-for-v6.1-rc2' of git://git.k..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1613fd6e880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4789759e8a6d5f57
dashboard link: https://syzkaller.appspot.com/bug?extid=9b69b8d10ab4a7d88056
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15434bc2880000

