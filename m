Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3F76032EA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 20:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiJRS63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 14:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJRS6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 14:58:24 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297542737
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 11:58:24 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id x21-20020a5d9455000000b006bc1172e639so10430871ior.18
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 11:58:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yQqlsY6PBWJmHaKFtwuo/Fk41jVzmNGP8DugV5geaHk=;
        b=SPuhO5M/iZsmepAouBWpvbn7VM34iiko6Ev609LzpD/QuV7RVIyUYWafrw751FvoBM
         XOSJh/VCAf5cffetXJlsGNNwDDazspwQ/RRzsKKMdE0dzYEsLqWSVMq6pbsk4sr5XTAr
         Mf2KSKUTM2Xwda2F7XalabU3kgtve2uZnHM662b/dvFnQKtqQ7jaJ++xf8o4ImQxFnMh
         LcvhvocGFWDtFEkuaS+WZ7RW3bBBNz8G0kmVy5i5kWOEZPm2qIiM+xpMt4lha1Zd1BDn
         54UJmn69EdRsZDAgSDZVgClOmRxGie69IlltiO6jiSGqV7Y6Kh4uQsCIRrxxFtZD8Vxd
         rveQ==
X-Gm-Message-State: ACrzQf3XnhGsQk5xiBY8ocPk5eABU9McAWgLJat8fV4JU0pm6rYpFWmP
        +kq5tPpLbw3JdGX03C/mXfevLYeXAOEuhW+VkwfbaBwmaRJf
X-Google-Smtp-Source: AMsMyM40S0lryKjEVJ7J40VbZVG76/PxWQeTW31FX3WMEKIW9Kcqs8RP8MUEVxu3l4pxUjHaEmHDYZrqz46WCULr4gvXnt9VXIpc
MIME-Version: 1.0
X-Received: by 2002:a92:cb88:0:b0:2fc:1695:df02 with SMTP id
 z8-20020a92cb88000000b002fc1695df02mr2728431ilo.92.1666119503519; Tue, 18 Oct
 2022 11:58:23 -0700 (PDT)
Date:   Tue, 18 Oct 2022 11:58:23 -0700
In-Reply-To: <20221018061633.890-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002925e605eb53ad2c@google.com>
Subject: Re: [syzbot] INFO: rcu detected stall in batadv_nc_worker (3)
From:   syzbot <syzbot+69904c3b4a09e8fa2e1b@syzkaller.appspotmail.com>
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

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P4085 } 2680 jiffies s: 2529 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         55be6084 Merge tag 'timers-core-2022-10-05' of git://g..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11c5acba880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df75278aabf0681a
dashboard link: https://syzkaller.appspot.com/bug?extid=69904c3b4a09e8fa2e1b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15c2fd8a880000

