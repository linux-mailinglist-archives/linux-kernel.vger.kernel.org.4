Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26620641354
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 03:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235126AbiLCCZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 21:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234892AbiLCCZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 21:25:27 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6EEBDCE2
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 18:25:26 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id q1so5807814pgl.11
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 18:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qe3Kot75P0ehlOAWJ+W2KaYDqgt2hyWIV3bO0GRxNwM=;
        b=QWQVuu2sfyBztLQQwqQPFN02JvATwjtE5qID6YEDN+72UodsQlyHEPyGRaWgZFRTTR
         uRnWK+9DpdqcQ25oen3icozFeCSxWxy6xZiD+z7PSYoGKo04INcqhg2+kviq+7In2pJR
         YEAqcsASnvC7DF9yDgA3BOfeKmOiA1tv+CaRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qe3Kot75P0ehlOAWJ+W2KaYDqgt2hyWIV3bO0GRxNwM=;
        b=aJ23nkKhgV7OhDkNsiWy4C8IqXa4ByZUq2wDcPlRhVw/cFu/CTm2WCjEHdsa+v1qpe
         8ocxNzX6o2aB/ipY30yZtDP/34a8c/JKY8VACDQf6/ynluAQjd5mivPlNwiQcBr1YqO8
         vQkWaZmrTpExvf1Rc0Z0X6sQo5aw4Jle4RIiqD3mqjV8JLJd2Rps4HwpgzbpE0MBCovB
         avX1g24LAp5MIzBZGoOn9mF1AqtAQ92nBM6joddTgXghq0Co3pSJxsBQmaFSjiR/8aW5
         BE8OV09vyLUf5wapqDCP8vW+S4IGN2ajyKF2/lEMWNBp8pbhMQ8btLoVKvEatiDCRuC5
         VKKQ==
X-Gm-Message-State: ANoB5pmsMMabw4GLAkQDc2svvN5S7WhRLcNM6U5jSdhnt77K+3vq5B8x
        43P6ixiCxDbc4oyhU3TWxrFcPA==
X-Google-Smtp-Source: AA0mqf4jgpifGJAXMClGoBCX78UAFNY/rPQyAwu9YUGBBvgEisZM5G6+77aK1xBoA4eCWNPz1o8blQ==
X-Received: by 2002:a63:d946:0:b0:477:af25:38c8 with SMTP id e6-20020a63d946000000b00477af2538c8mr45480936pgj.392.1670034326231;
        Fri, 02 Dec 2022 18:25:26 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 127-20020a620485000000b00576670cc16dsm1843999pfe.197.2022.12.02.18.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 18:25:25 -0800 (PST)
Date:   Fri, 2 Dec 2022 18:25:25 -0800
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
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com
Subject: Re: [PATCH v4 06/39] x86/fpu: Add helper for modifying xstate
Message-ID: <202212021825.4A1B632FD@keescook>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
 <20221203003606.6838-7-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221203003606.6838-7-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 04:35:33PM -0800, Rick Edgecombe wrote:
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
> 
> Add a new function fpregs_lock_and_load() that can simultaneously call
> fpregs_lock() and do this restore. Also perform some extra sanity
> checks in this function since this will be used in non-fpu focused code.
> 
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
