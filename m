Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1975D67146B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 07:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjARGkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 01:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjARG0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 01:26:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEFD37567
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 22:16:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2BD99B81AA4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:16:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF42C433F0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674022599;
        bh=UwDrflLC3FnHhtmPCYNvGd2FW7baUtXIew3FXdZo+uU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iJp7IVhBXD7Qd6VSgAlxZqPEnCsJ6kuEnfgtNG02mGXXEGMXAJGvTHmRyAZ3n41RQ
         JUaQUP2ZN9YtyY2xS2t+op3XAn0m6YJ3mds4Q9auIZW/22rpIiT8oU/nei2aEucRHS
         1n2fnbiB9U+wVH0VIMWkLvf4cBBWsPQoh+CZP9QsoHro7bU3j5H8v7gB9vEFfsaODC
         auSyaG11puHdeLC13YTzWgVZGgQ+6JOTe7TClGp8MU6BVgEzW9Rlmt3iFCJniYjBPX
         rv/hitGxQdO7neLaJt0uVMvzHj1uRjZSz4Aj5HET0vvrz9ktceCagyNV3Fxi8Hc3UK
         iL1fZJs1xedrQ==
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-4bf16baa865so453801357b3.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 22:16:39 -0800 (PST)
X-Gm-Message-State: AFqh2koMtQ7wXv0mjdIwxigRjuhYsugKlKWyV3CBK+k4I56JAZFdgUnN
        4bCg1F8EQxfv6Ijl4VT19zPw/XprH+dkfonnWPM=
X-Google-Smtp-Source: AMrXdXsprXsdmmOoyhcSQ4I5F8JvAF5EchcdIAoScHpU8NW4WM1OYrCyTzCVz3DYpKI6+11iWSXbcKxQcLncdwBI1Ng=
X-Received: by 2002:a81:558e:0:b0:46c:3be1:f0c8 with SMTP id
 j136-20020a81558e000000b0046c3be1f0c8mr963100ywb.135.1674022598887; Tue, 17
 Jan 2023 22:16:38 -0800 (PST)
MIME-Version: 1.0
References: <1673977558-7648-1-git-send-email-quic_jhugo@quicinc.com>
In-Reply-To: <1673977558-7648-1-git-send-email-quic_jhugo@quicinc.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Wed, 18 Jan 2023 08:16:12 +0200
X-Gmail-Original-Message-ID: <CAFCwf10mAFEJNkZCNBuzz1_dAOP2fgEXU2M2okkq77PTa0MWoQ@mail.gmail.com>
Message-ID: <CAFCwf10mAFEJNkZCNBuzz1_dAOP2fgEXU2M2okkq77PTa0MWoQ@mail.gmail.com>
Subject: Re: [PATCH] accel: Add .mmap to DRM_ACCEL_FOPS
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc:     jacek.lawrynowicz@linux.intel.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 7:48 PM Jeffrey Hugo <quic_jhugo@quicinc.com> wrote:
>
> In reviewing the ivpu driver, DEFINE_DRM_ACCEL_FOPS could have been used
> if DRM_ACCEL_FOPS defined .mmap to be drm_gem_mmap.  Lets add that since
> accel drivers are a variant of drm drivers, modern drm drivers are
> expected to use GEM, and mmap() is a common operation that is expected
> to be heavily used in accel drivers thus the common accel driver should
> be able to just use DEFINE_DRM_ACCEL_FOPS() for convenience.
>
> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> ---
>  include/drm/drm_accel.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/drm/drm_accel.h b/include/drm/drm_accel.h
> index 65c0affb..d495506 100644
> --- a/include/drm/drm_accel.h
> +++ b/include/drm/drm_accel.h
> @@ -27,7 +27,8 @@
>         .compat_ioctl   = drm_compat_ioctl,\
>         .poll           = drm_poll,\
>         .read           = drm_read,\
> -       .llseek         = noop_llseek
> +       .llseek         = noop_llseek, \
> +       .mmap           = drm_gem_mmap
>
>  /**
>   * DEFINE_DRM_ACCEL_FOPS() - macro to generate file operations for accelerators drivers
> --
> 2.7.4
>

Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
I'll merge it through my tree.
Thanks,
Oded
