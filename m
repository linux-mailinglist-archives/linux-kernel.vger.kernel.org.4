Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E2D6C3C9A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 22:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjCUV03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 17:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjCUV01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 17:26:27 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190C457D2A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 14:26:24 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id l7-20020a0566022dc700b0074cc9aba965so8354767iow.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 14:26:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679433983;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C+FYNnqKd+w1ZGDSpw0zb6Lp4HM2HTikzf97IDwlhu4=;
        b=2CXf7tO4Nauh4jsFHmjZzDNYtOzmUIPIOO/IZCxzXXhQy60VzvOdeC/krJ6hxL28iu
         X3TxvyiIpiqOpPFUYQibyBWl0JFbebBWEqNyB6Y0QsYWJgfwi1Gmrw+mvx51zw8rIJgM
         CPHvf6fiAdimT3WgOmUZHocjrYHOx+1csZTFSDBgsXAHmnTLMqD0H47C9t4DFnf8OgVF
         eM+4tP6o2TqhH3C1CBvC4tDBhBVhMEwFxokRFtJ6nEUeUThQ/icFerAQUBEJOjI/N4lK
         6gCugSouB1UtlMENNQCLBUArj46cZfNOqXh/NRDVYQPSlMNdhae7xO2oWgPkEFqKS7vn
         V9ig==
X-Gm-Message-State: AO0yUKUdUHlktoV0HqImFW/RHubEPbc/F0fGFcbAkaksZnDLE+KVZhVd
        pYDRoBN1VY6zZcH820EpCSnETeCBOPtTdxMp7nlhxkArJ8Mg
X-Google-Smtp-Source: AK7set8j1wnd0RNetmYMJ/6UVm+vkodHnklVedOj+4iGTAzRcSeU6bH9Zrt6hOlJcbmSWyRb6BJUUARVYMGbJfml75OIIWH9dC2/
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:f13:b0:310:fc49:1d9 with SMTP id
 x19-20020a056e020f1300b00310fc4901d9mr1464283ilj.6.1679433983388; Tue, 21 Mar
 2023 14:26:23 -0700 (PDT)
Date:   Tue, 21 Mar 2023 14:26:23 -0700
In-Reply-To: <00000000000022a65705ec7f923c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000000f2d005f76fb25e@google.com>
Subject: Re: [syzbot] [reiserfs?] kernel BUG in do_journal_begin_r
From:   syzbot <syzbot+2da5e132dd0268a9c0e4@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, axboe@kernel.dk, bvanassche@acm.org,
        idosch@nvidia.com, jack@suse.cz, jacob.e.keller@intel.com,
        jiri@nvidia.com, jlayton@kernel.org, kuba@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        neilb@suse.de, pabeni@redhat.com, reiserfs-devel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org,
        yi.zhang@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.1 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit b20b8aec6ffc07bb547966b356780cd344f20f5b
Author: Ido Schimmel <idosch@nvidia.com>
Date:   Wed Feb 15 07:31:39 2023 +0000

    devlink: Fix netdev notifier chain corruption

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=139af019c80000
start commit:   033c40a89f55 Merge tag 'apparmor-v6.2-rc9' of git://git.ke..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe56f7d193926860
dashboard link: https://syzkaller.appspot.com/bug?extid=2da5e132dd0268a9c0e4
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1264a8d7480000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: devlink: Fix netdev notifier chain corruption

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
