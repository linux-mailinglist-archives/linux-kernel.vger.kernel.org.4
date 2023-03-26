Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89266C9868
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 00:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjCZWF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 18:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjCZWF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 18:05:28 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FE090
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 15:05:26 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5841E1EC04CC;
        Mon, 27 Mar 2023 00:05:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1679868325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=nl2n/LYgguJT3xmeiUQKZrBzhXeqDwkpxLV1v2se1MQ=;
        b=GXp3RPXTUmPPP/HcHn+ndC3esryD0GFxwHq54zdelDk27glOH94+bs/R993zV29+OnP/J0
        JDgtMRvW9FvSLHERzl58QzjfgB3Tx231LaZCqQ8JnU6UpCZAOAOpQFZ/GbZtVFaeF/EaFu
        drY9syuDDI8+ozou5U7DJGXxJnhOX1M=
Date:   Mon, 27 Mar 2023 00:05:20 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v4 07/12] x86/mtrr: allocate mtrr_value array dynamically
Message-ID: <20230326220520.GJZCDBoPI+YhN5RUDg@fat_crate.local>
References: <20230306163425.8324-1-jgross@suse.com>
 <20230306163425.8324-8-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230306163425.8324-8-jgross@suse.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 05:34:20PM +0100, Juergen Gross wrote:
> The mtrr_value[] array is a static variable, which is used only in a
> few configurations. Consuming 6kB is ridiculous for this case,

Ah, that struct mtrr_value is of size 24 due to that first member
mtrr_type getting padded even if it is a u8.

> especially as the array doesn't need to be that large and it can easily
> be allocated dynamically.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  arch/x86/kernel/cpu/mtrr/mtrr.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
> index 0c83990501f5..50cd2287b6e1 100644
> --- a/arch/x86/kernel/cpu/mtrr/mtrr.c
> +++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
> @@ -581,7 +581,7 @@ struct mtrr_value {
>  	unsigned long	lsize;
>  };
>  
> -static struct mtrr_value mtrr_value[MTRR_MAX_VAR_RANGES];
> +static struct mtrr_value *mtrr_value;
>  
>  static int mtrr_save(void)
>  {
> @@ -750,6 +750,7 @@ static int __init mtrr_init_finialize(void)
>  	 * TBD: is there any system with such CPU which supports
>  	 * suspend/resume? If no, we should remove the code.
>  	 */
> +	mtrr_value = kcalloc(num_var_ranges, sizeof(*mtrr_value), GFP_KERNEL);

Pls put that over the comment.

Also, you need to handle kcalloc() returning an error.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
