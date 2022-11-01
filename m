Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19DB6155EA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 00:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbiKAXI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 19:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbiKAXIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 19:08:09 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B930920F6F
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 16:06:14 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id i3so14799519pfc.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 16:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XPbyEQQBk73Ni0h1h30fs6y6Ff39h2pLPwf6IGZm/XU=;
        b=eUptdhlUsvV6f6+h66eOG5r0izRulrLvkJ5ys7OCQD/MHQs5xN6d6LVLU3v2yxx4CR
         raSVpGmGBR51oXmx9pkSq8GN45s+bvJYMB8GYdxFRTlJL1yujWq5juUIeiJcJUWwkSQz
         2/xal7WVL9cZlY4jIns8zQ4LgzzbZdBp7YoPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XPbyEQQBk73Ni0h1h30fs6y6Ff39h2pLPwf6IGZm/XU=;
        b=N46S/hO3uMYXVZnSzbya9r8wPvk0tSQ5/Vwt69qbaNrVQ4npuIBuFQ742EkbnzPqKx
         ARCfH938t0BVEnCnL2lZvBUCrnZ67ZEEzS27791mwdkyfF2owUt0nzLfx9LTcsZS7b/U
         OwSERGPKzvjA9Ko71cURFlJW9JYbjZ0AUBZXWPQcWV0rXp5lMWBZ3CRJe1S0mWtOpnyH
         kMjQe30m6PwEzJZFlJ2trdPyY6tUTXJX2rIfM8qXFtPJYpXuDM6JGWua9JhCrQVM7NDi
         AsJBL4MIduiYW7rETK4zglJOdNrPkAj288nmASBVVO5f9qLG5rQrDq1YyNDe6jQkh4/w
         s5nw==
X-Gm-Message-State: ACrzQf3gycQz423WejulS84V8L2ewP+U3p8vQoFhpmsiG4j9taURI60g
        vduDgIxT34QeK4HrZi1FWfQkXw==
X-Google-Smtp-Source: AMsMyM7KcPBNktfAVOVyJfxO7PvzhGbnCFsHqvVrZlIhrLio7l35KizVH52ERAEGwnHFBBN97GItsQ==
X-Received: by 2002:a63:ec51:0:b0:46f:ed8d:7089 with SMTP id r17-20020a63ec51000000b0046fed8d7089mr4658386pgj.469.1667343973773;
        Tue, 01 Nov 2022 16:06:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h29-20020a63121d000000b004388ba7e5a9sm6344238pgl.49.2022.11.01.16.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 16:06:13 -0700 (PDT)
Date:   Tue, 1 Nov 2022 16:06:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc:     arnd@kernel.org, mauro.chehab@linux.intel.com,
        tvrtko.ursulin@linux.intel.com, airlied@linux.ie, trix@redhat.com,
        dlatypov@google.com, llvm@lists.linux.dev, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        gustavoars@kernel.org, nathan@kernel.org,
        linux-sparse@vger.kernel.org, linux-hardening@vger.kernel.org,
        rodrigo.vivi@intel.com, mchehab@kernel.org,
        intel-gfx@lists.freedesktop.org, luc.vanoostenryck@gmail.com,
        vitor@massaru.org
Subject: Re: [PATCH v5] overflow: Introduce overflows_type() and
 castable_to_type()
Message-ID: <202211011605.2D8C927C2@keescook>
References: <20220926191109.1803094-1-keescook@chromium.org>
 <20221024201125.1416422-1-gwan-gyeong.mun@intel.com>
 <ffcfb7ce-7646-c827-8d29-7c41e4b121d6@intel.com>
 <202210290029.3CD089A86C@keescook>
 <850085e1-e420-b6eb-104d-15694a400bb7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <850085e1-e420-b6eb-104d-15694a400bb7@intel.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2022 at 11:01:38AM +0300, Gwan-gyeong Mun wrote:
> 
> 
> On 10/29/22 10:32 AM, Kees Cook wrote:
> > On Sat, Oct 29, 2022 at 08:55:43AM +0300, Gwan-gyeong Mun wrote:
> > > Hi Kees,
> > 
> > Hi! :)
> > 
> > > I've updated to v5 with the last comment of Nathan.
> > > Could you please kindly review what more is needed as we move forward with
> > > this patch?
> > 
> > It looks fine to me -- I assume it'll go via the drm tree? Would you
> > rather I carry the non-drm changes in my tree instead?
> > 
> Hi!
> Yes, I think it would be better to run this patch on your tree.
> this patch moves the macro of i915 to overflows.h and modifies one part of
> drm's driver code, but I think this part can be easily applied when merging
> into the drm tree.

I've rebased it to the hardening tree, and it should appear in -next
shortly:

https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=for-next/hardening&id=5904fcb776d0b518be96bca43f258db90f26ba9a

-- 
Kees Cook
