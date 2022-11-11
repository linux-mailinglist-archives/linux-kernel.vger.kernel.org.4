Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650396251FC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 04:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbiKKD7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 22:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiKKD7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 22:59:20 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168B0D119
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 19:59:20 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id j12so3283330plj.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 19:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LgrIXUR8AU3qwrqhiw2jjUgSHNpYQrsvYDcBN102UbQ=;
        b=PSgjYIp1YjH3n3BqnVVZu+FCPYH7SSfo0UvMf8csT3kXBfM1I2a6YFvRhFx3PWk/NS
         yIWzvuuEED+AFAPS4Fyq4ShoziEHK/woObQ0BHBgUosVqjPtld1ArrZMEOARzrr8NWpx
         MSdrGNR4REGszRufFv+VS4KXkofyyrtqT/zulfT0YUzBE+HOQVXu4vOqdFZIXQG0bgnJ
         lnSBc/hLZRJHa3hiTBgMIHxrihPA35hiz4VmPN/8PNptKe/yg6Rq2mRwosEu7ITJe0bp
         PrwNO2WR8d/NuvWbTkU1sCSN0FSZQHiNrdmdpmRVQf+eqiSAfyzIT4efvb7GUUkl9chd
         LMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LgrIXUR8AU3qwrqhiw2jjUgSHNpYQrsvYDcBN102UbQ=;
        b=i6uwC/lZev4dlS7yvQ8QnHIP+qA4q3WWDXpUkQQ3qVFq456j0FTHD8UH3tpKKCqANw
         K1XzCRypKdkHzJozza2F1WSGGmq/Zz7Ll6cnijFYxHOnZAHtyFOqniok4KhYlo/TB+FX
         26II4eTigw/K0s2jkzeycyto5EIkB1ucxktyfFOrx28vUfllsTHk7ySDH4as2Qy5KdQf
         VVv0jEYxfGu3Mtmc0zrFJLS72+h33ydKrcenln+/1MDvLFKtRxTzpao/igUsXq2wVxFs
         GQbkpEKp6DWVYHxZ6UcNlktrSjxqBIehOCq5lTOGVaF1KT6lav0Jin2quGgg9OdUuN4z
         SfyA==
X-Gm-Message-State: ACrzQf10KFmQIyP1clU932pfQ7A9sD9EtON7xyaRm8/wu517+V9t/DPV
        IH25kC49esqTpOnhJLJlEcWdvQDg22BPrhR6/AQ=
X-Google-Smtp-Source: AMsMyM5SUIHXONzylMWf1aJrJzXwrcq8UjA/TM8nmo3JZ/yvyj6NreOfMvpc+v6yPj54zjSuSsFvFPj787UIFaj7ZBk=
X-Received: by 2002:a17:90a:64cd:b0:216:cdf6:54c0 with SMTP id
 i13-20020a17090a64cd00b00216cdf654c0mr3194897pjm.34.1668139159509; Thu, 10
 Nov 2022 19:59:19 -0800 (PST)
MIME-Version: 1.0
References: <20221108110715.227062-1-pedro.falcato@gmail.com> <202211101934.22CACD615@keescook>
In-Reply-To: <202211101934.22CACD615@keescook>
From:   Pedro Falcato <pedro.falcato@gmail.com>
Date:   Fri, 11 Nov 2022 03:59:08 +0000
Message-ID: <CAKbZUD2r=zK91J4c6pyHQhDuqqMzmrx+BBgFF4Cso2jK+jjhHA@mail.gmail.com>
Subject: Re: [PATCH v3] fs/binfmt_elf: Fix memsz > filesz handling
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, dalias@libc.org,
        ebiederm@xmission.com, sam@gentoo.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 3:38 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Nov 08, 2022 at 11:07:15AM +0000, Pedro Falcato wrote:
> > [...]
> > +              * This tail logic is skippable if we're the last phdr, as
> > +              * nothing can map an address >= our p_vaddr, since ELF phdr
> > +              * PT_LOAD segments are required to be sorted in an increasing
> > +              * order.
>
> I'm still looking through the patch, but I do want to call this bit out
> as a problem. The kernel cannot, unfortunately, make this assumption. See:
> https://lore.kernel.org/linux-fsdevel/YfOooXQ2ScpZLhmD@fractal.localdomain/

Ugh. I guess it doesn't matter in this situation? That logic only
matters if we're trying to fix this new loading bug, and old
executables load correctly with the old behavior anyway,
which is what you get if that logic falls through.

I don't know if this makes sense, but in my (possibly naive) opinion
we have a compromise to keep loading what could already be loaded,
without actually requiring to load broken ELFs 100% correctly.

We could of course also just sort the program headers at load time,
but I assume that's unwanted overhead for most well behaved ELF
program headers :)

-- 
Pedro Falcato
