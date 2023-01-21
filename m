Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB9E676926
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 21:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjAUUTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 15:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjAUUTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 15:19:44 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0B723C5E
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 12:19:20 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id g1-20020a92cda1000000b0030c45d93884so5954430ild.16
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 12:19:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pe29fqGB5jw0Lc13jqigdvwWKgCeBel/2NyFQTzRKFU=;
        b=xgkXgvCvXWH4F/M/tSF5/c1ynKoV1b4dONmt638vea66239V5GRzGlBZRF0kUqz+EP
         9eMvwq5125Y0BE6LjClKlwU4UmSiWDVqPkJOdA/YsUlPxoWe+V1Pe3deqLUDQKZgZMH4
         yE4fT3PGPiqE8d3FQgF8JAUor025ukUJ9ML2OiH7GAdMyT+yzCN+sFQCrSJJ0hSBE+cI
         kl7XFLezIQNm1whvZ4cEanW6gUQgZtocnSXvHCHTQ4yC1HRcVAZw0kGRYq4k7snmZmgc
         rrc/ZsCTcuv0/u4fAuFGP5X6nDzOCrV4yVvmUNXIeASOxi973ojcRCBZki8+XiCvaene
         g9rQ==
X-Gm-Message-State: AFqh2kp5j/5V+J4w8PRFjhqrEGfQ+r03tJhOriHIfrfRkQ36xa9YIe8s
        8UH9si7JMxqNFwwWMbtozzNARAuTS4IMXfq742guPB8QXPUG
X-Google-Smtp-Source: AMrXdXsMhd7fYTsq8AER0qV8wQz7Ln6057/YOLIm7ow9udsEXxqSp9CcJM7BO7xCaulaDj1Cf8u+Mwjm49RoRMxr6/2pXgX+5eSL
MIME-Version: 1.0
X-Received: by 2002:a05:6638:24c:b0:3a6:c95:e160 with SMTP id
 w12-20020a056638024c00b003a60c95e160mr1517664jaq.34.1674332359101; Sat, 21
 Jan 2023 12:19:19 -0800 (PST)
Date:   Sat, 21 Jan 2023 12:19:19 -0800
In-Reply-To: <0000000000004ab8ac05ef9b1578@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008016d805f2cbe102@google.com>
Subject: Re: [syzbot] [xfs?] KASAN: stack-out-of-bounds Read in xfs_buf_lock
From:   syzbot <syzbot+0bc698a422b5e4ac988c@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, dan.j.williams@intel.com,
        djwong@kernel.org, hch@lst.de, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

syzbot has bisected this issue to:

commit 679a99495b8fda800037b25af8cd990eb7dd72c9
Author: Christoph Hellwig <hch@lst.de>
Date:   Mon Nov 29 10:21:41 2021 +0000

    xfs: factor out a xfs_setup_dax_always helper

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17708805480000
start commit:   7dd4b804e080 Merge tag 'nfsd-6.2-3' of git://git.kernel.or..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14f08805480000
console output: https://syzkaller.appspot.com/x/log.txt?x=10f08805480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2b6ecad960fc703e
dashboard link: https://syzkaller.appspot.com/bug?extid=0bc698a422b5e4ac988c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10c58bd2480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11cc664a480000

Reported-by: syzbot+0bc698a422b5e4ac988c@syzkaller.appspotmail.com
Fixes: 679a99495b8f ("xfs: factor out a xfs_setup_dax_always helper")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
