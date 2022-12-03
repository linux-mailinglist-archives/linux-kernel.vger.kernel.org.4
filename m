Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340B7641360
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 03:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235028AbiLCC3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 21:29:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234949AbiLCC3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 21:29:08 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA53AE0761
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 18:29:07 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id h193so5815118pgc.10
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 18:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7cAXYlQ5VaMQ5BLk1aXMB0oGCT+qSAsSmGT0reRflQc=;
        b=Cw0UHv0K60H2AUe/OHjHGbe1/PIv2QHijwO47pCLQnR0Nr3P2+bbC8LJsVDbY+XouK
         NFoPxlyc2jdU2VQ+juROPfFypj8Jq05Y+bxXUKPbXsSeUNyBt5F1Bsw9gKeXm4yh9imA
         AV8acjj2rcjHaPGj3e4k1akRPlxsWHNY2D/M4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7cAXYlQ5VaMQ5BLk1aXMB0oGCT+qSAsSmGT0reRflQc=;
        b=iU4fERC/scFbo0f6FwQ12UfPYjbhnD7gJ5Vp2DxteAOcreThZKRBYHkjWslknNLC8E
         jEQrYZzG6QSRMwnxsFUoYTOZelI3VQ+NGnFc8GuuUiDLGs2o3cA/xmbU9E9lqXrHzc8O
         kPR7l9jz+zleS+YenLuQX11bIutnHUo29J1iRLRqBYPo/x/yOjVB8A4tlkaopg2UCEml
         LRxEz8Kk6VYVHLqF4KZ0PLkhlgOEvxNqVMiHseK3PyPwpiWUhZZzpCZXFFge7pwKOX/c
         xoEAZ+Alk0CCSskVaDufSwFmrHYP05g31/vIxf6SPP6aaLj1F/bZN5R95csVx9ZOdnmm
         HFtA==
X-Gm-Message-State: ANoB5pnOcbVv3e2bYxe8vvOcn/Y+JxE2ysnT0zVfGoVw33CG4tvNB9PS
        PUmij238hrE5ZYq5hprX8BLIDA==
X-Google-Smtp-Source: AA0mqf6/9F9eQhV2SemHnuT8JgDUMtDX9L2AtZ2rN4g6mPGyaYzfNzuVgwLmybGIQ8bH/RdTIzEP8g==
X-Received: by 2002:a63:4908:0:b0:477:e0b4:3f5 with SMTP id w8-20020a634908000000b00477e0b403f5mr34621298pga.265.1670034547107;
        Fri, 02 Dec 2022 18:29:07 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x27-20020aa7957b000000b0057534fcd895sm5716573pfq.108.2022.12.02.18.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 18:29:06 -0800 (PST)
Date:   Fri, 2 Dec 2022 18:29:05 -0800
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
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 08/39] x86/mm: Remove _PAGE_DIRTY from kernel RO pages
Message-ID: <202212021829.6BC87357@keescook>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
 <20221203003606.6838-9-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221203003606.6838-9-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 04:35:35PM -0800, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> New processors that support Shadow Stack regard Write=0,Dirty=1 PTEs as
> shadow stack pages.
> 
> In normal cases, it can be helpful to create Write=1 PTEs as also Dirty=1
> if HW dirty tracking is not needed, because if the Dirty bit is not already
> set the CPU has to set Dirty=1 when it the memory gets written to. This
> creates addiontal work for the CPU. So tradional wisdom was to simply set
> the Dirty bit whenever you didn't care about it. However, it was never
> really very helpful for read only kernel memory.
> 
> When CR4.CET=1 and IA32_S_CET.SH_STK_EN=1, some instructions can write to
> such supervisor memory. The kernel does not set IA32_S_CET.SH_STK_EN, so
> avoiding kernel Write=0,Dirty=1 memory is not strictly needed for any
> functional reason. But having Write=0,Dirty=1 kernel memory doesn't have
> any functional benefit either, so to reduce ambiguity between shadow stack
> and regular Write=0 pages, removed Dirty=1 from any kernel Write=0 PTEs.
> 
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
