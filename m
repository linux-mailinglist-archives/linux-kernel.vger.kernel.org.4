Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64CB35FB67C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 17:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbiJKPFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 11:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbiJKPDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 11:03:49 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B593A485B
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 07:59:02 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id 75-20020a6b144e000000b006bbed69b669so4980105iou.21
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 07:59:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qF3bHglYM71ubF3LjTgpbSJ9mSeb4/93dHfb62LacMI=;
        b=Vz3zFPTL4y5lEZl4PoOBuS7JHkk8ve84L/dGTsHUnhutOH3QJn231v5Y7/46NTQVfB
         yZAm5gkdGHnZ4z/ihR8HYmVDnvzeHGU8T5a/VJWS5AA3Gh57J15QrEZGiEjL3Po82C2g
         iW6NbKszckSx/CI3DOc9JLO69z1KEzDu8ZQ2BXgYNPZwNw6+6hxUP5HZhjN+jIrzPVzM
         S/4elHXkHyrSMc4ALuugGvfwZPPO0sNoTr2kpNGhFDZ2YDA9jTpRWOa+moMiTl/TqVwX
         GJ87Xotqi/55oJciMYNrgsCeMGb6W2RFQ2wvvUj4KSg+JTTc9DFMRClCTjg6c8t4/V80
         EoIA==
X-Gm-Message-State: ACrzQf0/NVK5Aj2k8j+HFEiRyifoN1EHaVHS/gdSi545PSRH4McLXPKy
        LlytlPgiiOF0ULifah/pB8UvTsG836TNvdEJ4ns/RZaulHoJ
X-Google-Smtp-Source: AMsMyM7uxTnyHSXsJBUCAatNCZgPs4iJZ2j8Qh6dtKm925bfqUNqLgDkazQ+wb9lkhqiH6twZ7i/aeZ9BwembhcAYrUl5e7ItM9m
MIME-Version: 1.0
X-Received: by 2002:a05:6602:168d:b0:6bc:36a0:254b with SMTP id
 s13-20020a056602168d00b006bc36a0254bmr4588645iow.80.1665500243768; Tue, 11
 Oct 2022 07:57:23 -0700 (PDT)
Date:   Tue, 11 Oct 2022 07:57:23 -0700
In-Reply-To: <00000000000037b96205eabe49b5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000673b6305eac37e1f@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in move_expired_inodes (2)
From:   syzbot <syzbot+6ba92bd00d5093f7e371@syzkaller.appspotmail.com>
To:     hirofumi@mail.parknet.co.jp, jack@suse.cz, lczerner@redhat.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit cbfecb927f429a6fa613d74b998496bd71e4438a
Author: Lukas Czerner <lczerner@redhat.com>
Date:   Thu Aug 25 10:06:57 2022 +0000

    fs: record I_DIRTY_TIME even if inode already has I_DIRTY_INODE

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17e93452880000
start commit:   493ffd6605b2 Merge tag 'ucount-rlimits-cleanups-for-v5.19'..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14193452880000
console output: https://syzkaller.appspot.com/x/log.txt?x=10193452880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d19f5d16783f901
dashboard link: https://syzkaller.appspot.com/bug?extid=6ba92bd00d5093f7e371
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1724028a880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17419234880000

Reported-by: syzbot+6ba92bd00d5093f7e371@syzkaller.appspotmail.com
Fixes: cbfecb927f42 ("fs: record I_DIRTY_TIME even if inode already has I_DIRTY_INODE")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
