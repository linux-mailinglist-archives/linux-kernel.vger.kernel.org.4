Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D566560BC34
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 23:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiJXVcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 17:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbiJXVbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 17:31:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B09C7C19F
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 12:38:19 -0700 (PDT)
Received: from [192.168.2.31] (109-252-112-196.nat.spd-mgts.ru [109.252.112.196])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9D7DF6602820;
        Mon, 24 Oct 2022 20:36:57 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666640218;
        bh=9YlOiiJFFn/lRLlSj5J0a6w6dJtCCcMej435SmulU3Q=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=CFcmZ8C6BB2A8CM2A0b7Wfltf1yPbbEtg6pjnWc0MwNzZ6ghV0qhGpzg30o4KQG1n
         Oi3hLsCSWwJWf0Q5Afgij5SRvAwoSLlsxO7pLUTohqkh8xX+ABtO+NOf5TZx38g1M6
         H4XjZ7Y2YNOG059jANmN9lvo8Sm4OWKy+VQL1jVaFmkDea2ZdEMTwYYA0Lco3SF/fA
         1bb9pk0jYP5Q3vUx5xLippRhU271U1TEvV2cy8EVXOOmH2jrZBmtwtEOZ2QqUXkxKS
         QzUbQhZEA11BinyEh3DNFMXeS5N4Wyrrlhy+gE2+Igo+FKsB2Xt4eqPWbiDktVnJ3B
         5BkaVKDy5InxQ==
Message-ID: <47c5b64e-b765-41be-b58b-cdc83edeca49@collabora.com>
Date:   Mon, 24 Oct 2022 22:36:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v1] drm: Switch drm_client_buffer_delete() to unlocked
 drm_gem_vunmap
Content-Language: en-US
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20221020213335.309092-1-dmitry.osipenko@collabora.com>
In-Reply-To: <20221020213335.309092-1-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/22 00:33, Dmitry Osipenko wrote:
> The drm_client_buffer_delete() wasn't switched to unlocked GEM vunmapping
> by accident when rest of drm_client code transitioned to the unlocked
> variants of the vmapping functions. Make drm_client_buffer_delete() use
> the unlocked variant. This fixes lockdep warning splat about missing
> reservation lock when framebuffer is released.
> 
> Reported-by: kernel test robot <yujie.liu@intel.com>
> Link: https://lore.kernel.org/dri-devel/890f70db-68b0-8456-ca3c-c5496ef90517@collabora.com/T/
> Fixes: 79e2cf2e7a19 ("drm/gem: Take reservation lock for vmap/vunmap operations")
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  drivers/gpu/drm/drm_client.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_client.c b/drivers/gpu/drm/drm_client.c
> index fbcb1e995384..38e1be991caa 100644
> --- a/drivers/gpu/drm/drm_client.c
> +++ b/drivers/gpu/drm/drm_client.c
> @@ -235,7 +235,7 @@ static void drm_client_buffer_delete(struct drm_client_buffer *buffer)
>  {
>  	struct drm_device *dev = buffer->client->dev;
>  
> -	drm_gem_vunmap(buffer->gem, &buffer->map);
> +	drm_gem_vunmap_unlocked(buffer->gem, &buffer->map);
>  
>  	if (buffer->gem)
>  		drm_gem_object_put(buffer->gem);

Applied to misc-next

-- 
Best regards,
Dmitry

