Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6E774F490
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 18:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbjGKQMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 12:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232879AbjGKQMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 12:12:10 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAE219BB
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 09:11:58 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b89114266dso44140905ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 09:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689091918; x=1691683918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gKlyg81WY1Ahyf8Z4TEgmZZoIPC/F0LheVwd7/XJwxg=;
        b=S9a3gHgP1uCjVZRBcpWoA1CLnj31G1NCAYspUTQ+H7udjIiIX0cy/WdxDAqk1tml3A
         ofwTLdI2VrgN1TAonv2cA/FSKRtmo0lrllh0eXaG0HqZRH1gd61D+FrdMIc337ulTwDf
         EKqDyh0l5QbJTqNQUegbtz33egnXVJNgEwvd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689091918; x=1691683918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gKlyg81WY1Ahyf8Z4TEgmZZoIPC/F0LheVwd7/XJwxg=;
        b=NNOeYKGU5lq5kUCVS1WGr05HoVtRsQADA80+KJ/EMYIU6d5NONAfaKaNQAMudj+KGs
         pP8FVRpgYHSX7l1WuNR9/BizhvhwUU8hMIw4EwYM7y0UE6nedFIdehV63O3ghO/NcJH/
         j9xlW8EAcTlfnZpJBerkGcusNCn6LjDWY3CiTYwP82tD6AJXNjtafQMhHICO/HhCigDd
         NyQZk/mFy3FPC6+77AzojyTOIzxhacjMuyY78iQR8oIJUIeJkyRtDbQqVvBKCWP/FfyN
         GFK5ybmLzsiB6MZqsGEpm17K9cOSU2iqO4moNGe8TBEqTwbY1E0cyYL0yAM6qHzuO3mM
         UDFg==
X-Gm-Message-State: ABy/qLbpsZuqOsKuLs8fCc7tF7HlV6n5sFcNzfUIxBmingEdw8ZEP1x6
        hAgL7cThhGmVu8zDaVEJACFUXw==
X-Google-Smtp-Source: APBJJlEUrtENyInsVOCTeanHUkQu6UdS5LjzN+KXc76SyB1fRhX8h+uTrQ0omTebC3KsSHxKHBmohA==
X-Received: by 2002:a17:902:a509:b0:1b8:76ce:9d91 with SMTP id s9-20020a170902a50900b001b876ce9d91mr14470522plq.1.1689091917989;
        Tue, 11 Jul 2023 09:11:57 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902ee8900b001b6674b6140sm2102562pld.290.2023.07.11.09.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 09:11:57 -0700 (PDT)
Date:   Tue, 11 Jul 2023 09:11:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: fix bindgen build error with UBSAN_BOUNDS_STRICT
Message-ID: <202307110911.D0E735849@keescook>
References: <20230711071914.133946-1-andrea.righi@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711071914.133946-1-andrea.righi@canonical.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 09:19:14AM +0200, Andrea Righi wrote:
> With commit 2d47c6956ab3 ("ubsan: Tighten UBSAN_BOUNDS on GCC") if
> CONFIG_UBSAN is enabled and gcc supports -fsanitize=bounds-strict, we
> can trigger the following build error due to bindgen lacking support for
> this additional build option:
> 
>    BINDGEN rust/bindings/bindings_generated.rs
>  error: unsupported argument 'bounds-strict' to option '-fsanitize='
> 
> Fix by adding -fsanitize=bounds-strict to the list of skipped gcc flags
> for bindgen.
> 
> Fixes: 2d47c6956ab3 ("ubsan: Tighten UBSAN_BOUNDS on GCC")
> Signed-off-by: Andrea Righi <andrea.righi@canonical.com>

Thanks for catching this!

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
