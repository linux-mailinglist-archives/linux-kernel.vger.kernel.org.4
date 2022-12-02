Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0705E6410C6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 23:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbiLBWlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 17:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234389AbiLBWlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 17:41:40 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C94BF116A
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 14:41:40 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id 140so6202668pfz.6
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 14:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RPMshK7tVLl5Lle8RoOXHHhv2DXWHlF2R9uHvQRM5Bc=;
        b=merJ+GaoyeIA1krzJpTvcAlWx2q4jrDPmzZsBdSBPsN2auuRted+2l9PmyqmnDRjMX
         GwKijFgomVRFjyD8dqtOB/DijExpw/+dFZMDUTxIDeqZC76u/xiWq5r9t0vylHKYxY8l
         Z7ETLvpzXA2XcSSwRDWGOCSWe5grGDPrOZI9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RPMshK7tVLl5Lle8RoOXHHhv2DXWHlF2R9uHvQRM5Bc=;
        b=yiSzrOg5NshSxXMJGN7ZRHhG5GsDTuHpMhz0qhNM4jsF5yldGL1XAWDdp2oYIs3nc+
         NCRqPpABgTXhZt+aXPod9okJMopsYpYRXoVoQCD6tnRFLUqbDtWIl9D0t6fQIceRqzBV
         LLrL1O9hFNGd6Q6K5Eu79cT7RLmuFsF65ad9weoBJnUDr1kpfoOOB2U/2J/SzpdZVebt
         g1GnQroxsB+oM1sFOF25UouTbMpH6SyA3P3fANsQk8/CroZfbp65T14rw8ZKHsyeNE56
         aIxt7eWR4h2KPej73EyJDc0HkFWGDIQUyJ2psOSWCCVln2S7I/DfeL7T0tl8ywehFf+d
         geFg==
X-Gm-Message-State: ANoB5plgG9PY6+NxjGvy5Ljxz6gb7ekwn3XZkxWu5iqrcvdfNYagJezl
        +cLXBnieJ9EUrde+39ijPk/u7g==
X-Google-Smtp-Source: AA0mqf4SuLL8KvtdI3fAxn2zB2XRgbdM9yw+U277XBIdZDVunRVgl+uywFPSqtnji0ZuzQi358w7CQ==
X-Received: by 2002:aa7:810e:0:b0:56b:f23a:7854 with SMTP id b14-20020aa7810e000000b0056bf23a7854mr59505812pfi.66.1670020899834;
        Fri, 02 Dec 2022 14:41:39 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z20-20020a63c054000000b00439c6a4e1ccsm4475973pgi.62.2022.12.02.14.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 14:41:39 -0800 (PST)
Date:   Fri, 2 Dec 2022 14:41:38 -0800
From:   Kees Cook <keescook@chromium.org>
To:     jeffxu@chromium.org
Cc:     skhan@linuxfoundation.org, akpm@linux-foundation.org,
        dmitry.torokhov@gmail.com, dverkamp@chromium.org, hughd@google.com,
        jeffxu@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, mnissler@chromium.org, jannh@google.com,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] mm/memfd: MFD_NOEXEC_SEAL and MFD_EXEC
Message-ID: <202212021437.C1FCD63D@keescook>
References: <20221202013404.163143-1-jeffxu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202013404.163143-1-jeffxu@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 01:33:58AM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>

Hi! Thanks for this update! For future versions, please also use "-n"
with "git format-patch" so the patches are numbered, otherwise it's more
difficult to figure out what order they should be applied in, etc.

-- 
Kees Cook
