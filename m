Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC52B601098
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 15:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiJQN4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 09:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiJQN43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 09:56:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C515464C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 06:56:26 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666014985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5d1QzgRSD0JRva4615IYb620QEIPs213050MB2/TnI8=;
        b=BapstiHpWGZA6P4nRyUp1d4o0a7OW2AotVj0zPb0P6sl83BEs21K7o8+manxMc41BMcjX9
        LF5/0ONRhbVyqHJ2+8YU8eM3TpcTZT2zcWmPM7//ZUZ+mjZ/6fzPsAVqz9xJC6KIuHVIxu
        7gs/7MZcr4F+J7ZFLvG5AUqyC/ePDrzpyWsxMJnetuPqdQznZ0ruBW0zWQo2mAgvF4DQgZ
        8Yix/Qk0w3as7IK1f3m010BMiBuDXNBf16grxYD1X72z8+STi1PLcSdb1scvL/PApJ43S2
        qoAAWfASbLf7MmUgko8ekz7bGDyb0vsrqjp7wc25wjT9aVbk7w4KYUzoj8yboA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666014985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5d1QzgRSD0JRva4615IYb620QEIPs213050MB2/TnI8=;
        b=jBHDMdAQbIrCzyvuqfA7ZTxwlDkZAlm0FQhxcG3rTmHc+5EuZupboC1/AFNi7VU0RY1Mi/
        HsaXfGh2x94ea2CA==
To:     Liang He <windhl@126.com>, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com
Cc:     jgg@ziepe.ca, kirill.shutemov@linux.intel.com,
        brijesh.singh@amd.com, linux-kernel@vger.kernel.org, windhl@126.com
Subject: Re: [PATCH] arch: x86: kernel: Add missing of_node_put() in x86_init.c
In-Reply-To: <20220615125739.3966617-1-windhl@126.com>
References: <20220615125739.3966617-1-windhl@126.com>
Date:   Mon, 17 Oct 2022 15:56:25 +0200
Message-ID: <87zgdupn92.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Liang,

On Wed, Jun 15 2022 at 20:57, Liang He wrote:

please check https://www.kernel.org/doc/html/latest/process/maintainer-tip.html
for instructions vs. subject prefixes and changelogs.

> In x86_wallclock_init(), we need to use of_node_put() for the
> of_find_matching_node() which returns a node pointer with refcount
> incremented.
>
> Signed-off-by: Liang He <windhl@126.com>
> ---
>  arch/x86/kernel/x86_init.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
> index e84ee5cdbd8c..81c071080efe 100644
> --- a/arch/x86/kernel/x86_init.c
> +++ b/arch/x86/kernel/x86_init.c
> @@ -50,6 +50,7 @@ static __init void x86_wallclock_init(void)
>  	struct device_node *node = of_find_matching_node(NULL, of_cmos_match);
>  
>  	if (node && !of_device_is_available(node)) {
> +		of_node_put(node);
>  		x86_platform.get_wallclock = get_rtc_noop;
>  		x86_platform.set_wallclock = set_rtc_noop;
>  	}

That still leaks the node in the case when the device is available, no?

Thanks,

        tglx
