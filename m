Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71B86E1D04
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 09:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjDNHTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 03:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjDNHTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 03:19:46 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED32F5FE4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 00:19:44 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id a13so17990114ybl.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 00:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681456784; x=1684048784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EPgTIbc3EmpS1tMla467skczJbzj4giN96ys9JA7Z/0=;
        b=cpzjVOhBclo5s7FOOCTsY9OXyCmdSzWInAqJyhp5jNfDqdTp2N2ndOvxaEirmRdSf6
         zjaJBiCEDcSvMGPu1p1UOKpttTZ/o1lXjrjpYKd+lubBYRMFfvK653NH0n95uAsnzuuH
         zQJowLAx7ESro4J0VCC1EyOUFhLUePYJIcxYT5el3eqOsRQtcf5Js6koa3/Ohb0EafTP
         XrAss8mrfMvjUKBN/eqzobuLLn+Sdh2d9cz1Ax/JvZjSF+KDm3GN7Z2y3Bkk3kZTlEGR
         QG0ogOVqT3BCmwv6whN5FGfNsrQcIs6oDLXTmSn0SdMVKQRJmamkS0Jo05FzQKUjt0yK
         /hug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681456784; x=1684048784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EPgTIbc3EmpS1tMla467skczJbzj4giN96ys9JA7Z/0=;
        b=dwFv5l7+BGaxB76MryG4+iLEQ8+FNo+YrjelmWyGj33wp0JJ4N2CUBrxsbR688WKyd
         3t/u3uIjXtgAEWwEiPXnSEjPPHHH0xNiF3D/7Y5K9o1iqA40Tns09EBOzPrDX+sq2TuV
         WNL/gWh02fLDIjDGZGhGatbXeYM6gdUSo6cbYX/aYUZkfmFS+IE/UiWpU46ZB3Bu8A0N
         yq5kWeRQgO90rZp/w0DPlEEn0VLP2hjj1qMamPWONIYGxZcQ3aegW96qIQykukPpKdrm
         1jjUhgDnbVV8KlgU9rdojN6eXkeN2bsUCN07oV/mSZrsSr1oBxCxqL2mf2YS995S7ZuP
         ZTrA==
X-Gm-Message-State: AAQBX9e2v9gxPBzlVkJyVq5Wpx7zg8iG85Gsoi7UdM0aPbB60TrQJMSY
        UUR9DcBKCOZPnfJHxg6IZg0uBkdlhu1Kwt82hgULfg==
X-Google-Smtp-Source: AKy350YKBDdF1IQraLtOT04N0F8XhTSVbdBO27R039XWq6ktIy204ErJfr84QLAyzDRtp3dBfvTyD07G8R9iSV9ap+s=
X-Received: by 2002:a25:d44a:0:b0:b8e:fbcb:d6ef with SMTP id
 m71-20020a25d44a000000b00b8efbcbd6efmr3297133ybf.4.1681456784107; Fri, 14 Apr
 2023 00:19:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230414061031.141430-1-haibo.li@mediatek.com>
In-Reply-To: <20230414061031.141430-1-haibo.li@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 14 Apr 2023 09:19:32 +0200
Message-ID: <CACRpkdZf0vQL9bJtGaKfn0wBPTQTZWsg0G7UTB1dmXhfi_2KmA@mail.gmail.com>
Subject: Re: [PATCH v3] ARM:unwind:fix unwind abort for uleb128 case
To:     Haibo Li <haibo.li@mediatek.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, amergnat@baylibre.com,
        linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        xiaoming.yu@mediatek.com,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Alex Sverdlin <alexander.sverdlin@nokia.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, ardb@kernel.org,
        catalin.marinas@arm.com, a.anurag@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 8:10=E2=80=AFAM Haibo Li <haibo.li@mediatek.com> wr=
ote:

> When unwind instruction is 0xb2,the subsequent instructions
> are uleb128 bytes.
> For now,it uses only the first uleb128 byte in code.
>
> For vsp increments of 0x204~0x400,use one uleb128 byte like below:
> 0xc06a00e4 <unwind_test_work>: 0x80b27fac
>   Compact model index: 0
>   0xb2 0x7f vsp =3D vsp + 1024
>   0xac      pop {r4, r5, r6, r7, r8, r14}
>
> For vsp increments larger than 0x400,use two uleb128 bytes like below:
> 0xc06a00e4 <unwind_test_work>: @0xc0cc9e0c
>   Compact model index: 1
>   0xb2 0x81 0x01 vsp =3D vsp + 1032
>   0xac      pop {r4, r5, r6, r7, r8, r14}
> The unwind works well since the decoded uleb128 byte is also 0x81.
>
> For vsp increments larger than 0x600,use two uleb128 bytes like below:
> 0xc06a00e4 <unwind_test_work>: @0xc0cc9e0c
>   Compact model index: 1
>   0xb2 0x81 0x02 vsp =3D vsp + 1544
>   0xac      pop {r4, r5, r6, r7, r8, r14}
> In this case,the decoded uleb128 result is 0x101(vsp=3D0x204+(0x101<<2)).
> While the uleb128 used in code is 0x81(vsp=3D0x204+(0x81<<2)).
> The unwind aborts at this frame since it gets incorrect vsp.
>
> To fix this,add uleb128 decode to cover all the above case.
>
> Signed-off-by: Haibo Li <haibo.li@mediatek.com>

Way to go, remember to collect all the Reviewed-by tags before
you put the patch into Russell's patch tracker.

Yours,
Linus Walleij
