Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B0662CDB5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 23:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbiKPWbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 17:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234604AbiKPWa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 17:30:58 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D2758BFB
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 14:30:56 -0800 (PST)
Received: from zn.tnic (p200300ea9733e7de329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7de:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8ECBB1EC053B;
        Wed, 16 Nov 2022 23:30:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1668637854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=cmRq9uXHaI9jSFnBZ3j6pMF3NRCi9BKeLHo9UftAF6Y=;
        b=YhdklwLDKCfJQFKUOidYM/oQ4yGzZsSlm5zSm9lgqzqPA1ZMEs+Lm1U9uIbOEcFq55Bt2d
        h2WvqvfpG/dYYDBtPWNDpkn4GHwJNvKjG9K6GxzxGMAgW/71wiwwuYvOyssP4L5XkoXKkp
        1ZwEFpSFbl3faaveBFcq1g5bpYIKiQ8=
Date:   Wed, 16 Nov 2022 23:30:50 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, nslusarek@gmx.net,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: Fix sys_perf_event_open() race against self
Message-ID: <Y3Vkmvi2vib7fwHn@zn.tnic>
References: <20220520183806.GV2578@worktop.programming.kicks-ass.net>
 <700710fc-1ac1-1b39-0e63-eb86adb4b984@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <700710fc-1ac1-1b39-0e63-eb86adb4b984@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 04:03:29PM +0530, Ravi Bangoria wrote:
> On 21-May-22 12:08 AM, Peter Zijlstra wrote:
> > 
> > Norbert reported that it's possible to race sys_perf_event_open() such
> > that the looser ends up in another context from the group leader,
> > triggering many WARNs.
> > 
> > The move_group case checks for races against itself, but the
> > !move_group case doesn't, seemingly relying on the previous
> > group_leader->ctx == ctx check. However, that check is racy due to not
> > holding any locks at that time.
> > 
> > Therefore, re-check the result after acquiring locks and bailing
> > if they no longer match.
> > 
> > Additionally, clarify the not_move_group case from the
> > move_group-vs-move_group race.
> 
> Tested-by: Ravi Bangoria <ravi.bangoria@amd.com>
> 
> Below is a quick test to reproduce the issue. It triggers WARN_ON()
> as normal user. No warnings with the patch.

Shouldn't this test be in tools/perf/tests/ or so?

If that hasn't happened yet, I mean.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
