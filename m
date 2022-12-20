Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F21B6526D6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 20:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233669AbiLTTPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 14:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiLTTPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 14:15:22 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA2AE006
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 11:15:21 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id s2-20020a056e02216200b0030bc3be69e5so1927935ilv.20
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 11:15:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kGV90AA/X0nTzuzvmG+X764dVgauxsWjPVfmjrcPhsc=;
        b=vAZOzjnMNsYxUKaxmNCcT839Zjn6Yr7IWopKvwO3gjIoXc8YpZuiQ9QsWHgaGY86pp
         pcXTj7p5Mo3JRQr+1RDTKfnS0cmTo/aUVrL+aoiRskgBnt8/Y1GIs9DUOWaz3zSJZb7S
         xCmZ0u0+o4eXJauGnPf2o7rHKQr4L1V9caByHj6ETWD5fJDNyc6g8UUbLP1ZVm7y/DS1
         go6iUoJTAl0qq0jthcWq91ipeXbcsxrVIAAfHbIbr/cQxZYd0Xb84HyI7aTBLhwHy/HM
         cD/293Sl5RzcdeY+cyUQ7x5qE6/OAbK6mttNf1vPuFZmnPCan5JJYDb7kdxDHbhyMrZ/
         CvxQ==
X-Gm-Message-State: ANoB5pnU7EJv+EVNekp776NbLIpRoubBgsq1BiASlmOsURVqU4BKTL/0
        KROu58pph3WLYGGT6uaMIjwgPuDzLVJazRIJEXZisCqVPNGL
X-Google-Smtp-Source: AA0mqf4Tb0gUAc0ob7+P6Tt6bdase52ycimGI6/V+tr7EItBqWQGrIlYa9jXJ7h5kvSuG1HY6y7Yt8uzuwxyZw0hda/OpU62eYjI
MIME-Version: 1.0
X-Received: by 2002:a02:954d:0:b0:375:569e:fb3f with SMTP id
 y71-20020a02954d000000b00375569efb3fmr49008772jah.200.1671563720670; Tue, 20
 Dec 2022 11:15:20 -0800 (PST)
Date:   Tue, 20 Dec 2022 11:15:20 -0800
In-Reply-To: <1924955.1671552163@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ca452805f04741f9@google.com>
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

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P5782 } 2677 jiffies s: 2821 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         2bc80899 rxrpc: Fix a couple of potential use-after-fr..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/
console output: https://syzkaller.appspot.com/x/log.txt?x=12729378480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b0e91ad4b5f69c47
dashboard link: https://syzkaller.appspot.com/bug?extid=c22650d2844392afdcfd
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
