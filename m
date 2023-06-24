Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2802B73CAD8
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 14:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbjFXMXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 08:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233086AbjFXMXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 08:23:50 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1180483
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 05:23:49 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f8689fbf59so3327080e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 05:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687609427; x=1690201427;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yn751ywK2U9KYdduKJFhNKJFt6soywgPM5VXULQbq7M=;
        b=JZSrs/dagCsfa5IS/LI1/iUfB8UqHmAp2Wxvnhfx3ktNKfv+NaxYQC2tB6xc8lv3zA
         N7x8oVvLCQCXuNxsQ+8/jsQUN4LjebTw8OlyE3E3BcacsViRjinHu/YT5LVC9JiTWPO3
         iZjSFbG4bprV/iA8VBHEt4IEanZM4UwwBwPnrAamwwN2DJEKXciewB8/azuQaZtzr6U1
         TCF/DtP0qdeVNwEXi7D3rUOD2MiNBbOdcZ1O1VUBV68RJ76KnRF200JqXZxFbk9scucW
         KbkyB2OXAXHRfaPbVrZTh9rXv+NXAehiIfyBn4wgPm2P12D+LrrO4m9FiWNMHZjvqefR
         aL/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687609427; x=1690201427;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yn751ywK2U9KYdduKJFhNKJFt6soywgPM5VXULQbq7M=;
        b=eZVrQ4C8q01jFtj/wO4cEhSR44+Zr1CMQ2dFwClnM2kEr0L4IIU1iwRMkX+V9dha3I
         8OS+n8o/gDxqrgmBHR6iE1T+Vo6EtR7easKCfRzMbgaiUflqcyVHVyxADQafbJSsVq2W
         hkJQ+VAxvhODlPwG83MKsD9cD0OOz2rK+AGzldx2M9Q31v13t76p6fIOrbq94MaBMDF3
         zr1MrQEFXwOs/PVv1zgfTi7+VNAknkiLcn8pXHfjQVTe8HPzl1XWpeuXJNnoW4SAe0St
         1Kq2RDXyAcrsjMRNxUVqCRdieRFwVC/QbPKgOMhCGoIaa1Tr6kktxAPADH/IB/6LCCs3
         UMQQ==
X-Gm-Message-State: AC+VfDycDq0WPRRqT0gYLp1TY+Lm3IxS+uhEMdwf1Ko9/B736tMZTAnI
        CG66XMtqWxvfn8s+ozfnlJhTTA==
X-Google-Smtp-Source: ACHHUZ56n9bMAGYEoENC5quKh4ep6ICrn7pjqv6gEFabi/tcaS7XoYtm2Kf8V3/rJwhFPu4KM96d7g==
X-Received: by 2002:a05:6512:3c89:b0:4f8:78a8:bfea with SMTP id h9-20020a0565123c8900b004f878a8bfeamr5650660lfv.16.1687609427280;
        Sat, 24 Jun 2023 05:23:47 -0700 (PDT)
Received: from [192.168.1.101] (abyk197.neoplus.adsl.tpnet.pl. [83.9.30.197])
        by smtp.gmail.com with ESMTPSA id s13-20020a19ad4d000000b004f00189e1dcsm260200lfd.117.2023.06.24.05.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jun 2023 05:23:46 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v2 0/3] Drop useless compatibles from the SCM driver
Date:   Sat, 24 Jun 2023 14:23:44 +0200
Message-Id: <20230623-topic-scm_cleanup-v2-0-9db8c583138d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFDglmQC/32NWwqDMBAAryL5bkoeErRfvUeRssatLqSJbFRai
 ndv6gH6OQPDfERGJsziUn0E40aZUixgTpXwE8QRJQ2FhVHGKmesXNJMXmb/vPuAENdZ+toZVTu
 tjQNRuh4yyp4h+qmUcQ2hyJnxQa9jdOsKT5SXxO/ju+mf/bfYtFTSNlY1LQK2zXANFIHTOfEou
 n3fv6GPEEPIAAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687609426; l=981;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=NIhA09+KlsRLNsMHrsyJbVTQhfpagiO0v2mvJX00qIU=;
 b=K1KtNfO7ywsy6E0m/cdWsaf2JtdfndkxG4gbSBAVunfqDw0e81kbUC5e9qxO1mhwwBLHoXGoh
 0PJr/DsgagqDn2jNIoOOR6nqfsOdfNmWuoLf46QUq9JsN9sBRgKQiNH
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compatibles, apart from some ancient ones kept for backwards compat
due to no generic fallback, are largely useless and we can easily remove
them. This series attempts to do that with hopefully no harm.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Changes in v2:
- Fix GCC Wunused-but-set-variable in patch 1 (thanks intel robot)
- Link to v1: https://lore.kernel.org/r/20230623-topic-scm_cleanup-v1-0-383089eae98d@linaro.org

---
Konrad Dybcio (3):
      firmware: qcom_scm: Always try to consume all three clocks
      firmware: qcom_scm: Always return devm_clk_get_optional errors
      firmware: qcom_scm: Drop useless compatibles

 drivers/firmware/qcom_scm.c | 90 ++++++++-------------------------------------
 1 file changed, 16 insertions(+), 74 deletions(-)
---
base-commit: 8d2be868b42c08290509c60515865f4de24ea704
change-id: 20230623-topic-scm_cleanup-c4620461126a

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

