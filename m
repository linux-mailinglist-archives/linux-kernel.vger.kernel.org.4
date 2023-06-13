Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3523472EFA3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 00:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbjFMWvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 18:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbjFMWvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 18:51:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37217EC;
        Tue, 13 Jun 2023 15:51:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0DC363611;
        Tue, 13 Jun 2023 22:51:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B613C433C8;
        Tue, 13 Jun 2023 22:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686696671;
        bh=zVWmLSa3tOz3dzkcme4HlB9HKtQ3K2iGtgg1kJGmiRI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ePMi2Q+CTmtpgJVaIzPrukxiTC3TxB3QFM0s88Sryp7g8J8pap0u8KRphDdUOa+Hc
         3n+gjevd+rbchrqK4t2C1AGaXtIUWAfKwlbnR4LjJwWOf42AsMGc5MSAt4EcLvTsGo
         RbyH9qwiqhUtcOHEDRlk0jRnI3n7YzvISckIc/nbWNKwchWGJt0cP+YWJGPUJ5hlsF
         8HkgyK7aNwncdd/FWqY0Wu4FUsKEFKLyix7my73Xm5JYXhDZeZRuPQGPQwxeYUhzf1
         7WsV7bPegyYRBugI8AdTh7llIeRbqerMKLniBHW5Cyp8KQe95Rg8dlg5pZF1neqnNG
         O/GAuthnXjn9A==
Date:   Tue, 13 Jun 2023 16:52:08 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel test robot <oliver.sang@intel.com>,
        kernel test robot <lkp@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?iso-8859-1?Q?J=F3_=C1gila?= Bitsch <jgilab@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] usb: ch9: Replace 1-element array with flexible array
Message-ID: <ZIjzGCMWrar3kf1L@work>
References: <20230613210400.never.078-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230613210400.never.078-kees@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 02:04:04PM -0700, Kees Cook wrote:
> With "-fstrict-flex-arrays=3" enabled, UBSAN_BOUNDS no longer pretends
> 1-element arrays are unbounded. Walking wData will trigger a warning,
> so make it a proper flexible array. Add a union to keep the struct size
> identical for userspace in case anything was depending on the old size.
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202306102333.8f5a7443-oliver.sang@intel.com
> Fixes: df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3")

I always have mixed feelings about a 'Fixes' tag applied to a commit
like this (one that enables a compiler option that avoids the introduction
of buggy code), when we are addressing the potentially buggy code that
the option is inteded to prevent. (thinkingface)

> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: kernel test robot <lkp@intel.com>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: "Jó Ágila Bitsch" <jgilab@gmail.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
--
Gustavo

> ---
>  include/uapi/linux/usb/ch9.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/usb/ch9.h b/include/uapi/linux/usb/ch9.h
> index b17e3a21b15f..82ec6af71a1d 100644
> --- a/include/uapi/linux/usb/ch9.h
> +++ b/include/uapi/linux/usb/ch9.h
> @@ -376,7 +376,10 @@ struct usb_string_descriptor {
>  	__u8  bLength;
>  	__u8  bDescriptorType;
>  
> -	__le16 wData[1];		/* UTF-16LE encoded */
> +	union {
> +		__le16 legacy_padding;
> +		__DECLARE_FLEX_ARRAY(__le16, wData);	/* UTF-16LE encoded */
> +	};
>  } __attribute__ ((packed));
>  
>  /* note that "string" zero is special, it holds language codes that
> -- 
> 2.34.1
> 
