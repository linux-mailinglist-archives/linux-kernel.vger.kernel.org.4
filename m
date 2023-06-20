Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCF8737110
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 17:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbjFTP6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 11:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjFTP6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 11:58:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9847EEA;
        Tue, 20 Jun 2023 08:58:19 -0700 (PDT)
Received: from [192.168.2.254] (109-252-154-132.dynamic.spd-mgts.ru [109.252.154.132])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 59F9B6600359;
        Tue, 20 Jun 2023 16:58:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687276697;
        bh=ls7zvLRnqt5Y8THKltOoAvNQHWOG4mAX3GW6W2X4FOI=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=BANzgbj+v61rPNNrF22H7ot9g3O9aOVblDPX03ehAkIYmdK/pOgHmG82/ArIZV8Hi
         ONnbjrL4ZXrkGAvQlnYGIBQoqsdXVmI8/RGLt49jpn0BRCcUq4XLim+wMEZxpJ5FEE
         VGyNS+iXCW3E/C0pGHsLrm12X7SiEwEd8tDFabhaKOcf/KkV4bxJOPHxLkGozcXWwK
         veGcVL3wWEf0HlJMaQo+RWSakvZzysjQikWYeCIRU6Xgo/9j3fQlKQRq5zTGYP6cJ1
         6lNXRGk9WOi6ulayQaVeMGl/p1KJ14LtJJZJ6zYgQkznXz0R4QdiP9pzSPkBqn1SbD
         FMkPCLTEHDO4A==
Message-ID: <1a04706a-caee-114c-6b6e-e4fdb815e619@collabora.com>
Date:   Tue, 20 Jun 2023 18:58:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH v4 5/6] dma-buf: Change locking policy for mmap()
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc:     linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-tegra@vger.kernel.org, kernel@collabora.com,
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
References: <20230529223935.2672495-1-dmitry.osipenko@collabora.com>
 <20230529223935.2672495-6-dmitry.osipenko@collabora.com>
 <91466907-d4e1-1619-27a8-a49a01cbc8f1@collabora.com>
Content-Language: en-US
In-Reply-To: <91466907-d4e1-1619-27a8-a49a01cbc8f1@collabora.com>
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

On 5/31/23 22:58, Dmitry Osipenko wrote:
> On 5/30/23 01:39, Dmitry Osipenko wrote:
>> Change locking policy of mmap() callback, making exporters responsible
>> for handling dma-buf reservation locking. Previous locking policy stated
>> that dma-buf is locked for both importers and exporters by the dma-buf
>> core, which caused a deadlock problem for DRM drivers in a case of
>> self-imported dma-bufs which required to take the lock from the DRM
>> exporter side.
>>
>> Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> ---
>>  drivers/dma-buf/dma-buf.c | 17 +++--------------
>>  1 file changed, 3 insertions(+), 14 deletions(-)
> 
> Christian, you acked the drm patch of this series sometime ago, perhaps
> it also implies implicit ack to this patch, but I'd prefer to have the
> explicit ack. I'll apply this series to drm-misc later this week if
> you'll approve this dma-buf change. Thanks in advance!

I'll merge the patches tomorrow. If there are any additional comments,
then please don't hesitate to post them.

-- 
Best regards,
Dmitry

