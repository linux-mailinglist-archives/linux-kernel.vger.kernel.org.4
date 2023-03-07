Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172D06ADC84
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 11:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjCGK5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 05:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjCGK4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 05:56:42 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB37457D2C;
        Tue,  7 Mar 2023 02:56:41 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-536be69eadfso237928437b3.1;
        Tue, 07 Mar 2023 02:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678186601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPOHIY+gc8hcUU6SBmeBbgRx0IvK4FL5OmeKKmmeG0c=;
        b=PFdukvBPDDh0hDaR0PstyR2iC4hbrhIkphg1WMlxchabdYYe2Twc9ALPRctsDXh66a
         87KfbWOTKvcIGkhvH6+ML8X5Z+0VL4Es0451Qu370/K8u/mEc3WS/mCKa4OU3i2f5noE
         QFYnVm/1ePinq+SbMpDWAUnLgNQaqxkexF1yKa+XakdjqxmvgdquTy1/O7pcvSEQEZH+
         eh4k1B7/LNejIIEKKvwc0/7kXp46yNfUFFQ5NCYVeGdCbwtHF8vp1qqRTlcLQbPlkdrz
         7dkwWdOPL1rq+9esaqYlvvePBXVcWh+BQPTGsZxKMyNVxhZ58nriRWAsj0aVr8dkGzxH
         DN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678186601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bPOHIY+gc8hcUU6SBmeBbgRx0IvK4FL5OmeKKmmeG0c=;
        b=Xajgu1XRpdZrLD2DeLfDMAYvapJX7i/UeFpX9KshGGcfSJ4IyzBPzfzrxdGqJuNMM/
         GxEq3AasMioXwnU28U2m8L6vEWQqlEj0W/uz50ZzbphoxiUCkFBVuo81nav7IZWy2g5m
         ZYcvNrwqg7vTkyKvwUEUKvjRyMnGORa2ZtY5D/CfxWr6mYrOLM1oWaWMkeiiKhZO/mSs
         JwS5EERXQH4cIUPTfa2PK5+5vUcuQLAw0KLlXDit0z587aUtY1dxNj8og776RONWE9l+
         dBmK3fTXueVIUx/rAWDhOW8ZLrfIbZ7+gqONGBGZTgeZueN7C2ZF9s+4C43glh0m9QS5
         bhiw==
X-Gm-Message-State: AO0yUKUYiceNGxiheBU6I6hkAM0yQFSvD7be2PpJYwqKo7I3bu3JxPh1
        AXUPL1mDNC78po1wPkPk1YNWjdAc6upR1j0ZtlQ=
X-Google-Smtp-Source: AK7set/vZP5VgbdieRCGNt1P4MDgpVw9hkloznp6byCCn62NkrbtjZscaBSfnfsnnnnthyx3ZGOqFsywK3xzdXzGsPw=
X-Received: by 2002:a81:431e:0:b0:533:8080:16ee with SMTP id
 q30-20020a81431e000000b00533808016eemr9046679ywa.10.1678186601088; Tue, 07
 Mar 2023 02:56:41 -0800 (PST)
MIME-Version: 1.0
References: <20230307102441.94417-1-conor.dooley@microchip.com> <20230307102441.94417-3-conor.dooley@microchip.com>
In-Reply-To: <20230307102441.94417-3-conor.dooley@microchip.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 7 Mar 2023 11:56:30 +0100
Message-ID: <CANiq72nLjBgMSUTtWuF7qU5vG9rA3v=ekWk1d6+SNiGkfcaS8Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] RISC-V: enable building 64-bit kernels with rust support
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
> While adding RISC-V to the table, I took the chance to re-sort it
> alphabetically.

For reference, there is a patch for this coming at:

    https://lore.kernel.org/rust-for-linux/I0YeaNjTtc4Nh47ZLJfAs6rgfAc_QZxh=
ynNfz-GQKssVZ1S2UI_cTScCkp9-oX-hPYVcP3EfF7N0HMB9iAlm1FcvOJagnQoLeHtiW3bGCgM=
=3D@bamelis.dev/

Cheers,
Miguel
