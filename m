Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4992630E13
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 11:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbiKSKXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 05:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiKSKX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 05:23:29 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2191CD
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 02:23:24 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id i12-20020a5d840c000000b006de8b8c5746so3203247ion.22
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 02:23:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DyOghY5lNB2rYGB9Hs+GFF/LBDyG9uVvf7JSRHz6Lq0=;
        b=yAEzFfxXI3EsvfjdbKYKU3Eo5AwpyhmtbHnvBj84dYhi+4bw4Tw/PaodZGJQ4dVQhj
         Dgfwq0N+QUVPBophtgiSP4MW0Pe0QemaP1H51a5m/RDobJfD1ofIkGdnK3Mz7nySu4RM
         5KqGlvOJLjK1gu2cXfQLIfOVhDBgwcCOpXR39LPuEVDmYoBWj7mqvlteZpj994WzV6WX
         bRBJ0i/k2KcL3Kgxdb3s8qW4pImL/X3oKpIqRdE/pOc+dnVr7J6Zif/w3QWUQNo5LEtu
         r0/L24zItCxa3SsAWuMuOqRkKDiER8+K6G742HMSKdNy6/cTYF1uh5o3l/0ftU6lMrZ1
         Eoiw==
X-Gm-Message-State: ANoB5plO7hmZaSuEpKFUYEtaQGBRMkXYIdEQvHBNRKeOjsz+HtOY7TdI
        2p/HIbmrHim1W8hHj/TjqDdX0bPu9ralrpMEX2VrCfcjW8tB
X-Google-Smtp-Source: AA0mqf6O10vR/p9xaXsbpVXWTMHKrkW8amuyK9eDdfCaqPFCKZcPZfqyibgEEVEET5JZGVbmQ2fbzAGOmUjraknqnmE2/tZIw68o
MIME-Version: 1.0
X-Received: by 2002:a92:c950:0:b0:300:de97:7a7c with SMTP id
 i16-20020a92c950000000b00300de977a7cmr440666ilq.307.1668853403585; Sat, 19
 Nov 2022 02:23:23 -0800 (PST)
Date:   Sat, 19 Nov 2022 02:23:23 -0800
In-Reply-To: <20221119094445.4509-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004d959d05edd036ed@google.com>
Subject: Re: [syzbot] possible deadlock in __jbd2_log_wait_for_space
From:   syzbot <syzbot+fa1bbda326271b8808c9@syzkaller.appspotmail.com>
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

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P5776 } 2683 jiffies s: 2765 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         15f3bff1 Add linux-next specific files for 20221116
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=130bea4e880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ec2a1d4f50866178
dashboard link: https://syzkaller.appspot.com/bug?extid=fa1bbda326271b8808c9
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15922a21880000

