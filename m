Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02F4644562
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 15:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbiLFOPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 09:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233613AbiLFOPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 09:15:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD5327FD8
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 06:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670336066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zjvIkSL2SBAgsiT7gQ2VbIYNtCKtla6HXdyvgY6EM/c=;
        b=UDrl6xbdrNks7ITkxps1vlypuJHLvdkb5bUDhS5FIaUqJEyk3GsNPEpmGGN1Pqc66nyhME
        o9JCKq1GB1EzY5X7ef8A4Lc1Wi3fTNExHrfw5KC59ZCgMegTzgSBb/akzxTLcr6Gld9riS
        fx81qdIBPRYoQOJmh3us6vBpyOTAeho=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-433-M-gu69lKOVCGdvNo3mUjBw-1; Tue, 06 Dec 2022 09:14:25 -0500
X-MC-Unique: M-gu69lKOVCGdvNo3mUjBw-1
Received: by mail-wr1-f70.google.com with SMTP id o8-20020adfba08000000b00241e80f08e0so3250418wrg.12
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 06:14:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zjvIkSL2SBAgsiT7gQ2VbIYNtCKtla6HXdyvgY6EM/c=;
        b=mDiVLgD6a5pB0pf69uYWAfQAhxS6HCymFeu/+f+ukH9IoMQA0u+M1PXWYFObZHZRDm
         jGA+y7Hm8q7uE6pYimVo8TQ5P0dPuB/Q9Nmh111OoexamgOsdWK8J4uq2sRUbootH8ai
         1+7HgCj0RsOQ0hxtmKz1Y+KRyXyxzIX9J9itPzjFtwDDb5KjCSbSyQSQjhl/GCjtn3N4
         pChcAY8cbj4j59f5k7e/i3j55nwDtwQWgDA6mFAYqplhHCN1larELzoT8W8sepUabtVl
         iz0CUKPp41HZZDpOVeTlcwPxfqxyKM9X7+MeeX+PeIL1qNMvv0ykwvDweOSc32raBeoo
         P7Wg==
X-Gm-Message-State: ANoB5pnkmXoDLMNmwe7r8/6KN0o8n2RjWyzTJjihe0iML3RzjMPA710e
        QvhAsugOC+yGt68cdL8xkLbZBt6Yw3iy4THoRCoRKKHG5jaUlVCsbPwnidJBaKHpYkm6SGEIdz/
        e7Hols7umYioqRf5Z+5vDHQIa
X-Received: by 2002:a05:600c:350a:b0:3d0:74be:a059 with SMTP id h10-20020a05600c350a00b003d074bea059mr19348426wmq.177.1670336063921;
        Tue, 06 Dec 2022 06:14:23 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4WyKP6LGRcLm2eiMh41m+pGGwu5lilQKOC/kqehU6ZzQEBrjtdzGo/MFwLtcjN9cST+hZe5w==
X-Received: by 2002:a05:600c:350a:b0:3d0:74be:a059 with SMTP id h10-20020a05600c350a00b003d074bea059mr19348409wmq.177.1670336063683;
        Tue, 06 Dec 2022 06:14:23 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id k10-20020a056000004a00b002365730eae8sm16924437wrx.55.2022.12.06.06.14.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 06:14:23 -0800 (PST)
Message-ID: <27f14969-d71b-63db-7770-5269bf7b9ef1@redhat.com>
Date:   Tue, 6 Dec 2022 15:14:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 3/3] drm/tiny: ili9486: remove conflicting framebuffers
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, neil.armstrong@linaro.org,
        Carlo Caione <ccaione@baylibre.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jerome Brunet <jbrunet@baylibre.com>,
        David Airlie <airlied@gmail.com>,
        Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20221116-s905x_spi_ili9486-v3-0-59c6b58cbfe3@baylibre.com>
 <20221116-s905x_spi_ili9486-v3-3-59c6b58cbfe3@baylibre.com>
 <14e5c4e4-30dd-8efd-81e4-d680664ab04a@linaro.org>
 <c460bbda-6e9d-24e8-eb73-2e7207958deb@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <c460bbda-6e9d-24e8-eb73-2e7207958deb@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/22 10:52, Thomas Zimmermann wrote:
> Hi
> 
> Am 06.12.22 um 10:41 schrieb Neil Armstrong:
>> Hi Carlo,
>>
>> On 06/12/2022 09:34, Carlo Caione wrote:
>>> For platforms using simplefb / efifb, call
>>> drm_aperture_remove_framebuffers() to remove the conflicting
>>> framebuffer.
>>
>> Conflicting framebuffer on the SPI display ? How is that possible ?
> 
> Calling drm_aperture_remove_framebuffers() is only required if the 
> graphics card may have been pre-initialized by the system, such as a 
> VGA-compatible card on a PC.
> 
> Could the SPI display have been initialized by the firmware? If not, the 
> call should be left out.
>

Agree.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

