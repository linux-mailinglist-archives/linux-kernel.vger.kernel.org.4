Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196026369B6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 20:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239857AbiKWTPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 14:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239848AbiKWTPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 14:15:41 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9753C5611
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 11:15:37 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id k3-20020a92c243000000b0030201475a6bso13353792ilo.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 11:15:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+OMnEyU4oxI5f5wx1GLYp+ZsI1aPHf/OqbCiQbPxXTY=;
        b=kseA0AZhJvNN1rSkLbmO3FByiBm2Xov9sN6PFIFfEufQbNSX1+HdyPr3FFj5vNj/GI
         dWeHttTKWqkw27broVfi6cCZ23JE3/r62RrXgh7S0U3LtSQwzsvc00MjPRWNQZKuhS4b
         X06dC4oZMmehedJ6fzmliVzjpjICrCw82TT1K0SIk1sPbWCX2SV/bqUnTeYQkiDsUjMl
         BrWhTV+dAO7gtv32EvrFp63yoBkhaJNBbJNgwzoHRBHODPFDmw/hJiKCynWcMWxjnG08
         0ORyxkY0n4f9RyovmL/Qxbqu8SYXSUP2g036sHIqUezJKrOjmNcrH0ydmH5BtLd9NDF0
         IvHQ==
X-Gm-Message-State: ANoB5pl1J9XV6+2yazwR19afq2VmjLJqghG3X7ZeDoHHk3fEeymDeWKQ
        5kMkEGlJHx79W94FqaMTfY0SoaXOyj1nTrbqK7aDI4dgNII0
X-Google-Smtp-Source: AA0mqf7CjJZIJv7lABB1S7AxpsJyownOJmyFk2iuAEnVpsp3Er47xPPdpyDDJ5Pd59mIsa8YgGrZmDhfM5JJT13Vmf1Zen+I6zKJ
MIME-Version: 1.0
X-Received: by 2002:a6b:490c:0:b0:6d5:9493:57c6 with SMTP id
 u12-20020a6b490c000000b006d5949357c6mr13830616iob.15.1669230937295; Wed, 23
 Nov 2022 11:15:37 -0800 (PST)
Date:   Wed, 23 Nov 2022 11:15:37 -0800
In-Reply-To: <20221123120238.5528-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000010d4b805ee281d70@google.com>
Subject: Re: [syzbot] possible deadlock in mnt_want_write_file
From:   syzbot <syzbot+1047e42179f502f2b0a2@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/reiserfs/namei.c:662:4: error: too many arguments provided to function-like macro invocation
fs/reiserfs/namei.c:661:6: error: use of undeclared identifier 'WARN_ON_ONCE'


Tested on:

commit:         eb708140 Linux 6.1-rc6
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
dashboard link: https://syzkaller.appspot.com/bug?extid=1047e42179f502f2b0a2
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1239542d880000

