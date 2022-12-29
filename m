Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C083E658CB7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 13:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbiL2Md0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 07:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiL2MdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 07:33:23 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B599FC4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 04:33:19 -0800 (PST)
Received: from [192.168.1.90] (unknown [86.121.236.106])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EDC6C660036C;
        Thu, 29 Dec 2022 12:33:17 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1672317198;
        bh=HnNHwx1Hns/CsXizdUfEU4bSOWFcFSLrbkcvkSGkq/E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FeclehEzEg1sPVBEesY+vutSQrkKTGg4UjxNoMzkHn6Ko5s+b5S4SpH/JY7Uq4kqC
         keBLAvy3Th/eg9EWI8ozGku0SMSt8e/WYVs8+WIkAU8eA7B4yooK4IuntE46Ts0Tn3
         5xFixI62CBRAJascV/mCnkDL3oEx97nH1EqiIDoKh7MWxhu2TskZ9EI4wClEQRGj8G
         o/Xpuf0x8dVPLvtPKHAcnIqXIF7gQHJdDu2BWQUA7BYI3I4+UONQqPzun7YdTFes0p
         vJIsptes/LjdlTzDXVt2FgU+WHBV10JwYFGjjhZmiZkz9hprxMfO+SR0twKuCNaNnW
         Tln557+i3yVkQ==
Message-ID: <5e1b0401-db1e-a7a4-787c-4b93d02f5b73@collabora.com>
Date:   Thu, 29 Dec 2022 14:33:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] scripts/tags.sh: Fix the Kconfig tags generation when
 using latest ctags
To:     Kevin Hao <haokexin@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vipin Sharma <vipinsh@google.com>
References: <20221229055401.855185-1-haokexin@gmail.com>
Content-Language: en-US
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <20221229055401.855185-1-haokexin@gmail.com>
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


On 12/29/22 07:54, Kevin Hao wrote:
> The Kconfig language has already been built-in in the latest ctags, so
> it would error exit if we try to define it as an user-defined language
> via '--langdef=kconfig'. This results that there is no Kconfig tags in
> the final tag file. Fix this by skipping the user Kconfig definition for
> the latest ctags.
> 
> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> ---
>   scripts/tags.sh | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/scripts/tags.sh b/scripts/tags.sh
> index e137cf15aae9..c56b13ae3fdf 100755
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
> +	KCONFIG_ARGS=""
> +	if ! $1 --list-languages | grep -iq kconfig; then
> +		setup_regex exuberant kconfig
> +		KCONFIG_ARGS="--langdef=kconfig --language-force=kconfig ${regex[@]}"
> +	fi
> +	all_kconfigs | xargs $1 -a $KCONFIG_ARGS
>   }

The 'regex' array needs quoting to prevent word splitting/globbing. I 
would suggest to transform 'KCONFIG_ARGS' into an array as well:

KCONFIG_ARGS=()
if ! $1 --list-languages | grep -iq kconfig; then
	setup_regex exuberant kconfig
	KCONFIG_ARGS=(--langdef=kconfig --language-force=kconfig "${regex[@]}")
fi
all_kconfigs | xargs $1 -a "${KCONFIG_ARGS[@]}"


>   emacs()
