Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54FD266CA3D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 18:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjAPRAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 12:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234175AbjAPRAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 12:00:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAFE42DFE;
        Mon, 16 Jan 2023 08:42:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEBCA61092;
        Mon, 16 Jan 2023 16:42:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C59C433D2;
        Mon, 16 Jan 2023 16:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673887376;
        bh=8a3MlUovzOvRSVhA5GVPmvPsQkOoUVDWU54w2dSskdA=;
        h=From:To:Cc:Subject:Date:From;
        b=BYVjSxYf7ZCktDrlSOSxMCnxFM1Srdx9kASdl9GSLq7/2wq43oA655h1SFh76Z6TK
         3SFhNV9Nag9pfV74xzmof6OxUEkKtA4fgkDGBKdglUyziMBrtDL4M2h6mLYsBz1kKU
         E8a82BQDKKAOh7iX7YF3RePkoqddAcs71zGP9wuPBk6Mh424T1njJ8FlGNK92aTP2k
         4VrdFsWLQNYfhBawZ0oGx2k7Q0PH86SbvZ/DkF0I4v2Qf12/+4mXHSiiTcDQ13TJxq
         16jSqKBdnUQR0J6ipzKSb/mfh+VzU8R7iRcFuyvx0DxOD0ZIukdfwFJjjqN1QvY2gT
         PZgNP/+26g56Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pHSZm-0004wK-KL; Mon, 16 Jan 2023 17:43:15 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH RESEND] dt-bindings: ufs: qcom: allow 'dma-coherent' property
Date:   Mon, 16 Jan 2023 17:42:36 +0100
Message-Id: <20230116164236.18958-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.38.2
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

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---

James and Martin,

I'm resending as reminder in case you missed the first submission which
included an arm64 dts update and also did not have you on CC as I was
following scripts/get_maintainer.pl too literally:

	https://lore.kernel.org/all/20221205100837.29212-1-johan+linaro@kernel.org/

I've added Rob and Bjorn's Reviewed-by tags from the above thread.

Could you take this one through the scsi tree?

Johan


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
2.38.2

