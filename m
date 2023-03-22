Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640A16C522B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjCVRSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjCVRSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:18:05 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D4F66D15
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:17:35 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so19854645pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1679505444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UittgdXM3g+Qbt7hZmz9fDwi45VTM0z8aAr7Vg+o+os=;
        b=CQ2n4+5TduAQlvRuSopwcvMBwx1aMvm0NwYexjQsp/nXY2wMaefj0B1ffmN8DwAkv2
         IKNoqVGc8o5V77z7pxmAKfmYrJk3fkC+m/B6vR+qyAkOjXZRI91G2B2UQ/ohroF2PhVD
         HP64OD7bXnzRISmJ9dvNmQj/AjwSSW3Pqvi9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679505444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UittgdXM3g+Qbt7hZmz9fDwi45VTM0z8aAr7Vg+o+os=;
        b=6M9/KVZlyHJC0S8xN5HT+v1dwVLNnOFkr8aN4CroaqBn9nC3Sw4MIZ8g8TRdIPXOzG
         YEj0M+qsGemc6Is074oIk7s9mDM4EGcx5EZgXNObwVY+XT5Wfkl7zQUo7fh4IpgxTfLE
         C0+VO/hH4p+4llahCWMK+JFgcRpfEAQCSEk0yvn3HE6bL/Kx52OnnXkkWc0+4YX7RSXB
         nEeLQl/kvzC3yrVBVdT5b4HYCp2AcmtN45vpoXx+yX7oYIAHjZu7mqjHo5FlYyrnt9MS
         /9+YvR9zJynoNN90Dmc0vL9cojYy9WSVCMsBIR6+9Uvetfo6hj41NQnLwon+lArUJDUy
         DKDA==
X-Gm-Message-State: AO0yUKUhJyDn/p1Bk0FpYYfIiNsbgUrSU4LoBuMnuyaAfCmKKW+6w9t4
        bidC1kgONZWEqX/D/Q89s8dMerYdBpWmPzjfPXiHKQ==
X-Google-Smtp-Source: AK7set/gRfEg9ZkMBG8RvdC24JfXTCE8uD3xzdGBfjruc84EYtVudASDkkG+lq/J5/fnXnQhZxyJt4P4RbTPQS/9SeY=
X-Received: by 2002:a17:902:6a84:b0:19f:2aa4:b1e5 with SMTP id
 n4-20020a1709026a8400b0019f2aa4b1e5mr1495889plk.2.1679505443863; Wed, 22 Mar
 2023 10:17:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230322102006.780624-1-liushixin2@huawei.com> <20230322102006.780624-3-liushixin2@huawei.com>
In-Reply-To: <20230322102006.780624-3-liushixin2@huawei.com>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Wed, 22 Mar 2023 18:17:12 +0100
Message-ID: <CAM4kBBJT1xSGe7KthBvBLstZ43cPP-PDKE7a-6hC5Fn6TneL0g@mail.gmail.com>
Subject: Re: [PATCH -next v6 2/2] mm/zswap: delay the initializaton of zswap
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 10:30=E2=80=AFAM Liu Shixin <liushixin2@huawei.com>=
 wrote:
>
> Since some users may not use zswap, the zswap_pool is wasted. Save memory
> by delaying the initialization of zswap until enabled.

To be honest, I'm not a huge fan of this. Would enabling zswap module
build instead solve your problem?

~Vitaly

> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>  mm/zswap.c | 51 +++++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 41 insertions(+), 10 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 09fa956920fa..3aed3b26524a 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -81,6 +81,8 @@ static bool zswap_pool_reached_full;
>
>  #define ZSWAP_PARAM_UNSET ""
>
> +static int zswap_setup(void);
> +
>  /* Enable/disable zswap */
>  static bool zswap_enabled =3D IS_ENABLED(CONFIG_ZSWAP_DEFAULT_ON);
>  static int zswap_enabled_param_set(const char *,
> @@ -220,6 +222,9 @@ static bool zswap_init_started;
>  /* fatal error during init */
>  static bool zswap_init_failed;
>
> +/* used to ensure the integrity of initialization */
> +static DEFINE_MUTEX(zswap_init_lock);
> +
>  /* init completed, but couldn't create the initial pool */
>  static bool zswap_has_pool;
>
> @@ -272,13 +277,13 @@ static void zswap_update_total_size(void)
>  **********************************/
>  static struct kmem_cache *zswap_entry_cache;
>
> -static int __init zswap_entry_cache_create(void)
> +static int zswap_entry_cache_create(void)
>  {
>         zswap_entry_cache =3D KMEM_CACHE(zswap_entry, 0);
>         return zswap_entry_cache =3D=3D NULL;
>  }
>
> -static void __init zswap_entry_cache_destroy(void)
> +static void zswap_entry_cache_destroy(void)
>  {
>         kmem_cache_destroy(zswap_entry_cache);
>  }
> @@ -663,7 +668,7 @@ static struct zswap_pool *zswap_pool_create(char *typ=
e, char *compressor)
>         return NULL;
>  }
>
> -static __init struct zswap_pool *__zswap_pool_create_fallback(void)
> +static struct zswap_pool *__zswap_pool_create_fallback(void)
>  {
>         bool has_comp, has_zpool;
>
> @@ -784,8 +789,15 @@ static int __zswap_param_set(const char *val, const =
struct kernel_param *kp,
>         /* if this is load-time (pre-init) param setting,
>          * don't create a pool; that's done during init.
>          */
> -       if (!zswap_init_started)
> -               return param_set_charp(s, kp);
> +       if (!zswap_init_started) {
> +               mutex_lock(&zswap_init_lock);
> +               if (!zswap_init_started) {
> +                       ret =3D param_set_charp(s, kp);
> +                       mutex_unlock(&zswap_init_lock);
> +                       return ret;
> +               }
> +               mutex_unlock(&zswap_init_lock);
> +       }
>
>         if (!type) {
>                 if (!zpool_has_pool(s)) {
> @@ -884,6 +896,15 @@ static int zswap_enabled_param_set(const char *val,
>         if (res =3D=3D *(bool *)kp->arg)
>                 return 0;
>
> +       if (!zswap_init_started && (system_state =3D=3D SYSTEM_RUNNING)) =
{
> +               mutex_lock(&zswap_init_lock);
> +               if (zswap_setup()) {
> +                       mutex_unlock(&zswap_init_lock);
> +                       return -ENODEV;
> +               }
> +               mutex_unlock(&zswap_init_lock);
> +       }
> +
>         if (zswap_init_failed) {
>                 pr_err("can't enable, initialization failed\n");
>                 return -ENODEV;
> @@ -1451,7 +1472,7 @@ static const struct frontswap_ops zswap_frontswap_o=
ps =3D {
>
>  static struct dentry *zswap_debugfs_root;
>
> -static int __init zswap_debugfs_init(void)
> +static int zswap_debugfs_init(void)
>  {
>         if (!debugfs_initialized())
>                 return -ENODEV;
> @@ -1482,7 +1503,7 @@ static int __init zswap_debugfs_init(void)
>         return 0;
>  }
>  #else
> -static int __init zswap_debugfs_init(void)
> +static int zswap_debugfs_init(void)
>  {
>         return 0;
>  }
> @@ -1491,12 +1512,13 @@ static int __init zswap_debugfs_init(void)
>  /*********************************
>  * module init and exit
>  **********************************/
> -static int __init init_zswap(void)
> +static int zswap_setup(void)
>  {
>         struct zswap_pool *pool;
>         int ret;
>
> -       zswap_init_started =3D true;
> +       if (zswap_init_started)
> +               return 0;
>
>         if (zswap_entry_cache_create()) {
>                 pr_err("entry cache creation failed\n");
> @@ -1537,6 +1559,7 @@ static int __init init_zswap(void)
>                 goto destroy_wq;
>         if (zswap_debugfs_init())
>                 pr_warn("debugfs initialization failed\n");
> +       zswap_init_started =3D true;
>         return 0;
>
>  destroy_wq:
> @@ -1551,11 +1574,19 @@ static int __init init_zswap(void)
>  cache_fail:
>         /* if built-in, we aren't unloaded on failure; don't allow use */
>         zswap_init_failed =3D true;
> +       zswap_init_started =3D true;
>         zswap_enabled =3D false;
>         return -ENOMEM;
>  }
> +
> +static int __init zswap_init(void)
> +{
> +       if (!zswap_enabled)
> +               return 0;
> +       return zswap_setup();
> +}
>  /* must be late so crypto has time to come up */
> -late_initcall(init_zswap);
> +late_initcall(zswap_init);
>
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Seth Jennings <sjennings@variantweb.net>");
> --
> 2.25.1
>
