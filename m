Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9236A5F406C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiJDJzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiJDJzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:55:23 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E638AB40
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 02:55:20 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 3B94A1C000E;
        Tue,  4 Oct 2022 09:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1664877318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GXyIi+ebWamha1iFgMmeG8iIDrDPq+QuZINrL3RrMt8=;
        b=jnKUvsyBxeC30nUgynS7YnHqQfSNor70hIJXOx5oinSj9zRE/3kI7CSLJe8UG0mpxlJdOm
        Db3rBDLJ2ubxjoG56MtkUBNylDAZ37GNtS8jRsGGaifjhuFUJla/9hNI4s/Htnd7Pol3j8
        /IJzu4vp1RpO3RvwZOaZyal0HWkieVi/B3HRcDh2jQUnjL25Dbh3U+8SG7NptE6nC6hJh4
        Q1gOmI3phUyHJy9z18H+KE5BKJcYbCs69EuT8Sa8tfrtuQz1y7dWLxu1KhxJFuBHN2a1wX
        LjdvaM/pvpvCbgzDuVUx0fhOwrVlS3w1abFuMDhecF16UEsSlMSLewd4vs0QLw==
Date:   Tue, 4 Oct 2022 11:55:16 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Ray Zhang <sgzhang@google.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] mtd: mtdoops: panic caused mtdoops to call mtd
 erase function immediately
Message-ID: <20221004115516.5ccaf9db@xps-13>
In-Reply-To: <20220927173845.2293378-3-sgzhang@google.com>
References: <20220927173845.2293378-1-sgzhang@google.com>
        <20220927173845.2293378-3-sgzhang@google.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ray,

sgzhang@google.com wrote on Tue, 27 Sep 2022 17:38:45 +0000:

> The panic function disables the local interrupts, preemption, and all
> other processors. When the invoked mtdoops needs to erase a used page,
> calling schedule_work() to do it will not work. Instead, just call mtd
> erase function immediately.
>=20
> Tested:
> ~# echo c > /proc/sysrq-trigger
> [  171.654759] sysrq: Trigger a crash
> [  171.658325] Kernel panic - not syncing: sysrq triggered crash
> ......
> [  172.406423] mtdoops: not ready 34, 35 (erase immediately)
> [  172.432285] mtdoops: ready 34, 35
> [  172.435633] Rebooting in 10 seconds..
>=20
> Signed-off-by: Ray Zhang <sgzhang@google.com>
> ---
>  drivers/mtd/mtdoops.c | 66 ++++++++++++++++++++++++++-----------------
>  1 file changed, 40 insertions(+), 26 deletions(-)
>=20
> diff --git a/drivers/mtd/mtdoops.c b/drivers/mtd/mtdoops.c
> index 84b21be347f6..73c6a55eb391 100644
> --- a/drivers/mtd/mtdoops.c
> +++ b/drivers/mtd/mtdoops.c
> @@ -106,29 +106,8 @@ static int mtdoops_erase_block(struct mtdoops_contex=
t *cxt, int offset)
>  	return 0;
>  }
> =20
> -static void mtdoops_inc_counter(struct mtdoops_context *cxt)
> +static void mtdoops_erase(struct mtdoops_context *cxt)
>  {
> -	cxt->nextpage++;
> -	if (cxt->nextpage >=3D cxt->oops_pages)
> -		cxt->nextpage =3D 0;
> -	cxt->nextcount++;
> -	if (cxt->nextcount =3D=3D 0xffffffff)
> -		cxt->nextcount =3D 0;
> -
> -	if (page_is_used(cxt, cxt->nextpage)) {
> -		schedule_work(&cxt->work_erase);
> -		return;
> -	}
> -
> -	pr_debug("mtdoops: ready %d, %d (no erase)\n",
> -		 cxt->nextpage, cxt->nextcount);
> -}

Could you please split this commit, I would like to see:
* moving the code around, creating the schedule indirection
  (no functional change)
* fixing the problem with a minimal diff

> -
> -/* Scheduled work - when we can't proceed without erasing a block */
> -static void mtdoops_workfunc_erase(struct work_struct *work)
> -{
> -	struct mtdoops_context *cxt =3D
> -			container_of(work, struct mtdoops_context, work_erase);
>  	struct mtd_info *mtd =3D cxt->mtd;
>  	int i =3D 0, j, ret, mod;
> =20
> @@ -166,8 +145,8 @@ static void mtdoops_workfunc_erase(struct work_struct=
 *work)
>  		ret =3D mtdoops_erase_block(cxt, cxt->nextpage * record_size);
> =20
>  	if (ret >=3D 0) {
> -		pr_debug("mtdoops: ready %d, %d\n",
> -			 cxt->nextpage, cxt->nextcount);
> +		pr_notice("mtdoops: ready %d, %d\n",
> +			  cxt->nextpage, cxt->nextcount);

Seems unrelated :)

>  		return;
>  	}
> =20
> @@ -181,6 +160,41 @@ static void mtdoops_workfunc_erase(struct work_struc=
t *work)
>  	goto badblock;
>  }
> =20
> +/* Scheduled work - when we can't proceed without erasing a block */
> +static void mtdoops_workfunc_erase(struct work_struct *work)
> +{
> +	struct mtdoops_context *cxt =3D
> +			container_of(work, struct mtdoops_context, work_erase);
> +
> +	mtdoops_erase(cxt);
> +}
> +
> +static void mtdoops_inc_counter(struct mtdoops_context *cxt, int panic)
> +{
> +	cxt->nextpage++;
> +	if (cxt->nextpage >=3D cxt->oops_pages)
> +		cxt->nextpage =3D 0;
> +	cxt->nextcount++;
> +	if (cxt->nextcount =3D=3D 0xffffffff)
> +		cxt->nextcount =3D 0;
> +
> +	if (page_is_used(cxt, cxt->nextpage)) {
> +		pr_notice("mtdoops: not ready %d, %d (erase %s)\n",
> +			  cxt->nextpage, cxt->nextcount,
> +			  panic ? "immediately" : "scheduled");
> +		if (panic) {
> +			/* In case of panic, erase immediately */
> +			mtdoops_erase(cxt);
> +		} else {
> +			/* Otherwise, schedule work to erase it "nicely" */
> +			schedule_work(&cxt->work_erase);
> +		}
> +	} else {
> +		pr_notice("mtdoops: ready %d, %d (no erase)\n",
> +			  cxt->nextpage, cxt->nextcount);
> +	}
> +}
> +
>  static void mtdoops_write(struct mtdoops_context *cxt, int panic)
>  {
>  	struct mtd_info *mtd =3D cxt->mtd;
> @@ -214,7 +228,7 @@ static void mtdoops_write(struct mtdoops_context *cxt=
, int panic)
>  	mark_page_used(cxt, cxt->nextpage);
>  	memset(cxt->oops_buf, 0xff, record_size);
> =20
> -	mtdoops_inc_counter(cxt);
> +	mtdoops_inc_counter(cxt, panic);
>  out:
>  	clear_bit(0, &cxt->oops_buf_busy);
>  }
> @@ -279,7 +293,7 @@ static void find_next_position(struct mtdoops_context=
 *cxt)
>  		cxt->nextcount =3D maxcount;
>  	}
> =20
> -	mtdoops_inc_counter(cxt);
> +	mtdoops_inc_counter(cxt, 0);
>  }
> =20
>  static void mtdoops_do_dump(struct kmsg_dumper *dumper,

Otherwise lgtm.

Thanks,
Miqu=C3=A8l
