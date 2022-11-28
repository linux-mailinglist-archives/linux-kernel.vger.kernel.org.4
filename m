Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C2763A11B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 07:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiK1GRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 01:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiK1GRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 01:17:11 -0500
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F2311174
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 22:17:09 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VVoRcX4_1669616225;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VVoRcX4_1669616225)
          by smtp.aliyun-inc.com;
          Mon, 28 Nov 2022 14:17:06 +0800
Message-ID: <1669616200.943005-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 2/2] tools/virtio: remove smp_read_barrier_depends()
Date:   Mon, 28 Nov 2022 14:16:40 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     dave@stgolabs.net, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com
References: <20221128034347.990-1-dave@stgolabs.net>
 <20221128034347.990-3-dave@stgolabs.net>
In-Reply-To: <20221128034347.990-3-dave@stgolabs.net>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Nov 2022 19:43:47 -0800, Davidlohr Bueso <dave@stgolabs.net> wrote:
> This gets rid of the last references to smp_read_barrier_depends()
>  which for the kernel side was removed in v5.9. The serialization
> required for Alpha is done inside READ_ONCE() instead of having
> users deal with it. Simply use a full barrier, the architecture
> does not have rmb in the first place.
>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

> ---
>  tools/virtio/ringtest/main.h | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/tools/virtio/ringtest/main.h b/tools/virtio/ringtest/main.h
> index 9ed09caa659e..b68920d52750 100644
> --- a/tools/virtio/ringtest/main.h
> +++ b/tools/virtio/ringtest/main.h
> @@ -140,12 +140,6 @@ static inline void busy_wait(void)
>  #define smp_wmb() smp_release()
>  #endif
>
> -#ifdef __alpha__
> -#define smp_read_barrier_depends() smp_acquire()
> -#else
> -#define smp_read_barrier_depends() do {} while(0)
> -#endif
> -
>  static __always_inline
>  void __read_once_size(const volatile void *p, void *res, int size)
>  {
> @@ -175,13 +169,22 @@ static __always_inline void __write_once_size(volatile void *p, void *res, int s
>  	}
>  }
>
> +#ifdef __alpha__
>  #define READ_ONCE(x) \
>  ({									\
>  	union { typeof(x) __val; char __c[1]; } __u;			\
>  	__read_once_size(&(x), __u.__c, sizeof(x));		\
> -	smp_read_barrier_depends(); /* Enforce dependency ordering from x */ \
> +	smp_mb(); /* Enforce dependency ordering from x */		\
>  	__u.__val;							\
>  })
> +#else
> +#define READ_ONCE(x)							\
> +({									\
> +	union { typeof(x) __val; char __c[1]; } __u;			\
> +	__read_once_size(&(x), __u.__c, sizeof(x));			\
> +	__u.__val;							\
> +})
> +#endif
>
>  #define WRITE_ONCE(x, val) \
>  ({							\
> --
> 2.38.1
>
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
