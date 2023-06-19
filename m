Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88417734B92
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 08:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjFSGKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 02:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjFSGKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 02:10:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC6283
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 23:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687155007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WGDrBUF36TLreoIVg0sYhBbDfxOAFyjjLH/MwCEaO0o=;
        b=imbP6qycGgm7xhKoqn+AK0Pj7KAiNUNaGW7xYsIbJWCwYAKudV3aJXKuFzF0FmjGECahXL
        JJqH+2XD1wjuBoYSerleBdntrG3ayxUWYQFG36FK6623fnl3AhH4GjER6s3wpj8Yz09ih/
        dv7Hj2jsvr7fwz7ubwK1eoGiue33xeI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-349-H6uWdKehPG-vx_7-Qi-58Q-1; Mon, 19 Jun 2023 02:10:04 -0400
X-MC-Unique: H6uWdKehPG-vx_7-Qi-58Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 911883C025AC;
        Mon, 19 Jun 2023 06:10:03 +0000 (UTC)
Received: from localhost (ovpn-12-194.pek2.redhat.com [10.72.12.194])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 81DA2112132C;
        Mon, 19 Jun 2023 06:10:01 +0000 (UTC)
Date:   Mon, 19 Jun 2023 14:09:58 +0800
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, thunder.leizhen@huawei.com,
        John.p.donnelly@oracle.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, horms@kernel.org,
        chenjiahao16@huawei.com, linux-riscv@lists.infradead.org,
        x86@kernel.org, bp@alien8.de
Subject: Re: [RFC PATCH 0/4] kdump: add generic functions to simplify
 crashkernel crashkernel in architecture
Message-ID: <ZI/xNm23BCNcB0+v@MiWiFi-R3L-srv>
References: <20230619055951.45620-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619055951.45620-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
                       ^ 'and' missed
> 
> Here, try to abstract the crashkernel parameter parsing code into a
> generic function parse_crashkernel_generic(), and the crashkernel memory
> reserving code into a generic function reserve_crashkernel_generic().
> Then, in ARCH which crashkernel=,high support is needed, a simple
> arch_reserve_crashkernel() can be added to call above two generic
> functions. This can remove the duplicated implmentation code in each
> ARCH, like arm64, x86_64.
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

