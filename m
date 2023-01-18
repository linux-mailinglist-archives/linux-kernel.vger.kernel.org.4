Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C0C671E45
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 14:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjARNnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 08:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjARNmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 08:42:25 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BEC6794D
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 05:11:23 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id y11-20020a056e02178b00b0030c048d64a7so24996524ilu.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 05:11:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gb9ye5L384z0sJ9lHOgovYJTtmnNnzRSfStsIP9mHp4=;
        b=2md0pQZiGXxq6h9S+0UQLbvoZhmkbSaRmAGwky7cYtacunuzJg12wFhB7mhANs1K8K
         aZQWBPbBxqkApfyB5L25PVhdcM6FYHfD9rv9TTjGq54sQAbXvlJTBGnOvPWJEccQa7G9
         uQ7+lp5nsBu0HPtuGI3NiGFBR+k+d9PzUOB6DGTzQKiSy/xAXCay1poAe3oS8jRJUYjW
         X9ROoCQTUim3gdwQ4Fwk4S2s6MuKK8X9EX0++h/ZyXV/ZwfY9MRPoOyG+luMA4Uryhav
         3KwYROd/hEaJJSosd9O11ryCiW2ZBAqZT8nB2Y6h0cr0qXYRhGmuhLYFiJ6aSGZYy3vH
         oruQ==
X-Gm-Message-State: AFqh2kqvsBCFLCGlrrn5V/fZxE/EuyOJaT1HkW5SrNx7dFfTHur2lBt4
        vTvKknm9cvGsJ1JFhbjGY6rjs2os3dcjhYoRoiFS8l+gEIqf
X-Google-Smtp-Source: AMrXdXuzeXKW4OevNrY1rNZ/gojCg/BXjtv/ERGhG5fJgGg1aitQlfltHaryjNoMWEuTb+ALgiV6PMylnyGQSAMulP7Z+slvC5Qd
MIME-Version: 1.0
X-Received: by 2002:a02:c643:0:b0:38a:c2a7:369d with SMTP id
 k3-20020a02c643000000b0038ac2a7369dmr633850jan.245.1674047483287; Wed, 18 Jan
 2023 05:11:23 -0800 (PST)
Date:   Wed, 18 Jan 2023 05:11:23 -0800
In-Reply-To: <000000000000fbb2d505f27398cb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000941ee205f2898d65@google.com>
Subject: Re: [syzbot] possible deadlock in release_sock
From:   syzbot <syzbot+bbd35b345c7cab0d9a08@syzkaller.appspotmail.com>
To:     cong.wang@bytedance.com, davem@davemloft.net, edumazet@google.com,
        eric.dumazet@gmail.com, gnault@redhat.com, jakub@cloudflare.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
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

syzbot has bisected this issue to:

commit 0b2c59720e65885a394a017d0cf9cab118914682
Author: Cong Wang <cong.wang@bytedance.com>
Date:   Sat Jan 14 03:01:37 2023 +0000

    l2tp: close all race conditions in l2tp_tunnel_register()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15331c61480000
start commit:   87b93b678e95 octeontx2-pf: Avoid use of GFP_KERNEL in atom..
git tree:       net
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17331c61480000
console output: https://syzkaller.appspot.com/x/log.txt?x=13331c61480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2b6ecad960fc703e
dashboard link: https://syzkaller.appspot.com/bug?extid=bbd35b345c7cab0d9a08
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1716b3a1480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14e57a91480000

Reported-by: syzbot+bbd35b345c7cab0d9a08@syzkaller.appspotmail.com
Fixes: 0b2c59720e65 ("l2tp: close all race conditions in l2tp_tunnel_register()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
