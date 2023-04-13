Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7716E6E083C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 09:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjDMHur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 03:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjDMHuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 03:50:46 -0400
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D739755
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 00:50:24 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Vg-WHcF_1681372217;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Vg-WHcF_1681372217)
          by smtp.aliyun-inc.com;
          Thu, 13 Apr 2023 15:50:18 +0800
Message-ID: <1681372206.941719-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] tools/virtio/ringtest: Replace obsolete memalign() with posix_memalign()
Date:   Thu, 13 Apr 2023 15:50:06 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     Deming Wang <wangdeming@inspur.com>
Cc:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>,
        Deming Wang <wangdeming@inspur.com>, <mst@redhat.com>,
        <jasowang@redhat.com>
References: <20230412072536.2029-1-wangdeming@inspur.com>
In-Reply-To: <20230412072536.2029-1-wangdeming@inspur.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Apr 2023 03:25:36 -0400, Deming Wang <wangdeming@inspur.com> wrote:
> memalign() is obsolete according to its manpage.
>
> Replace memalign() with posix_memalign() and remove malloc.h include
> that was there for memalign().
>
> As a pointer is passed into posix_memalign(), initialize *p to NULL
> to silence a warning about the function's return value being used as
> uninitialized (which is not valid anyway because the error is properly
> checked before p is returned).
>
> Signed-off-by: Deming Wang <wangdeming@inspur.com>

LGTM

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

> ---
>  tools/virtio/ringtest/ptr_ring.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/tools/virtio/ringtest/ptr_ring.c b/tools/virtio/ringtest/ptr_ring.c
> index c9b26335f891..a0bf4978eace 100644
> --- a/tools/virtio/ringtest/ptr_ring.c
> +++ b/tools/virtio/ringtest/ptr_ring.c
> @@ -26,9 +26,12 @@ typedef int gfp_t;
>
>  static void *kmalloc(unsigned size, gfp_t gfp)
>  {
> -	void *p = memalign(64, size);
> -	if (!p)
> -		return p;
> +	void *p;
> +	int ret;
> +
> +	ret = posix_memalign(&p, 64, size);
> +	if (ret < 0)
> +		return NULL;
>
>  	if (gfp & __GFP_ZERO)
>  		memset(p, 0, size);
> --
> 2.27.0
>
