Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F6A65A2CF
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 06:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiLaF5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 00:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiLaF5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 00:57:23 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2179B1706A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 21:57:22 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id o10-20020a056e02102a00b003006328df7bso14412057ilj.17
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 21:57:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tk5bOrII6lkUmypZzsyKwzaFfDI3eCnApyL6emxSBUs=;
        b=ssJffTccgPY5dvwjlWPb9LOArzWVFbJ9ssLAOed5ovQk//yAoXijeBITeRnX3jIYdU
         UMHLU/ljwTnnLSpAaOzdThJXifaZ9LG3aB/0Bd0ugwbNQfJIgFO1PpjG2PhT5kBHWQzR
         1J/qe0aQJcprhHEhafEPHa4QvtJ0nBD6uM4U6bMlfVpNQ8gLlgrQT5f5rILQ0q7DK9Aw
         NbtTrvFKRR0kGG65BkOhVHQhtqYC6Nm8NivpKJca5/AwjoRp0K/w6xEEzVFiiSl08iv6
         7Ug/ZfzrlHrGaV9TnxIu3/o9B6QOmZ0Hg5BZblSnEn+ZNSNubpk7ghbR2+RqZwSTpEnZ
         abzg==
X-Gm-Message-State: AFqh2kqTXzD7T16o3jFmOmLzvPK4zwrMZNxMG3M9FikYfF654o4VBxbA
        RygxeyDioCahqVbAbKk97X4lfiYDrBv7IyabCPLkXw0WSrAF
X-Google-Smtp-Source: AMrXdXur5XKocfSZe9DrCMuhvG9pzBgmwsVJIaZJgEqk6+LWS6dOhBWcSyn97DzHu+XlCcvbTSrggguU1TjG7vqJ0L/CB1C3ypHt
MIME-Version: 1.0
X-Received: by 2002:a92:d208:0:b0:302:a711:8127 with SMTP id
 y8-20020a92d208000000b00302a7118127mr2735698ily.123.1672466241522; Fri, 30
 Dec 2022 21:57:21 -0800 (PST)
Date:   Fri, 30 Dec 2022 21:57:21 -0800
In-Reply-To: <20221230235739.3228-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000039954605f11964d7@google.com>
Subject: Re: [syzbot] BUG: corrupted list in nfc_llcp_local_put
From:   syzbot <syzbot+ecb2ae7b1add2a4120de@syzkaller.appspotmail.com>
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

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P5546 } 2633 jiffies s: 2869 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         c8451c14 Merge tag 'acpi-6.2-rc2' of git://git.kernel...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1288e168480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=68e0be42c8ee4bb4
dashboard link: https://syzkaller.appspot.com/bug?extid=ecb2ae7b1add2a4120de
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=119703ca480000

