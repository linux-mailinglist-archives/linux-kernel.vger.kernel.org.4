Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9680E6BAA6F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 09:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjCOII0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 04:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjCOIIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 04:08:24 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B97D1B336
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 01:08:22 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id o12so1493531iow.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 01:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678867702;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LT6Ia3vKrU2zpUQTyPaL1FAau/PMFoHjbq3HdkvqDrE=;
        b=K0QKzfSsUasx51OPzdvhrTCXOOSEw8cM0ekR2+W9mJXPhKFEjFD77h1gulBGNguYpI
         l0mnOSUakFgLepYHwLyIMPNFZrG4EDnTp1GrEhvOlbQrRlDZZP6upWC5FodYfhC3S7HO
         QGrGozZea6ofdvV/OA4RSZLwJs8XhXDNg0avOtkb3W17mCJwCn2bZbu7YgvIs8xK1GWg
         zhaK1BJbhD3eMQrPAmX+euybgH8fEnv+uU4H/amXXUYbAeOJfq5byfVyGpyKYscy4ItW
         2HVepeWSWq/HcZ4WSpRCQAjm1iMmaxGYmqfRYROLO2RS8ol8vyRlO6g6f0246foykH8a
         xAsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678867702;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LT6Ia3vKrU2zpUQTyPaL1FAau/PMFoHjbq3HdkvqDrE=;
        b=tjMybIGG8jQZd5+2Qa36ptwgTlalENHxkotsY26XKjwoNznsQZq9LaKzKhnMIXvi/Z
         vGrRPbvsN05egxHssBgejxUHrpkKUYtS32wHS6NIWjVsGvUF0PzjEgR/VEYwU5SWRAqA
         lKC5rfBXUSm4bQ9Vfo0UVUgBPLReZuk2zmc8sGH7DK5QJTpLeA+nn2JTs9dcLzAbsuw8
         aaC40QUantWgOMbVtWn2tZ9+Hmih/KgOwavqpupnta5xTaxrPkBeQKDYeE0aZEGWQbu/
         TWsqg+WaED9E1v0CaKxmtLg6liYBuP8gMSu8dm17RXeb53gqIkObqs3uWSyVJ4EJ+bQv
         qB9Q==
X-Gm-Message-State: AO0yUKV++JT4OFP4jY9RnLedgnSwhDLvLfdIq+SsT2gqQk8iER+rcYdt
        L2jE8KzYYRpPY4rhpxay9yJUZ8PVrd41Mif6hwR0jg==
X-Google-Smtp-Source: AK7set+2ERjNr/4s9bDE/AXPsf/E/3VBNBKN1x3c8nrK5xEHr+GHeuWZM0XnWyyGwX6AO5laeBNcEtuNMc2+AMs/d6s=
X-Received: by 2002:a6b:fc05:0:b0:744:d7fc:7a4f with SMTP id
 r5-20020a6bfc05000000b00744d7fc7a4fmr18528284ioh.1.1678867701817; Wed, 15 Mar
 2023 01:08:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230315034441.44321-1-songmuchun@bytedance.com>
In-Reply-To: <20230315034441.44321-1-songmuchun@bytedance.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 15 Mar 2023 09:07:40 +0100
Message-ID: <CANpmjNMxDT+AHBZra9ryhm6aw+WqBsdJ_SKdcdZr6CBsh97LyQ@mail.gmail.com>
Subject: Re: [PATCH] mm: kfence: fix using kfence_metadata without
 initialization in show_object()
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     glider@google.com, dvyukov@google.com, akpm@linux-foundation.org,
        jannh@google.com, sjpark@amazon.de, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        muchun.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Mar 2023 at 04:45, Muchun Song <songmuchun@bytedance.com> wrote:
>
> The variable kfence_metadata is initialized in kfence_init_pool(), then, it is
> not initialized if kfence is disabled after booting. In this case, kfence_metadata
> will be used (e.g. ->lock and ->state fields) without initialization when reading
> /sys/kernel/debug/kfence/objects. There will be a warning if you enable
> CONFIG_DEBUG_SPINLOCK. Fix it by creating debugfs files when necessary.
>
> Fixes: 0ce20dd84089 ("mm: add Kernel Electric-Fence infrastructure")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Tested-by: Marco Elver <elver@google.com>
Reviewed-by: Marco Elver <elver@google.com>

Good catch!

> ---
>  mm/kfence/core.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index 5349c37a5dac..79c94ee55f97 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -726,10 +726,14 @@ static const struct seq_operations objects_sops = {
>  };
>  DEFINE_SEQ_ATTRIBUTE(objects);
>
> -static int __init kfence_debugfs_init(void)
> +static int kfence_debugfs_init(void)
>  {
> -       struct dentry *kfence_dir = debugfs_create_dir("kfence", NULL);
> +       struct dentry *kfence_dir;
>
> +       if (!READ_ONCE(kfence_enabled))
> +               return 0;
> +
> +       kfence_dir = debugfs_create_dir("kfence", NULL);
>         debugfs_create_file("stats", 0444, kfence_dir, NULL, &stats_fops);
>         debugfs_create_file("objects", 0400, kfence_dir, NULL, &objects_fops);
>         return 0;
> @@ -883,6 +887,8 @@ static int kfence_init_late(void)
>         }
>
>         kfence_init_enable();
> +       kfence_debugfs_init();
> +
>         return 0;
>  }
>
> --
> 2.11.0
>
