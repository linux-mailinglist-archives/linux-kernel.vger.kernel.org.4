Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4809A747BE9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 05:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjGEDvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 23:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjGEDvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 23:51:06 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7065110FE
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 20:51:03 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fb94b1423eso9432429e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 20:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1688529061; x=1691121061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A7koUXTGnXZ2BN6z2esFRUBwMxdqNEeh2TLixxqJrG4=;
        b=OSqKEasXz+D9ihlXJxO0mUy6ubDPxeEKZuYFwWcv1krSfchWaAhS7DeDkLUx0QA1Nf
         Wcu+k24HmcXRRG4dk9tQLpIwPIu3uEjdR4nJ2/Bj76VhFoiO915GQtOijA6CpWMCQua2
         MGgf0fW4Y4QtDrv5sGIQnQBhQOaU8yWqO6kaG6X45nVOR753xmJYRC+Dkn0FO76gECQs
         qPFITbMHuDEsdbTfMcFUcHa2dRKWgfCIVllgI+0TGN7lZDNHOQVyYsH4+/5XqyeDBimG
         SUj6MOo6AiAD/D0foDLc5eKOc66iLEEIWux9Jcs5ACm39DbQ1IYsvBpH4CjGGGzcDBOY
         S0QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688529061; x=1691121061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A7koUXTGnXZ2BN6z2esFRUBwMxdqNEeh2TLixxqJrG4=;
        b=V1BmUDugZecX+ojCywbYkWfvSwM+dEA0vOXVpUde6oIA0XmP/v0lP7hjNkA5RRqXi4
         i1pMI6jh0y0wGtH1O3x7Hj18NtZLZ7BHhlIcqb79kx61B3Sc4r8ORDC3UzSprtcy1Gfs
         YwD5LifBfnWexaI+prHeJeGcD6Cg+4aFCueONMxWtoH9Njhjyiwh28DpVtJIa2Z9aTAs
         +i3ffDMoxWhHnj0/NcJ3JXZmp5dYzEU7H56ZxzB5V4b4OoYl/mzWCDXdwHe1RTpLgsH/
         777EWoNNZBbiQ3D5N+A0ay9TPIGEulaPyLsSm6x45PTLZYbNCTyG3Cxh8KTyrk0F01Q3
         iQKQ==
X-Gm-Message-State: ABy/qLbmDG0fiKZYQzf1Ul2lLx0NFp7P5y3/wpLBELAal3BD5SAFlNmg
        1ojOhP/wUjXJsL26OQ0nDTUNu4hCaj8OdYuEU/vlyQ==
X-Google-Smtp-Source: APBJJlHOM2IZLucodj6HWgJHAsB+Q18K78EMjq0nn1drMe8tDHTaxF7UR7y9aWMrYrf3Z94KyBGdBYidCGb6JPA1epY=
X-Received: by 2002:a05:6512:3e10:b0:4fb:7bbf:daae with SMTP id
 i16-20020a0565123e1000b004fb7bbfdaaemr12214586lfv.64.1688529061686; Tue, 04
 Jul 2023 20:51:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230629142228.1125715-1-bjorn@kernel.org>
In-Reply-To: <20230629142228.1125715-1-bjorn@kernel.org>
From:   Andy Chiu <andy.chiu@sifive.com>
Date:   Wed, 5 Jul 2023 11:50:50 +0800
Message-ID: <CABgGipVO35+CZUioxn2jFD8mFjVup84GRJXGQQ8wx4urjc0Y+Q@mail.gmail.com>
Subject: Re: [PATCH v4] riscv: Discard vector state on syscalls
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux@rivosinc.com,
        Palmer Dabbelt <palmer@rivosinc.com>,
        =?UTF-8?Q?R=C3=A9mi_Denis=2DCourmont?= <remi@remlab.net>,
        Darius Rad <darius@bluespec.com>,
        Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 10:22=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kerne=
l.org> wrote:
>
> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>
> The RISC-V vector specification states:
>   Executing a system call causes all caller-saved vector registers
>   (v0-v31, vl, vtype) and vstart to become unspecified.
>
> The vector registers are set to all 1s, vill is set (invalid), and the
> vector status is set to Dirty.
>
> That way we can prevent userspace from accidentally relying on the
> stated save.
>
> R=C3=A9mi pointed out [1] that writing to the registers might be
> superfluous, and setting vill is sufficient.
>
> Link: https://lore.kernel.org/linux-riscv/12784326.9UPPK3MAeB@basile.reml=
ab.net/ # [1]
> Suggested-by: Darius Rad <darius@bluespec.com>
> Suggested-by: Palmer Dabbelt <palmer@rivosinc.com>
> Suggested-by: R=C3=A9mi Denis-Courmont <remi@remlab.net>
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

Thanks,
Reviewed-by: Andy Chiu <andy.chiu@sifive.com>
