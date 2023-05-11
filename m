Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD466FFC15
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 23:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239415AbjEKVst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 17:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238966AbjEKVso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 17:48:44 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F454690;
        Thu, 11 May 2023 14:48:42 -0700 (PDT)
Received: from [10.230.83.65] (unknown [72.28.92.215])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 3722440026;
        Thu, 11 May 2023 21:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1683841719;
        bh=hjvm1zm7cWLOP+uGf76IIMlTIPMFKlV+xXfMnXyGB8Q=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=Cjhg1vG0eHurLwCGA5RC85fFZHhbtKuQVMy4+k9XxNBIQ2RfNELgpNkVU2786iQeU
         EWeNhfVzikltesWaOsNXR8iVjzsuKOtRFjAqbHv2S5gyQt+bta974N+Z9gtor4AfPD
         dVSTc/GDABBZ5f2Fo9wphW+bkvJ475qR9CcgmYj/u7rOUWmZURzTCskLqVCdRj7uXw
         3BnhIR0AsBqBsLyPIIz83GmU5vJqRz5gMZJYa9J/d3fYIOfpkv0IuavddN5LKNur7U
         +UheZL1FcyvGu6wfqcPKwdo1H4d2MuuTrzqDpzKEE4XP129oPMZeXOxU1oPUJ9DZEP
         9q4Y5MdEPP25g==
Message-ID: <7085879d-4d21-b90a-c08d-60450d1c7d38@canonical.com>
Date:   Thu, 11 May 2023 14:48:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] apparmor: aa_buffer: Convert 1-element array to flexible
 array
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, apparmor@lists.ubuntu.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20230511213441.never.401-kees@kernel.org>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20230511213441.never.401-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/23 14:34, Kees Cook wrote:
> In the ongoing effort to convert all fake flexible arrays to proper
> flexible arrays, replace aa_buffer's 1-element "buffer" member with a
> flexible array.
> 
> Cc: John Johansen <john.johansen@canonical.com>
> Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: apparmor@lists.ubuntu.com
> Cc: linux-security-module@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: John Johansen <john.johansen@canonical.com>

I have pulled this into my tree.

> ---
> One thing I notice here is that it may be rare for "buffer" to ever change
> for a given kernel. Could this just be made PATH_MAX * 2 directly and
> remove the module parameter, etc, etc?

possibly. Currently the only use case I know of is for some stress testing
where we drop the buffer size down really small to try and break things.
This isn't part of the regular regression runs and could be handle with a
config/compile time to a buffer size constant.


> ---
>   security/apparmor/lsm.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index d6cc4812ca53..35eb41bb9e3a 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -46,7 +46,7 @@ int apparmor_initialized;
>   
>   union aa_buffer {
>   	struct list_head list;
> -	char buffer[1];
> +	DECLARE_FLEX_ARRAY(char, buffer);
>   };
>   
>   #define RESERVE_COUNT 2
> @@ -1647,7 +1647,7 @@ char *aa_get_buffer(bool in_atomic)
>   		list_del(&aa_buf->list);
>   		buffer_count--;
>   		spin_unlock(&aa_buffers_lock);
> -		return &aa_buf->buffer[0];
> +		return aa_buf->buffer;
>   	}
>   	if (in_atomic) {
>   		/*
> @@ -1670,7 +1670,7 @@ char *aa_get_buffer(bool in_atomic)
>   		pr_warn_once("AppArmor: Failed to allocate a memory buffer.\n");
>   		return NULL;
>   	}
> -	return &aa_buf->buffer[0];
> +	return aa_buf->buffer;
>   }
>   
>   void aa_put_buffer(char *buf)
> @@ -1747,7 +1747,7 @@ static int __init alloc_buffers(void)
>   			destroy_buffers();
>   			return -ENOMEM;
>   		}
> -		aa_put_buffer(&aa_buf->buffer[0]);
> +		aa_put_buffer(aa_buf->buffer);
>   	}
>   	return 0;
>   }

