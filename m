Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6097161D778
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 06:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiKEF1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 01:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiKEF1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 01:27:19 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278A92EF4F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 22:27:18 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id r197-20020a6b8fce000000b006c3fc33424dso4190859iod.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 22:27:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ASnNDxhoqSLaBjncwLtyuIp6tFD08p3uNjxVPZiJKI=;
        b=y1HeU337liEjK14bpC2B5JNfmZNbPIbFCgpN9Gfk+P5q+tiIzyCNW3Q2KsKnBPk6vk
         eVIsUuPuLwd6q99cDrbFRKuQ6daNUxiMtkiR3dMm8iXBKg0MPhO3gZVn9Dr5m/S9TDdc
         /57eFMeaogIbjZiHCF17voQSXY7gV2RC7t3UqjKeTD0bQ4D/1t8uGnmCvrwCF1PaRKF9
         zUdj4r/dziK7teGfDL5QPyEvtCn3jPCNvoUzPQGF1REP0tOEbCEK9JjUO5Jz7QJcmhTY
         oU2Cfq3jIHvt+UmE0+iSdFQIL0Oo3wTS9zcavL3gWE5NkasFxD8Hn/O8cwhmj2GzM7rW
         vZww==
X-Gm-Message-State: ACrzQf2iWOGH/sc9rB4fcNIeC+yFa8RWgExUdYZw0pN2LPxVkgiloGyJ
        rwzzKV/zn4l4tbp/XrT8o8qOaMgEEzffH5BuV261/hywp7cn
X-Google-Smtp-Source: AMsMyM6VWI4Vk3WRzJfNJhb6um+SW7Ecd5WwtI1YxMBLKoya+XpAkwf4Adj2jolavy1c/SExku6Efe+lBuQpH9G+Y3dNw75iPtHB
MIME-Version: 1.0
X-Received: by 2002:a02:a00f:0:b0:375:7166:2dac with SMTP id
 a15-20020a02a00f000000b0037571662dacmr14017102jah.49.1667626037516; Fri, 04
 Nov 2022 22:27:17 -0700 (PDT)
Date:   Fri, 04 Nov 2022 22:27:17 -0700
In-Reply-To: <00000000000041f5bc05e678fa9f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000959e6405ecb271a3@google.com>
Subject: Re: [syzbot] WARNING in __cancel_work
From:   syzbot <syzbot+10e37d0d88cbc2ea19e4@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, hdanton@sina.com,
        johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.dentz@gmail.com, luiz.von.dentz@intel.com,
        marcel@holtmann.org, netdev@vger.kernel.org, pabeni@redhat.com,
        penguin-kernel@I-love.SAKURA.ne.jp,
        penguin-kernel@i-love.sakura.ne.jp, syzkaller-bugs@googlegroups.com
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

syzbot suspects this issue was fixed by commit:

commit 2d2cb3066f2c90cd8ca540b36ba7a55e7f2406e0
Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date:   Sat Sep 3 15:32:56 2022 +0000

    Bluetooth: L2CAP: initialize delayed works at l2cap_chan_create()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1469d541880000
start commit:   7ebfc85e2cd7 Merge tag 'net-6.0-rc1' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=20bc0b329895d963
dashboard link: https://syzkaller.appspot.com/bug?extid=10e37d0d88cbc2ea19e4
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13537803080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12e68315080000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: Bluetooth: L2CAP: initialize delayed works at l2cap_chan_create()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
