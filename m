Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652D173C4A3
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 01:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbjFWXEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 19:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjFWXEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 19:04:31 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DD62683
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 16:04:15 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b516978829so8884195ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 16:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687561454; x=1690153454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=txk/WCv0OBhqw9zoLMLfCR3j+gSVpnW3ej3zmqExqts=;
        b=d4koG09azfxSCVGLfelgqL70MwsGRvFhiHye8G1ibWTbiAlwYKkiXEgRA7MVEszIrQ
         lq/XF6Hvc2cwYKb+9z95P5Mo/84eQ8uG0JTE8EHZnIGpinNzlWR203L8bYiYTUXQS1ot
         oIXJurB6gQleI3DNXTk6lg0W3Y+kytz7MdR4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687561454; x=1690153454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txk/WCv0OBhqw9zoLMLfCR3j+gSVpnW3ej3zmqExqts=;
        b=NdDxalQTmW1WeAgjdifH8RmujdYt2M40PREImLHaCBBGefsC0rML9gl2/gpx52lyCg
         aHeaIlYdqquex36397UPJ+LYXiZn7gku+WHNtuV3Ck/B35UAqvlq8ZQXHmIUv4J2i28J
         u576jvEvJfR8GCKSthGbqj6iuU/Ffvu8n5raq+pSaaeYGC1WouAsV9G1aRl3AQxW6nIp
         fW3XYcsU2/KYnskyATeP2YQXupkMJF5lyi8rIHkbG/DcZM5hM7QWm7K1ZNHaEHUU/z5/
         d6Z+I/AghO/uIQ6yO2xDqqBLuFXqI/b3bQe3l+WiQlc6uKnZNAu1eCFU5IfcAI9fDHTA
         p7Dw==
X-Gm-Message-State: AC+VfDy1vtC4m3Ese1luXTZtwN42aczu2ITfcASC4DOZXEPmG6cUHgue
        FQHyq5vHadZJexD72kDwPssgaw==
X-Google-Smtp-Source: ACHHUZ5J8MxKADVnZolSnbEzIOOF7z2KKtfA3Sz4OWPiqJU0GKUS0w2z2p5eliBQlKKH4eaxU6DXyg==
X-Received: by 2002:a17:902:6b86:b0:1b6:972f:9dfb with SMTP id p6-20020a1709026b8600b001b6972f9dfbmr464770plk.3.1687561454702;
        Fri, 23 Jun 2023 16:04:14 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g24-20020a170902869800b001b531e8a000sm79002plo.157.2023.06.23.16.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 16:04:13 -0700 (PDT)
Date:   Fri, 23 Jun 2023 16:04:13 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Christian Lamparter <chunkeey@googlemail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] carl9170: re-fix fortified-memset warning
Message-ID: <202306231549.CC5FE5D69@keescook>
References: <20230623152443.2296825-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623152443.2296825-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 05:23:59PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The carl9170_tx_release() function sometimes triggers a fortified-memset
> warning in my randconfig builds:
> 
> In file included from include/linux/string.h:254,
>                  from drivers/net/wireless/ath/carl9170/tx.c:40:
> In function 'fortify_memset_chk',
>     inlined from 'carl9170_tx_release' at drivers/net/wireless/ath/carl9170/tx.c:283:2,
>     inlined from 'kref_put' at include/linux/kref.h:65:3,
>     inlined from 'carl9170_tx_put_skb' at drivers/net/wireless/ath/carl9170/tx.c:342:9:
> include/linux/fortify-string.h:493:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
>   493 |                         __write_overflow_field(p_size_field, size);
> 
> Kees previously tried to avoid this by using memset_after(), but it seems
> this does not fully address the problem. I noticed that the memset_after()
> here is done on a different part of the union (status) than the original
> cast was from (rate_driver_data), which may confuse the compiler.
> 
> Unfortunately, the memset_after() trick does not work on driver_rates[]
> because that is part of an anonymous struct, and I could not get
> struct_group() to do this either. Using two separate memset() calls
> on the two members does address the warning though.
> 
> Fixes: fb5f6a0e8063b ("mac80211: Use memset_after() to clear tx status")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/net/wireless/ath/carl9170/tx.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/carl9170/tx.c b/drivers/net/wireless/ath/carl9170/tx.c
> index 6bb9aa2bfe654..88ef6e023f826 100644
> --- a/drivers/net/wireless/ath/carl9170/tx.c
> +++ b/drivers/net/wireless/ath/carl9170/tx.c
> @@ -280,7 +280,8 @@ static void carl9170_tx_release(struct kref *ref)
>  	 * carl9170_tx_fill_rateinfo() has filled the rate information
>  	 * before we get to this point.
>  	 */
> -	memset_after(&txinfo->status, 0, rates);
> +	memset(&txinfo->pad, 0, sizeof(txinfo->pad));
> +	memset(&txinfo->rate_driver_data, 0, sizeof(txinfo->rate_driver_data));

This is "accidentally" equivalent, which makes me nervous. It was
designed to clear everything after "rates", regardless of padding, etc.

What I don't get is why the warning is being emitted. It boils down to
an expansion of this:

        memset(__ptr + offsetofend(typeof(*(obj)), member), __val,
               sizeof(*(obj)) - offsetofend(typeof(*(obj)), member));

into:

	memset(&txinfo->status + offsetofend(struct ieee80211_tx_info, rates),
	       0, sizeof(txinfo->status - offsetofend(struct ieee80211_tx_info, rates)))

Is offsetofend() broken?

-- 
Kees Cook
