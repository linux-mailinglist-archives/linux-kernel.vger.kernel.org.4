Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF94B73B33A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 11:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjFWJGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 05:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjFWJGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 05:06:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC20C10C1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 02:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687511112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pguH3U8Bb3zv/4/0aDT3aEspkKoXYOCNJWdP7zh3GRw=;
        b=V8hBxl9ownnRUmT/f0vn0K662oJ9IXTa4JaIlStFwQCrlkzhc4CyXOlESvopcTRie3Drqq
        tmS1YrKnXlA3gChrByQQb9pj8/B/OLhctSAO5R6T+plksArvL4NDNuZj11uO8qmJMWOQu+
        Yd67WqSlzHuoYkt4/rG9TIqKE+F6tq0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-R37ELW45OEumAcT7m6n73Q-1; Fri, 23 Jun 2023 05:05:11 -0400
X-MC-Unique: R37ELW45OEumAcT7m6n73Q-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f5df65fa35so2431235e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 02:05:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687511110; x=1690103110;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pguH3U8Bb3zv/4/0aDT3aEspkKoXYOCNJWdP7zh3GRw=;
        b=bFH0tCQJwm5uGbYj7zsa8JLOA0jubapOugs7CriSOT2uw+8rd1h36FBvXwhpTDrTrc
         0qXW26jfot1QxbuoQdekcm+rAlKjGx1TUAW4HZrHcLmuWmOMOFByK4KfpsydRBpWUyyo
         IoE/EcAyqXhislIL8PZ75iDMXN0edy4ejnHn1c6FMOsRAMKeiVxFmTUwbEJJ954GTC1O
         KQCpajBcL+78o5p4PGHJzJv3vpMZGR36Vm+BiMmvTIhiSpP88vYZdZz3cirBNqFOnSRN
         mgB8uCDznXJFG2VOdhNFanId+CtXg4I/aQBTT+0bn93a4N6kuy3sl2ABTZlzXHIQW+U3
         zYoA==
X-Gm-Message-State: AC+VfDzkIV272zfUQj8HvClIO5s4o2eGpYabBmjAVQ1VMZIi7t8wLlY9
        Pz/GU5n+UqG56eUgQGzZd2c6pG1tgKrG7pPWrbAqhT7lYq1+aXuaw2suxCYycmT3a9rRyVE8M0v
        070PHIEMQdjJF7/0TmQXN8emJ
X-Received: by 2002:a05:600c:3653:b0:3f9:bb1d:ac1f with SMTP id y19-20020a05600c365300b003f9bb1dac1fmr6586481wmq.7.1687511109817;
        Fri, 23 Jun 2023 02:05:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4E54SGRmgaxisSuvMutI6oIRT8Zg2mEv3LSP5ryH95Ya6fsQ8vROo7ATWgSIjmGocyJpWfcg==
X-Received: by 2002:a05:600c:3653:b0:3f9:bb1d:ac1f with SMTP id y19-20020a05600c365300b003f9bb1dac1fmr6586464wmq.7.1687511109552;
        Fri, 23 Jun 2023 02:05:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id u8-20020a05600c00c800b003f70a7b4537sm1721769wmm.36.2023.06.23.02.05.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 02:05:09 -0700 (PDT)
Message-ID: <963f8bfa-ab05-466e-88b1-e5a17804f10f@redhat.com>
Date:   Fri, 23 Jun 2023 11:05:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] drm/mgag200: set variable mgag200_modeset
 storage-class-specifier to static
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, Tom Rix <trix@redhat.com>,
        airlied@redhat.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20230517134140.874179-1-trix@redhat.com>
 <f3d8cbe7-11a6-14a3-e161-906c73c5ade3@suse.de>
From:   Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <f3d8cbe7-11a6-14a3-e161-906c73c5ade3@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/2023 10:28, Thomas Zimmermann wrote:
> 
> 
> Am 17.05.23 um 15:41 schrieb Tom Rix:
>> smatch reports
>> drivers/gpu/drm/mgag200/mgag200_drv.c:23:5: warning: symbol
>>    'mgag200_modeset' was not declared. Should it be static?
>>
>> This variable is only used in its defining file, so it should be static
>>
>> Signed-off-by: Tom Rix <trix@redhat.com>
> 
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> 
>> ---
>>   drivers/gpu/drm/mgag200/mgag200_drv.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/mgag200/mgag200_drv.c 
>> b/drivers/gpu/drm/mgag200/mgag200_drv.c
>> index 976f0ab2006b..abddf37f0ea1 100644
>> --- a/drivers/gpu/drm/mgag200/mgag200_drv.c
>> +++ b/drivers/gpu/drm/mgag200/mgag200_drv.c
>> @@ -20,7 +20,7 @@
>>   #include "mgag200_drv.h"
>> -int mgag200_modeset = -1;
>> +static int mgag200_modeset = -1;
>>   MODULE_PARM_DESC(modeset, "Disable/Enable modesetting");
>>   module_param_named(modeset, mgag200_modeset, int, 0400);
> 

applied to drm-misc-next

Thanks for your contribution.

-- 

Jocelyn

