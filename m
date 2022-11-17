Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6990762DEFC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240056AbiKQPFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239843AbiKQPFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:05:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31DB397
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 07:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668697455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3/pZzLYRJIJU5BHs9Uc1Vomcy9mjzdUIDjXX/Oi2kCE=;
        b=DObzXfYg2wNgX+LpPwhYTzrOyyz5KP15fUcJ+zIXKaQISWCSQs7wSdm2qgqSEpALDmU0/G
        rmLTpUcfar2KnB2juAShGN0ZA1SNN9tIy8Kfn39/DBAqG4mcA7NeRw19jZQ2fCE0n1UITW
        4T8oVb5BJ/4RK9NJQpKKk988M6L/FWk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-67-ZkQhiPemOoGdSj7u-PCuqg-1; Thu, 17 Nov 2022 10:04:13 -0500
X-MC-Unique: ZkQhiPemOoGdSj7u-PCuqg-1
Received: by mail-qk1-f198.google.com with SMTP id ay43-20020a05620a17ab00b006fa30ed61fdso2395851qkb.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 07:04:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3/pZzLYRJIJU5BHs9Uc1Vomcy9mjzdUIDjXX/Oi2kCE=;
        b=Tj5hInmw0cKE7pFTKOUz0HCQIQrLMDI4wKrUHm2etTJNBYtbuYxAa7NcatB0n4jpez
         KARhGFhVe/tpa73ON43+ocV+YLWluq0gs77p2hOQfRrIiaxmBu5sI+XRmAaBENNpVOD1
         RO7Rgx4rXepafb5T96V0oknJt8eKhy0UlErx5GXWCLXnC3LYiWI31Npv9ueLEQIH32eC
         pY731sREuncFMO4Ig4CY8VsOMbsYDXLc0q6BA7YRlbZflprc4XczrDqpf4x2OFeaW9bh
         rSMHUj/OeypEFT5DMOWhUYMwdyeZ8k+tfgqtAzko4Ww7Esp1t79AsxSiQpWTqlmYBlaJ
         LRsg==
X-Gm-Message-State: ANoB5pkxDLgWOf+Oq+ggFM5DfhH3YhBfUpxFW1g5uAkxzMvQFGZoSdzF
        golni3YDafhrWuyX6fClXpp/v1E+Dm0QU6YaUghSETYLcKKDg5jW2N6Aq9cclA7iTtdx03E+B9t
        x1M9vp+qzJpOEAA28bxij05ObgfTfqRz3KKIZkTqw
X-Received: by 2002:ac8:124a:0:b0:3a5:e9fc:aa81 with SMTP id g10-20020ac8124a000000b003a5e9fcaa81mr2479621qtj.538.1668697453046;
        Thu, 17 Nov 2022 07:04:13 -0800 (PST)
X-Google-Smtp-Source: AA0mqf78K7K9QQ/LEvml9I/mWSQVn+B0fyexIMzg8OX/iKi7kiwkPii8zpQjSqYYBFiNTGcK/7rWDOQ6MILAFdcpRCs=
X-Received: by 2002:ac8:124a:0:b0:3a5:e9fc:aa81 with SMTP id
 g10-20020ac8124a000000b003a5e9fcaa81mr2479601qtj.538.1668697452805; Thu, 17
 Nov 2022 07:04:12 -0800 (PST)
MIME-Version: 1.0
References: <20221117071557.165742-1-kamalesh.babulal@oracle.com>
In-Reply-To: <20221117071557.165742-1-kamalesh.babulal@oracle.com>
From:   Joel Savitz <jsavitz@redhat.com>
Date:   Thu, 17 Nov 2022 11:03:56 -0400
Message-ID: <CAL1p7m4MeYbccde1rPKuxcbtj6Tm+sa4Ro_REAMBmWszyWJ3_w@mail.gmail.com>
Subject: Re: [PATCH v2] cgroup/cpuset: Improve cpuset_css_alloc() description
To:     Kamalesh Babulal <kamalesh.babulal@oracle.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Waiman Long <longman@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tom Hromatka <tom.hromatka@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 3:18 AM Kamalesh Babulal
<kamalesh.babulal@oracle.com> wrote:
>
> Change the function argument in the description of cpuset_css_alloc()
> from 'struct cgroup' -> 'struct cgroup_subsys_state'.  The change to the
> argument type was introduced by commit eb95419b023a ("cgroup: pass
> around cgroup_subsys_state instead of cgroup in subsystem methods").
> Also, add more information to its description.
>
> Signed-off-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>
> ---
> v2: Reworded the description to be more accurate, as suggested
>     by Waiman Long
>
>  kernel/cgroup/cpuset.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index b474289c15b8..ce789e1b2a2f 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -3046,11 +3046,15 @@ static struct cftype dfl_files[] = {
>  };
>
>
> -/*
> - *     cpuset_css_alloc - allocate a cpuset css
> - *     cgrp:   control group that the new cpuset will be part of
> +/**
> + * cpuset_css_alloc - Allocate a cpuset css
> + * @parent_css: Parent css of the control group that the new cpuset will be
> + *              part of
> + * Return: cpuset css on success, -ENOMEM on failure.
> + *
> + * Allocate and initialize a new cpuset css, for non-NULL @parent_css, return
> + * top cpuset css otherwise.
>   */
> -
>  static struct cgroup_subsys_state *
>  cpuset_css_alloc(struct cgroup_subsys_state *parent_css)
>  {
> --
> 2.34.3
>

Acked-by: Joel Savitz <jsavitz@redhat.com>

