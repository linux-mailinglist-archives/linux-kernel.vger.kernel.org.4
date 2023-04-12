Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3EEE6DFF9F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 22:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjDLUX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 16:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjDLUXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 16:23:21 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA76A7DA5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 13:22:57 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id u13so13295446ybu.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 13:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681330977; x=1683922977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PgwjS6Tr4i1305yeX30DIlabH7TqwnvRJKw/s8cbqkI=;
        b=Xm+oLaLy2xX8U8M3214PtlhA3pWh+6m/xZ7SE7GRIwizo0thViCEKmE8fPlBFQ9G3p
         Hztwgts8VEscCrAsloNWb4fLv9+D74xec1d79hZVChGcAk33NydBAoUVkiYPRpWmxJuI
         L8XbeIvSa4EO+hMUKbHSi6E49wl6FZq7+dd6a+eB4GC2MIRGdSJEJMrHCQN4jD2FQdFr
         q9UupqcdO5LzGVxuSOFY2SahZmlT9PaBzL8csr8/oQFAbkb+L+bw6FunMFSct6Ssw3BV
         k/KrwVIswr4u5gtNbbBOIPx4b4dypSzrhc1Rdab8MUsS0s/HjiDiKIXQTNhKw8QFsEBy
         QLwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681330977; x=1683922977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PgwjS6Tr4i1305yeX30DIlabH7TqwnvRJKw/s8cbqkI=;
        b=U1KpfKV3io2v6Xoo9tnUHeyO6HccoycLhAgaqMftDzU1Ch0urDwDY0m9AZtjjEbzA8
         j2zRNJFgEMTXzGr1/lwo4uJYAFs8lvE0BdeM4oDqFLHvOqjT3WxVIJgjY5T5YR7PtUnZ
         huErK7U95uB0H/Qygktgp0bFV+hnrZsQDYma4J3vksQB9jQwNb5K2Nv+1dA9Hv63ucRg
         tsyrfSUWc4WPRSM4tA7XpgPJLBJRrwuqKR5cKFBxlYkikefeuuuzgfmtiOyVNblAjBdO
         KyRfIXIOO/qFqePUU6nAJqLQndrTP8ZZt+axqSwNzITZuv5u8/tpQ6hYKdEaLHlSBDEG
         UhvQ==
X-Gm-Message-State: AAQBX9dxzZRngTAO9sbj+Lgx/wmrF2GEE5FXZBBFGcOXpkWAp4pvN6BE
        SkOTl5WntvhM2W1afUoXyUPtnzdOWIrGMvBeFIc=
X-Google-Smtp-Source: AKy350YfoLyqtWzzli9vHTYdX013KqUtiC1U6d/03D/of28HrW6Se3PJdf29WJ92nMhtkEq1HTJZDmV6JX+LoQ8cWV4=
X-Received: by 2002:a25:d9d0:0:b0:b8f:350e:ccee with SMTP id
 q199-20020a25d9d0000000b00b8f350ecceemr2358222ybg.11.1681330976992; Wed, 12
 Apr 2023 13:22:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230412-no_stackp-v1-0-46a69b507a4b@google.com> <20230412-no_stackp-v1-1-46a69b507a4b@google.com>
In-Reply-To: <20230412-no_stackp-v1-1-46a69b507a4b@google.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 12 Apr 2023 22:22:46 +0200
Message-ID: <CANiq72moZqOWvSQ=updqMEVe1NggyAO-_iD6s0UMSL8HZF0mtQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] start_kernel: add no_stack_protector fn attr
To:     ndesaulniers@google.com
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 8:32=E2=80=AFPM <ndesaulniers@google.com> wrote:
>
>  include/linux/compiler_attributes.h | 12 ++++++++++++

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
