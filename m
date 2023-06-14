Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D4572F119
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 02:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbjFNAnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 20:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbjFNAnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 20:43:32 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8867E1996
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 17:43:31 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-77b0124d7beso414552139f.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 17:43:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686703411; x=1689295411;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2l3o9X4DUl6CHYQ2eJ/wgVXYrcJVZyyGP64Bx5hzSFo=;
        b=OnkPH1LvYb39NzbmLiJqt7mC9bl1iHikWO4TwN6ugM0tHaCubuZFZSdluIQ7k8aXcL
         D3XDAXKsNvvjAxyNuTBngGfBtJDaJQZLBgtP6iraS1RHwh7PAxpzOpu+3vO3CYqxM5zc
         4nIucuhs6/mCTOLNQR7owjUOfHfJGjs6yElGQSbKAaSUI41gPX0eAsQ1Bp21N+9hEaAi
         bwjE1mhC5PXf3ElHfxCmR/jHETEXB+ImzRGl4vYkV7vTSP2unIYRx4YbUBcBTO9KoeKl
         GvAAl5lVLQEspkVfPoBrC024pJY3FyWL+UyRKrE1pBYHjs6sbS7BITLaQ7VqiVAgFk26
         Nu1g==
X-Gm-Message-State: AC+VfDztIBCW17xSFc4humt+b93G+e9LbCIW2wxv7GVmuZ5PZ0ox0yfQ
        Ht6AE9yHHPns3P1F8OZwdX1EZfgnkfwguQe25VrI7P0AW3Ki
X-Google-Smtp-Source: ACHHUZ7pQAFqGo+YXYn4Pp7UOHTIW0tLIJtZrgi4ompHLJQyjZVznMQSZHBldmo6gwCfDTX3d3k+ot9FDhCnEBBrs5htpNrxlKk2
MIME-Version: 1.0
X-Received: by 2002:a5d:8a18:0:b0:774:8f36:bb8e with SMTP id
 w24-20020a5d8a18000000b007748f36bb8emr5930497iod.2.1686703410910; Tue, 13 Jun
 2023 17:43:30 -0700 (PDT)
Date:   Tue, 13 Jun 2023 17:43:30 -0700
In-Reply-To: <000000000000342a9105fe052726@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a61ffe05fe0c3d08@google.com>
Subject: Re: [syzbot] [net?] WARNING in unreserve_psock
From:   syzbot <syzbot+dd1339599f1840e4cc65@syzkaller.appspotmail.com>
To:     bpf@vger.kernel.org, davem@davemloft.net, dhowells@redhat.com,
        edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
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

syzbot has bisected this issue to:

commit c31a25e1db486f36a0ffe3c849b0a82cda3db7db
Author: David Howells <dhowells@redhat.com>
Date:   Fri Jun 9 10:02:21 2023 +0000

    kcm: Send multiple frags in one sendmsg()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13050c75280000
start commit:   c29e012eae29 selftests: forwarding: Fix layer 2 miss test ..
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10850c75280000
console output: https://syzkaller.appspot.com/x/log.txt?x=17050c75280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=526f919910d4a671
dashboard link: https://syzkaller.appspot.com/bug?extid=dd1339599f1840e4cc65
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=170f2663280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12f1c5e7280000

Reported-by: syzbot+dd1339599f1840e4cc65@syzkaller.appspotmail.com
Fixes: c31a25e1db48 ("kcm: Send multiple frags in one sendmsg()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
