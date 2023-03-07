Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0586ADD2A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 12:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjCGLWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 06:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjCGLV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 06:21:59 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418FB7D8C;
        Tue,  7 Mar 2023 03:21:58 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id t4so10983745ybg.11;
        Tue, 07 Mar 2023 03:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678188117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+6M7Rrz8d9sk58/G5zmHZtDU4PDW4DV0zcA0ptQ1Png=;
        b=UvPobudrKein15cSeOXHadW3ZwXyETu9tdRk/e0W67OcmbQVHqprMAqPs5BFbtRInN
         bMb0324eNAx+3ZRMjr0fYXKGBZ//61yIXN3o9Xz87LSxsjbWhsu+oDg0E6JsnjeENazR
         CZgdgsEndyjCgUTVtXV4OXqJ9POmLz7IwIanvZ4YrF91nK5YWyZjnaIO32evJzdmPd07
         pp4n5JdsJTv2tOXxrOaaZ4LdXFJwVLjcJV0mbdPq9cV385dnSujp9ht4BW9THOovXQO8
         iU7s9FaQ4pw1yIkqdjsnDZvp3YOrtzvlEg0GrliwRMC8uHJ/W6ibcE2v4OG0RdrEAKyk
         Rwvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678188117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+6M7Rrz8d9sk58/G5zmHZtDU4PDW4DV0zcA0ptQ1Png=;
        b=dOgS5he6N0pDv/yggWMSWBGYZy4gAexc6NUmfrtsC24BoKhMJOsPzGvLWtC0i+wChK
         RZCh2sJIEnn9pQMLZQkN2RKIv4wkm2YFJb1bGEXk6c1kCoZgbLXlMDmDcyHIwSgvXOVm
         L4CanNDLhV6jIjP9OTqBaLk4mZfOXIwOg+qmaoXvhXW9amWVMn0TgSnJ35ClJVx+Womz
         o5IJYtudSVN+1TKRwGrZHJFTsIp3VCsWRPx0T4hFozE3ifs+Bed9lf7S7z44zI9h+Mgl
         sKEl4U0EPvX6iljXydueQ4pgmzymBEkaNLNBNU6tmLi2As2wM/O1kUwXu4bjklYjgz0D
         NOVQ==
X-Gm-Message-State: AO0yUKUFRgUV7YCcTcChTLnhCSKJbtg84BcAtUNf48n6drCfKXx0YOL/
        vlV8j8RB6hlkTCjWfjnE2FfE5ZzT2Dz/1d9k0SQhVNXzlfhUrQ==
X-Google-Smtp-Source: AK7set9Xm/+t4RsbYIh8ZTtsG14e7fG27l8U4WG+CAhTtfNoZ/TFjDRHLzJOC1Pb6hQWIxMo+D0M4xfhEHmOcmY6vLs=
X-Received: by 2002:a5b:b03:0:b0:ad7:b81e:69bd with SMTP id
 z3-20020a5b0b03000000b00ad7b81e69bdmr6382804ybp.2.1678188117463; Tue, 07 Mar
 2023 03:21:57 -0800 (PST)
MIME-Version: 1.0
References: <20230307102441.94417-1-conor.dooley@microchip.com> <20230307102441.94417-2-conor.dooley@microchip.com>
In-Reply-To: <20230307102441.94417-2-conor.dooley@microchip.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 7 Mar 2023 12:21:46 +0100
Message-ID: <CANiq72mB5jXPuLy4mcYsa-q4yjHeryVWZrDf6wavvpj5FkwMOw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] scripts: generate_rust_target: enable building on RISC-V
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-riscv@lists.infradead.org, conor@kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, rust-for-linux@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
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

On Tue, Mar 7, 2023 at 11:25=E2=80=AFAM Conor Dooley <conor.dooley@microchi=
p.com> wrote:
>
> Despite removing 32-bit support, I kept the structure of the if
> statement, despite early return being stylistically preferred, for
> alignment with the Rust-for-Linux tree. I'm happy to respin to sort that
> out of desired.

This is a case of 2 "equal" sides to the branch (though at the moment
an error), so it sounds good, and it will mean a smaller diff later.

> +            panic!("32-bit RISC-V is an unsupported architecture")

Nit: if there is a v2, please add a semicolon to be consistent with
the others in the file (not sure which style we will go for, it looks
like `rustfmt` accepts both ways).

Cheers,
Miguel
