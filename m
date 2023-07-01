Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BF37448B5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 13:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjGALR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 07:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjGALRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 07:17:25 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1738F3C05
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 04:17:24 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3110ab7110aso3195486f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jul 2023 04:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688210242; x=1690802242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=df+h6oGnsbGeKd+U7g7lpcO2qynlZCdJkGfl7jYf+pA=;
        b=e06iYFoPs5xPuAbDuKb81ThyTA81LIpjm3PRmqy3j4cy3YxIqrS9lkcSqhW0CqBBSS
         8p3cPM4cw207uKOtQN+8MfZf1Wk0MDXoih6INntfhPogb6ed4AVbRs8qbrlcens/s4nq
         24v/z5Ve6dhjzVdQGDaoF/4PRmRwHcEbPwhiMjI4idb8uBWtKamxfjdTZfLpCrefoh+P
         OS4Q7gzdQPL/lVS1JtSSpAKT4VDlDziSezxdjQc1niHDKYKP7LNtc5wHsRmhrDcGD0vC
         cGvOpA5U8ruzTxWvEjVgUR2oOfoG4PRGaSIboAEPW6Goxy+0c+1CWEFgflkP9Fd/C2YX
         MIdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688210242; x=1690802242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=df+h6oGnsbGeKd+U7g7lpcO2qynlZCdJkGfl7jYf+pA=;
        b=FrDG/Y5KQ1BcUDplGaenmzRZ5qDPvusm0dt9FaWwUbQAAAEzVzpOVLy/kcc68/DZsE
         bJ05gTTNsYtOLScvUgfeji6c1ZbpFNyyv6paYgK15CF2AS3SvAT3hrHq0goH/lT2uJsG
         fVJQEpY4jJwYXyWDz3wCkSjWRqTJUPyeT2ymtBWeQFm6JdsQcV8JG8oSwkck4yqntbxE
         VzpiKXPSkTUGR9YK8eNezC0UE1ROpDWSXy7pPxJjENBMqpQuw2DolMvMwFluQe7FMHbw
         7CwcmRXjZ6siEd+vIAco+JzoJIyqYNKdjDmZoir74+twz7GF6+wvMiWstTdBVHmmF6BS
         iNDw==
X-Gm-Message-State: ABy/qLbErAihH8S3JviLM3IB9nPm5Fe/vja5NYchZLAYExk34u8uRs+e
        JExvo4yqV+a70NDDEZQdvKQ=
X-Google-Smtp-Source: APBJJlENonAV0IBOUJNzIIwrFDKQBGpMZFiTS/gC79q2LiBxvDpM5KIZkUJmGNUdGxyj4vgFSogUhQ==
X-Received: by 2002:a5d:45d1:0:b0:313:fe1b:f447 with SMTP id b17-20020a5d45d1000000b00313fe1bf447mr3878752wrs.71.1688210242177;
        Sat, 01 Jul 2023 04:17:22 -0700 (PDT)
Received: from suse.localnet (host-212-171-6-230.retail.telecomitalia.it. [212.171.6.230])
        by smtp.gmail.com with ESMTPSA id t1-20020adfe101000000b0030fb828511csm20584023wrz.100.2023.07.01.04.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jul 2023 04:17:21 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        Deepak R Varma <drv@mailo.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Sumitra Sharma <sumitraartsy@gmail.com>,
        Deepak R Varma <drv@mailo.com>
Subject: Re: [PATCH v3 2/6] gfs2: Replace kmap_atomic()+memcpy by memcpy_from_page()
Date:   Sat, 01 Jul 2023 13:17:20 +0200
Message-ID: <6543613.G0QQBjFxQf@suse>
In-Reply-To: <4d132d7aa9cc71f88e6e02c8f6fcb0fec56542aa.1688073459.git.drv@mailo.com>
References: <cover.1688073459.git.drv@mailo.com>
 <4d132d7aa9cc71f88e6e02c8f6fcb0fec56542aa.1688073459.git.drv@mailo.com>
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

On gioved=EC 29 giugno 2023 23:50:07 CEST Deepak R Varma wrote:
> kmap_atomic() is deprecated in favor of kmap_local_{folio,page}().
>=20
> kmap_atomic() disables page-faults and preemption (the latter only for
> !PREEMPT_RT kernels), However, the code within the mapping/un-mapping in
> gfs2_internal_read() does not depend on the above-mentioned side effects.
>=20
> Further, memcpy_{from,to}_page() wrappers combine the
> {kmap, unmap}_local_page() blocks when they are intended exclusively to
> copy contents from/to the temporary mapped page. So, replace the
> kmap_atomic()/kunmap_automic()

s/kunmap_automic/kunmap_atomic/

> block by the memcpy_from_page() API call.
> This change allows to tidy-up code and also eliminate unused variable p.
>=20
> Suggested-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

I don't like to read the list of the functions replaced by the=20
memcpy_from_page() helper in the subject of the patch. These details are=20
better suited in commit messages.

=46urthermore, you have not been consistent: "kmap_atomic()+memcpy" contain=
s=20
parentheses only in one of the two functions. Both or none.

The thing that really matters here is that You are replacing the deprecated=
=20
kmap_atomic() with kmap_local_page(). This is what the subject should show.

Please cite the use of the suited helper _only_ within the commit message a=
nd=20
explain why it is preferred to open code kmap_local_page() + memcpy() +=20
kunmap_local().=20

> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
> Changes in v3:
>    - Split as a separate patch for conversion in gfs2_internal_read()


>    - Use memcpy_from_page() as suggested by Fabio and  Andreas G
>    - Included split version in patch set
>=20
> Changes in v2:
>    - Update patch description to correct the replacement function name
>      from kmap_local_folio to kmap_local _page
>=20
>=20
>=20
>  fs/gfs2/aops.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
> index 3eac4f2f5c27..f47fed657763 100644
> --- a/fs/gfs2/aops.c
> +++ b/fs/gfs2/aops.c
> @@ -489,7 +489,6 @@ int gfs2_internal_read(struct gfs2_inode *ip, char *b=
uf,
> loff_t *pos, unsigned copied =3D 0;
>  	unsigned amt;
>  	struct page *page;
> -	void *p;
>=20
>  	do {
>  		page =3D read_cache_page(mapping, index, gfs2_read_folio,=20
NULL);
> @@ -498,12 +497,12 @@ int gfs2_internal_read(struct gfs2_inode *ip, char=
=20
*buf,
> loff_t *pos, continue;
>  			return PTR_ERR(page);
>  		}
> -		p =3D kmap_atomic(page);
> -		amt =3D size - copied;
>  		if (offset + size > PAGE_SIZE)
>  			amt =3D PAGE_SIZE - offset;
> -		memcpy(buf + copied, p + offset, amt);
> -		kunmap_atomic(p);
> +		else
> +			amt =3D size - copied;

This is a different logical change. Please put it in a different patch with=
=20
proper subject and commit message.

Thanks,

=46abio=20

> +
> +		memcpy_from_page(buf, page, offset, amt);
>  		put_page(page);
>  		copied +=3D amt;
>  		index++;
> --
> 2.34.1




