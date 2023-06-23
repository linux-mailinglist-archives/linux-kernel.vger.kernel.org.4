Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250C173B8D1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 15:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjFWNc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 09:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjFWNcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 09:32:24 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2342130
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 06:32:23 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-76c6c1b16d2so41413039f.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 06:32:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687527142; x=1690119142;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mPlj0ePe9xQ/WGGxyQBMmpisE5qo9ZSTCQrilqsvigQ=;
        b=GkeAI6YCBJLyyqTexprsUH2OovXNPBlIPrh4SjJcaMuX35ZQxD7SmvQEUzHJESyaPb
         SPPTCoD2basTLZB63OdNOXKFTC04wHR7H5tvhYCnayYRrNXA1Z6saBn0C+3VpWxMhBri
         GF/k0uWqSuGmxOA/o8n8hzg1gya+bp8hS5oehJu15c0zExvl+ekw1IavVUzXfca0QAdV
         KK4gagN7JtAptzsFHvD+b8Du1JYO8VwL9MDKuvFNq4IM1qDpAz8AV1GmpVNpEKA6KNlR
         X+L0kv7LaYW9zVw0J3dtOcaV84K6G91icja4F2937NjI056Bt/4H5y8CZTHWfUaGe6LW
         77ng==
X-Gm-Message-State: AC+VfDxv2bxYhx/WJC9yEe5rCz0U8VhRd9pYXhfBRrRybd5xQncjJwwr
        rhMilTV9hZlRtmxruczBAu/BJxRthcA7q/H91M3xHrGnqQo4
X-Google-Smtp-Source: ACHHUZ7es2/0OYCgP9Xe9+U9nOMkBNUXSJs2+g2Sx3i1cyfAId1btZVYLtMzAKFe6WLIK1k38RkxmhHr4PLlb5Wssps8Nws/9xja
MIME-Version: 1.0
X-Received: by 2002:a02:848f:0:b0:423:219d:81ce with SMTP id
 f15-20020a02848f000000b00423219d81cemr7555030jai.2.1687527142625; Fri, 23 Jun
 2023 06:32:22 -0700 (PDT)
Date:   Fri, 23 Jun 2023 06:32:22 -0700
In-Reply-To: <000000000000a56e9105d0cec021@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e298cd05fecc07d4@google.com>
Subject: Re: [syzbot] [usb?] WARNING in usbnet_start_xmit/usb_submit_urb
From:   syzbot <syzbot+63ee658b9a100ffadbe2@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, davem@davemloft.net, dvyukov@google.com,
        edumazet@google.com, gregkh@linuxfoundation.org,
        kbuild-all@lists.01.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        lkp@intel.com, netdev@vger.kernel.org, nogikh@google.com,
        oneukum@suse.com, pabeni@redhat.com, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com, troels@connectedcars.dk
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

syzbot has bisected this issue to:

commit 45bf39f8df7f05efb83b302c65ae3b9bc92b7065
Author: Alan Stern <stern@rowland.harvard.edu>
Date:   Tue Jan 31 20:49:04 2023 +0000

    USB: core: Don't hold device lock while reading the "descriptors" sysfs file

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=124b5877280000
start commit:   692b7dc87ca6 Merge tag 'hyperv-fixes-signed-20230619' of g..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=114b5877280000
console output: https://syzkaller.appspot.com/x/log.txt?x=164b5877280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2cbd298d0aff1140
dashboard link: https://syzkaller.appspot.com/bug?extid=63ee658b9a100ffadbe2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1760094b280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1359cdf3280000

Reported-by: syzbot+63ee658b9a100ffadbe2@syzkaller.appspotmail.com
Fixes: 45bf39f8df7f ("USB: core: Don't hold device lock while reading the "descriptors" sysfs file")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
