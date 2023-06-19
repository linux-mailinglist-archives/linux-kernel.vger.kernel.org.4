Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776CE734CDA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 09:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjFSH6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 03:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFSH6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 03:58:45 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491B0E6A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 00:58:40 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f8d1eb535eso26471535e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 00:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687161519; x=1689753519;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PsYA3SSITBWx58LY7+NPQ9n1/11quAIBEa08PSijAIM=;
        b=RrccHDVnp7/vgtvYCAnBEWdzbO7WPv7N8SP/wUiNEVT+Db/pf/LrrHdvOZ3ahfAedy
         ShGgGo+0Nk1EDHHzK6aDuEWJ0tb+mkkJQg5V9SctBqP4lXSQ5PPfalAsSU3tXQNJcba2
         Lwl2oi5iR7WeiCjNLDSeerlbctlZC0q9uk7wF+AfuFhwmOsucY3EQ33g6j2k7/hpeIee
         TERbV82Y7Ffgru4uUG5RYFyeTkarTPT/jVRNGdZxLFKgeFbywCkhGNdhDOmOqFp5Gpqt
         stx4nKbuK4mvNRPPj0S3usDqxHodFuhix4ZysSQgU9EAm1MUhImJulmyl6Nbi+iogg7n
         aEPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687161519; x=1689753519;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PsYA3SSITBWx58LY7+NPQ9n1/11quAIBEa08PSijAIM=;
        b=AT5ah6/RCCNwoYadH3/+N6cLBhMn9CC740uKTn1VLXpocA/DPY2OAMgyIUIbukxAN6
         q990hVFmXvdhfv1jPgdRfzERvSLu5ix/13wVriSjD4lWrbgYzW8oZR/ZvrlMLso2e6Ul
         OvhgqMZv9FCzr8Gpy0824yMY0wOqyNzpdReVZMdaIJ8rrIYMZiksgSjIvtRp7rd6SGh8
         b3S3eBe/5Q6Rzl6skG5nRXRhni7VYx3GVoVi9tpOLjam9Eg2qyPix+l/BVaoKzHTQ69M
         452WclBJMGNkt6g7MCFdU9NIvtnFBeNvTP9zYNCb5YECvNCjx6os1nBb/pPHhJ4W4cqD
         uOxQ==
X-Gm-Message-State: AC+VfDw6NoDY6KO0Sy7JoF8Zfy2J6BKUOuhHUbMqRjeEsqo/Criowyhk
        wyEUR+doGPT/zTwUCguOKur9kw==
X-Google-Smtp-Source: ACHHUZ7zi9iC8PeypRWhnctEmoQaLsONwz1uNgOt0xacveoss3/btLzfOQXAHkkFr7Edgg4DsJ1ePA==
X-Received: by 2002:a7b:cd97:0:b0:3f9:a6f3:f23c with SMTP id y23-20020a7bcd97000000b003f9a6f3f23cmr1606248wmj.36.1687161518699;
        Mon, 19 Jun 2023 00:58:38 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id v5-20020a05600c214500b003f7f87ba116sm7091491wml.19.2023.06.19.00.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 00:58:38 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v4 0/6] arm64: qcom: add Type-C Altmode support
Date:   Mon, 19 Jun 2023 09:58:15 +0200
Message-Id: <20230601-topic-sm8550-upstream-type-c-v4-0-eb2ae960b8dc@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJcKkGQC/5XOTQ6CMBCG4auYrh3THyrgynsYF20ZpQm2pAUiI
 dzdwZ1xo8tvFs87C8uYPGZ22i0s4eSzj4FGsd8x15pwR/ANbSa5VPzIBQyx9w7yo9Kaw9jnIaF
 5wDD3CA6w0rZo6lIUmjMirMkINpngWkLC2HV07BPe/PPdvFxptz4PMc3vFyaxXX+sTQI4NFuPo
 pU19tz5YFI8xHRnmzzJfzRJmrK2ualSl9qpL039oynSpHR1XSoupD1+aOu6vgCPP9kFegEAAA=
 =
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2503;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=MvvDoKixsVmeFBw18T0RsHuaqVNOIyDv4qINeyouRXg=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkkAqqFSzbJ7CkMcpOUSgeay8rxg+YQXtIv1rEUjuI
 3sqXdF6JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZJAKqgAKCRB33NvayMhJ0dJED/
 4rOBjqIHXjrBLrOA7YtF/kWdk05DzpJXorVxKke1we0ccjz8duMuCn8486nUgaRAnP2yZ+WvRVOBUU
 XSIvLUL6fhn/qgA+w8nv0iSOalkWudr6k7Emjy3G5HiRrKIk3h2BVDU2OpvRGZGeFrkzXozzlGoHYm
 aydHbsjlTbMuGnJ4JyWclftCxMc8ijB3zlEPJcb4X1vGZyvNL37qWdtEyzclA/XqxJ6IXZ05T5JciM
 5EExq6rDcDxlo97BFcxxX3C0HD+S+w8nQkIrVD4Sdigv/+EIJHtukFw8mxq3GcATymYYFkYNgkg7YK
 iReQRcDIlA3zPHNQn6d3G+hJFvlXbJVqMlcp05OnATGlr9MFR+Vev4HFysFXCoAZmU8liVZACkOzb9
 X385nZOxW/gQleOfm22EmAUihJr4pMI2Y4IxsoVJHvGcOEBeTYnJieY1TERAj07UH6PhekisvOomBM
 6Cpr0sZAjIwRbBUu3H/x+SyeyCPxrR2/vuDAeVvHP6MKXW73idFORFHN9GkMFFgXikgrivmfyRscUr
 D5fV6HCXHZ3TXroVbx7RfMB2LmRLQaI+4RM5UAByphARD4/4vv5yFkysmJnh3kS/wRxu1gFx8pDfGt
 vVuhv/ZYYUTq9wXrRklGjb1skMIKtRobM7PuUBLW5oFGcK88g3cbrZrwvtfA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the missing bits to support the USB-C Altmode
support on SM8550.

These are the following changes since the previous SM8450 SoC:
- No more GLINK altmode events for USB only changes, only DP
- Type-C orientation is available on a PMIC signal connected
  to a GPIO line
- When altmode is disconnected, an 0xff mode event is sent.

The 0xff altmode is translated as a SAFE type-c mux mode.

The fact No more GLINK altmode events for USB needs to be resolved
in a separate patchset.

Redriver driver & bindings dependency at [1].

[1] https://lore.kernel.org/all/20230601-topic-sm8x50-upstream-redriver-v2-0-dda89b22b1c0@linaro.org/

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v4:
- Drop the orientation gpio handling code and bindings until the situatin is resolved
- Link to v3: https://lore.kernel.org/r/20230601-topic-sm8550-upstream-type-c-v3-0-22c9973012b6@linaro.org

Changes in v3:
- Fix fsa node names in both QRD amd MTP nodes
- Add missing orientation-gpios in MTP dt
- Remove invalid svid property
- Link to v2: https://lore.kernel.org/r/20230601-topic-sm8550-upstream-type-c-v2-0-3bbdf37575c3@linaro.org

Changes in v2:
- Updated redriver node to use retimer-switch on QRD
- Fixed redriver data-lane according to v2 bindings
- Added review/ack tags
- Added new change to handle retimer-switch in pmic-glink altmode driver
- Link to v1: https://lore.kernel.org/r/20230601-topic-sm8550-upstream-type-c-v1-0-d4d97b4d8bab@linaro.org

---
Neil Armstrong (6):
      soc: qcom: pmic_glink_altmode: handle safe mode when disconnect
      qcom: pmic_glink_altmode: add retimer-switch support
      qcom: pmic_glink: enable altmode for SM8550
      arm64: dts: qcom: sm8550: add ports subnodes in usb/dp qmpphy node
      arm64: dts: qcom: sm8550-mtp: add pmic glink port/endpoints
      arm64: dts: qcom: sm8550-qrd: add pmic glink port/endpoints

 arch/arm64/boot/dts/qcom/sm8550-mtp.dts | 66 +++++++++++++++++++++-
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts | 98 ++++++++++++++++++++++++++++++++-
 arch/arm64/boot/dts/qcom/sm8550.dtsi    | 26 +++++++++
 drivers/soc/qcom/pmic_glink.c           |  6 +-
 drivers/soc/qcom/pmic_glink_altmode.c   | 61 +++++++++++++++++++-
 5 files changed, 247 insertions(+), 10 deletions(-)
---
base-commit: e602e10c923db4435573997d383a145ee38ae333
change-id: 20230601-topic-sm8550-upstream-type-c-e85b4d971450

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

