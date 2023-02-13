Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6562F694B8F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjBMPq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjBMPqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:46:24 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB761E2A2;
        Mon, 13 Feb 2023 07:45:56 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id s203so9763473ybc.11;
        Mon, 13 Feb 2023 07:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rWSszm8aZB3aUFiYSjOVCVw6a/Ka6EAvUjYk9G4QlIY=;
        b=KHq6MeRggkI73FuZyGP5IiqEoBu4yxiJvMp2pJABimlh9y3e64Xu+Vdr6qe01FK58u
         HktPG5IU6v8lg6GKgdADWnKsMbg1AQwzlFpQArU2N4MvFYZlnmQeUdrx+LmHPFWfFqKR
         hx6zxn1RbFmcvofvmCvdlHCP1af0F6KLAqNEga9HyRv/YqxoNaxvcsjRS3obeXSZRrO9
         +eiYmTqP1kvYnk60fbDpAS88084I6whWoWwb4MhyHfQb4DJLSSs9wHSF0ZnzboZbniTb
         aIhA0g0MDh5jyFPSPLMuHafhNhGq2+wLsso2BqguUfPV1JuiXWXp9MFHkrpgSzpxezzj
         JHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rWSszm8aZB3aUFiYSjOVCVw6a/Ka6EAvUjYk9G4QlIY=;
        b=rMSvZH3z3Yf2m3huQXZqJV4Gj+Ej4lFV+uFI2NAlmJt20kytXxopYf0eog6ymGMLZO
         T/K1Mm7T91DmcCv9CwjSAM+HVyy9PzLaiyFQqJDMASe5PIXJBOWVoLA39o4LHMOWZxJu
         9fZyUzlyCcmsIlVh9vP2Vqnis08uht0yxoMJ47/ipMGNdc/KUkx/U3lJ3NV+oei/h7Dt
         ij6TDSZ30blnBY4sZjmQbwhsbdy+SDFkBhOZQaSA8u7Ers/xFds46yVjHHIMIHbeOHsw
         jSbeXtx0OuMMpnt6fwNGgawT1AtbVKNnkEsCJ7FojcUBin2yJZDUje0OFV++a+W5mt2P
         Co6A==
X-Gm-Message-State: AO0yUKUr5jMTESUEMvWbJuskchHSewvS+2b1t3mZSAoM8F2LomFvRKc8
        OYna1opJeYgKyMoGPREqoxmnjGScbqNeAfyxAzY=
X-Google-Smtp-Source: AK7set/HrxcQGA8VLrEvrjbsJArtIo7cQ6vUU7FxOsHB8P0S77yN0e0nWBnmi8Tc98W/uJ7AhNb7pVLrAEgTa8Qr7xk=
X-Received: by 2002:a5b:d4e:0:b0:91d:685c:bd3b with SMTP id
 f14-20020a5b0d4e000000b0091d685cbd3bmr423631ybr.25.1676303155863; Mon, 13 Feb
 2023 07:45:55 -0800 (PST)
MIME-Version: 1.0
References: <20230210152622.92912-1-andrea.righi@canonical.com>
 <CANiq72=FZtNmYvbb-YPHmQ=bm8rH8VO3M9nemT4i03g9A2PD2Q@mail.gmail.com> <Y+pQsfNiLkspVIK2@righiandr-XPS-13-7390>
In-Reply-To: <Y+pQsfNiLkspVIK2@righiandr-XPS-13-7390>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 13 Feb 2023 16:45:44 +0100
Message-ID: <CANiq72=4iAkBFoibwdmBe2FoYr+M=RqWrYbUK3q4+CYffbZNmA@mail.gmail.com>
Subject: Re: [PATCH] rust: fix regexp in scripts/is_rust_module.sh
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Eric Curtin <ecurtin@redhat.com>, Daniel Xu <dxu@dxuuu.xyz>,
        Martin Reboredo <yakoyoku@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        bjorn3_gh@protonmail.com, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Mon, Feb 13, 2023 at 4:01 PM Andrea Righi <andrea.righi@canonical.com> wrote:
>
> In this way both C and Rust modules can be loaded correctly (at least in
> my tests I'm able load both with CONFIG_DEBUG_INFO_BTF enabled).
>
> I haven't dropped the "RUST depends on !DEBUG_INFO_BTF" yet, but I think
> with this fix is applied we can relax this constraint.

Yeah, but the constraint was there for other reasons, so I got
surprised when I read that in the commit message.

Apparently, Martin cannot load the modules
(https://lore.kernel.org/rust-for-linux/20230213151339.661225-1-yakoyoku@gmail.com/),
but you can.

Cheers,
Miguel
