Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8656BBB90
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 18:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbjCOR6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 13:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjCOR6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 13:58:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B0759E6A;
        Wed, 15 Mar 2023 10:58:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8E3E1B81EC5;
        Wed, 15 Mar 2023 17:58:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 448C8C433D2;
        Wed, 15 Mar 2023 17:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678903127;
        bh=opfk99RIiIUh2uFqleYgDk2/kNdpAT1Wq7/Pq8VrxR4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nIMoo987szyyVdK2q+snILgdA/DtUowMQFKM8Z/QEkph96cbaQ5mIGN4VxCvVhu9h
         xQhRxC/rwJ4zoTed4lridrdU1I10hTSLDb9XUUxdqUHIBmw9Ebyo9fVwmaVNycxQ/S
         toXSW1kI+bWBUj3DRDMUMoWupul6Mk65HqU73vbSC8LlDfyt2MHJj/oXdklbfXP107
         DfXlc72AEBkwnoxGNiyltjb4LSI5i1wf+N63FZdfj7mqIq+S/cjBRGFSJjRzIffw7t
         zqD2X18vmUPuzjp28HD/N5p3hjEJQOEzR17sG2Of2BPl1RD/CCgMSSoDRl0icehh1a
         +Q9V6CK9IQgPQ==
Date:   Wed, 15 Mar 2023 17:58:41 +0000
From:   Lee Jones <lee@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv7 08/11] mfd: rk8xx: add rk806 support
Message-ID: <20230315175841.GL9667@google.com>
References: <20230307153617.643260-1-sebastian.reichel@collabora.com>
 <20230307153617.643260-9-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230307153617.643260-9-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Mar 2023, Sebastian Reichel wrote:

> Add support for SPI connected rk806, which is used by the RK3588
> evaluation boards. The PMIC is advertised to support I2C and SPI,
> but the evaluation boards all use SPI. Thus only SPI support is
> added here.
>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/mfd/Kconfig       |  14 ++
>  drivers/mfd/Makefile      |   1 +
>  drivers/mfd/rk8xx-core.c  |  69 ++++++-
>  drivers/mfd/rk8xx-spi.c   | 124 ++++++++++++
>  include/linux/mfd/rk808.h | 409 ++++++++++++++++++++++++++++++++++++++
>  5 files changed, 614 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/mfd/rk8xx-spi.c

For my own reference (apply this as-is to your sign-off block):

Acked-for-MFD-by: Lee Jones <lee@kernel.org>

Can't apply the set though, as you're still missing Acks.

Please ping me once we have them all.

--
Lee Jones [李琼斯]
