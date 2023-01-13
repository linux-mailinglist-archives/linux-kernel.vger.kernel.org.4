Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2657F66A233
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 19:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjAMSh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 13:37:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjAMShg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 13:37:36 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6D21EC5D
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 10:36:39 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id o13so19743925pjg.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 10:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j4F3gMakR5EjuEaFBMZ7D8qgSZpXpMhQV5Lb3h6YkX4=;
        b=sqwP3bvcIkIkHlOHuaj7PzhrogErMceNfkIz1l7wmrEJ52RKt1ZoLaNFxbpOSA3UpL
         wq1sh1ojD/X7Iy6a9obxqvPAX82NCW94JSqZoXJ4VPostzzk8OBUzRW2QZCxPsty/wXb
         9IXClLbv/GxUW9SLkr6zfzlHZd7HpiTaZ8Yvy9soWUs1OemOk/v/NO8MYlwrCl9zXF5+
         HCfWR+ud6GaZDcvdGETTwikzINdoumIpGP5pl8ezxXEzc3zwN5BIhZBeMaQiCdi43Xmr
         yAQ8h9uEbmzXOuUyEHA/9lDV/SU+Yesi9ACAmnts4FF2odbDNYPf5Uon+/q/RdhTXpub
         HMJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j4F3gMakR5EjuEaFBMZ7D8qgSZpXpMhQV5Lb3h6YkX4=;
        b=2vAR3n52cly0u/vUt/X1HR6pAP1+AEimYW/5FVj3cTBLQA6dQpSB8GXKyPaEyirtKi
         uHFrT+YkeJfoSi7i9LtFibZdN1qNBobLK7RHKnv94sUv/AQ7qF1jBsKnrcigKNBdJ4ON
         OmIEMfrYe9CrlK9w4rkWjCwtgKlqKEGhjfQAr1cNYGXYcelvowd3pEveWe7wqPFgyl4l
         QlgcTOJpyEmPQPFan/qJ1IfbXxmRBKegpu25+SCcMAHDSK8Yc0UPanbfWtdOnx8Npjdt
         6RYNbExTZHBaChFtRlSgCvNGE6lOpivd4Jk5ELylm54BUw6OmlUCwJHI7cjvnuabULTa
         k7XQ==
X-Gm-Message-State: AFqh2kpUgKzDUy3d5eBU96VPtNyac+1qcja5+grCc3K3PakfTd+O63e5
        lPdVT2cLKlaM3nuE4kQFAZTQfg71zsN1rJq2pVhowA==
X-Google-Smtp-Source: AMrXdXut+ZVz9p9DBkW4zfz3GUwV90SnmUswJaW85cGYlU4XXpHCwXHrnm3bYtlfE6P1Eb4qY9jWr4Npr5okcAdcplU=
X-Received: by 2002:a17:90a:488a:b0:226:b5f4:d420 with SMTP id
 b10-20020a17090a488a00b00226b5f4d420mr3958048pjh.102.1673634998456; Fri, 13
 Jan 2023 10:36:38 -0800 (PST)
MIME-Version: 1.0
References: <20230104132646.7100-1-chunfeng.yun@mediatek.com>
In-Reply-To: <20230104132646.7100-1-chunfeng.yun@mediatek.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 13 Jan 2023 10:36:27 -0800
Message-ID: <CAKwvOdnMF4LRhTnQ3Rg+q3hd7jm2tS0aTHmwU6isKJHL2u9Q-g@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] phy: mediatek: fix build warning caused by clang
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Eddie Hung <eddie.hung@mediatek.com>,
        kernel test robot <lkp@intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 4, 2023 at 5:26 AM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
>
> Remove the temporary @mask_, this may cause build warning when use clang
> compiler for powerpc, but can't reproduce it when compile for arm64.
> the build warning is -Wtautological-constant-out-of-range-compare, and
> caused by
> "BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask)"

Can you please include the text of the observed warning?

>
> After removing @mask_, there is a "CHECK:MACRO_ARG_REUSE" when run
> checkpatch.pl, due to @mask is constant, no reuse problem will happen.
>
> Fixes: 84513eccd678 ("phy: mediatek: fix build warning of FIELD_PREP()")

Uh, why was 84513eccd678 sent/reviewed/merged if it didn't fix the
issue correctly in the first place?

Is the issue perhaps that your mask isn't wide enough in the first
place, and should be?  See:
commit cfd6fb45cfaf ("crypto: ccree - avoid out-of-range warnings from clang")
for inspiration.

> Reported-by: kernel test robot <lkp@intel.com>

Can you please include the Link: tag to the lore URL of the report?

> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v6: modify the title
> v5: no changes
> v4 new patch, I'm not sure it can fix build warning, due to I don't cross compile
>     it for powerpc using clang in office.
> ---
>  drivers/phy/mediatek/phy-mtk-io.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/phy/mediatek/phy-mtk-io.h b/drivers/phy/mediatek/phy-mtk-io.h
> index d20ad5e5be81..58f06db822cb 100644
> --- a/drivers/phy/mediatek/phy-mtk-io.h
> +++ b/drivers/phy/mediatek/phy-mtk-io.h
> @@ -39,8 +39,8 @@ static inline void mtk_phy_update_bits(void __iomem *reg, u32 mask, u32 val)
>  /* field @mask shall be constant and continuous */
>  #define mtk_phy_update_field(reg, mask, val) \
>  ({ \
> -       typeof(mask) mask_ = (mask);    \
> -       mtk_phy_update_bits(reg, mask_, FIELD_PREP(mask_, val)); \
> +       BUILD_BUG_ON_MSG(!__builtin_constant_p(mask), "mask is not constant"); \
> +       mtk_phy_update_bits(reg, mask, FIELD_PREP(mask, val)); \
>  })
>
>  #endif
> --
> 2.18.0
>


-- 
Thanks,
~Nick Desaulniers
