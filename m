Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B342664094
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 13:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238412AbjAJMer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 07:34:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbjAJMel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 07:34:41 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02DD3C382
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 04:34:39 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id g19-20020a05600c4ed300b003d9eb1dbc0aso6807756wmq.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 04:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w9YImXfINgo9hv1+xP74ouf7bKnCq7vFHRFnlPk72z8=;
        b=oopKkV6gu4Xxlu7AOuziqpF7ufNLt04abrnj5XlqgWYwsv4ixMDww75sOE1ZCH6yp8
         gS1QvRqYfLbftJN9deSYJwF5Pkdeik2+ticfhNeMB3vRNx7PbsCo9HoRASC4+z9wmAJF
         Fv0r39+yas0BURGzKBS6F15pvtUvdGBnGV9ABYvtOAZK+rrshqwCq1qJYToxV6qngEKa
         A2njlD3SJn6S5Po0G8RpFAluGPhrLWrqc8j60EEqbcWDXAhWb+akt7Xh95cjkBpk3zd1
         DQRbjZmFarkXGadPku4iCIx1QaVyl7QGt5A7xTrLANYZqLELOFiddaoTLzNmk3esJvZN
         INnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w9YImXfINgo9hv1+xP74ouf7bKnCq7vFHRFnlPk72z8=;
        b=hAI0p0pxwK1pobpGGDPnk4nThGMJAuDiCQwYQkr1rQ9D6ILO5fL6eJVDQ7YlwWfciS
         zl33qipSmqRjqXcAQYhipCQTjxUcvoxdnYb8ySw9KVXDcQdJgegAZogjvuU2+KxVgvQF
         0acrLLsHxQqxuI0HMXVxFJN6h0gyb+heTbooBG6rGUXd0LpAtDGgognVQTV4AlJ0ZHlW
         3cTcDFOJjhmvEnFe5DLnWyR5U04VFEBM/9XMxdcU4Si/1BXsVsN4okT9rEJF151DaRdY
         GqYo8NgbzFTYoyAMS6L0jMzwo7SmYy6BsFboV4g64e1intoa+ejufooeuLmXrWz/8HRl
         Y+Fg==
X-Gm-Message-State: AFqh2krFWUqP3G23c//kZqSAOASiEEdKdoNAvrr4b8vj42WM6z1xWiie
        QNIA1Iiupg/KhLsJq9wnRvw=
X-Google-Smtp-Source: AMrXdXsubfM1A4kZ4BqYrKVlZ0jX9ZoNhSEnTlth10dWcKbdFSC0OkL4SVr3Bu2sMcVwUvOQFB0L7Q==
X-Received: by 2002:a05:600c:1c11:b0:3d1:e583:51a0 with SMTP id j17-20020a05600c1c1100b003d1e58351a0mr51058569wms.25.1673354078588;
        Tue, 10 Jan 2023 04:34:38 -0800 (PST)
Received: from gmail.com (1F2EF2EB.nat.pool.telekom.hu. [31.46.242.235])
        by smtp.gmail.com with ESMTPSA id bh13-20020a05600c3d0d00b003d358beab9dsm14607472wmb.47.2023.01.10.04.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 04:34:37 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 10 Jan 2023 13:34:35 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Zeng Heng <zengheng4@huawei.com>, michael.roth@amd.com,
        hpa@zytor.com, tglx@linutronix.de,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        kirill.shutemov@linux.intel.com, jroedel@suse.de,
        keescook@chromium.org, mingo@redhat.com,
        dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
        x86@kernel.org, liwei391@huawei.com,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH -v2] x86/boot/compressed: Register dummy NMI handler in
 EFI boot loader, to avoid kdump crashes
Message-ID: <Y71bW/8XZCackPLh@gmail.com>
References: <20230110102745.2514694-1-zengheng4@huawei.com>
 <Y71FJ+G0NGQe3Ppq@gmail.com>
 <Y71TglxSLJKO17SY@gmail.com>
 <Y71V8SRLxZ/Uqkfs@zn.tnic>
 <Y71XPl8br2QU2L8E@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y71XPl8br2QU2L8E@zn.tnic>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Borislav Petkov <bp@alien8.de> wrote:

> > mce_panic -> panic -> __crash_kexec()
> > 
> > Yes?
> > 
> > If so, then we should make sure we have *exited* #MC context before calling
> > panic() and not have to add hacks like this one of adding an empty NMI handler.
> > 
> > But I'm only speculating as it is hard to make sense of all this text.
> 
> IOW, does this help?
> 
> ---
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 7832a69d170e..55437d8a4fad 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -287,6 +287,7 @@ static noinstr void mce_panic(const char *msg, struct mce *final, char *exp)
>  		if (panic_timeout == 0)
>  			panic_timeout = mca_cfg.panic_timeout;
>  		panic(msg);
> +		mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);

So your suggestion was to exit MC context 'before' the panic() call - but 
the patch calls it 'after' - was that intentional?

Thanks,

	Ingo
