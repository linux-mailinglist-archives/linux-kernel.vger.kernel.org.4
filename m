Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF35738E56
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 20:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjFUSQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 14:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjFUSQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 14:16:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA1AFE;
        Wed, 21 Jun 2023 11:16:35 -0700 (PDT)
Received: from [192.168.2.254] (109-252-154-132.dynamic.spd-mgts.ru [109.252.154.132])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 61D736606FAC;
        Wed, 21 Jun 2023 19:16:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687371394;
        bh=PQA2rc/Gs+XDzpOTYaQqwgwiDRANnpvkFuiUXn6B45A=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=a6uFWwMGM2Wn9oqIqY7w7ZXRsmW9BSZjBsI4Ir5fTcMPux5toiFC6wlyILN77QVfb
         0L+ZFaptUWmBOJZm2yvNv0eh15H4wUN+1EiHsUsv63mFz6hu/moMeG3T4oQV6i35F0
         sHKIlQJA6GxprALI1nuPl+VQIhbWRMZVczzPnrUz21ntwNTap1H/IueLMyT7eRukEz
         N3GdhDZdinRaXuMBSFTeA1MUT7KUhYwb+koIItqlM5t/HFmZVenSeMDvjEPNqpSvPr
         WnQ/f7ngy10rNR4q+TxKWqOltsVMxB7/UwzmOPEST6X3Ell8COhkS5FvW3+wJ2ZV00
         b/tPSDkrH1Jtg==
Message-ID: <106bc72b-9358-de06-6f3f-06fdfa3859cd@collabora.com>
Date:   Wed, 21 Jun 2023 21:16:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH v4 2/6] dma-buf/heaps: Don't assert held reservation lock
 for dma-buf mmapping
Content-Language: en-US
To:     "T.J. Mercier" <tjmercier@google.com>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
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
        Emil Velikov <emil.l.velikov@gmail.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        kernel@collabora.com, linux-media@vger.kernel.org
References: <20230529223935.2672495-1-dmitry.osipenko@collabora.com>
 <20230529223935.2672495-3-dmitry.osipenko@collabora.com>
 <CABdmKX2RU2iYyUssBpwS17zA1dfegjzdo4pxp0r8cOCWcY9=kg@mail.gmail.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <CABdmKX2RU2iYyUssBpwS17zA1dfegjzdo4pxp0r8cOCWcY9=kg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/21/23 20:21, T.J. Mercier wrote:
> On Mon, May 29, 2023 at 3:46 PM Dmitry Osipenko
> <dmitry.osipenko@collabora.com> wrote:
>>
>> Don't assert held dma-buf reservation lock on memory mapping of exported
>> buffer.
>>
>> We're going to change dma-buf mmap() locking policy such that exporters
>> will have to handle the lock. The previous locking policy caused deadlock
>> problem for DRM drivers in a case of self-imported dma-bufs once these
>> drivers are moved to use reservation lock universally. The problem
>> solved by moving the lock down to exporters. This patch prepares dma-buf
>> heaps for the locking policy update.
>>
> Hi Dmitry,
> 
> I see that in patch 6 of this series calls to
> dma_resv_lock/dma_resv_unlock have been added to the
> drm_gem_shmem_helper functions and some exporters. But I'm curious why
> no dma_resv_lock/dma_resv_unlock calls were added to these two dma-buf
> heap exporters for mmap?

DMA-buf heaps are exporters, drm_gem_shmem_helper is importer. Locking
rules are different for importers and exporters.

DMA-heaps use own locking, they can be moved to resv lock in the future.

DMA-heaps don't protect internal data in theirs mmap() implementations,
nothing to protect there.

-- 
Best regards,
Dmitry

