Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61226727A2C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 10:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235621AbjFHIks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 04:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235560AbjFHIki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 04:40:38 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031392D48
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 01:40:27 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-77751dc936eso34036639f.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 01:40:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686213627; x=1688805627;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8hO5g5Z8IGEDKhfsPOAPWFp1Jr9Db2MKwZM4Dh0i6LM=;
        b=eMbeghRGFs7AJuCatdcefNs4oPrqTsXvhxkdN8EiX8FmTdAwfT+RyKFHpZvouCCQSa
         F3fmY5SZraeUTeDyYw4Y/qfg3LRCavC4Iddokm8wKAQWGWycnYfHn30iSBK9gc5+Fom7
         P3cJxtydiBlMcUbtjI1G2fteyfrNtN2I8Qayw+KbM1bGQ4Zehsk2CRF0DyzRNXoxbwtv
         M05rlGRBJyvsXKGt0Hbzczr7LIZ5pSz4UH+LaNsKJYl9B/g4PETVAXHdfTB/08/zSyDd
         NXZ970fdvcIOMsukfD4diPBUu/iQJCZTXRnRcCjFxiDtH6YX4RSvUWZKcq7FDo9InUKV
         JbTA==
X-Gm-Message-State: AC+VfDxiu16RaGOJxuO+7LYeRs2qd53H9gxCigeOuRQdK6u9F0Flv6Pe
        6ERZER/1q/2UISliYeE9BJ5Ekk2etGKtfC+w2Tm9DGjIPgeW
X-Google-Smtp-Source: ACHHUZ4kp4sl766pJXBZ565vKcFAO833KInXZQnC29ymDuXEpNNKzTBCvT5YvafYoD6s/d7e1f06VhAid4wRYQ2cqFr/0l0c4FgT
MIME-Version: 1.0
X-Received: by 2002:a6b:6b19:0:b0:759:25eb:210d with SMTP id
 g25-20020a6b6b19000000b0075925eb210dmr3898229ioc.0.1686213627131; Thu, 08 Jun
 2023 01:40:27 -0700 (PDT)
Date:   Thu, 08 Jun 2023 01:40:27 -0700
In-Reply-To: <00000000000009ee1005fc425b4b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000042bb6e05fd9a3406@google.com>
Subject: Re: [syzbot] [btrfs?] WARNING in btrfs_split_ordered_extent
From:   syzbot <syzbot+ee90502d5c8fd1d0dd93@syzkaller.appspotmail.com>
To:     boris@bur.io, clm@fb.com, dsterba@suse.com, hch@infradead.org,
        hch@lst.de, johannes.thumshirn@wdc.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

syzbot has bisected this issue to:

commit b73a6fd1b1efd799c6e3d14a922887f4453fea17
Author: Boris Burkov <boris@bur.io>
Date:   Tue Mar 28 05:19:57 2023 +0000

    btrfs: split partial dio bios before submit

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13b24d59280000
start commit:   a27648c74210 afs: Fix setting of mtime when creating a fil..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10724d59280000
console output: https://syzkaller.appspot.com/x/log.txt?x=17b24d59280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7474de833c217bf4
dashboard link: https://syzkaller.appspot.com/bug?extid=ee90502d5c8fd1d0dd93
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=120b88fd280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17e6a23b280000

Reported-by: syzbot+ee90502d5c8fd1d0dd93@syzkaller.appspotmail.com
Fixes: b73a6fd1b1ef ("btrfs: split partial dio bios before submit")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
