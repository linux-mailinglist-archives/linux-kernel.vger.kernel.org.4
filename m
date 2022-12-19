Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A0C651119
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 18:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbiLSRRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 12:17:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbiLSRRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 12:17:18 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD962CC1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 09:17:17 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id j5-20020a5d9d05000000b006e2f0c28177so4303214ioj.17
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 09:17:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PYjS+ImIjrElaMqPFYQYWhlqH8+ajaaNfs4wjRxv44E=;
        b=JYVSlBTjYqNXouii5Vg/aOQADbnEdsZPiXaUXwGiu0h5bIWbA8bYWxsD3EzA2dS8j2
         IgrMA5JrDwhhvvVEZ3b2v26jsBZUmTiLKeRIivCM2sTI0Hay6HLbI+JLtMRl7hdW6O+O
         uKVG4/+yQLyNF+RY5faW2iwEDz20h2jyQ8LTv9h8QAoaQfScnlldZOTQKBk1BtGkG3gV
         SC9NGp+btMXg6PstHcIMW2lBceQqvbPio9sE6EBL0CI0/sg/jgTswKWb6BJn1zHRwUPw
         WzkB5WXQ8HbrPYBWUG46yUUQmczbkrLLM0fI6vfIfGaxTAgJPmFwOeM9UljXStYFsK6J
         iKoQ==
X-Gm-Message-State: ANoB5pl6x2vfDdadsHhJD9F+C3NdDxukJVS0/1mVOdhWW5WPav00WDyq
        VH12hsbzWWCLuQGT+snNx564sJ0rdw+WA4DhNYYg5vdz8An4
X-Google-Smtp-Source: AA0mqf6mS7AY+xDbJTMOlE5wjvG4azZl8BE4+sZCPTnQM2/sNy65Okf7frmd5yiE7N74XUWj5uKHHblSC/tc/Lv4ktwvigNy0WiT
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3e1a:b0:38a:9017:1246 with SMTP id
 co26-20020a0566383e1a00b0038a90171246mr3484306jab.119.1671470237050; Mon, 19
 Dec 2022 09:17:17 -0800 (PST)
Date:   Mon, 19 Dec 2022 09:17:17 -0800
In-Reply-To: <1535853.1671468284@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bb6b2305f0317d76@google.com>
Subject: Re: [syzbot] kernel BUG in rxrpc_put_peer
From:   syzbot <syzbot+c22650d2844392afdcfd@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dhowells@redhat.com, edumazet@google.com,
        kuba@kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, marc.dionne@auristor.com,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
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

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: rcu detected stall in corrupted

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P5792 } 2657 jiffies s: 2825 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         6529d700 rxrpc: Move client call connection to the I/O..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/
console output: https://syzkaller.appspot.com/x/log.txt?x=13f3b420480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b0e91ad4b5f69c47
dashboard link: https://syzkaller.appspot.com/bug?extid=c22650d2844392afdcfd
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
