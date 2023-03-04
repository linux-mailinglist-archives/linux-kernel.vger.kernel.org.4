Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB356AA634
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 01:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjCDAYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 19:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjCDAY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 19:24:29 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C76D536
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 16:24:27 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id 9-20020a5ea509000000b0074ca36737d2so2203063iog.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 16:24:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ZYmyZcEFeCrpiQdyta3UENL3SqrmhwvXMRdTdLZxLU=;
        b=yq7OKBTHsbmnfFAS5Mmatk13JG7YJPr07O64szx4xqvt6hiUlObhxN1pCgeLkxWm1b
         2gehB+455VEijklW+1GsewG6KNanvJUktxA2SJvdePj2ioERKQjBWX8ceZbBgAgfz7xq
         aWBoAxV8DMEyCT8ZC+NMGjLLkeQzvBYwvnM1kFas9eNOgp7XyGiQ9e0G3O/G/C8AhQgx
         ONyinNW/8QHeYkVjunVNMjrc90lN8aM4EGo1wf9iLY2JBupiTHjhInSMHmSHpK6lUa4O
         Wjh5gGkL08eL051C3jhBqmRzZEXViRjVIZzohZEPc8ZJXf62n1DHiMwob2L8LAeysd+I
         0Y2w==
X-Gm-Message-State: AO0yUKWFXU4aVpkfamj8xIIiI3VpXjMAA39wjik3s3DVLAM7vJBmTT4V
        5n4TYFw2795u9TFjG58+nx6vFiWU6a1WQPU38wQosVCYuTCU
X-Google-Smtp-Source: AK7set8lUEUPhNB1YHgN5ADW4DD1Pqs+xKieEI7h+pTBvr4zCVYoG0kIoZ7cSEJvk0tCug/77ditPeuKPIbWMZnEGQ1uyIKvf65b
MIME-Version: 1.0
X-Received: by 2002:a5d:93c1:0:b0:74d:5a9:b55a with SMTP id
 j1-20020a5d93c1000000b0074d05a9b55amr1580274ioo.0.1677889467347; Fri, 03 Mar
 2023 16:24:27 -0800 (PST)
Date:   Fri, 03 Mar 2023 16:24:27 -0800
In-Reply-To: <0000000000001544f005e381d722@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ac777e05f6081529@google.com>
Subject: Re: [syzbot] [fs?] KASAN: use-after-free Read in kill_fasync
From:   syzbot <syzbot+382c8824777dca2812fe@syzkaller.appspotmail.com>
To:     chuck.lever@oracle.com, frederic@kernel.org, hdanton@sina.com,
        jlayton@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        peterz@infradead.org, rafael.j.wysocki@intel.com,
        syzkaller-bugs@googlegroups.com, tony@atomide.com,
        ulf.hansson@linaro.org, viro@zeniv.linux.org.uk
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

commit 69d4c0d3218692ffa56b0e1b9c76c50c699d7044
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Thu Jan 12 19:43:58 2023 +0000

    entry, kasan, x86: Disallow overriding mem*() functions

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17adfae4c80000
start commit:   972a278fe60c Merge tag 'for-5.19-rc7-tag' of git://git.ker..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3cc990589d31f8d6
dashboard link: https://syzkaller.appspot.com/bug?extid=382c8824777dca2812fe
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=141c2dac080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1590cfa4080000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: entry, kasan, x86: Disallow overriding mem*() functions

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
