Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E5A6A1D2F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 15:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjBXOBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 09:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjBXOBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 09:01:22 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F7963A03;
        Fri, 24 Feb 2023 06:01:21 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id n27-20020a4ad63b000000b005252709efdbso539250oon.4;
        Fri, 24 Feb 2023 06:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cD2V3GFxUMbiUHqwfuQz30DRd9uey95Pb5f4mqZNz5Q=;
        b=nSQHhui9wzPmOzXMr5aqMMdc/emCD2VEKeowVCo0NrHkcplyLtFZoJHoJSFkK4z40b
         1Y5bsQqiIwdR5gofZEF35EK9avASKH36E5ex9cJE5wk26qczgQcR+g0acFXnTiiKDgxR
         PvZla0biMrFKQWZUiXoGS6VgkiqBzncTWilDH6zjbE0U2SVw1hG4kbL7ENtszZEjBb05
         qptC3JWIkQCUlwk/JXL6N42MpRNrK4D9ejBf0Lzca0apISJPaVzxW40XxUIt1LW/qq0f
         4QDj1rzPaIjMHxDN33OwyQKN9iTS0IxjFl1iPOh6pz4OLI/4YSXCYDPmBLAYfvu1N4S0
         XtLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cD2V3GFxUMbiUHqwfuQz30DRd9uey95Pb5f4mqZNz5Q=;
        b=LCdynrcJKOI/qgwW3xIIVbinJgVRSNcF4a6tj9X0ZpQqzYPblaxl9nyTG25KlpEhX7
         z2s+dEJclcrZPa+9AXBAXeR8CIzRDRT6twQ4pVwgzUBZiW43zvltKtxZ1W00rDkA46z3
         pZVClP5gVVPGWFeqxa3dPhXv3pkzDlXWRh6ZH6XpCzTPwevuAgF9SsxPGo8gr87/NBYT
         ZywL8bt4gj9r3f0Uk9EBSBgvqQlW8mNkWjCM7Fj/ZL7MDWi/o+IWBmhAFoGOGUpe3JjG
         hTzfpxXlN++qRiY1MA/fO5fSJS4cOPRN3E0FrBSqVtajRU6KvKcA8mUbKu4K6MCa0+Rh
         4/ZQ==
X-Gm-Message-State: AO0yUKV2/pvL0tyZBOAAbNPoVb0wqLHiDY20CvgVdZb+G4FCNIiS3U3k
        0zNKC64YFs4+KTk0Pt3NfPs=
X-Google-Smtp-Source: AK7set98zYboFrn/b4D2MBfz+3WRgRRGr0dXxRlba6lrQpOjcTAlP8smsxqbzioF9NIua3JNmHd9sg==
X-Received: by 2002:a05:6820:61f:b0:51f:e2ab:5535 with SMTP id e31-20020a056820061f00b0051fe2ab5535mr8142396oow.0.1677247280363;
        Fri, 24 Feb 2023 06:01:20 -0800 (PST)
Received: from tx3000mach.io (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id v14-20020a9d604e000000b0068bbf5f2e49sm4505958otj.37.2023.02.24.06.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 06:01:19 -0800 (PST)
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
To:     lina@asahilina.net
Cc:     alex.gaynor@gmail.com, asahi@lists.linux.dev,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, gary@garyguo.net,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        masahiroy@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
        nicolas@fjasle.eu, ojeda@kernel.org,
        rust-for-linux@vger.kernel.org, wedsonaf@gmail.com
Subject: Re: [PATCH] rust: Enable the new_uninit feature for kernel and driver crates
Date:   Fri, 24 Feb 2023 11:01:13 -0300
Message-Id: <20230224140113.745953-1-yakoyoku@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230224-rust-new_uninit-v1-1-c951443d9e26@asahilina.net>
References: <20230224-rust-new_uninit-v1-1-c951443d9e26@asahilina.net>
MIME-Version: 1.0
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

On Fri, Feb 24, 2023 at 05:09:47PM +0900, Asahi Lina wrote:=0D
> The unstable new_uninit feature enables various library APIs to create=0D
> uninitialized containers, such as `Box::assume_init()`. This is=0D
> necessary to build abstractions that directly initialize memory at the=0D
> target location, instead of doing copies through the stack.=0D
> =0D
> Will be used by the DRM scheduler abstraction in the kernel crate, and=0D
> by field-wise initialization (e.g. using `place!()` or a future=0D
> replacement macro which may itself live in `kernel`) in driver crates.=0D
=0D
Very useful to me as some constructors in the USB bindings that I'm=0D
writting might make use of unitialized memory.=0D
=0D
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>=0D
