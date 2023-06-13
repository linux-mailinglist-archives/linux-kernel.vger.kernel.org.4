Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3680B72DBB8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 09:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239103AbjFMH4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 03:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239031AbjFMH4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 03:56:10 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F12E7D
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 00:56:08 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f629ccb8ebso6274044e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 00:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686642966; x=1689234966;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qt6DO4eTqgm1PKgstjuXoKWvYLzLs/3RIwW59uXSJfE=;
        b=XAAAvbiX1KmTs/nZ4eapF5OhkbIGZBHGMn4WJpPangVsSU+eXKkd+sfCNhXXAgCJec
         WAeFmGIDntrCMQry2+idiO2BkwKFIdW4x8AEO0ewV/aIqlEnVBbtggSMtR1sLK5DiU1n
         0nCGtOu9f3/+Nh42TTsrantfCKyeQ9cgmUuMFWf9llvkTGk/2AD8YysiAXuUEfYsJKSV
         /uxjWkVg4tCJVShhf/8lMCEcwLaDTdnbktkwHyCkQjwdPSfckW4+VIgIQKiTgB3dVV5C
         S0PPA3T/IK8Qf6rT90HQpfgVwxBhwqaqmGrJ46dGUoSB12xjD+kH3G8Al/vbu7nQudNy
         8Sog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686642966; x=1689234966;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qt6DO4eTqgm1PKgstjuXoKWvYLzLs/3RIwW59uXSJfE=;
        b=apXBnRR8+ATA9qevMHu5lKditIfBYxA07DkIoKpy8+VQbu9X2yVW61czqW6guyX8/a
         1TVvTTTZdSejBR9mVcMHlysjRVDtAJBirOLGLl/EUusTQrrZFG2lDLnjAGXL2B6xFUHC
         qFNIkzg0zsqOkIgL05elEB57wJ0joQ3+XBBzJ+axptqYGmvwvKI5XGboc9Qhj3re35Kq
         t41Lktj7sEHKpXc8EUZzjp6loyVfnIDLQdFVXhB7i7ltDhlBj8Jzxvk62ib4bN4bVZpb
         VRzbyg8Qy2WdBJUk+1lDl6XM+CsDb0rHZgTMXm0oKV9e2kyYvZjDBtqHg8uXPr/osOpj
         IgWQ==
X-Gm-Message-State: AC+VfDw9kTUSU+tpXGpvi50HglI7jZNlG1v/Uctlgxyb3j6Q9G7NH2uG
        W4idKCQar0NJ9BDS+CR/xjunfA==
X-Google-Smtp-Source: ACHHUZ5fW3ryKdvd83gwTbTkCIF0OxVrYv/7x/9Sz1zAv0fCZAcv6Fkgq85atuOhvfwTZUaZLcdY8g==
X-Received: by 2002:a19:5e58:0:b0:4f4:d324:8b14 with SMTP id z24-20020a195e58000000b004f4d3248b14mr5035114lfi.14.1686642966390;
        Tue, 13 Jun 2023 00:56:06 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id k20-20020a05600c0b5400b003f4266965fbsm13662316wmr.5.2023.06.13.00.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 00:56:05 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v3 0/8] arm64: qcom: add Type-C Altmode support
Date:   Tue, 13 Jun 2023 09:55:53 +0200
Message-Id: <20230601-topic-sm8550-upstream-type-c-v3-0-22c9973012b6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAkhiGQC/5WOvQ6CMBRGX8V09ppCqaCT72Ec+nOBJtA2LTQSw
 rtb2Nx0PN9wzreSiMFgJPfTSgImE42zGdj5RFQvbIdgdGZS0pLRKy1gct4oiGPDOYXZxymgGGF
 aPIICbLis9K0uKk5JVkgREWQQVvVZYudhyKMP2Jr30Xy+MvcmTi4sx4VU7OuPtVQABb33crSRQ
 j4GY0VwFxc6sptT+Y+tzDYmpW5ZzWuu2Jdt27YPAPDoxywBAAA=
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2787;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=BHAgQ+UG5MLHVgrLY9X0OW+HponTfcnibfbTbfKXYaA=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkiCEQVetVQxGQVm3pW63K5GgAgaxaLOJ7YEzbEf5B
 N3P1GEmJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZIghEAAKCRB33NvayMhJ0cpIEA
 CnECPB9irgAv5XQjvhHw9vJwqUoXarSQrXfjhw5aFN6kz8JINuGWFRzeU6XPoWh/QEZfEcnWiC9KPX
 zDtZ1gdeLQFiK5vgBMVlTVDJ+9QvCPmRxs5lYa8Qrud6f9G+ggV8GfDHJT8oGO5HEWG194gyLlpl2C
 GQnk3WiWkaGIY69Buxer6uW7Y82u4nJSqzoRaFSg4KWEnqvoud5o7rbJ04jWdhcnhi6LxINgEFgmwj
 OG2yxBDpwYwjODnVf3HWI4O6IRggNIuUGyCCwzLEK0oL1273DiveTp+SH3qqJl18uChHCcVug6FkUX
 8uz81i2Rys/tRFGlKB9XBXiCfkRmaRiqJq07S2uQklV+seYdKQG5AkQHIsTU94gTJiAOMDYZ1wznem
 GJ+PA65DvsqodMpNU0kWQ8x5JzVmAOJRGruR7mkvPL757qm/BWO74lQ6CVIj9yV73A/VYvjIKvDlQo
 DXZGHwg+Q0kecXzu/uW8TmFsDCouIVkkhJo62bjyoCD+6XekjHdbAZbS3BMVWSduhh1WIkPlaYtxNl
 tnXUppyM0oQBj0zh+NLZMwRjYWX+VD2Ig/R5cu+z8+R03pNncBu58mAtSupSPcniiE7H+55Bn0wm8Z
 y+gZp+yo6xaGBgqlCrsJ8jTILvksYJmg/f/vwCs6xtEd0KQnxtV1FReW+mRQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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

In order to handle those changes, a new orientation-gpios property
is added to the usb-c connector bindings.
The 0xff altomode is translated as a SAFE type-c mux mode.

And in order to handle such info, we tie this to the UCSI connector
events to propagate the orientation to Type-C switches.

Redriver driver & bindings dependency at [1].

[1] https://lore.kernel.org/all/20230601-topic-sm8x50-upstream-redriver-v2-0-dda89b22b1c0@linaro.org/

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
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
Neil Armstrong (8):
      dt-bindings: connector: usb-connector: add a gpio used to determine the Type-C port plug orientation
      soc: qcom: pmic_glink_altmode: handle safe mode when disconnect
      usb: ucsi: glink: use the connector orientation GPIO to provide switch events
      qcom: pmic_glink_altmode: add retimer-switch support
      qcom: pmic_glink: enable altmode for SM8550
      arm64: dts: qcom: sm8550: add ports subnodes in usb/dp qmpphy node
      arm64: dts: qcom: sm8550-mtp: add pmic glink port/endpoints
      arm64: dts: qcom: sm8550-qrd: add pmic glink port/endpoints

 .../bindings/connector/usb-connector.yaml          |  5 ++
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts            | 67 ++++++++++++++-
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts            | 99 +++++++++++++++++++++-
 arch/arm64/boot/dts/qcom/sm8550.dtsi               | 26 ++++++
 drivers/soc/qcom/pmic_glink.c                      |  6 +-
 drivers/soc/qcom/pmic_glink_altmode.c              | 61 ++++++++++++-
 drivers/usb/typec/ucsi/ucsi_glink.c                | 52 +++++++++++-
 7 files changed, 305 insertions(+), 11 deletions(-)
---
base-commit: e8bab25f2afdf2f74359f6c743b21fafc9cdb03e
change-id: 20230601-topic-sm8550-upstream-type-c-e85b4d971450

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

