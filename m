Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134B06892C2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 09:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjBCIx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 03:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbjBCIxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 03:53:24 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54E920697
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 00:53:21 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id d24-20020a5d9bd8000000b006ee2ddf6d77so2677623ion.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 00:53:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HKmKJPDbIloaVF9wxjUKzLZJm032XxjfFf+EFpRM0Yk=;
        b=8EgeS09PVC42EZYgxDHx+GjooUH6DcWhjT3fjbBO5YlxbK/LTBpFte01jaP/02wqiK
         cWsXJCxtSfFbuUUGKnS7vWFXmI0ykILOb2Vva3MuqRryl/fiRog+xfZhwclCaX4EhEAJ
         VQRV0lkddyxRuqOPACXri42vCJzny9zV9P0s3QW1pDy/SzGlo0hTHuDyJe4ftQj/5oDY
         lu+5jijl4krtaEj3BkGwYx5fkmpwy5+r8cS3Ff9Pw42h2Otm9WIjBOqkS5BspR6unhGY
         czUlluIHayF0ArpWdu1iZej5lxhrdEQbD73JpbdZk0d7zitalGz/ssPA7a8vyPWwF6Yt
         xpGA==
X-Gm-Message-State: AO0yUKXK22rY3mbuE9x+OhABiqy5zkIka1vQp5tQtwkm7bhbVaU3hzqb
        d4Y9gU3iO6MNILqgKf7piTA8LOB6sgD8a5rfKzCSrn31s6iU
X-Google-Smtp-Source: AK7set992YEjU59mc5KBs7LOS8DgjU2Yp0XuHbujD6DIew8NCUbNVWokx5RUonIbg1J0OqznsgdoGqUe6RiTEkrlZf+r1Sdtfvj2
MIME-Version: 1.0
X-Received: by 2002:a02:ac8e:0:b0:3b1:92c0:ac28 with SMTP id
 x14-20020a02ac8e000000b003b192c0ac28mr2337676jan.74.1675414401053; Fri, 03
 Feb 2023 00:53:21 -0800 (PST)
Date:   Fri, 03 Feb 2023 00:53:21 -0800
In-Reply-To: <000000000000cbd8aa05f1fd2516@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000039fb2d05f3c7d0ed@google.com>
Subject: Re: [syzbot] [ext4?] INFO: task hung in ext4_evict_ea_inode
From:   syzbot <syzbot+38e6635a03c83c76297a@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, alim.akhtar@samsung.com,
        avri.altman@wdc.com, beanhuo@micron.com, bvanassche@acm.org,
        hdanton@sina.com, jejb@linux.ibm.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu, wsa+renesas@sang-engineering.com
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

commit 82ede9c19839079e7953a47895729852a440080c
Author: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date:   Tue Jun 21 14:46:53 2022 +0000

    scsi: ufs: core: Fix typos in error messages

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=132b298b480000
start commit:   a689b938df39 Merge tag 'block-2023-01-06' of git://git.ker..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10ab298b480000
console output: https://syzkaller.appspot.com/x/log.txt?x=172b298b480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=33ad6720950f996d
dashboard link: https://syzkaller.appspot.com/bug?extid=38e6635a03c83c76297a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=114dd83a480000

Reported-by: syzbot+38e6635a03c83c76297a@syzkaller.appspotmail.com
Fixes: 82ede9c19839 ("scsi: ufs: core: Fix typos in error messages")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
