Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0AAB7179A8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 10:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235184AbjEaIKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 04:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235187AbjEaIK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:10:29 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9616393
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 01:10:28 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6af6df840ffso4220442a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 01:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685520628; x=1688112628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ha8WXDq7F6ehlGZN4Wnm79SzuKrgIbv9GmD5p3/ciq4=;
        b=DgBV7q1iFWBDxiVHk9JUFMK901wD1MP+icEW/zcNq51kchIW9/fmxP0NskfzKA04e9
         kTop/smn/jjdxZnRzBEiyWP2WMy0SSyrLpcoG2hW8cO7XgbPfZ8aSYBZLEQ0Vodxjgvu
         7bLrHj8W2DAz+pgxbvT9/QzRwEeDcvRgAIb2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685520628; x=1688112628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ha8WXDq7F6ehlGZN4Wnm79SzuKrgIbv9GmD5p3/ciq4=;
        b=amsk6Xvichs0xJ4pMZVnzf9YEowH8+Qh+Pl+dWjOZwI/Yb9dCKex7UU4Bg8H4Nh5Rh
         khAYuuT8lTt1z2kKhjO/8ub2PYfKFzKmHjCJl8kKFPYUr5iZw4QRbhK03BHaDHR+Umrh
         c1FxJ+mKa/rcpmLjZjhpKAIpBAII9tumWZHvvORBsKqNMoXL7/RbFGHdBSF5WdPingTt
         0k+xauq4BiXumAwlYI8/QbhOH4Vuohk79id7taTW7WkYsJ8rwvyS5EML05zjndX0ZYkj
         rCq96sjOISDSOmdNOOL5lmQnLlaNGI4h4LIGZmX7PRSnf4GjePvwiUfvn8+oqPoSjVdD
         zsuA==
X-Gm-Message-State: AC+VfDwgrcA80MhL8mwet+hxgDpWsODijKtHzTv4wuPsVQ8Jn7XiR9OT
        B2mg1YseGla93eaEN53MgS+YSLO/duBPnTjOtcIMMQ==
X-Google-Smtp-Source: ACHHUZ7rqg56DAcPJ9jkQZEWk9382a7L5h4RC6wgNI04P1u6bH0gTq4NfXck/bmoQRGPPXVH2knI7dLMyJlEpKqSWtU=
X-Received: by 2002:a05:6830:1d6f:b0:6b0:c54c:8247 with SMTP id
 l15-20020a0568301d6f00b006b0c54c8247mr949912oti.24.1685520627954; Wed, 31 May
 2023 01:10:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230220093343.3447381-1-hsinyi@chromium.org> <CAGXv+5E4_k1jKTnninYkuT6Tf=skB00AowHpM+hc8j_VFM-RfQ@mail.gmail.com>
 <CAJMQK-hnK69iVJhqW_8UtKHHLQ3608Cb74Jk_b+xHH0BBu4yVw@mail.gmail.com>
 <d39b0e77-e013-fe7e-9523-9bdbaacb5853@collabora.com> <90ad9b86-e03c-8e80-88d6-d514bbe9cacd@gmail.com>
 <CAJMQK-jmT1YDf0y6FYUUFHkQ0b-ZHD9S4X2zpkrmNoz5Dz4ctQ@mail.gmail.com>
In-Reply-To: <CAJMQK-jmT1YDf0y6FYUUFHkQ0b-ZHD9S4X2zpkrmNoz5Dz4ctQ@mail.gmail.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Wed, 31 May 2023 16:10:01 +0800
Message-ID: <CAJMQK-gWQUgY7NRhkSuk7KMf8XZEBfJZEEXo0S+8ty7Ms7xZ9w@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: mediatek: mt8183: kukui: Add scp firmware-name
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 3:47=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.org> =
wrote:
>
> On Wed, May 31, 2023 at 3:30=E2=80=AFPM Matthias Brugger <matthias.bgg@gm=
ail.com> wrote:
> >
> >
> >
> > On 30/05/2023 09:12, AngeloGioacchino Del Regno wrote:
> > > Il 30/05/23 07:12, Hsin-Yi Wang ha scritto:
> > >> On Tue, Feb 21, 2023 at 11:25=E2=80=AFAM Chen-Yu Tsai <wenst@chromiu=
m.org> wrote:
> > >>>
> > >>> On Mon, Feb 20, 2023 at 5:34 PM Hsin-Yi Wang <hsinyi@chromium.org> =
wrote:
> > >>>>
> > >>>> The upstream SCP firmware path is /lib/firmware/mediatek/mt8183/sc=
p.img
> > >>>>
> > >>>> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > >>>
> > >>> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> > >>
> > >> hi Matthias,
> > >>
> > >> Kindly ping on the patch, thanks!
> > >
> > > Agreed. Matthias, please pick this one.
> > >
> > > Hsin-Yi, can you also please send a version of this patch for stable?
>
> I sent a patch based on stable:
> https://patchwork.kernel.org/project/linux-mediatek/patch/20230531074421.=
888652-1-hsinyi@chromium.org/
>

Archived the above patch. I'll wait for the original patch landed then
send it to stable.

> > >
> >
> > Applied thanks!
>
> Thanks!
