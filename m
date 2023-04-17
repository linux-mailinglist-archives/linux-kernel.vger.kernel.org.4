Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E814F6E4E45
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 18:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjDQQ0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 12:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjDQQ0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 12:26:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC41C4ECE
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 09:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681748732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xTTtRzBVTjjwCLzyfJV4ohTaunXWOeVeAb2RjGQ5vZ8=;
        b=gW1lfeOJYshbxFj0ArHC728OX3BXQemBoXmU9DR3insObejwiVonjSE2xu/CYwpIlYpjEX
        U4gV8LwCVLP6GVKzgCqyFvvKpbiOf9UkFN5P/yk9rTZltLsolduaMORy6pLvNESMwLWvl9
        HYp6vS/1UR/HPJ+iFgHfFImm541TMy4=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-0KrpzXowPgK6T4SoglSG0Q-1; Mon, 17 Apr 2023 12:25:30 -0400
X-MC-Unique: 0KrpzXowPgK6T4SoglSG0Q-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2a8bba7dd2cso4950451fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 09:25:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681748725; x=1684340725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xTTtRzBVTjjwCLzyfJV4ohTaunXWOeVeAb2RjGQ5vZ8=;
        b=iSmsolYiCt31cqBfeZM1guoZ556ccPUCM/1lFdi1O+C8NJJB34xPyH5IXlIXUIz30H
         WF8xVO5PJzZEqi5KjIZluM3hwJ5y4/NR05Ht/iGY9wUh4qsLBVvfzHeMdXcpH/qvYTSt
         6bel/9Ev7FIMqPUcfM7uDgyBINxqfzpMdcpm1hK+01LtzJjQCGE5KvdqqnEA90jbdmHt
         qTE/WxBlWJSSmHWqKeqPkDGwhG0GUhp/dF7/hmURrmirKjCCqKGIZ8j78jrvZO++zRvd
         7PRpzWOpaHl3ak35Rkfa9VQPOreEitUVESYBHzgj5Bra3D8/ihX94UdhhlNdJnGNq2vN
         LWIA==
X-Gm-Message-State: AAQBX9cO2Eg9Tqucse1NIlnTt2zfd6jN9JYRJd+GfCY+/9nOKqYWaKBc
        ijoIOQ1wPyPl/KSxzEkw0ad5NXMQG3t09AdFoXPhIfeMesX4A87u3SIN16Ku42tSh6HldIVuGAs
        /5bY6TQxClPn3ORDukjiaaeY2Thf+/j1g1A+0GcPt
X-Received: by 2002:ac2:5dea:0:b0:4ec:e32f:3d1f with SMTP id z10-20020ac25dea000000b004ece32f3d1fmr2308536lfq.11.1681748725392;
        Mon, 17 Apr 2023 09:25:25 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y+bsYZfdQ0YbXRNUdAiXrEC617Co8M6Ae9OYtGyQ7Z0JTehg+Oxteoxe+dPaIDFHLfU5sWj8/W0mxSAgomtgA=
X-Received: by 2002:ac2:5dea:0:b0:4ec:e32f:3d1f with SMTP id
 z10-20020ac25dea000000b004ece32f3d1fmr2308529lfq.11.1681748725093; Mon, 17
 Apr 2023 09:25:25 -0700 (PDT)
MIME-Version: 1.0
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de> <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <2a746461-844a-2ad6-7b52-03f13fe1b9bf@web.de>
In-Reply-To: <2a746461-844a-2ad6-7b52-03f13fe1b9bf@web.de>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Mon, 17 Apr 2023 18:25:13 +0200
Message-ID: <CACO55ttSoyhgjqMdtiEfhMP1YKFFTZJRXEv17F-WRWPzLF2Uvw@mail.gmail.com>
Subject: Re: [PATCH 0/9] GPU-DRM-nouveau: Adjustments for seven function implementations
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     kernel-janitors@vger.kernel.org, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Lyude Paul <lyude@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 16, 2023 at 11:30=E2=80=AFAM Markus Elfring <Markus.Elfring@web=
.de> wrote:
>
> Date: Sun, 16 Apr 2023 11:22:23 +0200
>
> Several update suggestions were taken into account
> from static source code analysis.
>

Reviewed-by: Karol Herbst <kherbst@redhat.com>

> Markus Elfring (9):
>   debugfs: Move an expression into a function call parameter
>     in nouveau_debugfs_pstate_set()
>   debugfs: Move a variable assignment behind a null pointer check
>     in nouveau_debugfs_pstate_get()
>   debugfs: Use seq_putc()
>     in nouveau_debugfs_pstate_get()
>   debugfs: Replace five seq_printf() calls by seq_puts()
>     in nouveau_debugfs_pstate_get()
>   power_budget: Move an expression into a macro call parameter
>     in nvbios_power_budget_header()
>   clk: Move a variable assignment behind a null pointer check
>     in nvkm_pstate_new()
>   pci: Move a variable assignment behind condition checks
>     in nvkm_pcie_set_link()
>   pci: Move an expression into a function call parameter
>     in nvkm_pcie_set_link()
>   therm: Move an assignment statement behind a null pointer check
>     in two functions
>
>  drivers/gpu/drm/nouveau/nouveau_debugfs.c     | 19 ++++++++++---------
>  .../nouveau/nvkm/subdev/bios/power_budget.c   |  3 +--
>  .../gpu/drm/nouveau/nvkm/subdev/clk/base.c    |  2 +-
>  .../gpu/drm/nouveau/nvkm/subdev/pci/pcie.c    |  7 +++----
>  .../drm/nouveau/nvkm/subdev/therm/fanpwm.c    |  2 +-
>  .../drm/nouveau/nvkm/subdev/therm/fantog.c    |  2 +-
>  6 files changed, 17 insertions(+), 18 deletions(-)
>
> --
> 2.40.0
>

