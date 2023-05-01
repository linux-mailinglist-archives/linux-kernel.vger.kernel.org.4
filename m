Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D896E6F3313
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 17:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbjEAPmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 11:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbjEAPmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 11:42:50 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16073BC;
        Mon,  1 May 2023 08:42:48 -0700 (PDT)
Received: from [192.168.2.246] (109-252-144-198.dynamic.spd-mgts.ru [109.252.144.198])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EB81C66029DE;
        Mon,  1 May 2023 16:42:43 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1682955765;
        bh=tnb48ajCvVa+EQpEey/B5t9Rz5vp0zrnI8Dk3GtJzds=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=WgvDqGNqkRpELu/Mnul8g+QVtXq/hzn4k+FFEpusaFYSFGnm1Jzhw7htlINg83ht0
         rimocQaotDdO/fUi53zoTX3QHV7v9281Ek5Igtx+auJwFkjZpXDctQ0M/Kn5vHfS4+
         OW4QnmZX768H0BwI2PhD+LIZzOHhUDWBMs+Ix1NrYapO0+w/aY+gydF6hv1Foy7+Gb
         ViVwJ+6U+FpEkMOKSwdCn/llqkyoZM7FDHdwIeDlq2uH1XtoQerfiViPJdSJ5w6mWI
         1vjSPku078f0wkOVjQ9EvdrbQ3FtYALJUEpnGClgOfUj1aOcHAQUZKOvTnrFiO979u
         8o4Qf3UIpdQqQ==
Message-ID: <14d7ed85-7ab6-04d9-1958-d5ceae2a79f8@collabora.com>
Date:   Mon, 1 May 2023 18:42:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 6/7] dma-buf: Change locking policy for mmap()
Content-Language: en-US
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc:     linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        kernel@collabora.com, Sumit Semwal <sumit.semwal@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Liam Mark <lmark@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <jstultz@google.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tomi Valkeinen <tomba@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Emil Velikov <emil.l.velikov@gmail.com>
References: <20230406160637.541702-1-dmitry.osipenko@collabora.com>
 <20230406160637.541702-7-dmitry.osipenko@collabora.com>
In-Reply-To: <20230406160637.541702-7-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/23 19:06, Dmitry Osipenko wrote:
> Change locking policy of mmap() callback, making exporters responsible
> for handling dma-buf reservation locking. Previous locking policy stated
> that dma-buf is locked for both importers and exporters by the dma-buf
> core, which caused a deadlock problem for DRM drivers in a case of
> self-imported dma-bufs which required to take the lock from the DRM
> exporter side.
> 
> Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  drivers/dma-buf/dma-buf.c | 17 +++--------------
>  1 file changed, 3 insertions(+), 14 deletions(-)

Christian, may I add yours ack to this patch?

-- 
Best regards,
Dmitry

