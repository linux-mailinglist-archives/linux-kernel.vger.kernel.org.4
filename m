Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21BC76235D7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 22:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbiKIVbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 16:31:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKIVbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 16:31:23 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BFF7659
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 13:31:22 -0800 (PST)
Received: from zn.tnic (p200300ea9733e7bc329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7bc:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 094B61EC063F;
        Wed,  9 Nov 2022 22:31:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1668029481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ZVuAEP7EZJD1bSmxJ8gb2o1Y328HRP3H25tj29o45V8=;
        b=VhK+4kugpuZrqOzjcVJFEOya0RABF34TBESQEqw49x4MCk5qbzJJ6ucw6BjfZRhyR4tORv
        +FL/nQEEWAKdEmR/dKv48qF9AYwFzl4FDSlTjNKg0l210qAK07k8SvfsgiJUD9b5cJxGTR
        9Tgq13YrK2qJ2FjhI+ikBtQOxn+IB8c=
Date:   Wed, 9 Nov 2022 22:31:16 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
Subject: Re: [PATCH v13 7/7] x86/crash: add x86 crash hotplug support
Message-ID: <Y2wcJOehWcG7w5c4@zn.tnic>
References: <20221031193604.28779-1-eric.devolder@oracle.com>
 <20221031193604.28779-8-eric.devolder@oracle.com>
 <Y2A4TqyOaPYBu4Hk@zn.tnic>
 <1c11a429-b5a9-fb55-fbef-b49e760e2d1e@oracle.com>
 <Y2I3zQ9ZU+C9Kgf7@zn.tnic>
 <cd820d8a-7ce9-c32f-fc84-bbf20dd7d6e5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cd820d8a-7ce9-c32f-fc84-bbf20dd7d6e5@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 09:48:33AM -0600, Eric DeVolder wrote:
> ...
> which then defaults HOTPLUG_CPU to on and thus this code/ifdef in question.

defconfig can sometimes lag reality. In this case, the majority of
machines have SMP=y because the majority of machines out there are,
well, multicore.

> So at this point, I'm still not sure if you want the ifdef line:
>  - removed altogether
>  - transitioned to CRASH_HOTPLUG
>  - leave as is

So let's think out loud:

* the majority of machines will have CONFIG_HOTPLUG_CPU=y because
they're SMP machines and we want the elfcorehdr updates to happen when
CPUs get offlined or onlined.

CONFIG_MEMORY_HOTPLUG is most likely going to be =n on the majority of
machines out there.

(Note how the deciding factor for all this is what would make sense on
the prevailing majority of machines out there.)

And memory hotplug will be off for the simple reason that not so many
machines have memory hotplug hardware capability.

Which then means, IMHO, this functionality should be separate: have a
CPU hotplug callback and a memory hotplug callback.

And you kinda do that in

Subject: [PATCH v13 3/7] crash: add generic infrastructure for crash hotplug support

but then this all calls into a single handle_hotplug_event() and that
hp_action doesn't really matter.

It is used in the call to

  arch_crash_handle_hotplug_event(image, hp_action);

but that hp_action argument is unused in the x86 version.

IOW, you can do this callback regardless whether it is a CPU or memory
hotplug event.

So thinking about it, a single CONFIG_CRASH_HOTPLUG which unifies those
CPU and memory hotplug callback functionality makes most sense to me.
Because you don't really differentiate between the two in the callback
actions.

Anyway, this is how I see it from here. I could very well be missing an
aspect, of course.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
