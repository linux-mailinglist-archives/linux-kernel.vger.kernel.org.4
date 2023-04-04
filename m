Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445DF6D5EB5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 13:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbjDDLKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 07:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234748AbjDDLKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 07:10:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD904211
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 04:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680606552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Svw1oSeBp4w881PZdb3WIJds4gAfMl/RKNvjWtrEHsQ=;
        b=F/6dHR9F+YarX1MTeemmI2J8SS7/AQrgy5DAth8GrcHv+BxVw54QwDdSvL5LBoDovPzSVZ
        SfqOVPs1vqkCvs1pgLthb0Rki1YFOpWFSFl2YWLQ1F2E0r2ecL3rp78M9X2hNWi5h+2gSj
        WYDYJLuCc49rCNyhzciYN+crysvsJco=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-abHXZKXCO_GEg4F87YF7aQ-1; Tue, 04 Apr 2023 06:55:59 -0400
X-MC-Unique: abHXZKXCO_GEg4F87YF7aQ-1
Received: by mail-wm1-f71.google.com with SMTP id bh19-20020a05600c3d1300b003ee93fac4a9so17250854wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 03:55:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680605758;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Svw1oSeBp4w881PZdb3WIJds4gAfMl/RKNvjWtrEHsQ=;
        b=hkuA8C1fTJN7vuqpGVuy8QiUfmkhMGgQqZZSG30uJwI686symNCcR1TLC+jLYNwNCQ
         AQcmJHBfuG5yVgZc6ahVu7PnWkbhyTzLY6sVuoTDfHEBo8kLCODsesA0tn49Sp0lixHL
         TJfMCrFay3Tt+mrbeC+7TtOahfeIGX06An03X3PraVgxLH6IkBLPg5TSOpol/KXmsAo3
         AkAJwOUkJCYuAfMDY8w9umbFJzYesnvEXwq2ujilcCXJMST1xUemZvyRjaPaTeX6go3X
         jMvYRzKbd+/2bpzAY/MUiSrd1d1iXZLdgKmVPNYJHG5hqBcynvbJnIf4xvm8RprRACIh
         PKDg==
X-Gm-Message-State: AAQBX9dC2SAkYjkzOIzh51I41ExxhydOKXNiSQHDz6T7ZJAynzqbnqpr
        r9mKq8vFADRbDxX3AxYjSEtIRbTzmeg9Iqm/FdEsoE8fEHuesPSLoTGs/N0ZGagwovLOK/0VgtS
        2kLxD4H7U6DLsse0Eu41Y7ftG
X-Received: by 2002:a7b:c34a:0:b0:3ef:f26b:a187 with SMTP id l10-20020a7bc34a000000b003eff26ba187mr1803029wmj.0.1680605757951;
        Tue, 04 Apr 2023 03:55:57 -0700 (PDT)
X-Google-Smtp-Source: AKy350aO5CpFV+bAcevH7SdL+jF+TQBPO6ggaFH+XkVa4CVmRTVGSJzkhKwKtdhIvG0qMI9dIVjz3Q==
X-Received: by 2002:a7b:c34a:0:b0:3ef:f26b:a187 with SMTP id l10-20020a7bc34a000000b003eff26ba187mr1803018wmj.0.1680605757670;
        Tue, 04 Apr 2023 03:55:57 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id r16-20020a05600c35d000b003ee9f396dcesm22183101wmq.30.2023.04.04.03.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 03:55:57 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Li Yi <liyi@loongson.cn>,
        Christian Koenig <christian.koenig@amd.com>,
        Helge Deller <deller@gmx.de>,
        Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] video/aperture: fix typos
In-Reply-To: <0ad03743-0224-b154-a149-e3e4d54b252d@suse.de>
References: <20230404040101.2165600-1-suijingfeng@loongson.cn>
 <0ad03743-0224-b154-a149-e3e4d54b252d@suse.de>
Date:   Tue, 04 Apr 2023 12:55:56 +0200
Message-ID: <87355fex1f.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Thomas,

Sorry, I just applied this patch and didn't see your email before...

> Hi
>
> Am 04.04.23 um 06:01 schrieb Sui Jingfeng:
>>   EFI FB, VESA FB or VGA FB etc are belong to firmware based framebuffer
>>   driver.
>
> No whitespaces at the beginning of the lines.
>

I fixed that before applying, also removed the "are" in the sentence
above, since it sounded off and repharsed subject line as "Fix typos
in comments".

[...]

>>   	/*
>>   	 * Remove the device from the device hierarchy. This is the right thing
>> -	 * to do for firmware-based DRM drivers, such as EFI, VESA or VGA. After
>> +	 * to do for firmware-based fb drivers, such as EFI, VESA or VGA. After
>
> That sentences is not well phrased. Maybe say 'This is required for 
> firmware-provided graphics, such as EFI, VESA or VGA.'
>

Graphic drivers or display drivers would indeed be more accurate here. But
I think that "fb drivers" is still well pharsed since the are other places
where either fbdev or DRM drivers for firmware-provided framebuffers are
named like that.

For example, in the sysfb platform code and Kconfig symbol help text.

> Best regards
> Thomas
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

