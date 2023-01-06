Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E82F660710
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 20:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235330AbjAFTXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 14:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjAFTXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 14:23:21 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B28314017
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 11:23:20 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so2723347pjj.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 11:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GzCgQ6kuQycdzwh6t3skvEow87f6nzRLM3lEMDxfCiw=;
        b=WLX3Uq2Ju0++6xITuhnNWagM/zuoRNv8enKtAe43Bje28LFSgRbuN0S0JMDVLg2wpc
         FZtxZkbWhETfVX0Q5GDPP89Ma+OlP5vCL4l9m//rWN97dadTyAkjZHCjyEVBg2zu8u9X
         Smd5/OprTtQDPQdK/iDrHhTpmF0qGieFvowJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GzCgQ6kuQycdzwh6t3skvEow87f6nzRLM3lEMDxfCiw=;
        b=ZSzwLGAIhXdntR7sZf8EnCixTKqtXOLQ+dKdCmzz6om8FunVZuxG3wfZzDLYr13ALu
         C5E8MQNy/aCvHasv/m9Jr6wJgRrTi7jaaFxk9dKrBCRy4oPOLkWnOWIOA8NoEHSsXxx/
         zQHTttyglLBhD45TxyoKpmOyCFf35J8K504h47BGr5RfiN4m8u1uASG6zi/ZPnb4eQe/
         KDHTem/AsbnSme0Pbk9J7dmZ56pcRYLUBV5+6+KSHm0v+kVcxAt0tHZEZy5cn5u6t9D0
         YctRBJVjyeRg6Dk4MKft7GZuI0UJOHystEA3EiMdUnyo+XkZktl7KultjjMCKioODglE
         HILw==
X-Gm-Message-State: AFqh2koyxYjNQKbN1rZNV1vqv3J9oR+dL6abWuMScrqGwzxZ47X21YrJ
        pRR2Q9lcSUozLcdElCjkT9B3dw==
X-Google-Smtp-Source: AMrXdXuoBEios2bSour0+HwdUKLT+RXpqNTpRwJbB5HpIms5ZeSnyw7PfLZgzcT+ft/00U0d8uMDEw==
X-Received: by 2002:a05:6a20:1b02:b0:aa:7d04:109b with SMTP id ch2-20020a056a201b0200b000aa7d04109bmr71297175pzb.40.1673032999757;
        Fri, 06 Jan 2023 11:23:19 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q2-20020a63cc42000000b004788780dd8esm1194945pgi.63.2023.01.06.11.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 11:23:19 -0800 (PST)
Date:   Fri, 6 Jan 2023 11:23:18 -0800
From:   Kees Cook <keescook@chromium.org>
To:     david.keisarschm@mail.huji.ac.il
Cc:     linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Jason@zx2c4.com,
        aksecurity@gmail.com, ilay.bahat1@gmail.com
Subject: Re: [PATCH v3 3/3] Replace invocation of weak PRNG in
 arch/x86/mm/kaslr.c
Message-ID: <202301061118.836BF431F@keescook>
References: <cover.1671277662.git.david.keisarschm@mail.huji.ac.il>
 <a6b5907e2a1249f109c9112652cbbec244e00fba.1671277662.git.david.keisarschm@mail.huji.ac.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6b5907e2a1249f109c9112652cbbec244e00fba.1671277662.git.david.keisarschm@mail.huji.ac.il>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 18, 2022 at 08:19:00PM +0200, david.keisarschm@mail.huji.ac.il wrote:
> From: David Keisar Schmidt <david.keisarschm@mail.huji.ac.il>
> 
> This third series add some changes to the commit messages,
> and also replaces get_random_u32 with get_random_u32_below,
> in a case a modulo operation is done on the result.
> 
> The memory randomization of the virtual address space of kernel memory regions
> (physical memory mapping, vmalloc & vmemmap) inside arch/x86/mm/kaslr.c
> is based on the function prandom_bytes_state which uses the prandom_u32 PRNG.
> 
> However, this PRNG turned out to be weak, as noted in commit c51f8f88d705
> To fix it, we have changed the invocation of prandom_bytes_state to get_random_bytes.
> 
> Unlike get_random_bytes which maintains its own state, prandom_bytes state needs to be seeded,
> thus, we have omitted the call to the seeding function, since it is not needed anymore.

I'd really rather not do this. prandom is being seeded from "true" RNG,
and it allows for the KASLR to be hand-seeded for a repeatable layout
for doing debugging and performance analysis (for the coming FG-KASLR).

AIUI, prandom is weak due to its shared state (which KASLR's use doesn't
have) and its predictability over time (but KASLR uses it only at
boot-time). And being able to recover the outputs would mean KASLR was
already broken, so there isn't anything that becomes MORE exposed.

If there is some other weakness, then sure, we can re-evaluate it, but
for now I'd rather leave this as-is.

-Kees

-- 
Kees Cook
