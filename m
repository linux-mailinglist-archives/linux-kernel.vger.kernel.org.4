Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9472F65330D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 16:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbiLUPRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 10:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiLUPRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 10:17:20 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFDA1C12E
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 07:17:20 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id w18-20020a5d9cd2000000b006e32359d7fcso6882375iow.15
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 07:17:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LsL0T+3NXL0r5H78o9iGRrxxUT0PjlhzQTSCxOZ71OE=;
        b=ebyfYDm48dx75oc3oHgTdWmvTObxVRvFXxpwbwp8azY9BFsAbrj8FxchUu0MXN+krL
         RxZuPTq0L06tUE+mstZyaeUeIZTRCkyHlfAoHAR2F4hEZ7Z92s4boUD9EL+7Hp+k8Ee7
         6mVMtx2OWCpPgeCCCkuhOiyZcxIKrtTWAfIkr/Iu+A6q4+xQ6KbvGgTsXY7fD5ojdCha
         JGNDhaPt2qWaj9r75mQHQgmO1ROGQLiLj+mUVjExUH1UNbM2lSbXilZbT8To8NQZ2mkN
         1P2UcE6dbLtW9HAS4Fl3ZmWNteYYig30XWztYKzQLV7I3R3qakIUa/upPkhzAanm1aUP
         d5TA==
X-Gm-Message-State: AFqh2koCiUCJ4fNZqh00wLvec2XIf3DzF3a0pyR1m42refPdOPFRBMc7
        yeRFCk1HRXq7YD+eWi+KEFs5twNCplecmkho7nEEIpff+fJ4
X-Google-Smtp-Source: AMrXdXvsdh29OLI5WS5poiu1zFMEBALeZ7KrEBdJ0CFhRjCBL6bGDlyL8wn36sarByDMP9r591OQJxHos7UMy3MvT1LpIMpeK3z6
MIME-Version: 1.0
X-Received: by 2002:a02:a40c:0:b0:38a:6d77:5dcb with SMTP id
 c12-20020a02a40c000000b0038a6d775dcbmr163066jal.19.1671635839570; Wed, 21 Dec
 2022 07:17:19 -0800 (PST)
Date:   Wed, 21 Dec 2022 07:17:19 -0800
In-Reply-To: <bd9ab0b5-4c87-174d-78cd-c04aa12738b2@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000069608005f0580c52@google.com>
Subject: Re: [syzbot] WARNING in io_sync_cancel
From:   syzbot <syzbot+7df055631cd1be4586fd@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P5788 } 2646 jiffies s: 2841 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         d1f53b3e io_uring/cancel: mark task running before re-..
git tree:       git://git.kernel.dk/linux.git io_uring-6.2
console output: https://syzkaller.appspot.com/x/log.txt?x=13634a0f880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2edd87fe5cbdf43f
dashboard link: https://syzkaller.appspot.com/bug?extid=7df055631cd1be4586fd
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
