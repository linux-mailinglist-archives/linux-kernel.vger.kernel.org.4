Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7492E70A5A8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 07:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjETFYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 01:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjETFY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 01:24:27 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9B61B5
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 22:24:26 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-76c48b53e16so34187739f.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 22:24:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684560266; x=1687152266;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SrdV0ygMdYPqAmG7LwAZV4OGjE5KtVQqdUSmJPUHjZU=;
        b=NSRoR8aLjLHdwtEZyBfYhVmGZMG6GUIlaMjkloZxY0FYwhJ4dggtr+7SPEveHSwT+T
         pwloLU/9e0WPZTt3XEgKaeARilel4JM7CciMlgxoAPsdr5ED9qWhCtx8O5PPQIx352K1
         VLXcq3XlbpWqSvVRN07n6wMDQYwmpWqa8AZwpj9u2T20+SbMDrU9RshrbfXnHqfxgzx8
         Y2z/FuoqpwRsvjPsry0/mhUd6E0e++hVKBf0+mztVXhZizqdcLduq1s5AE4T3+fb09+P
         b8R6N5mjGHENE5PeuQ0IjVFAvGZxmBnUZNr3jGlYKsunD5JJlkN/ZyjxryzI4hLxBEnF
         BTLA==
X-Gm-Message-State: AC+VfDwI5be49XvMkIEJMbW2Fb0Iifh2qFeTbEpX53HhdD8EyoBoFNeO
        T7exuFwreY9nohOvQRPGHgy62Bm01x2H14t9xLfDHDPO087U
X-Google-Smtp-Source: ACHHUZ6hTFX7a0pVUYivQtv8iU28xZiCDjaD/cgUE6pqb8VNbogQ2Lh7JMQe9On01smA0p41OO2OMcJ1fCrx97WO3Na4JQboaq1h
MIME-Version: 1.0
X-Received: by 2002:a02:a10b:0:b0:416:5d0f:f494 with SMTP id
 f11-20020a02a10b000000b004165d0ff494mr1852614jag.5.1684560265963; Fri, 19 May
 2023 22:24:25 -0700 (PDT)
Date:   Fri, 19 May 2023 22:24:25 -0700
In-Reply-To: <0000000000003a41f705a9c74dfa@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000041730905fc1940ff@google.com>
Subject: Re: [syzbot] [usb?] INFO: task hung in usb_register_dev
From:   syzbot <syzbot+e761775e8f4a28711f19@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, charu@tickmarks.net,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com
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

commit df05a9b05e466a46725564528b277d0c570d0104
Author: Alan Stern <stern@rowland.harvard.edu>
Date:   Mon Apr 10 19:38:22 2023 +0000

    USB: sisusbvga: Add endpoint checks

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1286f641280000
start commit:   7d2a07b76933 Linux 5.14
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=b04081cf516e2565
dashboard link: https://syzkaller.appspot.com/bug?extid=e761775e8f4a28711f19
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=133519b1300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=116ec82e300000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: USB: sisusbvga: Add endpoint checks

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
