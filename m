Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C91570187A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 19:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjEMR3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 13:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjEMR3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 13:29:44 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D2C30FF
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 10:29:42 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-33338be98cdso64293485ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 10:29:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683998982; x=1686590982;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FbbmGkWIHFvHvZe0ffM+JCbiEheWBrVPtCvSgO2HARM=;
        b=eRiPykrBiVZraLGvOdVkb2QOpeuyH2q+vEpBY8XhawGIKEfGt/CdWqrDnCRC7YMbV2
         EjIkqavcvT9bvsfPhBdy8KxpFvrWR1Im8bKFn3AGSiOosLsVgyyoJfyz8v3MpvqfbLip
         an1oTsGXspLmxH15NEHenkSAwfZ+0zvJ3Y9OmuhRIGvjzWjhNiBmW/GjMG8Nd9k4BWNE
         IDeL/uHogIYvZf/RPvCBZf516mu1W34xae/tM62I5Ue5F13xmof3t7C4pYjc+FTZU74v
         KNvuYpTIWVbLOqOfX4cW2KF8GQCJLyolVraaFxJ1ipUSXVohM9C+Ve0cWXSoUJCwlW2O
         YRYg==
X-Gm-Message-State: AC+VfDzv3KByAHhX9ifAMfvlbyrWNps/2NwYnOrV2MRkdwUf6v3Nkp7X
        VCf3S1d08Qf/S4q97YTzW8f1zDLnSuYf5T2feVpER0RQY8DA
X-Google-Smtp-Source: ACHHUZ6Bge/ArExOnk8wEIK3iLc7XEi++eAV73yB8VeTPDfq9sh9MV/yAB5YBU9N9xid7sAkfDKnO8KwEkvb97I4zV8FaBYXRj92
MIME-Version: 1.0
X-Received: by 2002:a02:b1da:0:b0:40f:91fd:6f3c with SMTP id
 u26-20020a02b1da000000b0040f91fd6f3cmr8105325jah.2.1683998981954; Sat, 13 May
 2023 10:29:41 -0700 (PDT)
Date:   Sat, 13 May 2023 10:29:41 -0700
In-Reply-To: <0000000000001ca8c205f0f3ee00@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001f239205fb969174@google.com>
Subject: Re: [syzbot] [xfs?] KASAN: use-after-free Read in xfs_btree_lookup_get_block
From:   syzbot <syzbot+7e9494b8b399902e994e@syzkaller.appspotmail.com>
To:     david@fromorbit.com, dchinner@redhat.com, djwong@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

syzbot suspects this issue was fixed by commit:

commit 22ed903eee23a5b174e240f1cdfa9acf393a5210
Author: Darrick J. Wong <djwong@kernel.org>
Date:   Wed Apr 12 05:49:23 2023 +0000

    xfs: verify buffer contents when we skip log replay

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12710f7a280000
start commit:   1b929c02afd3 Linux 6.2-rc1
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=68e0be42c8ee4bb4
dashboard link: https://syzkaller.appspot.com/bug?extid=7e9494b8b399902e994e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=172ff2e4480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11715ea8480000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: xfs: verify buffer contents when we skip log replay

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
