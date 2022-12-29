Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231AC658BDF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 11:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbiL2Kn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 05:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiL2KnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 05:43:23 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C0310D9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 02:43:22 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id n15-20020a056e021baf00b0030387c2e1d3so11560932ili.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 02:43:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AVZe/ZcDLGzbgimBmtoeRFLrvHFtP/VZCFFPbV88TaQ=;
        b=7QuqnoCc/Tql6xWOOFhbijOyeAOQLQMWofJ/eH6N2AVkPShS32zFvL233cjngj6e08
         uMsAunU7q3F7g1O6Nrd0uH6c5ECe4kKohIIECUzPjkQKudOEIfCyvn6Qt+FgKVy2wRhR
         C61c1VqKcMD5mwmJIzukATUnhuKafFZccu2WWI7SWXmZyGLU1zqVMd73hp17CuBWB/6P
         RT/iRXIewdMtrUlIFZG9iz5td5oW+8BvcE51F2ct2wtWEda55S4ASDGc8g8rgEe522LP
         o8mPn6PNZi3jbs3C8Z3SXdO2NKkuW2Ps+m41VT/GzbvF/ScGc/uguCiHTgT09v2ny+Qg
         Lbvw==
X-Gm-Message-State: AFqh2kqm1I1/5DhGvOIuVBe+U43pQXiXEIYriaOdn/DNJg691ZR3vzGx
        HYbN8fv0E1eJf0V4AZjGU1TKRhRw5WyuknIKdPYm8NeOogsf
X-Google-Smtp-Source: AMrXdXvFC/5R6g1r1B5xOd/HLfv88l70ulSJMpD3+EOC//z9HVHvz59QEFHHNzlfXY3fY/QZD2wsWltUqGI0TqzKQ4oO80Zw/T43
MIME-Version: 1.0
X-Received: by 2002:a02:cc9b:0:b0:38a:5876:4ff with SMTP id
 s27-20020a02cc9b000000b0038a587604ffmr2382846jap.178.1672310601803; Thu, 29
 Dec 2022 02:43:21 -0800 (PST)
Date:   Thu, 29 Dec 2022 02:43:21 -0800
In-Reply-To: <20221229101603.2931-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005ff09b05f0f5276a@google.com>
Subject: Re: [syzbot] WARNING: locking bug in inet_autobind
From:   syzbot <syzbot+94cc2a66fc228b23f360@syzkaller.appspotmail.com>
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

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P5564 } 2687 jiffies s: 2885 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         1b929c02 Linux 6.2-rc1
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=124c2632480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2651619a26b4d687
dashboard link: https://syzkaller.appspot.com/bug?extid=94cc2a66fc228b23f360
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16485ff2480000

