Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA84606A53
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 23:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiJTVaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 17:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiJTVac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 17:30:32 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185A017D28D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 14:30:24 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id s2-20020a056e02216200b002f9de38e484so1038006ilv.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 14:30:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fOEVwTpTV+WiIgW9Y6aHqhsmoIOJQCR2rrVmT5U2Q8A=;
        b=IqOnNeViFBU+b1RUk2xm01/v9VPYs9Aoh62/23eTlwppR0JLjdLZX2WtLaVavHI2zd
         8GYmv5aUKS5LCsSIDBw6i1DbLYKIu0XVt8xJFwvue7s8mgB36i3sClMngMYVspO7m1dj
         qOjsZOhoC0GLxDZKo/Zh/JWs7zitwbzeMPywC3iWKbrD8nJsVJ+jwKYKrr4VDNEvShWp
         F9JM/0MojZtRPPH6pdZRl+FtwEWMbABV9+VGNK7jBPxPraa8bRrWD5oMdXRFjO4e9TGb
         8PReqAe2gngz8AGOOGdSCls7/+Ly75N8w4a90L1bJ3uH7uQcdsvQ/KPQqWPEpn3ThFHR
         l/ng==
X-Gm-Message-State: ACrzQf3D4jO1EUpDLWr7xupisZU3BsLVGPpkkeY60zEj8RtP53WolSnW
        Rn8qx3AiOz/TtVJO8V/vgv6aChCUf0GUVB7XoU/5dTAQH7+g
X-Google-Smtp-Source: AMsMyM5HcyktkIm3X4IHgUDC4wWVXV/VaYlSP4I3F9tGgvof4v+VVNFLPpLrxLCUE9yhqa9vgzRWo7hwRMtfdaWG/zvbi9iCkTCI
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:154f:b0:2f9:f2ed:b661 with SMTP id
 j15-20020a056e02154f00b002f9f2edb661mr10986924ilu.134.1666301423549; Thu, 20
 Oct 2022 14:30:23 -0700 (PDT)
Date:   Thu, 20 Oct 2022 14:30:23 -0700
In-Reply-To: <20221020105004.1341-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007084e105eb7e0869@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in kernfs_next_descendant_post
 (2)
From:   syzbot <syzbot+6bc35f3913193fe7f0d3@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
SYZFATAL: executor failed NUM times: executor NUM: exit status NUM

2022/10/20 21:28:38 SYZFATAL: executor failed 11 times: executor 0: exit status 67
SYZFAIL: wrong response packet
 (errno 16: Device or resource busy)
loop exited with status 67

SYZFAIL: wrong response packet
 (errno 16: Device or resource busy)
loop exited with status 67


Tested on:

commit:         55be6084 Merge tag 'timers-core-2022-10-05' of git://g..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1086ad3c880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df75278aabf0681a
dashboard link: https://syzkaller.appspot.com/bug?extid=6bc35f3913193fe7f0d3
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1540e4ba880000

