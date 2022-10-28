Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070756108C6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 05:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235948AbiJ1De2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 23:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235712AbiJ1DeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 23:34:23 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12559D039B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 20:34:22 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id j17-20020a5d93d1000000b006bcdc6b49cbso3237537ioo.22
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 20:34:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d9bEgoyCkEVc1rviJui83BJ63zZs6aH07Bg8EsC0G6Q=;
        b=tFwUcpw+yHxc4WsUgOGcJ3fRPPuySON8fVRa9QjDZsXxCHBlhFBlRKzbpJpJIJ6+ok
         rWzEAXYUGKxFmb4eC9S/vqnaza9ElmbHnwp0ZKKjnVHJiodfDPm3PdwmyJtsvsKeGjqn
         vulE5sjr4OAM5/L8/rdOAEUKY920kqbTPENmfoSAG7xSQKWmENdt4yBn3EbBCnDQWRCV
         0I+DhPJssoGelUnoQJpsWpoSSuBB9sqMWLB4cvmUzwhrmqql82Fr0RpvCeGxbRXyaRA2
         M5fT6EXrbgSKj23SbMK8kSXwPuPUTsxsmNE5T0r43KlCZPAbMWB/0AfCagV1RsUnt5N2
         lmlQ==
X-Gm-Message-State: ACrzQf0WHaKLg51yFWHoKbKwsxn2CVoEskog8PvLPrNzQydir9AbfyrI
        c3kAxg2YgD91ty30/BL7AJYnZyepJPobzQm0/lQxl8x6SwaR
X-Google-Smtp-Source: AMsMyM5D1/vrXmJp1T7B1mMtXHgOipwY7DPBpP1Uj5RWHyfccshSXYdP3JkEur3gchsb3YuZ8eqSfmteGNHGkWetUR0eZ6NgKSgP
MIME-Version: 1.0
X-Received: by 2002:a05:6638:d96:b0:363:9ed9:1112 with SMTP id
 l22-20020a0566380d9600b003639ed91112mr32264367jaj.171.1666928061421; Thu, 27
 Oct 2022 20:34:21 -0700 (PDT)
Date:   Thu, 27 Oct 2022 20:34:21 -0700
In-Reply-To: <000000000000a7077705eae5f90c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f79f5905ec0fee38@google.com>
Subject: Re: [syzbot] BUG: unable to handle kernel NULL pointer dereference in f2fs_stop_discard_thread
From:   syzbot <syzbot+035a381ea1afb63f098d@syzkaller.appspotmail.com>
To:     changfengnan@vivo.com, chao@kernel.org, frank.li@vivo.com,
        jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        wuhoipok@gmail.com
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

syzbot has bisected this issue to:

commit 4d67490498acb4ffcef5ba7bc44990d46e66a44c
Author: Fengnan Chang <changfengnan@vivo.com>
Date:   Thu Aug 19 08:02:37 2021 +0000

    f2fs: Don't create discard thread when device doesn't support realtime discard

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17da7522880000
start commit:   247f34f7b803 Linux 6.1-rc2
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=143a7522880000
console output: https://syzkaller.appspot.com/x/log.txt?x=103a7522880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a66c6c673fb555e8
dashboard link: https://syzkaller.appspot.com/bug?extid=035a381ea1afb63f098d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d92d6a880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12e5dbba880000

Reported-by: syzbot+035a381ea1afb63f098d@syzkaller.appspotmail.com
Fixes: 4d67490498ac ("f2fs: Don't create discard thread when device doesn't support realtime discard")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
