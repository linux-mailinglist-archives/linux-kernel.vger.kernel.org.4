Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C3265510F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 14:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbiLWNo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 08:44:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbiLWNoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 08:44:25 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDCB379FF
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 05:44:24 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id j5-20020a5d9d05000000b006e2f0c28177so1898526ioj.17
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 05:44:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/+brZE1BuxQx4JJ7arfpIPSEPG2D5qK+YSbmXqrC2Fw=;
        b=to4U/uGMFMtv9dmuEbLz/7AEjWI3WYN6YOb+ZDmc35LHDBefqhbGLX2K8r2nZP5HCM
         4xCw2lvN4YYwdyEC49zccPtTf4KqmpWZhAqUszpRCfo9Lu/r592MWLx9stu2Brp42Abz
         6Tml1eVANxnjd55Tq9xY6Auke819IhNEJSuWwQdYcw/4t0jCxANJcyBofX10wgsO05P7
         G7pInskQAwN9stxKD93oRJ6i162LhQlBV34xHzh8z11E9U4LdridBtwkOEr9lOlTFea0
         X4290i23bXwfPovpnM145bZPAnr9tgwDfQFY/MraenVNnldUaq2n+ZqnbKW7mRwtmZ5U
         t/kg==
X-Gm-Message-State: AFqh2krm5LlA/b/hou00e6rv1zk7kPg6W61+5iZJ6SmO5V0t52shvES/
        pxtvm9lkGCcrT6lnQBgSx6s+PY61TyhKbvs3FTyeLD5jYHTJ
X-Google-Smtp-Source: AMrXdXsbjmejxcAu5y04i/9VO2XqcPgHRXri3ilUuNNAnRUPtRp3qE+GkuTf2WssNCexpgOFvScBGJ/OthNs97njrrhPElJIcyzz
MIME-Version: 1.0
X-Received: by 2002:a92:4a11:0:b0:304:c58f:2149 with SMTP id
 m17-20020a924a11000000b00304c58f2149mr769399ilf.154.1671803064236; Fri, 23
 Dec 2022 05:44:24 -0800 (PST)
Date:   Fri, 23 Dec 2022 05:44:24 -0800
In-Reply-To: <20221223114849.2150-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c7413e05f07efb02@google.com>
Subject: Re: [syzbot] WARNING: refcount bug in gadgetfs_kill_sb
From:   syzbot <syzbot+ac031e7435393ad05df6@syzkaller.appspotmail.com>
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

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P4880 } 2641 jiffies s: 2057 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         8395ae05 Merge tag 'scsi-misc' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=15632254480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=17aadd57f57472c2
dashboard link: https://syzkaller.appspot.com/bug?extid=ac031e7435393ad05df6
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=172f58ff880000

