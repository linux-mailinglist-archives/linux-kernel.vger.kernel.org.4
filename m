Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7965B3690
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 13:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiIILkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 07:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbiIILjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 07:39:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7871CD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 04:39:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4531961FC5
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 11:39:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 066AFC433D7;
        Fri,  9 Sep 2022 11:39:19 +0000 (UTC)
Date:   Fri, 9 Sep 2022 12:39:16 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     george pee <georgepee@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        "Kirill A. Shutemov" <kirill.shtuemov@linux.intel.com>,
        Austin Kim <austindh.kim@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Report support for optional ARMv8.2 half-precision
 floating point extension
Message-ID: <Yxsl5PaioteeAcnh@arm.com>
References: <20220901141307.2361752-1-georgepee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901141307.2361752-1-georgepee@gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 09:13:05AM -0500, george pee wrote:
> Report as fphp to be consistent with arm64

Do you have a use-case as well? It may help deciding what to do with
this.

> diff --git a/arch/arm/include/uapi/asm/hwcap.h b/arch/arm/include/uapi/asm/hwcap.h
> index 990199d8b7c6..f975845ce5d3 100644
> --- a/arch/arm/include/uapi/asm/hwcap.h
> +++ b/arch/arm/include/uapi/asm/hwcap.h
> @@ -28,6 +28,7 @@
>  #define HWCAP_IDIV	(HWCAP_IDIVA | HWCAP_IDIVT)
>  #define HWCAP_LPAE	(1 << 20)
>  #define HWCAP_EVTSTRM	(1 << 21)
> +#define HWCAP_FPHP	(1 << 22)

I think with ARMv8 features on the arm32 kernel we tend to add them to
HWCAP2_*. With such change:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

I'll leave the decision to Russell on whether he wants this merged. An
argument may be that people still want to run 32-bit user-space and even
if they use am arm64 kernel, we can't add a COMPAT_HWCAP2_FPHP until we
have the arm32 counterpart. An alternative may be to only add the uapi
definition under arch/arm but without any functionality (so never
exposed to user). The arm64 kernel could expose it to compat tasks.

So, if Russell is ok with any of the options above, please also add the
compat arm64 support ;).

-- 
Catalin
