Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A36744978
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 15:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjGANyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 09:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjGANyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 09:54:11 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F36A3C11
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 06:54:10 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fba5a8af2cso29423385e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jul 2023 06:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688219648; x=1690811648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0OMMsvHxXHZc/OFAWSLiE/7BBNcrGZ7HGVVSJpHQ4oU=;
        b=WdZBm8gYVWsuxFe0tTqmRUi2cq1keghXJjX2qF1s+zENnrLES3Ns15//9eZs5Ee6CC
         LCQmca4AgfWmp1a0XzkUjt7HE81uck7LJ6NhDyxnYLZNaWOjot8iE/Mj0k7pdlAqpwUv
         BuTAudIHw6pyhb7W2czaqmGlJqqmIjAB/LWkHkFpTV9HlIJ/Lpv8G6Lc6xvWGUYjvjKn
         l6U6uGciggbQs4GhL1uMK4ZjKCcwDbdae8+MkCdyD7hN3EGQLIEuIsmh90VnZnftRL7+
         QwfV2J3a9feViug/5tQ4j2Muo/692aCJP/q0sKPTM3wV1fH2QdmcMeK5dsLQsX28LaMv
         y3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688219648; x=1690811648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0OMMsvHxXHZc/OFAWSLiE/7BBNcrGZ7HGVVSJpHQ4oU=;
        b=TwVbth7Q2QlRDz1ImEflAs9YnQrk+wTQ13iQyUjVdHF0Bx1Qz1psfEcuFesW6WtWLP
         fT5nWA/Evq0dqiSqojWTWdN3qJHTvTVdSL0ZBX604sh09LA3KvaYDxzwLMde/6wv4cAK
         ScA67apg5vSNNKh1t5N23VcZa6EaTLpDFEakKoou0Lyv6+6xrKL9HSLp5HSUONGZK/Qv
         +fO7RPUwEIZCBCzcz0zma9pEe5qTYe8BfOtmIautUQEJgpypbVcIXMSf8+z4JMxR+3n3
         juv/f6LiArZSKtH1c3Q56M8qaWXU1uCRBOMEeqlRHEiX/qIIgw9IXIMumuNVAilWnjbt
         EBkA==
X-Gm-Message-State: ABy/qLYbVZ+sinSLAH40/6AZT3enXFq8EbtAs/2GDOItKN4SHwT3UPMk
        ue6nVO5S/ShOT3oV1gx09d0=
X-Google-Smtp-Source: APBJJlEvmncnJLiIiHUhRiWxw7Jv6npdvAFV6FmDI7Gddi0kszH6KRyxdntb5Xw3trZaH6qkKJGZrQ==
X-Received: by 2002:adf:ed8a:0:b0:313:f0d7:a46 with SMTP id c10-20020adfed8a000000b00313f0d70a46mr4054894wro.3.1688219648426;
        Sat, 01 Jul 2023 06:54:08 -0700 (PDT)
Received: from suse.localnet (host-82-49-237-33.retail.telecomitalia.it. [82.49.237.33])
        by smtp.gmail.com with ESMTPSA id u20-20020a05600c211400b003fbb618f7adsm7712397wml.15.2023.07.01.06.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jul 2023 06:54:07 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        Deepak R Varma <drv@mailo.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Sumitra Sharma <sumitraartsy@gmail.com>,
        Deepak R Varma <drv@mailo.com>
Subject: Re: [PATCH v3 6/6] gfs2: Replace kmap_atomic() by kmap_local_page() in
 gfs2_write_buf_to_page
Date:   Sat, 01 Jul 2023 15:54:06 +0200
Message-ID: <2235268.iZASKD2KPV@suse>
In-Reply-To: <4bed561513ba76486ea3fc87f97e6c646f98cbe7.1688073459.git.drv@mailo.com>
References: <cover.1688073459.git.drv@mailo.com>
 <4bed561513ba76486ea3fc87f97e6c646f98cbe7.1688073459.git.drv@mailo.com>
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

On gioved=EC 29 giugno 2023 23:52:27 CEST Deepak R Varma wrote:
> kmap_atomic() is deprecated in favor of kmap_local_{folio,page}().

Deepak,

Again please refer to documentation and/or Ira's deprecation patch. The=20
reasons why are in one of my previous messages.

> Therefore, replace kmap_atomic() with kmap_local_page() in
> gfs2_write_buf_to_page().
>=20
> kmap_atomic() disables page-faults and preemption (the latter only for
> !PREEMPT_RT kernels), However, the code within the mapping/un-mapping in
> gfs2_write_buf_to_page() does not depend on the above-mentioned side
> effects.
>=20
> Therefore, a mere replacement of the old API with the new one is all that
> is required (i.e., there is no need to explicitly add any calls to
> pagefault_disable() and/or preempt_disable()).
>
> Suggested-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
> Changes in v3:
>    - Patch included in patch set
>=20
> Changes in v2:
>    - None
>=20
>=20
>  fs/gfs2/quota.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
> index 386ca770ce2e..e5767133aeea 100644
> --- a/fs/gfs2/quota.c
> +++ b/fs/gfs2/quota.c
> @@ -764,10 +764,10 @@ static int gfs2_write_buf_to_page(struct gfs2_inode=
=20
*ip,
> unsigned long index, }
>=20
>  	/* Write to the page, now that we have setup the buffer(s) */
> -	kaddr =3D kmap_atomic(page);
> +	kaddr =3D kmap_local_page(page);
>
Well, if this page could come from HIGHMEM, how about memcpy_to_page()?=20
Otherwise, (if it cannot come from HIGHMEM) we don't need to kmap*() it.=20

Can you please take a look at the allocation's flags?

Thanks,

=46abio
>
>  	memcpy(kaddr + off, buf, bytes);
>  	flush_dcache_page(page);
> -	kunmap_atomic(kaddr);
> +	kunmap_local(kaddr);
>  	unlock_page(page);
>  	put_page(page);
>=20
> --
> 2.34.1




