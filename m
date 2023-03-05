Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F336AAF17
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 11:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjCEKdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 05:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjCEKdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 05:33:01 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6527461AC;
        Sun,  5 Mar 2023 02:32:58 -0800 (PST)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 8890BC3FE3;
        Sun,  5 Mar 2023 10:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1678012376; bh=s2TXzjWqzet821PYxlp6EoCiLsVQo2P2OnQximHU/8o=;
        h=From:Subject:Date:To:Cc;
        b=SD//CbNdp2Z1chspwWOb+aTl6fwuNhyRDaWpbr/ODO/1XEdcJlBbXj2stlY/CYvj0
         j+6tbZn3aMBBsM/gWkHp8rrc7OA/sQgT/c2U/JssTzBqe+juKuNGDTR+fPEibkNds6
         GLB9C/FW9tCNqHQxER6SAH9wgDynMBxir4p4wh5E=
From:   Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH 0/2] Fix qcom,vmid handling in rmtfs_mem
Date:   Sun, 05 Mar 2023 11:32:32 +0100
Message-Id: <20230305-rmtfs-vmid-fix-v1-0-6a7206081602@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMBvBGQC/x2NQQqDQAxFryJZN5DOdDa9iriYGWMN6ChJKwXx7
 g1dvsd//BOMVdjg2Z2gfIjJ1hzutw7qnNuLUUZnCBQiRUqo63syPFYZcZIvEteYQqFEDwKPSjb
 GornV2bP2WRaXu7Jv/y/9cF0/ef7kE3UAAAA=
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=739; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=s2TXzjWqzet821PYxlp6EoCiLsVQo2P2OnQximHU/8o=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkBG/VYbhlbWlurjD9FdO/Zbivw0qZGh24D7h33
 R2CILv78GuJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZARv1QAKCRBy2EO4nU3X
 VsZxD/9U0mYI0AXlfmY7Y6j5bT5z9IC2kiyKiKLewPjlILB8Zb56u5oyY3QzYJMBoxon1tNSwX6
 qfi8cp/Y8HaE9T+XwLkCVvPcA3QInZIluI5aI6ifK+iJJKlpovmnh+cSc+lYb1mGXroPINXE1Uu
 IsEBF//wdtP07Zw26so6ZfEECw4QYgWhzytIVO5MHCkBbUDDNWVZkvAwMcIekiZ6j4ei6Y8QTNo
 6T3G2L+AIOt/JF2k8X6qBVqT64g/BC+Aoq7EmpAybH0rCXyZfSKKf6a6lByohO3WwLvFfv0W9tw
 Bxfn1IGmM7g+mbcPnTYtAsEfZjt8m8AIX0CTSkeMSDSCctsK+xsXrdFGoKylj1KpTcnsdHk03ks
 oDsie1eLWrO+7a0cNR7QNyCfTlGxgdVvswCEYKnafiEAKE3bMEYaUkXim3d0UtE3V7Iu2PGsu55
 0bwd7lJ3n0afaO7/YazcUxoNCW8rE/mkJHcmgsgKzME5ryimU+VFFXm2RtZiLy4qibRYzXYUgzd
 rakr/6SYrlVs4CG2j6UkQqf1A7JVO5AIxOw/eyBDRIU3moWm/xP73sRTxFRZFiIa8AtRtC8jnFg
 rMF4jjrsFDAk0UoRO2o3hu0hl7p4m/ARC6eXWzoNcvm6lOIcKm1uj+1PDEUTTAIUyIJOEkEpoPT
 egJm/Du/fP69O3A==
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

The commit e656cd0bcf3d ("soc: qcom: rmtfs: Optionally map RMTFS to
more VMs") which landed for v6.3-rc1 caused some issues on platforms
such as msm8974. Fix both the error handling and behavior when qcom,vmid
property is missing.

Please include this (or another fix) in 6.3 still.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Luca Weiss (2):
      soc: qcom: rmtfs: fix error handling reading qcom,vmid
      soc: qcom: rmtfs: handle optional qcom,vmid correctly

 drivers/soc/qcom/rmtfs_mem.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)
---
base-commit: 388bd72dfdc05abb319d86109a6edc9be5e0581d
change-id: 20230305-rmtfs-vmid-fix-0ec352b05040

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>

