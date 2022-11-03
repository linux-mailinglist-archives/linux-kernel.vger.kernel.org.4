Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04120618B54
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 23:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbiKCWWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 18:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiKCWWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 18:22:44 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D251FFAE
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 15:22:43 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id bs21so4768097wrb.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 15:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SWINOlKhJAkssXzcOhXO4HAUW0ow90/yx9bP7G1rGXs=;
        b=dJ7WU5ACz7c1mzpOTo4t5L1yluOsltb+7Wd5qhUUHWIn4jodJjq9DAF4tvOS749WKu
         24xBZA1Jvw338ujURsGnAsMRAeB9vNyoRo8MqbzAcp3INSQTRAO5SaKOlASS3iSJ4EMU
         PCZZZ8CdAcSKHb88A+ShL7sO7ISCCr3FHQ7Ep9GRu3mUF7sxabZONfbGHNf/m5ARL/6S
         UDj2KNKTpwhZgYCva9/JDlL05CoqqkqJD6A1lhC8kyRZ2GXrpG4If5htz3x9JRGQpECV
         0nJZCqU9M+KCC79jNTcm3HuRQcRuXRQ3jS9S3SydzkN1tAC7/haBPKMRjBmKgknSHqig
         icTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SWINOlKhJAkssXzcOhXO4HAUW0ow90/yx9bP7G1rGXs=;
        b=gpScVpGXQxhRwTSwdtMJvmkkCtpS4kr2x44J8qdxLEtyxUsEiYm1jlphMEWK61NPYZ
         h8fZlQzolYbxXQ/QgsSQrwwGk6qKrdI7o/yracdtb4n7wqrtIocY4/m+KtknDlU5k4eX
         pXokGtHoedU/UhmTD11SX/IvBU8HaTOsYp+kT2xG2FgWcVwTRsFKkzF6cgmVrDmP2qvc
         zYWautIW+VEcRRnj9WgQ79TRWfVAvIK7bEibBFYsgI1t4XOe4fYYZHUEWbRD29fWv6Z5
         Pfuk7+ZshQBR6HnY4pL1evdElHtJ6lxWhtjTvJJc86KM5gyCYyR7Kr63z1VZngmEiGL7
         q7Zg==
X-Gm-Message-State: ACrzQf2AiBH9ZeD5e+1lN3GMzovBdg6JpypGgmyFqYMEtPGkvK/rPXns
        mLb54O/Vc4S+SvIpahWfK78=
X-Google-Smtp-Source: AMsMyM60DYhjs7F3Uyj0ZeQmy+UHCwQak/sdeBkfIVbqNJrtBCUsPE2zDmNgaEl4IKUwklj14BHw0g==
X-Received: by 2002:a5d:4ace:0:b0:236:6054:30f5 with SMTP id y14-20020a5d4ace000000b00236605430f5mr20014260wrs.19.1667514161785;
        Thu, 03 Nov 2022 15:22:41 -0700 (PDT)
Received: from suse.localnet (host-79-43-11-206.retail.telecomitalia.it. [79.43.11.206])
        by smtp.gmail.com with ESMTPSA id n25-20020a7bc5d9000000b003c6c5a5a651sm1015763wmk.28.2022.11.03.15.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 15:22:41 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthew Auld <matthew.auld@intel.com>,
        Thomas =?ISO-8859-1?Q?Hellstr=F6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Zhao Liu <zhao1.liu@linux.intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Zhenyu Wang <zhenyu.z.wang@intel.com>,
        Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 3/9] drm/i915: Use kmap_local_page() in gem/i915_gem_shmem.c
Date:   Thu, 03 Nov 2022 23:22:32 +0100
Message-ID: <1833466.tdWV9SEqCh@suse>
In-Reply-To: <20221017093726.2070674-4-zhao1.liu@linux.intel.com>
References: <20221017093726.2070674-1-zhao1.liu@linux.intel.com> <20221017093726.2070674-4-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On luned=EC 17 ottobre 2022 11:37:19 CET Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
>=20
> The use of kmap_atomic() is being deprecated in favor of
> kmap_local_page()[1].
>=20
> The main difference between atomic and local mappings is that local
> mappings doesn't disable page faults or preemption.
>=20
> In drm/i915/gem/i915_gem_shmem.c, the function shmem_pwrite() need to
> disable pagefault to eliminate the potential recursion fault[2]. But
> here __copy_from_user_inatomic() doesn't need to disable preemption and
> local mapping is valid for sched in/out.
> So it can use kmap_local_page() / kunmap_local() with
> pagefault_disable() / pagefault_enable() to replace atomic mapping.
>=20
> [1]: https://lore.kernel.org/all/20220813220034.806698-1-ira.weiny@intel.=
com
> [2]: https://patchwork.freedesktop.org/patch/295840/
>=20
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
> Suggested by credits:
>   Ira: Referred to his suggestions about keeping pagefault_disable().
> ---
>  drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

The commit message explains clearly and the changes to the code look good. =
The=20
necessity to reuse pagefault_disable() / pagefault_enable() from the main=20
kmap_atomic() side effect is a nice catch.

Reviewed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Thanks!

> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c index f42ca1179f37..e279a3e30=
c02=20
100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> @@ -472,11 +472,13 @@ shmem_pwrite(struct drm_i915_gem_object *obj,
>  		if (err < 0)
>  			return err;
>=20
> -		vaddr =3D kmap_atomic(page);
> +		vaddr =3D kmap_local_page(page);
> +		pagefault_disable();
>  		unwritten =3D __copy_from_user_inatomic(vaddr + pg,
>  						      user_data,
>  						      len);
> -		kunmap_atomic(vaddr);
> +		pagefault_enable();
> +		kunmap_local(vaddr);
>=20
>  		err =3D aops->write_end(obj->base.filp, mapping, offset,=20
len,
>  				      len - unwritten, page, data);



