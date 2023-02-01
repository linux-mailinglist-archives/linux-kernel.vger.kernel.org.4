Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFCC6869CE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 16:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbjBAPQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 10:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbjBAPPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:15:38 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA083BD84
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 07:15:19 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id z25-20020a6be019000000b00716eaf80c1dso6723218iog.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 07:15:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SyFej6xjbPRyZaM86/7PzRDDHkpGCl9E7vkUdI1CRKA=;
        b=2a0jATZLZID7ULHhAjSZ6+KjItxauZYYTjPNFlAyv/psUqJ5tjHbxmoxNJiUaCQFZD
         niCapNNwNOW9cTP88OoJWYu+C5v5H+uwc8UvuV5Tw6qvJ/Xgz/1X5UCBfK6Ozxxtgr6P
         C5S9MHu1O9Znh+WWtOM36DB7Y6tmZxYrWjTwEPUDZIiEikI+bIoITAZNEdsbY/QQGJ4F
         wlOJ2wSpzUYzMkvMJDRPmqph1jDlCdMD7Mtj1lkFwJ6GhXGRq9qNUt99lOZ5k9Fq07ym
         C590OjpqW1Rpma3LIABx+pghI6zwx2LDorzmETlVYIOWnm845pDmBfuQrKoxsLUt8UzJ
         7lgg==
X-Gm-Message-State: AO0yUKUW6P1BuFtTYh5NlNB3K7IA7Vsed9ncYCKW506QyvqWEBUXfK5V
        ETPo+NGYbS2vcQYfJaGWuM9XzPYjMb+QWDe6nbiP2+eZvpRr
X-Google-Smtp-Source: AK7set8l57KyfGdv716/Oz/R/BPqJjY21y0xHGpvailL+5cj1cBsQ8dW+2FJT6VlbU8bhfOeD/OUeyFRuEUerkk1B+jNBt3J3Wne
MIME-Version: 1.0
X-Received: by 2002:a05:6638:468e:b0:3a9:72f3:f806 with SMTP id
 bq14-20020a056638468e00b003a972f3f806mr504385jab.34.1675264519053; Wed, 01
 Feb 2023 07:15:19 -0800 (PST)
Date:   Wed, 01 Feb 2023 07:15:19 -0800
In-Reply-To: <20230201115301.463-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000902e7205f3a4ea9c@google.com>
Subject: Re: [syzbot] general protection fault in skb_dequeue (3)
From:   syzbot <syzbot+a440341a59e3b7142895@syzkaller.appspotmail.com>
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

BUG: Bad rss-counter state mm:ffff88802b07c800 type:MM_ANONPAGES val:1
BUG: non-zero pgtables_bytes on freeing mm: 8192


Tested on:

commit:         80bd9028 Add linux-next specific files for 20230131
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=128b1afd480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=904dc2f450eaad4a
dashboard link: https://syzkaller.appspot.com/bug?extid=a440341a59e3b7142895
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15e89d43480000

