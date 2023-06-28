Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572147413CB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 16:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjF1OXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 10:23:04 -0400
Received: from mail.xen0n.name ([115.28.160.31]:38314 "EHLO
        mailbox.box.xen0n.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbjF1OWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 10:22:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1687962141; bh=KteBACahesOTtph0p7WmbToRdVIApqR3ig8QwMvsL1U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=m5C7Z7Vh/RSqq7hVsCH8Pwe6vJ3Zz7iRb3ONjRRqfY72GyqXfmTxGErKyo3/rHexH
         48Ox9N7CQ1f5Olb5MKEUDKIyhZxUJlvNgLPu0doMS7lsrLXe2YHO/ptv978GXowT/k
         svHobETosQ9GQedwM59HMbEYAFRziWU0zD5SeFkA=
Received: from [100.100.34.13] (unknown [220.248.53.61])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 5700360112;
        Wed, 28 Jun 2023 22:22:21 +0800 (CST)
Message-ID: <2217f142-470d-b467-6ad8-b1d7c0aee2c8@xen0n.name>
Date:   Wed, 28 Jun 2023 22:22:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] LoongArch: Delete debugfs checking
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        Immad Mir <mirimmad17@gmail.com>
Cc:     Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <7627f2b9-2287-46d2-b461-d33aa69931a8@moroto.mountain>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <7627f2b9-2287-46d2-b461-d33aa69931a8@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023/6/20 16:06, Dan Carpenter wrote:
> Debugfs functions are not supposed to be checked for errors.  This
> is sort of unusual but it is described in the comments for the
> debugfs_create_dir() function.  Also debugfs_create_dir() can never
> return NULL.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> I spotted this code because I was looking at patches which were sent
> to stable but without a Fixes tag.  The correct way of checking for
> error pointers is not IS_ERR_OR_NULL(), it's IS_ERR().  When a function
> returns both error pointers and NULL, the NULL should be treated as a
> special kind of success.  Please see my blog for more details.
> 
> https://staticthinking.wordpress.com/2022/08/01/mixing-error-pointers-and-null/
> 
> I have not included a Fixes tag here, because it's not really a bug fix,
> it's just a clean up.

Thanks for the patch and sorry for the late review. I didn't notice this 
back then (just recovering from covid around that time) but since 
loongarch-next isn't tagged yet I think the patch could make it this 
cycle. (Somehow Huacai didn't see the mail either, weird...)

> 
>   arch/loongarch/kernel/unaligned.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/arch/loongarch/kernel/unaligned.c b/arch/loongarch/kernel/unaligned.c
> index 85fae3d2d71a..3abf163dda05 100644
> --- a/arch/loongarch/kernel/unaligned.c
> +++ b/arch/loongarch/kernel/unaligned.c
> @@ -485,8 +485,6 @@ static int __init debugfs_unaligned(void)
>   	struct dentry *d;
>   
>   	d = debugfs_create_dir("loongarch", NULL);
> -	if (IS_ERR_OR_NULL(d))
> -		return -ENOMEM;
>   
>   	debugfs_create_u32("unaligned_instructions_user",
>   				S_IRUGO, d, &unaligned_instructions_user);

Trivial enough, thanks!

Reviewed-by: WANG Xuerui <git@xen0n.name>

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

