Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0B2692FCC
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 10:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjBKJlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 04:41:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBKJlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 04:41:04 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799453C29D;
        Sat, 11 Feb 2023 01:41:03 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id sa10so21319386ejc.9;
        Sat, 11 Feb 2023 01:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PKTTB4KrCAiL8SRqB2lSSGDnA1+HoHmmXJxC0p1EX7w=;
        b=n8shbWQqvG5ZrwU7/06sMCBiVo+lHWO2xDR2rSNdC5TUWcTDu8JVVL3+jAYNL0h2oF
         dHDftU1DzWK75WDjq1INxacyNDYK0Q/iDQdcP4uvGVWN3tW6ARxtvCql/MW+MsrA3NpY
         C6rBX/bGjAl4tvi0Bhri6EhDob/XEI3wooouNTEm/4+8N8fFj7QgNT05RKDZNbal34Go
         7T8JWXXlbikvuyCW2EN6iQi9cIsQYoOUfq4EgarUHco5jG0Eqfl2DmxfMVNLxgJmpt9n
         Gi5Ew4Z/2/tAosrbLjGItjvz3OIrHwmIoZcutnRcEg7K0OD8KT/E3fH/epyHsbcPOUTH
         W+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PKTTB4KrCAiL8SRqB2lSSGDnA1+HoHmmXJxC0p1EX7w=;
        b=Xjyv+4XtyO7GaJMEhB0zgTOxBqXsF4A11YJYpPZl4Ewm0yny8c4m8twgvmu6mIfwMK
         o0HcnkjADB6RknRZP1DVTq0xuQ13rjHFGfuz1rrlbC50CUyPiZZsb9Jgc94XCK/wAO4N
         R7OXKzLkZmjfG2HAfVfv6BlV2xsG6Gel4e+h+KVTnnE8MudBQgi+HNuLscQAi/CKtS/2
         pdMkaJh0U26zKbLFr3N2YJ70tTdD/ilLlk7UYKUy7x3bn76zWUgYbeNGjSxVkzgJWcm8
         E91KKVm0ixsufoek+7iqrbsvNIDWEAJe0JXLk6WC6wSvDKcHjGUIstqGUZVaGyz+pon2
         AU5w==
X-Gm-Message-State: AO0yUKX4pZPQ7mPQNclPfFVjUgzX7FCjV8PcxNXkn44SS9INYnzD+P36
        hi3tdtLboxRi0sZ2K0hY6qgtc345GPRzvGBfKTucEnHsiqs=
X-Google-Smtp-Source: AK7set86j/BnrX9H2DMZ1YIqefpYkzcgEtuGz0ePMJhYcApjmjxiU6GJLRZcJYPTlsHhKm/FMBWKAnGW8e0DQsc/CKU=
X-Received: by 2002:a17:907:20b3:b0:87b:d79f:9953 with SMTP id
 pw19-20020a17090720b300b0087bd79f9953mr2041563ejb.11.1676108461930; Sat, 11
 Feb 2023 01:41:01 -0800 (PST)
MIME-Version: 1.0
References: <06f51bab-42e1-975a-ad4f-6815c2063adb@redhat.com> <20230209120923.331111-1-n.petrova@fintech.ru>
In-Reply-To: <20230209120923.331111-1-n.petrova@fintech.ru>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Sat, 11 Feb 2023 10:40:50 +0100
Message-ID: <CAOi1vP9Wuzsx81O+yu_w5P-W=GHdXNv-LfL1dD6O0NxkdedCMw@mail.gmail.com>
Subject: Re: [PATCH v2] rbd: fix freeing memory of 'rbd_dev->opts',
 'rbd_dev->spec', 'rbd_dev->rbd_client'
To:     Natalia Petrova <n.petrova@fintech.ru>
Cc:     Dongsheng Yang <dongsheng.yang@easystack.cn>,
        Jens Axboe <axboe@kernel.dk>, ceph-devel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 9, 2023 at 1:09 PM Natalia Petrova <n.petrova@fintech.ru> wrote:
>
> If the rbd_dev_create() fails after assignment 'opts' to 'rbd_dev->opts',
> double free of 'rbd_options' happens:
> one is in rbd_dev_free() and another one is in do_rbd_add().
>
> If the rbd_dev_create() fails, for 'spec' it will be freed in
> rbd_dev_create()->rbd_spec_put() first and then in do_rbd_add()
> it will call rbd_spec_put() again. The same for 'rbd_client'.
> Unlike 'rbd_dev->opts', 'rbd_dev->spec' and 'rbd_dev->rbd_client'
> are ref-counted, that's why the ref-count underflow warning
> should be generated in rbd_spec_put() and rbd_put_client()
> to handle the return values of kref_put().

Hi Natalia,

I think you misinterpreted Xiubo.  The underflow warning would be
printed by kref_put() (if one is lucky and the freed memory doesn't get
immediately reallocated and overwritten in which case straight memory
corruption would occur).  There is no need to attempt to print another
warning here.

The problem is potential use-after-free on struct rbd_spec and struct
rbd_client (which is what the warning is for).  This use-after-free is
very similar in nature to what the tool that you are using found for
struct rbd_options (the same bug on the same error path) except that
reference counting is involved: instead of kfree() being called
directly, it's called indirectly from rbd_spec_free() and
rbd_client_release() through rbd_spec_put() and rbd_put_client()
respectively.  Both of these structs have a refcount of 1 here which
means that the first rbd_spec_free() or rbd_client_release() call is
equivalent to kfree() and, when either of them is called again from
do_rbd_add(), use-after-free would occur.

Hope this helps,

                Ilya

>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: 1643dfa4c2c8 ("rbd: introduce a per-device ordered workqueue")
> Signed-off-by: Natalia Petrova <n.petrova@fintech.ru>
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
> ---
> v2: Remarks on the processing of 'rbd_dev->spec' and 'rbd_dev->rbd_client'
> by Ilya Dryomov <idryomov@gmail.com> and Xiubo Li <xiubli@redhat.com>
> were taken into account.
>  drivers/block/rbd.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 04453f4a319c..f3f253febe0f 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -889,8 +889,10 @@ static void rbd_client_release(struct kref *kref)
>   */
>  static void rbd_put_client(struct rbd_client *rbdc)
>  {
> -       if (rbdc)
> -               kref_put(&rbdc->kref, rbd_client_release);
> +       if (rbdc) {
> +               if (!kref_put(&rbdc->kref, rbd_client_release))
> +                       pr_warn("The reference count underflow\n");
> +       }
>  }
>
>  /*
> @@ -5225,8 +5227,10 @@ static struct rbd_spec *rbd_spec_get(struct rbd_spec *spec)
>  static void rbd_spec_free(struct kref *kref);
>  static void rbd_spec_put(struct rbd_spec *spec)
>  {
> -       if (spec)
> -               kref_put(&spec->kref, rbd_spec_free);
> +       if (spec) {
> +               if (!kref_put(&spec->kref, rbd_spec_free))
> +                       pr_warn("The reference count underflow\n");
> +       }
>  }
>
>  static struct rbd_spec *rbd_spec_alloc(void)
> @@ -5357,7 +5361,6 @@ static struct rbd_device *rbd_dev_create(struct rbd_client *rbdc,
>         if (!rbd_dev)
>                 return NULL;
>
> -       rbd_dev->opts = opts;
>
>         /* get an id and fill in device name */
>         rbd_dev->dev_id = ida_simple_get(&rbd_dev_id_ida, 0,
> @@ -5372,6 +5375,7 @@ static struct rbd_device *rbd_dev_create(struct rbd_client *rbdc,
>         if (!rbd_dev->task_wq)
>                 goto fail_dev_id;
>
> +       rbd_dev->opts = opts;
>         /* we have a ref from do_rbd_add() */
>         __module_get(THIS_MODULE);
>
> --
> 2.34.1
>
