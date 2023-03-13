Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F026B7A5D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 15:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbjCMOc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 10:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjCMOcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 10:32:25 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF92658497
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 07:32:24 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id c13-20020a0566022d0d00b0074cc4ed52d9so6430753iow.18
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 07:32:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678717944;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4y/5zA6M4Bgo32w3DEC2QVqTxoqFR5HvYaARqLXL8ek=;
        b=ecWXISq9FPf+bEDIWnBDd6dj74r1fWjP3Mc/zDVnFZe5aUqmm3wRSQPd71O0zwtmN2
         4WsKltisZnjXaONIlgLtHABfUrayZTaBs0/dlMGqYmEKwSqrxLqAR/ymxrI++31gKepS
         Z56DPR+TD+eC3Bm/GCYHRA8vKAlXGZxKfMgkQhNpECDQgy+rt0eYb6fcMRmq/bUIGWNI
         dEXP6ZjJo2+f5zw5xp7nejHcGJQ7eu6TYQPHb+7kUtrAFsGZsjL8IzPgJ2OxLQSMfFFr
         jc3r9Z/EMX7Or8S5p6D92CCkTmbKIKCD8MMudn4CIIx+BXdV6/hUmLtpEwvSeSdhMNqH
         SxNQ==
X-Gm-Message-State: AO0yUKVYyU+Yzg7Nkye+J4XqOnvlTiszolNp0UMBxKVn047qZUalKOYT
        NcJozyxtYYOdu7xRmxShpQqO7qHnwLrlQ6AMcboTE3IbxJDO
X-Google-Smtp-Source: AK7set//Vxwu9cDJinI5+BoatG3+ShJiVgoRfhjdyDSgiMrcH7fhxRJ3a933Uwu++c+91ZnsWuj/l+LRUU8CbGVvI5Y+IF2T/veh
MIME-Version: 1.0
X-Received: by 2002:a6b:7902:0:b0:745:70d7:4962 with SMTP id
 i2-20020a6b7902000000b0074570d74962mr15645557iop.0.1678717944153; Mon, 13 Mar
 2023 07:32:24 -0700 (PDT)
Date:   Mon, 13 Mar 2023 07:32:24 -0700
In-Reply-To: <000000000000f0fb6005f1cfc17f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bd527205f6c8fa41@google.com>
Subject: Re: [syzbot] [io-uring?] KASAN: use-after-free Read in io_wq_worker_wake
From:   syzbot <syzbot+b3ba2408ce0c74bb9230@syzkaller.appspotmail.com>
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

syzbot suspects this issue was fixed by commit:

commit e6db6f9398dadcbc06318a133d4c44a2d3844e61
Author: Jens Axboe <axboe@kernel.dk>
Date:   Sun Jan 8 17:39:17 2023 +0000

    io_uring/io-wq: only free worker if it was allocated for creation

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=113a76fac80000
start commit:   1fe4fd6f5cad Merge tag 'xfs-6.2-fixes-2' of git://git.kern..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=8b79b14037065d92
dashboard link: https://syzkaller.appspot.com/bug?extid=b3ba2408ce0c74bb9230
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1388e5f2480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=127f1aa4480000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: io_uring/io-wq: only free worker if it was allocated for creation

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
