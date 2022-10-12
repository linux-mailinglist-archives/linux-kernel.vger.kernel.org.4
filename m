Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFFF5FC9D8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 19:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiJLRWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 13:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiJLRWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 13:22:33 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F69126AEF
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 10:22:30 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id w74so11575894oie.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 10:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZRYFk+9yyHZHAcB/2rwgdrsgnigrvHFKirKgHeDmUno=;
        b=AE8z8KD6uwSVMiRp4ABm0Kn9UkMq8P+bk8+Y1ITmg3vl1hYmjp6k8LU6URk5HzGGQF
         2/fqw2HhcOa/gTcb1tS3SQgcP9XK2z4BjeVToHve1GXn4ay7pgmzQA+nKS017UcVgGKS
         Udydt9y4k+dIUSNMddvtmXX3tSMn7byJOqVUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZRYFk+9yyHZHAcB/2rwgdrsgnigrvHFKirKgHeDmUno=;
        b=Br+UPU7kLGTueibMfyWw+tvQJwuERi/qm5eb34CnrTa6dUNQ5Sj0vvN5+ZtRy5yANz
         x/JJu4euquZGklv/ILijT6rW/xw61v8GG4QZH+DQVPhBwZplQiBRv0XgVip7c+hUiyWr
         SJzKJgMX3UHwMjAtB9xiNFjLQUsLIlE9FZdCWzrKK/exgJo607c11tZra14/lseO+Z+k
         lSjrk3Jagb/v5X3pqlRTeAwvXNLmago7bM89OaOdOHsial1ARmgOeSi5PLo+19+tg0Hf
         9tvCcznPyhV1eBO+yIJSnTOmBD06/5KwFW4wS42PzR30Yec2CwfqYdQXkyY8v7aafEG8
         X8Xw==
X-Gm-Message-State: ACrzQf3ApM9ABMh0yTykduCAGOcvAM4m89fqEqS2ms7qBk7RGQU7z8Fb
        14T62mEeNRQQZAwEAiyUYtKiO6X63Xz8bg==
X-Google-Smtp-Source: AMsMyM6sG+/2s70ytlWDfU2Vi4MFm5Bx9whp/yVm0lQ+TeY+VmqgC0uBjlP4ToCet7DvvnwG8YppPQ==
X-Received: by 2002:a05:6808:1916:b0:354:d449:7805 with SMTP id bf22-20020a056808191600b00354d4497805mr2567977oib.137.1665595348233;
        Wed, 12 Oct 2022 10:22:28 -0700 (PDT)
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com. [209.85.160.46])
        by smtp.gmail.com with ESMTPSA id j11-20020acab90b000000b003504f8f6ac5sm7039550oif.38.2022.10.12.10.22.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 10:22:24 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1324e7a1284so20201501fac.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 10:22:24 -0700 (PDT)
X-Received: by 2002:a05:6870:c0c9:b0:127:c4df:5b50 with SMTP id
 e9-20020a056870c0c900b00127c4df5b50mr3072194oad.126.1665595344160; Wed, 12
 Oct 2022 10:22:24 -0700 (PDT)
MIME-Version: 1.0
References: <20221010132030-mutt-send-email-mst@kernel.org>
 <87r0zdmujf.fsf@mpe.ellerman.id.au> <20221012070532-mutt-send-email-mst@kernel.org>
 <87mta1marq.fsf@mpe.ellerman.id.au> <87edvdm7qg.fsf@mpe.ellerman.id.au> <20221012115023-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221012115023-mutt-send-email-mst@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 12 Oct 2022 10:22:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg2Pkb9kbfbstbB91AJA2SF6cySbsgHG-iQMq56j3VTcA@mail.gmail.com>
Message-ID: <CAHk-=wg2Pkb9kbfbstbB91AJA2SF6cySbsgHG-iQMq56j3VTcA@mail.gmail.com>
Subject: Re: [GIT PULL] virtio: fixes, features
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, alvaro.karsz@solid-run.com,
        angus.chen@jaguarmicro.com, gavinl@nvidia.com, jasowang@redhat.com,
        lingshan.zhu@intel.com, wangdeming@inspur.com,
        xiujianfeng@huawei.com, linuxppc-dev@lists.ozlabs.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
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

On Wed, Oct 12, 2022 at 8:51 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> Are you sure?

MichaelE is right.

This is just bogus historical garbage:

> arch/arm/include/asm/irq.h:#ifndef NO_IRQ
> arch/arm/include/asm/irq.h:#define NO_IRQ       ((unsigned int)(-1))

that I've tried to get rid of for years, but for some reason it just won't die.

NO_IRQ should be zero. Or rather, it shouldn't exist at all. It's a bogus thing.

You can see just how bogus it is from grepping for it - the users are
all completely and utterly confused, and all are entirely historical
brokenness.

The correct way to check for "no irq" doesn't use NO_IRQ at all, it just does

        if (dev->irq) ...

which is why you will only find a few instances of NO_IRQ in the tree
in the first place.

The NO_IRQ thing is mainly actually defined by a few drivers that just
never got converted to the proper world order, and even then you can
see the confusion (ie some drivers use "-1", others use "0", and yet
others use "((unsigned int)(-1)".

                   Linus
