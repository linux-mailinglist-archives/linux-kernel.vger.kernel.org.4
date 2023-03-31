Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686146D2436
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 17:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbjCaPmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 11:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjCaPmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 11:42:24 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413C61E72D
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 08:42:23 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id i3-20020a6b5403000000b0075c881c4ddeso7868493iob.13
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 08:42:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680277342; x=1682869342;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aJYq+ZywDnRhStLXmh3DG5Chtbh5S+arEYAqRS8jFIw=;
        b=HCGlMBEOh9J/Df3V0/cSXKb9pUE6WoWcMwqNnpLjDTAtG9B82nRl0xJyTi9uLaRToE
         KMUy4xPdJmIOw6RvmR4ar8FrLulrlJptlg7Um+z+jqJOF2gqsl43MgYUY6AVZKZyz8oH
         OHe4Gq3rbQ+77DPk9NLeIiKLruIyVA91jX9HJlk/gP6smQPvxIJ5LtiXqQEDEhtq2jui
         p7ijU2014CutN/1apAG4A59y+0WaFlCiHkrQwHlEQs0tXjwo6iZOLQPaKWXRnS5TLQlC
         QXdrXzjeEcJVeE3t4r/dmnCUoY3txwen2sFmXqhT4Fpq+zRdt5exmplgsp8PluH49d2q
         qqTA==
X-Gm-Message-State: AAQBX9d4T2Vslk06uO90ZYzLpgw6j5WjFYMN7/kwPjUtx+C4Q0x1Hw9U
        LqFh+RX9v6+dr/JzRSnzt5QaI6N8bO4kYa66Yt8nz4Gn7/52
X-Google-Smtp-Source: AKy350ZZCOGDTvEy1d2vlO0/N8RFSfkcATk9zogGNoG5lCrg25Fl7BHt9IN9NRb0wcblmMp8Gja+mV9pY/NUE+aAYXo5MlGHY0uW
MIME-Version: 1.0
X-Received: by 2002:a92:3005:0:b0:326:17ae:47b9 with SMTP id
 x5-20020a923005000000b0032617ae47b9mr8063319ile.1.1680277342571; Fri, 31 Mar
 2023 08:42:22 -0700 (PDT)
Date:   Fri, 31 Mar 2023 08:42:22 -0700
In-Reply-To: <000000000000a5c9be05ed85b31b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000020d46805f8340e6b@google.com>
Subject: Re: [syzbot] [block?] KASAN: use-after-free Read in netdev_core_pick_tx
From:   syzbot <syzbot+10a7a8ca6e94600110ec@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, gakula@marvell.com, hdanton@sina.com,
        jiasheng@iscas.ac.cn, justin@coraid.com, kuba@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        michal.swiatkowski@linux.intel.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.1 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit f038f3917baf04835ba2b7bcf2a04ac93fbf8a9c
Author: Jiasheng Jiang <jiasheng@iscas.ac.cn>
Date:   Fri Mar 17 06:43:37 2023 +0000

    octeontx2-vf: Add missing free for alloc_percpu

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=133a3d2ec80000
start commit:   42226c989789 Linux 5.18-rc7
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d84df8e1a4c4d5a4
dashboard link: https://syzkaller.appspot.com/bug?extid=10a7a8ca6e94600110ec
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11ed1369f00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=166b22cef00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: octeontx2-vf: Add missing free for alloc_percpu

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
