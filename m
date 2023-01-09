Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06081662F95
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 19:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjAISzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 13:55:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234413AbjAISzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 13:55:22 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219991A06D
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 10:55:22 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id o16-20020a056602225000b006e032e361ccso5440189ioo.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 10:55:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hZ2myS91auaAPOzUbacG8wfmkGsOxK+7+KK8Wi7uEtk=;
        b=OPj5cYjJbE4ZQ8LQ4Mwq2D74lBpLWD0K4zHWxWrtYut9BSGQ0xLOA47Up1hkO891oZ
         w9z+f5+ztxaZEOU14wW9LnqFf3y9cTMIKAyaIgFa3IDPsqZBjfxP0smVe6dGyk4fD7u+
         nJCeu58x8tqgbFp0txQKLaXSR2F84vv1PzIHl6JRcQuj6HYNCDBjUauMKtBwigwXRW8u
         Kez9xWCL7vBqoTIV8keVXBFw2mBo1YU/sUBjF3VqgkQCNCwE+2+eKH5+GBjHi+8b/UGn
         7fw+j/98mz7Dz1+zBeevEaOxOuEXDighy8OHtnElCa3FjMuh78PRlkcBoYmDILSlJ6pg
         yajg==
X-Gm-Message-State: AFqh2krYAy7SmiNlWwOxPMbZGIihsHIt3j8Cy160H2kiS6gG0urQiW+9
        h4EeJ18SPMnUMiMTDZy/orNYig80kdjLIzGQ7J8Phmyuv2ks
X-Google-Smtp-Source: AMrXdXtmXqKmSIDKVAPjJ4BWYHm/KidAV+MsbsgLKVCZKGN4pDAUj08f5RekwiqOZhBguvx5a47fGiraS5NViND0cXBxZpoQ5/D0
MIME-Version: 1.0
X-Received: by 2002:a92:d5cf:0:b0:30b:b741:205c with SMTP id
 d15-20020a92d5cf000000b0030bb741205cmr6207437ilq.113.1673290521494; Mon, 09
 Jan 2023 10:55:21 -0800 (PST)
Date:   Mon, 09 Jan 2023 10:55:21 -0800
In-Reply-To: <36d665d6-3cd7-ffa8-da4f-1ceb67052ce7@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000023cc9d05f1d94f29@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in io_wqe_worker (2)
From:   syzbot <syzbot+ad53b671c30ddaba634d@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P5550 } 2678 jiffies s: 2801 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         a4b98579 Merge branch 'io_uring-6.2' into syztest
git tree:       git://git.kernel.dk/linux.git syztest
console output: https://syzkaller.appspot.com/x/log.txt?x=1490bc16480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8b79b14037065d92
dashboard link: https://syzkaller.appspot.com/bug?extid=ad53b671c30ddaba634d
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
