Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83EA55F80AA
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 00:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJGWIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 18:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJGWIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 18:08:23 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CAAD258B
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 15:08:22 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id i21-20020a056e021d1500b002f9e4f8eab7so4734679ila.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 15:08:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3MLPU74F3+6QXZTh1Q2e+ffMXLmh8O9A6adbCsWIvZM=;
        b=h+rf8ugK8Y8QURrysv96vgfGjN+x4Aqnn76e65+BgcnvkmgZK4YuXx+8J5uhvzdU5f
         39A7sR4NJGnesovsfDJmJ1P5kWpeHS32TiL29HSs/xyHiMwTWuFSOExfy7kFs8//SD4q
         nF5j48Wvgii7YYsGxl7lMk8wbwjP8sc59jAqaoXPhQCuoy5AXRyjgDVyhGMdU+CVu9Fe
         IHYJj+LgHuTed2QRs7/5sEhQDPpR/+6ruwTBZaYq1zwOVkvyuvSLJTxUKffdfSQ8D8Og
         xtsfxM5mNTXBNHPauDOCYfBlGlBmQaxO2udtmY8Dr5DzCkTHd1PySXOQpj6fnDgfPG3b
         afkA==
X-Gm-Message-State: ACrzQf1bg4qt+UCotVs7a/g612mgp5wZNZ8u+qM02kSr413IIhbI6RdM
        +F1LQ0AJ78PDnTn8b2O8gqo3k7RegfL0Fhqx+vsbcLTi97Nu
X-Google-Smtp-Source: AMsMyM4rH+FKGccUJ4CIIG5AIA9SpJMi9/O5BpcI21Jrn8IuicbbBHVI6C+JFM4YFp9t6GVA/uE3aF45zbzLjNQGVKCL68ohr2WE
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2dd5:b0:6a2:38e6:eaad with SMTP id
 l21-20020a0566022dd500b006a238e6eaadmr3289919iow.144.1665180502019; Fri, 07
 Oct 2022 15:08:22 -0700 (PDT)
Date:   Fri, 07 Oct 2022 15:08:22 -0700
In-Reply-To: <000000000000495a9305e9dea876@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004f5d5205ea790cf0@google.com>
Subject: Re: [syzbot] WARNING in change_pte_range
From:   syzbot <syzbot+2c2bb573a9524a95e787@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, david@redhat.com, jack@suse.cz,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, namit@vmware.com, peterx@redhat.com,
        rppt@kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
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

commit b1f9e876862d8f7176299ec4fb2108bc1045cbc8
Author: Peter Xu <peterx@redhat.com>
Date:   Fri May 13 03:22:56 2022 +0000

    mm/uffd: enable write protection for shmem & hugetlbfs

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=108e8fb8880000
start commit:   511cce163b75 Merge tag 'net-6.0-rc8' of git://git.kernel.o..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=128e8fb8880000
console output: https://syzkaller.appspot.com/x/log.txt?x=148e8fb8880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4520785fccee9b40
dashboard link: https://syzkaller.appspot.com/bug?extid=2c2bb573a9524a95e787
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14ecac35080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15668b38880000

Reported-by: syzbot+2c2bb573a9524a95e787@syzkaller.appspotmail.com
Fixes: b1f9e876862d ("mm/uffd: enable write protection for shmem & hugetlbfs")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
