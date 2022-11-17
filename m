Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F3C62DA0B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239625AbiKQL7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:59:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234837AbiKQL7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:59:15 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D75113CC6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 03:59:12 -0800 (PST)
Received: from zn.tnic (p200300ea9733e7de329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7de:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 494581EC064F;
        Thu, 17 Nov 2022 12:59:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1668686351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=awpbR7h4Pv1zHzHxS1pLlggYxafgPpDeFKa5pXmhjIQ=;
        b=dIs1gnsg/QpNHes9IXpkSqmws3L8073+Fi9QhZA1k2XgtmE99T/BWqv3VUNmjMDR2cNIf9
        6L5keCCoBbggQvewax7laWieHeWgajtnwvnjj4OVh+bIoUUIbw+kaZbOHsSpZtWk5DWZBf
        51HXCtQbiVbjXQieZP/xvMUmtNuvbTQ=
Date:   Thu, 17 Nov 2022 12:59:06 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, nslusarek@gmx.net,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: Fix sys_perf_event_open() race against self
Message-ID: <Y3YiCkjsa3NLIpq6@zn.tnic>
References: <20220520183806.GV2578@worktop.programming.kicks-ass.net>
 <700710fc-1ac1-1b39-0e63-eb86adb4b984@amd.com>
 <Y3Vkmvi2vib7fwHn@zn.tnic>
 <7bf54a3f-07f7-5471-f6c2-88d3d9bc7a5e@amd.com>
 <Y3YPjo5wdKGVw7c5@zn.tnic>
 <68df3063-3fa2-9332-1705-631716589450@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <68df3063-3fa2-9332-1705-631716589450@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 04:29:31PM +0530, Ravi Bangoria wrote:
> I do agree that more tests are always better. Though, this simple program
> was to test a _specific race condition_ which no longer exists in kernel.
> So even if we add it, what would it test?

It would make sure that race doesn't happen again. Or are you saying it
will never ever happen so no need? Because we never ever rewrite the
kernel?

Lemme save us some time: this test is dirt cheap. It is good to have so
that multithreaded sys_perf_event_open() is exercised. And once it is
there, someone else might have a look at it and improve it more or reuse
it for another test.

And there are no downsides.

If you're still not convinced, lemme know and I'll turn it into a proper
patch and submit it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
