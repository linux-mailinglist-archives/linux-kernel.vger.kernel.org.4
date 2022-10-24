Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829CA60BC8D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 23:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiJXVyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 17:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbiJXVyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 17:54:21 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524232F272D
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 13:08:10 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id t25so6791797qkm.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 13:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MDpgzQG8dmgEoiEUfYcpSbDd31DVRx70fLapPMBjtJI=;
        b=LCfRZon3vZnZHSxce4XZXcxfQd2il/sh41ERF0J3f8mlXerhKZxGO+aNgMRfqAC7u8
         HXrBUv5kabYITECZt9ZOzVsYJQ5cii/lIZ/BHPsZYpeqfaLHH/DPc3J0Pxxw0KRxbMZL
         y1vY9wimStgmzEIEHtluo6/5SDdCg6pmWfi/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MDpgzQG8dmgEoiEUfYcpSbDd31DVRx70fLapPMBjtJI=;
        b=K2OVqLRVRnhXgtwGSjRkGN4aw6/mbbaZKTLn3QmFkXtp/HFUE8pD5dmEPtWI3unqr7
         2nlKj8CgxIjoBpAeyejSBBlytcuNzurIJzrmLr7wJ8kTxzYK+0Tr6XJ78kwnEMrXGhC8
         6mE9NfFvgixFdmLhL1UuPPzY3ekorcudCEmVwy/RhwDUY8cMVDPhDFukEHPX/EXABN0i
         xkxLMK+zRWBieID2Ex/wPuPWHMFy7fA1e/mCOA3TpGcxjGW6qeZ0+1Bg0tIa1GQduW2u
         Lb1753W9cpQSeVlIIL5SDujXoZgDORMd5XRapa6rUAzzLefPWhkocE/y579TTFKxegpB
         rqyQ==
X-Gm-Message-State: ACrzQf3KxupplQf5WYQWmH1Qh20KK0qFPYfFcu2yLxHNldwN69Eyf46S
        1Yy4I0U28Cgan3O+viYCWTGapqaLDEKFhA==
X-Google-Smtp-Source: AMsMyM6D7dPhJF/bwNHAOoRwS8cYzHj3AXHWochKV/YIlZQONjG5jifX9kIdDPeOTdmfmriaw4Pxjw==
X-Received: by 2002:a05:620a:44c2:b0:6ee:7a72:50b3 with SMTP id y2-20020a05620a44c200b006ee7a7250b3mr23940749qkp.124.1666641989770;
        Mon, 24 Oct 2022 13:06:29 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id r4-20020ac867c4000000b0039cbe823f3csm480346qtp.10.2022.10.24.13.06.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 13:06:28 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id o70so12231240yba.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 13:06:28 -0700 (PDT)
X-Received: by 2002:a25:84cf:0:b0:6b3:c0c3:19d8 with SMTP id
 x15-20020a2584cf000000b006b3c0c319d8mr28662460ybm.349.1666641988539; Mon, 24
 Oct 2022 13:06:28 -0700 (PDT)
MIME-Version: 1.0
References: <20221024165421.GA1246679@paulmck-ThinkPad-P17-Gen-1>
 <CAHk-=wi1GXyh+kn1XfrbLA209MBGktteN=L+=cTEcoruxBtu3g@mail.gmail.com> <20221024200446.GD5600@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221024200446.GD5600@paulmck-ThinkPad-P17-Gen-1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Oct 2022 13:06:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi5fhyHfabjN6kDD+ow5m1JF4iduq0SHDkidqK1+G9aLA@mail.gmail.com>
Message-ID: <CAHk-=wi5fhyHfabjN6kDD+ow5m1JF4iduq0SHDkidqK1+G9aLA@mail.gmail.com>
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

On Mon, Oct 24, 2022 at 1:04 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> Please accept my apologies for my confusion!
>
> Please see below for a pull request for a better-formatted commit.

Oh, it was such a small nit that I already pulled your tree - my note
was really just a "not a big deal, but in the future it would be nice
if.."

                Linus
