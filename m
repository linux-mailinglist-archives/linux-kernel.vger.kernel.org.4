Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C79161DE72
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 22:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiKEVOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 17:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiKEVNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 17:13:35 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C0413CDE
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 14:13:35 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id g10so5267152qkl.6
        for <linux-kernel@vger.kernel.org>; Sat, 05 Nov 2022 14:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oAUSnUna3zS1fBFrtEIiCL0CSikhXV9H9gl4bxAoOlg=;
        b=ZuJIeLB+J2B+Wi1b1yHoLdNdJG615BQeh3CPU6LD93y3msmDVTjWdZW9SDWuwWG0Ca
         YhJ+P7666j6kD5Xt3qGOHQOk6MqT4dr6x8NEoIAvnzfrmsju0oEob+uN+nSjB06pGmVE
         9YOPL0fQ+TfTab0XaBhkdWiy9kYH1H39RsusA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oAUSnUna3zS1fBFrtEIiCL0CSikhXV9H9gl4bxAoOlg=;
        b=GPkEeG0JF1wNXIrUwo9OEBOFAI/kDMo6MOCCYr6V0ZjTTQybIY0csV1zwmFRadcb9w
         miuru6UlNMVz1stRTV3XSe7D82CyQ6beNfNJt9/Wz9H9TUsjGiedEhixxyNERTOI7Wf2
         4GE/8K2p9kV9arb1WLbtY3MOtvGB4sdf6BSog7TpYtG7K1a+ftJj4CwqBmlK3eBzX5Ea
         PA/J9c27uuNkXD9+Cdbv4cuBeDYfy18mtu9w0sOOf7074ND3I8Az0P1RFgHjG6mVnDHX
         Awbnz9moPrKh99neHk9yg1NOnT3wWj71/S9vcJ/EnuUrIsmhpBQ+eIpOl+BjYQ1Y1kXQ
         xoTg==
X-Gm-Message-State: ACrzQf1ZpPmLfyLs/ItWpRfHyjJwncIs4qnY3gUJ/QOTLunOGMpVcHPQ
        OVgW5gEyGNIuskBkwig8fccAnYAQ4MI6ZQ==
X-Google-Smtp-Source: AMsMyM6fmoUX7jSiTP6LBjbf0NVzpaoUbDcwiogshcvZPhktbPJYmpAmaMUmnHAmmZfzY8MiO/yLWQ==
X-Received: by 2002:a05:620a:1430:b0:6fa:b78:7e07 with SMTP id k16-20020a05620a143000b006fa0b787e07mr30234257qkj.120.1667682813887;
        Sat, 05 Nov 2022 14:13:33 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id k3-20020a05620a414300b006f9f714cb6asm2739997qko.50.2022.11.05.14.13.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Nov 2022 14:13:31 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 63so9556673ybq.4
        for <linux-kernel@vger.kernel.org>; Sat, 05 Nov 2022 14:13:31 -0700 (PDT)
X-Received: by 2002:a05:6902:1352:b0:6bb:3f4b:9666 with SMTP id
 g18-20020a056902135200b006bb3f4b9666mr38314227ybu.101.1667682810745; Sat, 05
 Nov 2022 14:13:30 -0700 (PDT)
MIME-Version: 1.0
References: <20221105060024.598488967@goodmis.org> <CAHk-=wi95dGkg7DiuOZ27gGW+mxJipn9ykB6LHB-HrbbLG6OMQ@mail.gmail.com>
 <20221105123642.596371c7@rorschach.local.home> <Y2bPlllkHo5DUmLY@zx2c4.com>
In-Reply-To: <Y2bPlllkHo5DUmLY@zx2c4.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 5 Nov 2022 14:13:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjkkomrdcrAxxFijs-Lih6vHze+A2TgM+v7-Z7ZkXT+WA@mail.gmail.com>
Message-ID: <CAHk-=wjkkomrdcrAxxFijs-Lih6vHze+A2TgM+v7-Z7ZkXT+WA@mail.gmail.com>
Subject: Re: [PATCH v4a 00/38] timers: Use timer_shutdown*() before freeing timers
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
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
        tipc-discussion@lists.sourceforge.net, alsa-devel@alsa-project.org
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

On Sat, Nov 5, 2022 at 2:03 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Something that might help here is changing the `...` into
> `... when exists` or into `... when != ptr` or similar.

I actually tried that.

You don't want "when exists", you'd want "when forall", but that seems
to be the default.

And trying "when != ptr->timer" actually does the right thing in that
it gets rid of the case where the timer is modified outside of the
del_timer() case, *but* it also causes odd other changes to the
output.

Look at what it generates for that

   drivers/media/usb/pvrusb2/pvrusb2-hdw.c

file, which finds a lot of triggers with the "when !=  ptr->timer",
but only does one without it.

So I gave up, just because I clearly don't understand the rules.

(Comparing output is also fun because the ordering of the patches is
random, so consecutive runs with the same rule will give different
patches. I assume that it's just because it's done in parallel, but it
doesn't help the "try to see what changes when you change the script"
;)

                 Linus
