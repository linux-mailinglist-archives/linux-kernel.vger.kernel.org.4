Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172BE6DE622
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 23:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjDKVFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 17:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjDKVFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 17:05:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED2B30C4;
        Tue, 11 Apr 2023 14:05:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6E8EB21A0A;
        Tue, 11 Apr 2023 21:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681247139;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7zctrdNUNIuPRnnH6YSgGlzlhIgOGJy0WVsWJrjpI1c=;
        b=Bq83Bse4pGHW5O27Qu0LfHWgyaDyZL6tUnd/WlQ/ncGfZVCH24uuqzDPAnJD2lACRNTdOX
        vBSvpuRp1SZgpl076h2+oZZThD17wMNMnm0oCWSRPWbTFmPe4XHEIYLEoj68Lj2oaOzCO9
        l9PcJs6jSbfv28/kDtOkRq6SAl+5niA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681247139;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7zctrdNUNIuPRnnH6YSgGlzlhIgOGJy0WVsWJrjpI1c=;
        b=/E60z5FOroRILhpYUhoJQHgQUsxcwyfqqpYb0VVFuwMnFfsRh2Ay/+iiBByGj3Tmj+bx7u
        /Vzgg3p5FE+tTLBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2EFEF13519;
        Tue, 11 Apr 2023 21:05:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DOxpCqPLNWRxHgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Tue, 11 Apr 2023 21:05:39 +0000
Date:   Tue, 11 Apr 2023 23:05:37 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Kevin Brodsky <kevin.brodsky@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Petr Vorel <petr.vorel@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ruben Ayrapetyan <ruben.ayrapetyan@arm.com>
Subject: Re: [PATCH RESEND] uapi/linux/const.h: Prefer ISO-friendly __typeof__
Message-ID: <20230411210537.GA1800481@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20230411092747.3759032-1-kevin.brodsky@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411092747.3759032-1-kevin.brodsky@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

> typeof is (still) a GNU extension, which means that it cannot be
> used when building ISO C (e.g. -std=c99). It should therefore be
> avoided in uapi headers in favour of the ISO-friendly __typeof__.

IMHO UAPI are built with -std=c90 -Wall -Werror=implicit-function-declaration
(see usr/include/Makefile).
But one or the other, you're right both require __typeof__.

"If you are writing a header file that must work when included in ISO C
programs, write __typeof__ instead of typeof."
https://gcc.gnu.org/onlinedocs/gcc-12.2.0/gcc/Typeof.html

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Tested-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> Unfortunately this issue could not be detected by
> CONFIG_UAPI_HEADER_TEST=y as the __ALIGN_KERNEL() macro is not
> expanded in any uapi header.

> Reported-by: Ruben Ayrapetyan <ruben.ayrapetyan@arm.com>
> Tested-by: Ruben Ayrapetyan <ruben.ayrapetyan@arm.com>
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> ---
>  include/uapi/linux/const.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/include/uapi/linux/const.h b/include/uapi/linux/const.h
> index af2a44c08683..a429381e7ca5 100644
> --- a/include/uapi/linux/const.h
> +++ b/include/uapi/linux/const.h
> @@ -28,7 +28,7 @@
>  #define _BITUL(x)	(_UL(1) << (x))
>  #define _BITULL(x)	(_ULL(1) << (x))

> -#define __ALIGN_KERNEL(x, a)		__ALIGN_KERNEL_MASK(x, (typeof(x))(a) - 1)
> +#define __ALIGN_KERNEL(x, a)		__ALIGN_KERNEL_MASK(x, (__typeof__(x))(a) - 1)
>  #define __ALIGN_KERNEL_MASK(x, mask)	(((x) + (mask)) & ~(mask))

>  #define __KERNEL_DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
