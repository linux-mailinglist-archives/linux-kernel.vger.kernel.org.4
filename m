Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469D2648D68
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 08:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiLJHYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 02:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiLJHYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 02:24:23 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4AA1F2DA
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 23:24:22 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id x9-20020a056e021ca900b003037ca1af0cso1397514ill.16
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 23:24:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g+a9Ql9iwWvSSIQfP/aoYCXm5wknpc2hGGVoKjPNBRU=;
        b=xkDNl/HRyb+Ajn7G+Vt5I+h9p2mTwWn1uaJkQ52SO30Fwd9IinQxL+mea0qhBzvj2W
         437wZ6usTZRHE3gdEfarK/sIHToBZ1quLjiCZlYSRJeN4J4LSL80vrljW27YkXkEk845
         oDZBvHO/l5cponI3+soQwJlBtAs7QBdCN878I4bHIwt12ler1ZJZaPQ6dZrGT0UFJtM7
         lEvr8HludIvs/JLPgcH5kyI8lh2pkODnvdBMiG6cwFiVYWFWL89YvjkUg9zPSSLaFDOa
         JxVnkAWSpYR4oIVgcAjeFdGhvfrJjj3la0JScZCaSMHydEv3dle1Whg+dJBuxlaXl5Pu
         bqWg==
X-Gm-Message-State: ANoB5plizL1MQ28lIBigAs6PzpOcQ6Dn6p3bVGFduTQiHYCehDWa4QO6
        /cxUH/yY9ClP5MU8JmiS2tNRRm+m31Tof5Dl6ccwh2GLCdf6
X-Google-Smtp-Source: AA0mqf7VNRH/XCjri7PycICQMeqjl0/JRHkrzBmIHP89YY01jEf4ioRJpLCxDCzAaBdGVTNrWuutB/s3ZDmpUrMlO7VFlcKBWQQZ
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:5ac:b0:303:9599:52b6 with SMTP id
 k12-20020a056e0205ac00b00303959952b6mr413152ils.58.1670657061497; Fri, 09 Dec
 2022 23:24:21 -0800 (PST)
Date:   Fri, 09 Dec 2022 23:24:21 -0800
In-Reply-To: <20221210011440.2050-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b133c805ef74280a@google.com>
Subject: Re: [syzbot] WARNING in do_mkdirat
From:   syzbot <syzbot+919c5a9be8433b8bf201@syzkaller.appspotmail.com>
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

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P4107 } 2635 jiffies s: 2829 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         0d1409e4 Merge tag 'drm-fixes-2022-12-09' of git://ano..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14f4750b880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d58e7fe7f9cf5e24
dashboard link: https://syzkaller.appspot.com/bug?extid=919c5a9be8433b8bf201
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1070ffdf880000

