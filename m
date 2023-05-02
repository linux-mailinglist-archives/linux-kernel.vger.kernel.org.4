Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBF46F4CE9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 00:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjEBWfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 18:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEBWfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 18:35:23 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC4710E7
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 15:35:22 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-32ac22bff76so68224915ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 15:35:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683066921; x=1685658921;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rmKBAcFG5wzZh9YJqIV73oMdMlGqGRhnPePCBL78SbM=;
        b=U2vZ0wCqCKNUJaGygdQlSuMbiX21PUoRcguX3pHn/0Q4CwXx0s6xeKv33Bjcc9rVBD
         qEb2i7YrfWkvNOZzXjdZznQB0860nacGDqESx/DrMoCTm9/o1PM+gupQLAaiy+xGmD/n
         Fm1eCLiORPhAvgDOlKwF+d4gaMqQhSwJ8b3JZrvfpyXMdw+DSMcQ+YKtlnFTwM0pEwzR
         WV0W8wBlNWDtOH/Jmww9CwGVKLAHbKs000B+oGb6BYNj4eb6yMRKBLVJQ5BW/Bkp1OLL
         PEHip4nBqQzPF/6000jGJeJrGpybziwRfe7kUY2r+DjIXnVqIDCmsMlDwxszaPdmHAtH
         8yTg==
X-Gm-Message-State: AC+VfDzbouHH2yq8BQ9zHRMPC+GBcleE65VBY2o24kPvT49Y/5Y1z6Ol
        Exet3gA4Ai2uQduQNEwcclrfjEYmkrsKNhMGCgphDCS2OhF4
X-Google-Smtp-Source: ACHHUZ64rS+SFsFFgEx0VPKZ24UEYLN7UTgw2oHdQkSfNUwqUxsXzM/eOgWNc8/LcJYjrbD9dH/mNJXsIZv6g/NKHNXEJwwA958R
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:107:b0:328:fb47:ede4 with SMTP id
 t7-20020a056e02010700b00328fb47ede4mr10295522ilm.3.1683066921512; Tue, 02 May
 2023 15:35:21 -0700 (PDT)
Date:   Tue, 02 May 2023 15:35:21 -0700
In-Reply-To: <000000000000716a3705f9adb8ee@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fd74ec05fabd8d49@google.com>
Subject: Re: [syzbot] [usb?] WARNING in usbtmc_ioctl/usb_submit_urb (2)
From:   syzbot <syzbot+ce77725b89b7bd52425c@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, johan@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 5cc59c418fde9d02859996707b9d5dfd2941c50b
Author: Alan Stern <stern@rowland.harvard.edu>
Date:   Sat May 22 02:16:23 2021 +0000

    USB: core: WARN if pipe direction != setup packet direction

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=140bee54280000
start commit:   58390c8ce1bd Merge tag 'iommu-updates-v6.4' of git://git.k..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=160bee54280000
console output: https://syzkaller.appspot.com/x/log.txt?x=120bee54280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d56ffc213bf6bf4a
dashboard link: https://syzkaller.appspot.com/bug?extid=ce77725b89b7bd52425c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15027ef7c80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16d7550c280000

Reported-by: syzbot+ce77725b89b7bd52425c@syzkaller.appspotmail.com
Fixes: 5cc59c418fde ("USB: core: WARN if pipe direction != setup packet direction")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
