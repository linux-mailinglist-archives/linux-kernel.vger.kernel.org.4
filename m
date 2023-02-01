Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F782686911
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 15:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbjBAOz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 09:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbjBAOzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 09:55:24 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E54966028
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 06:55:24 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id u6-20020a6be406000000b00716ceebf132so6739042iog.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 06:55:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZHi5bo3BzN4qPZ3mH6tPOGWzgbCBFQ/FU5LJ+gZiS0M=;
        b=ryckqB8BvXBV5D3A8gk3bdP6ydkIU3rSKShjaM+76eoWRkLvuqMTK5DZyuRchImUBe
         7Dt6K+O0/qbHdzFwVnPUvODtfc1gpMuKThhylqgqtgynmPIePMV3Rdxq7KZsL9lHIWjk
         a80a3eu57Sw4/gstSuwHh917GZdu8M/cncv2S8se5zTFH9/+tHtZxGWazISNw5qNh4dH
         8kROCs9X6+zWYCZr6rHx+HnLakvaWQgwKWkWDYx2ew7zeH8nZ+l6SbUJZ/LgHzbWIlL+
         qf815ehAkfsZu9rGeDyMVIaUKBRDenTI1hU2hAJ8vd+fNRxr3UemwxSPdBrlVE5PlITt
         Fr6g==
X-Gm-Message-State: AO0yUKX4Eq1bM8IrEZcZSYU1AgQYrResvNjUCaqHdUJtOJipFIAe5huu
        gEIk8KK7WUBDnyMcfE9E287GFv6xPIh2ZtptPM8kQHZ4QCfe
X-Google-Smtp-Source: AK7set+UGIpl3wTKHaXpzg2fKL3h3H9zyaLxeaTVojjCe5oJvNoD9IYP7owJ4jx6i4ZQp7jUcj6Al1H/hidiUGa7GTzzorVtLAFy
MIME-Version: 1.0
X-Received: by 2002:a02:9468:0:b0:375:c16b:7776 with SMTP id
 a95-20020a029468000000b00375c16b7776mr540197jai.54.1675263323110; Wed, 01 Feb
 2023 06:55:23 -0800 (PST)
Date:   Wed, 01 Feb 2023 06:55:23 -0800
In-Reply-To: <000000000000fea8c705e9a732af@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000047848f05f3a4a32f@google.com>
Subject: Re: [syzbot] [ntfs3?] KASAN: use-after-free Read in hdr_find_e
From:   syzbot <syzbot+c986d2a447ac6fb27b02@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev, pjwatson999@gmail.com,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
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

commit 0e8235d28f3a0e9eda9f02ff67ee566d5f42b66b
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Mon Oct 10 10:15:33 2022 +0000

    fs/ntfs3: Check fields while reading

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1268739e480000
start commit:   55be6084c8e0 Merge tag 'timers-core-2022-10-05' of git://g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=df75278aabf0681a
dashboard link: https://syzkaller.appspot.com/bug?extid=c986d2a447ac6fb27b02
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=164e92a4880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=126f7ac6880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs/ntfs3: Check fields while reading

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
