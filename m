Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51565F12CA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 21:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbiI3Tgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 15:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbiI3Tg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 15:36:26 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BBF2D1F6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 12:36:05 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id j188so5777860oih.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 12:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=8CE3Iabg2NpyHioPDddF/UlYh7dtUO0nVnT8qt44FKI=;
        b=IC84e+qgneQiadY8Da1KC/ooqTpFF7UZWB7qFQEKvywWBk74UdwDLIsNAhG/qWUz3/
         UR22fTaoR10FzZzcDj3COGzOTQnHM5GAqAHvLhPmQuZDMk7XWJ/3j1FQ0wI3JD0vxoh+
         RCmQDj0UW6zI1HUIR7hGP9y0aghmCZxDP8/mQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=8CE3Iabg2NpyHioPDddF/UlYh7dtUO0nVnT8qt44FKI=;
        b=rKex3RhjIN3Iu9DAEj5ZxTbT9PyqfNuB7aXV8eBRLp+xQvmzPY1sdJMk/L641wy07d
         e8Wm5Rt3isBm5RFT9yF0dVACNwgQZ2IdnK3KRh7X/XG5kAUip14Xii9pYiXoSmDiEoOb
         oyoG6aeSVxsnXEUxOhFIhZy55FSXf8KzPX8Nvwmnvzq+6EGz4i4pZjVJNqatjQ2nO0YM
         fBsrfVUyuCx1KIxo+33/Pn7YuKCIilJ1cx3NxgRM5B+0O0GweuzLGZpn2cbYbPbcRkYS
         JP6oWgyicHKnEN4q3VS1mKeQIM2I/xd0J3d0DS+In6eNkwyUVUO7G8VjghqZPe20ScOq
         20lg==
X-Gm-Message-State: ACrzQf3z1db8+DCSrc706tklC5lRWwvDfsEatGv8SgImQng7/7hKZ3Uo
        b8+qYUgivxdDqbKR+bF7KsIGstac4aNy9A==
X-Google-Smtp-Source: AMsMyM5OAlLj+5RQ8LT09hxsrm+1Hp4pOA1RZywTg4V+O9CsPIfE9wBjaEnYbWtgicpMAy1kDIUdrQ==
X-Received: by 2002:aca:1710:0:b0:34f:e8cd:68ff with SMTP id j16-20020aca1710000000b0034fe8cd68ffmr4495336oii.194.1664566563497;
        Fri, 30 Sep 2022 12:36:03 -0700 (PDT)
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com. [209.85.167.171])
        by smtp.gmail.com with ESMTPSA id p21-20020a9d6955000000b00657a221eb71sm739062oto.65.2022.09.30.12.36.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 12:36:02 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id v130so5747268oie.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 12:36:02 -0700 (PDT)
X-Received: by 2002:aca:b957:0:b0:351:4ecf:477d with SMTP id
 j84-20020acab957000000b003514ecf477dmr4491126oif.126.1664566561733; Fri, 30
 Sep 2022 12:36:01 -0700 (PDT)
MIME-Version: 1.0
References: <YllALIgZcQJ6asdA@arm.com> <YlllpH+PB8XVUn6h@arm.com>
 <YlvLqkIdrCp/rOsG@gondor.apana.org.au> <YlvSEHul1Rv3Ap34@arm.com>
 <YlvTNQGh+MfZFWKW@gondor.apana.org.au> <YlxATW56ZoNtmxlk@arm.com>
 <YtHo3Xu33jovwpFt@google.com> <YtIvr7t8A/OlIXrT@gondor.apana.org.au>
 <YtWeJ12GI7LxQ4IK@arm.com> <YypfJQqj8PeOp8A4@google.com> <Yzc2UrX7ndWw1vKI@arm.com>
In-Reply-To: <Yzc2UrX7ndWw1vKI@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 30 Sep 2022 12:35:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgPqauyKD9CoQg2AAtV=ygpS_fAahhgzPAe99k5Kush6A@mail.gmail.com>
Message-ID: <CAHk-=wgPqauyKD9CoQg2AAtV=ygpS_fAahhgzPAe99k5Kush6A@mail.gmail.com>
Subject: Re: [PATCH 07/10] crypto: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Isaac Manjarres <isaacmanjarres@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Saravana Kannan <saravanak@google.com>, kernel-team@android.com
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

On Fri, Sep 30, 2022 at 11:33 AM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> I started refreshing the series but I got stuck on having to do bouncing
> for small buffers even if when they go through the iommu (and I don't
> have the set up to test it yet).

May I suggest doing that "force bouncing" and "change kmalloc to have
a 8-byte minalign" to be the two first commits?

IOW, if we force bouncing for unaligned DMA, then that *should* mean
that allocation alignment is no longer a correctness issue, it's
purely a performance one due to the bouncing.

So then the rest of the series should be about "ok, this is actually a
hot enough allocation that I want to force alignment", and be purely
about performance, not correctness.

No?

               Linus
