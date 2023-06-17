Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45F5733E30
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 07:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjFQFO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 01:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjFQFOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 01:14:23 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904EF1AB
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 22:14:22 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-77d99de0e9bso139218939f.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 22:14:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686978862; x=1689570862;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ruLjNhk6fCywW5LUQo5nl6809b1AY9//IrZcqzckXw=;
        b=jd8GIc/aQZq+8wtWRKVOSelAzki/OcAxydTP8YtBfJtDFITxv+JJiuDf70LGxKxS8G
         EyLn+Sx7dXT9PHYp+SWlR3DG2MS0OOSqhqX8z4E1Kx/A9fb7VKa+gY9coX04HTg8bwM5
         vgUDm+DgE4A0FtvODLKz2dJegFOtVIkPuGAMk7MDRxnvk9SY05eRp4xt1gvkJw3KV48s
         2tYlklayqoVrwwzsKg/v1fweITM54lflNi0tNuHLwKRSnursYGSaAnGlbTCubxHghQ/p
         eSGPpfvhPvrua+HRStl5zzQFNKSYfX6YwQnbsM5Tq+plltu9QKlyqGv0DmeZZiU8/Gtk
         loWw==
X-Gm-Message-State: AC+VfDz+ZwcTRRaGzj4Ikxi94oA0OW5kH9CVXfu0iKkY/iY9q6DZ3NUp
        TreUUBY+f4XJhRx7yExNMYWqoW2WZzGoPNnaeqlxJqydQDHg
X-Google-Smtp-Source: ACHHUZ4ME0j7OSg9GrPniZmeNmXInLXLlmxE353z7XujKzFE1xvL+lh/SzXZuoFdTerY/43T8JOXyw5KdK1I5r/QOsxVefey2ESQ
MIME-Version: 1.0
X-Received: by 2002:a05:6638:10fc:b0:426:26bf:5a60 with SMTP id
 g28-20020a05663810fc00b0042626bf5a60mr972100jae.5.1686978861956; Fri, 16 Jun
 2023 22:14:21 -0700 (PDT)
Date:   Fri, 16 Jun 2023 22:14:21 -0700
In-Reply-To: <0000000000002b6ab405fe43af4a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cf863605fe4c5f40@google.com>
Subject: Re: [syzbot] [kernel?] possible deadlock in exit_itimers
From:   syzbot <syzbot+5fd924f4cd9dc1c7828c@syzkaller.appspotmail.com>
To:     frederic@kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 1b59b2577582f9cf3d0f17245675a76859175cc1
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Thu Jun 1 20:16:34 2023 +0000

    posix-timers: Prevent RT livelock in itimer_delete()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=106d46e3280000
start commit:   f7efed9f38f8 Add linux-next specific files for 20230616
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=126d46e3280000
console output: https://syzkaller.appspot.com/x/log.txt?x=146d46e3280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=60b1a32485a77c16
dashboard link: https://syzkaller.appspot.com/bug?extid=5fd924f4cd9dc1c7828c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1401d8ef280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=176b45cf280000

Reported-by: syzbot+5fd924f4cd9dc1c7828c@syzkaller.appspotmail.com
Fixes: 1b59b2577582 ("posix-timers: Prevent RT livelock in itimer_delete()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
