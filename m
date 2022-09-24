Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E3B5E8850
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 06:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbiIXE0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 00:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233180AbiIXE0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 00:26:39 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EB5A573F
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 21:26:38 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d11so1800107pll.8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 21:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=+d6hVTxyK8h4syV8bWCDMumA1KF1NKBl16cP5xB5blQ=;
        b=mu45f2py6D+MaOBfrTsq8dALBCwdJT9FEmBKzwIt5TAuz5vPBKIaFBwl/V5eyau9ho
         kqhvQ+HVodXe54dDW7Q5NnIhaEJDCl5m7DumA89WmTnl+8zLRkTHpDbHOhzuXfWM+q2c
         DgWz4rFv8ggCcI8ql0AKzPI/GVGfku7Y9LyrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=+d6hVTxyK8h4syV8bWCDMumA1KF1NKBl16cP5xB5blQ=;
        b=5/zvQAhjsAYnSFCbfzf9rvSu0aCbYcQhcUS1DkpBPUfcXG+qVKZgetjvCfTtf+dF86
         zk2ft+9yoj0MfCL3WmmWcd61dLk+2jPV4OSsIYAfA3mYbqp2oG5DYSfkzE1OLixXGt48
         vkHauXp7RFx/grdpLqRex54ShPZ/p2zCxGPgoXTD3AIXRzDPyPnuP0FPLxhWI24OVenP
         ZSgmASbzKaFMT1dPUu5CoQFrWhpPvmRRCt2WdPWbsY3eu4i4UCoQi68Uk+P9uiKkvUt6
         BMvvAKzsh0qqZcsgnmYegOkyOqC6CQQTo8QM3ErO3WrlrzTW8JgUk3xc+CzZyhDLoJf+
         W3Pg==
X-Gm-Message-State: ACrzQf3e/WceFlqypR7NnamDLuInRTbRC/JL5UfAL/e7V+a9dIzbrm7i
        ix/yl0KXFNp5+DqGCN3AS3jGhA==
X-Google-Smtp-Source: AMsMyM7DY4mKhiHNLEWjdaJtEycqS/oeTw07plUcB55yd7zbaNMsi4y7YgqHxrZASOB7Q4kdwM1eRg==
X-Received: by 2002:a17:90b:3b47:b0:202:d9d4:23f7 with SMTP id ot7-20020a17090b3b4700b00202d9d423f7mr24636557pjb.56.1663993597694;
        Fri, 23 Sep 2022 21:26:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f13-20020a170902ce8d00b0017894903949sm6888536plg.157.2022.09.23.21.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 21:26:37 -0700 (PDT)
Date:   Fri, 23 Sep 2022 21:26:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-efi@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/mm: Disable W^X detection and enforcement on 32-bit
Message-ID: <202209232126.64AA2AC570@keescook>
References: <20220923221730.1860518-1-dave.hansen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923221730.1860518-1-dave.hansen@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 03:17:30PM -0700, Dave Hansen wrote:
> The 32-bit code is in a weird spot.  Some 32-bit builds (non-PAE) do not
> even have NX support.  Even PAE builds that support NX have to contend
> with things like EFI data and code mixed in the same pages where W+X
> is unavoidable.
> 
> The folks still running X86_32=y kernels are unlikely to care much about
> NX.  That combined with the fundamental inability fix _all_ of the W+X
> things means this code had little value on X86_32=y.  Disable the checks.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
