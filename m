Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8CBF61A584
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 00:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiKDXPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 19:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiKDXP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 19:15:28 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0984B223
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 16:15:28 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id n4-20020a056e02140400b00300cc49a4d0so4830526ilo.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 16:15:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dh6VHIpm1eezFlTH8nL0qyHX0V1j8bdMOwrcsVM6rA8=;
        b=ixbx6IffSg66ucHcBEEXT5Mqls11SuDIQquE2on7VNsvoX3GV8UR3LgAjbum8A05Bu
         7a3IKd5oL3olUEcsAKWoPdg3cABVnkx5IIr1vcMfjC/P4FSw3+1QGVfKSNKJIaU/pscC
         /7NAGHKHNXjNdMQfA9yP36vHYcWA9EtBpfIa/ZjDMyZRIQmC2oPATWFK3HOmMPYIBEXK
         BHt3LShLIK05I449sTjUMFXmWjAtc3thS+LK0CbYXO1NZmJZFI/CUu9vjh353JSoOjjN
         c6YQJn8/JLsiCUrtzg3yTyrmQ1j2vqMKs0QFTTW8OKAOfDpiIiNR0ckcw581/jIL2Brn
         UFSA==
X-Gm-Message-State: ACrzQf0ATnEFpXwXYio9D5ZtI5QSxHYcFjF0F6nWsiO3HdV/enRr8jR8
        M+469gNK8Pen+cvRypgD4nuY72c0EO61/AEpS1dwB1M17wjO
X-Google-Smtp-Source: AMsMyM6Yhhk6S7iWVKjK0DufhE4CY5LjPiIvqTntkN0077ZdHDFfJb4pnUCW2o7r/3LujeDACdaHe1t1hKvTl8SoUx9p1Kuq5wbH
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2b09:b0:67f:c159:91b9 with SMTP id
 p9-20020a0566022b0900b0067fc15991b9mr22856707iov.182.1667603727430; Fri, 04
 Nov 2022 16:15:27 -0700 (PDT)
Date:   Fri, 04 Nov 2022 16:15:27 -0700
In-Reply-To: <00000000000082ed3805ea318a4a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ccbdf705ecad3fda@google.com>
Subject: Re: [syzbot] kernel BUG in ext4_mb_use_inode_pa
From:   syzbot <syzbot+4998f18bcd5fc7e40c8b@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, jack@suse.cz, lczerner@redhat.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tadeusz.struk@linaro.org,
        tytso@mit.edu
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

commit 4bb26f2885ac6930984ee451b952c5a6042f2c0e
Author: Jan Kara <jack@suse.cz>
Date:   Wed Jul 27 15:57:53 2022 +0000

    ext4: avoid crash when inline data creation follows DIO write

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14eb2fb6880000
start commit:   4fe89d07dcc2 Linux 6.0
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=48b99eaecc2b324f
dashboard link: https://syzkaller.appspot.com/bug?extid=4998f18bcd5fc7e40c8b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=119bc15c880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13d97bc0880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: ext4: avoid crash when inline data creation follows DIO write

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
