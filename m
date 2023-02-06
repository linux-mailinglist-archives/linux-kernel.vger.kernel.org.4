Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574EF68C618
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 19:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjBFSsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 13:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjBFSsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 13:48:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6495270E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 10:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675709237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hZ8casbfFD6TcKT9nSSfpPqsT0aAOl1x1pNCxblmoQc=;
        b=QqnWAfCcCTfhcbG6N0wC1ala5VkUHRg8vbImapztsg3lUi1fAcaL8bpE4oPZzDeeyYy+vg
        hwFMlPhsvpsEBzOTQ7chHgMwj2baOHBVcP8gVTKo5waw8Gt7A/RFpqLfwxGBdZyji3orqB
        0AfSnraBnVKPT5wJMRWtrRAEie4ytWc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-157-8fw6-7wFPLu2eEFbtPYmzA-1; Mon, 06 Feb 2023 13:47:16 -0500
X-MC-Unique: 8fw6-7wFPLu2eEFbtPYmzA-1
Received: by mail-wm1-f72.google.com with SMTP id l38-20020a05600c1d2600b003ddff4b9a40so6964365wms.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 10:47:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hZ8casbfFD6TcKT9nSSfpPqsT0aAOl1x1pNCxblmoQc=;
        b=mxbDt/pa0pzHIRmcfFTvrO3bl8mL927mzEKXJpGRZTYqA/ImAOYUi8pTi47OOrXn2X
         oRFdT5qACI/TlB0aoezMJM8mafmaeBAF+w0tmDftQR4cVpePxMRzYY58GCF97vZ65Xz+
         U27JpLtqkT50040ldNCBBTXPlgiaiH4wLInoQ15jMQ59Sy4XMSlToxLRNvjNgkkrWTNC
         TAM4lrGLPltpTjSxX36XuGGUClQFqyj6XKk2lRMjmzgxnuyJ6UJeePN1XNP30pRhefge
         Z+BR81LPP5uyGxpPq3QRiCEQ3g1z5nJAWIzdAJtxneDBwsqirYOjE6xrWShCl2DOLIQB
         aI6g==
X-Gm-Message-State: AO0yUKUrpeWq5JmNlPRnAca8FaKaehTfZSl727erNsqYVFtCt1wu3u1i
        qz3zDSrj1+vE3UzfLAa+6MsM25x4/f+e1AzeW4GrFq225kOLaPh9gZV4H72JftST1c5hl8L+Ymf
        0Cvr0nFrSpWb0233HBOAZH8mb
X-Received: by 2002:a05:600c:18a6:b0:3dd:1a8b:7374 with SMTP id x38-20020a05600c18a600b003dd1a8b7374mr702579wmp.5.1675709235680;
        Mon, 06 Feb 2023 10:47:15 -0800 (PST)
X-Google-Smtp-Source: AK7set9O+AFBlSx1vEYGijuQNmYcM6SnLQcrjncn2maMR7AxUw5thKkNysCaeGtaTLYwLHkwW2zybw==
X-Received: by 2002:a05:600c:18a6:b0:3dd:1a8b:7374 with SMTP id x38-20020a05600c18a600b003dd1a8b7374mr702568wmp.5.1675709235494;
        Mon, 06 Feb 2023 10:47:15 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id c7-20020a05600c0ac700b003d1d5a83b2esm16444126wmr.35.2023.02.06.10.47.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 10:47:15 -0800 (PST)
Message-ID: <a1cd8c74-98f4-bff0-0344-cbece787c6e8@redhat.com>
Date:   Mon, 6 Feb 2023 19:47:13 +0100
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
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        asahi@lists.linux.dev, Alyssa Rosenzweig <alyssa@rosenzweig.io>
References: <20230205125124.2260-1-lina@asahilina.net>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20230205125124.2260-1-lina@asahilina.net>
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

Hello Lina,

On 2/5/23 13:51, Asahi Lina wrote:
> Other functions touching shmem->sgt take the pages lock, so do that here
> too. drm_gem_shmem_get_pages() & co take the same lock, so move to the
> _locked() variants to avoid recursive locking.
> 
> Discovered while auditing locking to write the Rust abstractions.
> 
> Fixes: 2194a63a818d ("drm: Add library for shmem backed GEM objects")
> Fixes: 4fa3d66f132b ("drm/shmem: Do dma_unmap_sg before purging pages")
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---

Good catch. The patch looks good to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

What about drm_gem_shmem_free() BTW, I believe that the helper should also
grab the lock before unmap / free the sgtable?

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

