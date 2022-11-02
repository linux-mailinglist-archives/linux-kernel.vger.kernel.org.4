Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD3D615665
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 01:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiKBAFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 20:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiKBAFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 20:05:42 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603BFFAFD
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 17:05:41 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id n130so19229966yba.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 17:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LXVjpmcuceSLtVtq1KwkEZZvIzkOBdTR9+384qptIxA=;
        b=gY0XqIBcT72x+5mIHCPS8JMRAncFIGnhE9GY7Cn5NPnWk4IRHMt0JMqWu6DH90gzVc
         CHoUTiZPAQrnS/2fpZPWdo0998e+aHizZckzTlZvfGoKECQUr7hQYrT91Jrdwj8L9ytm
         DF7dq6zseQf0BPwvHgd/G9MfnW4J1KBOPwTjy0i+yOwLk3+QZGJdonLAVXhBGSZm6idB
         gtdVjKVZWDHQbbXp2bK3t9hmaiB4OGj8P4J6R1Vo1agDCf+oxQop9P6seYMRN/FP3Bc/
         /0jV5xUupHu/9i4wodfQv3Jf9DyvQ9qXM+Nhvawy+j0Q/7Vr17KQJ5qQrI1XnXInJe/B
         Pmmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LXVjpmcuceSLtVtq1KwkEZZvIzkOBdTR9+384qptIxA=;
        b=mLNjdvilVeBU+9aoFoX+Iiufgd1CcuyCcJY0uQK0Hpacjq1/1Jt/Tm1ORpRRZ0ycxq
         1qnSwOlHK3l75AuoyaD26FsKabxO7p7bhGCuVCQuGa90zgho1oAgu9ilbZCmFs+HxHqn
         l68VTpSBdXBkQ7kWiRMAnbGlOuujpvTQF+XO+DronCn2LWBXHraWEx0gtS8c7sishAgs
         oryUTV6ijCALd2t5fwhWlyjg6Ye+vj/Fl+k5+o4b8JcT4jV62nZyz/KHB/FJuaKM58OK
         mL9UgeV4M5kDb4r03GghOCOBdmsgCltnJFGZizAd5UC1aiGqLHxOleKOvSTcX6HZ9Eco
         ukQQ==
X-Gm-Message-State: ACrzQf0W6VwJQcnwyc74grSt7iIWFxRsHSLfm0OIqeVxoMvg1WicByFY
        Xvc1itf7LMejZUbnOW6BsDoVwkD9DGKQE0pJr1yvjg==
X-Google-Smtp-Source: AMsMyM7XHfcExfov1AZxC0aYOPIhc1Njm8sLYHakec7c8IDdtD3Rx445uxhfyVQggY9P/Cp7QQeM1XBRcgOs2Ij28ZA=
X-Received: by 2002:a05:6902:1cb:b0:6cf:e925:5baa with SMTP id
 u11-20020a05690201cb00b006cfe9255baamr256079ybh.636.1667347540410; Tue, 01
 Nov 2022 17:05:40 -0700 (PDT)
MIME-Version: 1.0
References: <TYCP286MB23235BB803E3A778C85B50F7CA379@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
In-Reply-To: <TYCP286MB23235BB803E3A778C85B50F7CA379@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Tue, 1 Nov 2022 17:05:28 -0700
Message-ID: <CABdmKX0iR-YAfR+rLczPDa5W9Y+JMYs5RKMK8bkjs3z80TgL6A@mail.gmail.com>
Subject: Re: [PATCH v2] dma-buf: fix racing conflict of dma_heap_add()
To:     Dawei Li <set_pte_at@outlook.com>
Cc:     sumit.semwal@linaro.org, christian.koenig@amd.com,
        benjamin.gaignard@collabora.com, labbott@redhat.com,
        Brian.Starkey@arm.com, jstultz@google.com, afd@ti.com,
        sspatil@android.com, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 7:53 AM Dawei Li <set_pte_at@outlook.com> wrote:
>
> Racing conflict could be:
> task A                 task B
> list_for_each_entry
> strcmp(h->name))
>                        list_for_each_entry
>                        strcmp(h->name)
> kzalloc                kzalloc
> ......                 .....
> device_create          device_create
> list_add
>                        list_add
>
> The root cause is that task B has no idea about the fact someone
> else(A) has inserted heap with same name when it calls list_add,
> so a potential collision occurs.
>
> v1: https://lore.kernel.org/all/TYCP286MB2323950197F60FC3473123B7CA349@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM/
>
> v1->v2: Narrow down locking scope, check the existence of heap before
> insertion, as suggested by Andrew Davis.
>
> Fixes: c02a81fba74f ("dma-buf: Add dma-buf heaps framework")
>
> base-commit: 447fb14bf07905b880c9ed1ea92c53d6dd0649d7
>
> Signed-off-by: Dawei Li <set_pte_at@outlook.com>
> ---
>  drivers/dma-buf/dma-heap.c | 37 ++++++++++++++++++++++++++++---------
>  1 file changed, 28 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> index 8f5848aa144f..1c787a147e3a 100644
> --- a/drivers/dma-buf/dma-heap.c
> +++ b/drivers/dma-buf/dma-heap.c
> @@ -216,9 +216,21 @@ const char *dma_heap_get_name(struct dma_heap *heap)
>         return heap->name;
>  }
>
> +static inline bool dma_heap_exist(const char *name)
> +{
> +       struct dma_heap *h;
> +
> +       list_for_each_entry(h, &heap_list, list) {
> +               if (!strcmp(h->name, name))
> +                       return true;
> +       }
> +
> +       return false;
> +}
> +
>  struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_info)
>  {
> -       struct dma_heap *heap, *h, *err_ret;
> +       struct dma_heap *heap, *err_ret;
>         struct device *dev_ret;
>         unsigned int minor;
>         int ret;
> @@ -235,13 +247,11 @@ struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_info)
>
>         /* check the name is unique */
>         mutex_lock(&heap_list_lock);
> -       list_for_each_entry(h, &heap_list, list) {
> -               if (!strcmp(h->name, exp_info->name)) {
> -                       mutex_unlock(&heap_list_lock);
> -                       pr_err("dma_heap: Already registered heap named %s\n",
> -                              exp_info->name);
> -                       return ERR_PTR(-EINVAL);
> -               }
> +       if (dma_heap_exist(exp_info->name)) {
> +               mutex_unlock(&heap_list_lock);
> +               pr_err("dma_heap: Already registered heap named %s\n",
> +                      exp_info->name);
> +               return ERR_PTR(-EINVAL);

Hi Dawei,
What Andrew was suggesting was that you entirely move the check from
here to the critical section down below, not duplicate the check. I
don't think we want to check this twice. We should be able to do this
by taking the heap_list_lock only once.

>         }
>         mutex_unlock(&heap_list_lock);
>
> @@ -283,13 +293,22 @@ struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_info)
>                 err_ret = ERR_CAST(dev_ret);
>                 goto err2;
>         }
> +
>         /* Add heap to the list */
>         mutex_lock(&heap_list_lock);
> +       if (unlikely(dma_heap_exist(exp_info->name))) {
> +               mutex_unlock(&heap_list_lock);
> +               pr_err("dma_heap: Already registered heap named %s\n",
> +                      exp_info->name);
> +               err_ret = ERR_PTR(-EINVAL);
> +               goto err3;
> +       }
>         list_add(&heap->list, &heap_list);
>         mutex_unlock(&heap_list_lock);
>
>         return heap;
> -
> +err3:
> +       device_destroy(dma_heap_class, heap->heap_devt);
>  err2:
>         cdev_del(&heap->heap_cdev);
>  err1:
> --
> 2.25.1
>
