Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301D9717361
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 03:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbjEaByT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 21:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjEaByR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 21:54:17 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8558EC
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 18:54:15 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5148ebc4b89so7478137a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 18:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google; t=1685498054; x=1688090054;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=skVyqUKLBKyibv6d7XLdEYCvRQQF4Q+nIRGKQII+Jf8=;
        b=TExyHzpKaDCsHZI9tB1BGMGJIB/gS5MgsCtPKQRTy0V/pZ8gsul9EULvLSwlNpznDl
         RffU2USIRZHVUnSrfAYjKDr8lN+MPF+yLZOAGkuASYSNvutnVMesxeXw4MQJuxbJLQyv
         BV9eZGVPhaWhkQdkZ/U4P7JgwbTM9pDa7aOhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685498054; x=1688090054;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=skVyqUKLBKyibv6d7XLdEYCvRQQF4Q+nIRGKQII+Jf8=;
        b=iQKr/rzqjqrUZrm7zRv6ZfSUXUAelnmSxryQXS6UFtWxy6PQEaj9Hqwk+NDqCv1Z4f
         JlF7KYBkVoDhMDojrO9coKMUsnviSPinp1ADpynVvrNXhdaZgiWgIAXzOx7FlsMWsz/4
         qNrDkoBGVUGxh5L2PeAYcHD9Z4L3Fp7qtuRMYOGX2zLQXPhvf2WxSJoLPM3Q7EBy/oru
         TtGfnArEj0Xx/eFdkXribyeomswcDlj9hObwdkgP5MI855j+yZ3d4aCIgNxOSsaIMOa6
         Xmh9cjMEy/hqbJ+zd+v3QE7i84UPO8E8WAcTg99iXrkYBokx79pozq0bpx7HYoXDdSH7
         HSNQ==
X-Gm-Message-State: AC+VfDzuBsCWFC3zexaPIFdCPlYUFV2DGH74JHEbUFscrfidQIyWYZRB
        oTqTLhfgsCo6b2ExE4saJG4S3FByR1w6C1zIQHs=
X-Google-Smtp-Source: ACHHUZ72kjvUtwQpZaZj/q7Ueb4/DnciEQ3oszBzjXjl/1vVKBO0X0QyT3wjYFy2wuQbgV3WCirccZcPi9efP1mCi+U=
X-Received: by 2002:a17:907:2d93:b0:96f:d07e:a1ce with SMTP id
 gt19-20020a1709072d9300b0096fd07ea1cemr4067762ejc.60.1685498054104; Tue, 30
 May 2023 18:54:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230413162440.3313036-1-eajames@linux.ibm.com>
In-Reply-To: <20230413162440.3313036-1-eajames@linux.ibm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 31 May 2023 01:54:01 +0000
Message-ID: <CACPK8Xdzjh3YATzuA+JB_PpzE-uJsbD+vL2Q3tUf83xYbto8vw@mail.gmail.com>
Subject: Re: [PATCH] fsi: core: Fix legacy minor numbering
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        jk@ozlabs.org, alistair@popple.id.au
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Apr 2023 at 16:24, Eddie James <eajames@linux.ibm.com> wrote:
>
> FSI reserves the first 64 minor numbers for the legacy numbering
> based on the chip id. However the legacy number shifts the chip
> id too much, resulting in overlap between legacy and non-legacy
> numbers. Reduce the chip id bit shift since the type field only
> takes 2 bits.

I don't know much about the legacy numbering. Was that something we
used before the device tree descriptions were in place? Do we still
need it if we have updated device trees?

>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  drivers/fsi/fsi-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
> index 0b927c9f4267..b9f410170655 100644
> --- a/drivers/fsi/fsi-core.c
> +++ b/drivers/fsi/fsi-core.c
> @@ -950,7 +950,7 @@ static int __fsi_get_new_minor(struct fsi_slave *slave, enum fsi_dev_type type,
>         /* Check if we qualify for legacy numbering */
>         if (cid >= 0 && cid < 16 && type < 4) {
>                 /* Try reserving the legacy number */

Would it help to put some of your commit message info in this comment,
so we know what the magic shift is doing?

> -               id = (cid << 4) | type;
> +               id = (cid << 2) | type;
>                 id = ida_simple_get(&fsi_minor_ida, id, id + 1, GFP_KERNEL);
>                 if (id >= 0) {
>                         *out_index = fsi_adjust_index(cid);
> --
> 2.31.1
>
