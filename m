Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5195573E30C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 17:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjFZPSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 11:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbjFZPSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 11:18:50 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FC118D;
        Mon, 26 Jun 2023 08:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687792729; x=1719328729;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=F2g+pWN+PH46QX+4CgNzEGk83Zi05IvEs2wwYLZavzE=;
  b=dOeU+V+8hg1QaOVFKVNuGZ35dyTWKyuiQhDQx9ARnBJ9FqPMqibZUdhK
   SHWKalyS6gMy6Va6IiexRuJ5zRfIqX3GO+beQEdRRybYw5b62+A0SoED/
   JwD6dbd4hfWS/mTw9vhNt9O1PlaGXmmNW2rx1xrDdqLO6/7BZmpcpBHfy
   5MN2pyc2QEjrtEybDtnrktAeLqb1KSnrC7dwa3OedULobtk7xsHxJpbNP
   hKkINss9ZTX68QgQrIMqTTvuRV7P8VwGzPPXJaa2v1XTQy2VQxfC0cJoR
   NQ0RkusAD2lZKrOnGqSLDlWClSXLZISPTANbBP27jPfio26vKtCA0VKTK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="391630726"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="391630726"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 08:18:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="860725040"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="860725040"
Received: from ettammin-mobl1.ger.corp.intel.com (HELO [10.249.254.105]) ([10.249.254.105])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 08:18:19 -0700
Message-ID: <88cbec2d2ae6329d44426cece4b558b7d83b1ff6.camel@linux.intel.com>
Subject: Re: [PATCH v2 2/4] drm/ttm: Don't shadow the operation context
From:   Thomas =?ISO-8859-1?Q?Hellstr=F6m?= 
        <thomas.hellstrom@linux.intel.com>
To:     Christian =?ISO-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>, intel-xe@lists.freedesktop.org
Cc:     Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Roger He <Hongbo.He@amd.com>, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, stable@vger.kernel.org,
        Matthew Brost <matthew.brost@intel.com>,
        linux-kernel@vger.kernel.org,
        Andi Shyti <andi.shyti@linux.intel.com>
Date:   Mon, 26 Jun 2023 17:18:16 +0200
In-Reply-To: <8b22c855-c84d-4b56-c94b-a3a079ab3037@gmail.com>
References: <20230626091450.14757-1-thomas.hellstrom@linux.intel.com>
         <20230626091450.14757-3-thomas.hellstrom@linux.intel.com>
         <8b22c855-c84d-4b56-c94b-a3a079ab3037@gmail.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-06-26 at 17:15 +0200, Christian K=C3=B6nig wrote:
> Am 26.06.23 um 11:14 schrieb Thomas Hellstr=C3=B6m:
> > ttm_bo_swapout() shadows the ttm operation context which may cause
> > major confusion in driver callbacks when swapping out
> > !TTM_PL_SYSTEM
> > memory. Fix this by reusing the operation context argument to
> > ttm_bo_swapout().
> >=20
> > Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> > Cc: Roger He <Hongbo.He@amd.com>
> > Cc: <dri-devel@lists.freedesktop.org>
> > Cc: <intel-gfx@lists.freedesktop.org>
> > Cc: <stable@vger.kernel.org> # v4.16+
> > Fixes: dc947770cf34 ("drm/ttm: enable swapout for reserved BOs
> > during allocation")
> > Signed-off-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> > Acked-by: Matthew Brost <matthew.brost@intel.com>
>=20
> We intentionally didn't used the parameter here, but I absolutely
> can't=20
> figure out why.
>=20
> Feel free to add my rb, but let's give it some time upstream before
> you=20
> base anything on top of this. Just in case we missed something.

Sure. Thanks for reviewing,
/Thomas

>=20
> Regards,
> Christian.
>=20
> > ---
> > =C2=A0 drivers/gpu/drm/ttm/ttm_bo.c | 3 +--
> > =C2=A0 1 file changed, 1 insertion(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/ttm/ttm_bo.c
> > b/drivers/gpu/drm/ttm/ttm_bo.c
> > index bd5dae4d1624..615d30c4262d 100644
> > --- a/drivers/gpu/drm/ttm/ttm_bo.c
> > +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> > @@ -1154,7 +1154,6 @@ int ttm_bo_swapout(struct ttm_buffer_object
> > *bo, struct ttm_operation_ctx *ctx,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Move to system cache=
d
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (bo->resource->mem_t=
ype !=3D TTM_PL_SYSTEM) {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0struct ttm_operation_ctx ctx =3D { false, false };
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0struct ttm_resource *evict_mem;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0struct ttm_place hop;
> > =C2=A0=20
> > @@ -1164,7 +1163,7 @@ int ttm_bo_swapout(struct ttm_buffer_object
> > *bo, struct ttm_operation_ctx *ctx,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0if (unlikely(ret))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
goto out;
> > =C2=A0=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0ret =3D ttm_bo_handle_move_mem(bo, evict_mem, true,
> > &ctx, &hop);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0ret =3D ttm_bo_handle_move_mem(bo, evict_mem, true,
> > ctx, &hop);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0if (unlikely(ret !=3D 0)) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
WARN(ret =3D=3D -EMULTIHOP, "Unexpected
> > multihop in swaput - likely driver bug.\n");
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
goto out;
>=20

