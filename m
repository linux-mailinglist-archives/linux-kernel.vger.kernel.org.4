Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFA4643D32
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 07:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbiLFGki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 01:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233955AbiLFGkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 01:40:35 -0500
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902DB1DDE1
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 22:40:33 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id d14so13976933edj.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 22:40:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e1mhWiQ+nK1TpnHegOmWn7jYPQfPzfQzNgARNwRVues=;
        b=W92dgloFmw1rFPCdLv7LEvU5pz58jJZwkAlWQP74gD261Lx5T80h28sy1JqO7w/U0p
         zw21m7xNvIcyFnehThv2nKnq8hzNCrwl8Lqo6ZAID3nMCpaUxaQ839vUQby4amby478j
         qoJ+Sxm5w5D6gu81KaqZPYh9FAh1Eb+jPlMEC9yG7HowwgJ2VoaL3CIXXtG+o9hqD3QQ
         1e03TqtqR5Dj4fmizHX+eUMmWb2GCpqmXF09P/xRQdpKuZ8/xelln8oCLY/tGxPkNPln
         fU9G47SOgUBowuLsD1W2N284IQ4WL7AtkE1tbd9dSS2kOJjexlffzCwklgzqja7MoAzY
         9jjg==
X-Gm-Message-State: ANoB5pni5EI54jRpGtoInVyBicCAh5IGLrXYrPMp+odt/YboJOqUnrlu
        topmAZt6kdnu4+0jLx2DOkALd9u1xL8=
X-Google-Smtp-Source: AA0mqf7PIOY9sVwrkuF+HKiQVpAYCxXMjsNyDxp/2zaNSy/5ZlK/tcFjYPJMxwV37fhp/jBnseaaZw==
X-Received: by 2002:aa7:daca:0:b0:46b:8078:2431 with SMTP id x10-20020aa7daca000000b0046b80782431mr27143396eds.408.1670308832172;
        Mon, 05 Dec 2022 22:40:32 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id ha7-20020a170906a88700b007c0bb571da5sm5257828ejb.41.2022.12.05.22.40.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 22:40:31 -0800 (PST)
Message-ID: <27ade063-79df-dad9-0427-e16f1ddb43ef@kernel.org>
Date:   Tue, 6 Dec 2022 07:40:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [patch 1/3] VT: Add height parameter to con_font_get/set consw
 operations
Content-Language: en-US
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kbd@lists.altlinux.org
Cc:     linux-kernel@vger.kernel.org
References: <20221205000739.583233140@ens-lyon.org>
 <20221205000807.751605665@ens-lyon.org>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20221205000807.751605665@ens-lyon.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05. 12. 22, 1:07, Samuel Thibault wrote:
> The current con_font_get/set API currently hardcodes a 32-pixel-tall
> limitation, which only dates from the old VGA hardware which could not
> handle taller fonts than that.
> 
> This change just adds a vpitch parameter to release this
> constraint. Drivers which do not support vpitch != 32 can just return
> EINVAL when it is not 32, font loading tools will revert to trying 32
> and succeed.
> 
> This change makes the fbcon driver consider vpitch appropriately, thus
> making it able to load large fonts.
> 
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> 
...
> --- linux-6.0.orig/drivers/usb/misc/sisusbvga/sisusb_con.c
> +++ linux-6.0/drivers/usb/misc/sisusbvga/sisusb_con.c
...
> @@ -1243,13 +1244,15 @@ sisusbcon_font_set(struct vc_data *c, st
>   
>   /* Interface routine */
>   static int
> -sisusbcon_font_get(struct vc_data *c, struct console_font *font)
> +sisusbcon_font_get(struct vc_data *c, struct console_font *font, unsigned int vpitch)
>   {
>   	struct sisusb_usb_data *sisusb;
>   
>   	sisusb = sisusb_get_sisusb_lock_and_check(c->vc_num);
>   	if (!sisusb)
>   		return -ENODEV;
> +	if (vpitch != 32)
> +		return -EINVAL;
>   
>   	/* sisusb->lock is down */
>   
> @@ -1268,7 +1271,7 @@ sisusbcon_font_get(struct vc_data *c, st
>   	}
>   
>   	/* Copy 256 chars only, like vgacon */
> -	memcpy(font->data, sisusb->font_backup, 256 * 32);
> +	memcpy(font->data, sisusb->font_backup, 256 * height);

Have you tested this? What does this 'height' refer to?

thanks,
-- 
js
suse labs

