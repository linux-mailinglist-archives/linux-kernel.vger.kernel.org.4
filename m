Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4E66C9BC2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 09:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbjC0HPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 03:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjC0HPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 03:15:02 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E50B3C17
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 00:15:01 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 818E51EC01E0;
        Mon, 27 Mar 2023 09:14:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1679901299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=VyN9F0GxUoEn+qrJE/aVb2CBqRfAPtwvoGZo8D4cuAI=;
        b=KP/d6vk5jqqqjNAw+ySI6StoEoZJ7gZ1/8Ibt+68CZd25ZBl5r2SjlrAKsOXaSjYVosHj8
        aEN9sRujV0Z8ns0U8kQmu4lFMAaAV7nbvOpO3/u0/8syoE7pQdByuGY+Z+YgfALWB7H9Hc
        JL2LOQFlIVxsJqtIfyu0tGRg60Vo2TI=
Date:   Mon, 27 Mar 2023 09:14:54 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v4 06/12] x86/mtrr: replace vendor tests in MTRR code
Message-ID: <20230327071454.GBZCFCbqzj+NTx0GkL@fat_crate.local>
References: <20230306163425.8324-1-jgross@suse.com>
 <20230306163425.8324-7-jgross@suse.com>
 <20230324165611.GIZB3WK13NdjceLWnN@fat_crate.local>
 <2bade717-4ee6-49ac-db3d-83937336dd9a@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2bade717-4ee6-49ac-db3d-83937336dd9a@suse.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 07:43:58AM +0200, Juergen Gross wrote:
> The is_cpu() checks are either in functions reachable only with mtrr_if being
> set, or are testing for INTEL, which is replaced by the test of mtrr_if being
> &generic_mtrr_ops as written in the commit message.

I went through all call sites... it seems like what you're saying should
work. I guess this mtrr_if check was added as a precaution in 2002 as
part of a cleanup:

commit 8fbdcb188e31ac901e216b466b97e90e8b057daa
Author: Dave Jones <davej@suse.de>
Date:   Wed Aug 14 21:14:22 2002 -0700

    [PATCH] Modular x86 MTRR driver.
    
    This patch from Pat Mochel cleans up the hell that was mtrr.c
    into something a lot more modular and easy to understand, by
    doing the implementation-per-file as has been done to various
    other things by Pat and myself over the last months.
    
    It's functionally identical from a kernel internal point of view,
    and a userspace point of view, and is basically just a very large
    code clean up.

So let's see what catches fire...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
