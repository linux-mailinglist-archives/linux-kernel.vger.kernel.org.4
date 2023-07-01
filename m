Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18868744971
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 15:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjGANpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 09:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjGANp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 09:45:29 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565FB3C00
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 06:45:28 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-313e23d0a28so3670453f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jul 2023 06:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688219127; x=1690811127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=spl3Nt5Mh1u6Uhlm9oKAy/7Yr7EModW5k9NwVSB4Gms=;
        b=Z1ihpuCsxOCdta/vnSzsGCtEzkGmm3FAcNlfZSL7Gu9C9Oo6Zrs/7fJvnBMFvG+hzv
         luZoloDhB7NCrRHEWEsd3aFo90qXN2SPtWwBa8EUs/wZ5kzLqFZG+KXRBmXQz/Y6Xg9O
         WJbZ9v+tGf5WfKDp8nRqxtnlYtT3Gq4X2DA9YJG5vU8WRFp/2t8UneQD/+2MWSSnz079
         aF9lQ9xD59pHtqQj2fuv35Ip82qLROd6EWqevutmeWrjLM3qZ3CSCyAOy+6KWEZ71se0
         G/l2j6UkcA1DnS0/f2Pik1t9s2oMKt9ykbWyu0HYIsINXyBXfd0JF+eJab36K4VkIEWx
         SOXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688219127; x=1690811127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=spl3Nt5Mh1u6Uhlm9oKAy/7Yr7EModW5k9NwVSB4Gms=;
        b=SjI25r6qRA5JzHFESxyia9O+NQaKKPGDRF/UO6Da7HDtgk96cnqQ5s3LmNRxdVQ1EQ
         UQL0w9MVwSqB38/SHnjh5Kwgv3mMzGK67vXDsk6brInB9vDQiDNl4z3J4MsUXhtZS1tq
         AiFq4GXWCIiCvwtaelMFtwq5QYQGVzk6tArIQUMzrDSK80uA2/iAxldo3nhrdtZYMb6q
         8hyuoiGCqEky98bZNwm+gdUTBxJAlH7JWlslcOwn//tbR3JIDJF0yCvdWFUzQ7wcbp6z
         rZy2RWMdNB7zP/97SvMfDm9SeKxM+53ACTQHWKJfFEOIfuehkzAwmNspSj0pALAnF45J
         k7DA==
X-Gm-Message-State: ABy/qLYUrcdME3t+yE5nBTFt/+6+7cB9Jsvlndz6dSdQWAn/aJLWmmNI
        DLXw2DtFb3v+I2cfuUGeunI=
X-Google-Smtp-Source: APBJJlFVf4dqgcV+O5QCrl2XMsX21r25ocAt5xvcDIt4CgAYJ2iCMSmdlE5QCxFjdJQYx6SfgDZ7kQ==
X-Received: by 2002:adf:ed45:0:b0:314:17a9:9f36 with SMTP id u5-20020adfed45000000b0031417a99f36mr4447038wro.69.1688219126541;
        Sat, 01 Jul 2023 06:45:26 -0700 (PDT)
Received: from suse.localnet (host-82-49-237-33.retail.telecomitalia.it. [82.49.237.33])
        by smtp.gmail.com with ESMTPSA id g11-20020a7bc4cb000000b003fbab76165asm11130532wmk.48.2023.07.01.06.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jul 2023 06:45:25 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        Deepak R Varma <drv@mailo.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Sumitra Sharma <sumitraartsy@gmail.com>,
        Deepak R Varma <drv@mailo.com>
Subject: Re: [PATCH v3 5/6] gfs2: Replace kmap() by kmap_local_page() in
 gfs2_read_super
Date:   Sat, 01 Jul 2023 15:45:24 +0200
Message-ID: <4817807.GXAFRqVoOG@suse>
In-Reply-To: <7ad72f9d1a97d673483c206d8ac9a88f2e32d3b9.1688073459.git.drv@mailo.com>
References: <cover.1688073459.git.drv@mailo.com>
 <7ad72f9d1a97d673483c206d8ac9a88f2e32d3b9.1688073459.git.drv@mailo.com>
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

On gioved=C3=AC 29 giugno 2023 23:51:53 CEST Deepak R Varma wrote:
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
> Therefore, replace kmap() with kmap_local_page() in gfs2_read_super().
>=20
> Suggested-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
> Changes in v3:
>    - Patch included in patch set
>=20
> Changes in v2:
>    - None
>=20
>  fs/gfs2/ops_fstype.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
> index 8a27957dbfee..80fe61662412 100644
> --- a/fs/gfs2/ops_fstype.c
> +++ b/fs/gfs2/ops_fstype.c
> @@ -264,9 +264,9 @@ static int gfs2_read_super(struct gfs2_sbd *sdp,=20
sector_t
> sector, int silent) __free_page(page);
>  		return -EIO;
>  	}
> -	p =3D kmap(page);
> +	p =3D kmap_local_page(page);
>
Deepak,

Could this page ever come from ZONE_HIGHMEM? Can you please check whether w=
e=20
really need to kmap*() it or not?=20

=46abio
>
>  	gfs2_sb_in(sdp, p);
> -	kunmap(page);
> +	kunmap_local(p);
>  	__free_page(page);
>  	return gfs2_check_sb(sdp, silent);
>  }
> --
> 2.34.1




