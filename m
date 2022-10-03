Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B2A5F3539
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 20:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiJCSEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 14:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiJCSEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 14:04:32 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1B52F654
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 11:04:29 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 70so10539069pjo.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 11:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=/dv15tDc2ktB7BAbAEqIaqb+HPgnCrw6tzjaeXZYRdw=;
        b=Luxyct5ZDEAf+s4tZkbPi5QWvqscJMmjQmwgPzdkwonol+VoRlsiuiHoPDe6z649HT
         GdmX3uXicFJo82Sjaz8mQCGFSRAQfkLCvV3r9epbDHNd85DICH2NOHamMJ/YfINRznXm
         RCqqekGfOD/I6JxvPfwxxVlkhxNGcYPH6wMo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=/dv15tDc2ktB7BAbAEqIaqb+HPgnCrw6tzjaeXZYRdw=;
        b=mo+6+6F+vFoNJCUEM+rywHG+3USzUdO3rLPiLQMEulkE0qvpduMZS7hU7NY9hTdS4N
         zR3I/qOQu0B3Ie3VOFT24SLADc0lcfX39XaAZVFhEQEqBZ2PIfi61GmsaaPqvuZmX5H+
         jU/S1QknZrwdz6HioIxLw9EcxzzGFtWRc54M/gAGNiFSa4xL+3lnzlhZqDy5ZZIxr7BG
         zGe3Ph2U5AN0bKSrTslAoo0TWaGQW55fN8IEBtgWQLrf3L+XPzdJjIfA9UyCSV647u0R
         Iamq2J9sx/866g4v76QYIfS+1efh9pNhY8YOTzCnMXzui6v2uprdJ047g/misV0VuwZv
         syng==
X-Gm-Message-State: ACrzQf0p3KiPNuSxeNajviO+JOKQWwXOUs07WI+x9Cie8z5j2vYm4+dO
        p8DCVdarh4c1Nt1kcPilRcuicA==
X-Google-Smtp-Source: AMsMyM6vXQUnWXKFrzPL+QjSqkQ4PdOl+MhVlYguyVb6m/Z7eQkFgOnTSODHgfVf3aBpQ6ydA6TL9g==
X-Received: by 2002:a17:90b:1a81:b0:20a:71e5:728d with SMTP id ng1-20020a17090b1a8100b0020a71e5728dmr12719181pjb.107.1664820269511;
        Mon, 03 Oct 2022 11:04:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g8-20020a17090a4b0800b0020a61d0e4eesm5470654pjh.30.2022.10.03.11.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 11:04:28 -0700 (PDT)
Date:   Mon, 3 Oct 2022 11:04:27 -0700
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
        jamorris@linux.microsoft.com, dethoma@microsoft.com,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [PATCH v2 07/39] x86/cet: Add user control-protection fault
 handler
Message-ID: <202210031055.62E60F6BBE@keescook>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-8-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929222936.14584-8-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 03:29:04PM -0700, Rick Edgecombe wrote:
> [...]
> -#ifdef CONFIG_X86_KERNEL_IBT
> +#if defined(CONFIG_X86_KERNEL_IBT) || defined(CONFIG_X86_SHADOW_STACK)

This pattern is repeated several times. Perhaps there needs to be a
CONFIG_X86_CET to make this more readable? Really just a style question.

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index b68eb75887b8..6cb52616e0cf 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1836,6 +1836,11 @@ config CC_HAS_IBT
 		  (CC_IS_CLANG && CLANG_VERSION >= 140000)) && \
 		  $(as-instr,endbr64)
 
+config X86_CET
+	def_bool n
+	help
+	  CET features are enabled (IBT and/or Shadow Stack)
+
 config X86_KERNEL_IBT
 	prompt "Indirect Branch Tracking"
 	bool
@@ -1843,6 +1848,7 @@ config X86_KERNEL_IBT
 	# https://github.com/llvm/llvm-project/commit/9d7001eba9c4cb311e03cd8cdc231f9e579f2d0f
 	depends on !LD_IS_LLD || LLD_VERSION >= 140000
 	select OBJTOOL
+	select X86_CET
 	help
 	  Build the kernel with support for Indirect Branch Tracking, a
 	  hardware support course-grain forward-edge Control Flow Integrity
@@ -1945,6 +1951,7 @@ config X86_SHADOW_STACK
 	def_bool n
 	depends on ARCH_HAS_SHADOW_STACK
 	select ARCH_USES_HIGH_VMA_FLAGS
+	select X86_CET
 	help
 	  Shadow Stack protection is a hardware feature that detects function
 	  return address corruption. Today the kernel's support is limited to

> [...]
> +#if defined(CONFIG_X86_KERNEL_IBT) || defined(CONFIG_X86_SHADOW_STACK)
> +DEFINE_IDTENTRY_ERRORCODE(exc_control_protection)
> +{
> +	if (!cpu_feature_enabled(X86_FEATURE_IBT) &&
> +	    !cpu_feature_enabled(X86_FEATURE_SHSTK)) {
> +		pr_err("Unexpected #CP\n");
> +		BUG();
> +	}

I second Kirill's question here. This seems an entirely survivable
(but highly unexpected) state. I think this whole "if" could just be
replaced with:

	WARN_ON_ONCE(!cpu_feature_enabled(X86_FEATURE_IBT) &&
		     !cpu_feature_enabled(X86_FEATURE_SHSTK),
		     "Unexpected #CP\n");

Otherwise this looks good to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
