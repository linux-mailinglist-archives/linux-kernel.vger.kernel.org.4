Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582E56104A2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 23:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236527AbiJ0Vl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 17:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236117AbiJ0Vly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 17:41:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7CB4B4A0;
        Thu, 27 Oct 2022 14:41:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E82B3B827DE;
        Thu, 27 Oct 2022 21:41:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F112C433D6;
        Thu, 27 Oct 2022 21:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666906911;
        bh=+bqMYfhBoMQBNclMwiXInuF4126VdbEDPwSYcMlTatk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=CJRlxu66YR1gJs+s/NRcf9oKssdDMmsNjr8UoEhMmO0BXaC5th/zLePkc9dB6Kfk1
         x6OmBiPkcO1KJDdZsxscaN8ZlqWvZdoHZbgds/k2Bvmgj9Dl3Yb9Cl946pyKrj2rat
         hJHXHbwRo0MRo9ApgPkb4JO8xANJvDN8P5wR7cSjTWZEe5PmONuVZ7Y1GuEt0HcG6e
         lbK6VL4KcBv7hSwPl2IRLroc1paBs4BmP9IMRzPc/BZ3xeTBHlOLDamhgj8NTRcuhL
         jiHOk3G3pyDA5u5k6bnWMVP2zIMEJ+P9TxPvw7uzqzOX0iica03IJcc2g0VXYzlm1r
         a/PEVvzF7+4bg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <5e55012567da74870e1fb2edc2dc513b5821e523.1666801017.git.daniel@makrotopia.org>
References: <9bde77be-f4ec-11e7-e645-7c4465bcf6db@collabora.com> <5e55012567da74870e1fb2edc2dc513b5821e523.1666801017.git.daniel@makrotopia.org>
Subject: Re: [PATCH v2] clk: mediatek: fix dependency of MT7986 ADC clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Sam Shih <sam.shih@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>
To:     Daniel Golle <daniel@makrotopia.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Date:   Thu, 27 Oct 2022 14:41:49 -0700
User-Agent: alot/0.10
Message-Id: <20221027214151.7F112C433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Daniel Golle (2022-10-26 09:18:07)
> It seems like CLK_INFRA_ADC_FRC_CK always need to be enabled for
> CLK_INFRA_ADC_26M_CK to work. Instead of adding this dependency to the
> mtk-thermal and mt6577_auxadc drivers, add dependency to the clock
> driver clk-mt7986-infracfg.c.

Is this a cleanup patch? Or a pre-requisite for thermal and auxadc
drivers? I don't understand the priority of this patch. Should I apply
it to fix a regression?
