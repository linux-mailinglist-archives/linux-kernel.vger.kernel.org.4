Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424335F6F5D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 22:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbiJFUjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 16:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbiJFUjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 16:39:06 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD94FF8E5;
        Thu,  6 Oct 2022 13:39:05 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id m15so4424629edb.13;
        Thu, 06 Oct 2022 13:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ca+7CywlehRa9vVzgJhRYOFM8nac5MOI2RRR0Wsz7FU=;
        b=aTCHWxtnM4Vl0sY2+8q1cac7CUsyi6re4UTqE4d0rLLWtjU2aS61RnTfwzfk0dm8gl
         MYpgxjJ6TKj8ByHZa2gCKTZNOD6K6rRin7OcsKA79yCS8VqXpmlD+sYF35vNADZItJL/
         o+sTK+j1mSGD4iZtwHAKzFXX7EyxRwJGVb4rY+vOBNkgfGlGeU/wmTf7PBSI6M+T76vB
         57sfg5yV5tGTN8Twgz21Cndtv9IeWe2PjPChoEGYA1oW/XHHeNcslyh4fXkCbjzZJ6jr
         N8rIeNXt137E3KKg7P3Kqg3DQX8mnQ9R98ailtCiVSnXDuBN/a+Xdnh7a07suNjrFV/H
         qDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ca+7CywlehRa9vVzgJhRYOFM8nac5MOI2RRR0Wsz7FU=;
        b=bB/Ro0uwMyXtLif5fsw5xc5x2E1brqFT/uNxI9kosUmBUqjPCweRHIeltUCF73ANIh
         b5ekvh3c8VQE+u5ZpQOXYjqcOlqIXsnqS7x/2gil5ltaQhqeDtpBHS8wPod9rnErK3WT
         EjXBiW2u+Ybk4iYMGNESaBg5odTC54plxNxTNmdT7ZbImFRC8l8WtLDJJIQK3DA4Gnzh
         Y+iAxOSJ8Oi89xNQjiQS2qqSgKk8A1s4kyWcv0MJUqthrEQ9JDxqYaMvWbCOshisVvqU
         p/jJnNtRHlnIWdKGiHS4sfbZv6PIzRNj6cOBmo2TA68BbCjcJmMBifHH8l+Zoq4fj4HV
         hj2A==
X-Gm-Message-State: ACrzQf14pJhZ4JzkRuJ85vhLa/w/S6GcYKlQvg2F4t64mL3GDL2XsGed
        G2AoM9wsK40hBQsQR55Oi0b5ZjOsRp9o5w==
X-Google-Smtp-Source: AMsMyM67jlXsZYauGc/CZ9gbt0+5W0O0rZbGQoyyercgX96L5tBoht8hBiH6Uxb8omWeKHYZ3y2Cqw==
X-Received: by 2002:a05:6402:2b8d:b0:43a:5410:a9fc with SMTP id fj13-20020a0564022b8d00b0043a5410a9fcmr1531627edb.99.1665088743726;
        Thu, 06 Oct 2022 13:39:03 -0700 (PDT)
Received: from mypc.localnet (host-79-17-38-224.retail.telecomitalia.it. [79.17.38.224])
        by smtp.gmail.com with ESMTPSA id z22-20020a170906435600b0078d225d2d2bsm173461ejm.114.2022.10.06.13.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 13:39:02 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     ira.weiny@intel.com,
        Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: Re: [PATCH] x86/sgx: Replace kmap/kunmap_atomic calls
Date:   Thu, 06 Oct 2022 22:37:32 +0200
Message-ID: <3694452.kQq0lBPeGt@mypc>
In-Reply-To: <20220929160647.362798-1-kristen@linux.intel.com>
References: <20220929160647.362798-1-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, September 29, 2022 6:06:46 PM CEST Kristen Carlson Accardi wrote:
> It is not necessary to disable page faults or preemption when
> using kmap calls

Do you refer to the page faults disabling that kmap_atomic() provides as a 
side effect? Can you please clarify a little more? kmap_atomic() disables 
always only page faults, instead it might not disable preemption; it depends 
on CONFIG_PREEMPT_RT. Therefore, why are you also talking about preemption?

Are you converting code which runs in atomic context regardless kmap_atomic()? 
If so, between kmap() and kmap_atomic(), the author(s) had only one choice, it 
correctly was kmap_atomic(), otherwise we might end up with a perfect recipe
for triggering SAC bugs.

kmap() were not suited in those cases because it might sleep. If the intents 
of the author are simply map a page while in atomic, so to avoid sleeping in 
atomic bugs, your conversions looks good. 

For the reasons above, can you please say something more about why this code 
needed a kmap_atomic() instead of calling kmap()?

A different case is in choosing kmap_atomic() is there because of its side 
effects, despite the code is running in non atomic context until the mapping, 
but it needs to disable pagefaults only somewhere between the mapping and 
unmapping. This is a trickier case than the above-mentioned one because along 
with conversion developers should at least disable the pagefaults and 
probably, although not necessarily, also disable preemption.

> , so replace kmap_atomic() and kunmap_atomic()
> calls with more the more appropriate kmap_local_page() and
> kunmap_local() calls.

Why is kmap_local_page() better suited in general and is safe in 
this specific case? 

I think that we should provide the maintainer with well supported reasons why 
they should change any piece of code which is still doing what it is thought 
for. A mere deprecation in favour of a newer API may not be enough to change 
code that is still working properly (like in the old "if it's not broken, 
don't fix it!", or something like this :)).

Thanks,

Fabio


> 
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> ---
>  arch/x86/kernel/cpu/sgx/encl.c  | 12 ++++++------
>  arch/x86/kernel/cpu/sgx/ioctl.c |  4 ++--
>  arch/x86/kernel/cpu/sgx/main.c  |  8 ++++----
>  3 files changed, 12 insertions(+), 12 deletions(-)
> 

[snip]


