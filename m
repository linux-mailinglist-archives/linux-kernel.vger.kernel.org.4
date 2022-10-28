Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A437611BA0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 22:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiJ1UhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 16:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiJ1UhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 16:37:23 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6BC234780
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 13:37:22 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id bx19-20020a056602419300b006bcbf3b91fdso5031454iob.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 13:37:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P1r/rIShP/bP72XX3Sqvx4nW6j6PsMJ8W5Bq6b3IPQI=;
        b=zzR6NfhM8PydCBXwyQKjQXIfOTNoRvT2uYpn61CboOKbgDEVFlSV0+o8FjGMAzirnZ
         D+UuSs8KCbo4FLGH9KA+Rr3PUgzpQRlExVmWlPmOfvIPf5xaeHpYVNHLd2bqMWa7RVXJ
         VjnL1SJgJ1MSC4mEc5+39V2R4ZPHn6uyZMt245LXtuzyV78ZIOBADMLlUKnVH0A/S6tj
         XoGWQy9qP9InwxSV4cWpiJ1gdYETwu1D0g5ah6nFddHGIadDS147mo3ZlJWZLCGuwNlq
         NTqkJNUfowdVAperY2pY28YHPtdlEQ93oJnEmg8//LJisyLjgtpORq3pcZDwCRWN0g5r
         xlLw==
X-Gm-Message-State: ACrzQf2AzhyWkd+8rKtKs87rgFDb71a/wyIIdM3Stn+VNZ+kKy1ZeiKC
        wAvt8pffuFW+6pFrruqcqqZmXloPLy/C4ypGXWl6MmWS7QyQ
X-Google-Smtp-Source: AMsMyM5Qwu6878P32GV17hEJui0vZdzBmKoIpnlWSTuMo+AzqgpFsG90tuODB8kD+YNDODGlFiMV6pvljl0zxTXvR5RjR1uM8lNO
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4c7:b0:300:8d6d:286a with SMTP id
 f7-20020a056e0204c700b003008d6d286amr606125ils.164.1666989442269; Fri, 28 Oct
 2022 13:37:22 -0700 (PDT)
Date:   Fri, 28 Oct 2022 13:37:22 -0700
In-Reply-To: <20221028094920.3200-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008d0beb05ec1e39e7@google.com>
Subject: Re: [syzbot] WARNING in alloc_charge_hpage
From:   syzbot <syzbot+0044b22d177870ee974f@syzkaller.appspotmail.com>
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

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P4090 } 2674 jiffies s: 2637 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         a7038524 Merge tag 'perf_urgent_for_v6.1_rc2' of git:/..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1543d716880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea03ca45176080bc
dashboard link: https://syzkaller.appspot.com/bug?extid=0044b22d177870ee974f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1401516e880000

