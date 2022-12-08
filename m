Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE21647A5B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 00:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiLHXwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 18:52:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiLHXwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 18:52:18 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63FD7E801
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 15:52:16 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id h10-20020a056e021b8a00b00302671bb5fdso2618689ili.21
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 15:52:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eyvNwceZF5z8ZR0dxpXEzRAKysxu2R1tYLIvKJOVfyI=;
        b=BtAg2b2w5AIC0XdQ7Qz7aNI/GJO7PH8agqbICTSrpLwwxlzTphw/S6dTpNQPPhJ9to
         h4or9451IscRKgGQFNEBmy4MFCPqkvOFF4QM1826a1o8ay+bwzHT0G1zn0Lq+V3EfpYK
         S8lZlk6tq/z4XYroLoDyx2nEwwokgkGF8lssHkvp5IMf6uQtmFauduWj9z50hf3lVgVg
         uUjklDtDvd2xE5OFOh7V54KJUdJWiM5b16v5yJ6b3wDoQTiMArNs4f8ZlH1oi/Z2QvFY
         78cEF7fM/qmYQqswPvPCNMCB5kTUkXKU0XGxr/G3VpkHYseE/KaFIGBhC+S+aaOHmFlj
         fd1w==
X-Gm-Message-State: ANoB5pmsXjl0GwepGXB/PmRVQNG3f8gDQgmhF/Ziw1/WuBXesxiozbxC
        lkDX4CJBXcmts18UdlN+SrSHWEyD8CM+ObV+TiS0WA2mpctS
X-Google-Smtp-Source: AA0mqf5eNp7hjb0FvQ5EQPFAIrGlfS3LdhxB+RcSrRifO8D2Fx2bnUdUgfZRoSFmRajDyx+hT2z4uiVEMbK/LXsfrO4yJuJdHBGF
MIME-Version: 1.0
X-Received: by 2002:a6b:8f43:0:b0:6e0:34ee:4e97 with SMTP id
 r64-20020a6b8f43000000b006e034ee4e97mr3798174iod.38.1670543536033; Thu, 08
 Dec 2022 15:52:16 -0800 (PST)
Date:   Thu, 08 Dec 2022 15:52:16 -0800
In-Reply-To: <1805058.1670508568@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000c17c905ef59bad4@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in rxrpc_destroy_all_locals
From:   syzbot <syzbot+1eb4232fca28c0a6d1c2@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dhowells@redhat.com, edumazet@google.com,
        kuba@kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, marc.dionne@auristor.com,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: rcu detected stall in corrupted

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P4104 } 2661 jiffies s: 2777 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         efb7555b rxrpc: Fix I/O thread stop
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/ afs-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=16b83997880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fb14358c9774adf3
dashboard link: https://syzkaller.appspot.com/bug?extid=1eb4232fca28c0a6d1c2
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
