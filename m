Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E806D637B75
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 15:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiKXOaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 09:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiKXOaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 09:30:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E9F7213E;
        Thu, 24 Nov 2022 06:29:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1E42AB82835;
        Thu, 24 Nov 2022 14:29:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9307C433D6;
        Thu, 24 Nov 2022 14:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669300196;
        bh=hIeGLPE7dl6RAVsZMh0WHZl4Pd+eFlTWe3fogJ7tYp8=;
        h=From:To:Cc:Subject:Date:From;
        b=MbShXb8EdixsZ3fJ0JShJ3FyadhLA0/Uo4HMvt9mdlnloJbIBTG0pIzZG50manRt7
         SNLhQBN0bxsF/UVdDL2uQOKniSaiMGutZyosktOPjQQTq3ZVfZGcjOf6e/tjj/ZGaI
         uMTQ2sOAKuBqujLw4DP8P98ChJUAZ8cwkWx+/nyck1zuhiPM46y0fuEcQD7WZkjwlT
         i447f/Ho97jimg+Sl9FS8MbHifLK4Ws0bQ0GqZEabHYswZVI0hCZ3t5U94LHjxBHn8
         yYb1nC68rz3qiKDH9bnRK8h/BLci+K5RnvWm0cf0jAAL92N8jH+tEnv3jQejzUX4TF
         GO0vhyHrpFymA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oyDEH-0007fo-H2; Thu, 24 Nov 2022 15:29:30 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] arm64: dts: qcom: sc8280xp: fix PCIe DMA coherency
Date:   Thu, 24 Nov 2022 15:25:01 +0100
Message-Id: <20221124142501.29314-1-johan+linaro@kernel.org>
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

The devices on the SC8280XP PCIe buses are cache coherent and must be
marked as such to avoid data corruption.

A coherent device can, for example, end up snooping stale data from the
caches instead of using data written by the CPU through the
non-cacheable mapping which is used for consistent DMA buffers for
non-coherent devices.

Note that this is much more likely to happen since commit c44094eee32f
("arm64: dma: Drop cache invalidation from arch_dma_prep_coherent()")
that was added in 6.1 and which removed the cache invalidation when
setting up the non-cacheable mapping.

Marking the PCIe devices as coherent specifically fixes the intermittent
NVMe probe failures observed on the Thinkpad X13s, which was due to
corruption of the submission and completion queues. This was typically
observed as corruption of the admin submission queue (with well-formed
completion):

	could not locate request for tag 0x0
	nvme nvme0: invalid id 0 completed on queue 0

or corruption of the admin or I/O completion queues (malformed
completion):

	could not locate request for tag 0x45f
	nvme nvme0: invalid id 25695 completed on queue 25965

presumably as these queues are small enough to not be allocated using
CMA which in turn make them more likely to be cached (e.g. due to
accesses to nearby pages through the cacheable linear map). Increasing
the buffer sizes to two pages to force CMA allocation also appears to
make the problem go away.

Fixes: 813e83157001 ("arm64: dts: qcom: sc8280xp/sa8540p: add PCIe2-4 nodes")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 27f5c2f82338..7748cd29276d 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -854,6 +854,8 @@ pcie4: pcie@1c00000 {
 				 <0x02000000 0x0 0x30300000 0x0 0x30300000 0x0 0x1d00000>;
 			bus-range = <0x00 0xff>;
 
+			dma-coherent;
+
 			linux,pci-domain = <6>;
 			num-lanes = <1>;
 
@@ -951,6 +953,8 @@ pcie3b: pcie@1c08000 {
 				 <0x02000000 0x0 0x32300000 0x0 0x32300000 0x0 0x1d00000>;
 			bus-range = <0x00 0xff>;
 
+			dma-coherent;
+
 			linux,pci-domain = <5>;
 			num-lanes = <2>;
 
@@ -1046,6 +1050,8 @@ pcie3a: pcie@1c10000 {
 				 <0x02000000 0x0 0x34300000 0x0 0x34300000 0x0 0x1d00000>;
 			bus-range = <0x00 0xff>;
 
+			dma-coherent;
+
 			linux,pci-domain = <4>;
 			num-lanes = <4>;
 
@@ -1144,6 +1150,8 @@ pcie2b: pcie@1c18000 {
 				 <0x02000000 0x0 0x38300000 0x0 0x38300000 0x0 0x1d00000>;
 			bus-range = <0x00 0xff>;
 
+			dma-coherent;
+
 			linux,pci-domain = <3>;
 			num-lanes = <2>;
 
@@ -1239,6 +1247,8 @@ pcie2a: pcie@1c20000 {
 				 <0x02000000 0x0 0x3c300000 0x0 0x3c300000 0x0 0x1d00000>;
 			bus-range = <0x00 0xff>;
 
+			dma-coherent;
+
 			linux,pci-domain = <2>;
 			num-lanes = <4>;
 
-- 
2.37.4

