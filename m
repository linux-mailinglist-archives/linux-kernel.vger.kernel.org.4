Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C00960CA39
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 12:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbiJYKjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 06:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbiJYKjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 06:39:41 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D860AD88
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 03:39:35 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e753329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e753:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 77F211EC04CB;
        Tue, 25 Oct 2022 12:39:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1666694374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=bJEdtbRqgdbjhqUqDGLu9oDkYSzHvDi/vH6BXxoFAh8=;
        b=JxIF5aD8t+drPh0XyHi/aIDkukRMN7v+nUHqpoC0kztFZF/DC3CYHhIjv8G0wKaXyWcgJ2
        NJswHW8qF/0qgkCUBTscjqoybTkfq7npVh1L77t2FH8Z+j9aYvMn2i6v+EnvcLXRHTv8xn
        0ypbB4muvtXV4mgjUbabEqF3ztjeN8Y=
Date:   Tue, 25 Oct 2022 12:39:34 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, david@redhat.com,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        sourabhjain@linux.ibm.com, linux-mm@kvack.org
Subject: Re: [PATCH v12 7/7] x86/crash: Add x86 crash hotplug support
Message-ID: <Y1e85gqB3kzlx7qL@zn.tnic>
References: <20220909210509.6286-1-eric.devolder@oracle.com>
 <20220909210509.6286-8-eric.devolder@oracle.com>
 <Yx7XEcXZ8PwwQW95@nazgul.tnic>
 <cb343eef-46be-2d67-b93a-84c75be86325@oracle.com>
 <YzRxPAoN+XmOfJzV@zn.tnic>
 <fd08c13d-a917-4cd6-85ec-267e0fe74c41@oracle.com>
 <Yzceb/y3SSFMuALR@zn.tnic>
 <d6386653-eb71-188c-8a09-5db46b4e42d4@oracle.com>
 <YzcqE1RVtPcuLlxN@zn.tnic>
 <bec2e406-bd4f-e845-6216-31c74619819b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bec2e406-bd4f-e845-6216-31c74619819b@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 11:20:59AM -0500, Eric DeVolder wrote:
> I once had CONFIG_CRASH_HOTPLUG, but you disagreed.
> 
> https://lore.kernel.org/lkml/Ylgot+LUDQl+G%2F5N@zn.tnic/
> 
> From there I simply went with
> 
>  #if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
> 
> which route do you prefer?

If you do a single Kconfig item which depends on those two, it probably
is cleaner this way. And if the max memory ranges are hardcoded you
don't need the other prompt asking the user something she most likely
doesn't know how to answer properly.

That is, unless you wanna have that crash hotplug built in all the time.

Because CONFIG_HOTPLUG_CPU is pretty much always enabled so you might
just as well add the crash hotplug support unconditionally, without any
Kconfig ifdeffery whatsoever except CONFIG_MEMORY_HOTPLUG as that is
special and not present on the majority of hardware.

But on a plain simple laptop or workstation which has CPU hotplug, would
it make sense for the crash ranges to get updated too when CPUs are
offlined?

If so, I think you want this code present there too, without a Kconfig
item.

If this is server-only anyway, then a single Kconfig item sounds like
not such a bad idea.

I hope that makes some sense.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
