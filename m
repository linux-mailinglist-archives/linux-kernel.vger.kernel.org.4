Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBC6659893
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 14:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234892AbiL3NM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 08:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiL3NMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 08:12:23 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEC51A052
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 05:12:22 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id b77-20020a6bb250000000b006e4ec8b2364so6613192iof.20
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 05:12:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aOyXb6XekkEj9NSf9pTRX0h4vJFQ+YhjmmSQ9RBSD/w=;
        b=e7ivGUtTv4B10J1dSoWuV7Ng4TSPSEJNzdMROOz1tvr0rNcmA8CEpiKV/WnAEfAwxE
         ixfEDnpLcBb2Y39/iXrO8FplrRim3drpetkYXlB0BuHDT18juMq7GIFG3YEOK6EcaygT
         VQcdLF+9BASBcGb4fuI+ksmJujnsr5uXEPbzlCgOvcp416NMvJ1q+cWz830Kp6zz32bQ
         gfEBQ1MOHYf2F3GNyPcknfh9Dbp9gXDytSj3GzmJtVyN32FWu7Fx/k9PcoC6ogMK65vG
         83zqVMBQNZlyLvebgx1c24RJzibUTKwiDlecvKDEC+7KvZd4ZS2KqCk7QWJlv1C/GWnE
         0Gxw==
X-Gm-Message-State: AFqh2kp673/leUasVUPsUwfasOFflLxdwRMjpYWTLHjUev33vqJCUH4I
        sfsdW0bpTXQ8Qya0UhEcpJSZbEMm7YGYpoR3LGsngolPXKGl
X-Google-Smtp-Source: AMrXdXsC9GTH11Mx+a+LFj8XQdxirbDNp6aSz7CDjkAsV0BTeq4cpIa5zCd11viPWp9l7vMsUqR+1lcY4tM6XM7xW4E0VYSvPGVF
MIME-Version: 1.0
X-Received: by 2002:a92:c98d:0:b0:30b:b810:8a57 with SMTP id
 y13-20020a92c98d000000b0030bb8108a57mr2803366iln.276.1672405941825; Fri, 30
 Dec 2022 05:12:21 -0800 (PST)
Date:   Fri, 30 Dec 2022 05:12:21 -0800
In-Reply-To: <20221230125241.3152-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001539e805f10b5a78@google.com>
Subject: Re: [syzbot] BUG: corrupted list in nfc_llcp_unregister_device
From:   syzbot <syzbot+81232c4a81a886e2b580@syzkaller.appspotmail.com>
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

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P5544 } 2636 jiffies s: 2861 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         2258c2dc Merge tag 'for-linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=13a33938480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=555d27e379d75ff1
dashboard link: https://syzkaller.appspot.com/bug?extid=81232c4a81a886e2b580
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1341acbc480000

