Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFFA6169C8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiKBQyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiKBQyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:54:16 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D8D63D3
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 09:54:15 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 66so5098598ybl.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 09:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f+jsYWzMq4ayln83LACSuCFQylp+aW9xpS8cdpbBSi0=;
        b=Z8JN/8nhG9eptQBEBpxwlVClP98EOTk8ztgCuPfjxHeDBQnhqELjWrIdPZ5K2mtIqd
         j4RMTLr15plCqweSdq3fqcfitKfeaKFfNhkYgoDwGRKj97tnv4ibaMA2+k1Ycj5QBJiW
         5h1nEu3c8rfB2xEf85WSK0RF12SBH21ItlZRiVDTcx0x+zn2Ry2xCi92Iay5Iv8LIEPN
         W1gffIV4OGrovFyqOUMrm/plPRlGVZwT4SsKup6d6QYOH2oUTcISDTep3wNjUzWgen/N
         8h9/xvXqCq3RsGTjfVtibEdwMi13cvCy2itdvFm61wFuyhFeCEe+8/CoaXkeg/ljZ7s4
         FUPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f+jsYWzMq4ayln83LACSuCFQylp+aW9xpS8cdpbBSi0=;
        b=V0En342PwaJblWBJ/6Rn/Jll3eWtZCnCe81nEpIiQa6Sa8uZlZ7uaB5qH2aBgF+LJq
         kJk9j04P8Rdy51ZUExve+fPeb1JGwuo9gfe0QrSuChd1NHl+7XlDGs0hbWOhA46Q3yJ2
         qGmz3DLX60QdVDrjkpn428+gQ8A0DQQxuSKRC7pUEcLfYBXRfPNSzyXN67GMkRyKGPgT
         vbGjMSpQV935/lPdZEQQGRDfnxsiVhxEo1g9E6STLPG5R1oJ0ticgMMzVoMJm9mmjgY9
         aLw0mVbC/nk+K7VnSrVZvQseRygP6/0q7t62pTh0RggDz7e9cdZtEp/g/c2qloZWJRCi
         JN+g==
X-Gm-Message-State: ACrzQf0akoDScAYVlgE02TPGgRiSp1JmaxRH1AU49n377GaDt8xFxLqZ
        MICy1M9fP6bjNw4xgvhVSlfRGvB08nbVNgEcoJ0ESA==
X-Google-Smtp-Source: AMsMyM65O4NBPUuaOBAgi95AvY9AqyXj3pXE7q8JILaTPjQvUhUaYGNVBiND+5QefC7PS0k2HKzI7xpKHUBwrDMr1pw=
X-Received: by 2002:a25:cd01:0:b0:6c2:6f0d:f4ce with SMTP id
 d1-20020a25cd01000000b006c26f0df4cemr22429548ybf.365.1667408054985; Wed, 02
 Nov 2022 09:54:14 -0700 (PDT)
MIME-Version: 1.0
References: <TYCP286MB2323D71DEC1D008BEA6F7ABBCA399@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
In-Reply-To: <TYCP286MB2323D71DEC1D008BEA6F7ABBCA399@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Wed, 2 Nov 2022 09:54:03 -0700
Message-ID: <CABdmKX3bE5eKOeonTnkLZUgg=1yx3h5QPkGgue-bATHVDChHLQ@mail.gmail.com>
Subject: Re: [PATCH v3] dma-buf: fix racing conflict of dma_heap_add()
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

On Wed, Nov 2, 2022 at 8:59 AM Dawei Li <set_pte_at@outlook.com> wrote:
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
> v2->v3: Remove double checking.
>
> Fixes: c02a81fba74f ("dma-buf: Add dma-buf heaps framework")
>
> base-commit: 447fb14bf07905b880c9ed1ea92c53d6dd0649d7
>
> Signed-off-by: Dawei Li <set_pte_at@outlook.com>
> ---
>  drivers/dma-buf/dma-heap.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> index 8f5848aa144f..7a25e98259ea 100644
> --- a/drivers/dma-buf/dma-heap.c
> +++ b/drivers/dma-buf/dma-heap.c
> @@ -233,18 +233,6 @@ struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_info)
>                 return ERR_PTR(-EINVAL);
>         }
>
> -       /* check the name is unique */
> -       mutex_lock(&heap_list_lock);
> -       list_for_each_entry(h, &heap_list, list) {
> -               if (!strcmp(h->name, exp_info->name)) {
> -                       mutex_unlock(&heap_list_lock);
> -                       pr_err("dma_heap: Already registered heap named %s\n",
> -                              exp_info->name);
> -                       return ERR_PTR(-EINVAL);
> -               }
> -       }
> -       mutex_unlock(&heap_list_lock);
> -
>         heap = kzalloc(sizeof(*heap), GFP_KERNEL);
>         if (!heap)
>                 return ERR_PTR(-ENOMEM);
> @@ -283,13 +271,26 @@ struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_info)
>                 err_ret = ERR_CAST(dev_ret);
>                 goto err2;
>         }
> -       /* Add heap to the list */
> +
>         mutex_lock(&heap_list_lock);
> +       /* check the name is unique */
> +       list_for_each_entry(h, &heap_list, list) {
> +               if (!strcmp(h->name, exp_info->name)) {
> +                       mutex_unlock(&heap_list_lock);
> +                       pr_err("dma_heap: Already registered heap named %s\n",
> +                              exp_info->name);
> +                       err_ret = ERR_PTR(-EINVAL);
> +                       goto err3;
> +               }
> +       }
> +
> +       /* Add heap to the list */
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

Reviewed-by: T.J. Mercier <tjmercier@google.com>

Thanks!
