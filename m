Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8AC6541BF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 14:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235392AbiLVNTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 08:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235576AbiLVNS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 08:18:58 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519D82B24E
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 05:18:57 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id t2so2009835ply.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 05:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0mC3YHxzlEQlwMPao/Y7ASve0hKwhscYa/RkKUoFYA=;
        b=idwOGGO1DQQ/Drnnb+7kYYOP6u1VjrOPSkhZO0g4Ex4/Q2zJDFJWn+qCdkaQqyNcqD
         f+N8QoRylsLnXhjcH1klfJYfhRRRLMYjvMmoBSa9PNyonHdW2xmzt1tqT2KhqSaN0Wr0
         Gurk2DAUiSrQp+k9WLGF/YVE5HrElbK5O35g227ccc7MYsmUHvPRqnuYBC2XFol912ME
         s/27D7otADi29Q1kJvPmNyihgYFl6ZiuRIMTUYzWJhkwWQjZ6hUvW+ASNdfqLTL45Bxk
         RUmSvuwgkgvG7qJupZ0Ks/dHzD4zkASjM21WP8rud+nuZdLcBujsr0lwP0PVC1b8nvvn
         PSJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d0mC3YHxzlEQlwMPao/Y7ASve0hKwhscYa/RkKUoFYA=;
        b=DvcdtZ3f4B7gO6l+tic+S9KRBFleTV+k5+jX3PWh/suMSsiCdjJ56kJugPxBTPebZ6
         nHiRHvQq9mHMnM4ZczuHyGOQ6OjNIgKdFGEhj6qCiVLaJYnBFq5CJJxUh6wLHWfvsRWo
         p8V5HEkT+Tq9AiDObWly+9hYh+mf7ZR9rRNZLvYtua9pG2vpRNxBlB8m3G/gW+ZUviZX
         b7EFBLYe7U4yE/NRkitc9hRBdM1ze1kvzBZ6GcmgdsoLp7YI4iV5j/vjNXUEajU5v6yz
         P4CPFzQ1GRS67ZN/PyT0+R08dNhfGlRVIShy+pDWVhJjcgmIowXP9uAkYurcynAT0J0n
         n8Aw==
X-Gm-Message-State: AFqh2koe0MZ0txWIsRgla+i9PUhOkgZGaZ6c5eO7jz+TzmN45QahuDfs
        hwhc331oqEdIBGsFfpyE3GkP
X-Google-Smtp-Source: AMrXdXtuB+Kyv8rWt7p+h2nL/e/HlXilbK3Ue4DDES7s++mjFr9Fvneq56XgcSIUgkMBUG46af0ibg==
X-Received: by 2002:a05:6a20:b813:b0:af:b16b:eeb5 with SMTP id fi19-20020a056a20b81300b000afb16beeb5mr6682563pzb.25.1671715136603;
        Thu, 22 Dec 2022 05:18:56 -0800 (PST)
Received: from localhost.localdomain ([117.217.177.99])
        by smtp.gmail.com with ESMTPSA id g12-20020a170902fe0c00b001896040022asm491570plj.190.2022.12.22.05.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 05:18:55 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bp@alien8.de,
        tony.luck@intel.com
Cc:     quic_saipraka@quicinc.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        linux-edac@vger.kernel.org, quic_ppareek@quicinc.com,
        luca.weiss@fairphone.com, ahalaney@redhat.com, steev@kali.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH v4 12/16] EDAC/device: Make use of poll_msec value in edac_device_ctl_info struct
Date:   Thu, 22 Dec 2022 18:46:52 +0530
Message-Id: <20221222131656.49584-13-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221222131656.49584-1-manivannan.sadhasivam@linaro.org>
References: <20221222131656.49584-1-manivannan.sadhasivam@linaro.org>
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

The EDAC drivers may optionally pass the poll_msec value. Use that value if
available, else fall back to 1000ms.

Cc: <stable@vger.kernel.org> # 4.9
Fixes: e27e3dac6517 ("drivers/edac: add edac_device class")
Reported-by: Luca Weiss <luca.weiss@fairphone.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/edac/edac_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
index 19522c568aa5..19c3ab2a434e 100644
--- a/drivers/edac/edac_device.c
+++ b/drivers/edac/edac_device.c
@@ -447,7 +447,7 @@ int edac_device_add_device(struct edac_device_ctl_info *edac_dev)
 		 * enable workq processing on this instance,
 		 * default = 1000 msec
 		 */
-		edac_device_workq_setup(edac_dev, 1000);
+		edac_device_workq_setup(edac_dev, edac_dev->poll_msec ? edac_dev->poll_msec : 1000);
 	} else {
 		edac_dev->op_state = OP_RUNNING_INTERRUPT;
 	}
-- 
2.25.1

