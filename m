Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545016A81E5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 13:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjCBMGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 07:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCBMGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 07:06:30 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4F63B3DA
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 04:06:29 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id y6-20020a056602120600b0074c87f954bfso10619479iot.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 04:06:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W+vGFryJyHO/kcxpjviopstdV6X7mkFZpRf95EKbss4=;
        b=FlsEU18oGGR1Ipdgng2z9ocP5pCKbRGv+yAiQfVQcheebrnWp2c52G9YZ2kTmFvyF8
         FosFE+rdFSEGd/p9oweg0OCdpK0MnOZgvicorPya7g2rq6Hg27Pjeiss1YdkkZLETZOe
         31Gm7eNX2EpKybA2U6mfTpmtmxSdELqRmCIVm4194QCSPzaK2aDjFAPjdMk6FkX8Cqwy
         CfdghR1POBuduKB8sjYj6kToP8qEpz6vwzvzDpHF6QbSqhsVXblaJIzmHMNI3Fq9HmpT
         eikcPEtUfxPMHUsUeJtkmGA5gmzuoksG5YNZk0uXGIqlww2wBfnz56tHaoC2LxavTihG
         Gkeg==
X-Gm-Message-State: AO0yUKV0bRTCwy/7Qui7FOXYwsd4/oFkIHOX317nqJ+ctxWrl3y3m+EU
        0IJ1oNd9qCGZ9Qo8GLEFnDHVfibNb+rusFPE0+NubW+bLpBh
X-Google-Smtp-Source: AK7set86njqnlQ595UPhEtBjsAoU+5M3f42yKnl+lTOrhfk8tX5iXCF1LaW4id7AOPgZ9ZLcR5qAulh3/EHAi4uFzqSSok1mm5p4
MIME-Version: 1.0
X-Received: by 2002:a02:9465:0:b0:3e0:6875:f5e2 with SMTP id
 a92-20020a029465000000b003e06875f5e2mr4612504jai.6.1677758788383; Thu, 02 Mar
 2023 04:06:28 -0800 (PST)
Date:   Thu, 02 Mar 2023 04:06:28 -0800
In-Reply-To: <000000000000e794f505f5e0029c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000099b9c905f5e9a820@google.com>
Subject: Re: [syzbot] [mm?] INFO: task hung in write_cache_pages (2)
From:   syzbot <syzbot+0adf31ecbba886ab504f@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, davem@davemloft.net, dvyukov@google.com,
        edumazet@google.com, elver@google.com, glider@google.com,
        hdanton@sina.com, kasan-dev@googlegroups.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
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

syzbot has bisected this issue to:

commit 17bb55487988c5dac32d55a4f085e52f875f98cc
Author: Matthew Wilcox (Oracle) <willy@infradead.org>
Date:   Tue May 17 22:12:25 2022 +0000

    ntfs: Remove check for PageError

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13fd6e54c80000
start commit:   489fa31ea873 Merge branch 'work.misc' of git://git.kernel...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10036e54c80000
console output: https://syzkaller.appspot.com/x/log.txt?x=17fd6e54c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cbfa7a73c540248d
dashboard link: https://syzkaller.appspot.com/bug?extid=0adf31ecbba886ab504f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16dc6960c80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16f39d50c80000

Reported-by: syzbot+0adf31ecbba886ab504f@syzkaller.appspotmail.com
Fixes: 17bb55487988 ("ntfs: Remove check for PageError")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
