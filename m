Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3B0613C3B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 18:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiJaRh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 13:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiJaRhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 13:37:23 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A631209B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 10:37:20 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id 8so8044481qka.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 10:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bVoym53aP4ff+z3FOoG5jl2g45mYf6RnCpQn2di8eJo=;
        b=T56lY+eFVQT6wo4ittAe0G4dhERg4tyWGyylnPI0H0GxAg+OlwxMOlCbWh5QFV4ubU
         PvA4puiCG3uFaIM9XbM8VMI1Ao/hPNCPIlMChrSiJH9o3YuFKN6q9oIE2b9adfkNYqNz
         BN3E4lesGWlRKxqyFYzhnZcv9MHu01QlYr6J8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bVoym53aP4ff+z3FOoG5jl2g45mYf6RnCpQn2di8eJo=;
        b=ktyjHBtxKmaWzmyRPRbajw9QN/jofts6PgUpb0GDOKpsoJXveD3cFBbiuSZNS4W9g5
         aVwBhfsPHRnjQVeT1vUh+UUDx3jLAZG0r5bws1QJ2LANkivI258tL7CA35rVnC+SCVyB
         LQ1WKXeYIH3QaaTVNEEa4+2btEQ4ZkSGWBMRfzvimPWXHu1T5Vkcq87mbaB9oPH1Il09
         +J+040XhdN7HJaXC/qcD5JJ9u5pqsAhpER89bV2F28Mn9q2uNdVDWiukB0IqEONO8C7c
         VNkPGRH4whOoYvIgg6qVj4ra5l7CZd/wdi3Ll6Hoee25PXuTinzVG07858mnyJqSKSM2
         7shw==
X-Gm-Message-State: ACrzQf19sDCHwB9SQbHF7dPOWFeJUp5iQA38uv6dipkjZ0u5oZNVuJ/S
        tvDjKqakMj6KihAH80AM/d5tC2IgL7v0Rw==
X-Google-Smtp-Source: AMsMyM5kHXkVZhvQRV4rQSaEplTr/MYHkh/05ibwmEF2FGuESB8dHjDoF45OlzYu9Ss4yjc7E3dbCw==
X-Received: by 2002:a05:620a:662:b0:6f8:82a6:d6ea with SMTP id a2-20020a05620a066200b006f882a6d6eamr9891722qkh.133.1667237839071;
        Mon, 31 Oct 2022 10:37:19 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id bs6-20020a05620a470600b006b61b2cb1d2sm5098163qkb.46.2022.10.31.10.37.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 10:37:18 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id r3so14512355yba.5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 10:37:18 -0700 (PDT)
X-Received: by 2002:a25:bb02:0:b0:6ca:9345:b2ee with SMTP id
 z2-20020a25bb02000000b006ca9345b2eemr2660948ybg.362.1667237837692; Mon, 31
 Oct 2022 10:37:17 -0700 (PDT)
MIME-Version: 1.0
References: <20221031171307.2784981-1-jannh@google.com>
In-Reply-To: <20221031171307.2784981-1-jannh@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 31 Oct 2022 10:37:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=whgwb5oysYi_sTgzQjDPdg+DGH=VmfQk0o1EBrWOk+JRw@mail.gmail.com>
Message-ID: <CAHk-=whgwb5oysYi_sTgzQjDPdg+DGH=VmfQk0o1EBrWOk+JRw@mail.gmail.com>
Subject: Re: [PATCH] fs: add memory barrier in __fget_light()
To:     Jann Horn <jannh@google.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>
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

On Mon, Oct 31, 2022 at 10:13 AM Jann Horn <jannh@google.com> wrote:
>
> If this is too expensive on platforms like arm64, I guess the more
> performant alternative would be to add another flags field that tracks
> whether the fs_struct was ever shared and check that instead of the
> reference count in __fget_light().

No, the problem is that you should never use the "smp_*mb()" horrors
for any new code.

All the "smp_*mb()" things really are broken. Please consider them
legacy garbage. It was how people though about SMP memory ordering in
the bad old days.

So get with the 21st century, and instead replace the "atomic_read()"
with a "smp_load_acquire()".

Much better on sane architectures.

                           Linus
