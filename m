Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3225FB367
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 15:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiJKN0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 09:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiJKN0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 09:26:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5284F673
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 06:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665494807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C/D2ubrokwdjZ4UmudjC7tKrqdHyl96YEsZuvnHbSsY=;
        b=ROFyHNHD7iT5mPnuDFsnHYZOBRcHd6bqlHVBv4cl3AXO3fbbTKIJrRgfQkXQGQ00OpTx1a
        x0Z3X+dsN4zNFOGz8e2qzdBZqxrIcJLIwX4O5UcUnekJcDO3L0IPVR7ijQv+RqNa+3qwGB
        QOM2ieXfvKy4N7eUOvclP0XBKgj9glM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-633-tWJ_4FPPMgaaDCzDlTDdWg-1; Tue, 11 Oct 2022 09:26:45 -0400
X-MC-Unique: tWJ_4FPPMgaaDCzDlTDdWg-1
Received: by mail-wm1-f69.google.com with SMTP id n6-20020a7bc5c6000000b003c6bbe5d5cfso2716966wmk.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 06:26:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C/D2ubrokwdjZ4UmudjC7tKrqdHyl96YEsZuvnHbSsY=;
        b=f73NI5J3ea6CazDEz/sc2+7oz6JU4c0EM187KvGb2orGqLXUSLGya5uT/Bb/ebzyqk
         /CUPhhILLLQ+Thr7uvbZbQzYG1C9FoqFvf1dR/8S4PFnfp++oIgWiaMJUuYUEU3FmYdZ
         DUcT/0eG0V4bsxghThrMAdpcGerZi57yXU7Go4koy9WiGW3f7p/ASHdoSgNDigPf5VqL
         ZRyYATVhxLs8JGzlA0MXbYgxURhNMVH1/Z6WnUrh0Fq1yASF/cxj1168Vq3We6cmQmmu
         im43qIcvso3ROuq2dZk412ypFxfuuYBZsCk7fwdw4QoctQJlFqUptZac4YnzbR8pvZhi
         DaSg==
X-Gm-Message-State: ACrzQf12c1OTFolGKm3a5CMejUbBLkKcbbW08jOiE5DPQ5ClUhzUQeSn
        CTd7sFr2q8vEjBIjoBy2dK7MXbk7+FAW2vvB0bPOAr0NS+79XyqaUQ0/EGLxKKcvobLxBbfj4Nw
        MpoWiCEbGVyLhm8F/F/Y6/0so
X-Received: by 2002:a5d:6f17:0:b0:22e:33e7:6f6c with SMTP id ay23-20020a5d6f17000000b0022e33e76f6cmr14672170wrb.201.1665494804647;
        Tue, 11 Oct 2022 06:26:44 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7JCEmZje/mdCYZs1oElYJeXtNTZDsJU6C5VVdr9yT1pIHLP4srTC2ac//peQ+wjq9x4B44UA==
X-Received: by 2002:a5d:6f17:0:b0:22e:33e7:6f6c with SMTP id ay23-20020a5d6f17000000b0022e33e76f6cmr14672159wrb.201.1665494804467;
        Tue, 11 Oct 2022 06:26:44 -0700 (PDT)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bd22-20020a05600c1f1600b003c6b822bfe8sm4797242wmb.29.2022.10.11.06.26.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 06:26:26 -0700 (PDT)
Message-ID: <bbbd1ebb-f0cc-91d6-2959-28919a2e8893@redhat.com>
Date:   Tue, 11 Oct 2022 15:26:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 3/3] drm/crtc-helper: Add a drm_crtc_helper_atomic_check()
 helper
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org
References: <20221010170203.274949-1-javierm@redhat.com>
 <20221010170203.274949-4-javierm@redhat.com>
 <f6a49350-74d0-4923-7c80-8e6233dc135b@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <f6a49350-74d0-4923-7c80-8e6233dc135b@suse.de>
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

On 10/11/22 15:21, Thomas Zimmermann wrote:
> Hi
> 
> Am 10.10.22 um 19:02 schrieb Javier Martinez Canillas:
>> Provides a default CRTC state check handler for CRTCs that only have one
>> primary plane attached.
>>
>> There are some drivers that duplicate this logic in their helpers, such as
>> simpledrm and ssd130x. Factor out this common code into a CRTC helper and
>> make drivers use it.
>>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> 
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> 
> There really isn't much here for now. I suspect that there are more 
> drivers that could use this helper. If you merge this before ofdrm, I'll 
> rebase ofdrm on top.
>

Sure. I probably won't post a v2 until tomorrow and I believe ofdrm is
ready to be merged, so I'll just rebase this series on top of that once
just push it.

> Please also see my comment below.
> 
> 

[...]

>> +/**
>> + * drm_crtc_helper_atomic_check() - Helper to check CRTC atomic-state
>> + * @crtc: CRTC to check
>> + * @state: atomic state object
>> + *
>> + * Provides a default CRTC-state check handler for CRTCs that only have
>> + * one primary plane attached to it.
>> + *
>> + * This is often the case for the CRTC of simple framebuffers.
> 
> I'd add a reference to drm_plane_helper_atomic_check() to this 
> paragraph. Like
> 
>    See drm_plane_helper_atomic_check() for the respective plane helpers.
> 
> And also reference back from the plane-check helper to the CRTC-check 
> helper.
>

Good idea, I'll do that. Thanks for your review.
 
> Best regards
> Thomas
> 

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

