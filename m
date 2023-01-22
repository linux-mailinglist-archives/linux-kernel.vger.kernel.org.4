Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE5D676C3E
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 12:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjAVLOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 06:14:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjAVLOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 06:14:23 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A300E1C31D
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 03:14:22 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id o10-20020a056e02102a00b003006328df7bso6700992ilj.17
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 03:14:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=knvEjaz7f71VMDphq93Ttomb3XiR1RLVfVR0GiG+5yc=;
        b=dAlE7NmHL5sTA7WSolyCGVzDiyKvDUdXKSfwVSWHKA/LxFHYhRNvGYtEfcFNGxdUEf
         YkBE5DfPppA4IH6rDZrDRy91ytFJecygYF8JpuLDe49P71RvU3tL4g+uNy/+qAwLe41a
         H4ayCXaq4NK0+lHmKLOfsssEv79N+j/YNT4GiRi+q2OQuDVxh/X8UviNFMB0sU6TPpx5
         fSBV4msuDbj4XjiO71VKFJESdD8mlI5UT7bohH/yKiCCRW6kdPcLUs/Ul2f1EToBkZ5C
         RNNzo/lwAMJu9UfbWjnhJzd7wUIUAB61J+c67BaEfGsdesCqcKr6l7HQIrmWxwbfyHhU
         ijng==
X-Gm-Message-State: AFqh2kpVZKirEpicevDcZF6qZTep+M7U/BjMMLuRRuZe7ke2zZDo2WT3
        3/t5PXCsZwKL/jdegKXBDhOeU2i9re6OyG75dZd7VGkTaGhv
X-Google-Smtp-Source: AMrXdXt6XfxN8kz3zBped8n8r4ixtXs+B2FAnQI2vA4E/ji1IGwbPrta94N1OpQJqC7Z8lQSds9Wh2G+0Tw+vpHVK9m46qL2Pr21
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1090:b0:30d:7fd4:a6dd with SMTP id
 r16-20020a056e02109000b0030d7fd4a6ddmr2610074ilj.20.1674386061807; Sun, 22
 Jan 2023 03:14:21 -0800 (PST)
Date:   Sun, 22 Jan 2023 03:14:21 -0800
In-Reply-To: <00000000000075a52e05ee97ad74@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006e58cb05f2d86236@google.com>
Subject: Re: [syzbot] [btrfs?] WARNING: kmalloc bug in btrfs_ioctl_send
From:   syzbot <syzbot+4376a9a073770c173269@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, clm@fb.com, dsterba@suse.com,
        dsterba@suse.cz, josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org,
        w@1wt.eu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 7661809d493b426e979f39ab512e3adf41fbcc69
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed Jul 14 16:45:49 2021 +0000

    mm: don't allow oversized kvmalloc() calls

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13f2c851480000
start commit:   f9ff5644bcc0 Merge tag 'hsi-for-6.2' of git://git.kernel.o..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=100ac851480000
console output: https://syzkaller.appspot.com/x/log.txt?x=17f2c851480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=827916bd156c2ec6
dashboard link: https://syzkaller.appspot.com/bug?extid=4376a9a073770c173269
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1775aed7880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11cbcbd0480000

Reported-by: syzbot+4376a9a073770c173269@syzkaller.appspotmail.com
Fixes: 7661809d493b ("mm: don't allow oversized kvmalloc() calls")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
