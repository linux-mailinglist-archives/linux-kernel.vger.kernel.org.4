Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBA270D92F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 11:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236366AbjEWJfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 05:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236377AbjEWJeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 05:34:44 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EB71AC
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 02:34:31 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-763da06581dso285646339f.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 02:34:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684834471; x=1687426471;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6XhonWAPAu8OTH4owMzaT0fJr80igSY+VEVOwOtFTeA=;
        b=IoPNwOkQD7O0YgTcffud0oM0HIy5dd6xUiadPqZK7//DzmGw9yn2JTtFLOriIHm5VD
         HHzsWlxiu1134+rTcsp4DTatdJkmUsIEZgIF/IqSozATKiIBo9f1QKz6B2LDtOPccVNZ
         88nUq4nMfiVQComo8Nb3FA1MspZ42hQOXf03ykMnAb7wDs/VyA0CkRpErG3yhSCgr+B5
         CvvbSbi5KLJT2ko8Clnpt4nLYxfJwNAyD+NlbnxvP4FvAbYyrL4izL+rItSiMJW3wBSZ
         1sRXukmyJOFru1bAhHefEH3IhBMXIczrqHpsthvZlCiOGQBr/QcR59k6BFkq1R6+1fIa
         pzww==
X-Gm-Message-State: AC+VfDyA1EXSfr7POyxF/2QI/xrVbsAuXeb0DT0ADehU0OBEwwEDVcf2
        qC26D4hhTJVw9wRriauTbemmd9ih2IILvldn4UK2UB7Z+AZB
X-Google-Smtp-Source: ACHHUZ5YZD8fx0KgCTuHpDJe0wpCyOKPizAlCEPgXSRJ4L1EvfuXNi5P5YSJh8gMioCuqsedxNrAggthsCP4xsGho4gpnN+tE5a8
MIME-Version: 1.0
X-Received: by 2002:a5d:9285:0:b0:763:5a5a:90e7 with SMTP id
 s5-20020a5d9285000000b007635a5a90e7mr6621320iom.3.1684834471032; Tue, 23 May
 2023 02:34:31 -0700 (PDT)
Date:   Tue, 23 May 2023 02:34:31 -0700
In-Reply-To: <00000000000066a94205fc488445@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000026bdd305fc5918a5@google.com>
Subject: Re: [syzbot] [block?] [reiserfs?] KASAN: user-memory-access Write in zram_slot_lock
From:   syzbot <syzbot+b8d61a58b7c7ebd2c8e0@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, axboe@kernel.dk, hch@lst.de,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        reiserfs-devel@vger.kernel.org, senozhatsky@chromium.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 9fe95babc7420722d39a1ded379027a1e1825d3a
Author: Christoph Hellwig <hch@lst.de>
Date:   Tue Apr 11 17:14:44 2023 +0000

    zram: remove valid_io_request

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=132fa586280000
start commit:   44c026a73be8 Linux 6.4-rc3
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10afa586280000
console output: https://syzkaller.appspot.com/x/log.txt?x=172fa586280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d8067683055e3f5
dashboard link: https://syzkaller.appspot.com/bug?extid=b8d61a58b7c7ebd2c8e0
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1223f7d9280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1245326a280000

Reported-by: syzbot+b8d61a58b7c7ebd2c8e0@syzkaller.appspotmail.com
Fixes: 9fe95babc742 ("zram: remove valid_io_request")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
