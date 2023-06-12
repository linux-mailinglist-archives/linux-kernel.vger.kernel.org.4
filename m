Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B80872CB8C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 18:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236929AbjFLQcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 12:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236772AbjFLQcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 12:32:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 491E71B3;
        Mon, 12 Jun 2023 09:32:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A17621FB;
        Mon, 12 Jun 2023 09:32:53 -0700 (PDT)
Received: from [192.168.4.21] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61BB23F5A1;
        Mon, 12 Jun 2023 09:32:04 -0700 (PDT)
Message-ID: <4c01e43a-0275-04a0-ad9d-ee2f2bf24e1c@arm.com>
Date:   Mon, 12 Jun 2023 17:31:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 1/4] limits.h: add UCHAR_MAX, SCHAR_MAX, and SCHAR_MIN
To:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Lee Jones <lee@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
References: <20230610204044.3653-1-demi@invisiblethingslab.com>
 <20230610204044.3653-2-demi@invisiblethingslab.com>
Content-Language: en-US
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <20230610204044.3653-2-demi@invisiblethingslab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Demi,

On 6/10/23 21:40, Demi Marie Obenour wrote:
> Some drivers already defined these, and they will be used by sscanf()
> for overflow checks later.  Also add SSIZE_MIN to limits.h, which will
> also be needed later.
> 
> Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
> ---
>  .../media/atomisp/pci/hive_isp_css_include/platform_support.h  | 1 -
>  include/linux/limits.h                                         | 1 +
>  include/linux/mfd/wl1273-core.h                                | 3 ---
>  include/vdso/limits.h                                          | 3 +++
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
...

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

Are you planning to use those definitions in the vDSO library?

If not can you please define them in linux/limits.h, the vdso headers contain
only what is necessary for the vDSO library.

Thanks!

>  #define USHRT_MAX	((unsigned short)~0U)
>  #define SHRT_MAX	((short)(USHRT_MAX >> 1))
>  #define SHRT_MIN	((short)(-SHRT_MAX - 1))

-- 
Regards,
Vincenzo
