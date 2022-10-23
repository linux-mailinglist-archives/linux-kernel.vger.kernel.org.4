Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C9F6094EC
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 19:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiJWRBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 13:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiJWRBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 13:01:34 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1672C42D58
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 10:01:32 -0700 (PDT)
Received: from [192.168.2.31] (unknown [109.252.112.196])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 86D4E660231A;
        Sun, 23 Oct 2022 18:01:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666544491;
        bh=URpcSAxzMg+PmcxqDirkleelgbYhO55RtdH6ohbFw+s=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=XlLbKkWzUPvGqpVarrySAieV23UFR8He3rsXS9QgI81CqocdJ+1wO8gR/IeG4i2dp
         3KIROkehklYkKlN0eNPt7nNHE5FyxLaYmc9yZkEHl7pRZ0WgboqWD2FwP29PqfT2gE
         UhJSisSuIY1Yz62JEyMABjjj5TWf5a92aBpmvEpYvBh+SQwrEfOzyipCfsot5P/BfE
         ZXNS9Nt0k1F0ik6ryXNMS8UfTUPI8ZEKI98caFb/+pQdsOrE30i9GOzSsgTQbho/Vi
         NMjB2EOj4LP3EzF/rFkyu5lrR5hHa6gXLEghyZfXd5/f8v4QkoZZ7w0yBV9RRWMH/9
         SJGyajd8uZ9Qg==
Message-ID: <e0c951b1-7e6e-272f-6fc6-bbe4a4b13ee7@collabora.com>
Date:   Sun, 23 Oct 2022 20:01:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v1] drm: Switch drm_client_buffer_delete() to unlocked
 drm_gem_vunmap
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
References: <20221020213335.309092-1-dmitry.osipenko@collabora.com>
Content-Language: en-US
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

Hello,

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

Christian, could you please give yours r-b? The dim insists that the
patch should have r-b or it won't let me push to misc-next. Thanks in
advance!

-- 
Best regards,
Dmitry

