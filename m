Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4E35F6A14
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 16:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbiJFOz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 10:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiJFOzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 10:55:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27106919D
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 07:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665068146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=hvu927jcP5VOBqnit88bPG8K5LsmKJyGG9EvVu5KyBM=;
        b=M1i0LhN0iYLpoI7lsRBj1cXGfpD1Jk1x4sOwrr2cIGx82KQL9bpcoBI917DV1veRwll09p
        gisZi1Dh5vx8kXvBtgRko6UjdhN+lzcDFOs93JgqEXmj8h4UuvqdkZHBoDHPk8G3bsSDyx
        TyaoGrJ+Xe4+S/1iUqkSOAM+qPhkIm0=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-558-KjGGkU5lOTqwkerQfynI4w-1; Thu, 06 Oct 2022 10:55:44 -0400
X-MC-Unique: KjGGkU5lOTqwkerQfynI4w-1
Received: by mail-il1-f198.google.com with SMTP id u2-20020a056e021a4200b002f9ecfa353cso1708798ilv.20
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 07:55:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hvu927jcP5VOBqnit88bPG8K5LsmKJyGG9EvVu5KyBM=;
        b=0mKqrUD3U9zfOKMQZzNAoeAV63upguVDOMNmskF+gSCd4dlNqQKERlv6cN7Q574dG+
         IuuPsU4pZuDj1u3EfXaIDRlxRIUFGDjNQGHU5wXxIF8vNNvgld6kV75MrsOUBwrzVM72
         4jhY6pRSGsSd5yi1g91G9ZTVEoD2dx1hAxxNDZ3zcauWlbZ2agkJI/Y5o346qJqmvkeq
         aweLpBfMe4WLWB/b/CUYtB6J1amenELad0niwJXKrrcYox/QLWArJFOSwDwHxEzoUsNC
         sDLqctJ1lqvUXRYybjWdGihxoZJPuGUKdMtdTBO96Byyu7RC7B+f7kEo0g8G0HGoalhD
         zdPA==
X-Gm-Message-State: ACrzQf2zsYG4PBtSzOA6VFcg8ciuonJgCOyhMsQnVdGLq6yuDiSP2OSj
        jy7pL7F3A5zTeCoigqoYCQPnRbzF5VCmKyKZFmSOpyehh2zKz+dxzVybODunD0L32ChToqex/7/
        KFZfQAR2aUxvgyrxDuLneVPhe
X-Received: by 2002:a05:6638:248f:b0:363:73fc:cc17 with SMTP id x15-20020a056638248f00b0036373fccc17mr40634jat.257.1665068143919;
        Thu, 06 Oct 2022 07:55:43 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6lCbCh+MPmTjfqYkLRJfeMy/CGiv6Cjxm/4a1eaZr5AusJ2YLiO8ihXN7k4fKIotEsuCwJjw==
X-Received: by 2002:a05:6638:248f:b0:363:73fc:cc17 with SMTP id x15-20020a056638248f00b0036373fccc17mr40624jat.257.1665068143639;
        Thu, 06 Oct 2022 07:55:43 -0700 (PDT)
Received: from x1.. (c-98-239-145-235.hsd1.wv.comcast.net. [98.239.145.235])
        by smtp.gmail.com with ESMTPSA id z2-20020a05660229c200b006884b050a0asm7848669ioq.18.2022.10.06.07.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 07:55:43 -0700 (PDT)
From:   Brian Masney <bmasney@redhat.com>
To:     andersson@kernel.org
Cc:     agross@kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ahalaney@redhat.com,
        echanude@redhat.com, johan+linaro@kernel.org
Subject: [PATCH v4] arm64: dts: qcom: sc8280xp: correct ref clock for ufs_mem_phy
Date:   Thu,  6 Oct 2022 10:55:29 -0400
Message-Id: <20221006145529.755521-1-bmasney@redhat.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first UFS host controller fails to start on the SA8540P automotive
board (QDrive3) due to the following errors:

    ufshcd-qcom 1d84000.ufs: ufshcd_query_flag: Sending flag query for idn 18 failed, err = 253
    ufshcd-qcom 1d84000.ufs: ufshcd_query_flag: Sending flag query for idn 18 failed, err = 253
    ufshcd-qcom 1d84000.ufs: ufshcd_query_flag: Sending flag query for idn 18 failed, err = 253
    ufshcd-qcom 1d84000.ufs: ufshcd_query_flag_retry: query attribute, opcode 5, idn 18, failed
        with error 253 after 3 retries

The system eventually fails to boot with the warning:

    gcc_ufs_phy_axi_clk status stuck at 'off'

This issue can be worked around by adding clk_ignore_unused to the
kernel command line since the system firmware sets up this clock for us.

Let's fix this issue by updating the ref clock on ufs_mem_phy. Note
that the downstream MSM 5.4 sources list this as ref_clk_parent. With
this patch, the SA8540P is able to be booted without clk_ignore_unused.

Signed-off-by: Brian Masney <bmasney@redhat.com>
Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
Tested-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
---
Changes since v3:
- Renamed ref_aux to ref in patch subject. Added Johan's R-b and T-b.

v3 of this patch can be found at
https://lore.kernel.org/lkml/20220830180120.2082734-1-bmasney@redhat.com/

v2 of this patch can be found at
https://lore.kernel.org/lkml/20220825163755.683843-1-bmasney@redhat.com/T/#u

v1 of this patch can be found at
https://lore.kernel.org/lkml/20220623142837.3140680-1-bmasney@redhat.com/T/#u

 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index c32bcded2aef..006b9a13bc2f 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -891,7 +891,7 @@ ufs_mem_phy: phy@1d87000 {
 			ranges;
 			clock-names = "ref",
 				      "ref_aux";
-			clocks = <&rpmhcc RPMH_CXO_CLK>,
+			clocks = <&gcc GCC_UFS_REF_CLKREF_CLK>,
 				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
 
 			resets = <&ufs_mem_hc 0>;
-- 
2.37.3

