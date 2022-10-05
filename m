Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0497B5F5CC1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 00:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiJEWdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 18:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiJEWdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 18:33:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E56844C7
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 15:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665009198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+vUhq4r4XyBFUdHgKqV0dej+dlEeKdamNVi2/y0KE7I=;
        b=cQ2OV+VifNqb9/MvDG1jk1Ni6briovFXOqWqDFEYeXqIp3y8AY4XcUWNkU5Sreh65kIoj9
        6HsyK4H7co52uCjIb2Tf4JnbrZmMjaVuv5/FkGSdHt5EnF1lMomzWLojWg0dQh/ulhYlRy
        yKjo0zzNF94ImrOiGkdNPqyZS9SsrIk=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-425-RpUwKx6iOKez4JzhkLcN3w-1; Wed, 05 Oct 2022 18:33:09 -0400
X-MC-Unique: RpUwKx6iOKez4JzhkLcN3w-1
Received: by mail-il1-f198.google.com with SMTP id h8-20020a056e021b8800b002f9c2e31750so278662ili.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 15:33:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=+vUhq4r4XyBFUdHgKqV0dej+dlEeKdamNVi2/y0KE7I=;
        b=FHaqDB6ZCvW8fvAuihIjexlDPG+6b1AivFV0iXNOGQiQeMoyXv9+QyoQWMxLlaQoTp
         dhIaiXu1cNEQWW1SDsc6Rg+ilQdDY7M2ySKQe9FP+Gju0mmjB5dorjT3RCnvD0qjEJN/
         XYIhO/zjhiDekVieZTkZ3ZzCApX8kyuL8w6fA1CdCd8fYDD2HZXMkijNb+QWqi8dcW2B
         YjtmqXDYIdQ6FIlqoKphm1GpFJIgdGYMAgMAHgab3tqtsV3Yku0vGGERAAOmJYZHxCtr
         1NOe0hZN0Btn8Um9mud3yKxVvLJHW2OBlIxNqibkYwranm313XLosJIXc/b81z6/NkeT
         pMLA==
X-Gm-Message-State: ACrzQf2fEznbYvgXZSSwLKbMwvKtgi6NgK6tWMNaVr/cGtVj6BHWsSua
        U+MAtCHMU7iZcy275h8vi77HM4b8OTgQHPVAPmaGNvaT6GEWCoH29FKuJt9LsYQP2C8XJFH+y+T
        AstVwX128poCiWI3yhYAE77ea
X-Received: by 2002:a05:6e02:160a:b0:2f9:8a30:c3af with SMTP id t10-20020a056e02160a00b002f98a30c3afmr905817ilu.11.1665009187044;
        Wed, 05 Oct 2022 15:33:07 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7THQAbirZ49N9OGGm9eNgjnxvJVm0Nb3tua0eaaJweHQHZSL7JgG8M5d6J6W+IqmROYUkcMQ==
X-Received: by 2002:a05:6e02:160a:b0:2f9:8a30:c3af with SMTP id t10-20020a056e02160a00b002f98a30c3afmr905808ilu.11.1665009186828;
        Wed, 05 Oct 2022 15:33:06 -0700 (PDT)
Received: from [10.56.18.1] ([140.209.96.154])
        by smtp.gmail.com with ESMTPSA id o2-20020a05660213c200b006814fd71117sm7166075iov.12.2022.10.05.15.33.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 15:33:06 -0700 (PDT)
Message-ID: <be0b278f-0c28-fe5b-5179-50c126d52996@redhat.com>
Date:   Thu, 6 Oct 2022 00:33:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v2] drm/ssd130x: Iterate over damage clips instead of
 using a merged rect
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     Jocelyn Falempe <jfalempe@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org
References: <20220930152944.2584356-1-javierm@redhat.com>
 <9fdaaae1-982c-92e1-bc61-a6db3e94ef56@suse.de>
Content-Language: en-US
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <9fdaaae1-982c-92e1-bc61-a6db3e94ef56@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/22 19:18, Thomas Zimmermann wrote:
> 
> 
> Am 30.09.22 um 17:29 schrieb Javier Martinez Canillas:
>> The drm_atomic_helper_damage_merged() helper merges all the damage clips
>> into one rectangle. If there are multiple damage clips that aren't close
>> to each other, the resulting rectangle could be quite big.
>>
>> Instead of using that function helper, iterate over all the damage clips
>> and update them one by one.
>>
>> Suggested-by: Jocelyn Falempe <jfalempe@redhat.com>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> 
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> 

Pushed this to drm-misc (drm-misc-next) now. Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

