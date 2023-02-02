Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87144687CF2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 13:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbjBBMK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 07:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjBBMKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 07:10:25 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8938AC25
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 04:10:24 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id x9-20020a056e021ca900b0030f177273c3so1075888ill.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 04:10:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ijWayKF5ggK69XyoBZToPMEIyZDoGPPBLOVHjV6MNQU=;
        b=J8Z85TH2VWiMip8g/+mgbjeeeglrLH+SiYDkw++lMg+xazm1Klh1hVAtEH0lr2OXr9
         SpWF+833698a4Bz3aRanB2icM4U/eKGnfpHvobakre7qUIEANrfhJQqmKDUI42wMEVYB
         4NPR6Dp5WHh1QGxsD7aXUYfO0CeOzgvjtPfWN8SmpgEIpZQt/3ROAPo1mEN2JJXX1Rqv
         Ny+Q8wE/oXx1PlLEQWF2z7ccm8l2gs4MI+LTBuOvSxJoZRMAM9Ckzz/k+q645ZRuvKmb
         ciWvgk78DHNFqFGOoSCqs2eZZ1n7g0XzAShC55GwKXZYx2k3mqPeguxqrs4XTTgVK0iz
         I2OA==
X-Gm-Message-State: AO0yUKWiKrT3jki8YzjpUujNz3mgPVc0/vAELS7n+jkwVhzh68A8x29L
        nxihYr+ZTz+bWXo6XmIwwTCEsznmWw33YupdjX/t3hmnZ5s8
X-Google-Smtp-Source: AK7set9AbnNoYKjx/qSkKWWOgIpAdmAM+7Lz7wDL1WptOFcb+5ZDCwCqkslyhwjhRXyLIy+Mfl08lwSTXn8Ea+H5lnxWbsrRqyOy
MIME-Version: 1.0
X-Received: by 2002:a6b:a07:0:b0:6df:2c9f:f8fc with SMTP id
 z7-20020a6b0a07000000b006df2c9ff8fcmr1297397ioi.4.1675339824005; Thu, 02 Feb
 2023 04:10:24 -0800 (PST)
Date:   Thu, 02 Feb 2023 04:10:23 -0800
In-Reply-To: <000000000000befd1d05eeb5af30@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000168a9205f3b6738f@google.com>
Subject: Re: [syzbot] WARNING in ext4_expand_extra_isize_ea
From:   syzbot <syzbot+4d99a966fd74bdeeec36@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, bagasdotme@gmail.com,
        ebiggers@kernel.org, guohanjun@huawei.com, jack@suse.cz,
        johnny.chenyi@huawei.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, liuyongqiang13@huawei.com,
        miaoxie@huawei.com, patchwork@huawei.com,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu,
        weiyongjun1@huawei.com, yanaijie@huawei.com, yebin10@huawei.com,
        yebin@huaweicloud.com, yuehaibing@huawei.com
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

commit cc12a6f25e07ed05d5825a1664b67a970842b2ca
Author: Ye Bin <yebin10@huawei.com>
Date:   Thu Dec 8 02:32:31 2022 +0000

    ext4: allocate extended attribute value in vmalloc area

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14e7b9a5480000
start commit:   644e9524388a Merge tag 'for-v6.1-rc' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d01b6e3197974dd
dashboard link: https://syzkaller.appspot.com/bug?extid=4d99a966fd74bdeeec36
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12f49603880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=163dfb9b880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: ext4: allocate extended attribute value in vmalloc area

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
