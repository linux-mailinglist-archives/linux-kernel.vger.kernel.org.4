Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F7660B675
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbiJXS6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232936AbiJXS5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:57:44 -0400
Received: from mail-io1-xd45.google.com (mail-io1-xd45.google.com [IPv6:2607:f8b0:4864:20::d45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB901EB564
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:37:44 -0700 (PDT)
Received: by mail-io1-xd45.google.com with SMTP id q16-20020a5e9410000000b006bfe9222a2aso1164597ioj.15
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:37:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=px1z7jXV/l5+I2kX7FaOIU8JAVr+5+wG2+rm0rbU2Aw=;
        b=P0LkXKdK84RtTiqGqmqj6kdlHoqB/TLBGwtz28jOeZKAe7r+2CaOESMnTtm3lsACG1
         v+8AQTbWGLOYupHw59ty2Pb2HUtVFK/h1LteVysZ/ahZs0KTc3JF7/YJWy3A6If6oU/f
         kOzN1/R1tlAMZr1yE4fR0Rx3/8j9OtkwrKt/easXF3wtSqw0zooqg9H+hAQNR5KlFpIk
         dlTX7ubAoZfBQ1EEvUmtic6ON09DeCWxhpoCsM3yXQuZLtlUGUrbdIZvbis48KqG+qAU
         P76mKE0+i6pfZEZB8JqhaDoOLCi/q7nxksctbYGUq8VuMuS92inEpzceitfGTQe/Xybt
         YcdQ==
X-Gm-Message-State: ACrzQf0SLmvcqez7szx8UwIJzTmB0BITLEkc1WXAGGAdPI/kcIq3OuBV
        GuvJQaFD6Rl7tUAjc1Lb+Jv17sz4lSJi0zvw3H5qgzpjZKup
X-Google-Smtp-Source: AMsMyM4BEYz5x1dx1hVWrup+gD5wfreGDYNunKN10djrQksWDMLgcjefHvjZUj4dgve0GTvLtJUwwFtaEf4ytvwT6dyS+VsXo5X6
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160c:b0:2fc:1bc4:1811 with SMTP id
 t12-20020a056e02160c00b002fc1bc41811mr21874502ilu.306.1666632685209; Mon, 24
 Oct 2022 10:31:25 -0700 (PDT)
Date:   Mon, 24 Oct 2022 10:31:25 -0700
In-Reply-To: <20221024070414.2711-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002c4dbe05ebcb295e@google.com>
Subject: Re: [syzbot] BUG: corrupted list in p9_fd_cancel (2)
From:   syzbot <syzbot+9b69b8d10ab4a7d88056@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: rcu detected stall in corrupted

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P4081 } 2634 jiffies s: 2749 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         d47136c2 Merge tag 'hwmon-for-v6.1-rc2' of git://git.k..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15754f4a880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4789759e8a6d5f57
dashboard link: https://syzkaller.appspot.com/bug?extid=9b69b8d10ab4a7d88056
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1338856a880000

