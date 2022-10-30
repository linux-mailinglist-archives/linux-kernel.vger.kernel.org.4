Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29038612798
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 06:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiJ3FlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 01:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiJ3FlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 01:41:18 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D56C2124B
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 22:41:16 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id h6-20020a92c266000000b00300624bf414so7897996ild.14
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 22:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LMH67DLr37XpWQPukqCW0d3TMkMjMRPPe5mLQsfeTPc=;
        b=JH6uhmaJrOzJIT/0OeLMS50qaqbTwjdciWzJWrj4Ekq4BeaQVHld/97TU/XZI4TTuk
         t71d3zT+q2CqyUmcDVjnzIr4JibgtCl+Rz7yjx3tNeVhHhJTDvD+bSaEjRdljcIhIqVF
         0+VgZ+oK4+UmUIAS7yBkI6CKCwF1tLMpYh6rviMjqrsLoO+n/X1q4b8AbP7fJCo7INn3
         AJ+6knhDERuTNblgVlkz349wSmrw3VSglSr0vhcmhwGX58lGbxN9Y4wAsGIZkRlISot2
         LyJ6bzh1n0ZrfuFcWXaGKGoa2QMf0gE5Cv5a9ZTebxUa5DeE9nVbNiw5YN7BdnXAvyR/
         7i7Q==
X-Gm-Message-State: ACrzQf1la/IV25ih2X4P4CWbm+qV5AYAztkInFkxMDinE2QmPH9482YW
        tvmdc7MTY08D9V0vzvDoxhJ+rzECVDy54Ph/i5V9HGwHEYby
X-Google-Smtp-Source: AMsMyM4Vg/JTXGJ2tlZP/1A9x78LOefhNVYfz+G7wXL5hIJJt/uRM82/OoOhLIQgR8TJN+TmbJzpKwZG0EGK+pa1VLm4ypUCJ96p
MIME-Version: 1.0
X-Received: by 2002:a5d:8913:0:b0:6a4:71b5:8036 with SMTP id
 b19-20020a5d8913000000b006a471b58036mr3521632ion.171.1667108475731; Sat, 29
 Oct 2022 22:41:15 -0700 (PDT)
Date:   Sat, 29 Oct 2022 22:41:15 -0700
In-Reply-To: <20221029161418.2709-1-yin31149@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007fa5c805ec39f00a@google.com>
Subject: Re: [syzbot] memory leak in regulatory_hint_core
From:   syzbot <syzbot+232ebdbd36706c965ebf@syzkaller.appspotmail.com>
To:     18801353760@163.com, davem@davemloft.net, edumazet@google.com,
        jhs@mojatatu.com, jiri@resnulli.us, johannes@sipsolutions.net,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
        xiyou.wangcong@gmail.com, yin31149@gmail.com
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
SYZFATAL: executor failed NUM times: executor NUM: exit status NUM

2022/10/30 05:33:05 SYZFATAL: executor failed 11 times: executor 0: exit status 67
SYZFAIL: wrong response packet
 (errno 16: Device or resource busy)
loop exited with status 67

SYZFAIL: wrong response packet
 (errno 16: Device or resource busy)
loop exited with status 67


Tested on:

commit:         aae703b0 Merge tag 'for-6.1-rc1-tag' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12e3a3e2880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2f454d7d3b63980
dashboard link: https://syzkaller.appspot.com/bug?extid=232ebdbd36706c965ebf
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10eb44b6880000

