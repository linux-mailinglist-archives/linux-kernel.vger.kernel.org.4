Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027BD660586
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 18:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235416AbjAFRTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 12:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235556AbjAFRSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 12:18:30 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6569AC0E
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 09:18:29 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id m5-20020a6b7f45000000b006fc1dded1b9so1100362ioq.18
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 09:18:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KNubMI1GatQvLGtaWUgQht+S/ChcWAcDTlFlP/zM3lw=;
        b=go+xWYSLLj/Qu+5+fAhgPJO44BTeeb2UYcVJB7dDm9J2BGOdr4OczZ9ZoZnjqEgPyU
         NK9q96pAdxLlwNjPQ2Nd3y0fZUo03HIura4IqFEmaKoTJ26XhbSguActStvE78+aUK5W
         e3a6IlUSIgoOeMdtzKNRq7qLd+UGAG2qlLCJSAV0FNfzWyrX/+aPZX5oJB9TAel2CPWb
         cg0qVTm9Y0WI4JeqAFlIjhnhfDwtUVY1TONO4JVvM4PBx9fDWmsLK/E+n3v690/N+H0a
         mGODrffi0jSZUW0fgR8foI/2c+JicHOyuR1dT1jqmqePSlL1OAUE8zswgko1g73++3EP
         YlTw==
X-Gm-Message-State: AFqh2koz+p3G4SSzyTHRbfbFatH6f0mLPViw61uQwlaf8Hv13w2Z7ew5
        GaD+nGhCB4GXrhvBQbWPbpfrsVsHEoUn5Q0XeFu2YhGSEnoe
X-Google-Smtp-Source: AMrXdXsC4+9DIJj/3HSQrpzNWCyl6PVy0sO43QtssChaZWPBo2v+DiTAj5KrRFuPHZIJNFMRYRhQQO79CuInadAneRX5Eo4M6ZNg
MIME-Version: 1.0
X-Received: by 2002:a92:c984:0:b0:304:a7a2:6878 with SMTP id
 y4-20020a92c984000000b00304a7a26878mr5636073iln.206.1673025508785; Fri, 06
 Jan 2023 09:18:28 -0800 (PST)
Date:   Fri, 06 Jan 2023 09:18:28 -0800
In-Reply-To: <783988.1673005658@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000026c40c05f19b9b69@google.com>
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

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P5540 } 2684 jiffies s: 2885 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         9e80802b rxrpc: TEST: Remove almost all use of RCU
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/
console output: https://syzkaller.appspot.com/x/log.txt?x=1587a762480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=affadc28955d87c3
dashboard link: https://syzkaller.appspot.com/bug?extid=c22650d2844392afdcfd
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
