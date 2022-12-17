Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD4764F709
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 03:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiLQCcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 21:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiLQCcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 21:32:14 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FE7680B1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 18:32:13 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id h26so394229qtu.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 18:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=32+z01bS/60qA2mmoByJGqJAOHtZb/bEvDiYOeG8ufE=;
        b=DTaBFry/QZoeuOH8bgOfjwLNEpYNqZzab+fCnqwy3J3+8q3/x84mM3bHSdja/1gN4I
         uaaXOIhD6RKnw9HSGLSwuVQ/veQVCcZtqIZCRyFURXAgPJy3BGnn7PAtcYRYeeLZn9Gt
         87gspRP1SiWekpT2XiWME2QkbC+z5x/IkkbAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=32+z01bS/60qA2mmoByJGqJAOHtZb/bEvDiYOeG8ufE=;
        b=62neuLA5yPCRt9/9/B639dHdPvuTY14TtMEuIAf9+vBoYWMpvM22l83AYzSt8admMQ
         uVD8CgLlAF7sFzg4qdYP0MTHaewRwyLiMgJy7+BDuKhLofwpb+zHzJnSxYeJozjDA9u2
         cfWw5rjEhgAlk4MHZlOKeNB+F79sBjKBWkT6Jb9zpzyvF+OdQqcQ0/bVVDIJP1jD0wUE
         OmNxVzbvPtfbamTEC4mwyZxSzuPFtLaLgmL7Mqe/AlzssqY6Hr++Z3RH3QGzvVFTOWBQ
         GiYo5GeqJtjjinNMOXEQg13pyAggopgypAjHwxN5eDGCO0XaFWGN2I3/9k3rK0zzGkMe
         3OIQ==
X-Gm-Message-State: AFqh2kqPod1ekimMHgJd6KufKK7W0iBOEjuWp+uCP0geDWNOO5xz0CjN
        kpE8LEuj3pjJUMjVXktJr3KXWQQrmofk1Pz8
X-Google-Smtp-Source: AMrXdXuiw+t7TLz/p7DG2NKg02GV+5nRYbh7ApkX+YKWJegue6xu76hA/f6+e8Rm8rhyRN8R7ivt/A==
X-Received: by 2002:ac8:4e14:0:b0:3a8:1f82:5b6c with SMTP id c20-20020ac84e14000000b003a81f825b6cmr2594825qtw.28.1671244332401;
        Fri, 16 Dec 2022 18:32:12 -0800 (PST)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com. [209.85.222.171])
        by smtp.gmail.com with ESMTPSA id e9-20020ac86709000000b003a69c77eb1asm2348705qtp.34.2022.12.16.18.32.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 18:32:11 -0800 (PST)
Received: by mail-qk1-f171.google.com with SMTP id pe2so1698512qkn.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 18:32:11 -0800 (PST)
X-Received: by 2002:a05:620a:678:b0:6ff:cbda:a128 with SMTP id
 a24-20020a05620a067800b006ffcbdaa128mr524218qkh.697.1671244330735; Fri, 16
 Dec 2022 18:32:10 -0800 (PST)
MIME-Version: 1.0
References: <CAO4mrfcX8J73DWunmdYjf_SK5TyLfp9W9rmESTj57PCkG2qkBw@mail.gmail.com>
 <5eff70b8-04fc-ee87-973a-2099a65f6e29@opensource.wdc.com> <Y5s7F/4WKe8BtftB@ZenIV>
 <80dc24c5-2c4c-b8da-5017-31aae65a4dfa@opensource.wdc.com> <Y5vo00v2F4zVKeug@ZenIV>
 <CAHk-=wgOFV=QmwWQW0QxDNkeDt4t5dOty7AvGyWRyj-O=8db9A@mail.gmail.com>
 <Y50BqT3nSF7+JEzt@ZenIV> <Y50FIckzrV9sWlid@boqun-archlinux>
In-Reply-To: <Y50FIckzrV9sWlid@boqun-archlinux>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 16 Dec 2022 20:31:54 -0600
X-Gmail-Original-Message-ID: <CAHk-=wj7FpAXZ0hnPKh-5CG-ZW8BmOhd4tEW+J7ryW26fkcDNA@mail.gmail.com>
Message-ID: <CAHk-=wj7FpAXZ0hnPKh-5CG-ZW8BmOhd4tEW+J7ryW26fkcDNA@mail.gmail.com>
Subject: Re: possible deadlock in __ata_sff_interrupt
To:     Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Wei Chen <harperchen1110@gmail.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot <syzkaller@googlegroups.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, let's bring in Waiman for the rwlock side.

On Fri, Dec 16, 2022 at 5:54 PM Boqun Feng <boqun.feng@gmail.com> wrote:
>
> Right, for a reader not in_interrupt(), it may be blocked by a random
> waiting writer because of the fairness, even the lock is currently held
> by a reader:
>
>         CPU 1                   CPU 2           CPU 3
>         read_lock(&tasklist_lock); // get the lock
>
>                                                 write_lock_irq(&tasklist_lock); // wait for the lock
>
>                                 read_lock(&tasklist_lock); // cannot get the lock because of the fairness

But this should be ok - because CPU1 can make progress and eventually
release the lock.

So the tasklist_lock use is fine on its own - the reason interrupts
are special is because an interrupt on CPU 1 taking the lock for
reading would deadlock otherwise. As long as it happens on another
CPU, the original CPU should then be able to make progress.

But the problem here seems to be thst *another* lock is also involved
(in this case apparently "host->lock", and now if CPU1 and CPU2 get
these two locks in a different order, you can get an ABBA deadlock.

And apparently our lockdep machinery doesn't catch that issue, so it
doesn't get flagged.

I'm not sure what the lockdep rules for rwlocks are, but maybe lockdep
treats rwlocks as being _always_ unfair, not knowing about that "it's
only unfair when it's in interrupt context".

Maybe we need to always make rwlock unfair? Possibly only for tasklist_lock?

Oh, how I hate tasklist_lock. It's pretty much our one remaining "one
big lock". It's been a pain for a long long time.

            Linus
