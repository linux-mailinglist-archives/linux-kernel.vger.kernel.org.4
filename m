Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0988D666BAD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 08:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237663AbjALHia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 02:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbjALHiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 02:38:25 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0414086B
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 23:38:21 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id e15-20020a056602158f00b006e01d8fa493so10698249iow.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 23:38:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LHegr42fMh2mC7YaeyPrb+IWDfGu4OqPhC+SkVDZ69E=;
        b=K9EblRaAr2oX41+bSS512J5W/J9NdSuL/Z2AVBBAnqTBt+SmHDw2Accc5F639rgqmp
         XnHiPZwDm2W5E3tHXft8r/3OlQlsnk4o3EpuuuCdJb7aqodd8kQCyvpy4h0JY08y7q0l
         davTzWbAXP3Z+w156VMTEOIzTqR5sLiBiWgu0NffVMVbZxbnNc47r4iXUCqv0OE/eHzr
         jR+d4+Uyz3clekSAYurtvXWqwsrW1+kTiZRErQrrN3OOQhsiDa1osufpbvfpcCffI8bV
         W3VaomQuC93rZwGqAxuL+g1IlBG/Zfq5IRox7Ya169eEBxHU/fa9sRmXnK8F9KShYsdn
         a9Lg==
X-Gm-Message-State: AFqh2kruodUMY6zR7IfifZ6LqvP2I4EzEJagzh4lpQB+mr9SFLIJ/XuR
        FfVbs0o2SPU26FQ61EgkcdyXYCLZWs3YRAm3I634bqnO/flP
X-Google-Smtp-Source: AMrXdXveXMYcV2hvEnIdnnjvSKHkmHNLeVfbBk51co0qLqOZqTPTYB7PV4M+UzpcQZdCPNu/EYeeWtHh8WMFgVi794CvZmA3km8C
MIME-Version: 1.0
X-Received: by 2002:a5e:aa15:0:b0:6e3:5daf:72cb with SMTP id
 s21-20020a5eaa15000000b006e35daf72cbmr6986983ioe.194.1673509101218; Wed, 11
 Jan 2023 23:38:21 -0800 (PST)
Date:   Wed, 11 Jan 2023 23:38:21 -0800
In-Reply-To: <20230112033143.520-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000081b39405f20c338f@google.com>
Subject: Re: [syzbot] [ext4?] INFO: task hung in ext4_evict_ea_inode
From:   syzbot <syzbot+38e6635a03c83c76297a@syzkaller.appspotmail.com>
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

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P5530 } 2672 jiffies s: 2801 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         a689b938 Merge tag 'block-2023-01-06' of git://git.ker..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1687d102480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=33ad6720950f996d
dashboard link: https://syzkaller.appspot.com/bug?extid=38e6635a03c83c76297a
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1157295a480000

