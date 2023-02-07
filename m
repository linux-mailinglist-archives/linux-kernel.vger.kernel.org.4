Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E6168DBC0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 15:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbjBGOgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 09:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbjBGOgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 09:36:09 -0500
Received: from mail-il1-x148.google.com (mail-il1-x148.google.com [IPv6:2607:f8b0:4864:20::148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6DE41085
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 06:32:53 -0800 (PST)
Received: by mail-il1-x148.google.com with SMTP id g1-20020a92cda1000000b0030c45d93884so10811180ild.16
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 06:32:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MHvmkN0/lz5e2uZSzTP0PAhn6qcrEsMnI/EGrNMX6Dc=;
        b=7D0NjFn6kn2XS4GG3o0XOq+dj6PlrwlmPR4FdDyKPwyQX3fzNW+XrKg2DMsbnijxRV
         I1jXB2qHJL/L22JwAg2r+qzl4t5SNhmTOvB+4ZAIAWAsUypCJ5RepYm2785GKTdO/giV
         +VqvHqycAqHWF58+oh4qGQ9XsYM02XaLGqWoNNjpctWivrcYcRVHN5eAyz7HISG9ufum
         ia6R4G36nK7VbMc0iloOD/eKmYzFXORlIFcFvHGMi1kACBkHckUSHTD+56fMoz0Gnuuh
         CIgXuYmPFAS+FdHl9uSGZBbnuBEdsePG2PWRFyazMz6ckUzKwvnRPGjBrhjL3G1IgJ5X
         fplg==
X-Gm-Message-State: AO0yUKViKF99E9F1L19/+LCaNUnK20HoxBl2ZlHHlM7KFfZoXPDUCIAf
        G9kxWssiWjjOWTu+O+71PtLW4oylj5t+ADCV8nidebu1KF3j
X-Google-Smtp-Source: AK7set+RDCmQu7vyyueNAp2uziZXT5n6La9Hx5rltbF9uY3E6YW4Ax8bXn5BpYe4GzAoOntIdCxbbbpoWNsfviOgzxqB3qa6V47/
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:14c3:b0:310:ce0a:d866 with SMTP id
 o3-20020a056e0214c300b00310ce0ad866mr2462405ilk.23.1675780277262; Tue, 07 Feb
 2023 06:31:17 -0800 (PST)
Date:   Tue, 07 Feb 2023 06:31:17 -0800
In-Reply-To: <3151379.1675779370@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000025e37805f41d0049@google.com>
Subject: Re: [syzbot] kernel BUG in __tlb_remove_page_size (2)
From:   syzbot <syzbot+d87dd8e018fd2cc2528b@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        dhowells@redhat.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        npiggin@gmail.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: rcu detected stall in corrupted

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P5549 } 2638 jiffies s: 2817 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         fab9eebf iov_iter: Kill ITER_PIPE
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/ iov-fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=14e2c6f3480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=facc234423e66dc6
dashboard link: https://syzkaller.appspot.com/bug?extid=d87dd8e018fd2cc2528b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
