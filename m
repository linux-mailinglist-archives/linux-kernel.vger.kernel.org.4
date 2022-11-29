Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5210B63BA16
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 08:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiK2HAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 02:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiK2HAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 02:00:32 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2A824966
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 23:00:31 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id y12-20020a056e021bec00b00302a7d5bc83so11247146ilv.16
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 23:00:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7iQRdFpIS1RfFuh0nwKFpnKn/nvgkEHQboePIax9ds0=;
        b=xzCeFxf+eoKEx9zL2raKfz8Yc0F3zvE2zf3jYNtYaA0yB+SJ/Tnt13fXBYueMuG9y2
         S8wJaxt3NjoBHvqwZ3Gbc0k4cF4tgoIJa77AYOsskCDkqlT+BAH/7bKMN6Iyg1sf4I7R
         KPQoKkvFOPqRVVvEWKlwzuFdmrk7G1X5J1jQgvOR/r2O0ki6nYQDfjg+VDHMzH3mVaL9
         DNyAvbNML7CtzwzV089fPneG1uZkpswk9O9gNITKqa7ml3sfzUydZu+HpKn3/l7t69LE
         rmJKY+46GQ4VH4c8lH95awb6ELnagomc3SCKBUul9G7t4hCeJCk0XE5ajAL1WQ+1EBgJ
         LCKw==
X-Gm-Message-State: ANoB5plTw9Lh/YOWcstMPvrbSb6LyfmjefM3OncnMk8wJwO0J+CjnUjr
        UqlhwURsEaAJyah/0homcKb6XxMNOi8wFQHq2ZgOOcVhf2pd
X-Google-Smtp-Source: AA0mqf7L5tGNEB/wdMyN5dUSQ/nCex/PwKjsXOFtsooc2Q9KLlHTnMhb7qiSJSb6WAGyPJm2np6hBJa3rinkAUx8kXoKhyj6JJRY
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1251:b0:303:1c15:2818 with SMTP id
 j17-20020a056e02125100b003031c152818mr2303990ilq.87.1669705231086; Mon, 28
 Nov 2022 23:00:31 -0800 (PST)
Date:   Mon, 28 Nov 2022 23:00:31 -0800
In-Reply-To: <20221129022831.6181-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002dbc8d05ee968baf@google.com>
Subject: Re: [syzbot] WARNING in iov_iter_revert (3)
From:   syzbot <syzbot+8c7a4ca1cc31b7ce7070@syzkaller.appspotmail.com>
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

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P4109 } 2690 jiffies s: 2793 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         b7b275e6 Linux 6.1-rc7
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15ab6753880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2325e409a9a893e1
dashboard link: https://syzkaller.appspot.com/bug?extid=8c7a4ca1cc31b7ce7070
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=100b6753880000

