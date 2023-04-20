Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321CF6E9674
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 15:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjDTN7w convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 20 Apr 2023 09:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbjDTN7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 09:59:48 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA1610F1;
        Thu, 20 Apr 2023 06:59:47 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-54fe3cd445aso42781797b3.5;
        Thu, 20 Apr 2023 06:59:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681999186; x=1684591186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SVfYoaULgv71tF/zxD/TKaMAx1hJmnu6fpoGpjXYABs=;
        b=UF3MZhOmI1V8LjXRQcscOaZ6UpkRn9R0ePC16fXlYkNeydb5gg6DmxdAXZsxRVvzFx
         e59I6yAhxBbOfzmmMuwIzVg7hu3ACoy8+qPSTwTdQx/210YgOb6hK0kDbQS/fuzwEk1T
         vD/+flk0LznIJ3FgzftlftcFpKsGBmbhnB/jat29ePtgcToAG6if1iguJ2d9KngFixwG
         fWWWiGm4eOTKkQ21oSi4k62n3ddsxb/n679wHpe1Sj8U+tS7PY9z4D7NGs7YU90oeY55
         juyE4V/aen1UhcXS63QBSs6pLW7FWwarvUIdrC27eHRQEMumse1tA4gsawiFKq3oL/uu
         mA2g==
X-Gm-Message-State: AAQBX9eCkC0p9qDh2E2GHOw74PcbneIXJDgBc95SkSSAVas82+TxLR4o
        X97ro80/qo5RZsT/nJYEUCcbp/Zh1Cs57GeR
X-Google-Smtp-Source: AKy350ZkLcyg8YRsi9IZkdbzNs/GkKHEDKF30awE7txdZaJav7sTd7K3UOdpn0Xt13SPNrpxK/zQWA==
X-Received: by 2002:a81:6d54:0:b0:541:9ac1:f5a9 with SMTP id i81-20020a816d54000000b005419ac1f5a9mr879372ywc.2.1681999186714;
        Thu, 20 Apr 2023 06:59:46 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id s126-20020a815e84000000b00545a08184cesm349163ywb.94.2023.04.20.06.59.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 06:59:46 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-555e170df98so41909687b3.10;
        Thu, 20 Apr 2023 06:59:46 -0700 (PDT)
X-Received: by 2002:a0d:d68f:0:b0:541:6d79:9291 with SMTP id
 y137-20020a0dd68f000000b005416d799291mr791288ywd.43.1681999186107; Thu, 20
 Apr 2023 06:59:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230419130234.44321-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20230419130234.44321-1-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 20 Apr 2023 15:59:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWWBnEcdZzn-cPNo8iMLgQHxmXp+B6PJBQH5FvLSPXayQ@mail.gmail.com>
Message-ID: <CAMuHMdWWBnEcdZzn-cPNo8iMLgQHxmXp+B6PJBQH5FvLSPXayQ@mail.gmail.com>
Subject: Re: [PATCH v4] memory: renesas-rpc-if: Fix PHYCNT.STRTIM setting
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Cong Dang <cong.dang.xn@renesas.com>,
        Hai Pham <hai.pham.ud@renesas.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 3:02 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> According to the datasheets, the Strobe Timing Adjustment bit (STRTIM)
> setting is different on R-Car SoCs, i.e.
>
> R-Car M3 ES1.*  : STRTIM[2:0] is set to 0x6
> other R-Car Gen3: STRTIM[2:0] is set to 0x7
> other R-Car Gen4: STRTIM[3:0] is set to 0xf
>
> To fix this issue, a DT match data was added to specify the setting
> for special use cases.
>
> Signed-off-by: Cong Dang <cong.dang.xn@renesas.com>
> Signed-off-by: Hai Pham  <hai.pham.ud@renesas.com>
> [wsa: rebased, restructured, added Gen4 support]
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>
> Change since v3:
> * rebased to latest changes in the driver
>
> The previous version was already reviewed by Geert and tested by
> Prabhakar. Since the rebase for v4 was not super trivial, I decided to
> drop the tags. It would be great if you could have another look. Thank
> you already. Happy hacking!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
