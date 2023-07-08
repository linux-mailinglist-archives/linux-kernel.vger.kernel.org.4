Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0620E74BB49
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 04:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbjGHCPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 22:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjGHCPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 22:15:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7AFE6E
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 19:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688782470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Kpy+PGb5drQmeWGSE0l67Lj4CAUJY3SUrpQEp6bMyqo=;
        b=CRFfKgnxOo1cP3iy2qu8XFSDbNrxurz8Ld0g00Tz5N55MBWTam8Wvtc10EpLq8wj0FwfaE
        HzztyJ057PjJviJwnDikyqpEeBDcMjfWyw+fuFoPFmCPlY92k5krHx1jP33olsBSubSo/7
        YVgMN9V3B2UH23dh8NhFPd9Z+dd5coY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-307-iTbWNiJGMhGyjVPRPERf0Q-1; Fri, 07 Jul 2023 22:14:27 -0400
X-MC-Unique: iTbWNiJGMhGyjVPRPERf0Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 799CB800962;
        Sat,  8 Jul 2023 02:14:26 +0000 (UTC)
Received: from darkstar.users.ipa.redhat.com (ovpn-12-59.pek2.redhat.com [10.72.12.59])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B20B1454142;
        Sat,  8 Jul 2023 02:14:20 +0000 (UTC)
Date:   Sat, 8 Jul 2023 10:15:53 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        thunder.leizhen@huawei.com, John.p.donnelly@oracle.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        horms@kernel.org, chenjiahao16@huawei.com,
        linux-riscv@lists.infradead.org, x86@kernel.org, bp@alien8.de
Subject: Re: [RFC PATCH 0/4] kdump: add generic functions to simplify
 crashkernel crashkernel in architecture
Message-ID: <ZKjG2R8RhWmJex53@darkstar.users.ipa.redhat.com>
References: <20230619055951.45620-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619055951.45620-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/19/23 at 01:59pm, Baoquan He wrote:
> In the current arm64, crashkernel=,high support has been finished after
> several rounds of posting and careful reviewing. The code in arm64 which
> parses crashkernel kernel parameters firstly, then reserve memory can be
> a good example for other ARCH to refer to.
> 
> Whereas in x86_64, the code mixing crashkernel parameter parsing and
> memory reserving is twisted, and looks messy. Refactoring the code to
> make it more readable maintainable is necessary.
> 
> Here, try to abstract the crashkernel parameter parsing code into a
> generic function parse_crashkernel_generic(), and the crashkernel memory
> reserving code into a generic function reserve_crashkernel_generic().
> Then, in ARCH which crashkernel=,high support is needed, a simple
> arch_reserve_crashkernel() can be added to call above two generic
> functions. This can remove the duplicated implmentation code in each
> ARCH, like arm64, x86_64.

Hi Baoquan, the parse_crashkernel_common and parse_crashkernel_generic
are confusion to me.  Thanks for the effort though.

I'm not sure if it will be easy or not, but ideally I think the parse
function can be arch independent, something like a general funtion
parse_crashkernel() which can return the whole necessary infomation of
crashkenrel for arch code to use, for example return like
below pseudo stucture(just a concept, may need to think more):

structure crashkernel_range {
	size,
	range,
	struct list_head list;
}

structure crashkernel{
  structure crashkernel_range *range_list;
  union {
  	offset,
  	low_high
  }
}

So the arch code can just get the data of crashkernel and then check
about the details, if it does not support low and high reservation then
it can just ignore the option.

Thoughts?

> 
> I only change the arm64 and x86_64 implementation to make use of the
> generic functions to simplify code. Risc-v can be done very easily refer
> to the steps in arm64 and x86_64. I leave this to Jiahao or other risc-v
> developer since Jiahao have posted a patchset to add crashkernel=,high
> support to risc-v.
> 
> This patchset is based on the latest linus's tree, and on top of below
> patch:
> 
> arm64: kdump: simplify the reservation behaviour of crashkernel=,high
>       https://git.kernel.org/arm64/c/6c4dcaddbd36
> 
> 
> Baoquan He (4):
>   kdump: rename parse_crashkernel() to parse_crashkernel_common()
>   kdump: add generic functions to parse crashkernel and do reservation
>   arm64: kdump: use generic interfaces to simplify crashkernel
>     reservation code
>   x86: kdump: use generic interfaces to simplify crashkernel reservation
>     code
> 
>  arch/arm/kernel/setup.c              |   4 +-
>  arch/arm64/Kconfig                   |   3 +
>  arch/arm64/include/asm/kexec.h       |   8 ++
>  arch/arm64/mm/init.c                 | 141 ++----------------------
>  arch/ia64/kernel/setup.c             |   4 +-
>  arch/loongarch/kernel/setup.c        |   3 +-
>  arch/mips/cavium-octeon/setup.c      |   2 +-
>  arch/mips/kernel/setup.c             |   4 +-
>  arch/powerpc/kernel/fadump.c         |   5 +-
>  arch/powerpc/kexec/core.c            |   4 +-
>  arch/powerpc/mm/nohash/kaslr_booke.c |   4 +-
>  arch/riscv/mm/init.c                 |   5 +-
>  arch/s390/kernel/setup.c             |   4 +-
>  arch/sh/kernel/machine_kexec.c       |   5 +-
>  arch/x86/Kconfig                     |   3 +
>  arch/x86/include/asm/kexec.h         |  32 ++++++
>  arch/x86/kernel/setup.c              | 141 +++---------------------
>  include/linux/crash_core.h           |  33 +++++-
>  kernel/crash_core.c                  | 158 +++++++++++++++++++++++++--
>  19 files changed, 274 insertions(+), 289 deletions(-)
> 
> -- 
> 2.34.1
> 
> 

Thanks
Dave

