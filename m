Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B302573487D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 23:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjFRVGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 17:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjFRVGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 17:06:33 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE69819C
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 14:06:32 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-77e23d23eccso138192139f.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 14:06:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687122392; x=1689714392;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AGPCsyVCjaMdb5zctZvXHEEDcHJ/Z5rO2/FLB/BsIJI=;
        b=UvvvYoCe8SCT2Oy8Jp8+pGZ0ww7Dj+4NhIUZe0Em4SB+X/shHQ590HJSqJjiaMhMx/
         rXhDEF2jhWwqgwJD0Volx2VnPSd7Z9s6YswW1qcAv4VH0lRC9+bxitBfcySxW/9LAnFx
         kiUwXFUchV4kumTPwWf6EsG3x3TbmYokEaH+4fXvQ6YshQV39v2LkMC+/s8EtlODbs+Y
         j+I3PcTtBJMnWHzDiv0XydTwMCxqd9hJTUl8KOl0RsVz0C+ywqqdFWS58MItBlMaF2w/
         QSp6Yc/1XFWjq9QyE106N8CYl+TVf52iiumT9gPHQZaedohCTiVI4QOIcHC2LI+46Yfs
         n10g==
X-Gm-Message-State: AC+VfDx574n0UTciw5pXa9DHh5ruPPSR0JiGRXHqW57sCuvsn661wYc+
        ujF8xPe6XlzmKUHAwXqcIEhXp67TYH3KgNh2/zMMTDC6aTdN
X-Google-Smtp-Source: ACHHUZ7xSr4w6krwjQPockQqELqyYqRd9bokpQafWNXKhNDv0G3b/mUPdU0P2k3tDRz7L758vvswpWfxwmv/yRNxFreCGHk5VisC
MIME-Version: 1.0
X-Received: by 2002:a6b:7c0b:0:b0:763:7dfb:27b2 with SMTP id
 m11-20020a6b7c0b000000b007637dfb27b2mr2282322iok.0.1687122392334; Sun, 18 Jun
 2023 14:06:32 -0700 (PDT)
Date:   Sun, 18 Jun 2023 14:06:32 -0700
In-Reply-To: <0000000000007ca70405fe4f149a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e34c0505fe6dca7a@google.com>
Subject: Re: [syzbot] [block?] WARNING in blkdev_put (3)
From:   syzbot <syzbot+04625c80899f4555de39@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, brauner@kernel.org, hare@suse.de, hch@lst.de,
        hdanton@sina.com, linux-block@vger.kernel.org,
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

commit 2736e8eeb0ccdc71d1f4256c9c9a28f58cc43307
Author: Christoph Hellwig <hch@lst.de>
Date:   Thu Jun 8 11:02:43 2023 +0000

    block: use the holder as indication for exclusive opens

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1713d65b280000
start commit:   f7efed9f38f8 Add linux-next specific files for 20230616
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1493d65b280000
console output: https://syzkaller.appspot.com/x/log.txt?x=1093d65b280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=60b1a32485a77c16
dashboard link: https://syzkaller.appspot.com/bug?extid=04625c80899f4555de39
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1600684b280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16b484f3280000

Reported-by: syzbot+04625c80899f4555de39@syzkaller.appspotmail.com
Fixes: 2736e8eeb0cc ("block: use the holder as indication for exclusive opens")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
