Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10130738FC4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 21:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbjFUTNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 15:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbjFUTNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 15:13:31 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2DE1AC;
        Wed, 21 Jun 2023 12:13:30 -0700 (PDT)
Received: from [192.168.2.254] (109-252-154-132.dynamic.spd-mgts.ru [109.252.154.132])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 028EE6606F8B;
        Wed, 21 Jun 2023 20:13:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687374808;
        bh=31gqMqJTvRFMt5UXxpnNL/tjjOgIsbFkFx6XfkMlUWM=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=A3Y7bDPAKpM3rcSGHIFA8PI0m/Ja56hIfliBp5aUB9qJ3o4hKjENUg8ePC+LfMPay
         Ti7i29x1tskVZzHLppVRK4oHAfpc8p/+1bGshpQPYQ+qkH61xfOQ517Wc46UKrRyQs
         /dw/JkFPO1RqCuEiDoBHiGVzYr3WmzNDaYFA5vNR5vTGZA1k7BX2dIHNaXRm6Z/nPH
         Isr3BK5oFu+AwckPA0Ho3iD9RoDguo0aozKqX+qqJ67YGCsuvWJnYYsF+/jBvRLWY/
         R8pAonWP+H681L4/wbk8RMCWx3GWIyq+RgVg8jLOA54yM4nAhJ+YHaInxf40qaUZIT
         Iz40NQBqG0/oA==
Message-ID: <bad6b25d-15e6-5655-b017-3c2cc4a59ec3@collabora.com>
Date:   Wed, 21 Jun 2023 22:13:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH v4 0/6] Move dma-buf mmap() reservation locking down to
 exporters
Content-Language: en-US
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
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
        Emil Velikov <emil.l.velikov@gmail.com>
Cc:     linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-tegra@vger.kernel.org, kernel@collabora.com
References: <20230529223935.2672495-1-dmitry.osipenko@collabora.com>
In-Reply-To: <20230529223935.2672495-1-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/23 01:39, Dmitry Osipenko wrote:
> This patchset makes dma-buf exporters responisble for taking care of
> the reservation lock. I also included patch that moves drm-shmem to use
> reservation lock, to let CI test the whole set. I'm going to take all
> the patches via the drm-misc tree, please give an ack.
> 
> Previous policy stated that dma-buf core takes the lock around mmap()
> callback. Which meant that both importers and exporters shouldn't touch
> the reservation lock in the mmap() code path. This worked well until
> Intel-CI found a deadlock problem in a case of self-imported dma-buf [1].
> 
> The problem happens when userpace mmaps a self-imported dma-buf, i.e.
> mmaps the dma-buf FD. DRM core treats self-imported dma-bufs as own GEMs
> [2]. There is no way to differentiate a prime GEM from a normal GEM for
> drm-shmem in drm_gem_shmem_mmap(), which resulted in a deadlock problem
> for drm-shmem mmap() code path once it's switched to use reservation lock.
> 
> It was difficult to fix the drm-shmem problem without adjusting dma-buf
> locking policy. In parctice not much changed from importers perspective
> because previosly dma-buf was taking the lock in between of importers
> and exporters. Now this lock is shifted down to exporters.
> 
> [1] https://intel-gfx-ci.01.org/tree/drm-tip/Patchwork_114671v2/shard-snb5/igt@prime_vgem@sync@rcs0.html
> [2] https://elixir.bootlin.com/linux/v6.3-rc4/source/drivers/gpu/drm/drm_prime.c#L924

Applied to misc-next

-- 
Best regards,
Dmitry

