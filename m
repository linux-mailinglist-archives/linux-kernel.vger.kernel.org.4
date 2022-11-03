Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3815A617A97
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 11:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbiKCKHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 06:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiKCKHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 06:07:36 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04319BC01;
        Thu,  3 Nov 2022 03:07:34 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e7e7329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7e7:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8F96C1EC0430;
        Thu,  3 Nov 2022 11:07:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1667470053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=B3oC+sm+mZZMeOEYpf8Tq9AGJhevA/jEHtXi9pF4QRE=;
        b=mH1GBeKDk90+OFcvgAlEFRDb+DAZib1e1gQXGU/SJ9A/UCqlpmc9Ixv2pdz3aIBcRJVbgF
        VTsYXtEGn5Zu42UgOZrJXrXuR9a/qf5XBFywYQtJz61R+oYB2h3hNmmjhZxsoEu6xbsSR1
        dNUid1ypgJErY6EdSsaFCVcuNOSmd7c=
Date:   Thu, 3 Nov 2022 11:07:28 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     silviazhao-oc <silviazhao-oc@zhaoxin.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        cobechen@zhaoxin.com, louisqi@zhaoxin.com, silviazhao@zhaoxin.com,
        8vvbbqzo567a@nospam.xutrox.com
Subject: Re: [PATCH] x86/perf: Fixed kernel panic during boot on Nano
 processor.
Message-ID: <Y2OS4PgqfavavMKY@zn.tnic>
References: <20221103032304.27753-1-silviazhao-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221103032304.27753-1-silviazhao-oc@zhaoxin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 11:23:04AM +0800, silviazhao-oc wrote:
> Nano processor may not fully support rdpmc instruction,

What does that even mean? Not fully support?

> it works well for reading general pmc counter, but will lead
> GP(general protection) when accessing fixed pmc counter.

RDPMC will #GP when the perf counter specified cannot be read.

AFAICT, that is RCX: 0000000040000001 which looks like perf counter
index 1 with INTEL_PMC_FIXED_RDPMC_BASE ORed in.

> Furthermore, family/mode information is same between Nano processor
> and ZX-C processor, it leads to zhaoxin pmu driver is wrongly loaded
> for Nano processor, which resulting boot kernal fail.

So *that* is the real problem - it tries to access perf counters
thinking it is running on architectural perf counters implementation but
nano doesn't have that.

> To solve this problem, stepping information will be checked to distinguish
> between Nano processor and ZX-C processor.

Why doesn't that ZXC thing doesn't have a CPUID flag to check instead of
looking at models and steppings and thus confusing it with a nano CPU?

> [https://bugzilla.kernel.org/show_bug.cgi?id=212389]
> 
> Reported-by: Arjan <8vvbbqzo567a@nospam.xutrox.com>

Does Arjan have a last name?

> Signed-off-by: silviazhao-oc <silviazhao-oc@zhaoxin.com>

I'm assuming your name is properly spelled "Silvia Zhao" and not in a
single word with a "-oc" string appended at the end, yes?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
