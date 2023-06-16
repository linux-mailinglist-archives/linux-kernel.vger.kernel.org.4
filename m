Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2A3733462
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 17:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345894AbjFPPKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 11:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345896AbjFPPJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 11:09:45 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7B03AB9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 08:09:30 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-77ad4f28a23so63728339f.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 08:09:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686928169; x=1689520169;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Imb23EaY07Gm7MJa4Np4kGVuIs1+xNQBFZQNfFls+gM=;
        b=IJWvJNEJ9DsWOo+wdL6yFH3mPwe4lV5ZBzuL3dgbbp7HYCFb3TfZpBewkolbOafOvo
         N0+EKtxqQxY+kiGrqcyQ+X9XSd0j65rvHHdHFwBh9EewJMnDQ9MFpsz+R86Ki9OQIopU
         mDXvuK2Xmm8yFddKTqXrLQ0PRqV/xKlu5/3TIpLklYsFRJBKq9ACQmm3Obl4n/Hic2TO
         rySA7FFDySH8LUH6rXy5VpXCF7FlXhXFAdD21nv2FWZH8moHxEsFcs8cvUYgXOjm+2sv
         BuDOj4HgZWZJZjKMC2jhsYf21ZXBp5qt2T9e47kHQk+lHcHEsS2KWqmKNQGmSYPOYIpQ
         Fezw==
X-Gm-Message-State: AC+VfDzmSs8ruwGgowOjrBSBicFg14vyhMca+/Sc3Ixa1izVm8D7khMa
        9+dgo0yTLX+yGiGwmDQEIpEupNOPKTya42oglt5Gz/eBbFHA
X-Google-Smtp-Source: ACHHUZ74+dXyvXDTGc+FFJWwCq4aB7E4QHdfr+P5b8tR/ce1Zt3HbjyX4nIZUMIKXW6jGatIamaZTBC88weu2rXjtpNJxD+nybqE
MIME-Version: 1.0
X-Received: by 2002:a02:a119:0:b0:423:13e1:8092 with SMTP id
 f25-20020a02a119000000b0042313e18092mr696867jag.5.1686928169697; Fri, 16 Jun
 2023 08:09:29 -0700 (PDT)
Date:   Fri, 16 Jun 2023 08:09:29 -0700
In-Reply-To: <00000000000098289005dc17b71b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000051087405fe4092cc@google.com>
Subject: Re: [syzbot] [bluetooth?] possible deadlock in sco_conn_del
From:   syzbot <syzbot+b825d87fe2d043e3e652@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, fgheet255t@gmail.com,
        hdanton@sina.com, johan.hedberg@gmail.com, josephsih@chromium.org,
        kuba@kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, lrh2000@pku.edu.cn,
        luiz.dentz@gmail.com, luiz.von.dentz@intel.com,
        marcel@holtmann.org, netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com, yinghsu@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit a2ac591cb4d83e1f2d4b4adb3c14b2c79764650a
Author: Ruihan Li <lrh2000@pku.edu.cn>
Date:   Wed May 3 13:39:36 2023 +0000

    Bluetooth: Fix UAF in hci_conn_hash_flush again

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13755717280000
start commit:   e4cf7c25bae5 Merge tag 'kbuild-fixes-v6.2' of git://git.ke..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=555d27e379d75ff1
dashboard link: https://syzkaller.appspot.com/bug?extid=b825d87fe2d043e3e652
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10052058480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1190687c480000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: Bluetooth: Fix UAF in hci_conn_hash_flush again

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
