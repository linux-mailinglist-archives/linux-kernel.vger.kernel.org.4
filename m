Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59DC69FAC7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 19:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjBVSJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 13:09:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjBVSJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 13:09:05 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B191B338;
        Wed, 22 Feb 2023 10:09:03 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1pUtY2-0008Ja-2A;
        Wed, 22 Feb 2023 19:08:58 +0100
Date:   Wed, 22 Feb 2023 18:08:50 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Edward-JW Yang <edward-jw.yang@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>
Subject: [PATCH RFC 0/4] clk: mediatek: de-duplicate MT798x drivers
Message-ID: <cover.1677089171.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

De-duplicate the clock drivers of MT7981 and MT7986 which currently both
implement identical drivers and bindings for apmixed and ethsys.

Daniel Golle (4):
  dt-bindings: clock: rename mt7986-clk.h to mediatek,mt7986-clk.h
  dt-bindings: clock: break out mediatek,ethsys into its own header
  dt-bindings: clock: break out mediatek,filogic-apmixed
  clk: mediatek: de-duplicate MT7981 and MT7986 clock drivers

 arch/arm64/boot/dts/mediatek/mt7986a.dtsi     |   4 +-
 drivers/clk/mediatek/Kconfig                  |  16 +--
 drivers/clk/mediatek/Makefile                 |   3 +-
 drivers/clk/mediatek/clk-mt7981-apmixed.c     | 104 ---------------
 drivers/clk/mediatek/clk-mt7981-eth.c         | 119 ------------------
 drivers/clk/mediatek/clk-mt7986-apmixed.c     |   3 +-
 drivers/clk/mediatek/clk-mt7986-eth.c         |   5 +-
 drivers/clk/mediatek/clk-mt7986-infracfg.c    |   2 +-
 drivers/clk/mediatek/clk-mt7986-topckgen.c    |   2 +-
 include/dt-bindings/clock/mediatek,ethsys.h   |  32 +++++
 .../clock/mediatek,filogic-apmixed.h          |  21 ++++
 .../dt-bindings/clock/mediatek,mt7981-clk.h   |  28 -----
 .../{mt7986-clk.h => mediatek,mt7986-clk.h}   |  33 -----
 13 files changed, 69 insertions(+), 303 deletions(-)
 delete mode 100644 drivers/clk/mediatek/clk-mt7981-apmixed.c
 delete mode 100644 drivers/clk/mediatek/clk-mt7981-eth.c
 create mode 100644 include/dt-bindings/clock/mediatek,ethsys.h
 create mode 100644 include/dt-bindings/clock/mediatek,filogic-apmixed.h
 rename include/dt-bindings/clock/{mt7986-clk.h => mediatek,mt7986-clk.h} (85%)


base-commit: 465461cf48465b8a0a54025db5ae2b3df7a04577
prerequisite-patch-id: ceeb7db2c1fd61fb42cd8957c631cee860e93ce6
prerequisite-patch-id: 8177adab61ca090036e9530c6659e6a695b3465b
prerequisite-patch-id: 5be9edd84fdd605ddbce41e3549dcc45a5dec065
prerequisite-patch-id: f3b34cb1ac47fce75669f8930bb9c7cf51173f14
prerequisite-patch-id: e07c2da0b595e06e20a0e0f110574abee914e4e6
prerequisite-patch-id: 44c460fb1c21f3ce5243e73802848fb7399e25e1
prerequisite-patch-id: 6e40d74d059a7fbac2bced10450834693925ce6e
prerequisite-patch-id: fc7b0c4d46471ef1376563ff26d772f4f1007354
prerequisite-patch-id: 8c1013997127e42ffbce8dbef427fbc33542ad13
prerequisite-patch-id: b8f3637fa6eb5f957d69cdb3aca74e38c9c07067
prerequisite-patch-id: 76b2c868e0a03c9450fb54d52e22a67a2dba69b0
prerequisite-patch-id: 1548b80484e87d7f1abea1125800d858d0f2403e
prerequisite-patch-id: 48e88001f2f28b1118d2ed396dc8663b8f26e4a9
prerequisite-patch-id: 8000474f161383df7e251b5bf9ab784adaee217f
prerequisite-patch-id: 2f16b9acc6eb449f34d068b2c56881b8b7290fdd
prerequisite-patch-id: de5edd84a9670d71e09f1fe9552393eb5743b400
prerequisite-patch-id: f94d08f15852db8310edb7223f77e0489cbd9321
prerequisite-patch-id: 868a7466fb0c4ec62da2ec89508a01be9fff179c
prerequisite-patch-id: 00730054a7236f404c76146a3f673f0d2f4868c9
prerequisite-patch-id: d257c09664fa98359ff61d82fcfcec532bfeeb1c
prerequisite-patch-id: caefec1f1926064267a9758ff43716c4841a603b
prerequisite-patch-id: 5eb5b957c4cdc763503917a0117e84837b8ae388
prerequisite-patch-id: 82a30502cf7bb3be5d69aefa0b2e076c9ca3fe4b
prerequisite-patch-id: f90f07ca0ce16a92ef293d9a96387d53dc09ca0b
prerequisite-patch-id: 80c10691a10fd966455fc6092fe82317fb0dd758
prerequisite-patch-id: 3972de64dfba1e56f85bcc1ba5550a70c982f43d
prerequisite-patch-id: b7e0f82550d9bb9e1e00b93be5cb8989ca81584e
prerequisite-patch-id: cb062cae596f04fa230b02610b88eb26670102df
prerequisite-patch-id: 515bfc7c97e88f974828c3524adc2903d1260f84
prerequisite-patch-id: d0d46c40c8ebd3d89a2b6d1c513cd5223d303aed
prerequisite-patch-id: fc721d9f0827e72f9cf57aaf54737c4dae24958a
prerequisite-patch-id: 7a4abf0b279dafdadd2fcee0c7a3a6f194fd2c6a
prerequisite-patch-id: 799def98b3d5d627361a1d7317f163da1042d31e
prerequisite-patch-id: a06eada68d8df69bb01584259b9f979e597b5e10
prerequisite-patch-id: 59d1fb7b50f114c0c0b5bd72c8899eb2e027a0f7
prerequisite-patch-id: 075ca4cd1b629372da648f64aa5c25e08a4bab7f
prerequisite-patch-id: b50e1eee096ff953857ddc1fa1282dd0f02d9011
prerequisite-patch-id: 7880d7bff472a9d7be05ca850f57b3732d14a528
prerequisite-patch-id: a065a5cc778d4fffc075380664db19c66e31f2e6
prerequisite-patch-id: 626195d174bc2949cffc78d87842dafb6942582b
prerequisite-patch-id: 0adfaee05c4d63dc2485d27033e0a3b2c5e47a83
prerequisite-patch-id: f23873067d2d091c548e5243030ac78a58aaee90
prerequisite-patch-id: 6c04d2ddf8b5637005bf6d836844c1876d1fc63b
prerequisite-patch-id: 91a5547d414331b6a2298cbb89644f3419e034ed
prerequisite-patch-id: d86d637982c0291c6a119a405f73a524079f1e2b
prerequisite-patch-id: 7939592d75ea6116aa8f443cdd9ccd27d33b21f4
prerequisite-patch-id: 321885b121f994df4221dbed5f8baf29a9c7ed14
prerequisite-patch-id: e647d85bf26bd1a57e1c66b524dddb532bc1e8c3
prerequisite-patch-id: 62b77fcedec3b9fbe8218d50b7ce1c59d28fb22b
prerequisite-patch-id: cf874372d08ba777eff0f277b962cddb3e098b27
prerequisite-patch-id: 2a5297a2487c569aeb8e573a27403329f542668d
prerequisite-patch-id: 492ae600b9735f09078fe5609007b6eab12c607b
prerequisite-patch-id: cea4b90736aac50de029a522065b3a07dd4e6806
prerequisite-patch-id: 7bd9b546413ba6e51ab4fbf114b3b3b482d655f0
prerequisite-patch-id: 4b68cf65d12190baf0c318e8a0216c61f4530190
prerequisite-patch-id: 7f8a615a336647833fb850d1d6b2df0a8a179764
prerequisite-patch-id: c527878538e7354e4415e5377e5b8dc1df29a133
prerequisite-patch-id: 80e87bad829109c689a434fd4472a6581214dbdd
prerequisite-patch-id: f012323e2660848fd632cd3e81f7615eeb59e8b3
prerequisite-patch-id: 0e2f416ceb7d63f38716a8dde538be470730a03c
prerequisite-patch-id: f7486faf67dd58ccc8a66c0223c750e46e606aa9
prerequisite-patch-id: 6c0adf953d24beeb10a69271f67f02f04aed0557
prerequisite-patch-id: 2874d9fd1f25330b8289355ce7779d07e06b8e72
prerequisite-patch-id: 4e79d87ec8d6333acbd56518498ef1c534d8b335
prerequisite-patch-id: eaeae891a94558adfdbb5a9bd4ba6a814c87ed14
prerequisite-patch-id: a1507dae703d9b3f1efaff16ee68faf843915ddc
prerequisite-patch-id: 2e950207f770586955407f37d7db07e89ab74e25
prerequisite-patch-id: 6340f8d7504b060fdcf80f28e97b73ece07d455a
prerequisite-patch-id: e1363c47900da76318dc296d14872356165c64fb
prerequisite-patch-id: 06c1e808d5fbda6ce36fbd6e8e4f1d462a918571
prerequisite-patch-id: 00bbd72f44fec6e5eafb7a9cd722b7f9f5c7c046
prerequisite-patch-id: 7a7a13d35a61c371e9db9b5d54160b2f5518bfaf
prerequisite-patch-id: 6bdba51dd13c2ff45ae95e637d7ca8eb9b14151b
prerequisite-patch-id: e364ceb63b07690c38aea6deb3ceff63ac5cef2b
prerequisite-patch-id: b4640a242eb9685c893dc53256a214acf171286c
prerequisite-patch-id: f42503b684358d892322f8e962497e7ef9a9601e
prerequisite-patch-id: 923dae5cdad6c0a206f4f012d8a530060a185301
prerequisite-patch-id: 298b7397c7f7217b0fffeb81a9d7b48edf14a4ce
prerequisite-patch-id: 14b3e261d25504369ba57252df6f3c5b36f1010c
prerequisite-patch-id: 26d665980eeb62a124e670d313c112a4b49f01db
prerequisite-patch-id: 1cb884c6722f333f29bffa6c475716d4c3137b6f
prerequisite-patch-id: cceb5e6e457ec5080fe058820afb953f731157d8
prerequisite-patch-id: f50ee5d7569ef9f1411bce25f81ecb0038394a8e
prerequisite-patch-id: a657ad5481c9952596b6060829b73af9b090ce5a
prerequisite-patch-id: 7ce097322d6f192a16cfb00b16255ab801ca21ce
prerequisite-patch-id: 65d24f1aabaaec350ae77aac4e467d148a5a2cbf
prerequisite-patch-id: 5b6e1e6c3518b32dade8a6ca3d69c0f61e799933
prerequisite-patch-id: 02b15174b3e236d185525fde725bd98e34330662
prerequisite-patch-id: ae41f9a06930cc9c694fdf29c4a48f6dc9d19cb4
prerequisite-patch-id: 3ca558522d37d83d4391964ada3c03fbfff29bc9
prerequisite-patch-id: 7fa978574aff41a768dadc5a42a1a90641b12627
prerequisite-patch-id: f715f8e1d098f9ee698b05c7e6cece9595d703e7
prerequisite-patch-id: 65b133f26b360b1ac29c8961e4116a1dccf78eb1
prerequisite-patch-id: 10ce8d9a031627b177290bb2fb6e03143d4576ac
prerequisite-patch-id: 3170f7b80906d9bae95654c685089d298becaf30
prerequisite-patch-id: 40f432b1b38a5cf0803b0e476c7c58bced7c2f6b
prerequisite-patch-id: f4a5dca419829fdafa283f9d7ac19a113b9577aa
prerequisite-patch-id: ca2588fb1077285314ba5097249f561d1d996007
prerequisite-patch-id: d0e46f229f6646ff7244366c16672fd94a7d9afd
prerequisite-patch-id: bf34abe01f01f9860bf24e1b342bd9b1bac5d0f0
-- 
2.39.2

