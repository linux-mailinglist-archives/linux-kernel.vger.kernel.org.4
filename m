Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA405FCA08
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 19:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiJLRqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 13:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJLRq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 13:46:28 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2B4C97F4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 10:46:27 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e705329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e705:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E58A01EC0230;
        Wed, 12 Oct 2022 19:46:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1665596782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Meljy89lAYExQlzfDo2HCH7IawAQ8LDvQAy651p5TKE=;
        b=eZymPjEFV/FwQ8Rxc+xKEUGadAuWqwhaK1hnhI9q3UT0JUCatTADf74Y4LJuMtCmnplwLu
        WT5stDquCviENtkSPoBEDcHALazjwMlGx+sYEsBNZc2KpzhrIxBA6tBl91O1i1n1GT0EKD
        9PU6VGgv4181HTIajDnoQoTkcA1qhXo=
Date:   Wed, 12 Oct 2022 19:46:18 +0200
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
Message-ID: <Y0b9apyIs+RpSo1e@zn.tnic>
References: <20220909210509.6286-1-eric.devolder@oracle.com>
 <20220909210509.6286-8-eric.devolder@oracle.com>
 <Yx7XEcXZ8PwwQW95@nazgul.tnic>
 <cb343eef-46be-2d67-b93a-84c75be86325@oracle.com>
 <YzRxPAoN+XmOfJzV@zn.tnic>
 <fd08c13d-a917-4cd6-85ec-267e0fe74c41@oracle.com>
 <Yzceb/y3SSFMuALR@zn.tnic>
 <d6386653-eb71-188c-8a09-5db46b4e42d4@oracle.com>
 <YzcqE1RVtPcuLlxN@zn.tnic>
 <Y0Dh4ieUUZ4oXa1/@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y0Dh4ieUUZ4oXa1/@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 08, 2022 at 10:35:14AM +0800, Baoquan He wrote:
> Memory hptlug is not limited by a certin or a max number of memory
> regions, but limited by how large of the linear mapping range which
> physical can be mapped into.

Memory hotplug is not limited by some abstract range but by the *actual*
possibility of how many DIMM slots on any motherboard can hotplug
memory. Certainly not 32K.

So you can choose a sane default which covers *all* actual systems out
there.

> For the Kconfig CRASH_MAX_MEMORY_RANGES Eric added, it's meaningful to
> me to set a fixed value which is enough in reality.

Yes, exactly.

> For extreme testing with special purpose, it could be broken easily,
> people need decide by self whether the CONFIG_CRASH_MAX_MEMORY_RANGES
> is enlarged or not.

I don't want for people to decide on one more thing where they have to
go and read a bunch of specs just to know what is a good value. So we
should set a sane, *practical* upper limit and simply go with it.

Everything else is testing stuff and if you test the kernel, then you
can change limits and values and so on as you want to.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
