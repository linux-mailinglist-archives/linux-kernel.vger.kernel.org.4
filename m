Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DACD260C621
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 10:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbiJYINY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 04:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbiJYINX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 04:13:23 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA52B1B8E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 01:13:22 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id a14-20020a6b660e000000b006bd37975cdfso5886002ioc.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 01:13:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XLOp7xpgqPZjm6Drc0YPdjqhCtFFQFhL8IDoFDZdLjo=;
        b=4RiT8XL/F3XRVzrVrINVWfkiGlSAY1Qo+B2LnmAb+MZUOz6+lvATwBdkspYoJ880dk
         yJ6vizyDzf8m/kV+p3j7rDI1UZgXtF9lXzFT0U4Vlqt7yVxHQONl5V3Ngm+6UtGnz+Fs
         iV5g0C8jPTLyZ9nztcMD+CEJkpx5FGbT9V0cWetjxqxDD0hPFGLSA1Bm5VEvt5efqMz8
         cXETRNhXD1Qh9KuXwNQuLijkxU/ekBRh435JjcSZsrAeNoRsiETULyD00jWSMzGsSQ4h
         MQNxgWmll0GoCoek7vAeHQJKEfPZiXJGEk12V1cvreVQVRADRhE+7XUwhWZfam60oc6M
         oc8A==
X-Gm-Message-State: ACrzQf3lZ3Ec32vv0EfLIzodKOAL7ZRNKx2+FBx8WGaVwgfn0ZbJF4aM
        XvZdMRdr4R6Y+ozYSKQmw8CbxpfNcqB/9v45hBroU+CSiUan
X-Google-Smtp-Source: AMsMyM4XiLnN5t8Bj6/3TPw7JseGjX9MDMSgbvsmnFxG/h0l9Jtw3SIO5KcTa1gvq3Au7NCP0fBPN7tgoKOlegG9hAQYlHrUFeMj
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2a:b0:2fc:2163:5072 with SMTP id
 g10-20020a056e021a2a00b002fc21635072mr22508672ile.121.1666685602121; Tue, 25
 Oct 2022 01:13:22 -0700 (PDT)
Date:   Tue, 25 Oct 2022 01:13:22 -0700
In-Reply-To: <20221025015726.2835-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000444f7905ebd77b9e@google.com>
Subject: Re: [syzbot] INFO: rcu detected stall in sys_newfstatat (4)
From:   syzbot <syzbot+1c02a56102605204445c@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: rcu detected stall in corrupted

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P4081 } 2627 jiffies s: 2677 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         a7038524 Merge tag 'perf_urgent_for_v6.1_rc2' of git:/..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11c5b8d6880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4789759e8a6d5f57
dashboard link: https://syzkaller.appspot.com/bug?extid=1c02a56102605204445c
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13074bc2880000

