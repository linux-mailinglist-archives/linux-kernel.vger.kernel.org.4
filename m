Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D0872C303
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 13:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235988AbjFLLiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 07:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235701AbjFLLhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 07:37:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7493D7D93;
        Mon, 12 Jun 2023 04:20:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C2EA6134B;
        Mon, 12 Jun 2023 11:20:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 517FEC433EF;
        Mon, 12 Jun 2023 11:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686568803;
        bh=23JwlmTrqv4IR+K4vNf3mjg3Y1quit9pjndWhP+WBVQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WbVmaT/k2NJ431omJScx8rn6Tr4xCwHvNKr6toopgTYPT/LQMqMpo7FBV6vIGJ4Ih
         +HSkHHWJ35Kcb4B/GPixREIZZBfO6jCqVm2Oj7ei4Ar3Tq5VdX+HzY8hRcQXP/+huS
         OJbyhn41f3IULnSq0wd/dz2lHKMxj8853QNGxSQmcax6UBGdjg1/NwAF+VG6M3OHL2
         ZzOOn7hwX4hqHpXo5AUa9bZN9l3F97lPwSQv46KeDu8M33XqdrFtdbw9tq1DG+/U0P
         7qVFwPAn09GyfkCtFxQ5HZGZsXWZZPEQgoJDyew2d9LSRvZgIIxDgS8gSf/0U6hnid
         f8spn2rSpOb/Q==
Date:   Mon, 12 Jun 2023 12:19:55 +0100
From:   Lee Jones <lee@kernel.org>
To:     Demi Marie Obenour <demi@invisiblethingslab.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH v3 1/4] limits.h: add UCHAR_MAX, SCHAR_MAX, and SCHAR_MIN
Message-ID: <20230612111955.GM3635807@google.com>
References: <20230610204044.3653-1-demi@invisiblethingslab.com>
 <20230610204044.3653-2-demi@invisiblethingslab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230610204044.3653-2-demi@invisiblethingslab.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Jun 2023, Demi Marie Obenour wrote:

> Some drivers already defined these, and they will be used by sscanf()
> for overflow checks later.  Also add SSIZE_MIN to limits.h, which will
> also be needed later.
> 
> Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
> ---
>  .../media/atomisp/pci/hive_isp_css_include/platform_support.h  | 1 -
>  include/linux/limits.h                                         | 1 +
>  include/linux/mfd/wl1273-core.h                                | 3 ---

Acked-by: Lee Jones <lee@kernel.org>

>  include/vdso/limits.h                                          | 3 +++
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/media/atomisp/pci/hive_isp_css_include/platform_support.h b/drivers/staging/media/atomisp/pci/hive_isp_css_include/platform_support.h
> index 0cdef4a5e8b1bed9884133f1a0b9d853d59d43a4..e29b96d8bebf14839f6dd48fdc6c0f8b029ef31d 100644
> --- a/drivers/staging/media/atomisp/pci/hive_isp_css_include/platform_support.h
> +++ b/drivers/staging/media/atomisp/pci/hive_isp_css_include/platform_support.h
> @@ -27,7 +27,6 @@
>  
>  #define UINT16_MAX USHRT_MAX
>  #define UINT32_MAX UINT_MAX
> -#define UCHAR_MAX  (255)
>  
>  #define CSS_ALIGN(d, a) d __attribute__((aligned(a)))
>  
> diff --git a/include/linux/limits.h b/include/linux/limits.h
> index f6bcc936901071f496e3e85bb6e1d93905b12e32..8f7fd85b41fb46e6992d9e5912da00424119227a 100644
> --- a/include/linux/limits.h
> +++ b/include/linux/limits.h
> @@ -8,6 +8,7 @@
>  
>  #define SIZE_MAX	(~(size_t)0)
>  #define SSIZE_MAX	((ssize_t)(SIZE_MAX >> 1))
> +#define SSIZE_MIN	(-SSIZE_MAX - 1)
>  #define PHYS_ADDR_MAX	(~(phys_addr_t)0)
>  
>  #define U8_MAX		((u8)~0U)
> diff --git a/include/linux/mfd/wl1273-core.h b/include/linux/mfd/wl1273-core.h
> index c28cf76d5c31ee1c94a9319a2e2d318bf00283a6..b81a229135ed9f756c749122a8341816031c8311 100644
> --- a/include/linux/mfd/wl1273-core.h
> +++ b/include/linux/mfd/wl1273-core.h
> @@ -204,9 +204,6 @@
>  				 WL1273_IS2_TRI_OPT | \
>  				 WL1273_IS2_RATE_48K)
>  
> -#define SCHAR_MIN (-128)
> -#define SCHAR_MAX 127
> -
>  #define WL1273_FR_EVENT			BIT(0)
>  #define WL1273_BL_EVENT			BIT(1)
>  #define WL1273_RDS_EVENT		BIT(2)
> diff --git a/include/vdso/limits.h b/include/vdso/limits.h
> index 0197888ad0e00b2f853d3f25ffa764f61cca7385..0cad0a2490e5efc194d874025eb3e3b846a5c7b4 100644
> --- a/include/vdso/limits.h
> +++ b/include/vdso/limits.h
> @@ -2,6 +2,9 @@
>  #ifndef __VDSO_LIMITS_H
>  #define __VDSO_LIMITS_H
>  
> +#define UCHAR_MAX	((unsigned char)~0U)
> +#define SCHAR_MAX	((signed char)(UCHAR_MAX >> 1))
> +#define SCHAR_MIN	((signed char)(-SCHAR_MAX - 1))
>  #define USHRT_MAX	((unsigned short)~0U)
>  #define SHRT_MAX	((short)(USHRT_MAX >> 1))
>  #define SHRT_MIN	((short)(-SHRT_MAX - 1))
> -- 
> Sincerely,
> Demi Marie Obenour (she/her/hers)
> Invisible Things Lab
> 

-- 
Lee Jones [李琼斯]
