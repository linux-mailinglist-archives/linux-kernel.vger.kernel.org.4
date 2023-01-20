Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B7D675F0D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 21:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjATUn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 15:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjATUn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 15:43:28 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3E094C98
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 12:43:27 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id l13-20020a056e0212ed00b00304c6338d79so4523127iln.21
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 12:43:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RsJ1Nljpon9SLJurOmoC1BIAWmEt4UdFJ9FMAmnjneo=;
        b=2o2uVWyHBvLhU5X1sg32mielFevVmDSvEK1BnP97250a/BQqqDZYBX6AIU1+iZZrqD
         7sAQU0EszNiwoSdL9FydzurQYFHDdTM1uB6x20WEpymxEor97zbr/bqnUfx9tCYgsBQM
         Priogr58hZQ+pKlrvAZ/q7tFepqRACGObsljbEIInNre+VfpZh9sS1BoZpOeUXcHNec5
         A8sijaYUsAUnS+ek61cinoRh2YkQE+LPn/DqMBvfGHxqpbyYTmORS9ThjkgIqA8vjH/L
         H2olFG9ZofwDs+VHmbf6nUYwx3Lug9LB/xZD4ukdpJKGHICl54tkz5fY8cxCGtfAlPsl
         7A1Q==
X-Gm-Message-State: AFqh2kqkTuPhTx2vocLfiQdsQT6+T2I1PTXEn05Sc2weQIHK/3huPJgG
        lJVSArYpFsli2X7rNTUM+m2xsMPx9d/ogUb1aCoebhCf7W2n
X-Google-Smtp-Source: AMrXdXugkmh4J5oclZpzPC4l3wq8MtWaI/4oNpFKdaoU/Q/TQ1+7KkWo6QQNdvY0vIjcfwY2XI3t/sIuf/zDdHaUGdeTDCuRUek7
MIME-Version: 1.0
X-Received: by 2002:a05:6638:515:b0:3a4:a464:27f1 with SMTP id
 i21-20020a056638051500b003a4a46427f1mr1390769jar.253.1674247406806; Fri, 20
 Jan 2023 12:43:26 -0800 (PST)
Date:   Fri, 20 Jan 2023 12:43:26 -0800
In-Reply-To: <000000000000fd3bbe05efb0d1fd@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f2f0bc05f2b819c6@google.com>
Subject: Re: [syzbot] [vfs?] [ntfs3?] [tmpfs?] WARNING in walk_component
From:   syzbot <syzbot+eba014ac93ef29f83dc8@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org,
        almaz.alexandrovich@paragon-software.com, hughd@google.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ntfs3@lists.linux.dev,
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

syzbot has bisected this issue to:

commit 6e5be40d32fb1907285277c02e74493ed43d77fe
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Fri Aug 13 14:21:30 2021 +0000

    fs/ntfs3: Add NTFS3 in fs/Kconfig and fs/Makefile

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=156b1c56480000
start commit:   1f5abbd77e2c Merge tag 'thermal-6.2-rc3' of git://git.kern..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=176b1c56480000
console output: https://syzkaller.appspot.com/x/log.txt?x=136b1c56480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=46221e8203c7aca6
dashboard link: https://syzkaller.appspot.com/bug?extid=eba014ac93ef29f83dc8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17f5d83a480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1727f4b4480000

Reported-by: syzbot+eba014ac93ef29f83dc8@syzkaller.appspotmail.com
Fixes: 6e5be40d32fb ("fs/ntfs3: Add NTFS3 in fs/Kconfig and fs/Makefile")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
