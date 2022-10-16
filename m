Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5139C5FFF3C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 14:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiJPMm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 08:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiJPMm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 08:42:26 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A5A1E3D9
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 05:42:24 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id n6-20020a056e021ba600b002fc99858e34so7338193ili.14
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 05:42:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KkKDrpHneMqOyeP+pW8+VRoR0qreDPkmug6S/L8Ngnc=;
        b=n9xhHhPwsZp8CmA++oGRoyia7sKvs3Y0m9YFgV17GjLrJ6sjn9voTG/+3sOOtvpVWD
         SuRTIofasBz2eQL3CfmUz6iaY0YvQXaCkqRAuNrFB+JH1iXwgelhlbn8AMZXhVT0x4qM
         paJwWiwhSBppVg1xiJHSvze3hDsF7spHONukBVPE2IEyF+iagkibOWyNU+S8G0y/lKsI
         CC6HPSH7ZVtAIYe9XFXuSWkMaEl4BRjtJ0lXqaIkb3+xvBSKGG8R7dRsiOlho1O0MNsO
         +EGvhXONQyZftY5S5OR28SLuwZyAXXsDqsKA3C+ibZIFfZON9L76THs7FoP0UVLm7GgS
         uleA==
X-Gm-Message-State: ACrzQf0ClIT503/lURjbtZtIng+t6aY+FUNPNSuxx7/U3Ubn9umXZ5Tn
        MMQYeU9p3lq7Svxg6hERa/0iFyvpvx8HPrqLOszhFsnX8xYt
X-Google-Smtp-Source: AMsMyM7cabzJFO6XiTQbLn+NV6lymyPMDowSLqGXWb7mXK2AGdioaCKiMK26dv8hJ3ebTq62y6OOBUVy9XKCSGukI7I7c8lpI7DX
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1563:b0:2fb:6601:80d9 with SMTP id
 k3-20020a056e02156300b002fb660180d9mr2857122ilu.71.1665924144050; Sun, 16 Oct
 2022 05:42:24 -0700 (PDT)
Date:   Sun, 16 Oct 2022 05:42:24 -0700
In-Reply-To: <20221016110248.708-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d437a305eb263003@google.com>
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

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P4084 } 2677 jiffies s: 2541 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         55be6084 Merge tag 'timers-core-2022-10-05' of git://g..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12c5ccb4880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df75278aabf0681a
dashboard link: https://syzkaller.appspot.com/bug?extid=69904c3b4a09e8fa2e1b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=131f08aa880000

