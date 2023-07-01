Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0687448A0
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 13:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjGALDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 07:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjGALDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 07:03:01 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2983ABF
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 04:03:00 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbd33a573cso160155e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jul 2023 04:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688209378; x=1690801378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XWGxndxFRuvJGKVSHvTPl6o4SCgPzXA9gfeKu76hfZ8=;
        b=N9Ct6hXdqjsfNuwtvfuIffzmQIOnASKd1vUFm6qSgx+/DlaDRiRUM9L637BoHCvOwe
         PWQvl6rMOXY/nm5ZRH6+UzF0zlvnj7/eFG5ARhgC75MLmRTMaE8btOvHi9u7sUNEXBPY
         LWV/AKu8W8Yo63+Ih65qsnDqJlo6vhFr2xj2PqkYBCmE5tuXdHxeEUonry6QgxmM+9j4
         VxNi/mAmbjZ/0QcGG2JonFhEb8MEyfl1fQbxvStzXEmlnrhA7aZ0P7jbt8iFKT+/5Wyt
         Bn22kTUKHkqq29SEpz8I7KJs/res4SFbwViaLnh6b4RUVd9SSblFVZoNuOLiMDKv8KrU
         pvRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688209378; x=1690801378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XWGxndxFRuvJGKVSHvTPl6o4SCgPzXA9gfeKu76hfZ8=;
        b=mH0LUUH3q1M8OX2SAb3WB2/uSFUMRIaA1pbW6YiASNOuT0ae2QYdb156kiJ6RNiTl3
         pxftjf2wNkJtTelUzekG3cgtQi/CBaP4DngPxHxDyaezYCv/qfT+1hDTCBmeGzwvu+he
         K6GYd5coJIgv46+5GKuSvKdK0yu6AmN7mP6kyX8dczUfM4gdIyO/beaKNwlcchg3qiHW
         jXgjMQlfIx2U7B63UinnaAvQC1Z7jJYZgBnEkLOK4RK9WmAhHKVPW8VgA3va9pl5zj3H
         4wxpehJY2pWeA6QlTzg9I9Dd26pJa4bVgyZp2srhOQB+WBjqTnhp4T+cZQeRczgc6iLK
         Xzfg==
X-Gm-Message-State: AC+VfDwZrD0oZkYzliLhN40Tx/esRMvimiK5v6WkZVGMbfnvO0FS6qeQ
        8omwXs0t0sp30kv2I+rZkbs=
X-Google-Smtp-Source: ACHHUZ5eNBvrZwml4SSyLZDaHtQ4XOdgUt5JbWIIrVgzvtCcsFs0V1TjO8yLbYMcOsoKyanFGF/F8w==
X-Received: by 2002:a05:600c:d2:b0:3fa:d167:5348 with SMTP id u18-20020a05600c00d200b003fad1675348mr3965315wmm.1.1688209378160;
        Sat, 01 Jul 2023 04:02:58 -0700 (PDT)
Received: from suse.localnet (host-212-171-6-230.pool212171.interbusiness.it. [212.171.6.230])
        by smtp.gmail.com with ESMTPSA id n19-20020a7bc5d3000000b003fbd04ecdc6sm1279616wmk.5.2023.07.01.04.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jul 2023 04:02:57 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        Deepak R Varma <drv@mailo.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Sumitra Sharma <sumitraartsy@gmail.com>,
        Deepak R Varma <drv@mailo.com>
Subject: Re: [PATCH v3 1/6] gfs2: Replace kmap_atomic() by kmap_local_page() in
 stuffed_readpage
Date:   Sat, 01 Jul 2023 13:02:55 +0200
Message-ID: <1804362.TLkxdtWsSY@suse>
In-Reply-To: <1955d9c440240f4c97efd80f3efca550871fe0ef.1688073459.git.drv@mailo.com>
References: <cover.1688073459.git.drv@mailo.com>
 <1955d9c440240f4c97efd80f3efca550871fe0ef.1688073459.git.drv@mailo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On gioved=EC 29 giugno 2023 23:49:29 CEST Deepak R Varma wrote:
> kmap_atomic() is deprecated in favor of kmap_local_{folio,page}().
>=20
> Therefore, replace kmap_atomic() with kmap_local_page() in
> stuffed_readpage().
>=20
> kmap_atomic() disables page-faults and preemption (the latter only for
> !PREEMPT_RT kernels), However, the code within the mapping/un-mapping in
> stuffed_readpage() does not depend on the above-mentioned side effects.
>=20
> Therefore, a mere replacement of the old API with the new one is all that
> is required (i.e., there is no need to explicitly add any calls to
> pagefault_disable() and/or preempt_disable()).
>=20
> Suggested-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

It LGTM, therefore, it is...

Reviewed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
> Changes in v3:
>    - split into 2 patches

NIT: I can't understand why you think the previous single patch needed to b=
e=20
split. Despite I can't understand why, I have nothing against it :-)

Thanks,

=46abio

P.S.: Next time please take note somewhere (maybe after the three dashes?)=
=20
that you are re-using my commit message word by word. I'd appreciate it :-)=
=20
However, it doesn't really matter much so please _don't_ send a newer patch=
=20
only for this little request.

>    - included in the patch set. Was sent as standalone patch previously
>=20
> Changes in v2:
>    - Update patch description to correct the replacement function name fr=
om
>      kmap_local_page to kmap_local_folio
>=20
>=20
>  fs/gfs2/aops.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
> index 3b41542d6697..3eac4f2f5c27 100644
> --- a/fs/gfs2/aops.c
> +++ b/fs/gfs2/aops.c
> @@ -432,10 +432,10 @@ static int stuffed_readpage(struct gfs2_inode *ip,
> struct page *page) if (error)
>  		return error;
>=20
> -	kaddr =3D kmap_atomic(page);
> +	kaddr =3D kmap_local_page(page);
>  	memcpy(kaddr, dibh->b_data + sizeof(struct gfs2_dinode), dsize);
>  	memset(kaddr + dsize, 0, PAGE_SIZE - dsize);
> -	kunmap_atomic(kaddr);
> +	kunmap_local(kaddr);
>  	flush_dcache_page(page);
>  	brelse(dibh);
>  	SetPageUptodate(page);
> --
> 2.34.1




