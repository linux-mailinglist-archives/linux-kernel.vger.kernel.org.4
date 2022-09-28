Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E345ED6D4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 09:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbiI1Hvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 03:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233853AbiI1Hv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 03:51:27 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D3811D0D0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 00:50:20 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id y8so16172878edc.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 00:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=QiNIg/zYZ38dNte35yIrwLt22pv5Z8LWSBq+qCcfUtU=;
        b=NtzNSjvY4vyAUbLC8Ii0LP3f102njHedYSBGeDzF/hkB810Z7nZG7cmefrAHtpFxhe
         Zp9te2hkWiDhTDlHfjC2QXAsRum0CWIfAidozvY7YrY5zd9bMeLp3BBUkbc21Pm4fwYD
         bKKKOWtXTMb7XcHcBJO0GQJ2gYygtC4R68NE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=QiNIg/zYZ38dNte35yIrwLt22pv5Z8LWSBq+qCcfUtU=;
        b=DjEBASN0D/tNQkw+vweYkY4AJSzDE+wo8tGQDc8/uIjYkE7khMnICPksBfMdc3RR8s
         AsbiEZHmPkudKX4cYAIXhBavV980AdnMF+T0lq3TCB5xAekzEU5HjqUELofcyW+bP0St
         TCm7BAJVG3MQWTrduwOZJVXGCgIL4JAlOJyWhu/e/S0qb7sBqWsJ+ukuYgJPJrcACtP5
         xQ/PJR/EAyz/2uLt8pA0VQobX+i+XSaxduX3ul6AGlO9eQ32IdP23b6OU4rEwxcEtyFv
         JbZW0+xCt+24gKv0cCA7u6PN+GNIRJjEpoMkjLAOjKJuIrWS2JEbXkRLci11iLU4AwjZ
         bGJw==
X-Gm-Message-State: ACrzQf1LP8mMLN03LvPK2Atrd65Bl53dy+0aEp6S2ih76IF5cCYYWgMH
        rTO501UUtKELXxJ/bBm5oxi1PjJuM9AEmPIt4s6ctg==
X-Google-Smtp-Source: AMsMyM6tdHhfxNIYTWCDrGO48E5DQKirqL+MmjRR/T8+Ih7026PNLiu8XfmJTZnxopqbAP43SYNBrqxzsdSO9XaLHp4=
X-Received: by 2002:a05:6402:1298:b0:457:c38a:2f10 with SMTP id
 w24-20020a056402129800b00457c38a2f10mr6387160edv.264.1664351418958; Wed, 28
 Sep 2022 00:50:18 -0700 (PDT)
MIME-Version: 1.0
References: <0a1618c4-b808-56bd-e89f-560b0423191d@collabora.com> <20220928015507.17206-1-miles.chen@mediatek.com>
In-Reply-To: <20220928015507.17206-1-miles.chen@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 28 Sep 2022 15:50:07 +0800
Message-ID: <CAGXv+5FLwrE-kiZ_opjB3NA=e2_tDoNUs6hKE-o9m_DXcQmcGA@mail.gmail.com>
Subject: Re: [PATCH 3/6] clk: mediatek: mt8192: Do not re-register
 top_early_divs in probe function
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     angelogioacchino.delregno@collabora.com,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        matthias.bgg@gmail.com, mturquette@baylibre.com, sboyd@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 9:55 AM Miles Chen <miles.chen@mediatek.com> wrote:
>
> >> top_early_divs are registered in the CLK_OF_DECLARE_DRIVER() half of the
> >> topckgen clk driver. Don't try to register it again in the actual probe
> >> function. This gets rid of the "Trying to register duplicate clock ..."
> >> warning.
> >>
> >> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> >
> >Can't we simply remove the CLK_OF_DECLARE_DRIVER() and top_init_early entirely,
> >and transfer TOP_CSW_F26M_D2 to top_divs[] instead?
> >I get that systimer concern and we have something similar in MT8195, where the
> >TOP_CLK26M_D2 is registered "late".
>
> Another reason for this:
> Removing the CLK_OF_DECLARE_DRIVER() is good when we want to build our driver as
> kernel modules because it does not work with kernel modules.

I agree. But as I mentioned in my other reply, we need to fix the clock
user first before dropping that clock. And there's also the matter of
DT backward compatibility. So we need to do it incrementally.


ChenYu
