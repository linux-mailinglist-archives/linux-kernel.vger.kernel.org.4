Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0225A61066B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 01:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiJ0Xag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 19:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233687AbiJ0Xad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 19:30:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE563F1C5;
        Thu, 27 Oct 2022 16:30:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B059762573;
        Thu, 27 Oct 2022 23:30:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3FAC433D6;
        Thu, 27 Oct 2022 23:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666913430;
        bh=N3/tiBBM65lbA3Kx0jToCOjz1sXOtHVXWYvgKgpiDFc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=iu6ONbFOuNtcJM4mQaxWpdNWxM/V/eSzUpZ73hpm3Qffo2BJqyPDWAqe0OR9TbNOh
         B6erzkAR+KYefBQnqAlUM8ofjzhedfcAsQ1QXRNpCxC8iBexmKJt0eFujzgcVORvLO
         ptEYjNYbC7CBC3v/yVO/a47eUK/wU08m8G/rEi0Jru8z4X302KFe3HCx/B/E2EksS1
         nQm7pGTZlJCCceE2Ma/wWzDQpD5elcc16qEbDL5rxpmLWCohB4x1y9LSIGmLkgnF2M
         gsUfd5eWBCbTN3nxWBKyNUR8izsE3bNEJuJ0hIeYOeIqBFjs7u0ncaNsawDK/qgOYz
         EQRxkyggrj46w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Y1sTM/E1VY+XdHk5@makrotopia.org>
References: <9bde77be-f4ec-11e7-e645-7c4465bcf6db@collabora.com> <5e55012567da74870e1fb2edc2dc513b5821e523.1666801017.git.daniel@makrotopia.org> <20221027214151.7F112C433D6@smtp.kernel.org> <Y1sTM/E1VY+XdHk5@makrotopia.org>
Subject: Re: [PATCH v2] clk: mediatek: fix dependency of MT7986 ADC clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Sam Shih <sam.shih@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>
To:     Daniel Golle <daniel@makrotopia.org>
Date:   Thu, 27 Oct 2022 16:30:27 -0700
User-Agent: alot/0.10
Message-Id: <20221027233030.0F3FAC433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Daniel Golle (2022-10-27 16:24:35)
> On Thu, Oct 27, 2022 at 02:41:49PM -0700, Stephen Boyd wrote:
> > Quoting Daniel Golle (2022-10-26 09:18:07)
> > > It seems like CLK_INFRA_ADC_FRC_CK always need to be enabled for
> > > CLK_INFRA_ADC_26M_CK to work. Instead of adding this dependency to the
> > > mtk-thermal and mt6577_auxadc drivers, add dependency to the clock
> > > driver clk-mt7986-infracfg.c.
> >=20
> > Is this a cleanup patch? Or a pre-requisite for thermal and auxadc
> > drivers? I don't understand the priority of this patch. Should I apply
> > it to fix a regression?
>=20
> I'd say 'no', as AUXADC and thermal has not yet been added to
> mt7986a.dtsi, also the corresponding clocks are currently still unused.
> So while this commit does fix a previous commit, it doesn't have a direct
> impact and will only matter once thermal and auxadc units are added to
> mt7986.dtsi.

Thanks! Please include these details next time.
