Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B6B6EA912
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 13:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjDULYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 07:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjDULYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 07:24:05 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843D844A2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 04:24:04 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 207ED1EC049C;
        Fri, 21 Apr 2023 13:24:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1682076243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=a87N52p5sMDjBSXQShCgpPp16fh6M2DXFX0u0FSwgJo=;
        b=Qk44wo9eSzByOhRGpZ70+42SvVcdUZTQk1T3UcAKDQZHhurNFK7yI6rc2ycrYBQBS8K610
        k229UH9ldd6fm6lR+0yOCyUAeqaHKYdDwhA0owRbS9ZW1KLKl+hN8d42K5oo/VETWkuqa0
        gtER9XWW1ptfeiCsDpyEzoFo3VukFUw=
Date:   Fri, 21 Apr 2023 13:23:55 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH v5 11/15] x86/mtrr: construct a memory map with cache
 modes
Message-ID: <20230421112355.GAZEJyS+w84odQ9s2i@fat_crate.local>
References: <20230401063652.23522-1-jgross@suse.com>
 <20230401063652.23522-12-jgross@suse.com>
 <20230420121551.GMZEEs9wkUrvX05nQr@fat_crate.local>
 <d164d84b-6773-36e3-1136-672072e9233d@suse.com>
 <20230420130113.GCZEE3mfOTxcDn6e3/@fat_crate.local>
 <681c5d8e-0e42-07e1-f91c-7696a2360f1c@suse.com>
 <20230420145451.GFZEFSO6VmvXdK/qi9@fat_crate.local>
 <bb77023b-8dd0-0551-5c16-92f184568161@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bb77023b-8dd0-0551-5c16-92f184568161@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 05:10:03PM +0200, Juergen Gross wrote:
> I think this will need another final loop over the MTRRs to check against the
> constructed map if a MTRR is completely useless.

Yeah, I slept on it: so I think there should be a patch ontop which does
add debug output - disabled by default and controllable by adding
"mtrr=debug" on the cmdline or so - which dumps the cache map operations
(add/remove) and the final table.

The reason being, when this cache_map thing hits upstream, we would need
a way to debug any potential issues which people might report so asking
them to do a "mtrr=debug" boot would be a good help.

And pls make the prints pr_info() and not pr_debug() because people
should not have to recompile in order to enable that.

> Another question: in case we detect such a hidden MTRR, should it be disabled
> in order to have more MTRRs available for run-time adding?

Let's not do anything for now and address this if really needed.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
