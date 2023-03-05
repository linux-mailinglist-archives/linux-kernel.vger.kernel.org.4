Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20CD56AAF19
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 11:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjCEKdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 05:33:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjCEKdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 05:33:01 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC0A659D;
        Sun,  5 Mar 2023 02:32:58 -0800 (PST)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id CAB3BD2455;
        Sun,  5 Mar 2023 10:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1678012376; bh=8TpJ2RFG2fZxCQ3aiTLoKbjpY3Tp/zvX9uXiLM/4nZg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=eII+qwGqhkCAMp5tSLM9EpPVeUHWQ5WFjqCQOPd8laG+n4CiqeejoFEsA4ytFM9dm
         VBTbJXaDVqLnM8j/KufitSh5k2Gwrs6fJFy5rwhKnfPjkUiorWwDVsIJXWy6GoIWpZ
         aIpzq5gFJsxamewFTyGrANszX5i/f1Pbi1YwbPnc=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Sun, 05 Mar 2023 11:32:33 +0100
Subject: [PATCH 1/2] soc: qcom: rmtfs: fix error handling reading qcom,vmid
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230305-rmtfs-vmid-fix-v1-1-6a7206081602@z3ntu.xyz>
References: <20230305-rmtfs-vmid-fix-v1-0-6a7206081602@z3ntu.xyz>
In-Reply-To: <20230305-rmtfs-vmid-fix-v1-0-6a7206081602@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1399; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=8TpJ2RFG2fZxCQ3aiTLoKbjpY3Tp/zvX9uXiLM/4nZg=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkBG/WIwFqGiCP08Av11dROVIBCpWddyUGN6I2C
 CN06B7rrOWJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZARv1gAKCRBy2EO4nU3X
 VsBPEADU3T/mVxhg7C/c/g8pjFRimH45ug3Bp+luheaFcvpcxCsSRvmYFthYjmeGNvZwYGMY6YN
 BkKrjoeFL+8HtFYvW0U4moHH3zbiRuOJABai/v3vpnJuPHYgZj3W/2PX3J1e9ZhsmemWHUMqahY
 s7DlGqnXjka9aGZCb4qionM1xLcRsfZcKf68eONBLATzY330LE9LajVcTIL785hagf6Q2aWjpXe
 9Kn/trcLEssPgRVBpoVh6wpCGROISeUzbuC+l2RuekykmrAURjjLGYgADUwa5B0mm812NqlEpig
 1psUD0I4gDBq5xcF2R5HLIAdT1UK6IFDmbSnRuh/SA/2B+FLJl882G6L7soHVn6qbkrsKDdUJqm
 DWEDeb2FhuhC5c1PBWwAYdavDvWYg71bZ+kQz/hkSAyo+FeDX2kXrHlMQlFpRFwcXRKALcDuswc
 I9Y+7NXiOmXT/ipJg7dt907301UkfhAVSDPFEA0M3LaDYTosYz2QAQUj2tIIvOlv1DrV01dQGed
 aij6sp0p0Qw+EeaYPGUF0NRf4d11Lm7oIs0q3paKrOFulRuEsOVusBRIeCfXvpEwqGvnekROFXS
 jRNwtdqezhIPcF+27+7+aSMDnUujwqCVgNLBu3gnfzaLZ+N1+xAMWFPWfXcwkVPbcF0UiJhxVoP
 WO963xoxXAXnVrg==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_property_count_u32_elems returns a negative integer when an error
happens , but since the value was assigned to an unsigned integer, the
check never worked correctly. Also print the correct variable in the
error print, ret isn't used here.

Fixes: e656cd0bcf3d ("soc: qcom: rmtfs: Optionally map RMTFS to more VMs")
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/soc/qcom/rmtfs_mem.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/rmtfs_mem.c b/drivers/soc/qcom/rmtfs_mem.c
index 9d59ad509a5c7..218397ab0c36f 100644
--- a/drivers/soc/qcom/rmtfs_mem.c
+++ b/drivers/soc/qcom/rmtfs_mem.c
@@ -176,7 +176,8 @@ static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
 	struct reserved_mem *rmem;
 	struct qcom_rmtfs_mem *rmtfs_mem;
 	u32 client_id;
-	u32 num_vmids, vmid[NUM_MAX_VMIDS];
+	u32 vmid[NUM_MAX_VMIDS];
+	int num_vmids;
 	int ret, i;
 
 	rmem = of_reserved_mem_lookup(node);
@@ -229,7 +230,7 @@ static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
 
 	num_vmids = of_property_count_u32_elems(node, "qcom,vmid");
 	if (num_vmids < 0) {
-		dev_err(&pdev->dev, "failed to count qcom,vmid elements: %d\n", ret);
+		dev_err(&pdev->dev, "failed to count qcom,vmid elements: %d\n", num_vmids);
 		goto remove_cdev;
 	} else if (num_vmids > NUM_MAX_VMIDS) {
 		dev_warn(&pdev->dev,

-- 
2.39.2

