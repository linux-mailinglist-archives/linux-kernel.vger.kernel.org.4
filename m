Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC4A7061C2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 09:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjEQHxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 03:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjEQHxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 03:53:10 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1337C4EEE
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 00:53:03 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-4345365ffe3so103670137.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 00:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684309982; x=1686901982;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WyFLOiSt+FtzfE39FeHW08WFhb9J+jn2vWhFKPP6Mwg=;
        b=q8TwWLY79Hyh3bjyTmB1ysfHFO1zMQYNMRu8iCGOMn/jUkAXM80ceXbdrj9PIy6Npf
         Kid149tAN7SKvMEEGX+yt3CRBD6/EBuIrXa/6RNYjdX2u69WObMU6SMdqGb++SKhp12X
         hgVFwidPFtTj16pO3vGJbt8a+gh8aKF6OwStMms+fAcsGHQtD8FWiZ8lt3zA0lZ18Wbo
         saA/ZZNAhj3k3j17r5MPynbxkPMengIXzx7uSDqD/sxLXKZiK6h+1UqVgr9biHPD7MOY
         +W2gTmQ+lO24NaFgCVi9NAIuzNEQP0SCbyzaq06Iljhb95I+fVKP1DxFAfwb3DdkW1D2
         4EMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684309982; x=1686901982;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WyFLOiSt+FtzfE39FeHW08WFhb9J+jn2vWhFKPP6Mwg=;
        b=WNIF7TcRclxuuX7raxmPhoLmkYczL0PQ1MpH/y8alhpsCEWXeMegHRo8vknbuyF5No
         Nb5NMP12S+2iULwgwVn6kMdcxwDmoywfrFWwX91aR6QoK0+9EDmVt+7zd4BS9yHRggS0
         7grO/zp0xVZ1/12zcnDv+4/7FwRsOT/8eGStOfqoz/Imq5kh2Udbc9YHArtL/CUBnmbi
         v2NKNsx6j21FfdQIR3b8hJiB+sUk4JxRC9eExztqSvSX2rDzeoPAZM7bsfGvV3grZrrU
         u8v83mtzlVT4cLK7H3Q7I8mg+seuOk9h/aYHs/lu1oibVvJXISlHjGmg1ItfwH5K/u0F
         rLYg==
X-Gm-Message-State: AC+VfDwgjgbj8BitOEzlVLRikHS8azSOoLUoToVEUIgYlYqw8gPJXf3F
        T897A1xMzlm1EYSt2URLAG7CSmMPmsY9MeIVi5eMpw==
X-Google-Smtp-Source: ACHHUZ7kdvCoiYGUDRXA0VpQ2rWsFU9JNMqBnmgZ0GZ6s8Q8KbJFCObn7U8FF6wlDvvnPZKguwQbMHKXd0vg3TnGxSE=
X-Received: by 2002:a67:fc05:0:b0:436:105d:91f9 with SMTP id
 o5-20020a67fc05000000b00436105d91f9mr12642224vsq.21.1684309982106; Wed, 17
 May 2023 00:53:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230517031856.19660-1-xiaoming.ding@mediatek.com> <ZGSDoVKKVqCkbaCB@infradead.org>
In-Reply-To: <ZGSDoVKKVqCkbaCB@infradead.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 17 May 2023 13:22:51 +0530
Message-ID: <CAFA6WYO+AvnbuAdWyBAQ8HkLaOno7PXdsPb9SubxrGNvAm4UnQ@mail.gmail.com>
Subject: Re: [PATCH] tee: add FOLL_LONGTERM for CMA case when alloc shm
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Xiaoming Ding <xiaoming.ding@mediatek.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, fei.xu@mediatek.com,
        srv_heupstream@mediatek.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2023 at 13:04, Christoph Hellwig <hch@infradead.org> wrote:
>
> > +     u32 page_flag = FOLL_WRITE;
> >
> >       if (!tee_device_get(teedev))
> >               return ERR_PTR(-EINVAL);
> > @@ -255,9 +256,11 @@ register_shm_helper(struct tee_context *ctx, unsigned long addr,
> >               ret = ERR_PTR(-ENOMEM);
> >               goto err_free_shm;
> >       }
> > -
> > +#if IS_ENABLED(CONFIG_CMA)
> > +     page_flag |= FOLL_LONGTERM;
> > +#endif
> >       if (flags & TEE_SHM_USER_MAPPED)
>
> If this mapping is long live it should always use FOLL_LONGTERM.

It depends on the userspace application needs. However, I think it
should be safe to use FOLL_LONGTERM by default to serve cases like
secure media playback.

>
> The ifdef does not make sense.

Agree.

-Sumit
