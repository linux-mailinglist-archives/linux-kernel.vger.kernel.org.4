Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE7874E846
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 09:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjGKHoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 03:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbjGKHou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 03:44:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1367C1A4;
        Tue, 11 Jul 2023 00:44:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A693F6135B;
        Tue, 11 Jul 2023 07:44:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D75AC433C7;
        Tue, 11 Jul 2023 07:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689061489;
        bh=fzY4SPbVj/3yMnNlQmbvE/VH/STLsTGDL1RF3su0iw8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=dL/YYpOZ9353AWN3aGM5uiCHHyo2O5VyjJLKXU57FPFX5v3MWFK/WAb8fwV2AjSvd
         IjUp6tarta5Dx8u0pkN77TUTOmHiU9mhRpznRTDAwmkHkh+nIVkWeh5T947U37whiJ
         oJ9db9YSPFK96gEe++nlxvYUH2FGBk25wA7Bj9XhUJXEJdgQMcTwiQ3ueYIf7Onk3l
         xFkN8h9Dqxffr9ocpDgO9dpBgUGT7vvUjRahukl6fcjt/0kzxvqKDp9PWuSa0CfMkM
         AXl6lvzeonAnzQV5oBIHv9zHznTnz19FbX1+51+QuWyGAVAln5MJaK5D95JrLAIxRi
         RjdSYyORuDNEQ==
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@collabora.com
In-Reply-To: <20230522170324.61349-1-sebastian.reichel@collabora.com>
References: <20230522170324.61349-1-sebastian.reichel@collabora.com>
Subject: Re: [PATCH v3 0/7] phy-rockchip-inno-usb2: add RK3588 support
Message-Id: <168906148486.189433.2848523710050580119.b4-ty@kernel.org>
Date:   Tue, 11 Jul 2023 13:14:44 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 22 May 2023 19:03:17 +0200, Sebastian Reichel wrote:
> This adds RK3588 to the Rockchip Inno USB2 PHY driver. The RK3588 has four of
> them. Two are used for USB2 and two are used by USB3 controllers (for USB2
> fallback mode). All of them can be used with this patchset.
> 
> Changes since PATCHv2:
>  * https://lore.kernel.org/linux-phy/20230403202307.120562-1-sebastian.reichel@collabora.com/
>  * Dropped patch adding the syscon compatible to the DT binding (applied by Heiko)
>  * Collected Reviewed-by from Rob Herring for DT binding patch (DT binding)
>  * Rebased to v6.4-rc1
>  * Removed superfluous init found by Vinod Koul
>  * Added one additional patch improving the error message for missing phy-config
>  * Fixed address_cells=2 code to not break the PHY at offset 0. I didn't notice it with the
>    previous versions, since that PHY is used for USB3 on Rockchip evaluation board and I
>    only started working on that recently.
> 
> [...]

Applied, thanks!

[1/7] dt-bindings: phy: rockchip,inno-usb2phy: add rk3588
      commit: 26720f89ee6878ef505812e852a3e914b7cbfe44
[2/7] phy: phy-rockchip-inno-usb2: add rk3588 support
      commit: 52b99b871eb79637342660b46c900642483d4412
[3/7] phy: phy-rockchip-inno-usb2: add reset support
      commit: 44d88aa9ae81c79ccc47ba4ef85aeda968bc4a50
[4/7] phy: phy-rockchip-inno-usb2: add rk3588 phy tuning support
      commit: 7d508a92e4588a59b909e235667d515051dd5955
[5/7] phy: phy-rockchip-inno-usb2: simplify phy clock handling
      commit: f4ca578b9803601074ab0d9e366b5fcda504e5a6
[6/7] phy: phy-rockchip-inno-usb2: simplify getting match data
      commit: 2e5ead8478e8e4a7b3d63a2001c2f0022b2f5e1b
[7/7] phy: phy-rockchip-inno-usb2: improve error message
      commit: e7254a4a7c444fa194440fa8dc73c7728e927162

Best regards,
-- 
~Vinod


