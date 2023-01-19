Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1D8673EDB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 17:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjASQbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 11:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjASQbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 11:31:24 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD504E518
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 08:31:22 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id r6-20020a92cd86000000b00304b2d1c2d7so1922747ilb.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 08:31:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dmhp+2IAI3g3qDOv15A77xhg9oc5VA7p9d1CqGLWy2s=;
        b=fqoTK5ecpmr53Iu/NzngRJbu4/9cGCJpiYCABKhINjU3Ltk1BUDG6abR+8fqOCuv4B
         9MEPgRu98Z9Ekf6hYW139TEDnDzy8sBBiQYLiuDd6ckoZKIXpnGxk67vf9QI6ySKwOnA
         vUhD95zSZD11FkvFCQatyiQCpKYAt95gtx25GuByYZLe5TfmoAWqJw2ND2XNBXP/ELk1
         cml89nXvXVsQ15+rlYJIT5MKeFAozBGgT/x0McDrTdqn0uIFiPMM8S+pmatwtAshZ9Ac
         5gl7dLfIVFlSvvMQ0MyynxSKwRJzMNI1h5O3KOd/ysfs0gct7t05c4s+Uc4tLXryXafz
         Lo9w==
X-Gm-Message-State: AFqh2kqE29D7UPCxmFiE6cIoCxy6/tpuGO+vXOvsiEG3Df5jWf1jQA+Z
        oUsNC1d3raOKzVN7rlmouqYK5PQ7DomHYML2ypvdgLwb9isL
X-Google-Smtp-Source: AMrXdXtVr57YNgl1eBdlM3krd9MaBpgSpj/K+zbJkq3fy2mnWv0s6siuxSohmU7qeB9JTHKab9JcXFmoy/4bPOO9VyZta6YyMWhI
MIME-Version: 1.0
X-Received: by 2002:a92:2807:0:b0:30e:d439:eccc with SMTP id
 l7-20020a922807000000b0030ed439ecccmr1260604ilf.76.1674145882239; Thu, 19 Jan
 2023 08:31:22 -0800 (PST)
Date:   Thu, 19 Jan 2023 08:31:22 -0800
In-Reply-To: <0000000000003198a505f0076823@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009cfc1705f2a07641@google.com>
Subject: Re: [syzbot] [udf?] BUG: unable to handle kernel NULL pointer
 dereference in __writepage
From:   syzbot <syzbot+c27475eb921c46bbdc62@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, hch@lst.de, jack@suse.com, jack@suse.cz,
        linkinjeon@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
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

commit 36273e5b4e3a934c6d346c8f0b16b97e018094af
Author: Christoph Hellwig <hch@lst.de>
Date:   Sun Nov 13 16:29:02 2022 +0000

    udf: remove ->writepage

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15176e66480000
start commit:   77856d911a8c Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17176e66480000
console output: https://syzkaller.appspot.com/x/log.txt?x=13176e66480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=55043d38f21f0e0f
dashboard link: https://syzkaller.appspot.com/bug?extid=c27475eb921c46bbdc62
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=141da6e7880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17d81b8b880000

Reported-by: syzbot+c27475eb921c46bbdc62@syzkaller.appspotmail.com
Fixes: 36273e5b4e3a ("udf: remove ->writepage")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
