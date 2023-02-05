Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C97068AF47
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 11:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjBEKKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 05:10:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjBEKKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 05:10:21 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDBB1BAD1
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 02:10:20 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id j7-20020a056e02014700b00310d217f518so6139943ilr.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 02:10:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M4+ikb5mvFAOATRtrZy/TmgzrLqQGI0z2J6tXsCw82c=;
        b=s91PfyRPTJ5J93NbbCjn7NjqcHSzbneO+tN8LBmBuSwRRwHlE07pPnnSP11igFUVCw
         NxNykDhQewr0zsGIDK+Kaz1lQHVW7ttn5PI0544lidY5gVMASUbrMtV5lTfPHaOXGfzf
         gnI+ZSJG3dJ8YQ8lHRiuAUJTf92P+9FDyh+B1dzKOBp/WlE02bbFR1cIn3PVsiOeONW8
         6QqYxJMTWJIrxSW6WMrljv1yjDJsskrVX3pQobHX9RpQUWPr+NaKUzIM62YjopytG3OT
         pE+b2YSp4MqFPSiNCtHZduo3NCwg1hkF1vMwAHxQXfvAQsGyzeQVLRYW/N/YS0AeNn1l
         zqVQ==
X-Gm-Message-State: AO0yUKWYE2iZ79kr52hQd12PvA0Sq2LtauQt9R7iVbMvcZpQnUppaybX
        ZsUv3QxeOGBUYOp7mnLymyLc5MHa5G5XIlhW22Ym/Pr49+iZ
X-Google-Smtp-Source: AK7set/qeu8kgXnVaRw+s+mNEMfx1nlVWdrlZfgVUrxzhv+imDXoIO5CAGN2nZlfPyhAnr0CKvH9VGTJNPoBcTXtzxpEbiMAK961
MIME-Version: 1.0
X-Received: by 2002:a92:7414:0:b0:313:bfa3:84f5 with SMTP id
 p20-20020a927414000000b00313bfa384f5mr187359ilc.122.1675591819686; Sun, 05
 Feb 2023 02:10:19 -0800 (PST)
Date:   Sun, 05 Feb 2023 02:10:19 -0800
In-Reply-To: <20230205093941.1451-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000033799605f3f11ffb@google.com>
Subject: Re: [syzbot] WARNING in kernfs_get (4)
From:   syzbot <syzbot+9be7b6c4b696be5d83ef@syzkaller.appspotmail.com>
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

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: rcu detected stall in corrupted

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P5555 } 2647 jiffies s: 2837 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         837c07cf Merge tag 'powerpc-6.2-4' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=113f785d480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=723d250bd16cf869
dashboard link: https://syzkaller.appspot.com/bug?extid=9be7b6c4b696be5d83ef
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1369cb27480000

