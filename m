Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C51B5EC5E1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 16:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbiI0OWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 10:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbiI0OV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:21:29 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DDFF1606
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:21:28 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id u69so9566528pgd.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=gQXzOLwGmO1I9pRRmLyUgJGlaUsyPlUGTQU3NVybLL0=;
        b=bNtC1TfMH2+cAv7Euw3nzYRDnmQOZRc3adBLCBjxHaQ2ZY5rhPwXfbAwqqo8ZWCrqb
         IZBnoqzcm+OcLDaBpTsVUqWjfi+2I8ytmMuoa03gPv7a1n8LS3QywDVvHn9G7bnyB7a1
         pXQmpycGDSBRDCG3adiC7zHKC9qVkBhS4U3YY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=gQXzOLwGmO1I9pRRmLyUgJGlaUsyPlUGTQU3NVybLL0=;
        b=lYE47mpDxUHpDIs7bIfhq3WBHoIDmzkTbKR2T0Y+u1OHJzQnprhGA9TXDqGWzTf5Od
         qNYdohKeLmjOkee3N/Ip9v8OH7tw/tieWxQsNt0ONw8yH7lkOElujZQ83ikGz+2pLRz6
         g4+P4ezkKW7JYM3Gy5Xu8gBS9pyNk0ri9yRK9nNPI4RRMmWdq2wm1+E+tuhd4B0jW2o+
         QNqZ7GNclH7xEyG2C1W0XqXQNIt4/kDN3NLQvwJyx3QcBolZOwpKAZq6Fo3vTWG5cnsd
         ckOIXnIC3AM3enWH4OYDgSKmpnswvnyVomXnkNlE8HaMlgbnpzx/rYKknbatr1T5Kign
         0bMw==
X-Gm-Message-State: ACrzQf0x1U2HJA+wyvEcCAUQzW/Z279h8e6sKZet2Y/+v/fb1p7z41Mz
        HpArnlNtbum8pgFWuEHHFVdiHnPx37ksUg==
X-Google-Smtp-Source: AMsMyM73XMgV1Do/e1WlYdtJReSLR3vkVg8q1kwNQyYvR+63k4h7qUAuxztbvazlfBRFjC+dY+//Cw==
X-Received: by 2002:a63:8b4c:0:b0:43c:bf35:1c7e with SMTP id j73-20020a638b4c000000b0043cbf351c7emr7683458pge.475.1664288488356;
        Tue, 27 Sep 2022 07:21:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k11-20020a63ff0b000000b0043ab80adf63sm1571117pgi.36.2022.09.27.07.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 07:21:27 -0700 (PDT)
Date:   Tue, 27 Sep 2022 07:21:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH] sethostname: dump new hostname into RNG
Message-ID: <202209270720.4CEAC77@keescook>
References: <20220927094039.1563219-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927094039.1563219-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 11:40:39AM +0200, Jason A. Donenfeld wrote:
> On some small machines with little entropy, a quasi-unique hostname is
> sometimes a relevant factor. I've seen, for example, 8 character
> alpha-numeric serial numbers. In addition, the time at which the hostname
> is set is usually a decent measurement of how long early boot took. So,
> call add_device_randomness() on new hostnames, which feeds its arguments
> to the RNG in addition to a fresh cycle counter.
> 
> Low cost hooks like this never hurt and can only ever help, and since
> this costs basically nothing for an operation that is never a fast path,
> this is an overall easy win.

Seems reasonable!

Reviewed-by: Kees Cook <keescook@chromium.org>

> 
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  kernel/sys.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/sys.c b/kernel/sys.c
> index b911fa6d81ab..7b7f973ea585 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -1366,6 +1366,7 @@ SYSCALL_DEFINE2(sethostname, char __user *, name, int, len)
>  	if (!copy_from_user(tmp, name, len)) {
>  		struct new_utsname *u;
>  
> +		add_device_randomness(tmp, len);
>  		down_write(&uts_sem);
>  		u = utsname();
>  		memcpy(u->nodename, tmp, len);
> -- 
> 2.37.3
> 

-- 
Kees Cook
