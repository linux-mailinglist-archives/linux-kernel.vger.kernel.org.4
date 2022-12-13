Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B81564ADF1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 03:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234323AbiLMCyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 21:54:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiLMCyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 21:54:22 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFBD13CC4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 18:54:21 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id o22-20020a6b5a16000000b006e2d564944aso1125902iob.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 18:54:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J6NXenqjtVYmfkITCWeR0vH6LO9Y9xEemg5D/oyg1+s=;
        b=a7suDPA9jX7MXGbY1Em3cPmZ8d3/5R1WpKtBWB3Md8Z68Eg5M53amCplgVFqtQWa6L
         sjXo67goLljBmWQdO5qhuhjJNTMPR/Q4HUBnjRYua+Sy60kKddqj59nRUHpJQ+zqN8WL
         qi+kWDhG7uNRFt+I+7phk+ox3jIbUATd8/bahp1hS9TJoQmYGN1PMKCmLf9oCV3q8ZM4
         KQ/nybf/LeJpdmJHVT3a1oNUs0Gua/B36gEPO9ONMOQQhnfJYGlNIA/L88e0bSmlWx4R
         we/8cp1d7WLmA09yLXb1NOsbnGmMgE9lE/g5HR3wc31ojDWuMWsG3zwCypiIv04FcMwo
         DTHg==
X-Gm-Message-State: ANoB5pl/HzA7T/RHXMa1ggrmlaGGHgI7h4L4LR7H5f7gWF5jQ9qi8TNH
        Gfy1RHiFs5LIQDIhM+5AxkvYk+sHdSijj3hzOWegsPP5YuaA
X-Google-Smtp-Source: AA0mqf6kFyLPDYcVBDXKwlY1p0FjHb8+of7QeMhe1QP0YpiQ2cA1DSSvzDKAJW9FqWMo18v64960+pqM0TVAfVDx/l84uI9xJiyP
MIME-Version: 1.0
X-Received: by 2002:a05:6602:208e:b0:6d6:8034:5cc3 with SMTP id
 a14-20020a056602208e00b006d680345cc3mr43478765ioa.10.1670900061234; Mon, 12
 Dec 2022 18:54:21 -0800 (PST)
Date:   Mon, 12 Dec 2022 18:54:21 -0800
In-Reply-To: <20221213002232.3295-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009aed2905efacbca6@google.com>
Subject: Re: [syzbot] INFO: trying to register non-static key in xfs_buf_delwri_submit_buffers
From:   syzbot <syzbot+11d99e499adff05631cc@syzkaller.appspotmail.com>
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

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P3560 } 2671 jiffies s: 2021 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         8702f2c6 Merge tag 'mm-nonmm-stable-2022-12-12' of git..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=10722ab7880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1cb72ec9ab8aff5e
dashboard link: https://syzkaller.appspot.com/bug?extid=11d99e499adff05631cc
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15d7c70b880000

