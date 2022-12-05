Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886F0642671
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 11:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbiLEKKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 05:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiLEKKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 05:10:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02738183B5;
        Mon,  5 Dec 2022 02:10:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A7865B80E60;
        Mon,  5 Dec 2022 10:10:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55EF1C433B5;
        Mon,  5 Dec 2022 10:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670235029;
        bh=YMlE6nWRDtF//ri9V9yKEVsMMR4A33b7UQugBFmOK7Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s8AB7kPviA+CsoLJTDlHHp0Ikx1yznlxLrVS43pQzT6D0sdKkbEiZSEJUKp1LxALF
         xhXyEboNzeqWBEGRw9vJNejXBVR8/WZdHC33robFiJkSzYiaPTj8SzOMURYnpByu8I
         SWBJzKWg97UAmcJcIkpgL7IJ3KGxVw6IpAbpW5a3dra0dft/XyFwV8fGfM0LpnAZ5/
         gfG80lxdQQGyksTrtMAVZ6qGR5VnFztHvu10tvT/pGaUNfiG+16Nkhc1XxJU8ekw4k
         0OIUa/GHTE12Wx95wkPARz7k6WL+ny+ZN01swZZnzc5VBx1misR6YMTe+6MMZPClFi
         BpPO/wLhiUXvQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1p28Qk-0007c8-AI; Mon, 05 Dec 2022 11:10:34 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 1/2] dt-bindings: ufs: qcom: allow 'dma-coherent' property
Date:   Mon,  5 Dec 2022 11:08:36 +0100
Message-Id: <20221205100837.29212-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221205100837.29212-1-johan+linaro@kernel.org>
References: <20221205100837.29212-1-johan+linaro@kernel.org>
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

UFS controllers may be cache coherent and must be marked as such in the
devicetree to avoid data corruption.

This is specifically needed on recent Qualcomm platforms like SC8280XP.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
index f2d6298d926c..1f1d286749c0 100644
--- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
@@ -44,6 +44,8 @@ properties:
     minItems: 8
     maxItems: 11
 
+  dma-coherent: true
+
   interconnects:
     minItems: 2
     maxItems: 2
-- 
2.37.4

