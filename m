Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6666BF763
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 03:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjCRC1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 22:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjCRC1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 22:27:22 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71AF7B4BD
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 19:27:20 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id 85-20020a6b1458000000b007545a9d6706so1558948iou.18
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 19:27:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679106440;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0u9iCqtoAmqFPlWvcnYREgJziHl4srI427ufeguhoqM=;
        b=IaTyXItcwkzR86lsol4Nf+j6tSHLeQr60jd+cLbyDevb4yjW/T0wJzPsykpKJ33rrd
         6pe+fYjHXmTkj6y5og0kPDJ2GQawOUUqQUBZxJBCskvQjwfrB0E9xs7cLErh+dvmyXnU
         YXQ/H+UL0u78XvN1pL9muy4He/q+LrDmpqgnlnXUnONOIWQVmz9mZzLmvnQHzAU/C1+G
         CWhpDpTa4Ggpov4L3qcxExHZHcSswBiXH/lhwKR9H+UU+Q3+ZzF+mZDiXxjdEGeFPXZ7
         NyOAeWo+P2IW4/gjKHFM7/D9oMwkZ4DqJq8dffNa2/Z8JvRFfWw0heUiRNpNB2OiG9H5
         IHUg==
X-Gm-Message-State: AO0yUKVu3LlZLOyu1u+nBrE/f4j66wCgpH60wkGOWauHh9MmN7A2MYpE
        YBoFE8x6tsmlBNUA0nqdsOv1FL8chVTuGgAhRaOVJVpfJrIM
X-Google-Smtp-Source: AK7set8wss4kUHb8bvkmj46rggkVv7EYWpiCNxgTNjAiaYvE3l2uDADG4+AdbZbUYfVh0de7isnTkVF1g0r5VUiiYVo8PDDYYWkv
MIME-Version: 1.0
X-Received: by 2002:a02:b181:0:b0:3b7:9d19:fec7 with SMTP id
 t1-20020a02b181000000b003b79d19fec7mr266557jah.0.1679106439975; Fri, 17 Mar
 2023 19:27:19 -0700 (PDT)
Date:   Fri, 17 Mar 2023 19:27:19 -0700
In-Reply-To: <000000000000aa58fb05ed5beed6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e51b9905f7236ef3@google.com>
Subject: Re: [syzbot] [jfs?] UBSAN: shift-out-of-bounds in dbMount
From:   syzbot <syzbot+0835e526215d5dcefaa9@syzkaller.appspotmail.com>
To:     dave.kleikamp@oracle.com, jfs-discussion@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        liushixin2@huawei.com, mudongliangabcd@gmail.com,
        paskripkin@gmail.com, r33s3n6@gmail.com, shaggy@kernel.org,
        syzkaller-bugs@googlegroups.com, wuhoipok@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit fad376fce0af58deebc5075b8539dc05bf639af3
Author: Liu Shixin via Jfs-discussion <jfs-discussion@lists.sourceforge.net>
Date:   Thu Nov 3 03:01:59 2022 +0000

    fs/jfs: fix shift exponent db_agl2size negative

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10f3046ec80000
start commit:   513c1a3d3f19 Merge tag 'trace-v6.2-rc6' of git://git.kerne..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=6bb1911ff9919df0
dashboard link: https://syzkaller.appspot.com/bug?extid=0835e526215d5dcefaa9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16d599df480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16bb69a7480000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs/jfs: fix shift exponent db_agl2size negative

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
