Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D675468DDBA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 17:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbjBGQPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 11:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbjBGQP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 11:15:28 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4B45FFC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 08:15:23 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id l14so6406349eds.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 08:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4RM6pXDqOiFHeAx0WMmnhom/Qz888Ih/TPZU+Y9eyTk=;
        b=NsNlyZdX9FntXMmjVZZquGBbjRgyatHH8Ma3nbcSD5cdovFSmwk5DDBQ2fWraFPrwc
         yEbD3pAldW0OWp9nFmXL3+41yWEaP4WAJsgLpL/66YPcHbCxz4tea6LTrE8ieMPZUjLt
         m4B76mBx3QUIutr78aW0ASxIjNPwfvFPpHMSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4RM6pXDqOiFHeAx0WMmnhom/Qz888Ih/TPZU+Y9eyTk=;
        b=LcTe93LXPL52f30wJ3vcPbvFZFErwjQQWYLZt0lWmxG3oRZDIA95HxM2stHe68V691
         uoOFkGXkTeI5C0z2tAEXIF+gd0fqy/BO96MZTRHNkBGt+QbAXSRJJXZCLF/WURZlK1kj
         oVojseFWfTL4p/RDaIoWaePmLKDFSgURZw73k33bj1NQzkgxWqLrQ3XDs7uBnAFfa7u/
         xJfzto42G2ZwwVQEwbCsZxWuQcsIf9rn7mLDnHjgGDCKfF3mBAT7sKNxA92jCn7uyStC
         C3q45YAEuNckia9kEyDsTDyBCaJrwEw0bo0H0Cpf56GUA18Zk6es3RHkZ34/9EYX0Hxl
         Xlcg==
X-Gm-Message-State: AO0yUKVI5ASQaX7Bj6mac2dmgB59j7fi/NzLwo/tanzwo0YHe66ygfsj
        mDQA8yUAwVqz7WMfGJJOXo2l6c5KLzZiR9J6Ju8S9Q==
X-Google-Smtp-Source: AK7set/FcSL2/cw1kw9dDJItJCHDIZRacJWlDYMZjk1Sf3ELUeO6GB/ctfnSOjcUg5cu4Jii3k8PTw==
X-Received: by 2002:a17:906:c190:b0:88d:79df:7cfc with SMTP id g16-20020a170906c19000b0088d79df7cfcmr3839223ejz.62.1675786521999;
        Tue, 07 Feb 2023 08:15:21 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id c12-20020a170906154c00b0088c224bf5b5sm7137594ejd.148.2023.02.07.08.15.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 08:15:21 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id l14so6405938eds.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 08:15:20 -0800 (PST)
X-Received: by 2002:a17:906:4e46:b0:87a:7098:ca09 with SMTP id
 g6-20020a1709064e4600b0087a7098ca09mr874420ejw.78.1675786520751; Tue, 07 Feb
 2023 08:15:20 -0800 (PST)
MIME-Version: 1.0
References: <20230129060452.7380-1-zhanghongchen@loongson.cn>
 <CAHk-=wjw-rrT59k6VdeLu4qUarQOzicsZPFGAO5J8TKM=oukUw@mail.gmail.com>
 <Y+EjmnRqpLuBFPX1@bombadil.infradead.org> <4ffbb0c8-c5d0-73b3-7a4e-2da9a7b03669@inria.fr>
 <Y+Ja5SRs886CEz7a@kadam>
In-Reply-To: <Y+Ja5SRs886CEz7a@kadam>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Feb 2023 08:15:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg6ohuyrmLJYTfEpDbp2Jwnef54gkcpZ3-BYgy4C6UxRQ@mail.gmail.com>
Message-ID: <CAHk-=wg6ohuyrmLJYTfEpDbp2Jwnef54gkcpZ3-BYgy4C6UxRQ@mail.gmail.com>
Subject: Re: block: sleeping in atomic warnings
To:     Dan Carpenter <error27@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     linux-block@vger.kernel.org, Julia Lawall <julia.lawall@inria.fr>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Hongchen Zhang <zhanghongchen@loongson.cn>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        maobibo <maobibo@loongson.cn>,
        Matthew Wilcox <willy@infradead.org>,
        Sedat Dilek <sedat.dilek@gmail.com>
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

On Tue, Feb 7, 2023 at 6:06 AM Dan Carpenter <error27@gmail.com> wrote:
>
> block/blk-crypto-profile.c:382 __blk_crypto_evict_key() warn: sleeping in atomic context
> block/blk-crypto-profile.c:390 __blk_crypto_evict_key() warn: sleeping in atomic context

Yeah, that looks very real, but doesn't really seem to be a block bug.

__put_super() has a big comment that it's called under the sb_lock
spinlock, so it's all in atomic context, but then:

> -> __put_super()
>    -> fscrypt_destroy_keyring()
>       -> fscrypt_put_master_key_activeref()
>          -> fscrypt_destroy_prepared_key()
>             -> fscrypt_destroy_inline_crypt_key()
>                -> blk_crypto_evict_key()

and we have a comment in __blk_crypto_evict_key() that it must be
called in "process context".

However, the *normal* unmount sequence does all the cleanup *before*
it gets sb_lock, and calls fscrypt_destroy_keyring() in process
context, which is probably why it never triggers in practice, because
the "last put" is normally there, not in __put_super.

Eric? Al?

It smells like __put_super() may need to do some parts delayed, not
under sb_lock.

              Linus
