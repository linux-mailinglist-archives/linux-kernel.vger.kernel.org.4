Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A4D6493B9
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 11:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiLKKmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 05:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiLKKmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 05:42:19 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94602E0E9
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 02:42:17 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id a11-20020a92c54b000000b003034a80704fso3277812ilj.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 02:42:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mTLXLz0Yqnnl7blWQ8qwUjLEzmVCWr1GK3r/EpeDXQY=;
        b=K90j7RGnThJk10rELrtLgttL9ttddKp0OUR1jsPpTqdA8YbHiRiI89FZ2A2sFY827G
         pgODkX/qi6iZkuz3pm0apAZB0RZ6z1pEfSq1/s3wGuJIITbXskpuror1166V2T/gO3pC
         x2VGIrJmyircIW23Pj2x/g+/c3nx8cctPptxEeqEAW1ES1n+NrCAiAmcUeCqR6u2oXIM
         jTMEBlyyBIuBO2WIRUUQqLdk/rwQZZ70n7vAUc5pqKpyTBxNOGahIW4y/Eds8sm8zQq3
         06dTXp9cZLgE+ZefbNQj+qy1W9mLzmz8+o85jLNxQvjxAu3gk2LB4VPiJF0x+CLe2ALm
         t4cw==
X-Gm-Message-State: ANoB5pnjratTBrCQ+GMkWIiYKdPOgDHmCvY3hIefS6xdFu7HDvH6AioI
        R+EZna/zYkpSqHtM3lGzKce3a37zSJ4ms1Jk3nhY/w6UaA17
X-Google-Smtp-Source: AA0mqf6D+OaJgdbCVlRl3UEi2lYa1tIbvMAs/5pLhmAF5LpEZ8NRNznaOTgl9mCTp36AvMCzWZpySdumDetWSaQsvkCHly9APzxB
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4183:b0:349:fa5a:a80b with SMTP id
 az3-20020a056638418300b00349fa5aa80bmr38339710jab.23.1670755336919; Sun, 11
 Dec 2022 02:42:16 -0800 (PST)
Date:   Sun, 11 Dec 2022 02:42:16 -0800
In-Reply-To: <20221211014342.2302-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005d216f05ef8b0a6e@google.com>
Subject: Re: [syzbot] WARNING: refcount bug in nldev_newlink
From:   syzbot <syzbot+3fd8326d9a0812d19218@syzkaller.appspotmail.com>
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

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P5545 } 2629 jiffies s: 2809 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         591cd615 Add linux-next specific files for 20221207
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=13b5948f880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8b2d3e63e054c24f
dashboard link: https://syzkaller.appspot.com/bug?extid=3fd8326d9a0812d19218
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1119320b880000

