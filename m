Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B1A6413A2
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 03:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235129AbiLCCm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 21:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234309AbiLCCmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 21:42:24 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3595EC08D
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 18:42:23 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id w129so6546423pfb.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 18:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=meefZluJRT8R1ZjwlCgxWmtfD4FhrgL7NrJdXoDBmDg=;
        b=MTgb8KAwPwhviwDCMgXJisTzBHivsq3T5iFl2j3sa72GQLKq316gETtxR6MxReMlP9
         OScIiVPvewVlAKwI9xxH1OoS70ozLjqj7rE3Yi6ELTKGwnUKk0manJYTzF7OpY/IWbYM
         YP28xqv0zglEeg8XLHPqcThJxDDXme/w/AILc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=meefZluJRT8R1ZjwlCgxWmtfD4FhrgL7NrJdXoDBmDg=;
        b=GJpBwpI3kM2l/WwjgognFxeTa0qR02oMWq9+UkAtCv+3AvPkKLc/rkefik27CFBmO5
         S4B3QAUFfPE4sPx3hiaXdIzN6aV2iCDsFbFjLVThRjkQ5towJdQewXCetHmm5o94nJEI
         Hcs6X6mh62YLY7qyvNDuZig1PcF11dZuTrq0qcp7hNJN6rOOA7H/b5oysWuN2K+C07Js
         bRZxpJCjIHNVWynnIMAtjxV3DIMBVzqGk0LwgJ/en+YxZ8taCOYfuF29YHT5n1pv+j8G
         fPngf7FKrLOfPQAENb+tI2pr/Gmkz1O8HEmiT8xX51K2USrLrF3Hhyh4x3srEpEY0npS
         9GqA==
X-Gm-Message-State: ANoB5pk/FiLx4B/I9s1JdmeudLdJl7U0rSH1drFJK+yGMBE/e4bC32cC
        qmYqYQcjDWznPLHceIVO7ttgwg==
X-Google-Smtp-Source: AA0mqf6nBAfJOSwwSZ437KK8J11H4vJ/7I2F5AOtpkwNBwwS77nrLl03wK13FIkg0xoppkHEZVitag==
X-Received: by 2002:a65:4c48:0:b0:478:24b4:1a7e with SMTP id l8-20020a654c48000000b0047824b41a7emr23581417pgr.516.1670035343071;
        Fri, 02 Dec 2022 18:42:23 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o13-20020a17090a0a0d00b0021896fa945asm7230803pjo.15.2022.12.02.18.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 18:42:22 -0800 (PST)
Date:   Fri, 2 Dec 2022 18:42:21 -0800
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
Subject: Re: [PATCH v4 25/39] x86: Introduce userspace API for shadow stack
Message-ID: <202212021842.28A81923A@keescook>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
 <20221203003606.6838-26-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221203003606.6838-26-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 04:35:52PM -0800, Rick Edgecombe wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> Add three new arch_prctl() handles:
> 
>  - ARCH_SHSTK_ENABLE/DISABLE enables or disables the specified
>    feature. Returns 0 on success or an error.
> 
>  - ARCH_SHSTK_LOCK prevents future disabling or enabling of the
>    specified feature. Returns 0 on success or an error
> 
> The features are handled per-thread and inherited over fork(2)/clone(2),
> but reset on exec().
> 
> This is preparation patch. It does not implement any features.
> 
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
