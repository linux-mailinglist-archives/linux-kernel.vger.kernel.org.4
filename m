Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E42C734D1F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 10:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjFSIHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 04:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjFSIH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 04:07:29 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6895D10EF
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 01:07:19 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f8f3786f1dso34558215e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 01:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687162038; x=1689754038;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pTktOFCzIOUVsb4Cs7NmYKNNeR+Ti0ZcbefkrZoWwOc=;
        b=yr+ZZu6LTyGEP+JhjT5lYV5irhRVwTYeepYL1AVvUCwE2+mL38T/TpSpAWazLBhSXv
         qT3HF/JDbVqiZHhfhpg1JzBj+TxPvz5bXvRbDQhnA/1s2sHqklpUsCqYw4xzAdu/JExP
         R4PvnYOzMrgOCZgEglsEd9/WS7h2fju/zrHmtaXD9FwH4hoYGz8B/3pzRLDYuesPj1XM
         uKtNKy5/P7c2hoQEP2xMy5d1wIoPxlVPS6uMh3g8oF9EqOkSiL9YrO2rrMeGIT70RwY3
         +ygNE6RXXf35ITGr1D9iC+eVNj7oBOheP3B38iGa+s5bhW6ZirogxsO+xvw0dI6gmiAx
         iw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687162038; x=1689754038;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pTktOFCzIOUVsb4Cs7NmYKNNeR+Ti0ZcbefkrZoWwOc=;
        b=dO0BV7sNXy6hJcxd6azitEL1kjFtzDJPRSpeWsmY/2QMx/F+BKHNVDZ/bXBJpQ8gQ0
         uoudNlARQxCVOEikdgb6XImLe6uV7DoBQ/i3lEdR1+g/9BRqFWMDcnmOeC0cNW57v9Iw
         vp+uivfxjOzT1gcH3F7dfGEiboRedVPXgI927pgBjY5x0dKsEIpDz3UKrQ67ZpNkj4ed
         5rIG8fAsesM3MLdwATsH16GFL9OftrAWEPDP53WibDt1TkYYDSUuXHr3+UkCnedbLTvz
         7qhDJhzzEm4Wj4z5Xd7wPOhCCVumcwQ0ljs9u26CJkkFcT/clKwS0qswCzSnOMVlINKs
         vfoQ==
X-Gm-Message-State: AC+VfDxJ6OJ39KdcMckrAUSs7FXCwEcSaudaAxFdkzKVbwwltUqacfo5
        KO1uGXMLdsTFL29Ad3QLZ2MX0A==
X-Google-Smtp-Source: ACHHUZ77TNh5D8J4mDr322CqsTHT4po0xBQC1gsWeZYyWxcCmPk/NBoMq7OqvL7CjrOLjLMl0GHVfg==
X-Received: by 2002:a05:600c:378b:b0:3f8:d0e7:daed with SMTP id o11-20020a05600c378b00b003f8d0e7daedmr9932881wmr.19.1687162037871;
        Mon, 19 Jun 2023 01:07:17 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id m19-20020a7bca53000000b003f801c12c58sm9791158wml.43.2023.06.19.01.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 01:07:17 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v5 0/6] arm64: qcom: add Type-C Altmode support
Date:   Mon, 19 Jun 2023 10:07:12 +0200
Message-Id: <20230601-topic-sm8550-upstream-type-c-v5-0-9221cd300903@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALAMkGQC/5XOu27DMAyF4VcJNJeFLpYvnfoeRQdRYmIBjmRIj
 tEg8LuXzlZkqcfD4fv5EJVKpCo+Tg9RaI015sTDvp2EH126EMTAW2ipjWylgiXP0UO99tZKuM1
 1KeSusNxnAg/UW2zC0KnGSsEEukqAxSU/MpJu08THudA5/jybX9+8x1iXXO7PF1a1X/9ZWxVIC
 HuPoz06/JxiciW/53IRu7zqI5pmzSCGs+lsZ7150cwRzbCmtR+GzkilsX3RmiNawxqhdjS0Evv
 g/2jbtv0CArgwoMgBAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2700;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=oCR2uCoQBZX86xUFDsgYWVQBRFojWAJtNPwqN1fU26o=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkkAyyFbxZQdMjWygurr3LlRYQWgEu1TMsnReimcq7
 6iZWt5eJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZJAMsgAKCRB33NvayMhJ0Zw8EA
 CtaZ67bKtJZ212TI8gp/oKzacR3/iSziGmLSsy87lJcmcUSTI3GygSqaO1iprtRl1bqXhPtRdZ11AG
 ZCP3zX57XxUV5Ps7E4Ct/tRMnbyUxXhprtDPAQt9RqebTBmPgQISr9vJdqIvITA25kexF62WOyJMJs
 wDFC58GL6/dktPeCrijXe+CCo0fWlplH7nlle9AUds9K5BwVCfV9dvncH9MjsDB8VnnfnXNFzGB1DD
 mjVKtc31Klmjnwbo+7pMhiUFUa2LGxABEN5XCBg1VgbbW8nxllM0wrQtFnNu79JBT1VmLTlKzbt0X/
 70LFi5MdG2Cbf1GhRxrzsCya3SWG84KWMgO08/qFtEACbMCFIBnmhxQQp12YZoF5Pk8kMVP5estUcz
 /wqE0I5dzZk+SQp1q0eynm8qOvnVgLTtipwplGqbTBsXrowlQAPrmS5UkfB977ipL0jl9HMI/k0ZO3
 HJiGSjRBvIcFKcirWvoYU5ezUUTVn8S9kB0VaGrz4wi24R9DopCoqwm/FhuFepF1V/C56+WodhoZyy
 PJsZfK3gf8jhMTTtXlvjxjRexfc/ijvDyd72asiHYMDE9Gvs4Wr7LqKmZNl9Gbx8xR1S8iYKkbONvC
 iajBTpuTbK/ou9f0iHUWgZ/0qVl3JTKB353aDoKMjtO4RUeW2gj6QYiuWaqA==
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
Changes in v5:
- switch to single port instead of ports for fsa node in MTP & QRD
- Link to v4: https://lore.kernel.org/r/20230601-topic-sm8550-upstream-type-c-v4-0-eb2ae960b8dc@linaro.org

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

 arch/arm64/boot/dts/qcom/sm8550-mtp.dts | 59 ++++++++++++++++++++-
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts | 91 ++++++++++++++++++++++++++++++++-
 arch/arm64/boot/dts/qcom/sm8550.dtsi    | 26 ++++++++++
 drivers/soc/qcom/pmic_glink.c           |  6 +--
 drivers/soc/qcom/pmic_glink_altmode.c   | 61 +++++++++++++++++++++-
 5 files changed, 233 insertions(+), 10 deletions(-)
---
base-commit: e602e10c923db4435573997d383a145ee38ae333
change-id: 20230601-topic-sm8550-upstream-type-c-e85b4d971450

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

