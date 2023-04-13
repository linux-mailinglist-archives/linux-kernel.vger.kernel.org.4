Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876C96E07E8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 09:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjDMHjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 03:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjDMHjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 03:39:13 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F96359A
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 00:39:12 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-54f21cdfadbso215471477b3.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 00:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681371551; x=1683963551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=azjEIx4GH14Y1N9b8EmQm9otxWDyzqOgZqFEjVHx4wE=;
        b=Ahf8wKQixFqrhMEyfuMsctrl+NkTUJiyZaJXBtm6a7Mb5H6yRxMTlTpAp27NO6WMMr
         k1vSqlzZnqN0HlkTJEYd5W8CP5GwqQwh1Glh1OVNvMECKQ1niEi2aRRx/Tc1HTaU66Vl
         SlLe/FFrDSA3xfcDGqNK9fYH9nyQ0QqMUMvv44uA0YUFYxrwHL4/119gEF30EmCvK6vr
         qrMy37Gi2mL7dm9t1yyvWhanxrl202DeOY9svx2NfMz33Dt0KHaCuoYZsnKy5Dr6K0Ek
         zkSEpQerd/7Kt2t84BPmOuiWCSGzPHkQNCJJeaPIWV1OjNIKzUacLvoGsFYu+AV4nVW4
         kzBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681371551; x=1683963551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=azjEIx4GH14Y1N9b8EmQm9otxWDyzqOgZqFEjVHx4wE=;
        b=C8iOeLiXe/6l+FNGcZhDsXSGNdrTrfc4Ir35xXUjeg2RySC3bdAriIRFIBiQxRPVjC
         q/GBc9qac9I7j9jHCM4VJydQH3KgK5Dkfv+afuT8WQxLj8/Yr3BgyzCK8BiIpXW4UsyM
         /HcJIBL8YpwE5Rm0U5UBy0fjV3jpGFVJEBQzSgfjC1XMT4DwSNfe3vV7QAItJhwI4d70
         /20CLlyxVHx/ouKr12XHV31rGziDbtpHFK+zNoYoDvqcWvArzdQNoqlZy/HathLX9Mq9
         HdrSvnZ5dcpsNyuzHZOIJV7XIKw91varFBg1wrUL8Qn5S4aH75ZRZzd/VJP3ZXBrq9oF
         i5Ag==
X-Gm-Message-State: AAQBX9d5jqoelzqILqurHJk+znvXat4Oqb1UvUlfkeCb/l7hgCn/c1Up
        Gs+z18COeR851xtpwTy0SCeOY3TJCm814Dz6XQd6JA==
X-Google-Smtp-Source: AKy350Y59eHiC+Gwv7NkE0MLxBEHcIS3XiglOEbI7/MvUm+GiXiAITea2wRpLlaxuDSCQVivjm+Q6Or8PM3fYSh94mg=
X-Received: by 2002:a81:4328:0:b0:545:4133:fc40 with SMTP id
 q40-20020a814328000000b005454133fc40mr748835ywa.9.1681371551508; Thu, 13 Apr
 2023 00:39:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230413073429.40050-1-haibo.li@mediatek.com>
In-Reply-To: <20230413073429.40050-1-haibo.li@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 13 Apr 2023 09:39:00 +0200
Message-ID: <CACRpkdb9sn25KdagSVmY5-XX+LypQdMEj=oBpnwOhYvS2Ny1xA@mail.gmail.com>
Subject: Re: [PATCH v2] ARM:unwind:fix unwind abort for uleb128 case
To:     Haibo Li <haibo.li@mediatek.com>
Cc:     Russell King <linux@armlinux.org.uk>, amergnat@baylibre.com,
        linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
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
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 9:34=E2=80=AFAM Haibo Li <haibo.li@mediatek.com> wr=
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

Thanks Haibo,
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Please put this into Russell's patch tracker once you feel it is finished!
https://www.arm.linux.org.uk/developer/patches/

Yours,
Linus Walleij
