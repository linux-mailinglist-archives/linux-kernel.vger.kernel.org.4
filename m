Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6370D70087E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 14:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240484AbjELMxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 08:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240097AbjELMxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 08:53:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982BB14E44
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 05:52:38 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683895950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q1Qnr6qOh5XLwLTUnA7hAJyWDHMXCkJRQnSY5Vv2iFI=;
        b=RLKM1irkA/S6PX5pgp00KghEnw1PJxlRcdAqv7K9iRiuwO9abG66QLIqqEINhLfB18ejov
        kmjTGbzivVDl/RcY/qZgTOniOrSmDYZNTVXI/RQ/CtI9toNONXIjndW0s8Qikn4DKJeCM4
        wMjs6CEDpOc82EwvqNA+0jy7S2c/jnB0md2Gi+ThyDAMFHaQWA9bEKYKMZzEv+I0EuUpdD
        Q6aarvkxQr3T6DKtUpG642NKXHsntlJ0ey2qXoARgh117e8KdqD/vmRQcAa5H75JHfHgYc
        LTcGYGHsqm2MsX1vljRhXV46X0M+uuLqdQ6cHyMpU4Tgq5vhRWbRiWqJ4GvCJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683895950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q1Qnr6qOh5XLwLTUnA7hAJyWDHMXCkJRQnSY5Vv2iFI=;
        b=BPEF2auQlKPvkeFlI6HKQG5cpnsOSyIpScFOUchyabKoijX+U/82lP2gWW5meqoOjAtSCm
        E9Sln1sGHvRY/ZBg==
To:     Adamos Ttofari <attofari@amazon.de>
Cc:     attofari@amazon.de, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Kyle Huey <me@kylehuey.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86: fpu: Keep xfd_state always in sync with
 MSR_IA32_XFD
In-Reply-To: <20230512113900.56393-1-attofari@amazon.de>
References: <20230511152818.13839-1-attofari@amazon.de>
 <20230512113900.56393-1-attofari@amazon.de>
Date:   Fri, 12 May 2023 14:52:30 +0200
Message-ID: <87y1ltbtkh.ffs@tglx>
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

On Fri, May 12 2023 at 11:38, Adamos Ttofari wrote:
>  	if (cpu_feature_enabled(X86_FEATURE_XFD))
> -		wrmsrl(MSR_IA32_XFD, init_fpstate.xfd);
> +		xfd_set_state(init_fpstate.xfd);

> @@ -914,8 +915,7 @@ void fpu__resume_cpu(void)
>  				     xfeatures_mask_independent());
>  	}
>  
> -	if (fpu_state_size_dynamic())
> -		wrmsrl(MSR_IA32_XFD, current->thread.fpu.fpstate->xfd);
> +	xfd_update_state(current->thread.fpu.fpstate);

How is that supposed to work?

    this_cpu(xfd_state) == current->thread.fpu.fpstate->xfd

So the MSR write won't happen.

Thanks,

        tglx
