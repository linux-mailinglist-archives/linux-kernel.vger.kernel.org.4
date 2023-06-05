Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F93F722CD9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 18:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbjFEQlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 12:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233042AbjFEQlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 12:41:50 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1BB94
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 09:41:48 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1a2ad8f4075so3561500fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 09:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685983308; x=1688575308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUsPK5qT+Od/SIBa5UUhtpAmbErx2EC2+EeGGcYa5rU=;
        b=J6mjvwgXki3I4xMigCdrzUJtNhQwAFBtz+p5o8skfFXfPZFfgCEimm/AmxMpQJ4P1J
         6k4+JhydIkYRZuLgFEVXH3fHJBF0eQgDuJGZFmaGeIiSG9nkxqrWEvZiBmWHt7nuwisW
         G8omI0M6sfveLCICXm/frZh0InwJRKvH0F4J+jozB1+ioi5bCD056Ddx3oFTA3sf0/iL
         EFj5fFczA6AIdJoqBgVUUWg5cgDInGFJ4uSzdaOXJZW1xrMhBN1739vGobQ/oRgsknBI
         PgSxh+kjnKiB/Kpzooy8QJp59MUa+rH6nQvW0Tk123hXjp7iTFtUbE8mtPxgfN/Ty0yv
         RFEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685983308; x=1688575308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sUsPK5qT+Od/SIBa5UUhtpAmbErx2EC2+EeGGcYa5rU=;
        b=csgB7lql9+YC3wPFSZnYd7ryah584oykQRULhp4YCM5g1Zfwhc4JlYdDPjJvnzYg8l
         BSPhcRXfSo/FS+8W7S9KG/krJW49A86kOoUWmgByBz8Vhxc1AxPHwUjWJxoVy9e2Dlw8
         KtMe2j9krlx9x1/ywlMgmTN2yzYxgwan33Oksul3uNTdliZvXuWqmh6rQB43HhnBPGvq
         pkrvGpitC8GuGQEsD64eAg/8A7jXiUE1g0QV74V+r/xoDQ4jCJVogb4SFS4ixq3pOXBl
         hxKJX0Xo30Mj3BK6bE+k33YksmWscUi65HvERH4eksL+Kyv9CYAkHaJzCz2ms69Jmw/3
         XcpA==
X-Gm-Message-State: AC+VfDz/dA40FbEON6i2ycpt7+P+y/iAndL/SSotZsUv1bu3YniNoZzy
        GYkXuUgcH1AhEyFcwpcIiMpM9foDWtqGjTuM09wBwEz8woY7/A==
X-Google-Smtp-Source: ACHHUZ4nWngzkypU3Cg/zTok12gK4tc1J01/ofn+M2gks5evrM0O8c9OmbgYZugTUsYq5SSkq3R/lfhedJOdFeeOlkU=
X-Received: by 2002:a05:6870:3651:b0:19f:e1ed:4cc7 with SMTP id
 v17-20020a056870365100b0019fe1ed4cc7mr245378oak.0.1685983307836; Mon, 05 Jun
 2023 09:41:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230605105834.702945-1-arnd@kernel.org>
In-Reply-To: <20230605105834.702945-1-arnd@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 5 Jun 2023 12:41:36 -0400
Message-ID: <CADnq5_P08Mf1Vzsr_fgWodKWrXZyYB26=zwP8VXzyNvgAX2AYQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: mark som eclear_address_watch() callback static
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Kim <jonathan.kim@amd.com>,
        Mukul Joshi <mukul.joshi@amd.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, Le Ma <le.ma@amd.com>,
        Ramesh Errabolu <Ramesh.Errabolu@amd.com>,
        dri-devel@lists.freedesktop.org, Yifan Zha <Yifan.Zha@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 5, 2023 at 6:58=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wrot=
e:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Some of the newly introduced clear_address_watch callback handlers have
> no prototype because they are only used in one file, which causes a W=3D1
> warning:
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c:164:10: error: no pr=
evious prototype for 'kgd_gfx_aldebaran_clear_address_watch' [-Werror=3Dmis=
sing-prototypes]
> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c:782:10: error: no prev=
ious prototype for 'kgd_gfx_v11_clear_address_watch' [-Werror=3Dmissing-pro=
totypes]
>
> Mark these ones static. If another user comes up in the future, that
> can be reverted along with adding the prototype.
>
> Fixes: cfd9715f741a1 ("drm/amdkfd: add debug set and clear address watch =
points operation")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks.  Srinivasan already sent out a fix for this.

Alex


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c b/drive=
rs/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> index efd6a72aab4eb..bdda8744398fe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> @@ -161,7 +161,7 @@ static uint32_t kgd_gfx_aldebaran_set_address_watch(
>         return watch_address_cntl;
>  }
>
> -uint32_t kgd_gfx_aldebaran_clear_address_watch(struct amdgpu_device *ade=
v,
> +static uint32_t kgd_gfx_aldebaran_clear_address_watch(struct amdgpu_devi=
ce *adev,
>                                         uint32_t watch_id)
>  {
>         return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
> index 52efa690a3c21..131859ce3e7e9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
> @@ -779,7 +779,7 @@ static uint32_t kgd_gfx_v11_set_address_watch(struct =
amdgpu_device *adev,
>         return watch_address_cntl;
>  }
>
> -uint32_t kgd_gfx_v11_clear_address_watch(struct amdgpu_device *adev,
> +static uint32_t kgd_gfx_v11_clear_address_watch(struct amdgpu_device *ad=
ev,
>                                         uint32_t watch_id)
>  {
>         return 0;
> --
> 2.39.2
>
