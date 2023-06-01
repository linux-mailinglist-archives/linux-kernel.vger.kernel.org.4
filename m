Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE31B719F1F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233781AbjFAOH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232873AbjFAOHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:07:21 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C499D19A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 07:07:08 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-30af0aa4812so925653f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 07:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685628427; x=1688220427;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ty9X1/lZ4kxiMPfO6SIBOmi6pFSnYht8KTXY1jDqhMk=;
        b=IbNZ/h4TiuSpaJndwjHm+qNz1wA3az6rVJttp6dEU8IO0aQLMDFSmP2dN+eFBQ1HDx
         fg8PWloJbb4r6byJRuANvyrhQubW/pLkfkOkCHgVmH3FOfwoCeQvZTRUZ4tlUzqnjJ3r
         I0AE5kjMz+BJza9C/PrlYKrII6tjp6UaL4wee+dLKk6lVsHOWMCf2RHqOSTNjFH8ucQw
         tDMpPAE+jCm5zOLHcd0CxyC+LqwMOGMppFkvfTn+zxO03Ibn0du/IFShugVW6IWq+T0d
         f95EXlwQ3BXEC6Hc+zxMEsPXu63bbB1+bZa9jevQinZL9Mcc7zJnqu0I2AiaZjOECp2a
         rOHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685628427; x=1688220427;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ty9X1/lZ4kxiMPfO6SIBOmi6pFSnYht8KTXY1jDqhMk=;
        b=GIXQuFqzwT0NVPtMhIkQPJKLeyhzkOPpqDRQAg6bFSGmedVoMhwLpUj3D8xJkUhir4
         sj3Z2DnUg2dj+IzuXOr341rhaRg+2LUwF8WziOEFBjSaQ8UtDUjkmahTZfPW1ek2sd2E
         60tpTYDIuMxL2jhpzvtpr5bOx3lZPe5dSesjk1fBmOIS0a/BnbtIUYnQpecyVFzpkqD/
         OJNSPECEO49XtcijpQKWbFjX905ZdGshiKjqvH9N5uDVS+y1AUzMKKUNiFgG3QGjkGPq
         eOukNMk0C7+nKhiWz/uJ+RMtO2tsB76YnWylaYmd2/1+LJkZvUuU1w4IIsK81Lyqmf1L
         Lp0g==
X-Gm-Message-State: AC+VfDx2oxXUYvOdHT3nhXevlSh5PsFijnlTtoJelUZ33ibZLp5XCFyo
        2RJULZWQPHCuVzC58qrgLWgPfA==
X-Google-Smtp-Source: ACHHUZ4b47dm+Xm9jwckIXF0KkauMPIOnltIj9V54u33oWFbZgBNyMbisrPoI/BqdP8HsjWMXIyqlQ==
X-Received: by 2002:adf:f307:0:b0:30a:f606:2459 with SMTP id i7-20020adff307000000b0030af6062459mr2025299wro.25.1685628427113;
        Thu, 01 Jun 2023 07:07:07 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id k11-20020adfe3cb000000b003078a3f3a24sm10504166wrm.114.2023.06.01.07.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 07:07:06 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH RFC 0/7] arm64: qcom: add Type-C Altmode support
Date:   Thu, 01 Jun 2023 16:07:00 +0200
Message-Id: <20230601-topic-sm8550-upstream-type-c-v1-0-d4d97b4d8bab@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAASmeGQC/x2NQQ6CMBAAv0L27CYtUkWvJj7AK/HQllU2gdJ0C
 9EQ/m7jceYws4FQYhK4VhskWll4DgX0oQI/2PAm5L4w1Ko+qpPSmOfIHmVqjVG4RMmJ7IT5Gwk
 9Umtc01/OujEKSsJZIXTJBj+USFjGsciY6MWf/7ODx/0Gz33/AZZ6Ex6IAAAA
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
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1978;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=pWKd11RIdBHbnx87p7fyQJTNZj+yiLAVlSvzPs6zzkc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkeKYGc/gegYT+2ro5I97D4w0ztrwLZSHJjqxi0rlv
 37qRo3yJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZHimBgAKCRB33NvayMhJ0TJnD/
 9qkKwIXFLTkm0pNFWnXYmzKRsVqM5YaC3GmSaZPYZ4VGOcM6zN8YF/2BpMVElgf2lO4uiGstOrxH6i
 c+66+MonE+Sd7IWBzYbaaX3354h33i4EAAZrydr5ewDcwwB9PymInhyn4SbHpRWUR5jiy77lWtXMG6
 AOj+l+wHeBNTNhoJ003676YRhmQCYrngDBTVWK0GanTitz85TyVGRTL3lSvCtytZacQiJpvnNKlpUN
 EnguSmODmXNcAU2SOMwuMlJGIRiEJqJOLBgI/qQxfd2JOaalkyUdsZSXOvDfMKYe2NLazgl7jLsBOg
 z9rBGG0GZqjsjR+G5ALOVNw6ioD3l/B7r8J2skGX7PZjMN2BS9D0iuCV7ojgTG34xtxaPzvjg500XL
 s5NBqBkH5QzXcHZNcNN/djhcYG+5iH0czlXrottXBV1ppTHMkCuCWxxxmHNWgRxcWbAiNZSkhwHW69
 OsO6Bi4Us4jW7Bj2ktBNgO10mp/B7PnYVPdxpFFdpmcTs1UYI628AYLSajxOeHXy5le0dazI+SkXk4
 R8i58VIdbilTMhLhLnik2Q7Ua96CuSta92AbuMw2CRqcT4eaWBxLE2bZoKxg1vkIakrRCvJZNvz8Gt
 LnXPbPMR8DM9E08FjoKdBoOEhkBp9JW2t7x3urh7DLIVP8mjfDhhwBeOCsNQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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

In order to handle those changes, a new orientation-gpios property
is added to the usb-c connector bindings.
The 0xff altomode is translated as a SAFE type-c mux mode.

And in order to handle such info, we tie this to the UCSI connector
events to propagate the orientation to Type-C switches.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (7):
      dt-bindings: connector: usb-connector: add a gpio used to determine the Type-C port plug orientation
      soc: qcom: pmic_glink_altmode: handle safe mode when disconnect
      usb: ucsi: glink: use the connector orientation GPIO to provide switch events
      qcom: pmic_glink: enable altmode for SM8550
      arm64: dts: qcom: sm8550: add ports subnodes in usb/dp qmpphy node
      arm64: dts: qcom: sm8550-mtp: add pmic glink port/endpoints
      arm64: dts: qcom: sm8550-qrd: add pmic glink port/endpoints

 .../bindings/connector/usb-connector.yaml          |  5 ++
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts            | 67 ++++++++++++++-
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts            | 99 +++++++++++++++++++++-
 arch/arm64/boot/dts/qcom/sm8550.dtsi               | 26 ++++++
 drivers/soc/qcom/pmic_glink.c                      |  6 +-
 drivers/soc/qcom/pmic_glink_altmode.c              | 18 +++-
 drivers/usb/typec/ucsi/ucsi_glink.c                | 52 +++++++++++-
 7 files changed, 262 insertions(+), 11 deletions(-)
---
base-commit: f339b18115200db76b42475e44e3bc926e3ecab0
change-id: 20230601-topic-sm8550-upstream-type-c-e85b4d971450

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

