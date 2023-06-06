Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B8B723E7B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 11:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbjFFJzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 05:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbjFFJzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 05:55:39 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C25E55
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 02:55:38 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-77a1f4e92cdso5142239f.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 02:55:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686045338; x=1688637338;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vHp7JhKpOLftA8ijBU5NEW0PH0Y4Ly54QRDLuuH98wQ=;
        b=NwQxhHie9RpGhIuBo6AE3q+5oFS+7CSbAMctm8phH/WvVzMeE1uPR/DhUg5FQ9ib42
         xp52qPgA7sjUUqzn9qRTyV+pbKWL//NUDqsqLUefQpqTgHJEvS0U35bOeLtd+4uQLOtQ
         ieCa6JhIDJDvLm9dksSX4kSOJBxizXVd0nRkcBgSNoHQxRh84iTVYB/MFYpTa1XiXp/H
         bZ2OSkrui9/JLrAwcRTxTzv/jR3iINweGRqSUwbMQb8oTpQ+KiISECl88akB6Oy4ml0u
         CEfpYm1oiG73hrFqL6XbIWYffCqAhbByyjOIhVro6cRSOM2y6E8HMhUoSlDtcF1Z4Eym
         9A5A==
X-Gm-Message-State: AC+VfDzo4zVP1l3UJZzVVBdNNCCfWoiOIKZc3W8Jey6mO4jQ+0kTImbc
        iSvo6FQZqCK4PzylDrnoakhf6EOaXtR/zoPuPrxzxvxZHMZR
X-Google-Smtp-Source: ACHHUZ6WLTcSDIIq1Kv0DMf4wTAm/1RJtlgXs9qRg8KIjuul16D89Csl9JRYFik6L8c4tUMMHqhwzA7cfC+KOGAhKoYpVXcRG3M1
MIME-Version: 1.0
X-Received: by 2002:a02:620e:0:b0:41e:7fef:24ea with SMTP id
 d14-20020a02620e000000b0041e7fef24eamr799123jac.1.1686045338103; Tue, 06 Jun
 2023 02:55:38 -0700 (PDT)
Date:   Tue, 06 Jun 2023 02:55:38 -0700
In-Reply-To: <00000000000002eb8105f51cfa96@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000073fb7305fd730525@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in btrfs_ioctl_add_dev
From:   syzbot <syzbot+afdee14f9fd3d20448e7@syzkaller.appspotmail.com>
To:     chris@chrisdown.name, clm@fb.com, dsterba@suse.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, xiaoshoukui@gmail.com,
        xiaoshoukui@ruijie.com.cn
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit ac868bc9d136cde6e3eb5de77019a63d57a540ff
Author: xiaoshoukui <xiaoshoukui@gmail.com>
Date:   Thu Apr 13 09:55:07 2023 +0000

    btrfs: fix assertion of exclop condition when starting balance

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12bdc3a3280000
start commit:   04a357b1f6f0 Merge tag 'mips_6.3_1' of git://git.kernel.or..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=f763d89e26d3d4c4
dashboard link: https://syzkaller.appspot.com/bug?extid=afdee14f9fd3d20448e7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11f043b0c80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15d2ea9cc80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: btrfs: fix assertion of exclop condition when starting balance

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
