Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF5E69FDD7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 22:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjBVVoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 16:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbjBVVoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 16:44:05 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22AC33449
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 13:44:03 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id ec43so35595293edb.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 13:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8oYWKIc1S3uxITVpxd8tWdXuh6CEoVI7L8XjQ7W6G1A=;
        b=HhUHBtTjub8KdQHhqu1fxHUgmYd9w+ceHrZK9zRemdaggPWtv2iGPX6Cql9YcsRCzv
         ew7JVcXnoVO+4cDmGI33ch5+YbLrwqZNZFUyY25F96N4PowEGSsYLjkRYiFYdoihT7td
         zjBWY+nzFImFuPwTQP0fDvzUFTGKWAxaIS278=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8oYWKIc1S3uxITVpxd8tWdXuh6CEoVI7L8XjQ7W6G1A=;
        b=d4ZZb+ptIZaOUdN+0VsD6nicHt3bvTzuEzR190IwOEwKkKM4Gi+tEpnFucRkHs8GBu
         nQRaroB+7uVVFZdO3FXDX80oIMT0XP+odO7Jqe0E/prHZSgJAlPutrP/wY24u8DkSJXL
         j6tgOgCkiBhYigqN32SXGZNl8GzaY6lUCWUhB+KK8xp8KnonLElWQoa9XIOti03KBerS
         KRMbI6ifiVQoCV29OBdGYSgoJIovNzaDFFldLz6LO0mVqLz+xP7vpxQmMMmj93G88loW
         OV5ttAnrfTeR4u3xQAX827z75Q78+KTb0kH4Wv4vY00A2YaPtSqf7Be7e8WI9UFSLpoT
         fzHQ==
X-Gm-Message-State: AO0yUKVecu0Kt5fvhcO9BRFHp8shvKX9BxQ9ByNiPhVAInm6x2akuwIs
        OMbij8haHjaVN1rW5e8hSzDQLTMMsEQQLhNiQ9M=
X-Google-Smtp-Source: AK7set9QJkYFdMsrJ8895Ahvim3s67sgcOkdha2N0QazmujXeY9r3wWg2bGdB8/nzZTVJubTmt7xrA==
X-Received: by 2002:a05:6402:88c:b0:4af:5ff1:8756 with SMTP id e12-20020a056402088c00b004af5ff18756mr3614518edy.0.1677102242122;
        Wed, 22 Feb 2023 13:44:02 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a63-20020a509ec5000000b004af6163f845sm1262556edf.28.2023.02.22.13.44.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 13:44:01 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id eg37so32313428edb.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 13:44:01 -0800 (PST)
X-Received: by 2002:a50:f694:0:b0:4ad:6d57:4e16 with SMTP id
 d20-20020a50f694000000b004ad6d574e16mr4649056edn.5.1677102240934; Wed, 22 Feb
 2023 13:44:00 -0800 (PST)
MIME-Version: 1.0
References: <20230223083932.0272906f@canb.auug.org.au>
In-Reply-To: <20230223083932.0272906f@canb.auug.org.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Feb 2023 13:43:44 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjXpth1kQRCeAXhxoAmsr8dnLLW9KJ0haMiXmdF6-hFfw@mail.gmail.com>
Message-ID: <CAHk-=wjXpth1kQRCeAXhxoAmsr8dnLLW9KJ0haMiXmdF6-hFfw@mail.gmail.com>
Subject: Re: linux-next: duplicate patch in the bpf tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
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

On Wed, Feb 22, 2023 at 1:39 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> The following commit is also in Linus Torvalds' tree as a different commit
> (but the same patch):

Yup, that was very intentional to keep the fallout of the problem on
random architectures minimal.

         Linus
