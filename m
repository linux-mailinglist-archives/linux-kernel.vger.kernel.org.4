Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0236860BC45
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 23:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbiJXVee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 17:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233714AbiJXVeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 17:34:09 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7A72745B3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 12:41:23 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id m6so6738350qkm.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 12:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RHwylrpUhj9v4/w8TtnyC8haWHtRwyVJQggauiAHehQ=;
        b=XwVorEtf3KoWJHKCNWfx/5m0XsHd+TojlQiZa2lTRU2tMPjvHFUP2MXHNmB9G5WCLM
         wnlvDUNfwHCWCVk960vhH/PdBT4jJExZ7npaGpp2QaYphHUTlRih7b+t+2I0i3k+Tru/
         BiOAM6q/OZRt/nZ9nWFvF90lCeUKgKCznjjjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RHwylrpUhj9v4/w8TtnyC8haWHtRwyVJQggauiAHehQ=;
        b=KmGGo2ZlgkDbLAqUcy1FlyzjSqM8jTQyyJZWS42EgajDIXYoy5N1YmNwAIZn+WP8gD
         sh39S1xQaltHYBgw70hIrO1H8FlW1cHBEbnIl39c1oDFHIuzTg5mAYKW8RZKx6BsddXz
         e02NmLumM604yECZ423HFISrby8h+Q85ngzgJMh7svBOOJresz1MWq9zzUjGeSucRszz
         9oQGE0VI7cjtNjYBNHYS//PCZ6BokDn0bah69mMRAkvc4fizu30eIW3r3qqWVyJYYY32
         n+HbLETO3hN/VCcIm7uHryh9aO54zLBK6eMup1SXZ0LRyeh3HSV7TD/84bnJflOt5e7S
         lqRA==
X-Gm-Message-State: ACrzQf0USusiDzKCkqPmZaVx+cCXlg0uTgL/OmyO6Vp7mr7ymQ17NG1+
        0nHQv5KEBerr17R1X5UpEm+SZmodO5GGmA==
X-Google-Smtp-Source: AMsMyM7tw6NlkQeUUbTT24dJIwVc8fjJ2U0murVDfChALiJAaWcj+1VhKZLWdFEN1VffMub60J4zNw==
X-Received: by 2002:a05:620a:1729:b0:6ee:cf01:6810 with SMTP id az41-20020a05620a172900b006eecf016810mr23734085qkb.555.1666640418832;
        Mon, 24 Oct 2022 12:40:18 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id fz9-20020a05622a5a8900b00398426e706fsm395503qtb.65.2022.10.24.12.40.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 12:40:18 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id o70so12159582yba.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 12:40:18 -0700 (PDT)
X-Received: by 2002:a05:6902:124f:b0:66e:e3da:487e with SMTP id
 t15-20020a056902124f00b0066ee3da487emr32262663ybu.310.1666640417860; Mon, 24
 Oct 2022 12:40:17 -0700 (PDT)
MIME-Version: 1.0
References: <20221024165421.GA1246679@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221024165421.GA1246679@paulmck-ThinkPad-P17-Gen-1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Oct 2022 12:40:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi1GXyh+kn1XfrbLA209MBGktteN=L+=cTEcoruxBtu3g@mail.gmail.com>
Message-ID: <CAHk-=wi1GXyh+kn1XfrbLA209MBGktteN=L+=cTEcoruxBtu3g@mail.gmail.com>
Subject: Re: [GIT PULL] Keep synchronize_rcu() from enabling irqs in early boot
To:     paulmck@kernel.org
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        rcu@vger.kernel.org, kernel-team@fb.com, rostedt@goodmis.org
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

On Mon, Oct 24, 2022 at 9:54 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> This pull request contains a commit that fixes bf95b2bc3e42 ("rcu: Switch
> polled grace-period APIs to ->gp_seq_polled"), which could incorrectly
> leave interrupts enabled after an early-boot call to synchronize_rcu().

Minor stylistic nit-pick - please try to keep the commit tags
together, ie the "Fixes:" tags goes with Reported-by: tags and
sign-offs etc..

              Linus
