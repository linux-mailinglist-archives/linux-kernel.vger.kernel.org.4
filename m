Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A916E3A78
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 19:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjDPR0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 13:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjDPR0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 13:26:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A41C30F4
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 10:26:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0736B61BE6
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 17:26:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 422E8C4339C
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 17:26:16 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="NvYyy6RX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1681665971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5YTV6RJSLLGsh4cCjIblt3GFNcM3RSEdifI1BEleZbs=;
        b=NvYyy6RXhM74TLQcpWzzhJgDUcpHwv/flgaFiK0ugy919JR+j+HROl5R0h0pPyZNO3XLB4
        wr1cNCEXb96QqKwwwzYjVUdiwV3gmFc0nYreQ6WLQHAkKLs/kyj9DWFf8V7LGXf7YImUWu
        ewuQNiHpqUbDL4YML4RtU2S2xi0f9+c=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 1b548319 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Sun, 16 Apr 2023 17:26:10 +0000 (UTC)
Received: by mail-ua1-f46.google.com with SMTP id a19so865231uan.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 10:26:10 -0700 (PDT)
X-Gm-Message-State: AAQBX9d9hNhX3MgmNunLJ9cPU9yGTYGyEFqJ9R4xHSso9teyPF6zx3FK
        lh3fzdYvY1C2uJXBOOOgQX7k2df2BubDzEDK+BE=
X-Google-Smtp-Source: AKy350ZIOu5e0q1b1DdiWvVZ6a3eht1nafwTTyUd15TIlw9ZJNaTFyyqBS3ctkfPQtof1l9QgdSD7m2nFCMHdxTUXeU=
X-Received: by 2002:a1f:ad91:0:b0:43f:df8d:cfe2 with SMTP id
 w139-20020a1fad91000000b0043fdf8dcfe2mr5740273vke.2.1681665969091; Sun, 16
 Apr 2023 10:26:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2799:0:b0:75c:e750:ab with HTTP; Sun, 16 Apr 2023
 10:26:08 -0700 (PDT)
In-Reply-To: <20230416172323.13278-1-david.keisarschm@mail.huji.ac.il>
References: <20230416172323.13278-1-david.keisarschm@mail.huji.ac.il>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sun, 16 Apr 2023 19:26:08 +0200
X-Gmail-Original-Message-ID: <CAHmME9qP2jwSk7o6EYGK_=vRntfLq6O1BcnH46ibt=Ypv3v-vw@mail.gmail.com>
Message-ID: <CAHmME9qP2jwSk7o6EYGK_=vRntfLq6O1BcnH46ibt=Ypv3v-vw@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] arch/x86/mm/kaslr: use siphash instead of prandom_bytes_state
To:     david.keisarschm@mail.huji.ac.il
Cc:     linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        keescook@chromium.org, ilay.bahat1@gmail.com, aksecurity@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/16/23, david.keisarschm@mail.huji.ac.il
<david.keisarschm@mail.huji.ac.il> wrote:
> From: David Keisar Schmidt <david.keisarschm@mail.huji.ac.il>
>
> However, the seeding here is done by calling prandom_seed_state,
> which effectively uses only 32bits of the seed, which means that observing
> ONE
> region's offset (say 30 bits) can provide the attacker with 2 possible
> seeds
> (from which the attacker can calculate the remaining two regions)
>
> In order to fix it,  we have replaced the two invocations of
> prandom_bytes_state and prandom_seed_state
> with siphash, which is considered more secure.
> Besides, the original code used the same pseudo-random number in every
> iteration,
> so to add some additional randomization
> we call siphash every iteration, hashing the iteration index with the
> described key.
>
>

Nack. Please don't add bespoke new RNG constructions willy nilly. I
just spent a while cleaning this kind of thing up.
