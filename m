Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B41665C85A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 21:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238863AbjACUqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 15:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238888AbjACUqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 15:46:03 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEAB14D33;
        Tue,  3 Jan 2023 12:46:02 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id l139so147035ybl.12;
        Tue, 03 Jan 2023 12:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XKlQpt6uvL07Ls9Ei/49KiHiJ6/fe4cVnWR4L1LQ220=;
        b=C+uywNvIs96mrpcs8fb9YrHTM4aboYcLDJfhJlb7po5ITqZtHOrUtmzsYWQy3B89OK
         EMJPu9xZwpoU6esWMrSY4bCE5sMvvHx5UAXTfm4zMFhyWJ4KhKj46sgFWvdm58Q7aDon
         tjP1T2rRw9+rnRj+Epnvf3JMRWTVNAD/96jMd3aWpPrWzlD1Vkfd+OyorbiMZcytLLzy
         KWYonAJQ2goHtacYwczR7kBfenQrHKF9xevx92mOhiBGZWG9LYoXg8PHONUsFSVoSU5C
         67g5zJzzdH5RY1XR0GYh/DCh+D4wNP+h690adCquoqoR5M80HXEmWLfn9DbqGhZYlkZV
         DkbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XKlQpt6uvL07Ls9Ei/49KiHiJ6/fe4cVnWR4L1LQ220=;
        b=GVdBShq84iL7gXZs+yep+8Q6GU2BVAcW8BFOvsPFlNMFoIy/k3H+WLOVIA8G1F8bv/
         LBDNrBuPjMXzngkW9+gWZoy7DIFyUwPbgDYXSCLPUfKSXWewm23COwRMs+Y1Mm49gSTR
         8iPvTcFxH5Iq+z4gatA3Xqu/Ek2rw2oDoJZuAMQQlycNOoyfwgCN2P+wX4ZzysF7xOJ2
         HYEv32b7oXlwQPAPeKDZGA5Pz3f7j/1wdl0t4QNSncdePQbMkttEvmv6tWBN9BkCFyXN
         yUuTN77e8r/EhZhpstCDNsuXF/ZP5pkY4N4CSxikIpaBILIVME6Cet/vFpb9Akso6+c7
         zLGw==
X-Gm-Message-State: AFqh2koWwqLq5eaPHkWHh0lvnUYycK+AXaPUbWyMcNadpq1dck6TnIs/
        ACAGaY7bG2GIxpPF5m7NoTPSi2voSGaZUhbdnLnWeI+EtzeXG+Fs
X-Google-Smtp-Source: AMrXdXv54hDRD6X+qXFCFyNcQnXFW0lAJv72Uh6HNGrltn5B8uS1J+CxDUixyptEbwfoz6XHL3Hp3p/sHv9PNaA3lBc=
X-Received: by 2002:a25:e6c1:0:b0:761:d9ec:328f with SMTP id
 d184-20020a25e6c1000000b00761d9ec328fmr4293632ybh.507.1672778761493; Tue, 03
 Jan 2023 12:46:01 -0800 (PST)
MIME-Version: 1.0
References: <20221231064203.1623793-1-masahiroy@kernel.org> <20221231064203.1623793-5-masahiroy@kernel.org>
In-Reply-To: <20221231064203.1623793-5-masahiroy@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 3 Jan 2023 21:45:50 +0100
Message-ID: <CANiq72n6ZLcNRh=Ec1xCSNJtb=KZNMA-MMrtd8=DyUL4-2i_0w@mail.gmail.com>
Subject: Re: [PATCH 4/6] fixdep: refactor hash table lookup
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
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

On Sat, Dec 31, 2022 at 7:42 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> +/*
> + * Lookup a string in the hash table. If found, just return true.
> + * If not, add it to the hashtable and return false.
> + */
> +static bool in_hashtable(const char *name, int len, struct item *hashtab[])

I think readers may find a bit surprising that a function named
`in_hashtable` mutates the table. Should we use a better name? Perhaps
`ensure_in_hashtable`?

In other words, the function is really "insert if not already there
and return the previous state". Similar methods in C++ and Rust are
called `insert`, though they return the opposite, i.e. whether the
insertion took place. If we did that, then `insert_into_hashtable` may
be a good name instead.

> +       unsigned int hash = strhash(name, len);

Nit: this could be `const`, but I see we are not using it in
`fixdep.c` (for non-pointees) and it was not done in the original. But
it could be nice to start...

Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
Tested-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
