Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B066643BAE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 04:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbiLFDMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 22:12:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbiLFDMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 22:12:17 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3A625284
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 19:12:16 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id y5-20020a056602120500b006cf628c14ddso11010407iot.15
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 19:12:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UvD+MZjtUR1zcO4JD+kq1ILF5xn9xebsMtnvhQcAkAE=;
        b=Ivubxhp8rhfUu56z9lFLcg1dEixpBA/plWP9arUmFEOhIV39ELGVbLc+mi6lcLSFPH
         JZZMoC3xExsStBuaXnvwvgkuJ0+v2GZxhv2LJRM3A+QClq9ObINwmGoa0oRnh3aAHejY
         jOQyBGDSIvG1aG3TQoqT2/Ia21EieIoPOPjVKXYboi3L4EmXW4hsvEeyEbkp32yk/G7J
         bnYs8ehXbujJaYvZLPEYyVKZkOns8AxCv/IoalBN43VtMllGXu4BDGNQ4XOqOIggjQ50
         g7Im/4RLb0LF4Bu+ETz8HF7+eafj+sn7JcaF4ZVqpyyeEw5vHvSAuTHff9QXPnZnBDeh
         8dhg==
X-Gm-Message-State: ANoB5pn5saFwA+fXbmskiQZxw6yEB0+/sXieS0x4OuzbNdID9RmrEDZl
        FQzPA/HzowAdRvjJl+meR31Evnw77epuefHIQMrsM0AVWl0b
X-Google-Smtp-Source: AA0mqf6A0GebHKYwEIp76zOIrRahHhD9zg1SBqJJFP7ufPb0tnRDBwWyKhcL9tmmAF8gUTA4P7QEV6FIh3yV6A26PFMBJA+62NY8
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:156c:b0:303:4885:a1fe with SMTP id
 k12-20020a056e02156c00b003034885a1femr6044451ilu.261.1670296335371; Mon, 05
 Dec 2022 19:12:15 -0800 (PST)
Date:   Mon, 05 Dec 2022 19:12:15 -0800
In-Reply-To: <20221205235827.GR3600936@dread.disaster.area>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bd587705ef202b08@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in xfs_qm_dqfree_one
From:   syzbot <syzbot+912776840162c13db1a3@syzkaller.appspotmail.com>
To:     david@fromorbit.com, djwong@kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: rcu detected stall in corrupted

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P4122 } 2641 jiffies s: 2877 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         bce93322 proc: proc_skip_spaces() shouldn't think it i..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1566216b880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d58e7fe7f9cf5e24
dashboard link: https://syzkaller.appspot.com/bug?extid=912776840162c13db1a3
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=164cad83880000

