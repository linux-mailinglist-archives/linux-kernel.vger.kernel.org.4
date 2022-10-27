Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81454610656
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 01:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbiJ0XZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 19:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235438AbiJ0XZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 19:25:05 -0400
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA823FF24;
        Thu, 27 Oct 2022 16:24:53 -0700 (PDT)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.94.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1ooCEq-0006Aq-KP; Fri, 28 Oct 2022 01:24:40 +0200
Date:   Fri, 28 Oct 2022 00:24:35 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Sam Shih <sam.shih@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v2] clk: mediatek: fix dependency of MT7986 ADC clocks
Message-ID: <Y1sTM/E1VY+XdHk5@makrotopia.org>
References: <9bde77be-f4ec-11e7-e645-7c4465bcf6db@collabora.com>
 <5e55012567da74870e1fb2edc2dc513b5821e523.1666801017.git.daniel@makrotopia.org>
 <20221027214151.7F112C433D6@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027214151.7F112C433D6@smtp.kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 02:41:49PM -0700, Stephen Boyd wrote:
> Quoting Daniel Golle (2022-10-26 09:18:07)
> > It seems like CLK_INFRA_ADC_FRC_CK always need to be enabled for
> > CLK_INFRA_ADC_26M_CK to work. Instead of adding this dependency to the
> > mtk-thermal and mt6577_auxadc drivers, add dependency to the clock
> > driver clk-mt7986-infracfg.c.
> 
> Is this a cleanup patch? Or a pre-requisite for thermal and auxadc
> drivers? I don't understand the priority of this patch. Should I apply
> it to fix a regression?

I'd say 'no', as AUXADC and thermal has not yet been added to
mt7986a.dtsi, also the corresponding clocks are currently still unused.
So while this commit does fix a previous commit, it doesn't have a direct
impact and will only matter once thermal and auxadc units are added to
mt7986.dtsi.
