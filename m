Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F42B619362
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 10:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbiKDJV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 05:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiKDJVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 05:21:21 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347A0248DB;
        Fri,  4 Nov 2022 02:21:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1E8B5CE29F5;
        Fri,  4 Nov 2022 09:21:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59070C433C1;
        Fri,  4 Nov 2022 09:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667553674;
        bh=ZNT0XwYAgRKuTKTfJu0Te8j5hILWxto2RffwHpENdF8=;
        h=From:To:Cc:Subject:Date:From;
        b=lR6xkhsNRtS7thTObdaB0xQK8Em+2A4+Ez2ybWVpI7xOyc2YCzsnhsbwOtcwLianv
         kOaG4ZZQ7aU0kFMePoZyERKA2b7xfR8VFFsQcOvpMwGQb1hFWq9R3eaFb80Jqt3j1I
         fnKjcG7MvczFgLJ1zgXZy69ZoOrScZD/5pptmh2VbQUAKQxnHeZdxqtBV8Dl7RpC1X
         QGCSd4jYfrb7sM3TiQsiA8c0rX+DdNTFJTFq2z7Sb5TSruWVPXX+nl2LeLW7+Nm6rg
         dzbAZBWGIhVCWTCUXut9+qyz02aQCZ40/4jGs6RShJykBd5dB3NU8Q9Xcnj1LZ2IMs
         lotEsNdcdYMrQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oqssh-0004XX-PF; Fri, 04 Nov 2022 10:20:56 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Brian Masney <bmasney@redhat.com>,
        Shazad Hussain <quic_shazhuss@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/2] arm64: dts: qcom: sc8280xp: fix UFS reference clocks and PHY nodes
Date:   Fri,  4 Nov 2022 10:20:43 +0100
Message-Id: <20221104092045.17410-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After some initial confusion, we've finally settled how the UFS ref
clocks are used.

The first patch fixes the UFS controller and PHY nodes so that they
reflect the hardware. This one should go in 6.1-rc where the two
previous attempts to address this are heading.

Note this patch depends on first updating the clock driver to reflect
that the device ref clock is fed from CXO. This is needed as the UFS
controller driver requires a valid frequency for the ref clock. A patch
that addresses the this has been submitted, but a v2 is in the works.
[1]

The second patch updates the UFS PHY nodes so that they reflect the
fixed UFS PHY binding that is now in linux-next. This one is 6.2
material but depends on first fixing the clocks.

So to summarise the dependency order:

 1. clock driver should be fixed in 6.1-rc
 2. patch 1/2 should go in 6.1-rc (after 1)
 3. patch 2/2 should go in 6.2 (after 1 and 2)

Johan


[1] https://lore.kernel.org/r/20221030142333.31019-1-quic_shazhuss@quicinc.com


Johan Hovold (2):
  arm64: dts: qcom: sc8280xp: fix UFS reference clocks
  arm64: dts: qcom: sc8280xp: update UFS PHY nodes

 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 57 ++++++++++----------------
 1 file changed, 21 insertions(+), 36 deletions(-)

-- 
2.37.3

