Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFDB697A7F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 12:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbjBOLPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 06:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjBOLPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 06:15:19 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D953A22A24;
        Wed, 15 Feb 2023 03:15:18 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id jg8so47359487ejc.6;
        Wed, 15 Feb 2023 03:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m+vt5/K3DfJh4TAbjzjKGmbIc8Of8qedTecbzcj/C/0=;
        b=pZZkNSG2MiTQJcMkT7oIUmc41sI2PcbiMB3LR3vTBY5qr1iBUnAM/i8dR9breBxjBG
         4eAF5cnSMwjaW5woJ+L3jrpV6WwAdwkFb/yCuvhU73Vko2m3Ea/5oMxr5m+9XQIQY7qd
         xy3GfJQhdEt1sYGPHMaUl0vYK31GxeFXX1SFxUxAC5bU0bhBJ6Uj6xAHqsMQ3//qRLt1
         3f8MplvYHWQb9r8Fs+GY5uCYRpiAlIa6fbb0VzJgqOwDxGRcMO2NjUdo+CN9TXQfrx12
         63tgGAEbTSobv5JSup/l0g+ApnIGAqSJJmX80a72R8B5CuSVPWenkhIbNZdi/9CMFcBk
         pUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m+vt5/K3DfJh4TAbjzjKGmbIc8Of8qedTecbzcj/C/0=;
        b=Aw2JyrQqnbRNjdPkDDD3Tb+iSOEglV9QtfsB2rBl4n1p0Rq/RTE0GAdAh8lyEKotPy
         CmLUxYpMEwYkPJYV8W6UnyGjsgit8NMB/R561dWtONClTarvE+pi3t0AUYsMglbq5H5q
         3eTZl+uuxhgzkE137a3VJs87ugHlvRYubAI6fomKHvkxbbcD4IceCqce68pYA8PVRDBj
         BX5YqTxPpyNmvJi9MGRULssuWsUOskkQsuddcI5lfwznDxWuip5OiHGXZAT8RhtfhI1h
         7TcXeabjiCRqhA13qMnhCSSzz/0j2HnPiuyOs+F1uUSDk0jIwysvz9mz8qDuieBB4XN4
         JfsQ==
X-Gm-Message-State: AO0yUKXAfeOq+ZzFo3u3XNlYcryHp1sUuGM675EfaJ5rx/ETy7nGEf7j
        qos/R4ViyPEehmBXijx7M8juIHvWByM=
X-Google-Smtp-Source: AK7set9qSNtQwFGoZ1OvCQKmecy/nxvuTic0dZWCKO2XYXtqMCes5T/kOIZsfVjCVfTcmz9W7R9Bkg==
X-Received: by 2002:a17:907:96a0:b0:8a4:7fb9:5656 with SMTP id hd32-20020a17090796a000b008a47fb95656mr2101551ejc.57.1676459717287;
        Wed, 15 Feb 2023 03:15:17 -0800 (PST)
Received: from gmail.com (1F2EF6B7.nat.pool.telekom.hu. [31.46.246.183])
        by smtp.gmail.com with ESMTPSA id q11-20020a1709066acb00b0088ee56fb24dsm9559072ejs.103.2023.02.15.03.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 03:15:16 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 15 Feb 2023 12:15:14 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Kim Phillips <kim.phillips@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: linux-next: manual merge of the tip tree with Linus' tree
Message-ID: <Y+y+wmxvDLaB1Suo@gmail.com>
References: <20230215120827.4780b588@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230215120827.4780b588@canb.auug.org.au>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> Today's linux-next merge of the tip tree got a conflict in:
> 
>   arch/x86/kernel/cpu/common.c
> 
> between commit:
> 
>   be8de49bea50 ("x86/speculation: Identify processors vulnerable to SMT RSB predictions")
> 
> from Linus' tree and commit:
> 
>   e7862eda309e ("x86/cpu: Support AMD Automatic IBRS")
> 
> from the tip tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc arch/x86/kernel/cpu/common.c
> index f3cc7699e1e1,38646f1b5f14..000000000000
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@@ -1403,14 -1412,6 +1414,9 @@@ static void __init cpu_set_bug_bits(str
>   			setup_force_cpu_bug(X86_BUG_RETBLEED);
>   	}
>   
> - 	if (cpu_has(c, X86_FEATURE_IBRS_ENHANCED) &&
> - 	    !cpu_matches(cpu_vuln_whitelist, NO_EIBRS_PBRSB) &&
> - 	    !(ia32_cap & ARCH_CAP_PBRSB_NO))
> - 		setup_force_cpu_bug(X86_BUG_EIBRS_PBRSB);
> - 
>  +	if (cpu_matches(cpu_vuln_blacklist, SMT_RSB))
>  +		setup_force_cpu_bug(X86_BUG_SMT_RSB);
>  +
>   	if (cpu_matches(cpu_vuln_whitelist, NO_MELTDOWN))
>   		return;

Looks good, thanks Stephen!

A similar resolution will show up in tomorrow's -next as well, via:

   e067248949e3 Merge branch 'linus' into x86/cpu, to resolve conflict

... so the conflict should go away in the next -next.

Thanks,

	Ingo
