Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F50B65B6E0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 20:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234664AbjABTOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 14:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjABTOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 14:14:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D1F9585
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 11:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672686800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rS6IkM26a9yODRpF7B+x34s+L3GGgZHwy27uItfaRms=;
        b=Bh/yMX7/yZaheRfjhmmv5r7P+xSuGsECgQWpGMYZ6jOjXP9m7KNmOdzO5cEwcsf1mZcXRK
        6/yaZRZ2KUjpebqYomt9SQQLY/GML8Aod6D06qkTI6GYlKospsQa19710EU9V7pgz5U4Ow
        9U0LcEMgl+MAxp/89qygUTxwfnvG9Fk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-537-3tgsJeaHOzakMd3B_GvJ1g-1; Mon, 02 Jan 2023 14:13:19 -0500
X-MC-Unique: 3tgsJeaHOzakMd3B_GvJ1g-1
Received: by mail-wm1-f69.google.com with SMTP id bi18-20020a05600c3d9200b003d991844dbcso9387823wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 11:13:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rS6IkM26a9yODRpF7B+x34s+L3GGgZHwy27uItfaRms=;
        b=mgq4iuBPTSey+MmEeLmXvicm1TWHOXOBST2Oe9+7r8LdkFb5e8bjFn80HYJixIeLXP
         kot7K/oc00tosArFVBwEEHpNYpZwhkFW4Jz2BXBfiF0L4TczTi9VkYi2pYZumi90Ktyo
         2KGpotXA7P7trMLZQ8dHx2nlo0CvvNivKkxvmSPHxR5gxhS8ExONiHZoOnddq2ja5DM7
         bPTtiG3G0vTW9KixSecHgUyxdasQ52btpmPkYJL7cIefkW0m7HXzIijN3j8KQ+gHYzEs
         Hau9Y4h+nj+dvVimVwfKkC+qu74Or0jNzQqTDlHyd4BCxYWgvSKCA4AooGi+McK4qiM5
         yyqA==
X-Gm-Message-State: AFqh2koVm3hM1A8nViAat6G3FHyVvCir75ZVHk79NmX3Zx2OdwXmw6l0
        ZzTOrD75DDtF9C7NdmBhJS3PzxaXQqjSQv/FEVtZCgDEMZJ3XAaOdBXlBSS99RgpKO5Xr6dRmwW
        QOzmHioJR9TnLQeDbklmWDbbx
X-Received: by 2002:adf:f00c:0:b0:242:63e5:fdaa with SMTP id j12-20020adff00c000000b0024263e5fdaamr23459080wro.62.1672686798040;
        Mon, 02 Jan 2023 11:13:18 -0800 (PST)
X-Google-Smtp-Source: AMrXdXt9wGF7fw14CLhRRj6sqQE3EQYPOSo+EpyWbo8tgMFVfQRNnX3BMShvwWiSB7JImfYWjXddSw==
X-Received: by 2002:adf:f00c:0:b0:242:63e5:fdaa with SMTP id j12-20020adff00c000000b0024263e5fdaamr23459073wro.62.1672686797810;
        Mon, 02 Jan 2023 11:13:17 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id u17-20020adfeb51000000b0026e94493858sm29025917wrn.106.2023.01.02.11.13.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 11:13:17 -0800 (PST)
Message-ID: <e7b9e76e-8f34-75c8-2136-095bd42a0bf8@redhat.com>
Date:   Mon, 2 Jan 2023 20:13:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 00/14] drm/panel: Make panel drivers use existing DSI
 write macros
Content-Language: en-US
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     linux-kernel@vger.kernel.org, Ondrej Jirman <megous@megous.com>,
        Purism Kernel Team <kernel@puri.sm>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org
References: <20221228014757.3170486-1-javierm@redhat.com>
 <Y7Mp1diWRWgiHsw0@ravnborg.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <Y7Mp1diWRWgiHsw0@ravnborg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/2/23 20:00, Sam Ravnborg wrote:
> Hi Javier.
> 
> On Wed, Dec 28, 2022 at 02:47:43AM +0100, Javier Martinez Canillas wrote:
>> Hello,
>>
>> This series contains cleanups for DRM panel drivers that define their own
>> DSI write macros instead of using what's already in <drm/drm_mipi_dsi.h>.
>>
>> The changes are quite trivial but I've only tested this with allmodconfig
>> and `make M=drivers/gpu/drm/panel/` so please review and testing would be
>> highly appreciated.
> 
> Nice cleanup - I like it.

Thanks.

> In most of the patches there is some trivial indent that should be
> fixed, I think I noted it everywhere.
>

Yup, I just used sed -i to modify in-place but the new macro _seq suffix
caused the wrong indent everywhere. I'll fix them in v2.
 
> Sorry - but no testing.
>

No worries, I also just build tested the drivers since I lack the HW but
the changes are pretty trivial so I expect no functional changes.
 
> The last patch is buggy - see the comment.

Indeed. Thanks for pointing that out! I completely missed that the macro
was different than the others.

> I suggest to land patch 1 now (with the fix), this makes it easier for
> others to test on top of drm-misc-next.
>

Agreed. I'll just post that one as a v2 and then the rest as a separate
series after pushing that to drm-misc-next.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

