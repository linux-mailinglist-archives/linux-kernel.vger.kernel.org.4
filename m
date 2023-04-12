Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE866DF8CF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 16:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjDLOkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 10:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbjDLOkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 10:40:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CBAC4EDD;
        Wed, 12 Apr 2023 07:39:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A069562A00;
        Wed, 12 Apr 2023 14:39:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2520DC4339E;
        Wed, 12 Apr 2023 14:39:45 +0000 (UTC)
Message-ID: <ec2f4f25-938d-f87c-90f2-2e7f69b27c8f@xs4all.nl>
Date:   Wed, 12 Apr 2023 16:39:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/7] media: videobuf2: Don't assert held reservation
 lock for dma-buf mmapping
Content-Language: en-US
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
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
Cc:     linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        kernel@collabora.com
References: <20230406160637.541702-1-dmitry.osipenko@collabora.com>
 <20230406160637.541702-2-dmitry.osipenko@collabora.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20230406160637.541702-2-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2023 18:06, Dmitry Osipenko wrote:
> Don't assert held dma-buf reservation lock on memory mapping of exported
> buffer.
> 
> We're going to change dma-buf mmap() locking policy such that exporters
> will have to handle the lock. The previous locking policy caused deadlock
> problem for DRM drivers in a case of self-imported dma-bufs once these
> drivers are moved to use reservation lock universally. The problem is
> solved by moving the lock down to exporters. This patch prepares videobuf2
> for the locking policy update.
> 
> Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Reviewed-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

Regards,

	Hans

> ---
>  drivers/media/common/videobuf2/videobuf2-dma-contig.c | 3 ---
>  drivers/media/common/videobuf2/videobuf2-dma-sg.c     | 3 ---
>  drivers/media/common/videobuf2/videobuf2-vmalloc.c    | 3 ---
>  3 files changed, 9 deletions(-)
> 
> diff --git a/drivers/media/common/videobuf2/videobuf2-dma-contig.c b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> index 205d3cac425c..2fa455d4a048 100644
> --- a/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> +++ b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> @@ -11,7 +11,6 @@
>   */
>  
>  #include <linux/dma-buf.h>
> -#include <linux/dma-resv.h>
>  #include <linux/module.h>
>  #include <linux/refcount.h>
>  #include <linux/scatterlist.h>
> @@ -456,8 +455,6 @@ static int vb2_dc_dmabuf_ops_vmap(struct dma_buf *dbuf, struct iosys_map *map)
>  static int vb2_dc_dmabuf_ops_mmap(struct dma_buf *dbuf,
>  	struct vm_area_struct *vma)
>  {
> -	dma_resv_assert_held(dbuf->resv);
> -
>  	return vb2_dc_mmap(dbuf->priv, vma);
>  }
>  
> diff --git a/drivers/media/common/videobuf2/videobuf2-dma-sg.c b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
> index 183037fb1273..28f3fdfe23a2 100644
> --- a/drivers/media/common/videobuf2/videobuf2-dma-sg.c
> +++ b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
> @@ -10,7 +10,6 @@
>   * the Free Software Foundation.
>   */
>  
> -#include <linux/dma-resv.h>
>  #include <linux/module.h>
>  #include <linux/mm.h>
>  #include <linux/refcount.h>
> @@ -498,8 +497,6 @@ static int vb2_dma_sg_dmabuf_ops_vmap(struct dma_buf *dbuf,
>  static int vb2_dma_sg_dmabuf_ops_mmap(struct dma_buf *dbuf,
>  	struct vm_area_struct *vma)
>  {
> -	dma_resv_assert_held(dbuf->resv);
> -
>  	return vb2_dma_sg_mmap(dbuf->priv, vma);
>  }
>  
> diff --git a/drivers/media/common/videobuf2/videobuf2-vmalloc.c b/drivers/media/common/videobuf2/videobuf2-vmalloc.c
> index a6c6d2fcaaa4..7c635e292106 100644
> --- a/drivers/media/common/videobuf2/videobuf2-vmalloc.c
> +++ b/drivers/media/common/videobuf2/videobuf2-vmalloc.c
> @@ -10,7 +10,6 @@
>   * the Free Software Foundation.
>   */
>  
> -#include <linux/dma-resv.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
>  #include <linux/mm.h>
> @@ -319,8 +318,6 @@ static int vb2_vmalloc_dmabuf_ops_vmap(struct dma_buf *dbuf,
>  static int vb2_vmalloc_dmabuf_ops_mmap(struct dma_buf *dbuf,
>  	struct vm_area_struct *vma)
>  {
> -	dma_resv_assert_held(dbuf->resv);
> -
>  	return vb2_vmalloc_mmap(dbuf->priv, vma);
>  }
>  

