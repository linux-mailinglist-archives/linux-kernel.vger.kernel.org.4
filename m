Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A734762D0AE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 02:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238109AbiKQBfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 20:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234016AbiKQBfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 20:35:19 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B2259FF2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 17:35:19 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id q6-20020a056e020c2600b00302664fc72cso292720ilg.14
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 17:35:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m2M14rjVSVmIxFERIVkDBPniB6v1VgAS1vnPA623NfI=;
        b=fDSVz4Lg3YGkvBPvYw+xlHL0w0ir/f58ctnwMZZNBWfaIy0qvoQ2NqyHtUA5bxJSBQ
         kCQGZHkeh0RHO1tB3nVhIpuKsMAm2/xP6fwYbssIWzcxavlV9u+Gf9r8PbOEiWhGWq8X
         yqvfTjwUQayi3qpmX+s6NsGOq8i+J40Qqks2hSNdiFxcHopySvknJniTV/HFhm5VHGOr
         vrhZR/LTQDeCXylDDIYUnWLBLQoWRU4UVcjyAruz+yi3cAQywe8ChIpzJQI7xmyPwZNN
         yU0UoqesC6kTWqAB4W4R1NAD1uCMfkixsRNIcUpXbPsSdiyjy3Flj6sXmpSJEzyIGRmm
         aycw==
X-Gm-Message-State: ANoB5pnqNFk6FtaDyPJ5SypMY4T8XT4vLFxJRKIfhbQPCQSZ2jjHS9Za
        GDa1Uzr0z3NyAPmhCWcDlOoZvo+/QYc7syw6VpZkVQY8Mxlx
X-Google-Smtp-Source: AA0mqf748OaI1Q7vumE815Vq8lgU51VjBRoqQLAeYQAknLuvzvObzoulNjXvZtW+A3fc6UPllvTZI44Wy24d7/ssuQQT2kE0ABej
MIME-Version: 1.0
X-Received: by 2002:a92:c889:0:b0:2ff:6c26:1c75 with SMTP id
 w9-20020a92c889000000b002ff6c261c75mr244831ilo.315.1668648918534; Wed, 16 Nov
 2022 17:35:18 -0800 (PST)
Date:   Wed, 16 Nov 2022 17:35:18 -0800
In-Reply-To: <20221117010835.3474-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000b539d05eda09a88@google.com>
Subject: Re: [syzbot] WARNING in call_timer_fn
From:   syzbot <syzbot+6fb78d577e89e69602f9@syzkaller.appspotmail.com>
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

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P4107 } 2643 jiffies s: 2809 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         7eba4505 net: dcb: move getapptrust to separate function
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12b65845880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=893a728fb1a6b263
dashboard link: https://syzkaller.appspot.com/bug?extid=6fb78d577e89e69602f9
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14ef644e880000

