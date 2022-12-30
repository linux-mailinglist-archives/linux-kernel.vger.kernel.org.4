Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037016596B6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 10:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234757AbiL3JV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 04:21:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiL3JVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 04:21:30 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EC58FF6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 01:21:29 -0800 (PST)
Received: from [192.168.1.90] (unknown [86.121.236.106])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 346266602CB4;
        Fri, 30 Dec 2022 09:21:27 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1672392087;
        bh=rCXi4h/44EcJUWAQW0r+NtzFp7zWZGlHxBrYkGNo9Ms=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PA3f0t+b7NiBEWBiiJEHW0oHrYV1co8GGRcm5Vnh5J8jivRI/CEZxBdxcaCxBtfU8
         hg5qXf5x3wSypQcTS1CRoL5nq+IlvBJsHJg00PN2A8mSM0c6pVfU4E9j8K8FgM3dHD
         PHy9zQK4OTUbkM//1FEZtoRYKF4sGqb8TTYK4BK/FqTvDYIZBLKwSNULND87JzE0qa
         UbbeJj6e4DZzCXIMHwf3mSDryfUtiIjbBK4Ft/SoJANXOP3hqHQS32ph6Gg9m7AM5A
         VcI2ANVzCn36ZWRLVm7+4VhlDulXPCvauREPAEIFe/nlqWgF24jQeBVmzm8Limha0V
         KJczVEYZPXXKg==
Message-ID: <920366ed-c719-a68d-2857-8c672db5caef@collabora.com>
Date:   Fri, 30 Dec 2022 11:21:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2] scripts/tags.sh: Fix the Kconfig tags generation when
 using latest ctags
Content-Language: en-US
To:     Kevin Hao <haokexin@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vipin Sharma <vipinsh@google.com>
References: <20221230025632.1053726-1-haokexin@gmail.com>
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <20221230025632.1053726-1-haokexin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/30/22 04:56, Kevin Hao wrote:
> The Kconfig language has already been built-in in the latest ctags, so
> it would error exit if we try to define it as an user-defined language
> via '--langdef=kconfig'. This results that there is no Kconfig tags in
> the final tag file. Fix this by skipping the user Kconfig definition for
> the latest ctags.
> 
> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> ---
> v2: Convert 'KCONFIG_ARGS' into array as suggested by Cristian.
> 
>   scripts/tags.sh | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/scripts/tags.sh b/scripts/tags.sh
> index e137cf15aae9..84775f08260f 100755
> --- a/scripts/tags.sh
> +++ b/scripts/tags.sh
> @@ -264,10 +264,12 @@ exuberant()
>   	--$CTAGS_EXTRA=+fq --c-kinds=+px --fields=+iaS --langmap=c:+.h \
>   	"${regex[@]}"
>   
> -	setup_regex exuberant kconfig
> -	all_kconfigs | xargs $1 -a                              \
> -	--langdef=kconfig --language-force=kconfig "${regex[@]}"
> -
> +	KCONFIG_ARGS=()
> +	if ! $1 --list-languages | grep -iq kconfig; then
> +		setup_regex exuberant kconfig
> +		KCONFIG_ARGS=(--langdef=kconfig --language-force=kconfig "${regex[@]}")
> +	fi
> +	all_kconfigs | xargs $1 -a "${KCONFIG_ARGS[@]}"
>   }
>   
>   emacs()

Reviewed-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

Thanks,
Cristian
