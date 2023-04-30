Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C5E6F27B7
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 07:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjD3FT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 01:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjD3FT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 01:19:26 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7094319BB
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 22:19:25 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-32b65428489so7715595ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 22:19:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682831964; x=1685423964;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jbgNg7bzEOiE+PpMY9EfhvJTml8HBUQsJEoVcCv5c8Q=;
        b=OcNSb5tdYfRYgT9MOMPvdUF9xAz1HracrsHO2elh80FrlIW+lU85Wo0biCUwWsFS7g
         y7zPsHC3g2/2WVA0829ptR4+1MYi1EGhw4fLgVAhvRCPltw5guZ03y1E+5do0mF78pyj
         Qh2N41nYgNk7P5MrJ7eL8So2gprqqBRxWZ+d+UzQt+vE5ZL3UFNYoVIqc7ECwu+TOYaC
         ZzFHCe6nnaHepetMrR2PPNQ3qazNCMkhkRwtd3g57vyiayDMzSSk/0LYnKI8dWLY5MNG
         dSeXfrl/yFygdQDvcSl666fpZHfWVU9GgEhT0r8d39KvBxeXD7RZmpAQ3gIob6umOEv3
         Cnkw==
X-Gm-Message-State: AC+VfDzgfpiRDlrFTclxT6Qvxe768aLv8MrRxSH3UecHjQ9aw+5a3WnY
        4bIIIxht/6RNypVlCCo55UvACZ+Pz1aBHZ1216AGT+JE4ime
X-Google-Smtp-Source: ACHHUZ7ExN+zShsIJc2XiFG2sXg9LR6zZCWJUqmWpaBVinskpdR+1L/m2w4P7/W7ipfQJwevuqU8oEbPVxYZNAFl3zT5ZpDJfNwZ
MIME-Version: 1.0
X-Received: by 2002:a92:d143:0:b0:330:a575:37e2 with SMTP id
 t3-20020a92d143000000b00330a57537e2mr852781ilg.4.1682831963878; Sat, 29 Apr
 2023 22:19:23 -0700 (PDT)
Date:   Sat, 29 Apr 2023 22:19:23 -0700
In-Reply-To: <00000000000083d76d05f909f716@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006c7b6b05fa86d9ee@google.com>
Subject: Re: [syzbot] [usb?] general protection fault in xpad_probe
From:   syzbot <syzbot+a3f758b8d8cb7e49afec@syzkaller.appspotmail.com>
To:     chaorace@gmail.com, dan.carpenter@linaro.org,
        dmitry.torokhov@gmail.com, dzm91@hust.edu.cn, error27@gmail.com,
        gregkh@linuxfoundation.org, hdanton@sina.com,
        hust-os-kernel-patches@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        matthias.benkmann@gmail.com, mkorpershoek@baylibre.com,
        mudongliangabcd@gmail.com, nate@yocom.org,
        pgriffais@valvesoftware.com, radon86dev@gmail.com,
        rafael@kernel.org, rojtberg@gmail.com, s.demassari@gmail.com,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com,
        vi@endrift.com
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

commit db7220c48d8d71476f881a7ae1285e1df4105409
Author: Vicki Pfau <vi@endrift.com>
Date:   Fri Mar 24 17:42:27 2023 +0000

    Input: xpad - fix support for some third-party controllers

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1028a1f8280000
start commit:   92e815cf07ed Add linux-next specific files for 20230428
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1228a1f8280000
console output: https://syzkaller.appspot.com/x/log.txt?x=1428a1f8280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8c8ae4d47d23592
dashboard link: https://syzkaller.appspot.com/bug?extid=a3f758b8d8cb7e49afec
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a5408c280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10d3b0e4280000

Reported-by: syzbot+a3f758b8d8cb7e49afec@syzkaller.appspotmail.com
Fixes: db7220c48d8d ("Input: xpad - fix support for some third-party controllers")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
