Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99E26B5D44
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 16:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjCKPP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 10:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjCKPP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 10:15:27 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F97CED694
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 07:15:26 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id a21-20020a5d9595000000b0074c9dc19e16so3966156ioo.15
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 07:15:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678547725;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6P10G5iUaSESkeHIuwzpZYyTiHSBK9Tr6QOwEjj60lg=;
        b=a0M2kMqYa7FlHOA+nWNBd0QeJNGn0xZu/RSjNP14BFs+bcqZHh1ZzE4L7YMKl822Bn
         JeSAKR3H8miIpjx2wUOnK/wLuJGLB1bcTxM3Z7YwRCS3qTe3xTaEbZGdRWQQaG28Fmy9
         vTj8xJ8LJGfG3WVw7Mg/bredII0eVxDdEKJsab/zAj9YKnM6BCoaZhqWJhGye9DxSUf2
         9kTP/CG8a8dzBk0npm2B2L2gIvFCDkfZ+qC39iwmj3WzNwKQUeB3svoPgqVAIlTNxgR2
         0u0Xqh5itSO06WroTWfdXThT9HRfDBSUwVhWDjHSz/zRQmLKuuqMR0JijZ2b3w2uM8xr
         szwQ==
X-Gm-Message-State: AO0yUKV7bl1W1oW6k9eQRvLr3DTWSldiO2886YzxpwHlE4/FUhaaF415
        bA1QeEl4m9f9gDLuZnwW+5AwFMNLGjXrTx2H6xk5dooa4MYo
X-Google-Smtp-Source: AK7set+PSWjoQX2+68dRj/Pny+y3li1xYjAsCmhN3Z0xdH3vqct4gUrytkcd8XlfS0r535494+alL7EUx64Sxi5G36UKFF1faKva
MIME-Version: 1.0
X-Received: by 2002:a02:620f:0:b0:3c9:562:1366 with SMTP id
 d15-20020a02620f000000b003c905621366mr14732712jac.3.1678547725605; Sat, 11
 Mar 2023 07:15:25 -0800 (PST)
Date:   Sat, 11 Mar 2023 07:15:25 -0800
In-Reply-To: <0000000000009bff3c05f1ce87f1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ec64a805f6a158c3@google.com>
Subject: Re: [syzbot] [io-uring?] KASAN: use-after-free Read in io_wqe_worker (2)
From:   syzbot <syzbot+ad53b671c30ddaba634d@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, hayeswang@realtek.com,
        io-uring@vger.kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 02767440e1dda9861a11ca1dbe0f19a760b1d5c2
Author: Hayes Wang <hayeswang@realtek.com>
Date:   Thu Jan 19 07:40:43 2023 +0000

    r8152: reduce the control transfer of rtl8152_get_version()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13284762c80000
start commit:   9b43a525db12 Merge tag 'nfs-for-6.2-2' of git://git.linux-..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=ff5cf657dd0e7643
dashboard link: https://syzkaller.appspot.com/bug?extid=ad53b671c30ddaba634d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=160480ba480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14cddc6a480000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: r8152: reduce the control transfer of rtl8152_get_version()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
