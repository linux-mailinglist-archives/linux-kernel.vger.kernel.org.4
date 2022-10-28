Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5D26118E5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 19:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbiJ1RIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 13:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbiJ1RIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 13:08:20 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D6D237955
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 10:06:17 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e7ce329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7ce:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2027D1EC0676;
        Fri, 28 Oct 2022 19:06:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1666976765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=UpitehZpLYGjIwKABq3amz3Mj5g5BAkI3R/OCX9YIGU=;
        b=sYaqnLEfiGpccG69Zo0DHQ8p82KZKaS9i7HHJxG1ytsE2O6MRw9p46NNgIzbmM8HV7b4Wh
        aDsWDGjCtw54+5Ag2KuMSALI2dA70QKjaOXaHGWQmTKnu2gNxUBncbpmflVX7+4m8keEFE
        Lbb2fSANN7sbNULJMbKglClTrthTZcY=
Date:   Fri, 28 Oct 2022 19:06:01 +0200
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
Message-ID: <Y1wL+ZrvD5gTZaKN@zn.tnic>
References: <Y0Dh4ieUUZ4oXa1/@MiWiFi-R3L-srv>
 <Y0b9apyIs+RpSo1e@zn.tnic>
 <53aed03e-2eed-09b1-9532-fe4e497ea47d@oracle.com>
 <Y0cmaPTKQuWtwIRh@zn.tnic>
 <Y0d+mFivS+88+Chr@MiWiFi-R3L-srv>
 <Y1e7Hw0PRDI9NxU9@zn.tnic>
 <Y1lIoTBNvHrKX5K9@MiWiFi-R3L-srv>
 <35c98ca6-10f8-b248-78c5-99fce7e66c65@oracle.com>
 <Y1uspLb7fLdtnQq+@zn.tnic>
 <d91f8728-6a63-415d-577c-bd76e69ec7f6@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d91f8728-6a63-415d-577c-bd76e69ec7f6@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 10:29:45AM -0500, Eric DeVolder wrote:
> So it is with this in mind that I suggest we stay with the statically sized elfcorehdr buffer.
> 
> If that can be agreed upon, then it is "just a matter" of picking a useful
> elfcorehdr size. Currently that size is derived from the NR_DEFAULT_CPUS and
> CRASH_MAX_MEMORY_RANGES. So, there is still the CRASH_MAX_MEMORY_RANGES knob
> to help a dial in size, should there be some issue with the default
> value/size.

Let's see

        kbuf.memsz =
                (CONFIG_NR_CPUS_DEFAULT + CONFIG_CRASH_MAX_MEMORY_RANGES) *
                        sizeof(Elf64_Phdr);

which, IINM, is

	(8192 + 32768) * 56

which is something like 2M.

(CONFIG_NR_CPUS_DEFAULT = 8192 - this is because of MAXSMP which gets
set on distro kernels)

Now, since userspace kexec tools uses 2048 for max memory ranges, that
size becomes smaller - around half a Mb. And since y'all wanna be on the
safe side, you can quadruple it and have

	(8192 + 8192) * 56

which is still under a megabyte. And that's fine, I guess, on a big
server.

> Or if there is desire to drop computing the size from NR_DEFAULT_CPUs and

I think you should leave the dependency on the Kconfig size so that
smaller machines which are configured this way, don't end up wasting
unnecessary memory.

> It is my intention to correct the CRASH_MAX_MEMORY_RANGES (if we keep it) as such:
> 
> config CRASH_MAX_MEMORY_RANGES
>     depends on CRASH_DUMP && KEXEC_FILE && MEMORY_HOTPLUG

Yes, but don't leave it to the user to decide what number to choose
- choose a high enough number, explain why you've chosen this with a
comment and that's it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
