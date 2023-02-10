Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5B4691F37
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 13:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbjBJMjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 07:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbjBJMjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 07:39:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BC571016
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 04:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676032706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PI3oUcKvFRhOHs5XVCh/GOynsoU/7+zmMQO9bHrhWBo=;
        b=c1mhwutQ83+aGK+iERWiNQkmIHh1p4rDvL69StzLB8ZpIUHysck7G77JHMQ/lhVwVCGDSr
        ZfqO2oxLqUjXVn2GDiPxbq2M1+rmEtWx9kBn+DFt2lN2zEKxxO35dWypPqwkVss+W5V0NA
        Bclo9mGTLUer/SY/9ixxbk19h44UWls=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-149-qDbXjn_VNxGojc7jKh6qpQ-1; Fri, 10 Feb 2023 07:38:25 -0500
X-MC-Unique: qDbXjn_VNxGojc7jKh6qpQ-1
Received: by mail-wm1-f72.google.com with SMTP id k9-20020a05600c1c8900b003dc5dec2ac6so4520548wms.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 04:38:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PI3oUcKvFRhOHs5XVCh/GOynsoU/7+zmMQO9bHrhWBo=;
        b=xBe0tV3Uc1k5oItEoFRWpQDems1Nz7CwHrTGUYBI7oeOzA7l00BPcesG9wTFAJvSu7
         47EJmu4KwmoGhuafTpMqp4r64O6LoVWV7lDwo/xZp6Cu5PQ7FE2T8iLX8GUrltUREURF
         QdbyZBfmAW9BOFUpSTGn0X7COytAOoD06t8gjHb8BEUGlzXpb5PWRg33fUZNqN0qoEAK
         Ql1MgMPVOs2vBNbbArJUO1uITZZ0wzfDpzZGFaBRxX4uc00bhL/VEWVhtiCrEa2w6pSu
         z9Tk9FEominotunKjYxYFp+qTHN8maIzwgTn2wBBXpIVvfEKKkjs07DALq87ANS53Z2u
         rEyw==
X-Gm-Message-State: AO0yUKWQjpxucxjD0cTRDQYmqHYMRtLBEP9v2j+toW0ufI55qb8Yyqrg
        FhQEhU8rKQEe9jXva5NzSYWIe+HCeVvyDv8PHyGGcOh3jpI46oYGu6QJJQroz2nai5H1H4rKGEu
        r0WZ7DcO4pslM+CA8TLKmSc0b
X-Received: by 2002:a5d:6750:0:b0:2be:64bb:1d84 with SMTP id l16-20020a5d6750000000b002be64bb1d84mr13710722wrw.24.1676032704781;
        Fri, 10 Feb 2023 04:38:24 -0800 (PST)
X-Google-Smtp-Source: AK7set94Bsqs5Ph/JyHM/6nNXatqCHays9ZS2lteG/fGGCwXWMilMicUznlG3v++jadE4RijV3uDbQ==
X-Received: by 2002:a5d:6750:0:b0:2be:64bb:1d84 with SMTP id l16-20020a5d6750000000b002be64bb1d84mr13710711wrw.24.1676032704636;
        Fri, 10 Feb 2023 04:38:24 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id s10-20020adff80a000000b002c54c7b9c78sm612414wrp.76.2023.02.10.04.38.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 04:38:24 -0800 (PST)
Message-ID: <bee5d455-3e15-427a-d7a6-f633a748f4c3@redhat.com>
Date:   Fri, 10 Feb 2023 13:38:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] drm/shmem-helper: Fix locking for
 drm_gem_shmem_get_pages_sgt()
Content-Language: en-US
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Asahi Lina <lina@asahilina.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        asahi@lists.linux.dev, Alyssa Rosenzweig <alyssa@rosenzweig.io>
References: <20230205125124.2260-1-lina@asahilina.net>
 <a1cd8c74-98f4-bff0-0344-cbece787c6e8@redhat.com>
In-Reply-To: <a1cd8c74-98f4-bff0-0344-cbece787c6e8@redhat.com>
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

On 2/6/23 19:47, Javier Martinez Canillas wrote:
> Hello Lina,
> 
> On 2/5/23 13:51, Asahi Lina wrote:
>> Other functions touching shmem->sgt take the pages lock, so do that here
>> too. drm_gem_shmem_get_pages() & co take the same lock, so move to the
>> _locked() variants to avoid recursive locking.
>>
>> Discovered while auditing locking to write the Rust abstractions.
>>
>> Fixes: 2194a63a818d ("drm: Add library for shmem backed GEM objects")
>> Fixes: 4fa3d66f132b ("drm/shmem: Do dma_unmap_sg before purging pages")
>> Signed-off-by: Asahi Lina <lina@asahilina.net>
>> ---
> 
> Good catch. The patch looks good to me.
> 
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> 

Pushed this to drm-misc (drm-misc-next). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

