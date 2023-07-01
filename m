Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE13744912
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 15:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjGANBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 09:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjGANBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 09:01:08 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADC03AA7
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 06:01:06 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so4776130e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jul 2023 06:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688216465; x=1690808465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QzqV5Rrxm89YWqUbr+C1x/jOrYWel3k8dI9zQ9hOaBM=;
        b=RDWt9tAUqm50Wm6VRdu1/pscaGasApYpv2ddTp5eG9keESua9M1n1oZ7GS3Uyf5vrn
         LGUCvEzZZP0+dHdFoBidzkbGdmUjGR7Mr2JBFI63nGPV0B4vrEsGPy0Lih1JK1XRMRGd
         NQz2tEN5qC4lLPG4mii6hmOWdWpkwFjP5RRBIJ4THL01ydTWIYNSgMhNR+GsYNNmN5so
         PFGuiWFS+j0JPvg7of5aYaEWfyvgZE7bPlTwwhNQk5GXIqET0VOaYuw1vFppJNE4iDNR
         0/RqWvUmJ32XMgsjPh+RzheCYDPc6m6eJ9PY/j1GSq2MvOvQ3vWFh7aiFY2voXg467CT
         rd3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688216465; x=1690808465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QzqV5Rrxm89YWqUbr+C1x/jOrYWel3k8dI9zQ9hOaBM=;
        b=SZ1fcrxdX0YWFT/kJXbc+mku9c45YII4WSBUkQEsS73VHfxLUGpWDTlW9ieTukJdY0
         OA4/APUvAh3LwtuqOu5tRyD46zEfAmKLBPHzI5ugGTUxXdNHF1WiHt0ycxQUzR16AjZa
         zpbyXoGtVRNQBTmXKFPJViwX/jbqFQQL/EWLF+Ga8SIRGrHOI9cLW+dGMdMv0tmGL6V9
         LmlrnXxQF+Uu8DCcB+1xebV8V13b6mYMIQeOIgDVRV4W6QDakt3xHoDTT4epFp/bLsO9
         edLksfJ6suVgoipkWrZt6rMDKV6ZPqlfzn37BKWAu1A3MhBEIUmrDEp5mciuuwxhDzkw
         2+lg==
X-Gm-Message-State: ABy/qLbEpVi460OrSD9cUTatQamnNoSOUDD9hIW9KB4xPvbqmZnqe/hB
        LD6wiP0wyF0+thqSQ5xFCiE=
X-Google-Smtp-Source: APBJJlGlq/bVtto9AnMnlXZwhGvJ4yJAbccQ1B750dCY1/Cgg6BA2x1mmBVOS43GYXvEuCmb3C3WjA==
X-Received: by 2002:a05:6512:3242:b0:4f8:6b82:56c4 with SMTP id c2-20020a056512324200b004f86b8256c4mr3679444lfr.33.1688216464529;
        Sat, 01 Jul 2023 06:01:04 -0700 (PDT)
Received: from suse.localnet (host-212-171-6-230.pool212171.interbusiness.it. [212.171.6.230])
        by smtp.gmail.com with ESMTPSA id d11-20020a1c730b000000b003fb416d732csm14208774wmb.6.2023.07.01.06.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jul 2023 06:01:03 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        Deepak R Varma <drv@mailo.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Sumitra Sharma <sumitraartsy@gmail.com>,
        Deepak R Varma <drv@mailo.com>
Subject: Re: [PATCH v3 3/6] gfs2: Replace kmap() by kmap_local_page() in
 gfs2_unstuffer_page
Date:   Sat, 01 Jul 2023 15:01:02 +0200
Message-ID: <2946216.VdNmn5OnKV@suse>
In-Reply-To: <063721a02d5e226d1e9e9782f76ce94c16d73e93.1688073459.git.drv@mailo.com>
References: <cover.1688073459.git.drv@mailo.com>
 <063721a02d5e226d1e9e9782f76ce94c16d73e93.1688073459.git.drv@mailo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On gioved=C3=AC 29 giugno 2023 23:50:43 CEST Deepak R Varma wrote:
> The use of kmap() is being deprecated in favor of kmap_local_page().
>=20
> There are two main problems with kmap(): (1) It comes with an overhead as
> the mapping space is restricted and protected by a global lock for
> synchronization and (2) it also requires global TLB invalidation when the
> kmap=E2=80=99s pool wraps and it might block when the mapping space is fu=
lly
> utilized until a slot becomes available.
>=20
> With kmap_local_page() the mappings are per thread, CPU local, can take
> page faults, and can be called from any context (including interrupts).
> It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
> the tasks can be preempted and, when they are scheduled to run again, the
> kernel virtual addresses are restored and still valid.
>=20
> Therefore, replace kmap() with kmap_local_page() in gfs2_unstuffer_page().
>=20
> Suggested-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---

Deepak,

Would you please cite the author of this boiler-plate commit message? I thi=
nk=20
that you are not required by any stated formal rule, however it would be mu=
ch=20
appreciated (by me, at least :-)).

> Changes in v3:
>    - Patch included in the patch series
>=20
> Changes in v2:
>    - None
>=20
>=20
>  fs/gfs2/bmap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
> index 8d611fbcf0bd..6b850e2ba5c8 100644
> --- a/fs/gfs2/bmap.c
> +++ b/fs/gfs2/bmap.c
> @@ -58,12 +58,12 @@ static int gfs2_unstuffer_page(struct gfs2_inode *ip,
> struct buffer_head *dibh, struct inode *inode =3D &ip->i_inode;
>=20
>  	if (!PageUptodate(page)) {
> -		void *kaddr =3D kmap(page);
> +		void *kaddr =3D kmap_local_page(page);
>  		u64 dsize =3D i_size_read(inode);

As a general rule, we should take the mappings the shorter time it is possi=
ble=20
(to avoid to disable migration for too long). I'm not sure why the "dsize"=
=20
assignment is made between mapping and un-mapping. Can you please explain w=
hy?

Thanks,

=46abio

>  		memcpy(kaddr, dibh->b_data + sizeof(struct gfs2_dinode),=20
dsize);
>  		memset(kaddr + dsize, 0, PAGE_SIZE - dsize);
> -		kunmap(page);
> +		kunmap_local(kaddr);
>=20
>  		SetPageUptodate(page);
>  	}
> --
> 2.34.1




