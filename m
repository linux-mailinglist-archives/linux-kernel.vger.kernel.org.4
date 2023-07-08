Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB9674BEA9
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 19:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjGHRxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 13:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjGHRxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 13:53:34 -0400
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5629210EA
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 10:53:33 -0700 (PDT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-666e3dad70aso4956197b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jul 2023 10:53:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688838812; x=1691430812;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KgUpKTeGPzi/nNVifJ5WyvHuZtEbyrg/rprJfjMZE9E=;
        b=OxGDWymk9ymuGnArPXjrINDV8WXtJtA/eio42EDwTHmP63Kqd4sWTWKkcXzC5axsDZ
         Icoiz32pblcxbbBM8wqmAD1pDWlyW4wIzZB+2JczT7JRjOfAEVASVmrhrdPzDQ8S+H5w
         JxqzBhzpTMtwtnv97fOpJUpF+Fqui9VVT9y6KAK6h9vTPuxlB+Cw0TYSqlCewVJCBh/9
         nVEDJBf7wDpm0Ouf2PISDLcVvKqZ1MfZdqhPt6fY2YI7GB3cvDT65gyVBghPM1OQ8vKv
         HK/nLlEZeI97s9F1ivycyBSXOQkYf6M1Xc26AIT2lAnWc9LcoXuKN105fE+9L/8V6r3w
         JBLw==
X-Gm-Message-State: ABy/qLbjFPwG0qsb+VJU/uBTyiuTB3wsIpcK2xQ/YdNSMgNKnqtvWDIm
        CcWSHGrBTTz2Ai+ZuAJHRsW/Gi6M8+IedXO1rlR/X3jmgvMj
X-Google-Smtp-Source: APBJJlHbGeKU/oHF+i4JDiNs+OLRa+VkY0mxtGbwG4jhPYI5mf54+xRP/IBFTXmemnbvKYxRxTqAKT9fBMziZomVR1z8FcMjVMW4
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:2d95:b0:668:9181:8e20 with SMTP id
 fb21-20020a056a002d9500b0066891818e20mr11799357pfb.1.1688838812689; Sat, 08
 Jul 2023 10:53:32 -0700 (PDT)
Date:   Sat, 08 Jul 2023 10:53:32 -0700
In-Reply-To: <000000000000d97d9305ff9f6e87@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000836b2805fffd6d7e@google.com>
Subject: Re: [syzbot] [block?] KASAN: slab-out-of-bounds Read in bio_split_rw
From:   syzbot <syzbot+6f66f3e78821b0fff882@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, axboe@kernel.dk, dhowells@redhat.com,
        herbert@gondor.apana.org.au, kuba@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit b6d972f6898308fbe7e693bf8d44ebfdb1cd2dc4
Author: David Howells <dhowells@redhat.com>
Date:   Fri Jun 16 11:10:32 2023 +0000

    crypto: af_alg/hash: Fix recvmsg() after sendmsg(MSG_MORE)

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15763ae8a80000
start commit:   3674fbf0451d Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       net
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17763ae8a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=13763ae8a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c9bf1936936ca698
dashboard link: https://syzkaller.appspot.com/bug?extid=6f66f3e78821b0fff882
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16223cb8a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13f13920a80000

Reported-by: syzbot+6f66f3e78821b0fff882@syzkaller.appspotmail.com
Fixes: b6d972f68983 ("crypto: af_alg/hash: Fix recvmsg() after sendmsg(MSG_MORE)")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
