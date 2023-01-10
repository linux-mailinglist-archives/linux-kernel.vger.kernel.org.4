Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A47F664D8A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 21:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbjAJUf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 15:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbjAJUfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 15:35:39 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA37A196;
        Tue, 10 Jan 2023 12:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rcZ4SPFKYx+tqc2REErmG5c3gwzYReVP3gYzWilP+RU=; b=BCylYdxJPNoZITKoQl6b6S7eIE
        y52arEeOIcDrAX+2lFYuERUvbyzLduxy61mENUE3K8fiF6bHsTiP4i2UpwfkLpFEFtcC9gxO7XtM/
        GuFdBgusmdVWfRsXnc1CFdgKwhVd7Mtf0UevkS8DpHeKRmq0qaio8/NfhJ+iX9nUZLrgcUGJ6QN5S
        9C3ZeXYGqoIMLl5LQTOm6EYoHaPuMDle/wAksygQSdod+FeSUViDVH2TDG7g7ARo/dNWV08URgAIp
        Vx9Hwbt1mYhhk0wO7t32Rw6JRBEjfLkWYCeP35gHVUzgZAbU8IT10YrvePF6F6hJcjOoYcwwPgKio
        xOf1pK0w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pFLKy-003Pwn-0g;
        Tue, 10 Jan 2023 20:35:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7FBBC300129;
        Tue, 10 Jan 2023 21:35:18 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3768E2C4CAB7F; Tue, 10 Jan 2023 21:35:18 +0100 (CET)
Date:   Tue, 10 Jan 2023 21:35:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        ndesaulniers@google.com, ojeda@kernel.org,
        rafael.j.wysocki@intel.com, revest@chromium.org,
        robert.moore@intel.com, rostedt@goodmis.org, will@kernel.org
Subject: Re: [PATCH 3/8] arm64: Extend support for CONFIG_FUNCTION_ALIGNMENT
Message-ID: <Y73MBswL76Hi9cay@hirez.programming.kicks-ass.net>
References: <20230109135828.879136-1-mark.rutland@arm.com>
 <20230109135828.879136-4-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230109135828.879136-4-mark.rutland@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 01:58:23PM +0000, Mark Rutland wrote:

> diff --git a/arch/arm64/include/asm/linkage.h b/arch/arm64/include/asm/linkage.h
> index 1436fa1cde24d..df18a3446ce82 100644
> --- a/arch/arm64/include/asm/linkage.h
> +++ b/arch/arm64/include/asm/linkage.h
> @@ -5,8 +5,14 @@
>  #include <asm/assembler.h>
>  #endif
>  
> -#define __ALIGN		.align 2
> -#define __ALIGN_STR	".align 2"
> +#if CONFIG_FUNCTION_ALIGNMENT > 0
> +#define ARM64_FUNCTION_ALIGNMENT	CONFIG_FUNCTION_ALIGNMENT
> +#else
> +#define ARM64_FUNCTION_ALIGNMENT	4
> +#endif
> +
> +#define __ALIGN		.balign ARM64_FUNCTION_ALIGNMENT
> +#define __ALIGN_STR	".balign " #ARM64_FUNCTION_ALIGNMENT

Isn't that much the same as having ARM64 select FUNCTION_ALIGNMENT_4B
and simply removing all these lines and relying on the default
behaviour?

