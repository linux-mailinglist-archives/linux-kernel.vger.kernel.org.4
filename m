Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0628F67CC12
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 14:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236814AbjAZN1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 08:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236210AbjAZN1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 08:27:34 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093896B991;
        Thu, 26 Jan 2023 05:27:12 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-50660e2d2ffso22817977b3.1;
        Thu, 26 Jan 2023 05:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j4qbG6eVB5xuDn3dtmvIgLy/zetvuTGbID3mzZEtD58=;
        b=DbKlCXK9xeHqYSCz4mS0W9lwiZGx22FO3kIPMku2DRhW+F5+qWwuFyUqw7oysb0vp1
         h/60OS6dTjUYnX5Yj/+lm1f4vt8YO+4eCEAKUcAjG+udU/h+Yc8b7eYGTpQ8ZyJPGxkX
         j9SLn5KwdS6HR44ZMiCtFufcuYyCOsv17qPfmStUbdHu1HXS6UUF9wEQUzWbb8m9/c8N
         LX5zyFIdlELEairpgpLune79Jsx/cARzgYUoM8Y9CgcOjevU1/elo17Ml1S4VDzgw/uI
         Yp4S2oPaTr+nPY+5kYfkDkGqMT2iTyNqk3+KnGmQID3WJ5U9qcX4qJ8FcRnwBDUvm03l
         rROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j4qbG6eVB5xuDn3dtmvIgLy/zetvuTGbID3mzZEtD58=;
        b=Q5O1yhHbbCA3HjKsZtuH7fpuxwZRWBUF52NiPwXBAoMg//PZp9g5zac+wNEwUVJOZi
         Xo665pMX/inCG/QWDwwks3eYwyuCod3d+W0SYh1ab5uZrw6vHDlXiCsjdJXSkctUa43m
         zta54Ei44WBYZeO1Ij02UX5VfL+KjmgpwHj7mt/OOh4tww+oA1OIcnb/BoTHjx3YULm8
         3Pk1pY+YVrbn9ZYVJgJxLPAovpWX2a9en7+tJDwhrBePZo6Mjz7z/cUHJLZF69V0RFje
         YtBTaA28LAyNFp+SYgD7d/TrHkSDu1avX14g/H/8qzigs5OLdOEvtcB7pyTnX7sEXMNq
         ossA==
X-Gm-Message-State: AO0yUKXi4/bdH/ICkqEB0zfVw6LFzxazTEtJhTWzi3QQNpuWG5rm5aNK
        GZVr63U2mO0Jo332SEgn+YX3vlBvvaC9aI+wLxc=
X-Google-Smtp-Source: AK7set+Zx9yy/BVXoOqFh45ED3u90etOiIl+eS4ys5iYxouATNh8yE1SOaojHW3o/0YIlMrw6dCi3vFpG5ePZXKDkhs=
X-Received: by 2002:a81:b246:0:b0:506:55d9:3a78 with SMTP id
 q67-20020a81b246000000b0050655d93a78mr824104ywh.339.1674739631151; Thu, 26
 Jan 2023 05:27:11 -0800 (PST)
MIME-Version: 1.0
References: <20230118104656.67706-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20230118104656.67706-1-wsa+renesas@sang-engineering.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 26 Jan 2023 13:26:44 +0000
Message-ID: <CA+V-a8vp-oxaQyzPg2YonshdO-j0z+8vXpqgD=P8w94eDNJDOA@mail.gmail.com>
Subject: Re: [PATCH v2] memory: renesas-rpc-if: Fix PHYCNT.STRTIM setting
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

Thank you for the patch.

I am yet to test this patch on g2l (I'll test v3 as you plan to send it today).

On Wed, Jan 18, 2023 at 10:46 AM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> From: Cong Dang <cong.dang.xn@renesas.com>
>
> According to the datasheets, the Strobe Timing Adjustment bit (STRTIM)
> setting is different on R-Car SoCs, i.e.
>
> R-Car H3 ES1.*  : STRTIM[2:0] is set to 0x0
> R-Car M3 ES1.*  : STRTIM[2:0] is set to 0x6
> other R-Car Gen3: STRTIM[2:0] is set to 0x7
> other R-Car Gen4: STRTIM[3:0] is set to 0xf
>
> To fix this issue, a DT match data was added to specify the setting
> for special use cases.
>
> Signed-off-by: Cong Dang <cong.dang.xn@renesas.com>
> Signed-off-by: Hai Pham  <hai.pham.ud@renesas.com>
> [wsa: rebased, restructured a little, added Gen4 support]
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
<snip>
> +struct rpcif_info {
> +       enum rpcif_type type;
> +       u8 strtim;
> +};
> +
>  struct rpcif {
>         struct device *dev;
>         void __iomem *base;
> @@ -71,6 +76,7 @@ struct rpcif {
>         struct reset_control *rstc;
>         size_t size;
>         enum rpcif_type type;
I think now you can get rid of this member?

Cheers,
Prabhakar
