Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52788729E6D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 17:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbjFIP1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 11:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241869AbjFIP0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:26:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D58A3C11
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 08:26:24 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686324382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=97eIlmVHHiXKUyciMmtc/hv+PsyVp2v+mcQ37Qjk6dU=;
        b=e+Iiazwjdi0sSxQOkSd63xWdxVQpwfjV8PlWhPv5HyrT7kfAquJkI8QAFEI7ZU+bv9Jfjq
        k128Ic2mKAGIbPBAl9jAhGdHuOnW70t/711Y25HHD4Jz6AuRgOW/v13To1nVq50f3scVVL
        F8zCFCM8w+d0Az32OpuNuWudCDJbi/oFzh+WZDxjtelrYD7GtTTJiR/ZlfwO49NjRI3u/M
        Nn0crU6QRv+LrPq0OnJdtt7nJ5U7ue/lcC2xKzyCHDiPH/KHEhjm1PeSBsJtmqCpEx6DoB
        Ewf8MM4b6vshkW/XvNaU5X0NEwIQ8IfMUFziyZFXuUbyZRcJZAPCSZZblWFFuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686324382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=97eIlmVHHiXKUyciMmtc/hv+PsyVp2v+mcQ37Qjk6dU=;
        b=1GDIMJG5h0PhIqh4dL5/8yYRO5/HJLJPSR5lFrxvRuupX0B8QfLyZYdkj9lJDoFoQKJQKW
        1V52IvTSK0YWo2Bg==
To:     Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.com, jslaby@suse.cz,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [PATCH v2 4/4] x86: Disable laoding 32bit processes if
 ia32_disabled is true
In-Reply-To: <20230609111311.4110901-5-nik.borisov@suse.com>
References: <20230609111311.4110901-1-nik.borisov@suse.com>
 <20230609111311.4110901-5-nik.borisov@suse.com>
Date:   Fri, 09 Jun 2023 17:26:21 +0200
Message-ID: <87bkhoirmq.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09 2023 at 14:13, Nikolay Borisov wrote:
> diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
> index 18fd06f7936a..0fa49388ff16 100644
> --- a/arch/x86/include/asm/elf.h
> +++ b/arch/x86/include/asm/elf.h
> @@ -148,9 +148,16 @@ do {						\
>  #define elf_check_arch(x)			\
>  	((x)->e_machine == EM_X86_64)
>  
> +#ifdef CONFIG_IA32_EMULATION
> +extern bool ia32_disabled;
>  #define compat_elf_check_arch(x)					 \

   1) Your keyboard clearly has a broken newline key.

   2) Why is there still a duplicated declaration?

   3) This #ifdeffery is not needed if this is done right.

Thanks,

        tglx
