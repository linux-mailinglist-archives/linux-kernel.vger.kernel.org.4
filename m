Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980D56FEDCF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 10:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235408AbjEKIXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 04:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234171AbjEKIXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 04:23:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D592D68
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 01:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683793349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gk+R+YkjF963S2SpF4BsdMdE47AkKmd4xwPaX4Oi4+k=;
        b=jRWL/k4f5CslsaWj22QP6Rsh4zJ2YmKgfCShbyOo4iWEWo4jyKyXQ4h7n/6ZXL/ChDAbkb
        FcWHXs0QQrpSt8mSDXrj88zBYtGW8LST7vWJlxfadbuseABqTs1IbrdD1hYrSynBo22aGC
        8yO5Xrg/4tSD6J7mtLiu79+D5GSDvkc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-gXROxhwMOYWSbwIkt1H3mg-1; Thu, 11 May 2023 04:22:27 -0400
X-MC-Unique: gXROxhwMOYWSbwIkt1H3mg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-94a348facbbso1035332966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 01:22:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683793347; x=1686385347;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gk+R+YkjF963S2SpF4BsdMdE47AkKmd4xwPaX4Oi4+k=;
        b=CnCVV5GNWwpRc9b2kVElycGp/eczIrKrU9hbkrH5gRGEaQSKFUIENID20waTMuim4G
         tmQtv5tNb3k6+t4+xqhlIqNf2+onFAyJjvxreqgOMOhQt6dBzqwSLB+UbQEYUvCM4gRi
         nBtsjZs9E2Vn/QgwoQg2eoCb+/CG6guqAkI7SEj1yKUxi/rfLu/D224HHuA8H4VDmpVY
         5bjmXFu43/5VVdkb+H0WkYZh2bHRm92wcUw8g7DEWUkzWDb9jyxpqbhxEz65mIBFXrIr
         tZnhTImkLRQWjCyyH6JNeCRIpOS3jZZ7wkSUH4puawgWH7A2eu55YEhAvg3T4oXBiONP
         qbjQ==
X-Gm-Message-State: AC+VfDysqIbh+WgncZTunQebA5oSf99I3EHcvWSSodpjCCo2h1O5o8X3
        Fq7z8YQtCmfsMhRhElR5yjQ5/Jo8px1o+18WYAt9qobT+FvILaHzysmYZjMBGfj2P+yPeAtCGgM
        ils4c55VSv46qZAP7sWTLJYO6
X-Received: by 2002:a17:906:478f:b0:96a:3b67:40bb with SMTP id cw15-20020a170906478f00b0096a3b6740bbmr4004890ejc.40.1683793346899;
        Thu, 11 May 2023 01:22:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6zc4nyULHOnur3f+oxT8ygqFitbgjgoYUQJ4s85VdQCqWOCPEtYkKW/BM86bhB+vNheUGeNg==
X-Received: by 2002:a17:906:478f:b0:96a:3b67:40bb with SMTP id cw15-20020a170906478f00b0096a3b6740bbmr4004876ejc.40.1683793346524;
        Thu, 11 May 2023 01:22:26 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id s25-20020a170906285900b0096a5d341b50sm582560ejc.111.2023.05.11.01.22.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 01:22:26 -0700 (PDT)
Message-ID: <7b406485-83dd-f3d9-4e82-6ca42d2f4b5a@redhat.com>
Date:   Thu, 11 May 2023 10:22:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] vboxsf: Replace all non-returning strlcpy with strscpy
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230510211146.3486600-1-azeemshaikh38@gmail.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230510211146.3486600-1-azeemshaikh38@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/10/23 23:11, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  fs/vboxsf/super.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/vboxsf/super.c b/fs/vboxsf/super.c
> index d2f6df69f611..1fb8f4df60cb 100644
> --- a/fs/vboxsf/super.c
> +++ b/fs/vboxsf/super.c
> @@ -176,7 +176,7 @@ static int vboxsf_fill_super(struct super_block *sb, struct fs_context *fc)
>  	}
>  	folder_name->size = size;
>  	folder_name->length = size - 1;
> -	strlcpy(folder_name->string.utf8, fc->source, size);
> +	strscpy(folder_name->string.utf8, fc->source, size);
>  	err = vboxsf_map_folder(folder_name, &sbi->root);
>  	kfree(folder_name);
>  	if (err) {

