Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E72664CFB8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 19:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238845AbiLNSxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 13:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237887AbiLNSxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 13:53:00 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1230528E3C
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 10:52:57 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id f9so2596688pgf.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 10:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3OH5piqQgYs2HTpmjsVvlC/zkWvQoKtSKrvl3IZUHZQ=;
        b=bI1QN40VfMI5YffahIskXJ19TxDe1I9BCbHooK/Oq0RHU8deXnhE+Uzgfmwy9d4kI9
         4l5UD0lWzsJh0Wh1y5ViJkI5rntsqx9KWbjNYwh6ih7fissYH/mdaOxsJXfbTnXWqtob
         pvxkFzZ/YnE344PU68pGDiTSvnfzuCbQUByWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3OH5piqQgYs2HTpmjsVvlC/zkWvQoKtSKrvl3IZUHZQ=;
        b=iJpOGs5jh7VuxVvlw2EqLrixA0OG9Bw2NUqiw3z2W5jNhd6/ICGoN27saTHSBxv5fz
         xmeSv8W2nNGj3DOTQdBL51ftH9EnFvYRLqKm8YUtP8YgIxUgqa4oB0yzTU+eLlfD6pMO
         h7IBrwIZNcWnZymwR+vJK6EILcvXvvqbcq37P5P3l6aXzYGYeHgmu6bl5DO7CYNESpmY
         hhf2dg7W0PHhxkkTTB31AkQ4BAj6r1BDlaKFLU7LFK/iivXUdDPCnD/TH3RyMxyx0XYO
         IpVCcFjPsoAq9uM0U7EIsA9M4ksFJEI1vJV7kxZg0BVgdbV42d0lj+jXadN9ltfGZq2N
         AO6Q==
X-Gm-Message-State: ANoB5pmEMwda2D2kWCgDWsp5FrFw5vtTomn1kxdTdlVWkiF9EL/P/tiP
        DvXPdBDDqjpTnO3CwAlj/gYNLg==
X-Google-Smtp-Source: AA0mqf65AEZDaIMr5dElxYb0kE1PXzokNGbweS278MyeHeqmjC2k8jXN/Ezzt8ghTuysEsp3KngeHQ==
X-Received: by 2002:a62:3103:0:b0:576:14a4:b76a with SMTP id x3-20020a623103000000b0057614a4b76amr22717330pfx.34.1671043976432;
        Wed, 14 Dec 2022 10:52:56 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a2-20020a624d02000000b00576d4d69909sm228569pfb.8.2022.12.14.10.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 10:52:55 -0800 (PST)
Date:   Wed, 14 Dec 2022 10:52:54 -0800
From:   Kees Cook <keescook@chromium.org>
To:     jeffxu@chromium.org
Cc:     skhan@linuxfoundation.org, akpm@linux-foundation.org,
        dmitry.torokhov@gmail.com, dverkamp@chromium.org, hughd@google.com,
        jeffxu@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com,
        linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v7 2/6] selftests/memfd: add tests for F_SEAL_EXEC
Message-ID: <202212141052.3B04BF6@keescook>
References: <20221209160453.3246150-1-jeffxu@google.com>
 <20221209160453.3246150-3-jeffxu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209160453.3246150-3-jeffxu@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2022 at 04:04:49PM +0000, jeffxu@chromium.org wrote:
> From: Daniel Verkamp <dverkamp@chromium.org>
> 
> Basic tests to ensure that user/group/other execute bits cannot be
> changed after applying F_SEAL_EXEC to a memfd.
> 
> Signed-off-by: Daniel Verkamp <dverkamp@chromium.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
