Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57A162EC86
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 04:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240308AbiKRDyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 22:54:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235045AbiKRDyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 22:54:22 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE08E905B8;
        Thu, 17 Nov 2022 19:54:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2B9DECE1FCA;
        Fri, 18 Nov 2022 03:54:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD7C9C433C1;
        Fri, 18 Nov 2022 03:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668743658;
        bh=VXNicNtjreRGd3uzhXnaHlX16PiEgIZSc4IxaUpQf1Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=blpIBpYqG8kamYrSjg1GHDUuELON6bpq1PL1PVPXqjqDXFmbz9L8Ji2OJhRM9UIds
         REBfOLVBzMTth0Z6fj55E6TW6tNEfVsjLRoGcZ+UbXkYb3L/Bguj5uY30ev9XZ932j
         EpMtvwjhwYhMRNW/ghqIhF81ejUtApaqnyGuRJxIRYUd73vKQVUnsS5fxDh3rwwh0H
         SGIDtpCYIeHeNJcnMSzvwvca88a9O066x2pdH1XJMI8SOw4HIdsiBlvqYGAGpZnkUi
         nn4gzWpF1SQq0iqj86U0LJs/WGhLtBilIdkwoTyfLxeEo/alYT0tTnPih5mV9LUUmb
         /aQkPdEtEb+8A==
Date:   Thu, 17 Nov 2022 21:54:04 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Clemens Ladisch <clemens@ladisch.de>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] hpet: Replace one-element array with flexible-array
 member
Message-ID: <Y3cB3MqiM+KFJHNm@work>
References: <20221118034250.never.999-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118034250.never.999-kees@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 07:42:55PM -0800, Kees Cook wrote:
> One-element arrays are deprecated[1] and are being replaced with
> flexible array members in support of the ongoing efforts to tighten the
> FORTIFY_SOURCE routines on memcpy(), correctly instrument array indexing
> with UBSAN_BOUNDS, and to globally enable -fstrict-flex-arrays=3.
> 
> Replace one-element array with flexible-array member in struct hpet.
> 
> This results in no differences in binary output. The use of struct hpet
> is never used with sizeof() and accesses via hpet_timers array are
> already done after explicit bounds checking.
> 
> [1] https://github.com/KSPP/linux/issues/79
> 
> Cc: Clemens Ladisch <clemens@ladisch.de>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Such a sneaky 1-element... ~.~

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
--
Gustavo

> ---
>  include/linux/hpet.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/hpet.h b/include/linux/hpet.h
> index 8604564b985d..21e69eaf7a36 100644
> --- a/include/linux/hpet.h
> +++ b/include/linux/hpet.h
> @@ -30,7 +30,7 @@ struct hpet {
>  			unsigned long _hpet_compare;
>  		} _u1;
>  		u64 hpet_fsb[2];	/* FSB route */
> -	} hpet_timers[1];
> +	} hpet_timers[];
>  };
>  
>  #define	hpet_mc		_u0._hpet_mc
> -- 
> 2.34.1
> 
