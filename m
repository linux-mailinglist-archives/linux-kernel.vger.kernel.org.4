Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB375EAFA0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 20:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbiIZSWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 14:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiIZSWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 14:22:16 -0400
X-Greylist: delayed 603 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 26 Sep 2022 11:18:47 PDT
Received: from mail-m121145.qiye.163.com (mail-m121145.qiye.163.com [115.236.121.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F9EDEF3;
        Mon, 26 Sep 2022 11:18:47 -0700 (PDT)
Received: from amadeus-VLT-WX0.lan (unknown [218.85.118.195])
        by mail-m121145.qiye.163.com (Hmail) with ESMTPA id 411F88000DC;
        Tue, 27 Sep 2022 02:01:24 +0800 (CST)
From:   Chukun Pan <amadeus@jmu.edu.cn>
To:     linux.amoon@gmail.com
Cc:     heiko@sntech.de, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        michael.riesch@wolfvision.net, robh+dt@kernel.org,
        Chukun Pan <amadeus@jmu.edu.cn>
Subject: Re: [PATCH-next v1] arm64: dts: rockchip: Enable NVM Express PCIe controller on rock3a
Date:   Tue, 27 Sep 2022 02:00:59 +0800
Message-Id: <20220926180102.37614-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220926061420.1248-1-linux.amoon@gmail.com>
References: <20220926061420.1248-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCSEgaVk1PHU8dTk0ZGh5JSlUTARMWGhIXJBQOD1
        lXWRgSC1lBWUlKQ1VDTlVKSkNVSkJOWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVSktLVUtZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6P006Qww*LD0YFAgsKilMSSIq
        Qy9PCS1VSlVKTU1PSUpOSUNPQ0xIVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlK
        Q1VDTlVKSkNVSkJOWVdZCAFZQUlOTEw3Bg++
X-HM-Tid: 0a837af5fb0fb03akuuu411f88000dc
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 26-09-22, 06:14, Anand Moon wrote:

> +	pcie30_3v3: gpio-regulator {
> +		compatible = "regulator-gpio";
> +		regulator-name = "pcie30_3v3";
> +		regulator-min-microvolt = <100000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpios = <&gpio0 RK_PD4 GPIO_ACTIVE_HIGH>;
> +		gpios-states = <0x1>;
> +		states = <100000 0x0>, <3300000 0x1>;
> +	};

This is actually no different from vcc3v3-pcie regulator?

> +&pcie30phy {
> +	data-lanes = <0 1 2 3>;
> +	phy-supply = <&vcc3v3_pi6c_03>;
> +	status = "okay";
> +};

It seems that there is no need to define additional data-lanes when
the pcie3x1 node is not enabled, and phy-supply seems unnecessary on
this board.

Excuse me, can you try the patches I posted? Lspci can recognize
pcie3x2 normally, but I don't have a spare nvme hard drive right
now to test if it works.

Thanks, Chukun

---
Chukun Pan (3):
  arm64: dts: rockchip: Add regulator suffix to ROCK3 Model A
  arm64: dts: rockchip: Rename pinctrl label of pcie2x1 on rock-3a
  arm64: dts: rockchip: Add PCIe v3 nodes to rock-3a

 .../boot/dts/rockchip/rk3568-rock-3a.dts      | 36 ++++++++++++++-----
 1 file changed, 27 insertions(+), 9 deletions(-)

-- 
2.25.1

