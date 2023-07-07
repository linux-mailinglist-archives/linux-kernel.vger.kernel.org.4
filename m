Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F70374B98E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 00:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjGGWcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 18:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjGGWca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 18:32:30 -0400
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47602123
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 15:32:29 -0700 (PDT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-53450fa3a18so3569926a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 15:32:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688769149; x=1691361149;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JrBZCM2sZbAEtmzMwiNkMKBUDefOdEVG2GINkQd/o2I=;
        b=POnyiiOkFnLWCggAeAfB0BQVLPEQX9oh6LeBuuGZmDrpttZnuoCQKvyyiH3FjHDrGs
         8863/mXd0MSkNqSMgf92AUJxa/jNuWXVMldeCo3y/cAiCH9gWSsgWova+N3lV4LZAOPM
         UdVW85bbwNK+2ZOkWL3iiAOx4K3b6tX3ZQpaEWkXzsGZsj+GK3j6Ow6oAvYy3jvozwme
         LfJgUS8jieENVTQR8A5TsrDy3WiAHiZsMDqIrpYIEBirS3SIlwd//ZGflYsK0D2wpx/H
         IbvYWvd2aJRrLibqdKGsbPGccecM1SYSEnb6y6CKL88L/GybQqFets2g1tz5oF5aEPrI
         WHmg==
X-Gm-Message-State: ABy/qLbYdfCjfhSxFwCkCKf4PHwkHCzg4rWghZ+hyDXvKmWlxHIPxJ5r
        wFQ1zr9p9FctCA/GdL8SN3KTeue0791yrHCB8f1+YI3kkuxL
X-Google-Smtp-Source: APBJJlHIN2tTYXymcCUfXVwsV+PDUVJ2fikgqRYkjrV4CjneUIezMffsOm9xPaios13wH8u6jIYhec5vLxheC5G5bAqo82SGxkqg
MIME-Version: 1.0
X-Received: by 2002:a63:4b10:0:b0:557:7f87:e5fb with SMTP id
 y16-20020a634b10000000b005577f87e5fbmr4278933pga.8.1688769149292; Fri, 07 Jul
 2023 15:32:29 -0700 (PDT)
Date:   Fri, 07 Jul 2023 15:32:29 -0700
In-Reply-To: <000000000000ae0f7b05d77b27b5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000040576405ffed3547@google.com>
Subject: Re: [syzbot] [block?] [trace?] WARNING in blk_register_tracepoints
From:   syzbot <syzbot+c54ded83396afee31eb1@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        mhiramat@kernel.org, mingo@redhat.com, rostedt@goodmis.org,
        syzkaller-bugs@googlegroups.com, yukuai3@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit fcaa174a9c995cf0af3967e55644a1543ea07e36
Author: Yu Kuai <yukuai3@huawei.com>
Date:   Wed Jun 21 16:01:11 2023 +0000

    scsi/sg: don't grab scsi host module reference

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13470f02a80000
start commit:   c8451c141e07 Merge tag 'acpi-6.2-rc2' of git://git.kernel...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=2651619a26b4d687
dashboard link: https://syzkaller.appspot.com/bug?extid=c54ded83396afee31eb1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1655b82a480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11ef7348480000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: scsi/sg: don't grab scsi host module reference

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
