Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D958A5BFB9A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiIUJr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbiIUJrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:47:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0253E915E9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:44:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50DD3139F;
        Wed, 21 Sep 2022 02:44:58 -0700 (PDT)
Received: from [10.57.17.233] (unknown [10.57.17.233])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D40383F73D;
        Wed, 21 Sep 2022 02:44:50 -0700 (PDT)
Message-ID: <ad42d19d-959c-61b4-8581-02ce0990c23f@arm.com>
Date:   Wed, 21 Sep 2022 10:44:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] lib/vdso: use "grep -E" instead of "egrep"
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20220920170633.3133829-1-gregkh@linuxfoundation.org>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <20220920170633.3133829-1-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/22 18:06, Greg Kroah-Hartman wrote:
> The latest version of grep claims the egrep is now obsolete so the build
> now contains warnings that look like:
> 	egrep: warning: egrep is obsolescent; using grep -E
> fix this up by moving the vdso Makefile to use "grep -E" instead.
> 
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  lib/vdso/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/vdso/Makefile b/lib/vdso/Makefile
> index c415a685d61b..e814061d6aa0 100644
> --- a/lib/vdso/Makefile
> +++ b/lib/vdso/Makefile
> @@ -17,6 +17,6 @@ $(error ARCH_REL_TYPE_ABS is not set)
>  endif
>  
>  quiet_cmd_vdso_check = VDSOCHK $@
> -      cmd_vdso_check = if $(OBJDUMP) -R $@ | egrep -h "$(ARCH_REL_TYPE_ABS)"; \
> +      cmd_vdso_check = if $(OBJDUMP) -R $@ | grep -E -h "$(ARCH_REL_TYPE_ABS)"; \
>  		       then (echo >&2 "$@: dynamic relocations are not supported"; \
>  			     rm -f $@; /bin/false); fi

-- 
Regards,
Vincenzo
