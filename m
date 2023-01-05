Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D22C65E929
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbjAEKma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbjAEKl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:41:58 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDF34E43A
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 02:40:34 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id i9so52268734edj.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 02:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ElgoEYYX4w2FGSSWb3yGwVmH3jRp5HCgJlvFyQc3564=;
        b=NOH89IwkBkrax5AB2S/wEli+A1tRI6lpy+rMrHZZUQ5JMiqZsNJkYRQOqNZuwwiiLk
         zxRqXHfBlKNPQoj+faAWwfrP7JXubSQYCM/xQN9XoVXThqRPTYege5hNx0etcaYgIlnM
         migZOMw051FTvj76yghnktRo/02OZsxzwDmBlsEt17+BaMT6YXAM7N+D963SWUhdjY4C
         3jVmLozeME+ESEMOEBEUSonsczvaxMWDW+fAEIBlCP7SjlPw3OqrD8BFdZkA+ZMZS+vf
         aMrHR14zKZrZZm4YzDq7BEUqWBC96ynvtFoV696zu8eg6s4hPG7adU9RuWlAFNyZlEnO
         q3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ElgoEYYX4w2FGSSWb3yGwVmH3jRp5HCgJlvFyQc3564=;
        b=UbFNTKjIRStZsA/WYyujhlk14vplP9Cva9k23osyETq7hgQsCvSFCL1akQhZ8Dc36r
         7pdPPR9OcEZsQFSVN99X2VEFbOF8CwXwLpQHnKSbi7zdStQnJe0P2sdijQE6vlqh0sy7
         9fgnkFbjIPAtZZz48Qx8SLaRC+CBvFp6W7yt4cBmlfH3dp9Oke1NwglnDUehTxnp3LGZ
         iERTnWHtidKVz9sEafg+MSKuD4V8ch4cHFcDsdpzJlM2co0eOrRDIlC3fGZMwDgFR+wL
         naupELQcbJIT65zf71ELBwT4ijy10KAXWHOGvi3cT3bQf3w/KCVJQgUMmd4yOk3R9yXG
         ZGbg==
X-Gm-Message-State: AFqh2kqCzT2WP5AHMxM6hrg2f+JhDgjITfUbo8CPeXLDMPQjZbaMnQjH
        fr0A1CxoeCepo0NGXC0YgE0=
X-Google-Smtp-Source: AMrXdXvl1OPabSqDu3RApJGBzvFED86Syh/1rXdtYWecHC6Dvklm/8iMK+F9gV76hI0QEVPowFymVQ==
X-Received: by 2002:aa7:cf94:0:b0:47b:16f5:61dc with SMTP id z20-20020aa7cf94000000b0047b16f561dcmr45010171edx.37.1672915232787;
        Thu, 05 Jan 2023 02:40:32 -0800 (PST)
Received: from gmail.com (1F2EF380.nat.pool.telekom.hu. [31.46.243.128])
        by smtp.gmail.com with ESMTPSA id u1-20020aa7d541000000b0046951b43e84sm15959447edr.55.2023.01.05.02.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 02:40:32 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 5 Jan 2023 11:40:30 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [PATCH x86/nmi 2/2] x86/nmi: Print reasons why backtrace NMIs
 are ignored
Message-ID: <Y7apHi9A0i63X4Me@gmail.com>
References: <20230105011537.1774941-1-paulmck@kernel.org>
 <20230105011537.1774941-2-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105011537.1774941-2-paulmck@kernel.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul E. McKenney <paulmck@kernel.org> wrote:

> +#ifdef CONFIG_NMI_CHECK_CPU
> +
> +static char *nmi_check_stall_msg[] = {
> +/*									*/
> +/* +--------- nsp->idt_seq_snap & 0x1: CPU is in NMI handler.		*/
> +/* | +------ cpu_is_offline(cpu)					*/
> +/* | | +--- nsp->idt_calls_snap != atomic_long_read(&nsp->idt_calls):	*/
> +/* | | |	NMI handler has been invoked.				*/
> +/* | | |								*/
> +/* V V V								*/
> +/* 0 0 0 */ "NMIs are not reaching exc_nmi handler",
> +/* 0 0 1 */ "exc_nmi handler is ignoring NMIs",
> +/* 0 1 0 */ "CPU is offline and NMIs are not reaching exc_nmi handler",
> +/* 0 1 1 */ "CPU is offline and exc_nmi handler is legitimately ignoring NMIs",
> +/* 1 0 0 */ "CPU is in exc_nmi handler and no further NMIs are reaching handler",
> +/* 1 0 1 */ "CPU is in exc_nmi handler which is legitimately ignoring NMIs",
> +/* 1 1 0 */ "CPU is offline in exc_nmi handler and no further NMIs are reaching exc_nmi handler",
> +/* 1 1 1 */ "CPU is offline in exc_nmi handler which is legitimately ignoring NMIs",

That kind of disambiguation of why a CPU is stuck looks really useful:

   Reviewed-by: Ingo Molnar <mingo@kernel.org>

One small suggestion would be to do this in the messages:

   s/exc_nmi handler
    /exc_nmi() handler

... to make it clear that it's a regular kernel function [well, hw entry 
handler], not a function pointer or some other indirection? No strong 
feelings though.

Thanks,

	Ingo
