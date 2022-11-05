Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEE161DD32
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 19:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiKES24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 14:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiKES2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 14:28:53 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBDFE09A
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 11:28:52 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id j6so5523424qvn.12
        for <linux-kernel@vger.kernel.org>; Sat, 05 Nov 2022 11:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+1YQb6nXk/q0EHljp4F8v1bXvbOovOAnj80btawKRAY=;
        b=DONWs6/FiwPtVJ4h9P9G1D+xI2OZ4sOZ++B4h9lOUr90grPUMADKKtOkyMNK85AsEf
         yHs4XotTZQfbZFXiKO1vIPQf4cjf9p2EEuLbIK2DwoG1VitJXDxI/Fg0k/P20CNhLtpT
         5yTAOviUwyDAlllMzqQFpJUoXjW0aoAYitY3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+1YQb6nXk/q0EHljp4F8v1bXvbOovOAnj80btawKRAY=;
        b=dXvvseMXHQW87lcf6+VYAPFUiTIyPpwy6UclUiKBfoFAgOHt+VOB4+0l2FS7z34Vgo
         +N9M5d41NyYC+C5ga7tsPjY+l/xm1/iW6TKAowOBD3PzM0dnBTIp6M/pK/Ho4ggVq/zd
         1pW7/YjSIW2gAoh++R1aykrqGfz8B6YgRV638u6cyhtiFBb/IB9liw7f0WnMRxJu7Y8F
         bVTiZfxq3t1VKQZpVccqjz6GpOqz3tTGV/LMUVG43DpdDhauouyFs7WlyjrJTXY8mLOH
         YhR8ZBACp+JLOrKOHJ+tMTPAzppBZ0DjFpESk/GnD37FRKBuyOyMdNExtDyjFAAmv3nL
         R1HQ==
X-Gm-Message-State: ACrzQf0zaVaPfhCppq+EYcMmrhgNV207paonjWu+6opmHgxMkRckXO83
        QZIMSDGIbL+fpP12KrONsX/7GEMSHxENpg==
X-Google-Smtp-Source: AMsMyM4Q0hleCZ62ZkddUmgfd8m6ovQRZaDynAjWaAs57fQiaWnkbCCvhgtxvFASIMtHku7m4zAWoA==
X-Received: by 2002:ad4:5e85:0:b0:4bb:fa4d:bb65 with SMTP id jl5-20020ad45e85000000b004bbfa4dbb65mr29301552qvb.9.1667672931576;
        Sat, 05 Nov 2022 11:28:51 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id m13-20020a05620a290d00b006fa43e139b5sm2427597qkp.59.2022.11.05.11.28.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Nov 2022 11:28:49 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id g127so9293401ybg.8
        for <linux-kernel@vger.kernel.org>; Sat, 05 Nov 2022 11:28:49 -0700 (PDT)
X-Received: by 2002:a25:bb02:0:b0:6ca:9345:b2ee with SMTP id
 z2-20020a25bb02000000b006ca9345b2eemr26793220ybg.362.1667672929161; Sat, 05
 Nov 2022 11:28:49 -0700 (PDT)
MIME-Version: 1.0
References: <20221105060024.598488967@goodmis.org> <CAHk-=wi95dGkg7DiuOZ27gGW+mxJipn9ykB6LHB-HrbbLG6OMQ@mail.gmail.com>
 <20221105123642.596371c7@rorschach.local.home> <20221105140356.6a3da628@rorschach.local.home>
In-Reply-To: <20221105140356.6a3da628@rorschach.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 5 Nov 2022 11:28:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjnASLkTdPd+wxto2RBQH+S9MUm4FrNPWvU87opFG5SKQ@mail.gmail.com>
Message-ID: <CAHk-=wjnASLkTdPd+wxto2RBQH+S9MUm4FrNPWvU87opFG5SKQ@mail.gmail.com>
Subject: Re: [PATCH v4a 00/38] timers: Use timer_shutdown*() before freeing timers
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-edac@vger.kernel.org,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-pm@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-bluetooth@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, intel-gfx@lists.freedesktop.org,
        linux-input@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-leds@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-ext4@vger.kernel.org, linux-nilfs@vger.kernel.org,
        bridge@lists.linux-foundation.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, lvs-devel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net, alsa-devel@alsa-project.org,
        Julia Lawall <Julia.Lawall@inria.fr>
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

On Sat, Nov 5, 2022 at 11:04 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Here's the changes I made after running the script

Please. No.

What part of "I don't want extra crud" was I unclear on?

I'm not interested in converting everything. That's clearly a 6.,2
issue, possibly even longer considering how complicated the networking
side has been.

I'm not AT ALL interested in "oh, I then added my own small cleanups
on top to random files because I happened to notice them".

Repeat after me: "If the script didn't catch them, they weren't
trivially obvious".

And it does seem that right now the script itself is a bit too
generous, which is why it didn't notice that sometimes there wasn't a
kfree after all because of a goto around it. So clearly that "..."
doesn't really work, I think it accepts "_any_ path leads to the
second situation" rather than "_all_ paths lead to the second
situation".

But yeah, my coccinelle-foo is very weak too, and maybe there's no
pattern for "no flow control".

I would also like the coccinelle script to notice the "timer is used
afterwards", so that it does *not* modify that case that does

                del_timer(&dch->timer);
                dch->timer.function = NULL;

since now the timer is modified in between the del_timer() and the kfree.

Again, that timer modification is then made pointless by changing the
del_timer() to a "timer_shutdown()", but at that point it is no longer
a "so obvious non-semantic change that it should be scripted". At that
point it's a manual thing.

So I think the "..." in your script should be "no flow control, and no
access to the timer", but do not know how to do that in coccinelle.

Julia?

And this thread has way too many participants, I suspect some email
systems will just mark it as spam as a result. Which is partly *why* I
would like to get rid of noisy changes that really don't matter - but
I would like it to be truly mindlessly obvious that there are *zero*
questions about it, and absolutely no manual intervention because the
patch is so strict that it's just unquestionably correct.

              Linus
