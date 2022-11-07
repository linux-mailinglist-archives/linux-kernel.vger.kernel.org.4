Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCB761F629
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbiKGOfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbiKGOf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:35:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7207D2E9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 06:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667831653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ijNz8eAPO9Q05t4hDsgKToL8SbJ7TyveKWVglTvBbII=;
        b=ct4F3gErRKg4aNSMracrIwsdX/0oJ6chrAHNhI+9WZoZqwMp2txMTDB4WFsFonIlf3xtEr
        YuIsdbx63pNt2D+gYekd3uQtMuogbYcU3H3cLqDS4ULhxRQTKBmzHLCmE4FMbAmpzgNx0l
        n2bJitdTSVDZGDhGidJteQxGC+GK1nY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-107-leZ0axh0NnSOFulX-c3Y1A-1; Mon, 07 Nov 2022 09:34:11 -0500
X-MC-Unique: leZ0axh0NnSOFulX-c3Y1A-1
Received: by mail-ed1-f72.google.com with SMTP id q13-20020a056402518d00b00462b0599644so8604408edd.20
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 06:34:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ijNz8eAPO9Q05t4hDsgKToL8SbJ7TyveKWVglTvBbII=;
        b=2iR2ypr1psQfNUoUVzxR3pVN9/TyMY3DOUoI2ZHe+2FjGLBqXyJff2Ra9ZMFtnj26+
         gZz3lkUxinBJxdesLGRrp26npfTjKwm+p+sxzW+fL8hTb2HVu4hoNGRWq3uuT7Uy2uxH
         9hJFeE7S+oCjKyjVgJjUnntJQ0MLPcdxrD7s1XfxZv/3iAHel2nGqX10eh+G1h/Sp6HE
         WEG2eQ7Y+EHJ7ixnp26InC+5jZy980150RHTSjtMjv1MlDgmwpjAyfq27+K8Aa8TGpNS
         jRl9azEMmOKyiPaBiYxI48IFBUpjRZALbcjyEYOGc+i5U47otZfRjAJZHUKDcXVjzeyc
         vO5g==
X-Gm-Message-State: ACrzQf32jhGDO2U/BJgyUiDEyQt7lHxWdz+gqqPzzGLokaT9jesISiWE
        aCEEHOeYtF7hVcEeZr097KH53IS7bnMWMvwlrHsipzNWneDg0m523ehbyFbmdEsaSg5SdpaSXcL
        WVEb7caH1X5zZu5GCHbj+AFYE
X-Received: by 2002:a17:907:7d8f:b0:78e:2cba:560f with SMTP id oz15-20020a1709077d8f00b0078e2cba560fmr48447152ejc.173.1667831650521;
        Mon, 07 Nov 2022 06:34:10 -0800 (PST)
X-Google-Smtp-Source: AMsMyM7RQoQplQyxXr+bxL3t5Ktl0d0ZhMW1oU/JYobjrch2dFusmFBgLa6XAR4eAiNPp2UxN3GyRg==
X-Received: by 2002:a17:907:7d8f:b0:78e:2cba:560f with SMTP id oz15-20020a1709077d8f00b0078e2cba560fmr48447139ejc.173.1667831650347;
        Mon, 07 Nov 2022 06:34:10 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id eh9-20020a0564020f8900b004587f9d3ce8sm4280958edb.56.2022.11.07.06.34.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 06:34:09 -0800 (PST)
Message-ID: <d35060f2-d2ea-104e-9915-99f83014cc84@redhat.com>
Date:   Mon, 7 Nov 2022 15:34:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v3] platform/x86: ISST: Fix typo in comments
Content-Language: en-US
To:     chen zhang <chenzhang@kylinos.cn>, rdunlap@infradead.org,
        bagasdotme@gmail.com
Cc:     linux-kernel@vger.kernel.org, chenzhang_0901@163.com,
        k2ci <kernel-bot@kylinos.cn>
References: <20221103013313.13278-1-chenzhang@kylinos.cn>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221103013313.13278-1-chenzhang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/3/22 02:33, chen zhang wrote:
> Fix spelling typo in comments.
> 
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: chen zhang <chenzhang@kylinos.cn>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans


> ---
> v3: Change "interace" to "interfaces", Change "share" to "shared"
> Thanks for your advice.
> v2: update the comments
> There is a bug with my company's mailbox with kylinos.cn, and sometimes 
> I can't receive reply emails. I cc my personal 163 mailbox, so that I can
> receive feedback from reviewer on time.
> ---
>  drivers/platform/x86/intel/speed_select_if/isst_if_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> index fd102678c75f..a7e02b24a87a 100644
> --- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> +++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> @@ -623,7 +623,7 @@ static long isst_if_def_ioctl(struct file *file, unsigned int cmd,
>  
>  /* Lock to prevent module registration when already opened by user space */
>  static DEFINE_MUTEX(punit_misc_dev_open_lock);
> -/* Lock to allow one share misc device for all ISST interace */
> +/* Lock to allow one shared misc device for all ISST interfaces */
>  static DEFINE_MUTEX(punit_misc_dev_reg_lock);
>  static int misc_usage_count;
>  static int misc_device_ret;

