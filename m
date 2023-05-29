Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C367145CD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 09:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjE2H6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 03:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjE2H6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 03:58:40 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E73AC
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 00:58:39 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-76c4c85d605so496106839f.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 00:58:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685347119; x=1687939119;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6glaZqXLdR/sqr43KU6Tb+HaCnc43Xn0goRWcqtcRyc=;
        b=Col8lGzPQgY0YEWrYYwVqID5OY+lIbYMWGRJH/GAPlOk2IiTM++MiYK+yEDE/mlDBJ
         pHetBtahmmrIMrGXJGDIOUHUqwSnCQyTzW0lHar7BioX/07ereYqU9mvojMgxTk/iA5q
         9L5YuaUcd/zPl1TB+4AReZQHSc6enRBIVYvRVlpF/LcMIcQsk0nzroIgXVRjEt6ZhI8+
         hT3CwQIm/czuKcuflGNgFefh5cBThHWN+xV0Yuh6dG+ra8r+HHn7V+cItnawPHZrPNZb
         Ib2VVvIk7u9o3bzdROVa9PYYqEejlkkHE6kbNsT8MO7+gCaPFvt1ryNTgACjTfOlejsJ
         oVKA==
X-Gm-Message-State: AC+VfDzktNMdeASJogUxhD7vuhQV9ybE1pixRAdSJoINgRYelXzb3B4o
        v6W3rIXsu6gLZgH1K9J86Xn2w22KQUC8pnjaKEJnT9sq/K/6
X-Google-Smtp-Source: ACHHUZ4MuBaRsJopnZiBm+6ufXaHSIG5lXU+lUdykELwTengmCKG9Deupzc7T4MRgR+haJxS4xX5eCIVMMG6ktdL/EfIcXF0qFza
MIME-Version: 1.0
X-Received: by 2002:a6b:7a08:0:b0:766:6741:8856 with SMTP id
 h8-20020a6b7a08000000b0076667418856mr3693372iom.4.1685347119096; Mon, 29 May
 2023 00:58:39 -0700 (PDT)
Date:   Mon, 29 May 2023 00:58:39 -0700
In-Reply-To: <0000000000005225a605bd97fa64@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005b688105fcd074af@google.com>
Subject: Re: [syzbot] [io-uring?] WARNING in io_ring_exit_work
From:   syzbot <syzbot+00e15cda746c5bc70e24@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, deller@gmx.de,
        gregkh@linuxfoundation.org, hdanton@sina.com,
        io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit d808459b2e31bd5123a14258a7a529995db974c8
Author: Helge Deller <deller@gmx.de>
Date:   Thu Feb 16 08:09:38 2023 +0000

    io_uring: Adjust mapping wrt architecture aliasing requirements

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=145bb249280000
start commit:   7c6984405241 Merge tag 'iommu-fixes-v6.2-rc3' of git://git..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=2b6ecad960fc703e
dashboard link: https://syzkaller.appspot.com/bug?extid=00e15cda746c5bc70e24
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15d5e97e480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1407c8da480000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: io_uring: Adjust mapping wrt architecture aliasing requirements

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
