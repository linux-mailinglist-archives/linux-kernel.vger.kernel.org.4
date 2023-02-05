Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0930E68AF5A
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 11:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjBEKdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 05:33:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjBEKdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 05:33:22 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D951E1FB
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 02:33:18 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id u6-20020a6be406000000b00716ceebf132so5554549iog.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 02:33:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JCqrZxvK10asgbl+stt0Be42IOx94Z96JN9ho01vFWw=;
        b=yu2Jd4ZbYG3sQvLfUV60g9PFBTJYpv8whitbx7ZBzytWNzcncRvplAKeExZ0Cy7fhT
         izUsSAonB2NRxbVGqnA7ExCqO0HJRqwkvdKNMjaWqTd/HvbNfX3AXoU0JubGTWgRrHpx
         urkKBrTD70GWuJHSYD2UsT7DMWQWgQToUKPtD1bdjrUbImjsPThi1KJWUfBdQWyHjhrw
         bnWWGr4CVSuOLBddd3hPogNgecj8NW37C3A9tYzbQlb8bfgVOm9tZGJkUfNHHJTiwGIv
         tZPoFLFE3QO5LBtGHOyquDT4OYnI3mhD52N2gLVltoK5+atbtWM13P0Lsj7HRMb/VHbY
         xz3g==
X-Gm-Message-State: AO0yUKW6QanIUP0K/6c8vClre/a/jP+URz8YVP0v3Qfv1hIl/gb95NAj
        BGAzCG1hq7/SouDYj+lHQGM46L/sQ0QR/yoC+TXx1TiPGnOQ
X-Google-Smtp-Source: AK7set/5tsMusXpXdXn+RY6bynkEbZgsj+7cHMC+ZJOixQJT4Mw7RpgDWoTsLNqqDhXUe2Ts3Zy89DORbb84YU21NbH9bx+uJzC5
MIME-Version: 1.0
X-Received: by 2002:a5e:d806:0:b0:704:a2da:f8f with SMTP id
 l6-20020a5ed806000000b00704a2da0f8fmr3366091iok.65.1675593197584; Sun, 05 Feb
 2023 02:33:17 -0800 (PST)
Date:   Sun, 05 Feb 2023 02:33:17 -0800
In-Reply-To: <20230205094432.1510-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005489a705f3f171cc@google.com>
Subject: Re: [syzbot] kernel BUG in __tlb_remove_page_size (2)
From:   syzbot <syzbot+d87dd8e018fd2cc2528b@syzkaller.appspotmail.com>
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

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P5557 } 2669 jiffies s: 2801 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         837c07cf Merge tag 'powerpc-6.2-4' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=154a4f45480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5ea620bd01d9130d
dashboard link: https://syzkaller.appspot.com/bug?extid=d87dd8e018fd2cc2528b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=116a0487480000

