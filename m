Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327FC652721
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 20:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbiLTThX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 14:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiLTThT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 14:37:19 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978F35FE2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 11:37:18 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id y6-20020a056e02178600b0030bc8cb4312so1316477ilu.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 11:37:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xtf3kK/4JkO5DVd4qOuGUgyJBsIREUJl3kcqk4Bwjr4=;
        b=lmur4oXgoZw24FS3OfRKdA35JmR+t4cWXxMFPUQ4EEXkTivGjpqBxXU6jYGrSityz1
         lKRg756YYOFXa5F6cCbnhEkI/kk0viLLztAa2NhR2ibNvHDj3jkKT+nBYNx8G6Eg9uOI
         zmw6MKhDVlHbQM2ylx/Sh/ZcaZYWKRG9ZSaX21LO0hy3xTAusHth47Wf7vsNm6Bcq69H
         RLBrf21K+mV38vIostjJ5hzfXg4b6y+oN1fnj9grw4/HAb7NtailoDoWQs0ui9SQUX8r
         FMc3sJvBx/Fa58IdbTKqHQ33eV7nONEdn6pftwB49FUAl9hUTXUXkXIgfJpvoWnLqjvD
         GGcA==
X-Gm-Message-State: ANoB5pnAixn2A1X5CqFEEm5WVdgYvhG8966nFNg1zW0zXo2lR8sCnoxC
        E9i7DTOktXFC9FBSa5+7nLKbIsNeEEJggfGF1oNdEzmTPd6b
X-Google-Smtp-Source: AA0mqf79LM6cuQfmZgkg9I2E8BaJp2XadINP9woNrMjfuuHwCStlay7Ncmm1QjAAXXiaNN1Z3ZOaFyHazaxPHao1vnryZURMltfR
MIME-Version: 1.0
X-Received: by 2002:a92:d8ca:0:b0:303:6b79:14bb with SMTP id
 l10-20020a92d8ca000000b003036b7914bbmr11203430ilo.9.1671565038025; Tue, 20
 Dec 2022 11:37:18 -0800 (PST)
Date:   Tue, 20 Dec 2022 11:37:18 -0800
In-Reply-To: <CAKH8qBs1UiikX=_CBzRC_2rg3sp8CU5hhB7sOkNkNBqm8OqFEw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004f881505f047903b@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in put_pmu_ctx
From:   syzbot <syzbot+b8e8c01c8ade4fe6e48f@syzkaller.appspotmail.com>
To:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        bpf@vger.kernel.org, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org,
        netdev@vger.kernel.org, peterz@infradead.org, sdf@google.com,
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

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P5778 } 2673 jiffies s: 2773 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         13e3c779 Merge tag 'for-netdev' of https://git.kernel...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12cb0e5d880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b0e91ad4b5f69c47
dashboard link: https://syzkaller.appspot.com/bug?extid=b8e8c01c8ade4fe6e48f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12df6a9b880000

