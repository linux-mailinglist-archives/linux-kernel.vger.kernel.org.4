Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B933D613D12
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 19:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiJaSFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 14:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiJaSE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 14:04:26 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B8713E2B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 11:04:25 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d10so11339552pfh.6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 11:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6pljquG0hkdcBPdXIDtkq1v6aN8iyQB1w4S/2qg/cek=;
        b=mbaTkWIZctaMqvca5J6aUZD1yU2UYtJBk9TxNW1vYxyFZbwSlWxTXO/4DvGjs1wwJP
         S1J/cj97edabhnPuqksCMwl1eu0ORZNLO9ms8r65u5wbDVM04VFOtkiuyQd5XCsFjEc4
         VxmFMqOjyuYh/4HnDzczDsxkfw4Ljzr5rdipzDoPlVV4yLGL5TQRGdMhg0gH7eruNE1p
         oVxsho9okB2M0NIN0f8X+MTG8f0e1tsxV+lJ/wS1Zg/Bztivz97X/3AHiBkQ6iJWdWB8
         7d+YNlNfqNBJXgOHKYfrFWm1JyjwBC+4J632yCsu+NbuC2rabHpI0o5hHgp7KaecAtwR
         L0RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6pljquG0hkdcBPdXIDtkq1v6aN8iyQB1w4S/2qg/cek=;
        b=13r3bIGkMEa3H8lzXjhQTy+FxUlUJFaF7kJHmyRK6Go3d/Fc464TYV10PQlEuImjGg
         yp5etQc1SoNuw73OR97f/AE+Gd4tCbixqsdahb08x+A/n3c7LjMai31FFHvkCiV1viw5
         YM6nFx5guB7Aeudg+f7Vdq+R9xoRmgaNFPfZJKJVFFb7aHktoJfFo8jQmCtf0nJeZiBw
         bnbZcDuqntoyNbAEZ08ulr1FcbG5QV05vr69KE8PfY7OdWkWghJrzAJwyfSLdt4G+sh0
         feURSdkGcZvFMPvrnTIluYH4nXZ7W0ewFbCxT7I9vIuD6zTE0Hh/8fHviAyCA91Cf1bH
         4LWQ==
X-Gm-Message-State: ACrzQf1WFPuSmVRbsKYDM3KZBoVKAXBjiYSKrWgHWgmO3QUhtnkrsZ94
        M0eHTm6NvDdTuA4T77cEVF5N
X-Google-Smtp-Source: AMsMyM5bkO0jc5E/Yeey8T7kpu9gaLOBOsA6kJDN2KwU5inXsF6u37NtULiOyALmrO8jomRmhKhNOg==
X-Received: by 2002:a05:6a00:c8d:b0:56d:370f:2003 with SMTP id a13-20020a056a000c8d00b0056d370f2003mr11529938pfv.76.1667239465227;
        Mon, 31 Oct 2022 11:04:25 -0700 (PDT)
Received: from localhost.localdomain ([117.193.209.221])
        by smtp.gmail.com with ESMTPSA id q14-20020a170902a3ce00b00186c6d2e7e3sm4742224plb.26.2022.10.31.11.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 11:04:24 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, vkoul@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        quic_cang@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org,
        dmitry.baryshkov@linaro.org, ahalaney@redhat.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 15/15] MAINTAINERS: Add myself as the maintainer for Qcom UFS driver
Date:   Mon, 31 Oct 2022 23:32:17 +0530
Message-Id: <20221031180217.32512-16-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221031180217.32512-1-manivannan.sadhasivam@linaro.org>
References: <20221031180217.32512-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qcom UFS driver has been left un-maintained till now. I'd like to step
up to maintain the driver and its binding.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cf0f18502372..149fd6daf52b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21097,6 +21097,14 @@ L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	drivers/ufs/host/ufs-mediatek*
 
+UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER QUALCOMM HOOKS
+M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+L:	linux-arm-msm@vger.kernel.org
+L:	linux-scsi@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
+F:	drivers/ufs/host/ufs-qcom.c
+
 UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER RENESAS HOOKS
 M:	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
 L:	linux-renesas-soc@vger.kernel.org
-- 
2.25.1

