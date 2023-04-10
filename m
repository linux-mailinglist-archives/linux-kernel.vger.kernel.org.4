Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB086DC305
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 05:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjDJDr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 23:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjDJDrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 23:47:55 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F66E68;
        Sun,  9 Apr 2023 20:47:54 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id y69so10362367ybe.2;
        Sun, 09 Apr 2023 20:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681098473; x=1683690473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hl6Ldr2ffJls2zPrC5MBUC142PJZp6NGW4lSlfYrLXo=;
        b=ksvDpJOqSnK4D9i61295t8pix74Twg9CUAER6KKwgaw88XWTXMopY0cDxvrPBazEOE
         wDPov8tkV2qdZBkehRdGO8sBF86F0qlA2EA0HqV761wbJvCjZ/6uK49gMm2ib8PFsnNy
         3pazCUXTICAEL+Z3B3/Z9ESZiZIHUTyEyNLsg9iKfbiPkBfbAZbqJClyZ1kUzdtX/nUt
         i+qIhMt0P0I2/MlSB4cOIgpYwHlWk83+y2z8EbqgzJXKIaRCIBYaEuRtWYWFzqERxwLJ
         BXobngkak/04YJCo4/57fReySCxvDwcY6kAV/e6UVqOaWzmoNfPoTDT2eSRPuDn9bAAp
         gd5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681098473; x=1683690473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hl6Ldr2ffJls2zPrC5MBUC142PJZp6NGW4lSlfYrLXo=;
        b=brCSB/XOo2wN/+hnUx7yuCycBGy87aj7WcUKhIYwy9SMu0KIDSA4UTzNrG8dYLWKXi
         UW8d9BkGNECJvoKCWkvGh/kYw9/3gHrhiOpVQrlvohI+DJWZhSzn8mVK0UgjfrgGuIrH
         48wbDAWwiNVqUnaGAmu/0NYhc2eoq314HHaOD+J0coE2Veu/3rz92upMNGqJVzNcKJwr
         i+ZPFahZ1wcWAsY4QLT3WvuzhUH+BrLjJbxMlBKuIxz3yFsVfvDGiKnlN25/XNWIkyO3
         y8+/6uzL5/anCbUj8Ufyxeg8lKrMu9DjkA251MQz6ltQ6XtfOTdsCiAFy6LPt9CJMYuI
         2bwg==
X-Gm-Message-State: AAQBX9e8yB3Gq+v/WS/MQBMdz05wjUsOmmxQDMZyACHpua6WfSZYdVqT
        7e77XwLV3iAIEceAWjgIFXRHa47K5k0zHE0RSQo=
X-Google-Smtp-Source: AKy350adDkkKnqOW4IGrkQPJIh22w8D9fGmOFWzJSCxBaRnkc8GB5Q1maI+xS6wpp75pqDl+eMIkiQqUgTNVD4ZsXqY=
X-Received: by 2002:a25:50d1:0:b0:b6b:d3f3:45af with SMTP id
 e200-20020a2550d1000000b00b6bd3f345afmr8883100ybb.1.1681098473651; Sun, 09
 Apr 2023 20:47:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230224-rust-arc-v2-0-5c97a865b276@asahilina.net>
In-Reply-To: <20230224-rust-arc-v2-0-5c97a865b276@asahilina.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 10 Apr 2023 05:47:42 +0200
Message-ID: <CANiq72=XwyK=EgFOU1jqMCFcoyjUc63WSu498ZhKVAg5CBaV7g@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] rust: sync: Arc: Any downcasting and assume_init()
To:     Asahi Lina <lina@asahilina.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Benno Lossin <y86-dev@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev
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

On Mon, Apr 3, 2023 at 12:01=E2=80=AFPM Asahi Lina <lina@asahilina.net> wro=
te:
>
> Hi everyone,
>
> This short series is part of the set of dependencies for the drm/asahi
> Apple M1/M2 GPU driver.
>
> The two patches simply add two missing features to the kernel Arc
> implementation which are present in the Rust std version: `Any`
> downcasting and `assume_init()`.

Applied to `rust-next`. Thanks!

Cheers,
Miguel
