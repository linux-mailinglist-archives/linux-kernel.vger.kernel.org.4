Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81773683A35
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 00:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbjAaXFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 18:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjAaXFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 18:05:19 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8C746727
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 15:05:18 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id s12-20020a056e021a0c00b0030efd0ed890so10274633ild.7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 15:05:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R4iyyOrc6238HvaMcaieQzTGBVMZ/RTQVCphLPtOjNc=;
        b=tRRNYSO9NsXJT96FhXTz7/yc3u+XhbzXY8+G5AnZm0FnffQeKxxGLm3s0o0AKowtDg
         vT2Zy9Ai+vDM01RUlzgpv/7YzXaahndUbvqUwSzHVS0A6GRnXYFEVLtJlESaFSxGm0gn
         RLrWAPj3oJ0PkOHn8wBeAajqjuyaNIbAr8kbkF26Tub36OfmyCxZ+qG6aWLpS2hbxsi1
         l82nDJxAyIcoxh22+tUrMsO6hXFD1ik5cow7iG3FNOld3xQvFs8DFXABQhj0/AyKzx7m
         8q5/WqUYZ1OYi/UJOvbJjNn/ys6/8JzJfLfMW70sOHyCRqjPFM6C7t1ooQByKs0CYOrO
         sITg==
X-Gm-Message-State: AO0yUKVWp0FF7UnOi1YN9oekFkRBVCcWIo/0lgYe3ZwIkPW26rVuvayE
        uZAm003V7VH6y8pebyUk/beIonwmOQZnuhYfUbJjMqfa1vAA
X-Google-Smtp-Source: AK7set+xfaVn822GQwLvNUzcEtvC3HGMC+oo8z7EbMNQNTmnEoZst/FpfJ9IhQkBtyJiDdL0yd/or5pNXLdpAGKb8zNtzhHh62Kk
MIME-Version: 1.0
X-Received: by 2002:a05:6638:f08:b0:3af:cb24:3f85 with SMTP id
 h8-20020a0566380f0800b003afcb243f85mr2387710jas.104.1675206317689; Tue, 31
 Jan 2023 15:05:17 -0800 (PST)
Date:   Tue, 31 Jan 2023 15:05:17 -0800
In-Reply-To: <00000000000010d44905f01bf8e7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007dd57305f3975d7d@google.com>
Subject: Re: [syzbot] [ntfs3?] BUG: unable to handle kernel NULL pointer
 dereference in ntfs_sparse_cluster
From:   syzbot <syzbot+deb631beeb93bdb2df4c@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, ndesaulniers@google.com, ntfs3@lists.linux.dev,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
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

commit c380b52f6c5702cc4bdda5e6d456d6c19a201a0b
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Fri Oct 7 11:02:36 2022 +0000

    fs/ntfs3: Change new sparse cluster processing

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1377b979480000
start commit:   e2ca6ba6ba01 Merge tag 'mm-stable-2022-12-13' of git://git..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=276eb8ff64eb2c27
dashboard link: https://syzkaller.appspot.com/bug?extid=deb631beeb93bdb2df4c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10d8601b880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17a09c93880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs/ntfs3: Change new sparse cluster processing

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
