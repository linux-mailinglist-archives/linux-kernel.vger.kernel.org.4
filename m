Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E80F600288
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 19:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiJPRwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 13:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiJPRwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 13:52:50 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192C12C66E
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 10:52:50 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id e53-20020a9d01b8000000b006619152f3cdso4640392ote.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 10:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QztUo4N/kTk5bDBhUjBzfNp1RuCgwau01vLbd3JmZqg=;
        b=NNPZIxOGwq7wDPFMGpcVXO7NTLgI9ICQPKuf2caldzrebIRVDNJ2ml38mL0vXNkBNY
         gMxRxqI+/kwvRl/seXDI+pVjBXVnMrAdNrvpSroNLhLwnMTVj7k1fGgGE4LQF/9YT6FR
         BFpp95mR9EXyYU2xUfDb+p3E+g08Te95dtggA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QztUo4N/kTk5bDBhUjBzfNp1RuCgwau01vLbd3JmZqg=;
        b=uI19phcHxFlXsWCqjD8JcK+XSw33id3+NvlaKrIihnZEnK5CK/BsBG5a+UwObuCYiQ
         kEnA3F4SfgPQL36HPUgucBybo5rZ3BCJWZqBpQeyCrW2A5eUul5AN58CDVaH/BxfwbZA
         KlvJM1wCuJufOVsy54GQGnw9ALDXXT79WEECAtMMQJNEI9WYdGmhRlujHlLJbFq+S9c6
         PVGv2eJhcq4iKYanZ+ndM9oBNUCS6KU8+9b3s+omClvWWRAphq3ZH0rBcfSBEvxwRTcL
         opPHbVcxXjzTerxv905w8N5TFGznMJiW7MXtValRLH6vjSbs58PABZ3Z4yj4Xs04J+Vz
         atYw==
X-Gm-Message-State: ACrzQf3O+DmWzJtPxU/aQxrVyDyHKmqmblyRI4n9FRzIm3Kjc9ZaNGTW
        c7bOmI9KbTf8uACy36Bv7PRZi2RNmPqdNQ==
X-Google-Smtp-Source: AMsMyM4NBoQGyxlngmHGPeQeSobUy3XNOskcVbFRuJbU9FldeiSIrfEuJagl4gHxfNUAc+5eo59OFg==
X-Received: by 2002:a9d:4e7:0:b0:65b:e537:5a75 with SMTP id 94-20020a9d04e7000000b0065be5375a75mr3439293otm.138.1665942768899;
        Sun, 16 Oct 2022 10:52:48 -0700 (PDT)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com. [209.85.167.182])
        by smtp.gmail.com with ESMTPSA id r64-20020acac143000000b00350a8b0637asm3524268oif.47.2022.10.16.10.52.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Oct 2022 10:52:48 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id g10so10041216oif.10
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 10:52:48 -0700 (PDT)
X-Received: by 2002:a05:6870:c0c9:b0:127:c4df:5b50 with SMTP id
 e9-20020a056870c0c900b00127c4df5b50mr3901741oad.126.1665942757701; Sun, 16
 Oct 2022 10:52:37 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000007647ec05eb05249c@google.com> <Y0nTd9HSnnt/KDap@zn.tnic>
 <2eaf1386-8ab0-bd65-acee-e29f1c5a6623@I-love.SAKURA.ne.jp>
 <Y0qfLyhSoTodAdxu@zn.tnic> <Y0sbwpRcipI564yp@yury-laptop> <23488f06-c4b4-8bd8-b0bc-85914ba4d1c6@I-love.SAKURA.ne.jp>
 <Y0tafD7qI2x5xzTc@yury-laptop>
In-Reply-To: <Y0tafD7qI2x5xzTc@yury-laptop>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 16 Oct 2022 10:52:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wihz-GXx66MmEyaADgS1fQE_LDcB9wrHAmkvXkd8nx9tA@mail.gmail.com>
Message-ID: <CAHk-=wihz-GXx66MmEyaADgS1fQE_LDcB9wrHAmkvXkd8nx9tA@mail.gmail.com>
Subject: Re: [syzbot] WARNING in c_start
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Borislav Petkov <bp@alien8.de>,
        syzbot <syzbot+d0fd2bf0dd6da72496dd@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com,
        Andrew Jones <ajones@ventanamicro.com>, netdev@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Menglong Dong <imagedong@tencent.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Petr Machata <petrm@nvidia.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        caraitto@google.com, willemb@google.com, jonolson@google.com,
        amritha.nambiar@intel.com, linux-kernel@vger.kernel.org
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

On Sat, Oct 15, 2022 at 6:12 PM Yury Norov <yury.norov@gmail.com> wrote:
>
> On Sun, Oct 16, 2022 at 09:24:57AM +0900, Tetsuo Handa wrote:
> >
> > Again, please do revert "cpumask: fix checking valid cpu range" immediately.
>
> The revert is already in Jakub's batch for -rc2, AFAIK.

Hmm.

I've looked at this, and at the discussion, and the various reports,
and my gut feel is that the problem is that the whole
"cpumask_check()" is completely bogus for all the "starting at bit X"
cases.

And I think it was wrong even before, and yes, I think the "+1"
simplification just made things worse.

I think that where it makes sense is in contexts where we actually
*use* the bit value as a bit, so cpumask_clear_cpu() doing

        clear_bit(cpumask_check(cpu), cpumask_bits(dstp));

makes 100% sense and is unequivocally something that merits a warning.
An out-of-range cpu number is a serious bug in that context.

But all the cases where the function fundamentally already limits
things to the number of CPU's (with comments like "Returns >=
nr_cpu_ids if no further cpus unset.") should simply not have the
cpumask_check() at all.

All it results in just moving the onus of testing things into the
callers, or just makes for odd complications ("-1 is valid, because it
acts as the previous cpu for the beginning because we add one to get
the next CPU").

Anyway, since rc1 is fairly imminent, I will just revert it for now -
I don't want to have a pending revert wait until -rc2.

But I actually suspect that the thing we should really do is to just
remove the check entirely for these functions that are already defined
in terms of "if no more bits, return nr_cpu_ids". They already
basically return an error case, having them *warn* about the error
they are going to return is just obnoxious.

                     Linus
