Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E898A610E43
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 12:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbiJ1KTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 06:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiJ1KT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 06:19:28 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84601C25C6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 03:19:22 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e7ce329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7ce:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 369E51EC0523;
        Fri, 28 Oct 2022 12:19:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1666952361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=pnKOGkzAqYTHQEPw8aoAjfmGZ1+iB9PnhYVRmuE0Q+s=;
        b=UNvJ7Vp2kgarN+/wDOtP8BOPFsBNaaHPA1NI5oCgjBJ9RAFITLDoZSaTh1oTF8EC14K3cw
        rlE1QqX50TPrcfya1eMFzgk9/FDndlTUXLGAot114Ul/iuwJJbMnNePqwCKt9K0d9IJ8ck
        T93Fq3KVC9ezYRr1EIvrHobwC7hAcnA=
Date:   Fri, 28 Oct 2022 12:19:16 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     Baoquan He <bhe@redhat.com>, david@redhat.com,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        sourabhjain@linux.ibm.com, linux-mm@kvack.org
Subject: Re: [PATCH v12 7/7] x86/crash: Add x86 crash hotplug support
Message-ID: <Y1uspLb7fLdtnQq+@zn.tnic>
References: <d6386653-eb71-188c-8a09-5db46b4e42d4@oracle.com>
 <YzcqE1RVtPcuLlxN@zn.tnic>
 <Y0Dh4ieUUZ4oXa1/@MiWiFi-R3L-srv>
 <Y0b9apyIs+RpSo1e@zn.tnic>
 <53aed03e-2eed-09b1-9532-fe4e497ea47d@oracle.com>
 <Y0cmaPTKQuWtwIRh@zn.tnic>
 <Y0d+mFivS+88+Chr@MiWiFi-R3L-srv>
 <Y1e7Hw0PRDI9NxU9@zn.tnic>
 <Y1lIoTBNvHrKX5K9@MiWiFi-R3L-srv>
 <35c98ca6-10f8-b248-78c5-99fce7e66c65@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <35c98ca6-10f8-b248-78c5-99fce7e66c65@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 02:24:11PM -0500, Eric DeVolder wrote:
> Be aware, in reality, that if the system was fully populated, it would not
> actually consume all 8192 phdrs. Rather /proc/iomem would essentially show a
> large contiguous address space which would require just a single phdr.

Then that from below:

	pnum += CONFIG_CRASH_MAX_MEMORY_RANGES;

which then would end up allocating 8192 would be a total waste.

So why don't you make that number dynamic then?

You start with something sensible:

	total_num_pheaders = num_online_cpus() + "some number of regions" + "some few others"

I.e., a number which is a good compromise on the majority of machines.

Then, on hotplug events you count how many new regions are coming in
and when you reach the total_num_pheaders number, you double it (or some
other increase stragegy), reallocate the ELF header buffers etc needed
for kdump and you're good.

This way, you don't waste memory unnecessarily on the majority of
systems and those who need more, get to allocate more.

> I'd prefer keeping CRASH_MAX_MEMORY_RANGES as that allow the maximum phdr
> number value to be reflective of CPUs and/or memory; not all systems support
> both CPU and memory hotplug. For example, I have queued up this change to
> reflect this:
> 
>     if (IS_ENABLED(CONFIG_HOTPLUG_CPU) || IS_ENABLED(CONFIG_MEMORY_HOTPLUG)) {

If you're going to keep CRASH_MAX_MEMORY_RANGES, then you can test only
that thing as it expresses the dependency on CONFIG_HOTPLUG_CPU and
CONFIG_MEMORY_HOTPLUG already.

If you end up making the number dynamic, then you could make that a
different Kconfig item which contains all that crash code as most of the
people won't need it anyway.

Hmm?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
