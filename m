Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214E471846B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 16:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237597AbjEaOMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 10:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237592AbjEaOM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 10:12:28 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD70630E0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 07:09:41 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-53404873a19so3492474a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 07:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685542115; x=1688134115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0vEqY/E4kBl9Nf1zMfIIL6jodud4pGK1JF+jErJgfEs=;
        b=k6TqpBWFY3kgumCchnSoLKDuzJoNIjmOgiWSI2Uq5X1d2ePEt1noJu/tbgvPDWj3RY
         yJbrgTeZxf9Su+S1w/JyDansZkghP/8xEt5vkez9NA1q8J3BFQicz0pCjD+KFmAgkY6K
         i9ny6ABrmrN2ti11Ejv6wNKbZ+EKi2w7BzMF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685542115; x=1688134115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0vEqY/E4kBl9Nf1zMfIIL6jodud4pGK1JF+jErJgfEs=;
        b=SBjv/+FVAKMAtPPPAf6GUmVHPTRe4MWJDyf2a+29bMB0XAZ1M70WHUahOH28/p2oxK
         BugWwlnYoscH0NJS+Y/6IVGwJ/vn23/TGR3Q4i4C/KKy7+xwZ6ixjrGDfUlPjBbqNZkr
         Pu0fkLi1DW5m8W0aos6oeQ1apxLk/UYgbnONXB2VR0vVb0bpu/9ltrJo5L8VCIG5j2lk
         xiicDN67naOVlcdDd4Oou9/9/TgZC63p3raQgChgxYHBhmpMSPJOwEnmfjQFxTNvBtet
         gJlqvMihOMz1qPcLCfYQeVD68+0rK03DVa1Qo3Oi5cgisX/YmAM0e4LLfQ4Nsexstsr1
         TDHg==
X-Gm-Message-State: AC+VfDxs/UjnOpbYM4xexQ4a+ZZmC5NswGQRlO8ChicGNqQZYLzOmgl0
        //W+D9+fW7By2deFrFZS1yb5h3xVoFO1GbQSba8=
X-Google-Smtp-Source: ACHHUZ7xNTZj9Q0JRzEeLAGmfgjH6A93IymZV7GAS0ccrm6sU1+Hb0ksiRYge5FnnV5o/dhwqndKWw==
X-Received: by 2002:a17:90a:7d15:b0:24d:ee34:57b6 with SMTP id g21-20020a17090a7d1500b0024dee3457b6mr4416306pjl.41.1685541528781;
        Wed, 31 May 2023 06:58:48 -0700 (PDT)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com. [209.85.214.172])
        by smtp.gmail.com with ESMTPSA id j8-20020a654d48000000b0050f93a3586fsm1227541pgt.37.2023.05.31.06.58.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 06:58:48 -0700 (PDT)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1ac65ab7432so162955ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 06:58:47 -0700 (PDT)
X-Received: by 2002:a17:903:7cb:b0:1ab:2763:e003 with SMTP id
 ko11-20020a17090307cb00b001ab2763e003mr110372plb.17.1685541527389; Wed, 31
 May 2023 06:58:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230531134020.3383253-1-sashal@kernel.org> <20230531134020.3383253-12-sashal@kernel.org>
In-Reply-To: <20230531134020.3383253-12-sashal@kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 31 May 2023 06:58:35 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WpsV8hZBkHVbVCSkatnkGN=oMebEGykGDvaOr+2yyikQ@mail.gmail.com>
Message-ID: <CAD=FV=WpsV8hZBkHVbVCSkatnkGN=oMebEGykGDvaOr+2yyikQ@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.3 12/37] irqchip/gic-v3: Disable pseudo NMIs on
 Mediatek devices w/ firmware issues
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Julius Werner <jwerner@chromium.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de,
        matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 31, 2023 at 6:40=E2=80=AFAM Sasha Levin <sashal@kernel.org> wro=
te:
>
> From: Douglas Anderson <dianders@chromium.org>
>
> [ Upstream commit 44bd78dd2b8897f59b7e3963f088caadb7e4f047 ]
>
> Some Chromebooks with Mediatek SoCs have a problem where the firmware
> doesn't properly save/restore certain GICR registers. Newer
> Chromebooks should fix this issue and we may be able to do firmware
> updates for old Chromebooks. At the moment, the only known issue with
> these Chromebooks is that we can't enable "pseudo NMIs" since the
> priority register can be lost. Enabling "pseudo NMIs" on Chromebooks
> with the problematic firmware causes crashes and freezes.
>
> Let's detect devices with this problem and then disable "pseudo NMIs"
> on them. We'll detect the problem by looking for the presence of the
> "mediatek,broken-save-restore-fw" property in the GIC device tree
> node. Any devices with fixed firmware will not have this property.
>
> Our detection plan works because we never bake a Chromebook's device
> tree into firmware. Instead, device trees are always bundled with the
> kernel. We'll update the device trees of all affected Chromebooks and
> then we'll never enable "pseudo NMI" on a kernel that is bundled with
> old device trees. When a firmware update is shipped that fixes this
> issue it will know to patch the device tree to remove the property.
>
> In order to make this work, the quick detection mechanism of the GICv3
> code is extended to be able to look for properties in addition to
> looking at "compatible".
>
> Reviewed-by: Julius Werner <jwerner@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Link: https://lore.kernel.org/r/20230515131353.v2.2.I88dc0a0eb1d9d537de61=
604cd8994ecc55c0cac1@changeid
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/irqchip/irq-gic-common.c |  8 ++++++--
>  drivers/irqchip/irq-gic-common.h |  1 +
>  drivers/irqchip/irq-gic-v3.c     | 20 ++++++++++++++++++++
>  3 files changed, 27 insertions(+), 2 deletions(-)

Please delay picking this across all stable versions unless until you
can also get Marc's fix:

https://lore.kernel.org/r/168544149933.404.717399647227994720.tip-bot2@tip-=
bot2

-Doug
