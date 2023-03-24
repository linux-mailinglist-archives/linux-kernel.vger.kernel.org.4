Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1FF6C7AF2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 10:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbjCXJNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 05:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjCXJNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 05:13:33 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BE31EFEB
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 02:13:32 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id j4-20020a6b5504000000b00758646159fbso793534iob.20
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 02:13:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679649211;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QExb/T1F8/XoorTxuEKbTqt2ECV6VnSe+3ISxG21XUQ=;
        b=b3gweLQ+dhmKQUNyEPZcHRPsUgkFBkZptnRHOX8oW0ascl+2YNQo4QjPwBpr8pRQVV
         MLR/V91LLypd49FUoQCixbZhrFR3p9neNFmq9GJAQGS3TDxvXBOcInRTfzSoNpVi/TUL
         QQN7YC53lpQLArOTS3cfWSYZPU4Lna5y9bUyh9SsjL2qMf+Qn1iK8Cb3hkzIjCbvRuQe
         /Tnx7AW+N/yN7MrBvObEOb846WqtcHqx3rJOu6HIfD468iuiWxU6IcBuWDNERpRZquKn
         TGaDgnG4YJFNVEZNbluZFwlFS2mucOLanaPna3KOGbeN70LO7H4dBv8VAqJhtVRBWV6u
         gchw==
X-Gm-Message-State: AO0yUKU3cogndvrl1RkeVRvbpbsJhl0Ksovz0v8J+WNiPI5h7+sUa4w2
        vuWD2pFKxyosVsgYJmIciSBjuyH7nuBzRN8Q4TIqdb/4tJPX
X-Google-Smtp-Source: AK7set+u9V3h/lFnpss+6vSzDvV1hDPTiWdu/52VHEtBts1JBVTxyLHO1pbJZyyllLB5e3fSkCqgmE/v2lcGcZ6C+6WU1l4vDvHu
MIME-Version: 1.0
X-Received: by 2002:a02:a189:0:b0:3c5:14cb:a83a with SMTP id
 n9-20020a02a189000000b003c514cba83amr639266jah.2.1679649211430; Fri, 24 Mar
 2023 02:13:31 -0700 (PDT)
Date:   Fri, 24 Mar 2023 02:13:31 -0700
In-Reply-To: <CAGxU2F7XjdKgdKwfZMT-sdJ+JK10p_2zNdaQeGBwm3jpEe1Xaw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000098457705f7a1ce42@google.com>
Subject: Re: [syzbot] [kvm?] [net?] [virt?] general protection fault in virtio_transport_purge_skbs
From:   syzbot <syzbot+befff0a9536049e7902e@syzkaller.appspotmail.com>
To:     avkrasnov@sberdevices.ru, bobby.eshleman@bytedance.com,
        bobby.eshleman@gmail.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, oxffffaa@gmail.com, pabeni@redhat.com,
        sgarzare@redhat.com, stefanha@redhat.com,
        syzkaller-bugs@googlegroups.com,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.1 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file net/vmw_vsock/vsock_loopback.c
patch: **** unexpected end of file in patch



Tested on:

commit:         fff5a5e7 Merge tag 'for-linus' of git://git.armlinux.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
dashboard link: https://syzkaller.appspot.com/bug?extid=befff0a9536049e7902e
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16b4bba1c80000

