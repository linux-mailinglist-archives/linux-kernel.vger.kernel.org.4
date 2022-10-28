Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B43611B8D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 22:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiJ1Uay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 16:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiJ1Uav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 16:30:51 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AA095AED
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 13:30:48 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e7ce329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7ce:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 758D11EC06D8;
        Fri, 28 Oct 2022 22:30:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1666989047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=wV+E+/SMNeV699Rje9XOtWwOh+RoW8MB13Rtk2kIH54=;
        b=Zgd42Z5SFTE8Xc3j3xc1VSLfYMBJFZVxHZyh6fjY141Qi+2badS1kc1kDjx2+dxSbyqIRK
        dcu+8tgMur56gLjZL1CFgFjliSpNQn6T0MLV2JsrpxAhn/1OVcXtElWXfTcn+cHOFE2mFr
        X7eDXclf2JgXUf9AC3BZRYyu1Kw+mig=
Date:   Fri, 28 Oct 2022 22:30:33 +0200
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
Message-ID: <Y1w76RwZUKUvsS7A@zn.tnic>
References: <53aed03e-2eed-09b1-9532-fe4e497ea47d@oracle.com>
 <Y0cmaPTKQuWtwIRh@zn.tnic>
 <Y0d+mFivS+88+Chr@MiWiFi-R3L-srv>
 <Y1e7Hw0PRDI9NxU9@zn.tnic>
 <Y1lIoTBNvHrKX5K9@MiWiFi-R3L-srv>
 <35c98ca6-10f8-b248-78c5-99fce7e66c65@oracle.com>
 <Y1uspLb7fLdtnQq+@zn.tnic>
 <d91f8728-6a63-415d-577c-bd76e69ec7f6@oracle.com>
 <Y1wL+ZrvD5gTZaKN@zn.tnic>
 <ca43bd5f-8a74-9412-3d4b-52c7d5e54978@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ca43bd5f-8a74-9412-3d4b-52c7d5e54978@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 02:26:58PM -0500, Eric DeVolder wrote:
> config CRASH_MAX_MEMORY_RANGES
>     depends on CRASH_DUMP && KEXEC_FILE && MEMORY_HOTPLUG
>     int
>     default 8192
>     help
>       For the kexec_file_load path, specify the maximum number of
>       memory regions, eg. as represented by the 'System RAM' entries
>       in /proc/iomem, that the elfcorehdr buffer/segment can accommodate.
>       This value is combined with NR_CPUS and multiplied by Elf64_Phdr
>       size to determine the final buffer size.

No, do this:

config CRASH_MEMORY_HOTPLUG_SUPPORT
    depends on CRASH_DUMP && KEXEC_FILE && MEMORY_HOTPLUG
    help
      Help text explaining what this feature is

this thing will simply get enabled when the user enables MEMORY_HOTPLUG
and CRASH_DUMP.

and then you do in the code:

/*
 * A comment explaining how the 8192 value has been selected.
 */
#define CRASH_MAX_MEMORY_RANGES	8192

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
