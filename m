Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98956690002
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 06:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjBIFsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 00:48:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBIFst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 00:48:49 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77535EC4D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 21:48:46 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id v18-20020a17090ae99200b00230f079dcd9so5070633pjy.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 21:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FV8ZmgsAYphE9Ak6qoa3ww8DrLbAPBbA8KqiMQ61iko=;
        b=ITPX0KdifT4t2zEMXoze7cwMyaLKjIS0ISyaM6hdc32rMfah2WKcoR+M1IUJnFh8jQ
         /Ya6JP/PPq8ZKM2KjfvNP2NX++mRtmOaUDSlmyPnDwWkEPBFv/H05Nz+kctLvkCOKmZL
         14JTYfWXOlJIutsIyFCZuuV83V4CCGFj6MdZNmk7xBXVUXuRkOEO6AJh7dNtLAa4PeRY
         WrAAUgOk/uugpZiUQIbn5bb801O6NOlx28/Ge91Hhjp6d2gv+GitGvTtMGe6Pssdsz6A
         Yi+tbKLWaCiz5F9Dl1VADtKsZmMyVh9RrtakG7QHxYMFZ2+qr7KLNq8TONQ9v80VBrw3
         lCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FV8ZmgsAYphE9Ak6qoa3ww8DrLbAPBbA8KqiMQ61iko=;
        b=i1eLcejoABt+Xq/HJsaaCojjbmgc4LJ05G+xZ3yOgAql2g9YNEYp4hbhWgCq+02vP4
         +4joKQRyUC1nnL0QtGqlIbcO1zWL2xe2CEZz7a9VNjCmlnJWRmbiq7hc1ngBssCF+ZDu
         oeLqrssJIM4VxxrijsxZSPT7g18MzU7uLXCr4zKTd7c4PlH5vh29veiwGJse52TJj0WT
         o316pf4Q7TOFr9r1yuH9MA5Vp1SUuBG1sMiEM+vzJiRcDuL6yYsOpzKIZfYLXaJ+oceE
         ttYmZ9AgyFrqa2at1jOS/70JLJheTMbsCZ2OpILAxpWzhtVI6SjpRo8JJENSbGLVVDwg
         qsxA==
X-Gm-Message-State: AO0yUKUcrFQa5yVoODDemEX7xV3b9SRZ2h1ODBfkfPAA/MMWmbJk2w5d
        N0xHwOIPecWcUsEoHEyF1UXVLldNjGA=
X-Google-Smtp-Source: AK7set9ArzHzgwCO9usoJrgu9l9c7cftrgfe9l//SPMiPYNxamZOXaXX6JZ5smV/nPopFeFSXUGj+w==
X-Received: by 2002:a17:903:32ce:b0:198:fca8:2108 with SMTP id i14-20020a17090332ce00b00198fca82108mr11041958plr.44.1675921725980;
        Wed, 08 Feb 2023 21:48:45 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id u3-20020a170902a60300b00198e1bc9d83sm441107plq.266.2023.02.08.21.48.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Feb 2023 21:48:45 -0800 (PST)
Date:   Thu, 9 Feb 2023 13:54:28 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Thomas =?GB18030?B?V2VpgTCJOHNjaHVo?= <linux@weissschuh.net>
Cc:     Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        huyue2@coolpad.com, zhangwen@coolpad.com
Subject: Re: [PATCH] erofs: make kobj_type structures constant
Message-ID: <20230209135428.00003233.zbestahu@gmail.com>
In-Reply-To: <20230209-kobj_type-erofs-v1-1-078c945e2c4b@weissschuh.net>
References: <20230209-kobj_type-erofs-v1-1-078c945e2c4b@weissschuh.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=GB18030
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Feb 2023 03:21:13 +0000
Thomas Weißschuh <linux@weissschuh.net> wrote:

> Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
> the driver core allows the usage of const struct kobj_type.
> 
> Take advantage of this to constify the structure definitions to prevent
> modification at runtime.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Reviewed-by: Yue Hu <huyue2@coolpad.com>

> ---
>  fs/erofs/sysfs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
> index fd476961f742..435e515c0792 100644
> --- a/fs/erofs/sysfs.c
> +++ b/fs/erofs/sysfs.c
> @@ -179,13 +179,13 @@ static const struct sysfs_ops erofs_attr_ops = {
>  	.store	= erofs_attr_store,
>  };
>  
> -static struct kobj_type erofs_sb_ktype = {
> +static const struct kobj_type erofs_sb_ktype = {
>  	.default_groups = erofs_groups,
>  	.sysfs_ops	= &erofs_attr_ops,
>  	.release	= erofs_sb_release,
>  };
>  
> -static struct kobj_type erofs_ktype = {
> +static const struct kobj_type erofs_ktype = {
>  	.sysfs_ops	= &erofs_attr_ops,
>  };
>  
> @@ -193,7 +193,7 @@ static struct kset erofs_root = {
>  	.kobj	= {.ktype = &erofs_ktype},
>  };
>  
> -static struct kobj_type erofs_feat_ktype = {
> +static const struct kobj_type erofs_feat_ktype = {
>  	.default_groups = erofs_feat_groups,
>  	.sysfs_ops	= &erofs_attr_ops,
>  };
> 
> ---
> base-commit: 0983f6bf2bfc0789b51ddf7315f644ff4da50acb
> change-id: 20230209-kobj_type-erofs-0f0f4c901045
> 
> Best regards,

