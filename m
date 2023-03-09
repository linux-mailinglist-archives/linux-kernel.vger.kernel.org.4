Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E106B237C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 12:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjCIL5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 06:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjCIL5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 06:57:19 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA57DD360
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 03:57:18 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id i8-20020a056e02054800b00318a7211804so772516ils.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 03:57:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678363037;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yX6TF+vn9/IHLiO2rdpruGDt6O5lqRy5gxKQUxEGJDo=;
        b=CjUgkecVbxDkNI4i2liF1AmRE3I5kVFSfxa5xzDVL17Q5DqVxnaBQ1Qq1R5N5XlsJI
         FoG2m7x6teQQ1+6Qj/RQ9rDRTmV1tgnhwcDx6h7XRz8+cuBUPnZbLGfKi3JquoT3o//k
         eX+EZtZbFp9K6jrf83BB3WLUAPbOKBk0rvMVFdMJ0qiZ9rgW/9M8Hpqs0CE1fKTTDASc
         T9merYMOd0VRUqTT0won3lja/t3cfS87ufyeeXOgkWHWC8nwUu7HlJzwaxi4y+JTIhv7
         o52TfUxvasXCBblPQI6iWpaJTCAsizO3ePKDh0gxmkoJTeVZ6/3EFBfMXQUrYlUWxyJo
         o9Ug==
X-Gm-Message-State: AO0yUKVUFcU5g0N1Sin+DKZWPk1bdhyNHNQ8H9rsdXj0aMWXyVweG5NU
        Rr9lMUPWi6ljAaRRUpdMTgLGmVjBakbiBMonPNAeM3zw6mZw
X-Google-Smtp-Source: AK7set+l8Q/wcIAHiiaNGzoKIqYWGV1eypA0ZwqCwtYTqttblmrfVY7wkNJf3lfXJvgGGVFWxEPLrQ5Yl2IIoz5/eOqsmab5UWT0
MIME-Version: 1.0
X-Received: by 2002:a05:6638:cd0:b0:3e5:4c9d:6e14 with SMTP id
 e16-20020a0566380cd000b003e54c9d6e14mr10876861jak.4.1678363037341; Thu, 09
 Mar 2023 03:57:17 -0800 (PST)
Date:   Thu, 09 Mar 2023 03:57:17 -0800
In-Reply-To: <0000000000004c06c405eb318db4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a5202905f6765872@google.com>
Subject: Re: [syzbot] [btrfs?] WARNING in btrfs_run_delayed_refs
From:   syzbot <syzbot+ebdb2403435c4136db2b@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

commit 8bb808c6ad91ec3d332f072ce8f8aa4b16e307e0
Author: David Sterba <dsterba@suse.com>
Date:   Thu Nov 3 13:39:01 2022 +0000

    btrfs: don't print stack trace when transaction is aborted due to ENOMEM

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1541ad14c80000
start commit:   98555239e4c3 Merge tag 'arc-6.1-fixes' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=a66c6c673fb555e8
dashboard link: https://syzkaller.appspot.com/bug?extid=ebdb2403435c4136db2b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11a4d8ea880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13172832880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: btrfs: don't print stack trace when transaction is aborted due to ENOMEM

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
