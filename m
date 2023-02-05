Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F0868AEE4
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 09:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjBEIxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 03:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjBEIxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 03:53:18 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BCB1A948
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 00:53:18 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id d2-20020a056e021c4200b00313bdffad9aso588931ilg.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 00:53:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T1MVW7Le5RQxqoSefxXRWTD9BxYYiTWenwv5ch+pTL4=;
        b=QhbV4kpEF2+9o81kxeBNOC4vOCTko6JmoDOgfgh8Y3HvB7FLiSfixNg1MQ6ONj8370
         8aaPghHwKR0zYaD+IV0EV5pebPiYMQylX+5Z0E2D16LoIJQwiOgJ6lIOnOmZRd+4tptq
         h896NkX+2Lp1uev6qx/0GTgNwacCMNSJwhNzP/xv4u92wy+9rDYJJOOhhHKto/ao2EFK
         W4Ic1WqCzLpIFe3mHVKRSdRJ1G+ZPB81gYdhqnMnQCk55DbzgTtl2sMI9JtuQERdlTec
         WmgbfyEoMmLURUvS5uvynsjVaqNjn/eu2/OuP55zJmM04lAu/+099mpws9DB+KYNJDE+
         dfMw==
X-Gm-Message-State: AO0yUKUyImkG1zi/hlDhDn6codXd5uwjpYN+jSqRQBVBqE4yJ6cb0VhC
        IUwRhEnG/Ckv4EPLyJlEYQiPhLv3xXQAa67P3Cpx7y+jor4n
X-Google-Smtp-Source: AK7set9MQFQDx9jhUKxwCQqWqUb0HO+0V6zapdDN1rBm954uTMZn0JyfHY31n5fZAbk4AcAdIk3ofwwApEPZAIpwfu9TEMXmLT8n
MIME-Version: 1.0
X-Received: by 2002:a6b:6f13:0:b0:718:5e4f:6771 with SMTP id
 k19-20020a6b6f13000000b007185e4f6771mr3321262ioc.20.1675587197468; Sun, 05
 Feb 2023 00:53:17 -0800 (PST)
Date:   Sun, 05 Feb 2023 00:53:17 -0800
In-Reply-To: <20230205082542.1363-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b206e205f3f00b4c@google.com>
Subject: Re: [syzbot] kernel BUG in __tlb_remove_page_size (2)
From:   syzbot <syzbot+d87dd8e018fd2cc2528b@syzkaller.appspotmail.com>
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
BUG: Bad rss-counter state

BUG: Bad rss-counter state mm:ffff88802bf00900 type:MM_SHMEMPAGES val:1
BUG: non-zero pgtables_bytes on freeing mm: 8192


Tested on:

commit:         4fafd969 Add linux-next specific files for 20230203
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1413c073480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d2fba7d42502ca4
dashboard link: https://syzkaller.appspot.com/bug?extid=d87dd8e018fd2cc2528b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15a4779d480000

