Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5AF743170
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 02:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbjF3AIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 20:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbjF3AIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 20:08:06 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E38E4B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 17:08:05 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-991da766865so153008266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 17:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688083684; x=1690675684;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qObUezpKEChN6EJPRpioTlFXu5Gh0veDoFYzvMKfmR4=;
        b=Bc84eEQ2+y4NQ5C40Js2f4YqMQL7aivir7yrXZSExgRu4FGBrgpMemNxm/gU5nOqeQ
         XfncxH+dXvNcjQIJJ2TrV2P0kEhIPiqWRYQ5UjKMFxI9KpYqfw0jfZAYiVqpY/52pa6H
         QFfI1sPfvAKbuniqZ6EeWjrk4Jrj3YE6gRGrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688083684; x=1690675684;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qObUezpKEChN6EJPRpioTlFXu5Gh0veDoFYzvMKfmR4=;
        b=DDAM0ky2gui1xr2B8dHnpD+s/rUiCNKhaHtBIgv/f/3OeIoWGtEY/CmkH2lyZ4vgEJ
         f/FukDh1evbE8RXifYQfxhHZopBAi2oPoCLtqK0D6NoLcJhbiAesdN7JaDOqEOgld24s
         qSFwz5WsH/y9vYiudTjJyec3DK7BizIfmSPKF8nxBJx4EBFf0IkSyA/T6T0EUYD9EmtL
         FWvuJ35xrkFcQzHBKweQZ0hhdBOPoSOW6h7P2noYx2ZgM0NlSdM11nYArLxC6qG5lf0u
         92Us2AIahI3i0cxd1gQ9JnTY9j2Cb8gZC/99v3aKB9AuM8l0DVnbx0J4wqiqhsLHpG8Y
         dA5g==
X-Gm-Message-State: ABy/qLZyyFaQqKZbwbW38jQfNRtvf39G41kkZNQI1cJDxFvsLyPIpGQm
        KMam7b45XW49qrQdT2KRyUeKFydF2sKZjY7+zltCMj6i
X-Google-Smtp-Source: APBJJlEmqQlSjnqLq8UC7xZHa75Yg0Mv5Los1SYgb1l4Ij4xfKpr/qNUI1Ejtkh/rz4Ccy4Qlf/HQg==
X-Received: by 2002:a17:906:4a91:b0:988:9856:9bef with SMTP id x17-20020a1709064a9100b0098898569befmr666279eju.30.1688083684041;
        Thu, 29 Jun 2023 17:08:04 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id n19-20020a170906841300b00988d0ad4477sm7374324ejx.29.2023.06.29.17.08.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 17:08:03 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-51d7e8dd118so1451012a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 17:08:03 -0700 (PDT)
X-Received: by 2002:aa7:d585:0:b0:51a:3159:53c7 with SMTP id
 r5-20020aa7d585000000b0051a315953c7mr441085edq.30.1688083683177; Thu, 29 Jun
 2023 17:08:03 -0700 (PDT)
MIME-Version: 1.0
References: <ZJxZJDUDs1ry84Rc@work>
In-Reply-To: <ZJxZJDUDs1ry84Rc@work>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Jun 2023 17:07:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg6oH=LanEa6Dz5LTjHqO+UUOor=rpKCfS90aiAWAUJ1A@mail.gmail.com>
Message-ID: <CAHk-=wg6oH=LanEa6Dz5LTjHqO+UUOor=rpKCfS90aiAWAUJ1A@mail.gmail.com>
Subject: Re: [GIT PULL] flexible-array transformations for 6.5-rc1
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2023 at 08:59, Gustavo A. R. Silva <gustavoars@kernel.org> wrote:
>
> Please, pull the following patches that transform zero-length and
> one-element arrays into C99 flexible-array members. These patches
> have been baking in linux-next for a while.

This must stop.

Honestly, this is just making things *WORSE*.

That drivers/media/platform/qcom/venus/hfi_cmds.h needs to be
converted all-or-nothing, not this crazy piece-meal conversion effort.

You literally seem to be converting structure definitions that ARE NOT
USED, and then leaving the ones that actually *are* used alone,
because they have uses like

    struct hfi_sys_set_resource_pkt {
    ..
        u32 resource_data[1];
    };

                pkt->hdr.size += sizeof(*res) - sizeof(u32);

where 'res' is a pointer to that packet type.

I'm not at all interested in patches that convert structures that have
zero use. You might as well just *remove* them in that case, rather
than make some syntactic change that doesn't matter.

And yes, that header file already has a mix of '[]' arrays and '[1]'
arrays. I'm not interested in continuing that kind of pointless
conversion.

Either this gets converted properly, or it gets left alone. No more of
this kind of crazy "let's convert the types that are never used".

            Linus
