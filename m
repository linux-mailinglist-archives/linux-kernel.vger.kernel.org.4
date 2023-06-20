Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6726737042
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 17:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbjFTPTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 11:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbjFTPTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 11:19:43 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD2F198
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 08:19:41 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f90b8acefeso28657395e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 08:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687274380; x=1689866380;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7D3/27sIAlZ3B7J/QryMAK6yu8lmX5V348NUxdNvxQQ=;
        b=T3JN4eITlACkWl8gXWGi47T/9zkxomuMTzVr8hsCUJSp0mg47P1wmb6xdEJOukJ1j9
         YYitI/FH95lauoEgU6VuAoj7EO7/MBOKHXbGXrXEKccBBHWraAK6gN3i/lwagjAfKAXo
         qP7Th0tc10vrPT+dWXBYJYgFlw+8haaEVNJhQsIKH9P+5mnLsUtBwT4qL0IYcpQ52ocv
         eUkWc6XBFLvuBi+LQWVZmbf7DXq/n1J9kCvfKQYVPxZGDwO9LBsp3ur3y85qvBwpLgld
         rrEjAGiLk8ew/bkBmLoj9b5EoNZzwUzMaXfNesX+Ehlv4+obv81tg3fmshED56aww2b1
         fCMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687274380; x=1689866380;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7D3/27sIAlZ3B7J/QryMAK6yu8lmX5V348NUxdNvxQQ=;
        b=dbQLa83ogOmLVaMNyi0YPcydzyjhfIRvkMV3z+rxjvon6VJYDrl6MbFRrCve9Nqg7V
         la68JosJVT8E+iGbsPs3lahVWQ6VFWl4gEYEQWl1aKYXwhjvdeCgv19E6iZOAPMAGXcb
         XPeeGj5zof+5wmAU2o5Lb919Naxve9GiZ9yqLkpFF94/8H3AkinyeBEi0aohuYHOEr8F
         J4EtdyvfAl1D6+ZvkAw887KakRQkMOHFRrUU0j0/nfWjSgCdkturMq1zLXap+In+gEHY
         aiRDTH45KPrYQD1HkE30QWtXyagCRHqUUP/4kjlXtqBDqAJuluqxfeX6Nvk00m5ge561
         srkg==
X-Gm-Message-State: AC+VfDwzlgb7b6sKQlYFuWoIt+3PhdBjVLXIy4T/JuemkLL2ichQyQHM
        PhFbw6cPBpVuQ768jrH/ye45ZQ==
X-Google-Smtp-Source: ACHHUZ7rzVXxsoPtiHUXBoCKkJ5rFe7DnWgsi2AceVr5PgOyDIOHpGfiwUasyknfuzjExhUA60aP6g==
X-Received: by 2002:a05:600c:2650:b0:3f8:1f52:f3a9 with SMTP id 16-20020a05600c265000b003f81f52f3a9mr9007202wmy.23.1687274380277;
        Tue, 20 Jun 2023 08:19:40 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id x23-20020a05600c21d700b003f427687ba7sm2518659wmj.41.2023.06.20.08.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 08:19:39 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/4] bluetooth: qca: enable WCN7850 support
Date:   Tue, 20 Jun 2023 17:19:35 +0200
Message-Id: <20230620-topic-sm8550-upstream-bt-v1-0-4728564f8872@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIfDkWQC/x2NQQqDMBBFryKz7kCMprS9SukiiZM6oDHMxFIQ7
 97Q5fvw/jtASZgUHt0BQh9W3nKD/tJBnH1+E/LUGKyxg7lag3UrHFHXm3MG96JVyK8YKk4pjoN
 x6R77EZoevBIG8TnO7SDvy9LGIpT4++89X+f5A2FYjpR/AAAA
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Rocky Liao <rjliao@codeaurora.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1135;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=dAwRJxxbreKqEKaekZVrwh5wN7D21C7UA5pt8IQY/gQ=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkkcOJY+FgDQyIt7WU5ufoqKJkGhZXSpCTNxc6fDaK
 ieUBekmJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZJHDiQAKCRB33NvayMhJ0c6ND/
 91iUCwBa+20G/uH51adrYkI1+xCCln5H4zhRoVgupJmgZfD57fmhPQtRKbmZs1yF8gmUmvUFmobGWF
 7UaqZFfqsD02h/fo0/nUkDh9co+0LzUMJGNk8DZ2OzutTZYftxiT54Mb3BllHgMBmzzq2XbClC2EeC
 bWZD3Ig1MEU8p2B+v3AHNQzm0nzaMI/fEOAn1o4DmehAraInI5hRh1UJXc2+Zv/2LbruJwiC9xxdVa
 Cj93P54ixPC4839DkRXFe1l9U6S+jivbWvMxGdcYFMo9eu2L5vlYYZwGLd5d5/BYZPyng0NhMSVyA6
 rktiBYZen9p7lJA1gIgZi06dVZUK8DTdSSyPDzNvcLxrWxL718JgmEsLEKh/MByQGjZy67t3tOwZNN
 Gwlanl2O9fvKys9FsdO0qGy9sL5aPMqq+D6bpWYlx+sOTwncta3zVccsY8v9AnU/LKM/6auDxTiNou
 kI+iP2AK/mjnqX3sI3U1iwy/wVCUxEn/25a5TbUVpgC2vVa7pRzZHh0YKZXnYwHNliJgTv9R28SX5O
 7HkZeAVoNAcbXFkQsmdNLO5gWqai5oPg/r+oLradIoJUnhxi9Wx0JuwmMNJ/yIafw+mipHTLt3v6JF
 o2MUNX/dAxv9aUGnG3hUO+5Gy8fi++pT42CUTNPi6bydEQNBmX1a9o0ZnJOg==
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

This serie enables WCN7850 on the Qualcomm SM8550 QRD
reference platform.

The WCN7850 is close to the WCN6855 but uses different
firmware names.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (4):
      dt-bindings: net: bluetooth: qualcomm: document WCN7850 chipset
      bluetooth: qca: add support for WCN7850
      arm64: dts: qcom: sm8550: add UART14 nodes
      arm64: dts: qcom: sm8550-qrd: add bluetooth support

 .../bindings/net/bluetooth/qualcomm-bluetooth.yaml | 23 +++++++++++
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts            | 43 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8550.dtsi               | 30 ++++++++++++++
 drivers/bluetooth/btqca.c                          |  7 ++++
 drivers/bluetooth/btqca.h                          | 10 +++++
 drivers/bluetooth/hci_qca.c                        | 48 +++++++++++++++++-----
 6 files changed, 150 insertions(+), 11 deletions(-)
---
base-commit: 9dbf40840551df336c95ce2a3adbdd25ed53c0ef
change-id: 20230620-topic-sm8550-upstream-bt-dfc4305f9c14

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

