Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2C06DA604
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 00:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239314AbjDFW5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 18:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236860AbjDFW5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 18:57:01 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1AC5594;
        Thu,  6 Apr 2023 15:56:56 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id i20so1105679ybg.10;
        Thu, 06 Apr 2023 15:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680821816; x=1683413816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iydX2LDnSRpjcKftCM/l6eMaLJRNEprfMAGYryJldYE=;
        b=MsjHecOL+RinSqZ2nVZCC0kquKL7puH8gezoQfl85lAIJKQxs5X0EmM34ScxeJt4PK
         WSK0QP6WEs3/KU5rfYaT1X9cwVtOlE0NDX6VEQEdn7pWd6l7vw6JnOlToLjwaTdPIgKH
         HjfTpHrPw4NU5/csi+6wVhU/zXZgzK/3geNMAUsPCZFEWGzuX9sO2HyHCXO43TvgT+SU
         D7NR7wAAFAR8WTIzI5BlNINcRL6y/+c6zc14C+wO5GLrIRBTLwAbs4Gg/P+IynkgYxIq
         wCvMUgwbub9Xp1Q3UnfatVjEkaCKfTaVmUN2tKc5IvcMTGfcB3kyXVv7onSf924BTfk0
         nVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680821816; x=1683413816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iydX2LDnSRpjcKftCM/l6eMaLJRNEprfMAGYryJldYE=;
        b=4vzyeVjUl2MEnbwybVQEgGDDWInBp+U+MmfzNecPanLvkJ7Y69rmTuwBo3YFlSaqhN
         Y5QPXedEyqjTrdx81WgNwk+MiC/56uiQMLq35lxdTi0AN6/Vyv8Ug9r6JwMC3gtlXSqU
         GmNhFpwhy7TMMy05wiCxFqkYjxDjGsZ989DywxKhrSVAxYh7LlGVj8aaHfuEEY5iTg8/
         k9wgAXVNDpHfG7j3pj9XV3P56e9zdp0pGYw5m9ilREMVyNHw57O3F/cfAEwn6NPYSDJP
         9EckvDWI8tWzDQP7Jb5MMHdhxKVJeFWaSUW6noLzpNaD4l+LdS0rRUHCAsyO09pOL3Ee
         RpQQ==
X-Gm-Message-State: AAQBX9cS9V4AiBtWl18q5kNzjI3zJESbSwFwIrnkI0tGRSL5XJXsYco6
        59fHzAPqqmfw8CwwTmBtxLm+k6JUWAZx51En5pA=
X-Google-Smtp-Source: AKy350Yl0xqUe387QVnMJ7raet/8Rc8kpaEmEsbsDn9PgMwtlUY60G6WBUTLXYA5TAc+OOnlMIUcVLJ1vG3nunkFGxw=
X-Received: by 2002:a25:dad3:0:b0:b77:e465:cb16 with SMTP id
 n202-20020a25dad3000000b00b77e465cb16mr633589ybf.11.1680821815912; Thu, 06
 Apr 2023 15:56:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230210152622.92912-1-andrea.righi@canonical.com>
In-Reply-To: <20230210152622.92912-1-andrea.righi@canonical.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 7 Apr 2023 00:56:45 +0200
Message-ID: <CANiq72=Ob56wF5D=fbR85nNn_t4KxRvxj2G5nVYko7M6ky4v6g@mail.gmail.com>
Subject: Re: [PATCH] rust: fix regexp in scripts/is_rust_module.sh
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        bjorn3_gh@protonmail.com, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 4:26=E2=80=AFPM Andrea Righi <andrea.righi@canonica=
l.com> wrote:
>
> nm can use "R" or "r" to show read-only data sections, but
> scripts/is_rust_module.sh can only recognize "r", so with some versions
> of binutils it can fail to detect if a module is a Rust module or not.

Applied to `rust-fixes`. Thanks!

Cheers,
Miguel
