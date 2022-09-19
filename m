Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44BF5BCADF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 13:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiISLhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 07:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiISLh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 07:37:29 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C252AC7C
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 04:37:27 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id q3-20020a056e0220e300b002f5e648e02eso900487ilv.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 04:37:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=JMjjfVC91TTUNQZvcqF9zdl5PYrQQuOY0rItvZ1mhQo=;
        b=ji9Mm8Oco+q9VHTIL7/1s6OLBnJ9m/P3yX5/cmFFM+zM3ylwbHjVTkKNDVKSw6dIut
         /lUDTd0qgWT3q3gVpVeNzMkGwgNqjKIhdAgMgbSIvBGISBfZpDepkR7mey/Zh2RIBqnC
         41BPTuZ34ah2+scJq2asWks3OUXH0yCbaE2yKqCADfxWiVdYc8wgYN4wfptXAZ1iuV3S
         94hGUELr8WcuNm5U69bVxyMY61FKXQdTV++k/QlW+IeuVD8OzvB+EtIHnSeOqXZsyCe4
         XrOyJd3qkLmm2MNcX1yjpIAtnuHFPhJUmKarjZFsBd/axOK/2+98UzPZwRQS6BNvJTlI
         JMng==
X-Gm-Message-State: ACrzQf3sjfOtCEzZLy+qZxDNRGdIfG/ZE/igivwTtwvCEX9fFhxfbC6O
        j2uTqHnPztYlBS7S/X7UJeJb/cfb5XKJIBJErcBItu45kh+M
X-Google-Smtp-Source: AMsMyM5ouRz2wth5Sbyk0LnirCenat8zoIHe+G3pHVIoW2u1S0dDL9uL+VQKaLt5YLxM29l+r1E378HrNuPNyVi7J8HTvYGIEIp4
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a86:b0:2f5:96eb:52d2 with SMTP id
 k6-20020a056e021a8600b002f596eb52d2mr2396283ilv.91.1663587447049; Mon, 19 Sep
 2022 04:37:27 -0700 (PDT)
Date:   Mon, 19 Sep 2022 04:37:27 -0700
In-Reply-To: <20220919111036.1016-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d5957405e90622e1@google.com>
Subject: Re: [syzbot] INFO: task hung in hub_port_init (2)
From:   syzbot <syzbot+76629376e06e2c2ad626@syzkaller.appspotmail.com>
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

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P3497 } 2645 jiffies s: 2025 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         a6b44374 Merge branch 'for-next/core', remote-tracking..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=120d7937080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=14bf9ec0df433b27
dashboard link: https://syzkaller.appspot.com/bug?extid=76629376e06e2c2ad626
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11a15337080000

