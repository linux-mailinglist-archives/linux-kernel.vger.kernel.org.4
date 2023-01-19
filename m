Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEDB673482
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 10:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjASJfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 04:35:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjASJfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 04:35:16 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7E64CE5D
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 01:35:16 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id g11-20020a056e021a2b00b0030da3e7916fso1201198ile.18
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 01:35:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=am8GpKWA1BfZfDywTelCI0lV8JSyrH6JH35aW+117pk=;
        b=561KcE8P2fxlT0dA7pwkr5XtmboCvRdpwX4qw9sLoKJcgzLRt+kbeSG4MXoSiKmX9L
         AcOFvcaaXtz59a8m+IChZP2O0TwDVMJrThDLMaPsxex0dbuQit0Doc37yWZJVeKop/2h
         9s3+bWv4GFpkh71ekg5e8dn9Uxx4tjGVZI4162RY5ZSuD5UsfjrY5cUg7WYrR/OGMu4+
         p038P77mao3GEkMP7xiVOzdF5mAZXGuIFVfq43ND7ZOWc7yP0ryamCoPPeB9y/35LQN3
         l+Zp5lnhc9Qb5ZJxL0yn5ZSqRNKqRShDq3I+BiHDlCiz+84hfrS0iITLPcqMf+R/0HIe
         dtnA==
X-Gm-Message-State: AFqh2kqAWARvUrrwa1LswfHxzEfmiLZz+Il7z9zGZe9yzvNd8Z+HTzIo
        X5R9MIE3VUNaeUuWleiyg8Vmb8tOKI5N644gd0+ntAZ49AjN
X-Google-Smtp-Source: AMrXdXsOAWPE6bSz4Hy3s0I/hLKjZwQxD0yrmoLIlj3p9fBgVOSQZ+UzmiokcTtqSqnCIFMwiC7AwT2r4rkTMOuBnMzWq3EzLcwe
MIME-Version: 1.0
X-Received: by 2002:a92:d241:0:b0:302:fe4d:3b9f with SMTP id
 v1-20020a92d241000000b00302fe4d3b9fmr1103045ilg.54.1674120915492; Thu, 19 Jan
 2023 01:35:15 -0800 (PST)
Date:   Thu, 19 Jan 2023 01:35:15 -0800
In-Reply-To: <000000000000d7eced05f01fa8d0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007aa8fc05f29aa6d7@google.com>
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Read in mi_find_attr
From:   syzbot <syzbot+8ebb469b64740648f1c3@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 6e5be40d32fb1907285277c02e74493ed43d77fe
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Fri Aug 13 14:21:30 2021 +0000

    fs/ntfs3: Add NTFS3 in fs/Kconfig and fs/Makefile

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=111e2f0e480000
start commit:   e2ca6ba6ba01 Merge tag 'mm-stable-2022-12-13' of git://git..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=131e2f0e480000
console output: https://syzkaller.appspot.com/x/log.txt?x=151e2f0e480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a6133b41a9a0f500
dashboard link: https://syzkaller.appspot.com/bug?extid=8ebb469b64740648f1c3
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16fb2ad0480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=164513e0480000

Reported-by: syzbot+8ebb469b64740648f1c3@syzkaller.appspotmail.com
Fixes: 6e5be40d32fb ("fs/ntfs3: Add NTFS3 in fs/Kconfig and fs/Makefile")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
