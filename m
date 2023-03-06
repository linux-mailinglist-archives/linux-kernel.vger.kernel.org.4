Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B286ACE0F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 20:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjCFT33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 14:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjCFT32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 14:29:28 -0500
Received: from amity.mint.lgbt (vmi888983.contaboserver.net [149.102.157.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B553165046
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 11:29:16 -0800 (PST)
Received: from amity.mint.lgbt (mx.mint.lgbt [127.0.0.1])
        by amity.mint.lgbt (Postfix) with ESMTP id 4PVlQm5zyFz1S5JW
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 12:08:32 -0500 (EST)
Authentication-Results: amity.mint.lgbt (amavisd-new);
        dkim=pass (2048-bit key) reason="pass (just generated, assumed good)"
        header.d=mint.lgbt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mint.lgbt; h=
        content-transfer-encoding:mime-version:x-mailer:message-id:date
        :subject:to:from; s=dkim; t=1678122511; x=1678986512; bh=Cp0Pj3r
        +o2NETU+8hKdAUsF77CSSWrab0rX6wePh+5w=; b=ycjXMdalEBc39Wr2qWrRfS6
        ICUh45mzBKfMp4GOiXmyGGogv4S70CNnd2gyTxxTw2rchfYe9rxwgRcliEp33UMA
        osq6BrXjx+dByZb0kwdMX964nxEPrkxAPb9mYfcV4daMh1FTw1Viewue5cI7Nc52
        00NjsjWRGiOXaGKXrjYzcKskGlV/TuIcWN6ZosBHZ5fiRaCBpp4Cl+qzDmKewR56
        mAQZTA4RA0SLEUb4ovZq9MPMx9o4kCgbMEF2keVNl9AmtZ+fsiDDpCKhoUeYjVbV
        svqjwQErytf1rNuRv0r4cbRWacctW1PLB9IsH/cNLTDlcEP76YZVPZN7323K+NQ=
        =
X-Virus-Scanned: amavisd-new at amity.mint.lgbt
Received: from amity.mint.lgbt ([127.0.0.1])
        by amity.mint.lgbt (amity.mint.lgbt [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id aiRkuyNeBkvW for <linux-kernel@vger.kernel.org>;
        Mon,  6 Mar 2023 12:08:31 -0500 (EST)
Received: from dorothy.. (unknown [186.105.8.42])
        by amity.mint.lgbt (Postfix) with ESMTPSA id 4PVlQZ50bjz1S4vb;
        Mon,  6 Mar 2023 12:08:22 -0500 (EST)
From:   Lux Aliaga <they@mint.lgbt>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        vkoul@kernel.org, kishon@kernel.org, alim.akhtar@samsung.com,
        avri.altman@wdc.com, bvanassche@acm.org, keescook@chromium.org,
        tony.luck@intel.com, gpiccoli@igalia.com
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-hardening@vger.kernel.org,
        phone-devel@vger.kernel.org, martin.botka@somainline.org,
        marijn.suijten@somainline.org
Subject: [PATCH v7 0/6] arm64: dts: qcom: sm6125: UFS and xiaomi-laurel-sprout support
Date:   Mon,  6 Mar 2023 14:08:10 -0300
Message-Id: <20230306170817.3806-1-they@mint.lgbt>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce Universal Flash Storage support on SM6125 and add support for t=
he Xiaomi Mi A3 based on the former platform.

Changes since v6:
- Add struct for v3-660 UFS PHY offsets and replace the v5 offsets in sm6=
115 UFS PHY config to these
- Set ufs_mem_phy reg size to 0xdb8 in sm6125.dtsi
- Drop "#address-cells" and "#size-cells" properties on reserved-memory n=
ode in xiaomi-laurel-sprout dts
- Move "status" last on &pon_resin node in xiaomi-laurel-sprout dts
- Modify "&pm6125_gpio" pointer to "&pm6125_gpios" in xiaomi-laurel-sprou=
t dts

v6: https://lore.kernel.org/linux-devicetree/20230108195336.388349-1-they=
@mint.lgbt/
v5: https://lore.kernel.org/linux-devicetree/20221231222420.75233-2-they@=
mint.lgbt/



