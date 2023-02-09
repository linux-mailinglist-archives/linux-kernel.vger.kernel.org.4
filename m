Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524C0690148
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 08:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjBIHeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 02:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBIHeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 02:34:20 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C011E9D2
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 23:34:19 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id o12-20020a056e02068c00b00313fe7757dbso1079048ils.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 23:34:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=34nRmfeUqTlP32NAMyzynpXO86DIrlluU6UV26B5jh8=;
        b=TlcO9gnJp3rBS62KOYSaLzX/cE8yEH/j5ceArX3F7If59zXaaD68b+ztHO0aIvyx0v
         gIzHcKmXFdAtrKX4kpke0c+B1btz7YIiEMchrN+Xvi7lGYjA7chIqxJk/07fR0+rCbBA
         nKPZ5ELlOLv9GeCJ3B7ZyzMzjJdxbRWohssjhGtjGamuhtMa5apuxERMr0aXBQ0OF1l1
         hfk6cTOQVkvRTT/ImGyvg/EYYg15/wS45rp0450mDgEakeQMHhBp5L9WRQLUMrFSmPto
         ctNhPn+TtUbM1TgB5EgxTZkk3iZD0DaG+0lUTFWkzQmwGaV07jeoDPXR8oTVR+Wsuipq
         aoSA==
X-Gm-Message-State: AO0yUKXL9MdIs4ra3zcNSAMZsGA6abgjXIXm+gye2382eiqyRaCPKuBm
        dxwhN7o+XaHm41cWP2eWKhc55H3beG9T03Jxbl5XURIgEcz4
X-Google-Smtp-Source: AK7set+2UxKQC1x0H3sMcHx980d7UZz4jPKXKjswcTZNCDMYUwCys8aYIhWNjJzWfR0KD64L5sOlEQrThHadAXLEemV1GWSUKrD4
MIME-Version: 1.0
X-Received: by 2002:a02:c953:0:b0:3a9:7066:1ad5 with SMTP id
 u19-20020a02c953000000b003a970661ad5mr7444419jao.38.1675928058664; Wed, 08
 Feb 2023 23:34:18 -0800 (PST)
Date:   Wed, 08 Feb 2023 23:34:18 -0800
In-Reply-To: <20230209072740.2224-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009b1e8a05f43f68a5@google.com>
Subject: Re: [syzbot] INFO: rcu detected stall in ext4_file_write_iter (6)
From:   syzbot <syzbot+b9564ba6e8e00694511b@syzkaller.appspotmail.com>
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

syzbot tried to test the proposed patch but the build/boot failed:

kernel/time/tick-sched.c:1498:40: error: expected ')' before ';' token
kernel/time/tick-sched.c:1498:2: error: too few arguments to function 'hrtimer_forward_now'
kernel/time/tick-sched.c:1500:25: error: expected ';' before '}' token
kernel/time/tick-sched.c:1501:1: error: control reaches end of non-void function [-Werror=return-type]


Tested on:

commit:         4fafd969 Add linux-next specific files for 20230203
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
dashboard link: https://syzkaller.appspot.com/bug?extid=b9564ba6e8e00694511b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17347093480000

