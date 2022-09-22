Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE1D5E59A3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 05:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiIVDd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 23:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIVDdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 23:33:55 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF8A9A9EB
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 20:33:54 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id bh13so7912263pgb.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 20:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=XNbtSxfuJM0TvCbKrDSFlGazSHd4nOQHgC+9b6ylUe4=;
        b=JLTH01KnBgmnNcpiE4BaxPSMUmiRK1wixqi2R2fDvpYZ7mbFuWVA+eCMwV9Ooy7Y2R
         Woa8XpodShi3pnIGGNpgTJfitVebcLwCm8c/U0JiK4sHYFoOL+kb1m3bgvOAeN7Z7r0W
         00Y2KF+MivPazWmmeeTVy/Yh2IAp+53XXFWOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=XNbtSxfuJM0TvCbKrDSFlGazSHd4nOQHgC+9b6ylUe4=;
        b=qIHEy5uEaH7UvkQGL8UpSjNT4UpSO9czD1c2BY+fCrefT7M0YOAvo15pOfvOJWCTsA
         GnoYx+/Q0FTtyFeWUmweGFH42oIzj0Un9n4YLLgnulmkJnFNHxD8XARCiiAKDmrEbnwy
         DNNwxX0Hn+ItIK2mY6QynfBy+Hmf6DteeMU77jh/In2UZ7GP4DTIv82iYZVANJjhA2w3
         4x+kTfx69+rjGxlYYvMU7o3902hkqNS6oUFzTFlE7a3Mr3VscFEGgewEyr/oYIeaqTn7
         Bc7i/pMURlXeo46MtbWACohoumntCvmUfYoO3CI7i3W6eNYjDvgM3b4YfQK8FG8pAL3I
         HHZA==
X-Gm-Message-State: ACrzQf0VzneUsJvnzpvJFl7VGFSUk4Da02e8WZHOWCT7bBoFIOwg8QIl
        ZWt+m8ZCAe9H2ppAEdrVZGFBCA==
X-Google-Smtp-Source: AMsMyM7tC1MtDvRJS7cc5qSCv8s84GqWYuQca9GUuvaL53zNqSZvZvxuvVucuuBYn6cgvQqhY2zIhQ==
X-Received: by 2002:a05:6a00:1889:b0:540:acee:29e4 with SMTP id x9-20020a056a00188900b00540acee29e4mr1550769pfh.49.1663817633640;
        Wed, 21 Sep 2022 20:33:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u9-20020a170902bf4900b00176ca089a7csm2754925pls.165.2022.09.21.20.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 20:33:53 -0700 (PDT)
Date:   Wed, 21 Sep 2022 20:33:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Siddhesh Poyarekar <siddhesh@gotplt.org>
Cc:     linux-hardening@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] fortify: Use __builtin_dynamic_object_size() when
 available
Message-ID: <202209212032.5F392F42@keescook>
References: <20220920192202.190793-1-keescook@chromium.org>
 <20220920192202.190793-5-keescook@chromium.org>
 <9d80e0a3-3fcc-0676-4529-79743f418557@gotplt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d80e0a3-3fcc-0676-4529-79743f418557@gotplt.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 07:43:17AM -0400, Siddhesh Poyarekar wrote:
> On 2022-09-20 15:22, Kees Cook wrote:
> > Since the commits starting with c37495d6254c ("slab: add __alloc_size
> > attributes for better bounds checking"), the compilers have runtime
> > allocation size hints available in some places. This was immediately
> > available to CONFIG_UBSAN_BOUNDS, but CONFIG_FORTIFY_SOURCE needed
> > updating to explicitly make use the hints via the associated
> > __builtin_dynamic_object_size() helper. Detect and use the builtin when
> > it is available, increasing the accuracy of the mitigation. When runtime
> > sizes are not available, __builtin_dynamic_object_size() falls back to
> > __builtin_object_size(), leaving the existing bounds checking unchanged.
> 
> I don't know yet what the overhead is for __builtin_dynamic_object_size vs
> __builtin_object_size, were you able to measure it somehow for the kernel?
> If there's a significant tradeoff, it may make sense to provide a user
> override.

So far I've not seen any measurable performance difference, but I just
may not be creative enough yet.

So far, the tunable is building a kernel with or without FORTIFY_SOURCE
and UBSAN_BOUNDS. :)

-- 
Kees Cook
