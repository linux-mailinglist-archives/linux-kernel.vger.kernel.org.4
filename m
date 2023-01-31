Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C046828CC
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 10:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbjAaJ13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 04:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbjAaJ1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 04:27:24 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4591E1CF6B
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 01:27:18 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id r11-20020a6b8f0b000000b0071853768168so4259890iod.23
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 01:27:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=baRMDYfh/xlZwZGAG0yWHlpzuwaFuMZN9hC0V7iVjuc=;
        b=fSGlzlSK7tPh3/GhEfw+EmVU3iNeOnJS+r2j17jIuBOaFuI1Z4Vpc4a4fvwXpz/g0o
         RxnUV+Y8k2SxD/RPW0MJeTTxLHVNnlyPQNbFl68AQCqzsVWgeteGdyZ/4WhNU3zvDKY5
         wn6zfxSsfo1oQ/+ZrSBOd5wQmv2jEits7hu0FR4C4omC5TbqiPky++PbRIrMtoKBUrnT
         kbnuevajjSpbFxEaQ+xQsNvlSZFpE2BtCgSXAeBgHlcJPxM3Pd0JzYhZ1rDdSxwIVZoO
         763y8kyUk3UuozluhSSg0pZevQ2M6oTwWPctX6TTp9N8PHKlVTCAjVmhLz4m41CM+sRc
         cDiA==
X-Gm-Message-State: AO0yUKWHd+w+Ijtm8fQj2/sZ7dWcIojXCR6qgzTJ6v1Jz5fWEmeU8rHA
        NVBHvEk/y/S+Z4BHQ4vhiRVTWtr9OBIX4818t+ka1s4o0xBX
X-Google-Smtp-Source: AK7set8u4spgzHnLNJ4gN0tBiiWYVG3rnp0zIzeRaLeYX+acTnMe57OUFWUYS0D9NU/MPHWLIEUKjPHw+7whQBTcaEL3mtKntMHa
MIME-Version: 1.0
X-Received: by 2002:a92:3f04:0:b0:310:d43c:edf1 with SMTP id
 m4-20020a923f04000000b00310d43cedf1mr1923200ila.34.1675157237600; Tue, 31 Jan
 2023 01:27:17 -0800 (PST)
Date:   Tue, 31 Jan 2023 01:27:17 -0800
In-Reply-To: <000000000000d7eced05f01fa8d0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000171a2805f38bf07a@google.com>
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Read in mi_find_attr
From:   syzbot <syzbot+8ebb469b64740648f1c3@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com, edward.lo@ambergroup.io,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
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

commit 4f1dc7d9756e66f3f876839ea174df2e656b7f79
Author: Edward Lo <edward.lo@ambergroup.io>
Date:   Fri Sep 9 01:04:00 2022 +0000

    fs/ntfs3: Validate attribute name offset

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12e74535480000
start commit:   e2ca6ba6ba01 Merge tag 'mm-stable-2022-12-13' of git://git..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=a6133b41a9a0f500
dashboard link: https://syzkaller.appspot.com/bug?extid=8ebb469b64740648f1c3
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16fb2ad0480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=164513e0480000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs/ntfs3: Validate attribute name offset

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
