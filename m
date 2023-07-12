Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A8074FC86
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 03:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjGLBQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 21:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjGLBQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 21:16:27 -0400
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1D1127
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 18:16:26 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6b8cc7351f0so542820a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 18:16:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689124586; x=1691716586;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HVCDywhHpMOGTFqG/gDYk0S45lUTl1W6WhYjBIpoNpw=;
        b=hTYbQ9NLlc9KN3t/4reGw0NNRlvsnShsVpGiMq9Btupn41JTSgvf0zzYBVelUc6Zav
         r4wwLN1OS6CJ+e2qJxXxrOUgW7dZBIzOLyOW8pnF8P8VFKNBa+LlmIu8cDqxiHmuABlM
         CLrJNSW96afgyiHl11OKFHSZ+yKZvyDt/VwUPchaebubv0qQS7jiu4RA/ORG2A+It8es
         Zwl8sa108VDA0BfaXngcXrsc4wm2dSu/mhfLVLADhRVsIan/DRpGgL6YiLtq4sb6Cm7b
         WlzswyJZ/D/7il3Wc9nCP7ffy9yUeaYcz4lJvmKqKG0K62s5gvtQ0T9Gtx3kgXkcg1eh
         ctGQ==
X-Gm-Message-State: ABy/qLZ68yZDJy79PTFiGt/9Zd5etmhlT0TurQOU9qoPVGyn7wAXrIfa
        SJxm5biMvdETB6ztxzN41IIjl9xdvOc/xm1nxx0cP+lC6QNC
X-Google-Smtp-Source: APBJJlEfdPeTrhOct9RIcxFE/RE/xuq9yIIGgVNHdByqdXJPK44xyvBuBojGYPkI1HcFu3nt3m+tr7yZqNEffrD+pg4iJnyU9rQU
MIME-Version: 1.0
X-Received: by 2002:a05:6830:4524:b0:6b8:70f3:fd36 with SMTP id
 i36-20020a056830452400b006b870f3fd36mr712756otv.2.1689124586175; Tue, 11 Jul
 2023 18:16:26 -0700 (PDT)
Date:   Tue, 11 Jul 2023 18:16:26 -0700
In-Reply-To: <20230712004750.2476-1-astrajoan@yahoo.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f0c50706003ff6f3@google.com>
Subject: Re: [syzbot] [can?] possible deadlock in j1939_sk_errqueue (2)
From:   syzbot <syzbot+1591462f226d9cbf0564@syzkaller.appspotmail.com>
To:     astrajoan@yahoo.com, davem@davemloft.net, dvyukov@google.com,
        edumazet@google.com, ivan.orlov0322@gmail.com,
        kernel@pengutronix.de, kuba@kernel.org, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@rempel-privat.de,
        mkl@pengutronix.de, netdev@vger.kernel.org,
        o.rempel@pengutronix.de, pabeni@redhat.com, robin@protonic.nl,
        skhan@linuxfoundation.org, socketcan@hartkopp.net,
        syzkaller-bugs@googlegroups.com, syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+1591462f226d9cbf0564@syzkaller.appspotmail.com

Tested on:

commit:         3f01e9fe Merge tag 'linux-watchdog-6.5-rc2' of git://w..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=130a98a2a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4c2acb092ca90577
dashboard link: https://syzkaller.appspot.com/bug?extid=1591462f226d9cbf0564
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1380a782a80000

Note: testing is done by a robot and is best-effort only.
