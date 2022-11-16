Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733C962CDB7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 23:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234491AbiKPWb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 17:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234579AbiKPWbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 17:31:51 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17494FFB9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 14:31:50 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id q71so249610pgq.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 14:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FuowNGPTACp89J8qJBsAOfot0OBx9v/djIM9nHRJfM0=;
        b=L+ZZ6NdarAtX/vYxChdinzB3DR8s1GMqb9vfjK+lwHitmNITGnnTAHFjISUk6z2lZU
         H5+Foj/v9lPRInp7nTbLsf7VLYmgjH0Qih6bEo3heWm8bEqzUTMUuh0IuHpEhQxznhRN
         1vS4W8FGntxzz7SGyuVu1nErMhL+Ewop110ns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FuowNGPTACp89J8qJBsAOfot0OBx9v/djIM9nHRJfM0=;
        b=dN18veZb3n7ZBAMcelJt71xeZ73uo4BMCpnqUXfOCbnyTBjMXFDFlA4c/wgz7f5EdP
         RmkW9yapLACCKW2dgbmFhA80Yhvr/GAIRQvcdM+uNs2yoLf8yNdx8FWj0jQyfCSXYAVp
         vQgG3UKq4/qj0NJfjbo1eQIdzMkIFhToG0lNkmT+lxc8oYF1Nms7Ctv/ZdsebdrGCDHu
         2uWCAIsTMxVwYcxXWRe9ID6cBxLdoWNNmDuBwz6Q8iIpg3tdsh7PMhrBIEeVk8WDL/KF
         Tj6iS7Aqb52afr/SCb756z+WDUxVY9Em3z9i2xCBtdgXf8A4INjK4uMqqpDVJLo9mxpT
         GE/w==
X-Gm-Message-State: ANoB5pmxF/yDAO0kZHN4WAqYNNM0Wqz0teZ1OrHJRfEIeb8n44384aFb
        vkjnfut0hyXfGT7LAKnrmqEI4BTHspDeag==
X-Google-Smtp-Source: AA0mqf4NMJEoRIPLpgpdOPkP++IiFc7kQxgLSVi6uRK6NnNTDN/5GhXmiNS+e3r3I25QRBRl5UYjLA==
X-Received: by 2002:a05:6a00:11:b0:56c:a2f1:2783 with SMTP id h17-20020a056a00001100b0056ca2f12783mr196141pfk.7.1668637910309;
        Wed, 16 Nov 2022 14:31:50 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d12-20020a630e0c000000b00470537b9b0asm10286020pgl.51.2022.11.16.14.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 14:31:49 -0800 (PST)
Date:   Wed, 16 Nov 2022 14:31:49 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] lkdtm: Avoid objtool/ibt warning
Message-ID: <202211161431.FF6F3BB867@keescook>
References: <202211142027.0E3ISIZr-lkp@intel.com>
 <Y3JdgbXRV0MNZ+9h@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3JdgbXRV0MNZ+9h@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 04:23:45PM +0100, Peter Zijlstra wrote:
> On Mon, Nov 14, 2022 at 08:26:17PM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   094226ad94f471a9f19e8f8e7140a09c2625abaa
> > commit: 656d054e0a15ec327bd82801ccd58201e59f6896 jump_label,noinstr: Avoid instrumentation for JUMP_LABEL=n builds
> > date:   6 months ago
> > config: x86_64-buildonly-randconfig-r001-20221114
> > compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
> > reproduce (this is a W=1 build):
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=656d054e0a15ec327bd82801ccd58201e59f6896
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout 656d054e0a15ec327bd82801ccd58201e59f6896
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
> 
> 
> > >> vmlinux.o: warning: objtool: lkdtm_UNSET_SMEP+0x1c3: relocation to !ENDBR: native_write_cr4+0x41
> 
> ---
> Subject: lkdtm: Avoid objtool/ibt warning
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Mon Nov 14 16:17:50 CET 2022
> 
> For certain configs objtool will complain like:
> 
>   vmlinux.o: warning: objtool: lkdtm_UNSET_SMEP+0x1c3: relocation to !ENDBR: native_write_cr4+0x41
> 
> What happens is that GCC optimizes the loop:
> 
> 	insn = (unsigned char *)native_write_cr4;
> 	for (i = 0; i < MOV_CR4_DEPTH; i++)
> 
> to read something like:
> 
> 	for (insn = (unsigned char *)native_write_cr4;
> 	     insn < (unsigned char *)native_write_cr4 + MOV_CR4_DEPTH;
> 	     insn++)
> 
> Which then obviously generates the text reference
> native_write_cr4+041. Since none of this is a fast path, simply
> confuse GCC enough to inhibit this optimization.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: Kees Cook <keescook@chromium.org>

Please feel free to carry this, or forward it to Greg KH.

-Kees

> ---
>  drivers/misc/lkdtm/bugs.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- a/drivers/misc/lkdtm/bugs.c
> +++ b/drivers/misc/lkdtm/bugs.c
> @@ -487,6 +487,7 @@ static void lkdtm_UNSET_SMEP(void)
>  	 * the cr4 writing instruction.
>  	 */
>  	insn = (unsigned char *)native_write_cr4;
> +	OPTIMIZER_HIDE_VAR(insn);
>  	for (i = 0; i < MOV_CR4_DEPTH; i++) {
>  		/* mov %rdi, %cr4 */
>  		if (insn[i] == 0x0f && insn[i+1] == 0x22 && insn[i+2] == 0xe7)

-- 
Kees Cook
