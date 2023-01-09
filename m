Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D60661CD7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 04:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234878AbjAIDrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 22:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233695AbjAIDrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 22:47:17 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA0A274
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 19:47:16 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id g11-20020a6be60b000000b006e2c707e565so4121477ioh.14
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 19:47:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E6PSNSHuzrJBJ/47W8KvJu4qLfm98K6cE9rADnwjx6Y=;
        b=AjL/idRoTkDRqqVyu+hUllkXp4qdJ1mQuelaiYs0CNRR1zXLws/Kz60+g34hMs0MgY
         8YXtElmjlwHn0sRT7nNgxvjF9Q+REgp2VdfW880lHxIqp0F6MfU4EllU/HzjbysOI0FM
         U+ivuO03FblvDbZv23IK8+juLzd8+2wmz01pQZhjrtFbsx4m6BiOIwe6ChoyVixldelg
         xkgaXasaMc0PQmUlmkszd/LafpBvPimtmdnMDwAwqjbPWb319ScglXOz+mW+XR9M6wk2
         Ub+kdEisWDtXI3Ro7utAYbDBa0sPzFE5Xsy2sk/oWtUdl8ksbCZb/48iq7UfQ4hFtbrw
         9f4g==
X-Gm-Message-State: AFqh2kroRrlUVEsZInkoI6YFRLDHSKBIHW9OBEl7MoQF9pII9B0zw8nN
        9DuLD643dGyiZQw+LWKZUDjSUHO1qoENF/IeNTbs6qx6Z+6X
X-Google-Smtp-Source: AMrXdXvi2iDuNkvMJihht1FzczeqZ0AFlaBPeGXZ1mRxRpJ3AGgVatdbWS7VO7fy12IupJ4K0R7vk2GFTp6TstNz2IVpsPGEoeta
MIME-Version: 1.0
X-Received: by 2002:a05:6638:60a:b0:363:ae32:346f with SMTP id
 g10-20020a056638060a00b00363ae32346fmr7177789jar.31.1673236036189; Sun, 08
 Jan 2023 19:47:16 -0800 (PST)
Date:   Sun, 08 Jan 2023 19:47:16 -0800
In-Reply-To: <df7cb4c5-eae8-1aa4-2c1d-4cbf3c651c1a@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000090056605f1cc9f96@google.com>
Subject: Re: [syzbot] KASAN: wild-memory-access Read in io_wq_worker_running
From:   syzbot <syzbot+d56ec896af3637bdb7e4@syzkaller.appspotmail.com>
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

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P5561 } 2648 jiffies s: 2797 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         a4b98579 Merge branch 'io_uring-6.2' into syztest
git tree:       git://git.kernel.dk/linux.git syztest
console output: https://syzkaller.appspot.com/x/log.txt?x=17668ed6480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8b79b14037065d92
dashboard link: https://syzkaller.appspot.com/bug?extid=d56ec896af3637bdb7e4
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
