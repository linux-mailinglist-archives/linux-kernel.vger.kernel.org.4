Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0526F62B531
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 09:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238777AbiKPI1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 03:27:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232990AbiKPI0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 03:26:48 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DD01CFC7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 00:25:14 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id be26-20020a056602379a00b006dd80a0ba1cso8417820iob.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 00:25:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lny9Dvc9MjZV1wbqMm6Jn2I1GJzUT0nsWXCanrCgi4I=;
        b=De6QX43A9KMeaw/vuA6pgkWxyfxJhTYR4NTYrx5fPgacL7FtCA152GycpA4qaBgonF
         +20r6WchqGsMTthne1l++yagyigmwhYJd9k2G6u6Al6rNkCErnt788Uwe9vCcn8UDtdg
         Z4CPmzgXe0jjZE4JqbvIJ+YW4rSMpIxBOyUI4xa+1AUEbH9E2c5iHuXR73AcXJZeZjHn
         TyXsTpVqP8ULPX7nQEBicxuWBw3JOXZpID45UkGcPrhdWUwAQVilRWvf9WMnLXiyLBRM
         QGmB5jTbQrF+FYjQ090Qfb97HjomlGLVOpxu30QdPR/5sOY2ujDQXmGx9qJ2A36dt4JK
         7qWA==
X-Gm-Message-State: ANoB5pn13bVatC3/wbO4iZnk1L51ba5xIUoXw2hGLIyrAUPXKfDVVIJN
        pGLT1yQbkp9jt8ygQXGtIOYu/laRFpnWVCxvEE6qpC96bRcl
X-Google-Smtp-Source: AA0mqf5VOlfcsrkFiQsLXljChvLH/mL3+yKgiPuTMDig5hz9/wJSGvlPnXqJUPUkhP9Keuvu2qF+HhFZPec0N4iAYM8jcoMOmyA+
MIME-Version: 1.0
X-Received: by 2002:a05:6638:87:b0:375:afff:bc23 with SMTP id
 v7-20020a056638008700b00375afffbc23mr9683919jao.221.1668587114194; Wed, 16
 Nov 2022 00:25:14 -0800 (PST)
Date:   Wed, 16 Nov 2022 00:25:14 -0800
In-Reply-To: <20221116051237.2996-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000037ea5805ed9236d4@google.com>
Subject: Re: [syzbot] INFO: task hung in rfkill_global_led_trigger_worker (2)
From:   syzbot <syzbot+2e39bc6569d281acbcfb@syzkaller.appspotmail.com>
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

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P4112 } 2628 jiffies s: 2845 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         e01d50cb Merge tag 'vfio-v6.1-rc6' of https://github.c..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16ef649e880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=47b0b2ecc119b39f
dashboard link: https://syzkaller.appspot.com/bug?extid=2e39bc6569d281acbcfb
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14b645be880000

