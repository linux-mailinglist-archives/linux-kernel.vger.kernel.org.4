Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A905B68E6B7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 04:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjBHDms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 22:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjBHDmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 22:42:45 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F3D42DCD
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 19:42:21 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id j7-20020a056e02014700b00310d217f518so11901624ilr.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 19:42:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C0ijTKp3Y+ReIoTs9tvXRXxqziMRe2/ghZUtDpSbhEw=;
        b=jvlvMgQyu+inVveOLGv7GvyL3w+P01AHa/FjqFY7BijD2gjJKkg9/Ge46HrJeR1Eb5
         uPOKy9WV+i0TGkMDmnLzxmX3B4KHp04+3Wd3qmqHojZS3N88a3GwKCMGRsLullsiza0z
         PpEdwvgTINco2Xp7LAGXNz2HDJHCPEXhPxm8s4pSRlRH9rka1V7U8UmhKSnGp4obuv7d
         ffB8xx3Pl7rAk8PDkMml77mS8SPopsfPuL/oZynMLYk4MmrpHfeyWSdAetAuBPJ/BoYL
         EZ/YZAVdkHFuceVnKVFeYISu+QWPjTzm8X4EEbV1bedIj1IShEeTITZbWGOQAOxuaSej
         jKbQ==
X-Gm-Message-State: AO0yUKUihr8ycm/jm5AEUYYD6UGT96volZIwTvr1HbpohQ07zVt0LDy5
        X/pd/xwgEGGHXHR2thah4EWAaqpNCghiUhoUaSTO9N1GS99V
X-Google-Smtp-Source: AK7set/BI6nvb1YrUoci9u2DQPy2lKsoVSrrL4oG9u2PUZshosXQQos93WxRLfm2ziJVl/Qtp7JVRJ2SrH2fW+4kdI5h6t6OvjUa
MIME-Version: 1.0
X-Received: by 2002:a02:b80a:0:b0:3b0:5216:258a with SMTP id
 o10-20020a02b80a000000b003b05216258amr3716662jam.23.1675827739260; Tue, 07
 Feb 2023 19:42:19 -0800 (PST)
Date:   Tue, 07 Feb 2023 19:42:19 -0800
In-Reply-To: <20230208031916.1589-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001a85a605f4280d44@google.com>
Subject: Re: [syzbot] general protection fault in iomap_dio_bio_iter
From:   syzbot <syzbot+a4f579527ea6394140a5@syzkaller.appspotmail.com>
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

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P5566 } 2654 jiffies s: 2877 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         986f457b block: convert bio_map_user_iov to use iov_it..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git iov-extract-20230207
console output: https://syzkaller.appspot.com/x/log.txt?x=1218381f480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6bb1911ff9919df0
dashboard link: https://syzkaller.appspot.com/bug?extid=a4f579527ea6394140a5
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
