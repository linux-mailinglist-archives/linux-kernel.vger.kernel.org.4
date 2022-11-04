Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEDCF619F58
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 18:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbiKDR4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 13:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbiKDR4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 13:56:22 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F8747333
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 10:56:21 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id g13-20020a056602072d00b006c60d59110fso3437119iox.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 10:56:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HFLDZrSmrKf3eaUSPUfU/z0D34JmXW5qNTObPr5a3dE=;
        b=V9ntpzARzivmUk/tBWGRoe08u67tqIJyPDgQfQh4ijXRHcUjtF2INfV4neIZFQTfkc
         D/VNwF+EY4B8zlN/SZBbdGQaink29jlTrVXOYq6B9/ADzqB+fY+wdn232hdAW5Up7RP+
         wzoImMfAjeDNwxr5OUjCIZ3JVu3VQpr/sx5Wh2ikI4T3nWOrN35Xqxp/6zkXDJ4451Pq
         onebDn0ebHwSb8PBbzuZH8jHXmjr3412RGS4ip30E6eEgxAOK9l4xvj1lbn7W0qUePoR
         7Vv2QlUn3/6Bex1M2D9n4+Ed3IraOj/2C3yGPc4tpQHJN9gAqXjjfkUdBlwS7hm+JHOI
         InAQ==
X-Gm-Message-State: ACrzQf3QtyrdYPuasG7SjLqW8d0m7vjzPTfK34czD77vp23OTZNdAKWF
        EXLCwCNznGbbKtoXofamR1gtCWFhfv2StDSdFt7ibNR2tXSl
X-Google-Smtp-Source: AMsMyM5jISVm+ThnehVRlGr4SGLsiESwHWORrPJaHVN2Gla1RS8HH7b06ZPnW17OhSwF1wbMM8K1f2L1F/XbPusoit6A69WxSHeM
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1210:b0:375:4aa6:ff85 with SMTP id
 n16-20020a056638121000b003754aa6ff85mr19651201jas.227.1667584580937; Fri, 04
 Nov 2022 10:56:20 -0700 (PDT)
Date:   Fri, 04 Nov 2022 10:56:20 -0700
In-Reply-To: <0000000000000bab2c05e95a81a3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000946f3005eca8cafe@google.com>
Subject: Re: [syzbot] BUG: corrupted list in hci_conn_add_sysfs
From:   syzbot <syzbot+b30ccad4684cce846cef@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com,
        gregkh@linuxfoundation.org, johan.hedberg@gmail.com,
        kuba@kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        luiz.von.dentz@intel.com, marcel@holtmann.org,
        netdev@vger.kernel.org, pabeni@redhat.com, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com, yin31149@gmail.com
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

syzbot suspects this issue was fixed by commit:

commit 448a496f760664d3e2e79466aa1787e6abc922b5
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Mon Sep 19 17:56:59 2022 +0000

    Bluetooth: hci_sysfs: Fix attempting to call device_add multiple times

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1052f8fe880000
start commit:   dc164f4fb00a Merge tag 'for-linus-6.0-rc7' of git://git.ke..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=122d7bd4fc8e0ecb
dashboard link: https://syzkaller.appspot.com/bug?extid=b30ccad4684cce846cef
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1110db8c880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13e58aef080000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: Bluetooth: hci_sysfs: Fix attempting to call device_add multiple times

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
