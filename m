Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DADD768D4AC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 11:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjBGKoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 05:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjBGKoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 05:44:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324D15BB8
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 02:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675766623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e9w8e2JcvMX6iMDnX/Jbx1d9onPql+IXVufG06c+nXs=;
        b=CWr2TY3bkpiHSA9OMEFpvNQ3EB+h/JmRrfHwHkpg+bAzAXaE9vWXfnUkcAzRvSX379md9c
        JsoawLCBokXsnvrHkP8mM0NdV6mVNXE240G+PtNJJ3OcSi0qCMVzcnnhCIJRmvJKz2PVF7
        4Ri6Hl5Hs0XrKRxl9YB3NuvJo+C0AdM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-468-vnWEO7dmMsCUPSSXwze9aA-1; Tue, 07 Feb 2023 05:43:41 -0500
X-MC-Unique: vnWEO7dmMsCUPSSXwze9aA-1
Received: by mail-wr1-f72.google.com with SMTP id c14-20020a5d528e000000b002c3f54b828bso223188wrv.21
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 02:43:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e9w8e2JcvMX6iMDnX/Jbx1d9onPql+IXVufG06c+nXs=;
        b=FElN/Vc7/w18gxOo6o+xf1S3FDKCjynTlOL2kqCdRaR+Wbc4XpxzXjbh1/yCw7KjQT
         PUzZ81K9ZHzu8JQ/AFRyrlNQ3/4MCq+LOW74p0tZHoFJihsYrE3jFK3QWNJZr/vhBKIN
         UHDwhAo3+WZyX0nCcvzfzOstd7MgSjAOXUnA0UnmVB80DrSvV/OEvJJfBspU2oOYflWT
         4hvvhr24ypohTTySoYBafic1MsNh320jSTA9EC4bUAOBHrWVcwXNuT2ilPLLWw8jc0Gt
         jMrJ3PcahIOd/NOKfz0BsMebt8D227Fu2WuzsTFIRyMyBPC5TEhsUBOaKKSrzVgY8YS8
         pHOw==
X-Gm-Message-State: AO0yUKWBn98AqlN7hjFQ5BcJ/8rUxAPrXd92h/Co2WX00EKMKKD1yWbH
        zUFSyrqu4PUmO6IUxDRMbf5XyK5bbApwiZruOaLED9etDGevro1b3cUC5dD1OeyPS+iSMPmV4u/
        qYWNAWWRbQG8t2WLtoMViI3is
X-Received: by 2002:a05:600c:a68f:b0:3db:1f68:28f with SMTP id ip15-20020a05600ca68f00b003db1f68028fmr2479694wmb.24.1675766620729;
        Tue, 07 Feb 2023 02:43:40 -0800 (PST)
X-Google-Smtp-Source: AK7set+3X9OYULToFjxq0/e5ycg2dn+KVQVTkxzR4pq1pJZIYm4hVjPpyQn+MPCc8jKQ+WKwgg9A/w==
X-Received: by 2002:a05:600c:a68f:b0:3db:1f68:28f with SMTP id ip15-20020a05600ca68f00b003db1f68028fmr2479685wmb.24.1675766620553;
        Tue, 07 Feb 2023 02:43:40 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id r16-20020a05600c459000b003e00c9888besm2692340wmo.30.2023.02.07.02.43.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 02:43:40 -0800 (PST)
Message-ID: <a69c7362-52a5-ed26-ce12-69364d12fcf6@redhat.com>
Date:   Tue, 7 Feb 2023 11:43:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] drm/shmem-helper: Fix locking for
 drm_gem_shmem_get_pages_sgt()
Content-Language: en-US
To:     Asahi Lina <lina@asahilina.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        asahi@lists.linux.dev
References: <20230205125124.2260-1-lina@asahilina.net>
 <a1cd8c74-98f4-bff0-0344-cbece787c6e8@redhat.com>
 <d3331cf8-02df-bf15-586b-af9d10830758@asahilina.net>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <d3331cf8-02df-bf15-586b-af9d10830758@asahilina.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/23 11:33, Asahi Lina wrote:
> On 07/02/2023 03.47, Javier Martinez Canillas wrote:
>> Hello Lina,
>>
>> On 2/5/23 13:51, Asahi Lina wrote:
>>> Other functions touching shmem->sgt take the pages lock, so do that here
>>> too. drm_gem_shmem_get_pages() & co take the same lock, so move to the
>>> _locked() variants to avoid recursive locking.
>>>
>>> Discovered while auditing locking to write the Rust abstractions.
>>>
>>> Fixes: 2194a63a818d ("drm: Add library for shmem backed GEM objects")
>>> Fixes: 4fa3d66f132b ("drm/shmem: Do dma_unmap_sg before purging pages")
>>> Signed-off-by: Asahi Lina <lina@asahilina.net>
>>> ---
>>
>> Good catch. The patch looks good to me.
>>
>> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
>>
>> What about drm_gem_shmem_free() BTW, I believe that the helper should also
>> grab the lock before unmap / free the sgtable?
> 
> That's called from driver free callbacks, so it should only be called
> when there are no other users left and the refcount is zero, right? If
> there's anyone else racing it I think we have bigger problems than the
> pages lock at that point, since the last thing it does is `kfree(shmem);` ^^
>

Yes, I was wondering only for the critical section that does:

		if (shmem->sgt) {
			dma_unmap_sgtable(obj->dev->dev, shmem->sgt,
					  DMA_BIDIRECTIONAL, 0);
			sg_free_table(shmem->sgt);
			kfree(shmem->sgt);
		}
		if (shmem->pages)
			drm_gem_shmem_put_pages(shmem);
 
> (In Rust terms this is equivalent to the Drop trait, which takes a
> mutable/exclusive reference, which means no other reference to the
> object can exist at that point, so no races are possible. And in fact in
> my Rust abstraction I trigger a drop of the Rust object embedded in the
> shmem object before calling drm_gem_shmem_free(), so if this invariant
> doesn't hold that code would be wrong too!)
>

But I guess you are correct and would be safe to assume that the .free
callback won't race against other struct drm_gem_object_funcs handlers.
I just felt to ask since wasn't sure about that.
 
I'll wait a few days in case someone else wants to take a look to your
patch and then push it to drm-misc. Thanks again! 

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

