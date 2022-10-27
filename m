Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 300BA60F37C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 11:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234619AbiJ0JSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 05:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiJ0JSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 05:18:18 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2B6C4C
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 02:18:17 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e7cb329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7cb:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 07D621EC0304;
        Thu, 27 Oct 2022 11:18:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1666862296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=PuWsivckZVN0DUmFsrtIzP5SfWNqnnELeSC7m6XkqO0=;
        b=ECir+ksAb1wck/b9cY4WWx2YowY5msdpOFe8bK0ZcXwjlMW3WNGZRGyQhdE1uZfApCDO6H
        PVy6Q+uZLRRkULhLvqHKfLISTQL+6ltVx0iNx7+gNHmRnR2M6D1YkGWrGnhvGxTX8QT+Cs
        KfW+LUAy8hSIRP1hSJdjSZyOsmnvTuc=
Date:   Thu, 27 Oct 2022 11:18:11 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v4 08/16] x86/mtrr: remove set_all callback from struct
 mtrr_ops
Message-ID: <Y1pM05I7I4HBpIcw@zn.tnic>
References: <20221004081023.32402-1-jgross@suse.com>
 <20221004081023.32402-9-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221004081023.32402-9-jgross@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 10:10:15AM +0200, Juergen Gross wrote:
> diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
> index dacb537da126..501ca1747d55 100644
> --- a/arch/x86/kernel/cpu/mtrr/mtrr.c
> +++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
> @@ -165,15 +165,15 @@ static int mtrr_rendezvous_handler(void *info)
>  	 * saved, and we want to replicate that across all the cpus that come
>  	 * online (either at the end of boot or resume or during a runtime cpu
>  	 * online). If we're doing that, @reg is set to something special and on
> -	 * all the cpu's we do mtrr_if->set_all() (On the logical cpu that
> +	 * all the cpu's we do cache_cpu_init() (On the logical cpu that

s/cpu's/CPUs/
s/cpu/CPU/

while at it.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
