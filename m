Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7BB5BBD57
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 12:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiIRKAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 06:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiIRJ7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 05:59:23 -0400
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A46E06;
        Sun, 18 Sep 2022 02:59:19 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1663495156; bh=GhjgtFBnDwq38pLPrNGHQBD/G+iWkmUIYKT3/As9ZJc=;
        h=From:To:Cc:Subject:Date;
        b=ldzxa9jok4Kb04UQIOk7AiM4ZQAwglQLzjSUlyk1Z98Bh63ESFFPkzVJU9e70S0CM
         T9QNwXVv/VjhfbXgiYm39823aHfYFd5Jucz3vErpKqojhorKEK/LT/Sz5F4SKFJWiN
         HNo0Yrot80oPSe85qwqv13ykeE8wzSn983uksGUg=
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
Subject: [PATCH 0/4] Apple ADMAC peripheral reset clean-up
Date:   Sun, 18 Sep 2022 11:58:41 +0200
Message-Id: <20220918095845.68860-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_FAIL,SPF_HELO_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Apple SoCs the ADMAC peripheral shares a reset line with another
audio-related peripheral which is the MCA.

On the side of the MCA, the reset is described in binding (staged in
broonie-sound/for-6.1) and in the soon-to-be-merged series adding new
nodes to t8103/t600x SoC device trees [1]. The staged MCA driver does
make use of the reset, knowing it's a shared one.

This series catches up on the ADMAC side, adds the reset to the binding
and describes it in the t8103/t600x DTs (on top of [1]). It also pulls
the shared reset from the driver.

Since [1] already includes another ADMAC binding change and will
probably be fully merged into Hector's asahi-soc tree, I propose the
binding change here takes the same route. Leaving patches #3 and #4 to
go into dmaengine.

[1] https://lore.kernel.org/asahi/87pmful5r4.wl-maz@kernel.org/T/#t

Martin Povišer (4):
  dt-bindings: dma: apple,admac: Add reset
  arm64: dts: apple: Add ADMAC resets on t8103/t600x
  dmaengine: apple-admac: Do not use devres for IRQs
  dmaengine: apple-admac: Trigger shared reset

-- 
2.33.0

