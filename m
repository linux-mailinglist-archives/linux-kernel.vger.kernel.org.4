Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55DB655426
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 21:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbiLWUOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 15:14:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiLWUOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 15:14:18 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B581098
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 12:14:17 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id l13-20020a056e021c0d00b003034e24b866so3147924ilh.22
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 12:14:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C3HCsdMbMuVerprxWeEdkncMgxqNV5nEqkTIItMUrHY=;
        b=eufMiVCCzOeoFx3ZC98ZuCMQXk8SojLwzzsiZfIvWsWZSBehXpkrkxba6RRr3Q4KAj
         acEv8nK143s2ghGKwJTBUroTI5dlO6THS2JrWm/8wrUgZZ4w3THBkL5r2xVzgYyIywtJ
         EtfI+2Y+hjG0w/ZhjiH8w61QENw+0mI0VqYAfyLc5ncL1qu0L0gEFOw9PuQ1Wv1U85gB
         0ImWjgMBIoMOvWrFQmo99zc/C00CazUymX4sS3dQV7HlPzGeCysft3+DwGNUSrpmt3jN
         pYLRxWi9OkBTwn1A56DGb77+RDlSIPofNzl/CWaQsyfZbEqMpic4GUVCh1RacJkZgMRP
         AxIg==
X-Gm-Message-State: AFqh2kr4206Szjoj9DeuSeaPGPdCPTUklVxjtja5OhUvUa/Mt2fvFWK9
        sKKXfmuyhPVs9v3/fGEnPYf8xcQbWQcN3L8298//VLXi5QU9
X-Google-Smtp-Source: AMrXdXu55244jWoT4K5/eYguO9xvuPpTd8E4Qo4VcSXeFVkcvhnWeDlER5is+O2m5h/pYan6fNl7r1LW6vEt28kFnCac/2LIeWBA
MIME-Version: 1.0
X-Received: by 2002:a02:5b0a:0:b0:38a:70d0:5264 with SMTP id
 g10-20020a025b0a000000b0038a70d05264mr943012jab.11.1671826456968; Fri, 23 Dec
 2022 12:14:16 -0800 (PST)
Date:   Fri, 23 Dec 2022 12:14:16 -0800
In-Reply-To: <20221223112733.2065-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000018098505f0846eaa@google.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in do_page_mkwrite
From:   syzbot <syzbot+ff866d16791d4984b3c7@syzkaller.appspotmail.com>
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

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P5544 } 2667 jiffies s: 2841 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         a27405b2 Merge tag 'sound-6.2-rc1-2' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=111d689c480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e2d7bfa2d6d5a76
dashboard link: https://syzkaller.appspot.com/bug?extid=ff866d16791d4984b3c7
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11c63cac480000

