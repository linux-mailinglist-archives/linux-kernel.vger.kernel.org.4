Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77EFB62EB63
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 02:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240749AbiKRB41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 20:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235099AbiKRB4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 20:56:23 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938B3742C7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 17:56:20 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id k21-20020a5e8915000000b006de391b332fso1883402ioj.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 17:56:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5pvNabL4h/jw3vWWl8UrKWU7ECeSF3aiv4l/7+Kwbb8=;
        b=BVex/LXLR2J/x9PgEpIRLItoUUvaoMRRlTqvj2GPmLN1FCvDAp0ifIXRjwVH+DD4C0
         HIi2JLG9Mjh+3hDpvQuxoRU5KN6fLCSwjaey+7xF2EuhvxfPtYxsAB9OsU+L6d2pj3ET
         I2HDYNOjal/D4uUqDLWnesRasOxJyU0KPXsJCBVz6fp4yMYmgIL0PgDrf4lH5GAEAZkJ
         pE498QFY8+LzSVFQL6m0J6vLHXJWP6p6VvA77vLuWu85DjtJjHjOr66FTAri+DKZ0VYe
         X0676HT1WPs4maQJ0FF7s6CtOpMwXtcUeCVUJyJkDjwseuRZS4gJujuuYaTzWioOgTes
         wGHA==
X-Gm-Message-State: ANoB5pkW307ZfOoE/duQKoa7Tf4K5QCFt8Z74zEXlMef0w/xAirc9M6X
        yoy4ptDyLvXJ0GCFLm/ytkZ1et1c/uDkFmwUMT49jUewlKoa
X-Google-Smtp-Source: AA0mqf45hbckZ2aQOX7ek+n7IrRm+TLARFS5k7Cpgc/J3eoK5JGyghNN8Zz2xGtvDMZWQ5eFrzyaERPuVNbmpR8na1Tlmn82UWtD
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3e15:b0:374:53a:a5bf with SMTP id
 co21-20020a0566383e1500b00374053aa5bfmr2275103jab.77.1668736579920; Thu, 17
 Nov 2022 17:56:19 -0800 (PST)
Date:   Thu, 17 Nov 2022 17:56:19 -0800
In-Reply-To: <0000000000004e78ec05eda79749@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000011ec5105edb50386@google.com>
Subject: Re: [syzbot] BUG: sleeping function called from invalid context in static_key_slow_inc
From:   syzbot <syzbot+703d9e154b3b58277261@syzkaller.appspotmail.com>
To:     Jason@zx2c4.com, davem@davemloft.net, edumazet@google.com,
        frederic@kernel.org, gnault@redhat.com, jacob.e.keller@intel.com,
        jakub@cloudflare.com, jiri@nvidia.com, johannes@sipsolutions.net,
        juri.lelli@redhat.com, kirill.shutemov@linux.intel.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, netdev@vger.kernel.org,
        nicolas.dichtel@6wind.com, pabeni@redhat.com, paul@paul-moore.com,
        peterz@infradead.org, razor@blackwall.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, steven.price@arm.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        tparkin@katalix.com
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

commit b68777d54fac21fc833ec26ea1a2a84f975ab035
Author: Jakub Sitnicki <jakub@cloudflare.com>
Date:   Mon Nov 14 19:16:19 2022 +0000

    l2tp: Serialize access to sk_user_data with sk_callback_lock

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1600bb49880000
start commit:   064bc7312bd0 netdevsim: Fix memory leak of nsim_dev->fa_co..
git tree:       net
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1500bb49880000
console output: https://syzkaller.appspot.com/x/log.txt?x=1100bb49880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a33ac7bbc22a8c35
dashboard link: https://syzkaller.appspot.com/bug?extid=703d9e154b3b58277261
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13cd2f79880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=109e1695880000

Reported-by: syzbot+703d9e154b3b58277261@syzkaller.appspotmail.com
Fixes: b68777d54fac ("l2tp: Serialize access to sk_user_data with sk_callback_lock")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
