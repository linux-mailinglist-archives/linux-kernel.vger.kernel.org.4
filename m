Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49764669454
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 11:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241263AbjAMKiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 05:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241216AbjAMKhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 05:37:31 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C95774581
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 02:35:32 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id w18-20020a5d9cd2000000b006e32359d7fcso13196968iow.15
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 02:35:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l1+xVltypcnxAkvWPCQxFM0n2XimN1lwperOL1Mtxsc=;
        b=tVNQG5Tx5U3GFKuFejqyAJQ9lca48G1sXli9apbPJXNZjbrxipZKISO1r9wHGEuJ9Y
         3CtpR7HaUxPRvBi4vU6jXMOBvVMUookNsQo7lZ3KscBqSM9GhJlpHZJcMVVO25jX2v/c
         8uPbLgFbbPGlePCuXw4ttVQNnMAVejnZx6H+S5ja8WLZAfAwC0k1FKm7jTRYtwMvaluK
         Bh1XaYYda0WLZAlEyLE8MborgDNcja/aaQdiwEfENE8rdlz+sO9N6CijnHdF+Fu4ArMb
         1E6gsZNLlROuWBPm/d7HdZlX8NfaxCdV2Q8dAqqi5CW5VAmfGQ40NIf2x6RMJ4+ga1mP
         6aRQ==
X-Gm-Message-State: AFqh2ko6tBiRq6MGbA6HHanbw033DvVYnfhRa6Z83DN/oEZJNps/xfsd
        4jDoVUlqUpHRXf0G2ji4K1wruEQ+j5eeBfs8VEIGwobDX0PI
X-Google-Smtp-Source: AMrXdXueeOIjbgfJsuBkstMAC9Xwe+1dbnbo484X5eHTUi4XAlHe/5Z1A3bZDcjhLu3OpLSqti+aeZx4FW67RwpWMZUBFutdcV5B
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:789:b0:30d:a9e6:785c with SMTP id
 q9-20020a056e02078900b0030da9e6785cmr2630943ils.213.1673606132313; Fri, 13
 Jan 2023 02:35:32 -0800 (PST)
Date:   Fri, 13 Jan 2023 02:35:32 -0800
In-Reply-To: <00000000000015ac7905e97ebaed@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000002b67005f222cbba@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in rdma_close
From:   syzbot <syzbot+67d13108d855f451cafc@syzkaller.appspotmail.com>
To:     asmadeus@codewreck.org, dan.carpenter@oracle.com,
        davem@davemloft.net, edumazet@google.com, ericvh@gmail.com,
        kuba@kernel.org, leon@kernel.org, linux-kernel@vger.kernel.org,
        linux_oss@crudebyte.com, lucho@ionkov.net, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
        v9fs-developer@lists.sourceforge.net
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

This bug is marked as fixed by commit:
9p: client_create/destroy: only call trans_mod->close after create

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=67d13108d855f451cafc

---
[1] I expect the commit to be present in:

1. for-kernelci branch of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

2. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

3. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

4. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

The full list of 10 trees can be found at
https://syzkaller.appspot.com/upstream/repos
