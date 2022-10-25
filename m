Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C52160CA1F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 12:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbiJYKcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 06:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbiJYKcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 06:32:01 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC42D8ED3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 03:32:00 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e753329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e753:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 594351EC04CB;
        Tue, 25 Oct 2022 12:31:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1666693919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ai++jgLmenhahiBLse1vLJYEB/bd3+G6lQ4acR+CSyY=;
        b=P0z3I0xwj2YyygD/nk8kPmHQz8xOPhwrirQ4FKwWdW+LYy3NzSZiRAcnVsDad4/4TyA+Id
        C+dIkSRTyCBWdW6AUgSdcRLJzREMPfzuSdYMC78Rx5/r6BqAXRtj4u1KDAn+pdlC6xIfU4
        MRXEub1PBMS0Jdrf8LEWllVjz5u5FYg=
Date:   Tue, 25 Oct 2022 12:31:59 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Baoquan He <bhe@redhat.com>
Cc:     Eric DeVolder <eric.devolder@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, david@redhat.com,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        sourabhjain@linux.ibm.com, linux-mm@kvack.org
Subject: Re: [PATCH v12 7/7] x86/crash: Add x86 crash hotplug support
Message-ID: <Y1e7Hw0PRDI9NxU9@zn.tnic>
References: <YzRxPAoN+XmOfJzV@zn.tnic>
 <fd08c13d-a917-4cd6-85ec-267e0fe74c41@oracle.com>
 <Yzceb/y3SSFMuALR@zn.tnic>
 <d6386653-eb71-188c-8a09-5db46b4e42d4@oracle.com>
 <YzcqE1RVtPcuLlxN@zn.tnic>
 <Y0Dh4ieUUZ4oXa1/@MiWiFi-R3L-srv>
 <Y0b9apyIs+RpSo1e@zn.tnic>
 <53aed03e-2eed-09b1-9532-fe4e497ea47d@oracle.com>
 <Y0cmaPTKQuWtwIRh@zn.tnic>
 <Y0d+mFivS+88+Chr@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y0d+mFivS+88+Chr@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 10:57:28AM +0800, Baoquan He wrote:
> The concern to range number mainly is on Virt guest systems.

And why would virt emulate 1K hotpluggable DIMM slots and not emulate a
real machine?

> On baremetal system, basically only very high end server support
> memory hotplug. I ever visited customer's lab and saw one server,
> it owns 8 slots, on each slot a box containing about 20 cpus and 2T
> memory at most can be plugged in at one time. So people won't make too
> many slots for hotplugging since it's too expensive.

There you have it - the persuading argument.

> I checked user space kexec code, the maximum memory range number is
> honored to x86_64 because of a HPE SGI system. After that, nobody
> complains about it. Please see below user space kexec-tools commit in
> https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
> 
> The memory ranges may be not all made by different DIMM slots, could be
> firmware reservatoin, e.g efi/BIOS diggged out physical memory,
			    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

I don't know what that means.

If it is firmware crap, you want to exclude that from kdump anyway.

> Now CONFIG_NR_CPUS has the maximum number as 8192. And user space
> kexec-tools has maximum memory range number as 2048. We can take
> the current 8192 + 2048  = 10K as default value conservatively. Or
> take 8192 + 2048 * 2 = 12K which has two times of maximum memory range
> bumber in kexec-tools. What do you think?

I still think that we should stick to reality and support what is
possible not what is potentially and theoretically there.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
