Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E48738E6F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 20:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjFUSSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 14:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjFUSR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 14:17:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285DB2139;
        Wed, 21 Jun 2023 11:17:36 -0700 (PDT)
Received: from [192.168.2.254] (109-252-154-132.dynamic.spd-mgts.ru [109.252.154.132])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 574366606FAC;
        Wed, 21 Jun 2023 19:17:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687371454;
        bh=zmKL+M3CGk6HThKHIP9ubJfE9b7029/+Mv8Ujzw+Hbk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bVOzuhAOq2uJZVaj/5XigJdh/I6rgUGxJUrtMGIZ5RNOsTocyNU6xHMZLHSfb0qOK
         BYAN6ioVATc9QAliy1MG/l7CSJVKuP21ALotoS/yqE8uZCZt4SP5TykgBFFyhxsgz9
         XBAJSlSbFCBuBpoe3TMaaGPTBYBJM2wK5/dnZ50Hkf8GXcbeRwY5Gxo6VvBaCZ4M74
         39eSteKg8Mlwp64C2wVVN/D6zzCt0xT6IaLw7m/iZE5evOkWrfOVbtnIH9ldGF++sG
         InvwtE2fxcXzpXjtDI2irEMmVHLQT3TZ1AmOxXrZc3xfIEsUYtnLdq3lMyllOY1LLj
         n+TS5qiJhS6VA==
Message-ID: <9d800e80-3860-d58c-3a96-0f5e73cb9309@collabora.com>
Date:   Wed, 21 Jun 2023 21:17:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH v4 5/6] dma-buf: Change locking policy for mmap()
Content-Language: en-US
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Sumit Semwal <sumit.semwal@linaro.org>
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
 <1a04706a-caee-114c-6b6e-e4fdb815e619@collabora.com>
 <3ddf2152-392f-095d-3db6-c0c5c56e0cbf@amd.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <3ddf2152-392f-095d-3db6-c0c5c56e0cbf@amd.com>
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

On 6/21/23 08:42, Christian König wrote:
> Am 20.06.23 um 17:58 schrieb Dmitry Osipenko:
>> On 5/31/23 22:58, Dmitry Osipenko wrote:
>>> On 5/30/23 01:39, Dmitry Osipenko wrote:
>>>> Change locking policy of mmap() callback, making exporters responsible
>>>> for handling dma-buf reservation locking. Previous locking policy
>>>> stated
>>>> that dma-buf is locked for both importers and exporters by the dma-buf
>>>> core, which caused a deadlock problem for DRM drivers in a case of
>>>> self-imported dma-bufs which required to take the lock from the DRM
>>>> exporter side.
>>>>
>>>> Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
>>>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>>> ---
>>>>   drivers/dma-buf/dma-buf.c | 17 +++--------------
>>>>   1 file changed, 3 insertions(+), 14 deletions(-)
>>> Christian, you acked the drm patch of this series sometime ago, perhaps
>>> it also implies implicit ack to this patch, but I'd prefer to have the
>>> explicit ack. I'll apply this series to drm-misc later this week if
>>> you'll approve this dma-buf change. Thanks in advance!
>> I'll merge the patches tomorrow. If there are any additional comments,
>> then please don't hesitate to post them.
> 
> Sorry for not responding earlier, I have been moving both my office as
> well as my household and still catching up.
> 
> I don't have time for an in-deep review, but my ack stands for the whole
> series.

Thanks! I'll add yours ack and merge patches soon

-- 
Best regards,
Dmitry

