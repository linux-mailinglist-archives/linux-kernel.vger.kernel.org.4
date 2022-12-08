Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5953D6472BC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbiLHPVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiLHPUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:20:51 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A43D75BC4;
        Thu,  8 Dec 2022 07:19:45 -0800 (PST)
Received: from zn.tnic (p200300ea9733e73d329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e73d:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 54F181EC06FB;
        Thu,  8 Dec 2022 16:19:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1670512783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=3GU5MeoEbeuS2CWF2tNDJu8X0AyDevMso/wvj1Ji+qA=;
        b=NUsCzemugvmppmEdsoSK6otFrDka2N/KgWTUsMIzcOKX8/O2yCj11UviDU9BZajMWfNuOZ
        I+X/oo/Dn1IfADiurnMCSjSTBOGx8z1O6gf/1U0ej+B0F3/tqfxGGLr2JUu2Y2tDXnwMXf
        OptitUxT+Wn2xIHJ5ac9Pig8cPZKtvQ=
Date:   Thu, 8 Dec 2022 16:19:39 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-tip-commits@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ian Rogers <irogers@google.com>, x86@kernel.org
Subject: Re: [tip: perf/core] perf/amd/ibs: Make IBS a core pmu
Message-ID: <Y5IAi/fgbJk1/h2L@zn.tnic>
References: <20221115093904.1799-1-ravi.bangoria@amd.com>
 <166929138346.4906.10749574210524260976.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <166929138346.4906.10749574210524260976.tip-bot2@tip-bot2>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I believe this is one of the things Linus wanted to have on AMD hw.

On Thu, Nov 24, 2022 at 12:03:03PM -0000, tip-bot2 for Ravi Bangoria wrote:
> The following commit has been merged into the perf/core branch of tip:
> 
> Commit-ID:     30093056f7b2f759ff180d3a86d29f68315e469b
> Gitweb:        https://git.kernel.org/tip/30093056f7b2f759ff180d3a86d29f68315e469b
> Author:        Ravi Bangoria <ravi.bangoria@amd.com>
> AuthorDate:    Tue, 15 Nov 2022 15:09:04 +05:30
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Thu, 24 Nov 2022 11:09:19 +01:00
> 
> perf/amd/ibs: Make IBS a core pmu
> 
> So far, only one pmu was allowed to be registered as core pmu and thus
> IBS pmus were being registered as uncore. However, with the event context
> rewrite, that limitation no longer exists and thus IBS pmus can also be
> registered as core pmu. This makes IBS much more usable, for ex, user
> will be able to do per-process precise monitoring on AMD:
> 
> Before patch:
>   $ sudo perf record -e cycles:pp ls
>   Error:
>   Invalid event (cycles:pp) in per-thread mode, enable system wide with '-a'
> 
> After patch:
>   $ sudo perf record -e cycles:pp ls
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.017 MB perf.data (33 samples) ]
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Acked-by: Ian Rogers <irogers@google.com>
> Link: https://lkml.kernel.org/r/20221115093904.1799-1-ravi.bangoria@amd.com
> ---
>  arch/x86/events/amd/ibs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
> index 3271735..fbc2ce8 100644
> --- a/arch/x86/events/amd/ibs.c
> +++ b/arch/x86/events/amd/ibs.c
> @@ -631,7 +631,7 @@ static const struct attribute_group *op_attr_update[] = {
>  
>  static struct perf_ibs perf_ibs_fetch = {
>  	.pmu = {
> -		.task_ctx_nr	= perf_invalid_context,
> +		.task_ctx_nr	= perf_hw_context,
>  
>  		.event_init	= perf_ibs_init,
>  		.add		= perf_ibs_add,
> @@ -655,7 +655,7 @@ static struct perf_ibs perf_ibs_fetch = {
>  
>  static struct perf_ibs perf_ibs_op = {
>  	.pmu = {
> -		.task_ctx_nr	= perf_invalid_context,
> +		.task_ctx_nr	= perf_hw_context,
>  
>  		.event_init	= perf_ibs_init,
>  		.add		= perf_ibs_add,

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
