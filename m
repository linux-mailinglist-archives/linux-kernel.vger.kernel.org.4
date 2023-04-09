Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321406DC201
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 01:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjDIX30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 19:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjDIX3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 19:29:23 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522B930E8;
        Sun,  9 Apr 2023 16:29:22 -0700 (PDT)
Received: from [192.168.192.83] (unknown [50.47.134.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 1628F3F316;
        Sun,  9 Apr 2023 23:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1681082960;
        bh=fuvSkyeKHK0fmmQZOGbjU1Ws/M62j/C83O119GEEF3s=;
        h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
         In-Reply-To:Content-Type;
        b=mEy83qDiPie7xqbu6p0TemHmdYTuXH48HGkzLLcQmXR7oHsG7wsBr4P2mep2bo2Pd
         /1fuTGKfqGOS2YNWWITKzV4meEH7miWqe1XQ7k8+VUPs8WNcL158kZEP+WRkAlQGp2
         tSbwSTlgKFXz1tvIsrGITZXvqEs4ZIpFpanNF5jj1JpRInbjR4JLsT9RX8N0U++Sf6
         OYNm6dHUan4A3PWn77j2LUpXtwNSdqherXaBt/2d+UUFMmga+9Clv0ao8VH8LWULZH
         zaGBdt296uK2r2hdFgRwvQL22R8OU2HvElCCr6ToCONd7PQYw0ce0tmC7WWzLc59gX
         +lL4wZXxs1txg==
Message-ID: <3dc8b96b-db8c-428f-fc70-4df0e11f0d60@canonical.com>
Date:   Sun, 9 Apr 2023 16:29:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To:     Danila Chernetsov <listdansp@mail.ru>
Cc:     Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20230404190549.18257-1-listdansp@mail.ru>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
Subject: Re: [PATCH] apparmor: fix missing error check for
 rhashtable_insert_fast
In-Reply-To: <20230404190549.18257-1-listdansp@mail.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/23 12:05, Danila Chernetsov wrote:
>   rhashtable_insert_fast() could return err value when memory allocation is
>   failed. but unpack_profile() do not check values and this always returns
>   success value. This patch just adds error check code.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: e025be0f26d5 ("apparmor: support querying extended trusted helper extra data")
> 
> Signed-off-by: Danila Chernetsov <listdansp@mail.ru>

Acked-by: John Johansen <john.johansen@canonical.com>

thanks, I have pulled this into the apparmor tree


> ---
>   security/apparmor/policy_unpack.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
> index cf2ceec40b28..4d8adb21732c 100644
> --- a/security/apparmor/policy_unpack.c
> +++ b/security/apparmor/policy_unpack.c
> @@ -1046,8 +1046,13 @@ static struct aa_profile *unpack_profile(struct aa_ext *e, char **ns_name)
>   				goto fail;
>   			}
>   
> -			rhashtable_insert_fast(profile->data, &data->head,
> -					       profile->data->p);
> +			if(rhashtable_insert_fast(profile->data, &data->head,
> +						profile->data->p)) {
> +				kfree_sensitive(data->key);
> +				kfree_sensitive(data);
> +				info = "failed to insert data to table";
> +				goto fail;
> +			}
>   		}
>   
>   		if (!aa_unpack_nameX(e, AA_STRUCTEND, NULL)) {

