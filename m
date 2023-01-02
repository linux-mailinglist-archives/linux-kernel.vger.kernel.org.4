Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF2365AFE9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 11:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbjABKv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 05:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbjABKvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 05:51:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD6062EC;
        Mon,  2 Jan 2023 02:50:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05FA360ECA;
        Mon,  2 Jan 2023 10:50:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B886C433F1;
        Mon,  2 Jan 2023 10:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672656651;
        bh=yGI5iSphXYrpFU5loWTxWRokLwgsxQu/6JAkUvh34PU=;
        h=From:To:Cc:Subject:Date:From;
        b=hYIqk8TZJJO/0wy1j2QwUfJf6OUr5w2y83+3+RzjpR7+sSGtUvn5Y/4kEcPOSHZxs
         aHsVU0nWprWPKgVvVhrDvJmMGVVK8odvpal8sbB1yyiyGAtEhiPyZX3RDcF9yAYdIl
         TWf+cpq+xgQ3i9NHNGQKa3ONjsq5tJezPY5Cd2nBht+4xxvD43BJy+JbMry4HUiCk6
         b929EhSzAZJuxOIrPceDC1BvMMHvwuPv7TiS+GhX0L3l9ajZUUVzpugG1uoNgysclf
         NZKPtQMtJs6o3eIchF46EyPXRL9/m7Xi6ZC9hYRZJZyMs/55tSDu1kBW7FxzXsKDYi
         /k9YkFrs7EL1Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pCIPM-00026o-2X; Mon, 02 Jan 2023 11:51:08 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/6] arm64: dts: qcom: disable x13s sound + cleanups
Date:   Mon,  2 Jan 2023 11:50:32 +0100
Message-Id: <20230102105038.8074-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apparently enabling the soundcard in the X13s devicetree was a bit
premature so disable it for now until driver support is in place (e.g.
to avoid probe failures during boot).

This series also clean up the sc8280xp sound nodes somewhat, for
example, by making sure they are disabled by default and moving the
wcd938x node which do not belong under 'soc' to the root node. Two other
devicetrees had the wcd938x node under 'soc' and the fixes are also
included here.

Johan


Johan Hovold (6):
  arm64: dts: qcom: sc8280xp-x13s: disable soundcard
  arm64: dts: qcom: sc8280xp: disable sound nodes
  arm64: dts: qcom: sc8280xp: clean up tx-macro node
  arm64: dts: qcom: sc8280xp-x13s: fix wcd938x codec node
  arm64: dts: qcom: sm8250-mtp: fix wcd938x codec node
  arm64: dts: qcom: sm8450-hdk: fix wcd938x codec node

 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 62 +++++++++++--------
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi        | 18 +++++-
 arch/arm64/boot/dts/qcom/sm8250-mtp.dts       | 40 ++++++------
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts       | 52 ++++++++--------
 4 files changed, 96 insertions(+), 76 deletions(-)

-- 
2.37.4

