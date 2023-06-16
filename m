Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D49C732799
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 08:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbjFPGbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 02:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244549AbjFPG3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 02:29:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F8D49E8;
        Thu, 15 Jun 2023 23:28:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25E7862527;
        Fri, 16 Jun 2023 06:28:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 652CBC433C8;
        Fri, 16 Jun 2023 06:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686896881;
        bh=NK6NuNFj6+ESLJk6aKbG68bt0tVJtq65SC771NXQPfg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WwCkCulQ6VNP6YtmzKbofwhV7Z2+OKi2JPo0GjlVrFuD+Ok0Yq/Gg++NnVw+iYMDr
         5iz7p5PFY3HafVtWf0I9vr3r09RSpQJ9oJO0rQRExuh7qb1Jzg/rfAXSb4jYhl9K/J
         o+7Yz8vSs0P484qhoE2tlZssstXQQo4MiOGQmx7e2otY0gNALtDe2W9igNHZLeL1jX
         /OiOwBr+65CIlNbJ0DJGBH4bGj6MQFO3zt/BWScq+/3OemQKsAwqulJMMpQE6jOsP3
         Jq7RpQ2U069FvzGKo3OICqcDDPjwpXHjmOBQ0yZuvD1CtxmLCfg3u0O9V2AtOhPTp/
         kTek1+U/Omx6w==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-4f84d70bf96so504605e87.0;
        Thu, 15 Jun 2023 23:28:01 -0700 (PDT)
X-Gm-Message-State: AC+VfDzXr+xxr83tsm6t8dc8yMWBB/sHvHgFjqzeyZHI8f5HLVNTrP22
        OMgFdEkUjBhWFFFcTNL/Wu32s7g8vmqa2ogOb0Q=
X-Google-Smtp-Source: ACHHUZ4/Yfz6iefR4/LZNWw3H9bD7KIpGKrwWMx1kWDdh4k0Fq0YPCWWuMoccGxCBeNVge+THgNUshhhznV0O6TiVkU=
X-Received: by 2002:a05:6512:1289:b0:4f6:19c3:da30 with SMTP id
 u9-20020a056512128900b004f619c3da30mr2240526lfs.29.1686896879390; Thu, 15 Jun
 2023 23:27:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230616012136.3047071-1-yukuai1@huaweicloud.com>
In-Reply-To: <20230616012136.3047071-1-yukuai1@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 15 Jun 2023 23:27:47 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6aSvCEa1khjjmDYGozUEs+Tx75RxfaE1+xL2Y1T6aN=Q@mail.gmail.com>
Message-ID: <CAPhsuW6aSvCEa1khjjmDYGozUEs+Tx75RxfaE1+xL2Y1T6aN=Q@mail.gmail.com>
Subject: Re: [PATCH] md/raid1-10: fix casting from randomized structure in raid1_submit_write()
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     axboe@kernel.dk, nathan@kernel.org, ndesaulniers@google.com,
        yukuai3@huawei.com, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 6:26=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Following build error triggered while build with clang version 17.0.0
> with W=3D1(this can't be reporduced with gcc 13.1.0):
>
> drivers/md/raid1-10.c:117:25: error: casting from randomized structure
> pointer type 'struct block_device *' to 'struct md_rdev *'
>      117 |         struct md_rdev *rdev =3D (struct md_rdev *)bio->bi_bde=
v;
>          |                                ^
>
> Fix this by casting 'bio->bi_bdev' to 'void *', as it used to be.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202306142042.fmjfmTF8-lkp@int=
el.com/
> Fixes: 8295efbe68c0 ("md/raid1-10: factor out a helper to submit normal w=
rite")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Applied to md-next.

Thanks,
Song

> ---
>  drivers/md/raid1-10.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
> index 169ebe296f2d..3f22edec70e7 100644
> --- a/drivers/md/raid1-10.c
> +++ b/drivers/md/raid1-10.c
> @@ -116,7 +116,7 @@ static void md_bio_reset_resync_pages(struct bio *bio=
, struct resync_pages *rp,
>
>  static inline void raid1_submit_write(struct bio *bio)
>  {
> -       struct md_rdev *rdev =3D (struct md_rdev *)bio->bi_bdev;
> +       struct md_rdev *rdev =3D (void *)bio->bi_bdev;
>
>         bio->bi_next =3D NULL;
>         bio_set_dev(bio, rdev->bdev);
> --
> 2.39.2
>
