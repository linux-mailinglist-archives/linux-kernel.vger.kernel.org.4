Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B758642E47
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 18:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbiLERGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 12:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbiLERGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 12:06:18 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E292D1838D
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 09:06:16 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id c23-20020a6b4e17000000b006db1063fc9aso10159611iob.14
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 09:06:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5LpAWu712FVAtTHbQqwYlcqFGXcCDNZ1bTZQLNlfzbA=;
        b=MbqaWahvIViHx9NWMFqJ9pNmoWKsiZchwA7W2JN6NGnZE1XjiQSPl2SArzsdwlnJHC
         2ay8dvGjdroPt9zekR14GugqFRQyLM0uH3ByECG5Hc5Ty+DFdoQHF6mleZ6bg8atBFkC
         2t6rIyVtUDW41ZmGlvQCUOFqa3eNxE9rnralNZo77emqjK0m5mbKwfrme809gaCHeTkj
         sIDNJnZvAXkf/WjVMODv4Up0iE+cfeH4FUIFLbvt38RN6NPzS9pRr9M0VXqPi9QY2SoA
         r/g1mRVI8NKzaMfMdBmjmwWEDAJpW4Ae7k99Pajx3fRJJroAdLJm445W6zOqw16gwFbp
         ZTcQ==
X-Gm-Message-State: ANoB5pmCE8RJN3bVARnXhaOeKLXTixmh+Y6Rl2zWjKs9DHinEZFwTw1c
        5DIZMj4ry6rOVd2aeWRMCDiGBs4hNolH+DwLk4Pv8NCEVHJI
X-Google-Smtp-Source: AA0mqf7CYgDBGtX2wnkOjjP04uEnvDKifuMirKiP5cLckSMc4HCdS96uad0ftEGPpwUvW0xxYbks6Gwg8o9jql5AbKEkxSzcz/LM
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:14c1:b0:303:3931:678a with SMTP id
 o1-20020a056e0214c100b003033931678amr8657962ilk.272.1670259976257; Mon, 05
 Dec 2022 09:06:16 -0800 (PST)
Date:   Mon, 05 Dec 2022 09:06:16 -0800
In-Reply-To: <20221205140422.7412-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000914b5f05ef17b451@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in xfs_qm_dqfree_one
From:   syzbot <syzbot+912776840162c13db1a3@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: rcu detected stall in corrupted

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P4111 } 2640 jiffies s: 2849 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         0ba09b17 Revert "mm: align larger anonymous mappings o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=135dc11d880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2325e409a9a893e1
dashboard link: https://syzkaller.appspot.com/bug?extid=912776840162c13db1a3
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1551f50f880000

