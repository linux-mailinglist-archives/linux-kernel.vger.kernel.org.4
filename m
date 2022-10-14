Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104865FEE66
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 15:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiJNNKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 09:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiJNNKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 09:10:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC5287F81;
        Fri, 14 Oct 2022 06:10:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6DB07B822B2;
        Fri, 14 Oct 2022 13:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE029C433D6;
        Fri, 14 Oct 2022 13:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665753026;
        bh=0UWfEXADH79SUIFSFUOzUN9Z7O8mN3bA71DoAjm0o+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RAnusdpMXtsxh0cy7ysADo6KpporNRqVtaAUVHwP4HKdj1SWp7d7KsG0eSoRBmbie
         bxyeKQUzukN8nWu8Ng6T26lghfSZ/EnF+6wHyYA6M0gpbmUVIrv6sQ0pWTCQErzL4L
         XXqyBLNhoX0TSWIvR+Y66zKf4UKT3XlR/zbBpwcKtNoT5TBLkY3jqxm+LIRyYRrWYj
         DaYQp0k6NWcDDTsx2Vfu5iq0GvU9PzFPwCPzQf6U2g0sT48FujD+jzrFUPQm6gMVSf
         rofOMGrFDoT+eBM4miIpcoZ2QLHPz/m3lzPyVbhVpydjG5B7YlF1ds3Nl7bIF3cqLJ
         TuOMEMPfmzngA==
Date:   Fri, 14 Oct 2022 14:10:18 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Xianting Tian <xianting.tian@linux.alibaba.com>,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, anup@brainfault.org, heiko@sntech.de,
        guoren@kernel.org, mick@ics.forth.gr,
        alexandre.ghiti@canonical.com, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, corbet@lwn.net, Conor.Dooley@microchip.com,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        crash-utility@redhat.com, heinrich.schuchardt@canonical.com,
        k-hagio-ab@nec.com, hschauhan@nulltrace.org, yixun.lan@gmail.com
Subject: Re: [PATCH 2/2] Documentation: kdump: describe VMCOREINFO export for
 RISCV64
Message-ID: <Y0lfuixXue4k4poY@spud>
References: <20221014074810.4471-1-xianting.tian@linux.alibaba.com>
 <20221014074810.4471-3-xianting.tian@linux.alibaba.com>
 <Y0ldrJ91ac0um3++@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0ldrJ91ac0um3++@debian.me>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Bagas,

On Fri, Oct 14, 2022 at 08:01:32PM +0700, Bagas Sanjaya wrote:
> On Fri, Oct 14, 2022 at 03:48:10PM +0800, Xianting Tian wrote:
> > The following interrelated definitions and ranges are needed by the kdump
> > crash tool, they are exported by "arch/riscv/kernel/crash_core.c":
> >     VA_BITS,
> >     PAGE_OFFSET,
> >     phys_ram_base,
> >     MODULES_VADDR ~ MODULES_END,
> >     VMALLOC_START ~ VMALLOC_END,
> >     VMEMMAP_START ~ VMEMMAP_END,
> >     KASAN_SHADOW_START ~ KASAN_SHADOW_END,
> >     KERNEL_LINK_ADDR ~ ADDRESS_SPACE_END
> > 
> > Document these RISCV64 exports above.
> > 
> 
> The patch description LGTM, thanks.
> 
> > +----------------------------------------------------------------------------------------------------------------------------------------------------
> > +MODULES_VADDR|MODULES_END|VMALLOC_START|VMALLOC_END|VMEMMAP_START|VMEMMAP_END|KASAN_SHADOW_START|KASAN_SHADOW_END|KERNEL_LINK_ADDR|ADDRESS_SPACE_END
> > +----------------------------------------------------------------------------------------------------------------------------------------------------
> 
> The overline above header text is unnecessary, so I have to strip it:
> 
> ---- >8 ----
> 
> diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
> index 6c7a1728de220e..8e2e164cf3db49 100644
> --- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
> +++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
> @@ -615,7 +615,6 @@ phys_ram_base
>  
>  Indicates the start physical RAM address.
>  
> -----------------------------------------------------------------------------------------------------------------------------------------------------
>  MODULES_VADDR|MODULES_END|VMALLOC_START|VMALLOC_END|VMEMMAP_START|VMEMMAP_END|KASAN_SHADOW_START|KASAN_SHADOW_END|KERNEL_LINK_ADDR|ADDRESS_SPACE_END
>  ----------------------------------------------------------------------------------------------------------------------------------------------------

Without whitespace highlighting, your change threw me for a sec.. But
yeah, having the overline is inconsistent with other headings in the
doc.

What I wanted to ask about was the linelength as I don't know anything
about rst. Is it possible to avoid having the ~150 character line or is
that a necessary evil?

Thanks,
Conor.

>  
> Thanks.
> 
> -- 
> An old man doll... just what I always wanted! - Clara


