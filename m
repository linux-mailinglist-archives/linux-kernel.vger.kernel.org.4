Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09FBB7174F9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 06:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbjEaEOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 00:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234080AbjEaEOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 00:14:30 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDD5BE
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 21:14:29 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7773a91a912so39494439f.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 21:14:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685506468; x=1688098468;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oQ8lccKkDI0BWu9z1HB+e7MlGRULvpuKC8oP5Znml6Y=;
        b=UnKY4iRE6PAiB3TUOO60xFuKQyVxeeeqn19y83gVnn6wuTarJq8DntCTtlsmp4R+Sy
         wY9x2iwEOCcUZzUXJmZejqdv5OgxUjJ2nhr4XUIUWjNzwKpGorI8kiCJuObzZMbM1Yjh
         hT44qt93mmCpYoto4GEWQQZTVnhE7ishWwnVMEWGwrUT22CHkUdwWP1a7cJ7KTToa497
         3qx6KQvkYH/Ev59nBnb7z7GNc35qB4U/MJdEPT5kxebNnnyPkVD3miio2Y1QQ8fklI92
         Q7qc5QmWj2asq0CqTooY7IZBWML4Gb5XvkpHlyOVtFvm/shVfNV8C5q+cSkNLXG+Kl/Q
         Yf/w==
X-Gm-Message-State: AC+VfDw/58CA3h8sjq6OoJKal3L+FnfpL1A0GMVYpT4szsatnfmNJMsv
        Sn0euSblEe3W/R/qxPzo3833ld4vqFzN0lyvTVrOLq7xyEOE
X-Google-Smtp-Source: ACHHUZ6ijLZzEZwuH0NsIQsxc2DP3wZIt7NQIH+V0p25HtMvQGsTBm7wIgmvAtUsrUwp+QLAYA9eicuP9Hvyt6mCmRqtQ6uApq/A
MIME-Version: 1.0
X-Received: by 2002:a02:a19d:0:b0:41a:f4a3:9884 with SMTP id
 n29-20020a02a19d000000b0041af4a39884mr2015057jah.1.1685506467298; Tue, 30 May
 2023 21:14:27 -0700 (PDT)
Date:   Tue, 30 May 2023 21:14:27 -0700
In-Reply-To: <000000000000030b7e05f7b9ac32@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000040020d05fcf58ebf@google.com>
Subject: Re: [syzbot] [ntfs3?] WARNING in attr_data_get_block (2)
From:   syzbot <syzbot+a98f21ebda0a437b04d7@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 68674f94ffc9dddc45e7733963ecc35c5eda9efd
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat Apr 15 18:47:06 2023 +0000

    x86: don't use REP_GOOD or ERMS for small memory copies

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12de3271280000
start commit:   ffe78bbd5121 Merge tag 'xtensa-20230327' of https://github..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=9c35b3803e5ad668
dashboard link: https://syzkaller.appspot.com/bug?extid=a98f21ebda0a437b04d7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=139dca3ec80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15a55a35c80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: x86: don't use REP_GOOD or ERMS for small memory copies

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
