Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8743167FFE2
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 16:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234871AbjA2P0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 10:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjA2P0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 10:26:20 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C321A97B
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 07:26:18 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id g1-20020a92cda1000000b0030c45d93884so5983132ild.16
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 07:26:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8cF9L9jLWY8TFRKz3jdp0+sMF5n63XrGkYgD+r/LrUM=;
        b=1V+TAQQnyEilut58oKsc8eBtMJfqHAYWE7ws8GX3U1SvnZr2bIjprxAeT00Il+BTHq
         thEOFF3B940UvxU5yHM4c69y6Vd97VZC/1z+v9QBiijqguDSEIK5Q8utMJfNPT1cPZgu
         G2kjRoX4bmolZBHYOt18mcNXf0MdwqE12O6yx5BFY4xdnSHgg7OZevWmtPsnfSvQq7ks
         fetS32PvFGOVPqQm8hDZ3+6SaV+LcKg3hQqY44oq2Wuw0zaM8tJJDgvrwTRRso44fNZ2
         dppTbTyr1hmdAFWCxxP8xEiGBJ9tEIQTscqahENSI6BmCsEyN48Ev+gQqWzr33M3yhgP
         rsog==
X-Gm-Message-State: AO0yUKVmQwnrGP5ZjHnzGgN9Lz/3Vz5+DSK85+6jZ31Mde03q0Us45YG
        GAgPrOwH51fDJdAFmE+xM3m2YHqfJA7cNZyDSZhhXaI/F1ux
X-Google-Smtp-Source: AK7set+J97wR6pyTkJQzNgrvEAzGQv2Coaf5oP9nuxQEXIut8CfO8ZG6G1elUbRDOv3uUOL8oT6D2A3Lpa4yxBs0atsxKTWirtU4
MIME-Version: 1.0
X-Received: by 2002:a92:8e4d:0:b0:310:c52c:81ff with SMTP id
 k13-20020a928e4d000000b00310c52c81ffmr1143173ilh.50.1675005977489; Sun, 29
 Jan 2023 07:26:17 -0800 (PST)
Date:   Sun, 29 Jan 2023 07:26:17 -0800
In-Reply-To: <0000000000008f0ed405ed71ef58@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000048f87b05f368b832@google.com>
Subject: Re: [syzbot] possible deadlock in btrfs_dirty_inode
From:   syzbot <syzbot+37edf86c9b60581e523f@syzkaller.appspotmail.com>
To:     anand.jain@oracle.com, clm@fb.com, dsterba@suse.com,
        hdanton@sina.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

commit b740d806166979488e798e41743aaec051f2443f
Author: Josef Bacik <josef@toxicpanda.com>
Date:   Mon Nov 7 16:44:51 2022 +0000

    btrfs: free btrfs_path before copying root refs to userspace

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10cf123e480000
start commit:   77c51ba552a1 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=6f9416d398342c83
dashboard link: https://syzkaller.appspot.com/bug?extid=37edf86c9b60581e523f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148fcd31880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=167bfb31880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: btrfs: free btrfs_path before copying root refs to userspace

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
