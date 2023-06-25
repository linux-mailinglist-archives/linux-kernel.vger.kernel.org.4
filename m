Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C03F73CDD6
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 03:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjFYBkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 21:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjFYBkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 21:40:01 -0400
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AE8A8;
        Sat, 24 Jun 2023 18:40:00 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VlqRN2W_1687657195;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VlqRN2W_1687657195)
          by smtp.aliyun-inc.com;
          Sun, 25 Jun 2023 09:39:56 +0800
Message-ID: <1687657188.5529833-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 08/26] virtio-mem: use array_size
Date:   Sun, 25 Jun 2023 09:39:48 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     keescook@chromium.org, kernel-janitors@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>
References: <20230623211457.102544-1-Julia.Lawall@inria.fr>
 <20230623211457.102544-9-Julia.Lawall@inria.fr>
In-Reply-To: <20230623211457.102544-9-Julia.Lawall@inria.fr>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2023 23:14:39 +0200, Julia Lawall <Julia.Lawall@inria.fr> wrote:
> Use array_size to protect against multiplication overflows.
>
> The changes were done using the following Coccinelle semantic patch:
>
> // <smpl>
> @@
>     expression E1, E2;
>     constant C1, C2;
>     identifier alloc = {vmalloc,vzalloc};
> @@
>
> (
>       alloc(C1 * C2,...)
> |
>       alloc(
> -           (E1) * (E2)
> +           array_size(E1, E2)
>       ,...)
> )
> // </smpl>
>
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

>
> ---
>  drivers/virtio/virtio_mem.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index 835f6cc2fb66..a4dfe7aab288 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -399,7 +399,7 @@ static int virtio_mem_bbm_bb_states_prepare_next_bb(struct virtio_mem *vm)
>  	if (vm->bbm.bb_states && old_pages == new_pages)
>  		return 0;
>
> -	new_array = vzalloc(new_pages * PAGE_SIZE);
> +	new_array = vzalloc(array_size(new_pages, PAGE_SIZE));
>  	if (!new_array)
>  		return -ENOMEM;
>
> @@ -465,7 +465,7 @@ static int virtio_mem_sbm_mb_states_prepare_next_mb(struct virtio_mem *vm)
>  	if (vm->sbm.mb_states && old_pages == new_pages)
>  		return 0;
>
> -	new_array = vzalloc(new_pages * PAGE_SIZE);
> +	new_array = vzalloc(array_size(new_pages, PAGE_SIZE));
>  	if (!new_array)
>  		return -ENOMEM;
>
> @@ -588,7 +588,7 @@ static int virtio_mem_sbm_sb_states_prepare_next_mb(struct virtio_mem *vm)
>  	if (vm->sbm.sb_states && old_pages == new_pages)
>  		return 0;
>
> -	new_bitmap = vzalloc(new_pages * PAGE_SIZE);
> +	new_bitmap = vzalloc(array_size(new_pages, PAGE_SIZE));
>  	if (!new_bitmap)
>  		return -ENOMEM;
>
>
