Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784B766234D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 11:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236997AbjAIKkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 05:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236629AbjAIKkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 05:40:47 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B79018E30
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 02:40:44 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id ay40so5934900wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 02:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+15hlIC73/i7RS8+s7sRGfxlZ9giO8ORM4NySaQdUqw=;
        b=QTQPm9dTr2P+uNEcd2haK7oI3EsCl2CiT2PFiC+9aWUECvzpl/1dX6RUi3w1wAwUZU
         98OwaBy0wphzoRUfHAWXfy4gjFFF1gwinlNbYHtD1osfx3Sgi2tnGQlCk0uJ91wK10gd
         u/L3arQWNbOOWQsr+CR3u3RaMD9aBfinrma9rQWocpt5lVUs1jka3UDyeP9zSrZxMUaC
         PThOTZWFQSwdd4C2S5sar9HLCOYEEHdIOmptddVdbqoP3ao/a6hANmk2hfUY8NyQxHTu
         OAcIeUwstXsEUK1gUEYtSxGdV/TrWoZvLgqVKzddvL5TY7tv1OlENjOvdN355nLNRNgM
         TUpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+15hlIC73/i7RS8+s7sRGfxlZ9giO8ORM4NySaQdUqw=;
        b=zjC2Vh2R3Hvd0q2WB/XKIqISb26jKuMBg4y1g9YUb7Y/VSPGiGypjXiDw0R35GUxPd
         buXgfnmheJyLcApXi3V2NFO3+aSUBgEBDsMXxEAD7Q92mfC5GSPcrikmxZohUAWuPaVm
         23ARVQnsa6cqVpHKcY/dtA+7LafeZlDi9acLptk9PuiTAZGVU368+BxkXu4OoA5ipjJX
         I8l+MLeVV5PXjmo0IwlA2NlkD7m5bMUYbr6ujFSJisG7oB1HWzv2wSrLmU7qwOkXYihn
         lPjc6QUwsOMvCXq7LU8/iejx7nS69lRJQLxaC7HHTtm2SB0BIkhiBuRS+wZHqYAzMkNQ
         z+bA==
X-Gm-Message-State: AFqh2kp/BZvNUulRJtVBBfCkPGT/IzBtcF3TJ7h87A+A/nlq5PT9fzEk
        ADTtRfQXJ4SFEARiQGo6zc4=
X-Google-Smtp-Source: AMrXdXscTImYmFak/xQxcMkCtkJeTAF3pHQoSEZ8hU172nTJyWhvyYi9TwQH/4cGuwA2lWz2d8seig==
X-Received: by 2002:a05:600c:2252:b0:3d3:5d8b:7af with SMTP id a18-20020a05600c225200b003d35d8b07afmr48782803wmm.41.1673260843065;
        Mon, 09 Jan 2023 02:40:43 -0800 (PST)
Received: from gmail.com (1F2EF719.nat.pool.telekom.hu. [31.46.247.25])
        by smtp.gmail.com with ESMTPSA id k4-20020a05600c1c8400b003d22528decesm17703586wms.43.2023.01.09.02.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 02:40:42 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 9 Jan 2023 11:40:40 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86: Disable kernel stack offset randomization for
 !TSC
Message-ID: <Y7vvKHYXpe7KmwCI@gmail.com>
References: <alpine.DEB.2.21.2301082113350.65308@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2301082113350.65308@angie.orcam.me.uk>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Maciej W. Rozycki <macro@orcam.me.uk> wrote:

> For x86 kernel stack offset randomization uses the RDTSC instruction, 
> which causes an invalid opcode exception with hardware that does not 
> implement this instruction:

> @@ -85,7 +86,8 @@ static inline void arch_exit_to_user_mod
>  	 * Therefore, final stack offset entropy will be 5 (x86_64) or
>  	 * 6 (ia32) bits.
>  	 */
> -	choose_random_kstack_offset(rdtsc() & 0xFF);
> +	if (cpu_feature_enabled(X86_FEATURE_TSC))
> +		choose_random_kstack_offset(rdtsc() & 0xFF);
>  }

While this is an obscure corner case, falling back to 0 offset silently 
feels a bit wrong - could we at least attempt to generate some 
unpredictability in this case?

It's not genuine entropy, but we could pass in a value that varies from 
task to task and which is not an 'obviously known' constant value like the 
0 fallback?

For example the lowest 8 bits of the virtual page number of the current 
task plus the lowest 8 bits of jiffies should vary from task to task, has 
some time dependence and is cheap to compute:

	(((unsigned long)current >> 12) + jiffies) & 0xFF

This combined with the per-CPU forward storage of previous offsets:

#define choose_random_kstack_offset(rand) do {                          \
        if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT, \
                                &randomize_kstack_offset)) {            \
                u32 offset = raw_cpu_read(kstack_offset);               \
                offset ^= (rand);                                       \
                raw_cpu_write(kstack_offset, offset);                   \
        }                                                               \

Should make this reasonably hard to guess for long-running tasks even if 
there's no TSC - and make it hard to guess even for tasks whose creation an 
attacker controls, unless there's an info-leak to rely on.

Thanks,

	Ingo
