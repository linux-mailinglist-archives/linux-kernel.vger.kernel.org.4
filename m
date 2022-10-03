Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC4C5F34D3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 19:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiJCRsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 13:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiJCRse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 13:48:34 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365F21EEDF
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 10:48:31 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 3so10285576pga.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 10:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=8KcKcFPOC4l2l7q42vPtJKHACw1c6U1nHGwLuGCBrtI=;
        b=eCxjnyQOC/p1XVcFTERWKX6VM2qsqYEBiy6ZNqGj67YBhAcuNUJLAn1LuZIvNA9fnl
         kMd+iRRosWbdU4NzBsEG0JfMY6/8OZ0SGnlMISNEkwUW4jjshZ9GBf6Kh5BSUk696tgE
         pSS254Hjf3opl3nYRXMoWVe2gizlUf04qvkiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=8KcKcFPOC4l2l7q42vPtJKHACw1c6U1nHGwLuGCBrtI=;
        b=qYkaX3ZoPlY9WKFjKc13964HRb+3wGGF5fWkIeRsNquGHvMVqww3910Tm7eSkRkt6X
         gtR5215btqbvqNrLx4Lw/s9W2AfcB/BjLfIPXPC6vWpzpDnCW1IFWBs2/TJUUb15YKlQ
         Q5p3c7v2pDZgWR9HcoAkEDorXMLOK0Swu0+1HPE7YbyCXDaLqMUxJi9hJrMNi01cW9cq
         11P0iRTm/Kib4pPlc95OePCgtjKvn4JG5Gm2hsB417B111bA/dCwlVFj2eQie+ALFy+/
         wH/tcNkhvzZNSu6/KNmEqrriwlINNGQcorLQmfB2/PvA5/MEcBlpR3IfXkCUIjlvSfH3
         znOw==
X-Gm-Message-State: ACrzQf3ixCD5W8RtiKgYDgK+auHKNgApTJEFlJ0b2/PKVVNNmdy0nzwW
        vbjfA8nD17L++So3AmEnWeAOzQ==
X-Google-Smtp-Source: AMsMyM7Lm/wmn3oK24rB8YaBVMCA71BQS5OYYHpaHSkv2uoRxqUJpCd3c5KJNJ2p8z+/tEUEYWoAzA==
X-Received: by 2002:a05:6a00:2141:b0:561:8552:3eb9 with SMTP id o1-20020a056a00214100b0056185523eb9mr4182300pfk.65.1664819310719;
        Mon, 03 Oct 2022 10:48:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y135-20020a62ce8d000000b0055f811897d8sm5403435pfg.73.2022.10.03.10.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 10:48:30 -0700 (PDT)
Date:   Mon, 3 Oct 2022 10:48:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com, rppt@kernel.org,
        jamorris@linux.microsoft.com, dethoma@microsoft.com
Subject: Re: [PATCH v2 06/39] x86/fpu: Add helper for modifying xstate
Message-ID: <202210031045.419F7DB396@keescook>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-7-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929222936.14584-7-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 03:29:03PM -0700, Rick Edgecombe wrote:
> Just like user xfeatures, supervisor xfeatures can be active in the
> registers or present in the task FPU buffer. If the registers are
> active, the registers can be modified directly. If the registers are
> not active, the modification must be performed on the task FPU buffer.
> 
> When the state is not active, the kernel could perform modifications
> directly to the buffer. But in order for it to do that, it needs
> to know where in the buffer the specific state it wants to modify is
> located. Doing this is not robust against optimizations that compact
> the FPU buffer, as each access would require computing where in the
> buffer it is.
> 
> The easiest way to modify supervisor xfeature data is to force restore
> the registers and write directly to the MSRs. Often times this is just fine
> anyway as the registers need to be restored before returning to userspace.
> Do this for now, leaving buffer writing optimizations for the future.

Just for my own clarity, does this mean lock/load _needs_ to happen
before MSR access, or is it just a convenient place to do it? From later
patches it seems it's a requirement during MSR access, which might be a
good idea to detail here. It answers the question "when is this function
needed?"

> 
> Add a new function fpregs_lock_and_load() that can simultaneously call
> fpregs_lock() and do this restore. Also perform some extra sanity
> checks in this function since this will be used in non-fpu focused code.

Nit: this is called "fpu_lock_and_load" in the patch itself.

> 
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
