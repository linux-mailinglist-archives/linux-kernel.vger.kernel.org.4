Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B40661027F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 22:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236017AbiJ0UQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 16:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236842AbiJ0UPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 16:15:55 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EF25B700
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 13:15:53 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id z30so1944496qkz.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 13:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PkxtUHaGFDycP6D2luIHLSXJkXOzlvpiMUNbGq0VIDw=;
        b=AiYRsbNPUrZt3HPq+xtJfDrvafoV3sgbBvDsYvDt8alNybjtz3OkR1xymRkE3QILqj
         mmJ4n9e+K/PVts3cQ2eJ5htk2mJ+mPxzhWMdsaeW6GINZP2CIccvVT49FekPjg7PRFXI
         92WGHwoPAVqBkaMzcdjnmCw5MEE1uFvTm34eA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PkxtUHaGFDycP6D2luIHLSXJkXOzlvpiMUNbGq0VIDw=;
        b=xJjIB0xbqIFV+1zPBn0XV3FAWSZfhzaUlvjlAtJloHwJWvh05tc4MX9/451gJoEGC+
         wtuIGGMnIjcyJZhSN+kc3QR1KtyGPepGl2IdgLSawn54k2/fXykFFZrFgjxehl+9nn5/
         rcDr25C1xGsyFfJ2rckupAM5ZsMsM3Ks6QMPixZn1ld4UPEdyTLzLPFybLO5K4OsYI+h
         mJGb+0555M/sqnWCGCug3BxjmEaPyxJEX5oeC9/Q0ZEtAZRESICeGlB03qx3g0mMlUzq
         QLGgSLQ39fSHcaWBt83QIa+g6RHra+JjU2H0dLMA64Hk7I8x3hP5w2CywggHulP7upr6
         bZyA==
X-Gm-Message-State: ACrzQf1xQvbieRTwtFwHRxaIT6MtDstWga7dtk4qrxEb3vlMT2MXZaDz
        YnuU7FL7QmpxIdVEWq0mBjl47xoA1DtaYQ==
X-Google-Smtp-Source: AMsMyM7A/cBM00sVlXD/6tJTItSYycjhKHySJ/EJPJ3XYMbHOD3iJG+qCxSuge0CZWAZsj1TI2XIog==
X-Received: by 2002:a05:620a:439b:b0:6f8:e1b0:e06d with SMTP id a27-20020a05620a439b00b006f8e1b0e06dmr8102392qkp.629.1666901741892;
        Thu, 27 Oct 2022 13:15:41 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id m8-20020a05620a24c800b006ce515196a7sm1605138qkn.8.2022.10.27.13.15.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 13:15:40 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-367b8adf788so27754517b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 13:15:40 -0700 (PDT)
X-Received: by 2002:a81:d34c:0:b0:349:1e37:ce4e with SMTP id
 d12-20020a81d34c000000b003491e37ce4emr46057341ywl.112.1666901739776; Thu, 27
 Oct 2022 13:15:39 -0700 (PDT)
MIME-Version: 1.0
References: <20221027150525.753064657@goodmis.org> <20221027150928.780676863@goodmis.org>
 <20221027155513.60b211e2@gandalf.local.home>
In-Reply-To: <20221027155513.60b211e2@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 27 Oct 2022 13:15:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjAjW2P5To82+CAM0Rx8RexQBHPTVZBWBPHyEPGm37oFA@mail.gmail.com>
Message-ID: <CAHk-=wjAjW2P5To82+CAM0Rx8RexQBHPTVZBWBPHyEPGm37oFA@mail.gmail.com>
Subject: Re: [RFC][PATCH v2 19/31] timers: net: Use del_timer_shutdown()
 before freeing timer
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Mirko Lindner <mlindner@marvell.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Menglong Dong <imagedong@tencent.com>,
        linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
        bridge@lists.linux-foundation.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, lvs-devel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net
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

On Thu, Oct 27, 2022 at 12:55 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I think we need to update this code to squeeze in a del_timer_shutdown() to
> make sure that the timers are never restarted.

So the reason the networking code does this is that it can't just do
the old 'sync()' thing, the timers are deleted in contexts where that
isn't valid.

Which is also afaik why the networking code does that whole "timer
implies a refcount to the socket" and then does the

    if (del_timer(timer))
           sock_put()

thing (ie if the del_timer failed - possibly because it was already
running - you leave the refcount alone).

So the networking code cannot do the del_timer_shutdown() for the same
reason it cannot do the del_timer_sync(): it can't afford to wait for
the timer to stop running.

I suspect it needs something like a new "del_timer_shutdown_async()"
that isn't synchronous, but does that

 - acts as del_timer in that it doesn't wait, and returns a success if
it could just remove the pending case

 - does that "mark timer for shutdown" in that success case

or something similar.

But the networking people will know better.

               Linus
