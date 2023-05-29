Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42407715178
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 00:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjE2WF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 18:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjE2WFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 18:05:55 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DBADB;
        Mon, 29 May 2023 15:05:53 -0700 (PDT)
Received: from [192.168.2.2] (109-252-150-34.dynamic.spd-mgts.ru [109.252.150.34])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 26C94660217A;
        Mon, 29 May 2023 23:05:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685397952;
        bh=E8D9UsqcqdEvEaSPqwft+gP6ubYKoB1Svo0H0BTDyFA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=P6uFKmXC0TuQ4UYU9RsteNwepJOX/EuIwZ3L7kLP8gvVCzg0XXjllPHK/tLG5xcGx
         VJDkSEKqLLRaaDkqDA2Hf3zPtNqI4QWffOKLx5/FByohz6tXFlgep4mKsnMP5uwn3J
         ITdsL7oiuo7wEZNTU8EDVMvfsF+ONOzX1R+omxBBDun/jsdmTI3x84WaBr4jCTXgfr
         tI6vDNXbD0B0JM8bMmC22PwJqZMhYPK/Q6UTa7HnDxLhfJH9ZyAYCFj8XL7I/p7eZ8
         OMtQvEIhBWLr1Wmp8g1qFwPQodk8FA+dembDBoTf4wzxgIvxEG8mqJnTxmV0pQ8l/e
         hmFRL6ZZZSLFg==
Message-ID: <d813304a-cb9e-7e97-ebba-13b6126c6b9a@collabora.com>
Date:   Tue, 30 May 2023 01:05:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 6/6] drm/shmem-helper: Switch to reservation lock
Content-Language: en-US
To:     Emil Velikov <emil.l.velikov@gmail.com>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Liam Mark <lmark@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <jstultz@google.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tomi Valkeinen <tomba@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-tegra@vger.kernel.org, kernel@collabora.com
References: <20230521205112.150206-1-dmitry.osipenko@collabora.com>
 <20230521205112.150206-7-dmitry.osipenko@collabora.com>
 <CACvgo52QvmZw5k_9dmBHPB25rTdLZJzVG_vNFr8or+3f5sVO=Q@mail.gmail.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <CACvgo52QvmZw5k_9dmBHPB25rTdLZJzVG_vNFr8or+3f5sVO=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/23 16:02, Emil Velikov wrote:
>> -void drm_gem_shmem_put_pages(struct drm_gem_shmem_object *shmem)
>> +static int drm_gem_shmem_pin_locked(struct drm_gem_shmem_object *shmem)
>> +{
>> +       int ret;
>> +
>> +       dma_resv_assert_held(shmem->base.resv);
>> +
>> +       ret = drm_gem_shmem_get_pages(shmem);
>> +
>> +       return ret;
> With the assert_held in the getter, it would be less confusing to
> inline this and the unpin_locked functions.

Sorry, missed this comment earlier. The reason why it's a separate
function is because there will be another caller once we'll add the
drm-shrinker.

-- 
Best regards,
Dmitry

