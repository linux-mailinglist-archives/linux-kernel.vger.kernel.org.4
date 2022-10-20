Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1EC6605F17
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 13:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbiJTLj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 07:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiJTLjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 07:39:24 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927131DDC2D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 04:39:16 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e710329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e710:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 59C931EC0567;
        Thu, 20 Oct 2022 13:39:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1666265949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Vt+wMbRFE0rG1uXDujJFiYR0joB4irWLNz9Ee1QgEPY=;
        b=Lo2rYQRz7A01KADbSuyKRxc1XILdeTNVtSfBHQ6PVOriFyIbeFkH76vI40g1wbm5m7rGlR
        TMyHEwGgv0LOWkHvZL3E1HTzoJhM7nJazREkCHOqRC+ROyKYNxA00cJXwKIXbr/IrRJqTn
        z8gXYkwQKD48/lE+L7Ml+vSO/8iqZPk=
Date:   Thu, 20 Oct 2022 13:39:09 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org
Subject: Re: [PATCH] x86/xen: simplify sysenter and syscall setup
Message-ID: <Y1EzXQP3/Pn3bme+@zn.tnic>
References: <20221020113619.17204-1-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221020113619.17204-1-jgross@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 01:36:19PM +0200, Juergen Gross wrote:
> xen_enable_sysenter() and xen_enable_syscall() can be simplified a lot.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  arch/x86/xen/setup.c | 23 ++++++-----------------
>  1 file changed, 6 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/x86/xen/setup.c b/arch/x86/xen/setup.c
> index cfa99e8f054b..0f33ed6d3a7b 100644
> --- a/arch/x86/xen/setup.c
> +++ b/arch/x86/xen/setup.c
> @@ -910,17 +910,9 @@ static int register_callback(unsigned type, const void *func)
>  
>  void xen_enable_sysenter(void)
>  {
> -	int ret;
> -	unsigned sysenter_feature;
> -
> -	sysenter_feature = X86_FEATURE_SYSENTER32;
> -
> -	if (!boot_cpu_has(sysenter_feature))
> -		return;
> -
> -	ret = register_callback(CALLBACKTYPE_sysenter, xen_entry_SYSENTER_compat);
> -	if(ret != 0)
> -		setup_clear_cpu_cap(sysenter_feature);
> +	if (boot_cpu_has(X86_FEATURE_SYSENTER32) &&

Can you switch that and below to cpu_feature_enabled() while at it, pls?

> +	if (boot_cpu_has(X86_FEATURE_SYSCALL32) &&
	^^^^^^^^^^^^^^^^^^

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
