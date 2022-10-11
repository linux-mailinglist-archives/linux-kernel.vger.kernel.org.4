Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC37D5FB2E8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 15:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiJKNKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 09:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiJKNKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 09:10:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F25E02E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 06:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665493805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=thvlIsm/fxiw86jRXsCCSqqflOvpvNicCGXfc4rTb2E=;
        b=dDBIs7vg1Pvdggf99xdC7gQT78dG+6vvuspwSFSmJ9nERpQP2+1UizjL7p0AjGA9laus2U
        Fa5X54NHtFkLHUVI0CzyWu1fM/lVfvbgBhUSodiLEGKS7jcB63Q1dJ0IsumbmOFLUgfcyj
        6nWXrjhnVKmRbKeU+0XAVBxUtHupcRk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-637-nAFt5xn8MF-KCp7zHPA8XQ-1; Tue, 11 Oct 2022 09:10:03 -0400
X-MC-Unique: nAFt5xn8MF-KCp7zHPA8XQ-1
Received: by mail-wm1-f71.google.com with SMTP id v191-20020a1cacc8000000b003bdf7b78dccso8440345wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 06:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=thvlIsm/fxiw86jRXsCCSqqflOvpvNicCGXfc4rTb2E=;
        b=NlIbtdz+xjZtq1Fy77pnVih/6MsidM/Ss28mRpmC7kvezzPOkJ/GpWY7bhN5fJV5ZF
         YFx4hJ/NtqFZyn8TH1uW4UQK08HIEvekOROJ0U0MNeSOTPCzzlO1SPwGnDYmtE4uLGw7
         2kdhvTdzR1kSVZaMay2M8h6g8NT69fbxWHYpR6RUWw+UMbOwbyX/SxUoWSlOnhXFUC+C
         gQ4unDwhmw5+jIatrbe2he8uycOTOGvutzy0Nb/0knXR/JJ8WdnwTCUm9iNXePTwu0e6
         SgDVNLzkJJLDY/Pg0C5W/bKdZ+3XEh1MPoGU6HcJ+SUrfjv/88Vo9Xnk2fEW1N4u/D12
         /7/w==
X-Gm-Message-State: ACrzQf18a83bNsMgmw3IUVcP1prtLvoxMKj6Jylk4ffY25dcbyzCGyEP
        X9LOrE97FcpF1I4Wq1vEsSGEXFSq/hUCUQN8q8u/L4tOn4CxLQtUDf/Oxv9qWVucM4pKlt3/7+1
        U9S6+DPj7JYcHKdHiv8AMF1TQ
X-Received: by 2002:a7b:cd14:0:b0:3c6:bf44:770d with SMTP id f20-20020a7bcd14000000b003c6bf44770dmr5254545wmj.35.1665493802684;
        Tue, 11 Oct 2022 06:10:02 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5gcbU6PwwqP+FAMtJeHKur4l1vlHgqnaIB/vm2BBuL/XqcMa7ClWWTIgdYKUf/nQrS9V/52w==
X-Received: by 2002:a7b:cd14:0:b0:3c6:bf44:770d with SMTP id f20-20020a7bcd14000000b003c6bf44770dmr5254528wmj.35.1665493802432;
        Tue, 11 Oct 2022 06:10:02 -0700 (PDT)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bj4-20020a0560001e0400b0022e0580b7a9sm4302671wrb.17.2022.10.11.06.10.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 06:10:01 -0700 (PDT)
Message-ID: <e3e0b130-03b9-0fcc-a42c-2bd7b035c7e4@redhat.com>
Date:   Tue, 11 Oct 2022 15:09:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 1/3] drm/simpledrm: Do not call
 drm_atomic_add_affected_planes()
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org
References: <20221010170203.274949-1-javierm@redhat.com>
 <20221010170203.274949-2-javierm@redhat.com>
 <fc9a8b09-4b41-291e-d235-bb71eeb95f3c@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <fc9a8b09-4b41-291e-d235-bb71eeb95f3c@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas,

On 10/11/22 15:06, Thomas Zimmermann wrote:
> Hi
> 
> Am 10.10.22 um 19:02 schrieb Javier Martinez Canillas:
>> There's no need to add planes to the atomic state. Remove the call
>> to drm_atomic_add_affected_planes() from simpledrm.
>>
>> On full modesets, the DRM helpers already add a CRTC's planes to the
>> atomic state; see drm_atomic_helper_check_modeset(). There's no reason
>> to call drm_atomic_add_affected_planes() unconditionally in the CRTC's
>> atomic_check() in simpledrm. It's also too late, as the atomic_check()
>> of the added planes will not be called before the commit.
>>
>> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> 
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>

Thanks.
 
> There's also drm_atomic_add_affected_planes() in mgag200. Since you're 
> at it, I'd appreciate a patch.
>

Sure, I'll include in v2. I noticed that but didn't feel like posting
a patch because I'm not familiar with that device nor have HW to test.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

