Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6AE5F110A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 19:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbiI3Rkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 13:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiI3Rkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 13:40:42 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B54E2B8D
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 10:40:41 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e70a329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e70a:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EE81F1EC01CE;
        Fri, 30 Sep 2022 19:40:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1664559636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=rPlsW5KXga8GPT52DXx9hd1bxPky9/DpS45uUaF1jqQ=;
        b=LAMPYyFU5/elnJA6eLDIg0hj/h8ekXQ+HIwqaG5hORiAdOY3BXtgD2dOu4EWezSox6Kfu4
        cuuNrlmnypVPqorNFf45jNS+fzd5mpIvfODZpSEW+KyeqJhlSqdYQlDu8P8BCxaqaOSm13
        7DNGh8ICOnqiSTOkxmKCmlRCNRD/iVk=
Date:   Fri, 30 Sep 2022 19:40:35 +0200
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
Message-ID: <YzcqE1RVtPcuLlxN@zn.tnic>
References: <20220909210509.6286-1-eric.devolder@oracle.com>
 <20220909210509.6286-8-eric.devolder@oracle.com>
 <Yx7XEcXZ8PwwQW95@nazgul.tnic>
 <cb343eef-46be-2d67-b93a-84c75be86325@oracle.com>
 <YzRxPAoN+XmOfJzV@zn.tnic>
 <fd08c13d-a917-4cd6-85ec-267e0fe74c41@oracle.com>
 <Yzceb/y3SSFMuALR@zn.tnic>
 <d6386653-eb71-188c-8a09-5db46b4e42d4@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d6386653-eb71-188c-8a09-5db46b4e42d4@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 12:11:26PM -0500, Eric DeVolder wrote:
> There is of course a way to enumerate the memory regions in use on the
> machine, that is not what this code needs. In order to compute the maximum
> buffer size needed (this buffer size is computed once), the count of the
> maximum number of memory regions possible (even if not currently in use) is
> what is needed.

Isn't that max number documented somewhere in memory hotplug docs?

Because then you don't need that Kconfig item either. Imagine you're a
distro kernel distributor and you want crash to work on all machines
your kernel works.

So you go and set that number to max. And that would be the 99% of the
kernel configs out there.

Which means, you can just set it to max without a Kconfig item.

> Oh, that would be an error of haste on my part. This should be:
>   depends on CRASH_DUMP && MEMORY_HOTPLUG

You need a Kconfig item which enables all this gunk as MEMORY_HOTPLUG is
not a omnipresent feature. And that Kconfig item should depend on the
other Kconfig items of the technology you need.

> Baoquan pointed me to:
> 
> https://lore.kernel.org/lkml/cover.1656659357.git.naveen.n.rao@linux.vnet.ibm.com/T/

In that thread says:

"- arch_kexec_apply_relocations_add() is only overridden by x86 and s390.
  Retain the function prototype for those and move the weak
  implementation into the header as a static inline for other
  architectures."

So yes, that's even better.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
